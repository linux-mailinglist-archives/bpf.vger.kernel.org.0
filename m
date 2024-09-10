Return-Path: <bpf+bounces-39541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AA19744F7
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 23:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E4F1C25752
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A07B1AB52E;
	Tue, 10 Sep 2024 21:40:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378731AAE0B
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004453; cv=none; b=pftB5uFS8rFKoNcgfqcZUqMUFWQxYD4nyI1Z8ho1MmfybIUUXkxgvaPmHxouAuHLg6XqHp6G7DD6Vwzm1i10OU2/9STQYTK0CaeCtxS+GAIgdOSU4yisQE613/gAICsA7Aw4n1k04gLlooPxrS848gW+EHjC3QB07EhOd/HMXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004453; c=relaxed/simple;
	bh=BKAU17kiqTGnYRW95RzZaLsyww+bIbrlVbTXFHS0510=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYP7zfRXqfuFqAgpw2O8XpppJgJQieXGXvaUNtoGW5+2lOMmP/C69AWmNUQzAGMCSAEXSsYA/5f5gIWlESJp2vQtrLvHyWHtfLZmZzyO/gUVgiJaDTm8JQARAYtPkmdUWQPaRV1f3/J1/n+FaJFRg2PArYsMTQn3frNgcTrM7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id BAE618D1A963; Tue, 10 Sep 2024 14:40:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Salvatore Benedetto <salvabenedetto@meta.com>
Subject: [PATCH bpf-next v2] bpf: Use fake pt_regs when doing bpf syscall tracepoint tracing
Date: Tue, 10 Sep 2024 14:40:37 -0700
Message-ID: <20240910214037.3663272-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Salvatore Benedetto reported an issue that when doing syscall tracepoint
tracing the kernel stack is empty. For example, using the following
command line
  bpftrace -e 'tracepoint:syscalls:sys_enter_read { print("Kernel Stack\n=
"); print(kstack()); }'
  bpftrace -e 'tracepoint:syscalls:sys_exit_read { print("Kernel Stack\n"=
); print(kstack()); }'
the output for both commands is
=3D=3D=3D
  Kernel Stack
=3D=3D=3D

Further analysis shows that pt_regs used for bpf syscall tracepoint
tracing is from the one constructed during user->kernel transition.
The call stack looks like
  perf_syscall_enter+0x88/0x7c0
  trace_sys_enter+0x41/0x80
  syscall_trace_enter+0x100/0x160
  do_syscall_64+0x38/0xf0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

The ip address stored in pt_regs is from user space hence no kernel
stack is printed.

To fix the issue, kernel address from pt_regs is required.
In kernel repo, there are already a few cases like this. For example,
in kernel/trace/bpf_trace.c, several perf_fetch_caller_regs(fake_regs_ptr=
)
instances are used to supply ip address or use ip address to construct
call stack.

Instead of allocate fake_regs in the stack which may consume
a lot of bytes, the function perf_trace_buf_alloc() in
perf_syscall_{enter, exit}() is leveraged to create fake_regs,
which will be passed to perf_call_bpf_{enter,exit}().

For the above bpftrace script, I got the following output with this patch=
:
for tracepoint:syscalls:sys_enter_read
=3D=3D=3D
  Kernel Stack

        syscall_trace_enter+407
        syscall_trace_enter+407
        do_syscall_64+74
        entry_SYSCALL_64_after_hwframe+75
=3D=3D=3D
and for tracepoint:syscalls:sys_exit_read
=3D=3D=3D
Kernel Stack

        syscall_exit_work+185
        syscall_exit_work+185
        syscall_exit_to_user_mode+305
        do_syscall_64+118
        entry_SYSCALL_64_after_hwframe+75
=3D=3D=3D

Reported-by: Salvatore Benedetto <salvabenedetto@meta.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/trace/trace_syscalls.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.=
c
index 9c581d6da843..785733245ead 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -564,6 +564,7 @@ static int perf_call_bpf_enter(struct trace_event_cal=
l *call, struct pt_regs *re
 	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
=20
 	/* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &=
param) */
+	perf_fetch_caller_regs(regs);
 	*(struct pt_regs **)&param =3D regs;
 	param.syscall_nr =3D rec->nr;
 	for (i =3D 0; i < sys_data->nb_args; i++)
@@ -575,6 +576,7 @@ static void perf_syscall_enter(void *ignore, struct p=
t_regs *regs, long id)
 {
 	struct syscall_metadata *sys_data;
 	struct syscall_trace_enter *rec;
+	struct pt_regs *fake_regs;
 	struct hlist_head *head;
 	unsigned long args[6];
 	bool valid_prog_array;
@@ -602,7 +604,7 @@ static void perf_syscall_enter(void *ignore, struct p=
t_regs *regs, long id)
 	size =3D ALIGN(size + sizeof(u32), sizeof(u64));
 	size -=3D sizeof(u32);
=20
-	rec =3D perf_trace_buf_alloc(size, NULL, &rctx);
+	rec =3D perf_trace_buf_alloc(size, &fake_regs, &rctx);
 	if (!rec)
 		return;
=20
@@ -611,7 +613,7 @@ static void perf_syscall_enter(void *ignore, struct p=
t_regs *regs, long id)
 	memcpy(&rec->args, args, sizeof(unsigned long) * sys_data->nb_args);
=20
 	if ((valid_prog_array &&
-	     !perf_call_bpf_enter(sys_data->enter_event, regs, sys_data, rec)) =
||
+	     !perf_call_bpf_enter(sys_data->enter_event, fake_regs, sys_data, r=
ec)) ||
 	    hlist_empty(head)) {
 		perf_swevent_put_recursion_context(rctx);
 		return;
@@ -666,6 +668,7 @@ static int perf_call_bpf_exit(struct trace_event_call=
 *call, struct pt_regs *reg
 	} __aligned(8) param;
=20
 	/* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &=
param) */
+	perf_fetch_caller_regs(regs);
 	*(struct pt_regs **)&param =3D regs;
 	param.syscall_nr =3D rec->nr;
 	param.ret =3D rec->ret;
@@ -676,6 +679,7 @@ static void perf_syscall_exit(void *ignore, struct pt=
_regs *regs, long ret)
 {
 	struct syscall_metadata *sys_data;
 	struct syscall_trace_exit *rec;
+	struct pt_regs *fake_regs;
 	struct hlist_head *head;
 	bool valid_prog_array;
 	int syscall_nr;
@@ -701,7 +705,7 @@ static void perf_syscall_exit(void *ignore, struct pt=
_regs *regs, long ret)
 	size =3D ALIGN(sizeof(*rec) + sizeof(u32), sizeof(u64));
 	size -=3D sizeof(u32);
=20
-	rec =3D perf_trace_buf_alloc(size, NULL, &rctx);
+	rec =3D perf_trace_buf_alloc(size, &fake_regs, &rctx);
 	if (!rec)
 		return;
=20
@@ -709,7 +713,7 @@ static void perf_syscall_exit(void *ignore, struct pt=
_regs *regs, long ret)
 	rec->ret =3D syscall_get_return_value(current, regs);
=20
 	if ((valid_prog_array &&
-	     !perf_call_bpf_exit(sys_data->exit_event, regs, rec)) ||
+	     !perf_call_bpf_exit(sys_data->exit_event, fake_regs, rec)) ||
 	    hlist_empty(head)) {
 		perf_swevent_put_recursion_context(rctx);
 		return;
--=20
2.43.5


