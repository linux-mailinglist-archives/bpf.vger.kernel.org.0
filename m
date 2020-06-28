Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1816320CB1C
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 01:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgF1Xni (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Jun 2020 19:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgF1Xni (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Jun 2020 19:43:38 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09CE220768;
        Sun, 28 Jun 2020 23:43:35 +0000 (UTC)
Date:   Sun, 28 Jun 2020 19:43:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Will Deacon <will@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, bpf@vger.kernel.org
Subject: Re: [PATCH] kernel/trace: Add TRACING_ALLOW_PRINTK config option
Message-ID: <20200628194334.6238b933@oasis.local.home>
In-Reply-To: <20200628182842.2abb0de2@oasis.local.home>
References: <20200624084524.259560-1-drinkcat@chromium.org>
        <20200624120408.12c8fa0d@oasis.local.home>
        <CAADnVQKDJb5EXZtEONaXx4XHtMMgEezPOuRUvEo18Rc7K+2_Pw@mail.gmail.com>
        <CANMq1KCAUfxy-njMJj0=+02Jew_1rJGwxLzp6BRTE=9CL2DZNA@mail.gmail.com>
        <20200625035913.z4setdowrgt4sqpd@ast-mbp.dhcp.thefacebook.com>
        <20200626181455.155912d9@oasis.local.home>
        <20200628172700.5ea422tmw77otadn@ast-mbp.dhcp.thefacebook.com>
        <20200628144616.52f09152@oasis.local.home>
        <20200628192107.sa3ppfmxtgxh7sfs@ast-mbp.dhcp.thefacebook.com>
        <20200628154331.2c69d43e@oasis.local.home>
        <20200628220209.3oztcjnzsotlfria@ast-mbp.dhcp.thefacebook.com>
        <20200628182842.2abb0de2@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 28 Jun 2020 18:28:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> You create a bpf event just like you create any other event. When a bpf
> program that uses a bpf_trace_printk() is loaded, you can enable that
> event from within the kernel. Yes, there's internal interfaces to
> enabled and disable events just like echoing 1 into
> tracefs/events/system/event/enable. See trace_set_clr_event().

I just started playing with what the code would look like and have
this. It can be optimized with per-cpu sets of buffers to remove the
spin lock. I also didn't put in the enabling of the event, but I'm sure
you can figure that out.

Warning, not even compiled tested.

-- Steve

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 6575bb0a0434..aeba5ee7325a 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -31,6 +31,8 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
 GCOV_PROFILE := y
 endif
 
+CFLAGS_bpf_trace.o := -I$(src)
+
 CFLAGS_trace_benchmark.o := -I$(src)
 CFLAGS_trace_events_filter.o := -I$(src)
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index dc05626979b8..01bedf335b2e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -19,6 +19,9 @@
 #include "trace_probe.h"
 #include "trace.h"
 
+#define CREATE_TRACE_EVENTS
+#include "bpf_trace.h"
+
 #define bpf_event_rcu_dereference(p)					\
 	rcu_dereference_protected(p, lockdep_is_held(&bpf_event_mutex))
 
@@ -473,13 +476,29 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 		fmt_cnt++;
 	}
 
+static DEFINE_SPINLOCK(trace_printk_lock);
+#define BPF_TRACE_PRINTK_SIZE	1024
+
+static inline void do_trace_printk(const char *fmt, ...)
+{
+	static char buf[BPF_TRACE_PRINT_SIZE];
+	unsigned long flags;
+
+	spin_lock_irqsave(&trace_printk_lock, flags);
+	va_start(ap, fmt);
+	vsnprintf(buf, BPF_TRACE_PRINT_SIZE, fmt, ap);
+	va_end(ap);
+
+	trace_bpf_trace_printk(buf);
+	spin_unlock_irqrestore(&trace_printk_lock, flags);
+}
+
 /* Horrid workaround for getting va_list handling working with different
  * argument type combinations generically for 32 and 64 bit archs.
  */
 #define __BPF_TP_EMIT()	__BPF_ARG3_TP()
 #define __BPF_TP(...)							\
-	__trace_printk(0 /* Fake ip */,					\
-		       fmt, ##__VA_ARGS__)
+	do_trace_printk(fmt, ##__VA_ARGS__)
 
 #define __BPF_ARG1_TP(...)						\
 	((mod[0] == 2 || (mod[0] == 1 && __BITS_PER_LONG == 64))	\
diff --git a/kernel/trace/bpf_trace.h b/kernel/trace/bpf_trace.h
new file mode 100644
index 000000000000..09088bb92fe1
--- /dev/null
+++ b/kernel/trace/bpf_trace.h
@@ -0,0 +1,27 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM bpf_trace
+
+#if !defined(_TRACE_BPF_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_BPF_TRACE_H
+
+TRACE_EVENT(bpf_trace_printk,
+
+	TP_PROTO(bpf_string),
+
+	TP_ARGS(secs, err),
+
+	TP_STRUCT__entry(
+		__string(bpf_string, bpf_string)
+	),
+
+	TP_fast_assign(
+		__assign_string(bpf_string, bpf_string);
+	),
+
+	TP_printk("%s", __get_str(bpf_string))
+);
+
+#endif /* _TRACE_BPF_TRACE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
