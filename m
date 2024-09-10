Return-Path: <bpf+bounces-39399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D99727B4
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 05:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DA41C237BF
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 03:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF67E101;
	Tue, 10 Sep 2024 03:43:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7A24205
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725939805; cv=none; b=gsD8ajsERzqD0RTcO0ZZmHsBRpDi8WIhKz4jX8G4sqMs9ypvIzWFSPXHXJqN96MPUbrlvEFlaaq0LmBH8AKbC291wYnUfQ3m0msPiJWT/I6gd3DXQ62/dr+ZGB2oz7mjJlwC7ndTuEhITPH1107TnIn6BpJIfsUV5WkQOpq0c9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725939805; c=relaxed/simple;
	bh=E+g14WRHJZqJRntUmlng0XFOrU3z/E4rapwtwvI7q6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=reo8r3KqcgDXv4gHTo4PFfG0VJfHqi8LmYMl0JK6RfnTscgJGz8wwUgMS5TAtRK0YS9zkdP3RlN9iewQpYfYDwqEgGw0n3MjqYLb9Yr8Ah+Doou5Q+U9ei3ySIEe7PS9HaWQ4uMRx645fISeVacjj7CAAUJAkeEKcg/ndNSrKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 964BC8C9597F; Mon,  9 Sep 2024 20:43:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Salvatore Benedetto <salvabenedetto@meta.com>
Subject: [PATCH bpf-next] bpf: Use fake pt_regs when doing bpf syscall tracepoint tracing
Date: Mon,  9 Sep 2024 20:43:06 -0700
Message-ID: <20240910034306.3122378-1-yonghong.song@linux.dev>
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
the output will be
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

To fix the issue, we need to use kernel address from pt_regs.
In kernel repo, there are already a few cases like this. For example,
in kernel/trace/bpf_trace.c, several perf_fetch_caller_regs(fake_regs_ptr=
)
instances are used to supply ip address or use ip address to construct
call stack.

The patch follows the above example by using a fake pt_regs.
The pt_regs is stored in local stack since the syscall tracepoint
tracing is in process context and there are no possibility that
different concurrent syscall tracepoint tracing could mess up with each
other. This is similar to a perf_fetch_caller_regs() use case in
kernel/trace/trace_event_perf.c with function perf_ftrace_function_call()
where a local pt_regs is used.

With this patch, for the above bpftrace script, I got the following outpu=
t
=3D=3D=3D
  Kernel Stack

        syscall_trace_enter+407
        syscall_trace_enter+407
        do_syscall_64+74
        entry_SYSCALL_64_after_hwframe+75
=3D=3D=3D

Reported-by: Salvatore Benedetto <salvabenedetto@meta.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/trace/trace_syscalls.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.=
c
index 9c581d6da843..063f51952d49 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -559,12 +559,15 @@ static int perf_call_bpf_enter(struct trace_event_c=
all *call, struct pt_regs *re
 		int syscall_nr;
 		unsigned long args[SYSCALL_DEFINE_MAXARGS];
 	} __aligned(8) param;
+	struct pt_regs fake_regs;
 	int i;
=20
 	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
=20
 	/* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &=
param) */
-	*(struct pt_regs **)&param =3D regs;
+	memset(&fake_regs, 0, sizeof(fake_regs));
+	perf_fetch_caller_regs(&fake_regs);
+	*(struct pt_regs **)&param =3D &fake_regs;
 	param.syscall_nr =3D rec->nr;
 	for (i =3D 0; i < sys_data->nb_args; i++)
 		param.args[i] =3D rec->args[i];
--=20
2.43.5


