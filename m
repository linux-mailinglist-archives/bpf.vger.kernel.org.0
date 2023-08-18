Return-Path: <bpf+bounces-8053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BECB7807E8
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA59628233C
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1163182B1;
	Fri, 18 Aug 2023 09:02:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615E17ADD;
	Fri, 18 Aug 2023 09:02:10 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B319F3ABB;
	Fri, 18 Aug 2023 02:01:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf092a16c9so5782695ad.0;
        Fri, 18 Aug 2023 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692349306; x=1692954106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKKH8lOOWJx5/wwDW5pWYlJrkLRfMTfmu5uoSiIad0c=;
        b=I2/h1pJ0aV5ha+41pSS7wq1kGNdK00+za19KiMELXEjAi1l5eyFvTZKX3swGbtxxCU
         qsY5GV9vlvf9H1s2ZGKWA5MESNQmpTzq2FQcdx+dXFsEFKyCoHzIg4cMCsFDsx+E27+b
         uaVzs3/2bIUslnlb+gcoCNpZ37Lz4f+DYRnc1p2rGRHnhbV9VvsIarAT4Z7a29RPf0Hd
         Tx7FbgX3iJ8043jK7GYqv8fTZUkVko4BB/VlHZYANePHwKWk8mDlQEov/oKbCNb8KZqv
         F9ffycIa0q+a4vlPoXx7zPFiO6maYVNhc3z2QFjpYmCqK2/MbPj+e7WagW2KVNDm3TVC
         6RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349306; x=1692954106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKKH8lOOWJx5/wwDW5pWYlJrkLRfMTfmu5uoSiIad0c=;
        b=LmaKtuxDwZUb50YKICkUES9g0SUJkxh0GdCrsu9QRN6UiC8/BZA3k/KafH878h2WfD
         DyLTkB/Lgm7zghn9yT0wARKKIB5us/i4hPCCo0CRc0a1x4NCwtmIb+EgJ3iMWUCiFekc
         8YX2+ZQN0lkydQgbRcj5w4svbGmgwg1cORqA/nONCvtKHOdvUynoPQ+ovtKAGE7Q8ulD
         ucAyIRcgLdUeNWorLHdzN4bUYj7xzW7VL6YO9Eda+FbDLY+JWYRNI0l6XimB+CRyNwQw
         02aUqa6eFrFZBGXKvSljOE8a+1k9UIUYz/3l+PyfDhs4CnkiOOIavdHcmOJrBr7H15ov
         iikw==
X-Gm-Message-State: AOJu0YwxMZWXrwF17IiDv89siIbL19og66nRisDl/DmtjLN6Z7pwZKIE
	+SQv7fjmVOWz7A1VxRNd2A==
X-Google-Smtp-Source: AGHT+IEw/kgz4tTPYWkxWZNPPLXh5DO3suEd+KWXRjF8BGZ1VAgTCgljptPPQpJG09CIEkAGYTlyUg==
X-Received: by 2002:a17:903:32c7:b0:1bc:2d43:c747 with SMTP id i7-20020a17090332c700b001bc2d43c747mr2347499plr.38.1692349306057;
        Fri, 18 Aug 2023 02:01:46 -0700 (PDT)
Received: from dell-sscc.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001b89045ff03sm1217130plb.233.2023.08.18.02.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:01:45 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [bpf-next 5/9] samples/bpf: make tracing programs to be more CO-RE centric
Date: Fri, 18 Aug 2023 18:01:15 +0900
Message-Id: <20230818090119.477441-6-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818090119.477441-1-danieltimlee@gmail.com>
References: <20230818090119.477441-1-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The existing tracing programs have been developed for a considerable
period of time and, as a result, do not properly incorporate the
features of the current libbpf, such as CO-RE. This is evident in
frequent usage of functions like PT_REGS* and the persistence of "hack"
methods using underscore-style bpf_probe_read_kernel from the past.

These programs are far behind the current level of libbpf and can
potentially confuse users. Therefore, this commit aims to convert the
outdated BPF programs to be more CO-RE centric.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/offwaketime.bpf.c          | 18 +++++-------------
 samples/bpf/test_overhead_kprobe.bpf.c | 20 +++++++-------------
 samples/bpf/tracex1.bpf.c              | 17 +++++------------
 samples/bpf/tracex5.bpf.c              |  5 +++--
 4 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/samples/bpf/offwaketime.bpf.c b/samples/bpf/offwaketime.bpf.c
index 3200a0f44969..5f008f328836 100644
--- a/samples/bpf/offwaketime.bpf.c
+++ b/samples/bpf/offwaketime.bpf.c
@@ -8,18 +8,12 @@
 #include <linux/version.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
 
 #ifndef PERF_MAX_STACK_DEPTH
 #define PERF_MAX_STACK_DEPTH         127
 #endif
 
-#define _(P)                                                                   \
-	({                                                                     \
-		typeof(P) val;                                                 \
-		bpf_probe_read_kernel(&val, sizeof(val), &(P));                \
-		val;                                                           \
-	})
-
 #define MINBLOCK_US	1
 #define MAX_ENTRIES	10000
 
@@ -68,11 +62,9 @@ struct {
 SEC("kprobe/try_to_wake_up")
 int waker(struct pt_regs *ctx)
 {
-	struct task_struct *p = (void *) PT_REGS_PARM1(ctx);
+	struct task_struct *p = (void *)PT_REGS_PARM1_CORE(ctx);
+	u32 pid = BPF_CORE_READ(p, pid);
 	struct wokeby_t woke;
-	u32 pid;
-
-	pid = _(p->pid);
 
 	bpf_get_current_comm(&woke.name, sizeof(woke.name));
 	woke.ret = bpf_get_stackid(ctx, &stackmap, STACKID_FLAGS);
@@ -121,9 +113,9 @@ int oncpu(struct trace_event_raw_sched_switch *ctx)
 SEC("kprobe.multi/finish_task_switch*")
 int oncpu(struct pt_regs *ctx)
 {
-	struct task_struct *p = (void *) PT_REGS_PARM1(ctx);
+	struct task_struct *p = (void *)PT_REGS_PARM1_CORE(ctx);
 	/* record previous thread sleep time */
-	u32 pid = _(p->pid);
+	u32 pid = BPF_CORE_READ(p, pid);
 #endif
 	u64 delta, ts, *tsp;
 
diff --git a/samples/bpf/test_overhead_kprobe.bpf.c b/samples/bpf/test_overhead_kprobe.bpf.c
index c3528731e0e1..668cf5259c60 100644
--- a/samples/bpf/test_overhead_kprobe.bpf.c
+++ b/samples/bpf/test_overhead_kprobe.bpf.c
@@ -8,13 +8,7 @@
 #include <linux/version.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-
-#define _(P)                                                                   \
-	({                                                                     \
-		typeof(P) val = 0;                                             \
-		bpf_probe_read_kernel(&val, sizeof(val), &(P));                \
-		val;                                                           \
-	})
+#include <bpf/bpf_core_read.h>
 
 SEC("kprobe/__set_task_comm")
 int prog(struct pt_regs *ctx)
@@ -26,14 +20,14 @@ int prog(struct pt_regs *ctx)
 	u16 oom_score_adj;
 	u32 pid;
 
-	tsk = (void *)PT_REGS_PARM1(ctx);
+	tsk = (void *)PT_REGS_PARM1_CORE(ctx);
 
-	pid = _(tsk->pid);
-	bpf_probe_read_kernel_str(oldcomm, sizeof(oldcomm), &tsk->comm);
-	bpf_probe_read_kernel_str(newcomm, sizeof(newcomm),
+	pid = BPF_CORE_READ(tsk, pid);
+	bpf_core_read_str(oldcomm, sizeof(oldcomm), &tsk->comm);
+	bpf_core_read_str(newcomm, sizeof(newcomm),
 				  (void *)PT_REGS_PARM2(ctx));
-	signal = _(tsk->signal);
-	oom_score_adj = _(signal->oom_score_adj);
+	signal = BPF_CORE_READ(tsk, signal);
+	oom_score_adj = BPF_CORE_READ(signal, oom_score_adj);
 	return 0;
 }
 
diff --git a/samples/bpf/tracex1.bpf.c b/samples/bpf/tracex1.bpf.c
index f3be14a03964..889bed5480ac 100644
--- a/samples/bpf/tracex1.bpf.c
+++ b/samples/bpf/tracex1.bpf.c
@@ -8,15 +8,9 @@
 #include "net_shared.h"
 #include <linux/version.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
 #include <bpf/bpf_tracing.h>
 
-#define _(P)                                                                   \
-	({                                                                     \
-		typeof(P) val = 0;                                             \
-		bpf_probe_read_kernel(&val, sizeof(val), &(P));                \
-		val;                                                           \
-	})
-
 /* kprobe is NOT a stable ABI
  * kernel functions can be removed, renamed or completely change semantics.
  * Number of arguments and their positions can change, etc.
@@ -34,12 +28,11 @@ int bpf_prog1(struct pt_regs *ctx)
 	struct sk_buff *skb;
 	int len;
 
-	/* non-portable! works for the given kernel only */
-	bpf_probe_read_kernel(&skb, sizeof(skb), (void *)PT_REGS_PARM1(ctx));
-	dev = _(skb->dev);
-	len = _(skb->len);
+	bpf_core_read(&skb, sizeof(skb), (void *)PT_REGS_PARM1(ctx));
+	dev = BPF_CORE_READ(skb, dev);
+	len = BPF_CORE_READ(skb, len);
 
-	bpf_probe_read_kernel(devname, sizeof(devname), dev->name);
+	BPF_CORE_READ_STR_INTO(&devname, dev, name);
 
 	if (devname[0] == 'l' && devname[1] == 'o') {
 		char fmt[] = "skb %p len %d\n";
diff --git a/samples/bpf/tracex5.bpf.c b/samples/bpf/tracex5.bpf.c
index 8cd697ee7047..4d3d6c9b25fa 100644
--- a/samples/bpf/tracex5.bpf.c
+++ b/samples/bpf/tracex5.bpf.c
@@ -10,6 +10,7 @@
 #include <uapi/linux/unistd.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
 
 #define __stringify(x) #x
 #define PROG(F) SEC("kprobe/"__stringify(F)) int bpf_func_##F
@@ -46,7 +47,7 @@ PROG(SYS__NR_write)(struct pt_regs *ctx)
 {
 	struct seccomp_data sd;
 
-	bpf_probe_read_kernel(&sd, sizeof(sd), (void *)PT_REGS_PARM2(ctx));
+	bpf_core_read(&sd, sizeof(sd), (void *)PT_REGS_PARM2(ctx));
 	if (sd.args[2] == 512) {
 		char fmt[] = "write(fd=%d, buf=%p, size=%d)\n";
 		bpf_trace_printk(fmt, sizeof(fmt),
@@ -59,7 +60,7 @@ PROG(SYS__NR_read)(struct pt_regs *ctx)
 {
 	struct seccomp_data sd;
 
-	bpf_probe_read_kernel(&sd, sizeof(sd), (void *)PT_REGS_PARM2(ctx));
+	bpf_core_read(&sd, sizeof(sd), (void *)PT_REGS_PARM2(ctx));
 	if (sd.args[2] > 128 && sd.args[2] <= 1024) {
 		char fmt[] = "read(fd=%d, buf=%p, size=%d)\n";
 		bpf_trace_printk(fmt, sizeof(fmt),
-- 
2.34.1


