Return-Path: <bpf+bounces-33432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F391CDB6
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 17:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3D2282D69
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 15:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7857782866;
	Sat, 29 Jun 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Elb1kVmq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5C824A0
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719673505; cv=none; b=JVo5vfKCrWf2imfG3+HbwLN7+A0vrpu6ioJAQnR62c4SSgDtBd7x6cHqZYmz9EOWzYTvN1GRaZZEiZ6FyK6Obb3LUxt4/rMqFXp8/7pPF3LfhtoTSc58qI82z7XYjdJYRcaTAalCmIdR8rMDzJO9imArW5mfiRju7RPtgLsUqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719673505; c=relaxed/simple;
	bh=2DTQmWqH/wkMk/0O7Leu0Bu0zxHmvBJSnT2Q6y4GAuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCIm08SVrljTxcaSJpqdZWR4nXFQ8a2UjFTEdd/MYuksC9LQGvjSAFjfxs21hFHjVpRpp4EK9+Jxw18pZDUBgfMLthn4biV1adewzL4Yy0Y4KNSETqT6cEGMK3rg1YirjF/splx4jLQcYrKSpph5otMTdb9CzCpr3GRFtwwfKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Elb1kVmq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719673502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk4NhAj11FnmgdfVKtJg7NJBjEggdWwUsCGnQLGSY70=;
	b=Elb1kVmqCK/zEwzG02UIGQDUS79Ojgg/7D+xybVz3IcCOkrYkL+/G3qrCEtVBBHwMVu+ea
	/J4GJAFH1BbqTNs3zS3SnrnB6ItBokrwAKuvSLKDEqIJEQkv4gBKHMs0TV+lvWQtw1rpaQ
	z6Pqph+Xoo2prkPLSJLnYf2VnWjV2UU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-xzfP7Ds6Np29icu3_sB1Nw-1; Sat,
 29 Jun 2024 11:04:58 -0400
X-MC-Unique: xzfP7Ds6Np29icu3_sB1Nw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9B0719560AA;
	Sat, 29 Jun 2024 15:04:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.39.192.76])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3892B19560AA;
	Sat, 29 Jun 2024 15:04:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 29 Jun 2024 17:03:21 +0200 (CEST)
Date: Sat, 29 Jun 2024 17:03:14 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, andrii.nakryiko@gmail.com,
	andrii@kernel.org, bpf@vger.kernel.org, jolsa@kernel.org,
	kernel@xen0n.name, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	mhiramat@kernel.org, nathan@kernel.org, rostedt@goodmis.org
Subject: [PATCH] LoongArch: make the users of larch_insn_gen_break() constant
Message-ID: <20240629150313.GB4504@redhat.com>
References: <20240627173806.GC21813@redhat.com>
 <37f79351-a051-3fa9-7bfb-960fb2762e27@loongson.cn>
 <20240629133747.GA4504@redhat.com>
 <CAAhV-H4tCrTuWJa88JE96N93U2O_RUsnA6WAAUMOWR6EzM9Mzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4tCrTuWJa88JE96N93U2O_RUsnA6WAAUMOWR6EzM9Mzw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

LoongArch defines UPROBE_SWBP_INSN as a function call and this breaks
arch_uprobe_trampoline() which uses it to initialize a static variable.

Add the new "__builtin_constant_p" helper, __emit_break(), and redefine
the current users of larch_insn_gen_break() to use it.

The patch adds check_emit_break() into kprobes.c and uprobes.c to test
this change. They can be removed if LoongArch boots at least once, but
otoh these 2 __init functions will be discarded by free_initmem().

Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20240614174822.GA1185149@thelio-3990X/
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/loongarch/include/asm/inst.h    |  3 +++
 arch/loongarch/include/asm/uprobes.h |  4 ++--
 arch/loongarch/kernel/kprobes.c      | 12 ++++++++++--
 arch/loongarch/kernel/uprobes.c      |  8 ++++++++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index c3993fd88aba..944482063f14 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -532,6 +532,9 @@ static inline void emit_##NAME(union loongarch_instruction *insn,	\
 
 DEF_EMIT_REG0I15_FORMAT(break, break_op)
 
+/* like emit_break(imm) but returns a constant expression */
+#define __emit_break(imm)	((u32)((imm) | (break_op << 15)))
+
 #define DEF_EMIT_REG0I26_FORMAT(NAME, OP)				\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
 			       int offset)				\
diff --git a/arch/loongarch/include/asm/uprobes.h b/arch/loongarch/include/asm/uprobes.h
index c8f59983f702..99a0d198927f 100644
--- a/arch/loongarch/include/asm/uprobes.h
+++ b/arch/loongarch/include/asm/uprobes.h
@@ -9,10 +9,10 @@ typedef u32 uprobe_opcode_t;
 #define MAX_UINSN_BYTES		8
 #define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
 
-#define UPROBE_SWBP_INSN	larch_insn_gen_break(BRK_UPROBE_BP)
+#define UPROBE_SWBP_INSN	__emit_break(BRK_UPROBE_BP)
 #define UPROBE_SWBP_INSN_SIZE	LOONGARCH_INSN_SIZE
 
-#define UPROBE_XOLBP_INSN	larch_insn_gen_break(BRK_UPROBE_XOLBP)
+#define UPROBE_XOLBP_INSN	__emit_break(BRK_UPROBE_XOLBP)
 
 struct arch_uprobe {
 	unsigned long	resume_era;
diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
index 17b040bd6067..78cfaac52748 100644
--- a/arch/loongarch/kernel/kprobes.c
+++ b/arch/loongarch/kernel/kprobes.c
@@ -4,8 +4,16 @@
 #include <linux/preempt.h>
 #include <asm/break.h>
 
-#define KPROBE_BP_INSN		larch_insn_gen_break(BRK_KPROBE_BP)
-#define KPROBE_SSTEPBP_INSN	larch_insn_gen_break(BRK_KPROBE_SSTEPBP)
+#define KPROBE_BP_INSN		__emit_break(BRK_KPROBE_BP)
+#define KPROBE_SSTEPBP_INSN	__emit_break(BRK_KPROBE_SSTEPBP)
+
+static __init int check_emit_break(void)
+{
+	BUG_ON(KPROBE_BP_INSN      != larch_insn_gen_break(BRK_KPROBE_BP));
+	BUG_ON(KPROBE_SSTEPBP_INSN != larch_insn_gen_break(BRK_KPROBE_SSTEPBP));
+	return 0;
+}
+arch_initcall(check_emit_break);
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe);
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
diff --git a/arch/loongarch/kernel/uprobes.c b/arch/loongarch/kernel/uprobes.c
index 87abc7137b73..90462d94c28f 100644
--- a/arch/loongarch/kernel/uprobes.c
+++ b/arch/loongarch/kernel/uprobes.c
@@ -7,6 +7,14 @@
 
 #define UPROBE_TRAP_NR	UINT_MAX
 
+static __init int check_emit_break(void)
+{
+	BUG_ON(UPROBE_SWBP_INSN  != larch_insn_gen_break(BRK_UPROBE_BP));
+	BUG_ON(UPROBE_XOLBP_INSN != larch_insn_gen_break(BRK_UPROBE_XOLBP));
+	return 0;
+}
+arch_initcall(check_emit_break);
+
 int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
 			     struct mm_struct *mm, unsigned long addr)
 {
-- 
2.25.1.362.g51ebf55



