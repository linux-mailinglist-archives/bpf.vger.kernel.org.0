Return-Path: <bpf+bounces-1130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0E770E5EF
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 21:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2BB28132D
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718D521CF5;
	Tue, 23 May 2023 19:49:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1461F934
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 19:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3827C433D2;
	Tue, 23 May 2023 19:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684871377;
	bh=wGtFDXPE8CltQmJ9Fbh/aecZq2T4bSX/gGoZYsF+49Q=;
	h=From:To:Cc:Subject:Date:From;
	b=oMQbKI0Nj0UwqawJ3TbFjDbSkvvztGzzZjp2YrN7OJvYD+vJFcZCyydU6kdAJQjhu
	 NAlf2lrJzRw5flZWTMAMVarPR/j+i1+s333STkNgcKC2cmhqD+TV/lxHwaAyeRWBqH
	 PRfd5PM1IShFAHDWpWoSLNJVVA0y3J/bpB5eLiyu4bdEVMMrA65OVDUwgFr05NZUFT
	 u8C+RcCuK4Knv0x+eE6T3SxhPx50u5Mncc97c4i2rY4v9dMbN2QRaj4dFiP8oDHsC9
	 kaDktqxoy/vLFovbKxqjj00KfGQLlupsY3cYfXtMJNNNst74ncHlF+ag5Vyt0i3npL
	 cASbX5JTIUp/Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH 1/2] [v2] bpf: hide unused bpf_patch_call_args
Date: Tue, 23 May 2023 21:43:06 +0200
Message-Id: <20230523194930.2116181-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This function has no callers and no declaration when CONFIG_BPF_JIT_ALWAYS_ON
is enabled:

kernel/bpf/core.c:2075:6: error: no previous prototype for 'bpf_patch_call_args' [-Werror=missing-prototypes]

Hide the definition as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: change indentation to align arguments better. Still not great
as the line is just too long
---
 kernel/bpf/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7421487422d4..0926714641eb 100644
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


