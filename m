Return-Path: <bpf+bounces-55897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE9A88DB1
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 23:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C61D189ABF8
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 21:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4F21DE3B5;
	Mon, 14 Apr 2025 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qhgEIFXS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C62DFA4E
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665776; cv=none; b=B+1W+MIGM8+caSh1JPVq41aFWzsnvjB8ca123KDTFa9rgMZ6pmalwFp/8qtqtwWl9CgPp/s0fC1ws6kJrYUh6NmEzzQjH8/1YVl7zxsvlWlQ92NfRh3CMmnYcj0QURCE94eOQ657EACpj5sAtILQ1oRsuHvwnIaHeTXy8YG9sw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665776; c=relaxed/simple;
	bh=HmQIPffzUx2fIx+kTtZicygBvpdqmmPifK5ZVu+zzS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFzHNi/rVyXKKYqik7oG2QgMk2xuOBMXq8TSZwvSloG+1p9wMnyPtNM+OzL5FqF9I9s5SIiVZUjvzVJPzQCbjYpmJu4CoaGjC+rsJu8a1GAnpnqfrHty3MNkWyZ+TCo1vu5sGI26tQogzxjxZT6/Z0vJaSqmMww1iJhQ/0Cqh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qhgEIFXS; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744665775; x=1776201775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LOx2NDtuGVGZQyX3vDkPmuUIvPcuXIIgQiEgRR2yyRk=;
  b=qhgEIFXSybFpg4oL6FvWVBkMsSAcVUkGbTL6pCwZwxPxGbjVExH1iiW9
   IiZiiEReVKIXUo4HYQloQYJhvRgnHtmroqvtkxTj0g636RWyjVDk4RC7I
   tQ6FJcHrhx2J76zTsyjO4sKnj1cUoMEbyReZPPhJTPIsj149JaFCtLGI8
   M=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="815990330"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 21:22:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:53826]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 09143611-8c22-4209-a065-96d1b3bdf763; Mon, 14 Apr 2025 21:22:48 +0000 (UTC)
X-Farcaster-Flow-ID: 09143611-8c22-4209-a065-96d1b3bdf763
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 21:22:48 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 21:22:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
CC: Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, Johan Almbladh
	<johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>,
	"Hari Bathini" <hbathini@linux.ibm.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=
	<bjorn@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang
	<xi.wang@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller"
	<davem@davemloft.net>, Wang YanQing <udknight@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<bpf@vger.kernel.org>
Subject: [PATCH v1 bpf 1/2] bpf: Allow bpf_int_jit_compile() to set errno.
Date: Mon, 14 Apr 2025 14:21:49 -0700
Message-ID: <20250414212207.63163-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414212207.63163-1-kuniyu@amazon.com>
References: <20250414212207.63163-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

There are some failure paths in bpf_int_jit_compile() that are not
worth triggering a warning in __bpf_prog_ret0_warn().

For example, if we fail to allocate memory in bpf_int_jit_compile(),
we should propagate -ENOMEM to userspace instead of attaching
__bpf_prog_ret0_warn().

Let's pass &err to bpf_int_jit_compile() to propagate errno.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 arch/arc/net/bpf_jit_core.c      |  2 +-
 arch/arm/net/bpf_jit_32.c        |  2 +-
 arch/arm64/net/bpf_jit_comp.c    |  2 +-
 arch/loongarch/net/bpf_jit.c     |  2 +-
 arch/mips/net/bpf_jit_comp.c     |  2 +-
 arch/parisc/net/bpf_jit_core.c   |  2 +-
 arch/powerpc/net/bpf_jit_comp.c  |  2 +-
 arch/riscv/net/bpf_jit_core.c    |  2 +-
 arch/s390/net/bpf_jit_comp.c     |  2 +-
 arch/sparc/net/bpf_jit_comp_64.c |  2 +-
 arch/x86/net/bpf_jit_comp.c      |  2 +-
 arch/x86/net/bpf_jit_comp32.c    |  2 +-
 include/linux/filter.h           |  2 +-
 kernel/bpf/core.c                |  6 ++++--
 kernel/bpf/verifier.c            | 21 +++++++++++++++------
 15 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
index e3628922c24a..146bc0606f18 100644
--- a/arch/arc/net/bpf_jit_core.c
+++ b/arch/arc/net/bpf_jit_core.c
@@ -1411,7 +1411,7 @@ static struct bpf_prog *do_extra_pass(struct bpf_prog *prog)
  * (re)locations involved that their addresses are not known
  * during the first run.
  */
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 {
 	vm_dump(prog);
 
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index deeb8f292454..81d6af62d47d 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -2142,7 +2142,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 {
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct bpf_binary_header *header;
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 70d7c89d3ac9..cf88f174a145 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1820,7 +1820,7 @@ struct arm64_jit_data {
 	struct jit_ctx ctx;
 };
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 {
 	int image_size, prog_size, extable_size, extable_align, extable_offset;
 	struct bpf_prog *tmp, *orig_prog = prog;
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index fa1500d4aa3e..437e5e1130a0 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1186,7 +1186,7 @@ static int validate_code(struct jit_ctx *ctx)
 	return 0;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 {
 	bool tmp_blinded = false, extra_pass = false;
 	u8 *image_ptr;
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index e355dfca4400..deb6bf7150bc 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -909,7 +909,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 {
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct bpf_binary_header *header = NULL;
diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_core.c
index 06cbcd6fe87b..0c74306cb392 100644
--- a/arch/parisc/net/bpf_jit_core.c
+++ b/arch/parisc/net/bpf_jit_core.c
@@ -41,7 +41,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 {
 	unsigned int prog_size = 0, extable_size = 0;
 	bool tmp_blinded = false, extra_pass = false;
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 2991bb171a9b..ede2462f3653 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -129,7 +129,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp, int *err)
 {
 	u32 proglen;
 	u32 alloclen;
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index f8cd2f70a7fb..11fa033ec666 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -42,7 +42,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 {
 	unsigned int prog_size = 0, extable_size = 0;
 	bool tmp_blinded = false, extra_pass = false;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 0776dfde2dba..3d875ff21362 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2255,7 +2255,7 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
 /*
  * Compile eBPF program "fp"
  */
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp, int *err)
 {
 	u32 stack_depth = round_up(fp->aux->stack_depth, 8);
 	struct bpf_prog *tmp, *orig_fp = fp;
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 73bf0aea8baf..0e5aa8535a27 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1477,7 +1477,7 @@ struct sparc64_jit_data {
 	struct jit_ctx ctx;
 };
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 {
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct sparc64_jit_data *jit_data;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9e5fe2ba858f..313e68414486 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3495,7 +3495,7 @@ struct x64_jit_data {
 #define MAX_PASSES 20
 #define PADDING_PASSES (MAX_PASSES - 5)
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 {
 	struct bpf_binary_header *rw_header = NULL;
 	struct bpf_binary_header *header = NULL;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index de0f9e5f9f73..628a96c12091 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2518,7 +2518,7 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 {
 	struct bpf_binary_header *header = NULL;
 	struct bpf_prog *tmp, *orig_prog = prog;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5cf4d35d83e..4652dc8d46a7 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1124,7 +1124,7 @@ u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 	((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
 	 (void *)__bpf_call_base)
 
-struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog, int *err);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba6b6118cf50..cbc973f9449f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2491,8 +2491,10 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 		if (*err)
 			return fp;
 
-		fp = bpf_int_jit_compile(fp);
+		fp = bpf_int_jit_compile(fp, err);
 		bpf_prog_jit_attempt_done(fp);
+		if (*err)
+			return fp;
 		if (!fp->jited && jit_needed) {
 			*err = -ENOTSUPP;
 			return fp;
@@ -2999,7 +3001,7 @@ const struct bpf_func_proto bpf_tail_call_proto = {
  * It is encouraged to implement bpf_int_jit_compile() instead, so that
  * eBPF and implicitly also cBPF can get JITed!
  */
-struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_prog *prog)
+struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_prog *prog, int *err)
 {
 	return prog;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..2e2956bacf4f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21074,10 +21074,11 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	if (err)
 		goto out_undo_insn;
 
-	err = -ENOMEM;
 	func = kcalloc(env->subprog_cnt, sizeof(prog), GFP_KERNEL);
-	if (!func)
+	if (!func) {
+		err = -ENOMEM;
 		goto out_undo_insn;
+	}
 
 	for (i = 0; i < env->subprog_cnt; i++) {
 		subprog_start = subprog_end;
@@ -21090,14 +21091,18 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		 * func[i]->stats will never be accessed and stays NULL
 		 */
 		func[i] = bpf_prog_alloc_no_stats(bpf_prog_size(len), GFP_USER);
-		if (!func[i])
+		if (!func[i]) {
+			err = -ENOMEM;
 			goto out_free;
+		}
 		memcpy(func[i]->insnsi, &prog->insnsi[subprog_start],
 		       len * sizeof(struct bpf_insn));
 		func[i]->type = prog->type;
 		func[i]->len = len;
-		if (bpf_prog_calc_tag(func[i]))
+		if (bpf_prog_calc_tag(func[i])) {
+			err = -ENOMEM;
 			goto out_free;
+		}
 		func[i]->is_func = 1;
 		func[i]->sleepable = prog->sleepable;
 		func[i]->aux->func_idx = i;
@@ -21154,7 +21159,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
-		func[i] = bpf_int_jit_compile(func[i]);
+		func[i] = bpf_int_jit_compile(func[i], &err);
+		if (err)
+			goto out_free;
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
 			goto out_free;
@@ -21198,7 +21205,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	}
 	for (i = 0; i < env->subprog_cnt; i++) {
 		old_bpf_func = func[i]->bpf_func;
-		tmp = bpf_int_jit_compile(func[i]);
+		tmp = bpf_int_jit_compile(func[i], &err);
+		if (err)
+			goto out_free;
 		if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {
 			verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
 			err = -ENOTSUPP;
-- 
2.49.0


