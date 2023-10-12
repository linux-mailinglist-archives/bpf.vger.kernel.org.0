Return-Path: <bpf+bounces-12025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A77C6CAF
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 13:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4522828B0
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61624A05;
	Thu, 12 Oct 2023 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mt57GOFp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D5249F2
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 11:46:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867B7B7
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697111189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIegbc1FLrrwIh2JY6As7DXUlzCdo7e3rD7xAJ0V3OI=;
	b=Mt57GOFp8cOHdpuiLhafsQDZ3n30TU3VN2JGMfNW1pdyNGDCiLyOWv+uAvo925Sc6UshvF
	Wa9yA0YgkWdi2dHZLyjHgqlxv5WsjIZnkXdF7Js7T4OVt7JCjphVvqvtEOGWbjyMdPm/wm
	Zxr8U2Czub7xsDIR4+HQTYitjOpU2sU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-3jWqN8JuMCGfw_MDG6rsJg-1; Thu, 12 Oct 2023 07:46:10 -0400
X-MC-Unique: 3jWqN8JuMCGfw_MDG6rsJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1A3185530F;
	Thu, 12 Oct 2023 11:46:09 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D6D462157F5A;
	Thu, 12 Oct 2023 11:46:07 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Artem Savkov <asavkov@redhat.com>
Subject: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in struct syscall_tp_t
Date: Thu, 12 Oct 2023 13:45:50 +0200
Message-ID: <20231012114550.152846-1-asavkov@redhat.com>
In-Reply-To: <20231005123413.GA488417@alecto.usersys.redhat.com>
References: <20231005123413.GA488417@alecto.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

linux-rt-devel tree contains a patch (b1773eac3f29c ("sched: Add support
for lazy preemption")) that adds an extra member to struct trace_entry.
This causes the offset of args field in struct trace_event_raw_sys_enter
be different from the one in struct syscall_trace_enter:

struct trace_event_raw_sys_enter {
        struct trace_entry         ent;                  /*     0    12 */

        /* XXX last struct has 3 bytes of padding */
        /* XXX 4 bytes hole, try to pack */

        long int                   id;                   /*    16     8 */
        long unsigned int          args[6];              /*    24    48 */
        /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
        char                       __data[];             /*    72     0 */

        /* size: 72, cachelines: 2, members: 4 */
        /* sum members: 68, holes: 1, sum holes: 4 */
        /* paddings: 1, sum paddings: 3 */
        /* last cacheline: 8 bytes */
};

struct syscall_trace_enter {
        struct trace_entry         ent;                  /*     0    12 */

        /* XXX last struct has 3 bytes of padding */

        int                        nr;                   /*    12     4 */
        long unsigned int          args[];               /*    16     0 */

        /* size: 16, cachelines: 1, members: 3 */
        /* paddings: 1, sum paddings: 3 */
        /* last cacheline: 16 bytes */
};

This, in turn, causes perf_event_set_bpf_prog() fail while running bpf
test_profiler testcase because max_ctx_offset is calculated based on the
former struct, while off on the latter:

  10488         if (is_tracepoint || is_syscall_tp) {
  10489                 int off = trace_event_get_offsets(event->tp_event);
  10490
  10491                 if (prog->aux->max_ctx_offset > off)
  10492                         return -EACCES;
  10493         }

What bpf program is actually getting is a pointer to struct
syscall_tp_t, defined in kernel/trace/trace_syscalls.c. This patch fixes
the problem by aligning struct syscall_tp_t with with struct
syscall_trace_(enter|exit) and changing the tests to use these structs
to dereference context.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 kernel/trace/trace_syscalls.c                    | 4 ++--
 tools/testing/selftests/bpf/progs/profiler.inc.h | 2 +-
 tools/testing/selftests/bpf/progs/test_vmlinux.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index de753403cdafb..9c581d6da843a 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -556,7 +556,7 @@ static int perf_call_bpf_enter(struct trace_event_call *call, struct pt_regs *re
 {
 	struct syscall_tp_t {
 		struct trace_entry ent;
-		unsigned long syscall_nr;
+		int syscall_nr;
 		unsigned long args[SYSCALL_DEFINE_MAXARGS];
 	} __aligned(8) param;
 	int i;
@@ -661,7 +661,7 @@ static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *reg
 {
 	struct syscall_tp_t {
 		struct trace_entry ent;
-		unsigned long syscall_nr;
+		int syscall_nr;
 		unsigned long ret;
 	} __aligned(8) param;
 
diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index f799d87e87002..897061930cb76 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -609,7 +609,7 @@ ssize_t BPF_KPROBE(kprobe__proc_sys_write,
 }
 
 SEC("tracepoint/syscalls/sys_enter_kill")
-int tracepoint__syscalls__sys_enter_kill(struct trace_event_raw_sys_enter* ctx)
+int tracepoint__syscalls__sys_enter_kill(struct syscall_trace_enter* ctx)
 {
 	struct bpf_func_stats_ctx stats_ctx;
 
diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c b/tools/testing/selftests/bpf/progs/test_vmlinux.c
index 4b8e37f7fd06c..78b23934d9f8f 100644
--- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
+++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
@@ -16,12 +16,12 @@ bool kprobe_called = false;
 bool fentry_called = false;
 
 SEC("tp/syscalls/sys_enter_nanosleep")
-int handle__tp(struct trace_event_raw_sys_enter *args)
+int handle__tp(struct syscall_trace_enter *args)
 {
 	struct __kernel_timespec *ts;
 	long tv_nsec;
 
-	if (args->id != __NR_nanosleep)
+	if (args->nr != __NR_nanosleep)
 		return 0;
 
 	ts = (void *)args->args[0];
-- 
2.41.0


