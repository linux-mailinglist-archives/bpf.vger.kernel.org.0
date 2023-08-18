Return-Path: <bpf+bounces-8050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E857807D2
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15C628235B
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 09:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323C018006;
	Fri, 18 Aug 2023 09:01:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56D17FE1;
	Fri, 18 Aug 2023 09:01:57 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4A1423A;
	Fri, 18 Aug 2023 02:01:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68872cadc7cso581944b3a.1;
        Fri, 18 Aug 2023 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692349295; x=1692954095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVL2uL0YfoWa6hUpsOGj+GWrUBMv+KAl85kdKYemUFM=;
        b=Unej7sgI7UpKElD6Xjm3W80ojN4WUKKgr5bcZ2BaPa3OIPAkvW1J2KsY1/ftg2KVxq
         tVtCpDMKRod3+Dq+LxM7RiVr7fWIfjDOHeWHRsIHjEUMqGjVjo+iFACARphN7cYLkTyN
         0hB58hrcZLDfRtuUPz3QJOV2pOaLfZNWdF27fE9vHJjrwGQtT0DNqPO1jbICUEu6cwUu
         d7fa4D+eZ8Q/G2JZFs6FqIQKi4/sARFqPgKuSsHhfavU/bSvpunK7SahOBibdd06jDz4
         aGGxCB2E4T+/3U3Hhp5itip0oqsU9Zlf3lmgsAQlw+AwgYn9SwhdNugdmbQSrtZ5fs/B
         3iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349295; x=1692954095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVL2uL0YfoWa6hUpsOGj+GWrUBMv+KAl85kdKYemUFM=;
        b=RnSqGvd6kw43HGFl0iNaCkztJ69oCoI1WFVe81YeDwZLC5dUd/HTzu/aYqUw5VeQIg
         R61BNSYPmtvDrakSpCqBdyVPS2eUUUJkde5PQVESeKrSHUzhL2lqo+SOEXEssLh8G83X
         pX9rZquihgEY7CY3kfMFFEKDFDVkwqmZRPXx7V7hwpTQf8fu6WzFjENAxX+abdfkvfK7
         Li4WKv3tLMGUZJtXRf7hggHPVMXrb9SOpaMJfxmPvrPOqe7LzxQdcBO6bQ0lRj7I35v5
         kwx2N6xeOJ+mP5dsb/f832REEK+By0GucUzLa5LRbkrqucxuGuUJIoIBD3yhHifyYr73
         nsoA==
X-Gm-Message-State: AOJu0YywRHWixfaFsLiuxO6QcbO5yhWnXSkfkjVnAfvAkB+QgGMPqqIs
	RabuocNa39qLKNTD8vKgxg==
X-Google-Smtp-Source: AGHT+IHf2Wd9drm5Ks37lUHzdQNY64cR+wCLztgLoJPZkd/clnY4QsiBZMiiyCIIqnAd0FQrQpsbbw==
X-Received: by 2002:a05:6a20:ddaf:b0:137:53d1:3e2 with SMTP id kw47-20020a056a20ddaf00b0013753d103e2mr1853407pzb.41.1692349294731;
        Fri, 18 Aug 2023 02:01:34 -0700 (PDT)
Received: from dell-sscc.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001b89045ff03sm1217130plb.233.2023.08.18.02.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:01:32 -0700 (PDT)
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
Subject: [bpf-next 2/9] samples/bpf: convert to vmlinux.h with tracing programs
Date: Fri, 18 Aug 2023 18:01:12 +0900
Message-Id: <20230818090119.477441-3-danieltimlee@gmail.com>
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

This commit replaces separate headers with a single vmlinux.h to
tracing programs. Thanks to that, we no longer need to define the
argument structure for tracing programs directly. For example, argument
for the sched_switch tracpepoint (sched_switch_args) can be replaced
with the vmlinux.h provided trace_event_raw_sched_switch.

Additional defines have been added to the BPF program either directly
or through the inclusion of net_shared.h. Defined values are
PERF_MAX_STACK_DEPTH, IFNAMSIZ constants and __stringify() macro. This
change enables the BPF program to access internal structures with BTF
generated "vmlinux.h" header.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/net_shared.h           |  2 ++
 samples/bpf/offwaketime_kern.c     | 21 ++++++---------------
 samples/bpf/spintest_kern.c        | 10 ++++++----
 samples/bpf/test_overhead_tp.bpf.c | 29 ++---------------------------
 samples/bpf/tracex1_kern.c         |  5 ++---
 samples/bpf/tracex3_kern.c         |  4 +---
 samples/bpf/tracex4_kern.c         |  3 +--
 samples/bpf/tracex5_kern.c         |  7 +++----
 samples/bpf/tracex6_kern.c         |  3 +--
 samples/bpf/tracex7_kern.c         |  3 +--
 10 files changed, 25 insertions(+), 62 deletions(-)

diff --git a/samples/bpf/net_shared.h b/samples/bpf/net_shared.h
index e9429af9aa44..88cc52461c98 100644
--- a/samples/bpf/net_shared.h
+++ b/samples/bpf/net_shared.h
@@ -17,6 +17,8 @@
 #define TC_ACT_OK		0
 #define TC_ACT_SHOT		2
 
+#define IFNAMSIZ 16
+
 #if defined(__BYTE_ORDER__) && defined(__ORDER_LITTLE_ENDIAN__) && \
 	__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define bpf_ntohs(x)		__builtin_bswap16(x)
diff --git a/samples/bpf/offwaketime_kern.c b/samples/bpf/offwaketime_kern.c
index 23f12b47e9e5..8e5105811178 100644
--- a/samples/bpf/offwaketime_kern.c
+++ b/samples/bpf/offwaketime_kern.c
@@ -4,14 +4,15 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
-#include <uapi/linux/bpf.h>
-#include <uapi/linux/ptrace.h>
-#include <uapi/linux/perf_event.h>
+#include "vmlinux.h"
 #include <linux/version.h>
-#include <linux/sched.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+#ifndef PERF_MAX_STACK_DEPTH
+#define PERF_MAX_STACK_DEPTH         127
+#endif
+
 #define _(P)                                                                   \
 	({                                                                     \
 		typeof(P) val;                                                 \
@@ -111,18 +112,8 @@ static inline int update_counts(void *ctx, u32 pid, u64 delta)
 
 #if 1
 /* taken from /sys/kernel/tracing/events/sched/sched_switch/format */
-struct sched_switch_args {
-	unsigned long long pad;
-	char prev_comm[TASK_COMM_LEN];
-	int prev_pid;
-	int prev_prio;
-	long long prev_state;
-	char next_comm[TASK_COMM_LEN];
-	int next_pid;
-	int next_prio;
-};
 SEC("tracepoint/sched/sched_switch")
-int oncpu(struct sched_switch_args *ctx)
+int oncpu(struct trace_event_raw_sched_switch *ctx)
 {
 	/* record previous thread sleep time */
 	u32 pid = ctx->prev_pid;
diff --git a/samples/bpf/spintest_kern.c b/samples/bpf/spintest_kern.c
index 455da77319d9..15740b16a3f7 100644
--- a/samples/bpf/spintest_kern.c
+++ b/samples/bpf/spintest_kern.c
@@ -4,14 +4,15 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
-#include <linux/skbuff.h>
-#include <linux/netdevice.h>
+#include "vmlinux.h"
 #include <linux/version.h>
-#include <uapi/linux/bpf.h>
-#include <uapi/linux/perf_event.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+#ifndef PERF_MAX_STACK_DEPTH
+#define PERF_MAX_STACK_DEPTH         127
+#endif
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, long);
@@ -60,6 +61,7 @@ SEC("kprobe/_raw_spin_lock_irq")PROG(p11)
 SEC("kprobe/_raw_spin_trylock")PROG(p12)
 SEC("kprobe/_raw_spin_lock")PROG(p13)
 SEC("kprobe/_raw_spin_lock_bh")PROG(p14)
+
 /* and to inner bpf helpers */
 SEC("kprobe/htab_map_update_elem")PROG(p15)
 SEC("kprobe/__htab_percpu_map_update_elem")PROG(p16)
diff --git a/samples/bpf/test_overhead_tp.bpf.c b/samples/bpf/test_overhead_tp.bpf.c
index 8b498328e961..5dc08b587978 100644
--- a/samples/bpf/test_overhead_tp.bpf.c
+++ b/samples/bpf/test_overhead_tp.bpf.c
@@ -8,40 +8,15 @@
 #include <bpf/bpf_helpers.h>
 
 /* from /sys/kernel/tracing/events/task/task_rename/format */
-struct task_rename {
-	__u64 pad;
-	__u32 pid;
-	char oldcomm[TASK_COMM_LEN];
-	char newcomm[TASK_COMM_LEN];
-	__u16 oom_score_adj;
-};
 SEC("tracepoint/task/task_rename")
-int prog(struct task_rename *ctx)
+int prog(struct trace_event_raw_task_rename *ctx)
 {
 	return 0;
 }
 
 /* from /sys/kernel/tracing/events/fib/fib_table_lookup/format */
-struct fib_table_lookup {
-	__u64 pad;
-	__u32 tb_id;
-	int err;
-	int oif;
-	int iif;
-	__u8 proto;
-	__u8 tos;
-	__u8 scope;
-	__u8 flags;
-	__u8 src[4];
-	__u8 dst[4];
-	__u8 gw4[4];
-	__u8 gw6[16];
-	__u16 sport;
-	__u16 dport;
-	char name[16];
-};
 SEC("tracepoint/fib/fib_table_lookup")
-int prog2(struct fib_table_lookup *ctx)
+int prog2(struct trace_event_raw_fib_table_lookup *ctx)
 {
 	return 0;
 }
diff --git a/samples/bpf/tracex1_kern.c b/samples/bpf/tracex1_kern.c
index ef30d2b353b0..bb78bdbffa87 100644
--- a/samples/bpf/tracex1_kern.c
+++ b/samples/bpf/tracex1_kern.c
@@ -4,9 +4,8 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
-#include <linux/skbuff.h>
-#include <linux/netdevice.h>
-#include <uapi/linux/bpf.h>
+#include "vmlinux.h"
+#include "net_shared.h"
 #include <linux/version.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/samples/bpf/tracex3_kern.c b/samples/bpf/tracex3_kern.c
index bde6591cb20c..7cc60f10d2e5 100644
--- a/samples/bpf/tracex3_kern.c
+++ b/samples/bpf/tracex3_kern.c
@@ -4,10 +4,8 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
-#include <linux/skbuff.h>
-#include <linux/netdevice.h>
+#include "vmlinux.h"
 #include <linux/version.h>
-#include <uapi/linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/samples/bpf/tracex4_kern.c b/samples/bpf/tracex4_kern.c
index eb0f8fdd14bf..ca826750901a 100644
--- a/samples/bpf/tracex4_kern.c
+++ b/samples/bpf/tracex4_kern.c
@@ -4,9 +4,8 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
-#include <linux/ptrace.h>
+#include "vmlinux.h"
 #include <linux/version.h>
-#include <uapi/linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/samples/bpf/tracex5_kern.c b/samples/bpf/tracex5_kern.c
index 64a1f7550d7e..8cd697ee7047 100644
--- a/samples/bpf/tracex5_kern.c
+++ b/samples/bpf/tracex5_kern.c
@@ -4,15 +4,14 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
-#include <linux/ptrace.h>
+#include "vmlinux.h"
+#include "syscall_nrs.h"
 #include <linux/version.h>
-#include <uapi/linux/bpf.h>
-#include <uapi/linux/seccomp.h>
 #include <uapi/linux/unistd.h>
-#include "syscall_nrs.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+#define __stringify(x) #x
 #define PROG(F) SEC("kprobe/"__stringify(F)) int bpf_func_##F
 
 struct {
diff --git a/samples/bpf/tracex6_kern.c b/samples/bpf/tracex6_kern.c
index acad5712d8b4..6ad82e68f998 100644
--- a/samples/bpf/tracex6_kern.c
+++ b/samples/bpf/tracex6_kern.c
@@ -1,6 +1,5 @@
-#include <linux/ptrace.h>
+#include "vmlinux.h"
 #include <linux/version.h>
-#include <uapi/linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
 struct {
diff --git a/samples/bpf/tracex7_kern.c b/samples/bpf/tracex7_kern.c
index c5a92df8ac31..ab8d6704a5a4 100644
--- a/samples/bpf/tracex7_kern.c
+++ b/samples/bpf/tracex7_kern.c
@@ -1,5 +1,4 @@
-#include <uapi/linux/ptrace.h>
-#include <uapi/linux/bpf.h>
+#include "vmlinux.h"
 #include <linux/version.h>
 #include <bpf/bpf_helpers.h>
 
-- 
2.34.1


