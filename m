Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EE1306BF6
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 05:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhA1EKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 23:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhA1EKL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 23:10:11 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26AC061786;
        Wed, 27 Jan 2021 19:38:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id p15so3064465pjv.3;
        Wed, 27 Jan 2021 19:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIUaDsS3TlIZbhKyHx6NwpLW6Nt70ekQtolYf9/XSE4=;
        b=BfZUONoI/oMuQVqqie1EtCfkpQpGaMMSZeoARnty8VDv46F/l3NNuBkkIqVky+WJYZ
         K4SO5o8OYNGU4j++oWSeJD26zlvv+X9BS82wXhJJQjP/XGqbqI2U6iyoGSvXs4Uy6+wU
         BpaLVeKaFoOAdZGIwxL+vCzXAVI6JXKGqz1aO0v19ZCQmVOrcYiK2t6efKS6T1ZU2jJL
         DgN3+pTBjLiA6eDgWvRX9LFLkvNaWNiGt+F1EIUhqlq1vLuSzElHV8jYh4XJ2fcG415d
         QfMBfEnT/opAA/kXSBQ/J6FiSqbGDvGDu011VLZc/LhPkZFt/WcuxbMCjqfesiXdobcv
         cJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIUaDsS3TlIZbhKyHx6NwpLW6Nt70ekQtolYf9/XSE4=;
        b=gMJ3uDlPpAWQ1PHRYIIG0Y0809UbGX2703t9S1qWcrSyGKHtn37Z4xW76wySIXeYD8
         8oFbBkoYN/9nekEtipg1A98G6ZjcBcSBXBaU6+reDn66JFBR4EQKektypJcJfHa7zMIl
         inyMWEBOj9OrloSZ4sxbgNR5KDYths0gkLkwFCMM7gaHx62yVf/dXzGRWB8e0uSGXKXg
         rqipkX7Ru5+JmZzBfZuwGqhvD1jACvBZEYbURbREp2U4JzIL37KWQwMTSYmq8AHOzAyz
         IpxTy4xpeMEoGkR+XL5z/zeVN+ac9uYgPwprfMvNkqx1emfj3K0O/pbGpnS70qD+qVKb
         ybMg==
X-Gm-Message-State: AOAM531DZGbfS9N93ymhwnnVvM/gRv/pYpA6CaZfDFyFAX/YxDve/lMy
        pcQkFkRGJ/T0/32AjG9vxKWk2XWRM9QvZpPX
X-Google-Smtp-Source: ABdhPJwE6QB1xC4MSSr4U96XQc8VXCcwYGuhcZ1xBfLcEnYi/8WDOgHRyf6F7Bd8GOI0Kuoo6q3Hbw==
X-Received: by 2002:a17:902:9049:b029:da:efd6:4c12 with SMTP id w9-20020a1709029049b02900daefd64c12mr14373276plz.12.1611805127489;
        Wed, 27 Jan 2021 19:38:47 -0800 (PST)
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp. [210.141.244.193])
        by smtp.gmail.com with ESMTPSA id d21sm3393117pjz.39.2021.01.27.19.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 19:38:46 -0800 (PST)
Date:   Thu, 28 Jan 2021 12:38:42 +0900
From:   Masami Hiramatsu <masami.hiramatsu@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Subject: Re: kprobes broken since 0d00449c7a28
 ("x86: Replace ist_enter() with nmi_enter()")
Message-Id: <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
In-Reply-To: <20210128103415.d90be51ec607bb6123b2843c@kernel.org>
References: <25cd2608-03c2-94b8-7760-9de9935fde64@suse.com>
        <20210128001353.66e7171b395473ef992d6991@kernel.org>
        <20210128002452.a79714c236b69ab9acfa986c@kernel.org>
        <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
        <20210128103415.d90be51ec607bb6123b2843c@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Thu, 28 Jan 2021 10:34:15 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 27 Jan 2021 19:57:56 +0200
> Nikolay Borisov <nborisov@suse.com> wrote:
> 
> > 
> > 
> > On 27.01.21 г. 17:24 ч., Masami Hiramatsu wrote:
> > > On Thu, 28 Jan 2021 00:13:53 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > 
> > >> Hi Nikolay,
> > >>
> > >> On Wed, 27 Jan 2021 15:43:29 +0200
> > >> Nikolay Borisov <nborisov@suse.com> wrote:
> > >>
> > >>> Hello,
> > >>>
> > >>> I'm currently seeing latest Linus' master being somewhat broken w.r.t
> > >>> krpobes. In particular I have the following test-case:
> > >>>
> > >>> #!/bin/bash
> > >>>
> > >>> mkfs.btrfs -f /dev/vdc &> /dev/null
> > >>> mount /dev/vdc /media/scratch/
> > >>>
> > >>> bpftrace -e 'kprobe:btrfs_sync_file {printf("kprobe: %s\n", kstack());}'
> > >>> &>bpf-output &
> > >>> bpf_trace_pid=$!
> > >>>
> > >>> # force btrfs_sync_file to be called
> > >>> sleep 2
> > >>> xfs_io -f -c "pwrite 0 4m" -c "fsync" /media/scratch/file5
> > >>>
> > >>> kill $bpf_trace_pid
> > >>> sleep 1
> > >>>
> > >>> grep -q kprobe bpf-output
> > >>> retval=$?
> > >>> rm -f bpf-output
> > >>> umount /media/scratch
> > >>>
> > >>> exit $retval
> > >>>
> > >>> It traces btrfs_sync_file which is called when fsync is executed on a
> > >>> btrfs file, however I don't see the stacktrace being printed i.e the
> > >>> kprobe doesn't fire at all. The following alternative program:
> > >>>
> > >>> bpftrace -e 'tracepoint:btrfs:btrfs_sync_file {printf("tracepoint:
> > >>> %s\n", kstack());} kprobe:btrfs_sync_file {printf("kprobe: %s\n",
> > >>> kstack());}'
> > >>>
> > >>> only prints the stack from the tracepoint and not from the kprobe, given
> > >>> that the tracepoint is called from the btrfs_sync_file function.
> > >>
> > >> Thank you for reporting!
> > >>
> > >> If you don't mind, could you confirm it with ftrace (tracefs)?
> > >> bpftrace etc. involves too many things. It is better to test with
> > >> simpler way to test it.
> > >> I'm not familer with the bpftrace, but I think you can check it with
> > >>
> > >> # cd /sys/kernel/debug/tracing
> > >> # echo p:myevent btrfs_sync_file >> kprobe_events
> > >> # echo stacktrace > events/kprobes/myevent/trigger
> > >>  (or echo 1 > options/stacktrace , if trigger file doesn't exist)
> > > 
> > > Of course, also you have to enable the event.
> > >  # echo 1 > events/kprobes/myevent/enable
> > > 
> > > And check the results
> > > 
> > >  # cat trace
> > > 
> > > 
> > >> Could you also share your kernel config, so that we can reproduce it?
> > > 
> > 
> > I've attached the config and indeed with the scenario you proposed it
> > seems to works. I see:
> > 
> >        xfs_io-20280   [000] d.Z.  9900.748633: myevent:
> > (btrfs_sync_file+0x0/0x580)
> >           xfs_io-20280   [000] d.Z.  9900.748647: <stack trace>
> >  => kprobe_trace_func
> >  => kprobe_dispatcher
> >  => kprobe_int3_handler
> >  => exc_int3
> >  => asm_exc_int3
> >  => btrfs_sync_file
> >  => do_fsync
> >  => __x64_sys_fsync
> >  => do_syscall_64
> >  => entry_SYSCALL_64_after_hwframe
> 
> Hmm, then there might be a problem in bpftrace or ebpf (need more info).
> At least kprobes itself isn't broken.
> I guess they check "in_nmi()" and skip such event?

Yeah, there is. Nikolay, could you try this tentative patch?

Of course this just drops the NMI check from the handler, so alternative
checker is required. But I'm not sure what the original code concerns.
As far as I can see, there seems no re-entrant block flag, nor locks
among ebpf programs in runtime.

Alexei, could you tell me what is the concerning situation for bpf?

Thank you,

From c5cd0e5f60ef6494c9e1579ec1b82b7344c41f9a Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Thu, 28 Jan 2021 12:31:02 +0900
Subject: [PATCH] tracing: bpf: Remove in_nmi() check from kprobe handler

Since commit 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()") has
changed the kprobe handler to run in the NMI context, in_nmi() always returns
true. This means the bpf events on kprobes always skipped.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/bpf_trace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6c0018abe68a..764400260eb6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -96,9 +96,6 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
 	unsigned int ret;
 
-	if (in_nmi()) /* not supported yet */
-		return 1;
-
 	cant_sleep();
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
-- 
2.25.1

-- 
Masami Hiramatsu
