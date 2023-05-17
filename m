Return-Path: <bpf+bounces-770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0C67068BA
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 14:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A691C20F03
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255FC18B18;
	Wed, 17 May 2023 12:56:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9D79C0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 12:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E768C433EF;
	Wed, 17 May 2023 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684328185;
	bh=aFRrYAqDSJxn8HKtK8TeJ3ohzNrp0EBecEl3zcAiyt8=;
	h=From:To:Cc:Subject:Date:From;
	b=RwYMMQwsvv4e5jkEclWn763W6XRr9IKHeCWmYki3sfUxAoo+EqonowM7V8dRIqL+p
	 3orWIahvQw8w2LKaHGl/rXoaP4rzg+KNOid/e541r6UQsX2u7o8czOd4HE7mBIfrYf
	 d5avXK6rec78PIwHP674iqTZKSz0jlt3+J3D/Dq+F5Kpq9CP43IZp4dgz9jBDwVMtZ
	 65m6G+Dl54pK4akJff1zvPe6dWjQH+loEXhXOlzUDKlou8DNnq56k9FKfTsnTR8Opm
	 536gkKzV1O8mRdIIMKZh5EAmbqJXnKS9Q5SAnGBG7wg6S5OE24Pi+GBv6JjCtj0I9V
	 0tgr12efNB3Ow==
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Delyan Kratunov <delyank@fb.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Menglong Dong <imagedong@tencent.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] bpf: hide unused bpf_patch_call_args
Date: Wed, 17 May 2023 14:56:08 +0200
Message-Id: <20230517125617.931437-1-arnd@kernel.org>
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
 kernel/bpf/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7421487422d4..6f5ede31e471 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2064,7 +2064,7 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
 };
 #undef PROG_NAME_LIST
 #define PROG_NAME_LIST(stack_size) PROG_NAME_ARGS(stack_size),
-static u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
+static __maybe_unused u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
 				  const struct bpf_insn *insn) = {
 EVAL6(PROG_NAME_LIST, 32, 64, 96, 128, 160, 192)
 EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
@@ -2072,6 +2072,7 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
 };
 #undef PROG_NAME_LIST
 
+#ifdef CONFIG_BPF_SYSCALL
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 {
 	stack_depth = max_t(u32, stack_depth, 1);
@@ -2080,6 +2081,7 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 		__bpf_call_base_args;
 	insn->code = BPF_JMP | BPF_CALL_ARGS;
 }
+#endif
 
 #else
 static unsigned int __bpf_prog_ret0_warn(const void *ctx,
-- 
2.39.2


