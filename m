Return-Path: <bpf+bounces-1683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F717203C0
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 15:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87E72818CA
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC601951B;
	Fri,  2 Jun 2023 13:51:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CADE19509
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 13:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BA4C433D2;
	Fri,  2 Jun 2023 13:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685713897;
	bh=+FsSpx9RH7B04NclB3EiDSdjh3wRRkb9YV3Jl0GU0lc=;
	h=From:To:Cc:Subject:Date:From;
	b=ImH0SK4xMGhP5BS50S2vxwDTc+bpUVKnvvZjh7vAUdBlhNZMJysg3FXiYW8H6EkN/
	 UgkvcuTKbQqVz4wvwQ3QO8S6g9oVMGJSyyvWTGmlUOLe/0/dE+18ECounmjtPb4diM
	 mRHFBW5qp2ooJ2KsVn7pbkE+867c5SoCklzFvLUpKQV/tB/dXZloj6Kf5hf6Occ6mw
	 Zb1mGaUEITebvwkKJ9px3QU6VoCROvvl0mTAgxRbUgkAdsFxG2Qc9zlL20muWFexkn
	 aFAc/sr/8x5vtC5yCu2zBulNEG0XNwTUZxPakRGMIa9OtNDsR7GMzjgGGFXiOoMHTN
	 qSHCZ4+FSD2MA==
From: Arnd Bergmann <arnd@kernel.org>
To: Yonghong Song <yhs@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [v3] bpf: hide unused bpf_patch_call_args
Date: Fri,  2 Jun 2023 15:50:18 +0200
Message-Id: <20230602135128.1498362-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This function is only used when CONFIG_BPF_JIT_ALWAYS_ON is disabled,
but CONFIG_BPF_SYSCALL is enabled. When both are turned off, the
prototype is missing but the unused function is still compiled,
as seen from this W=1 warning:

kernel/bpf/core.c:2075:6: error: no previous prototype for 'bpf_patch_call_args' [-Werror=missing-prototypes]

Add a matching #ifdef for the definition to leave it out.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: fix incorrect changelog text
v2: change indentation to align arguments better. Still not great
as the line is just too long
---
 kernel/bpf/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7421487422d48..0926714641eb5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2064,14 +2064,16 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
 };
 #undef PROG_NAME_LIST
 #define PROG_NAME_LIST(stack_size) PROG_NAME_ARGS(stack_size),
-static u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
-				  const struct bpf_insn *insn) = {
+static __maybe_unused
+u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
+			   const struct bpf_insn *insn) = {
 EVAL6(PROG_NAME_LIST, 32, 64, 96, 128, 160, 192)
 EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
 EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
 };
 #undef PROG_NAME_LIST
 
+#ifdef CONFIG_BPF_SYSCALL
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 {
 	stack_depth = max_t(u32, stack_depth, 1);
@@ -2080,6 +2082,7 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 		__bpf_call_base_args;
 	insn->code = BPF_JMP | BPF_CALL_ARGS;
 }
+#endif
 
 #else
 static unsigned int __bpf_prog_ret0_warn(const void *ctx,
-- 
2.39.2


