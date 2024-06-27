Return-Path: <bpf+bounces-33270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2211891AC2D
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 18:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D181C22839
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E419925F;
	Thu, 27 Jun 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxYdcrAO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B591991C8
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504284; cv=none; b=EOqL05CKbBW2Kjr2CiWLoX1N0vTF9AnEKZBqZZg9FZOx1kwRv+rvx3NY3c1U28mVI3KCJS41TvWYcRU9x3ARtJxg8F6p9N62iAHAklQ5PI5hKdq6v/wUhbFbXK2Mj49oZKomx/9GKrIbvhwSkQsubqfk4RdRsqeXOUqGZfHlAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504284; c=relaxed/simple;
	bh=+xg+eevwCWNy89yxtQRq2r+EP1xcUe3bwgIph/PpJKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8KX40CPBBnX3LBD7rlTKXxCIt3NZNXR4DoHZ2MEeCWKXfS+m38+bWqCjBzAi4DSeHum/7EgQvXIVyyi/lcYYdfTmKEXEI4e0ybA+2vzXlhNrqnoVRMVfM1ui4Qa3+bj7qcjMSnrO6a/8QN0OITKHPWclhRuhjUYKjIfr0Z6U7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxYdcrAO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719504280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IHtUPZptzkhMFmEd2WdOkD9spo21pG/I1JXLQ6QiKXg=;
	b=TxYdcrAOrSp/T1hWjBSDyclnRC5OMtGcBER4Wsr7lp4sVP+8KdK/O1Ge4/Soa1anzESpt2
	nJDWbh4/Pu4A5poqgZBVK41w8dbhg5WNDOeTYlfE1qSXriWyfD4Vur4fa1/iWCLNm2SYKl
	YDSAKRTUuQylzd1wyJrM6mgmRkO9iRI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-NlcjFHhrMRadlitg845r3g-1; Thu,
 27 Jun 2024 12:04:38 -0400
X-MC-Unique: NlcjFHhrMRadlitg845r3g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 895D21956096;
	Thu, 27 Jun 2024 16:04:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0FAB319560A3;
	Thu, 27 Jun 2024 16:04:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 27 Jun 2024 18:03:01 +0200 (CEST)
Date: Thu, 27 Jun 2024 18:02:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Jiri Olsa <jolsa@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: [PATCH] LoongArch: uprobes: make UPROBE_SWBP_INSN/UPROBE_XOLBP_INSN
 constant
Message-ID: <20240627160255.GA25374@redhat.com>
References: <20240618194306.1577022-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618194306.1577022-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

LoongArch defines UPROBE_SWBP_INSN as a function call and this breaks
arch_uprobe_trampoline() which uses it to initialize a static variable.

Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20240614174822.GA1185149@thelio-3990X/
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/loongarch/include/asm/uprobes.h | 6 ++++--
 arch/loongarch/kernel/uprobes.c      | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/uprobes.h b/arch/loongarch/include/asm/uprobes.h
index c8f59983f702..18221eb9a8b0 100644
--- a/arch/loongarch/include/asm/uprobes.h
+++ b/arch/loongarch/include/asm/uprobes.h
@@ -6,13 +6,15 @@
 
 typedef u32 uprobe_opcode_t;
 
+#define __emit_break(imm)	(uprobe_opcode_t)((imm) | (break_op << 15))
+
 #define MAX_UINSN_BYTES		8
 #define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
 
-#define UPROBE_SWBP_INSN	larch_insn_gen_break(BRK_UPROBE_BP)
+#define UPROBE_SWBP_INSN	__emit_break(BRK_UPROBE_BP)
 #define UPROBE_SWBP_INSN_SIZE	LOONGARCH_INSN_SIZE
 
-#define UPROBE_XOLBP_INSN	larch_insn_gen_break(BRK_UPROBE_XOLBP)
+#define UPROBE_XOLBP_INSN	__emit_break(BRK_UPROBE_XOLBP)
 
 struct arch_uprobe {
 	unsigned long	resume_era;
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



