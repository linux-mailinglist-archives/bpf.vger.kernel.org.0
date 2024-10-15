Return-Path: <bpf+bounces-42019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0220799E646
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 13:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18811F217EF
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F71F7084;
	Tue, 15 Oct 2024 11:39:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1781F12E4;
	Tue, 15 Oct 2024 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992367; cv=none; b=Nv7hQWYtCALyfB84jajHugKIb5Yp4TRNLy5ABgR2a/+2jcmOxdUPF4L4AWcfHsJiEngPH2fbbvGCA8PNbxmC+Ozvs7Nw+RHgorYNveoe7vm43ZJCbUW2RNRIhA86GobPD3GedONO85sBGuhjXiadUqmHo29CSpnpZSAOdTkOQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992367; c=relaxed/simple;
	bh=rr0nWEYrqLlVaPbZ9c1h3jCsPjkNEijFpvF3AjTKWk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaz3hhUTwnSlNxLsXOkAHzP6e5PFSyFI3jouAPJ1tOD5u1ubWRB8AwPmdim7f1BkYLeGVfGbl0ikOatDh7yXlcJiLNlDMVmwjr6hyqXwTwBy/fpor7ACdjbTYZyeD7pzSx8Sf744rIBjKol+Z5pIYhYOhhbAfSIzdh+lCKAk/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx44hpVA5nAIAdAA--.42657S3;
	Tue, 15 Oct 2024 19:39:21 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front2 (Coremail) with SMTP id qciowMCxbcdkVA5n6E0uAA--.9583S8;
	Tue, 15 Oct 2024 19:39:21 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] objtool/LoongArch: Add support for goto table
Date: Tue, 15 Oct 2024 19:39:15 +0800
Message-ID: <20241015113915.12623-7-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241015113915.12623-1-yangtiezhu@loongson.cn>
References: <20241015113915.12623-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMCxbcdkVA5n6E0uAA--.9583S8
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFWktry3tF13Ar4UZryfZrc_yoW8GFykpa
	13C3s8Kw45XrWxKr13tay8uFy3Aa1xW3W2grWIkr93Zw43XF4rtF1SvF98tFWxWw4rtr4I
	qrs5Kr15AF1UA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jz2NtUUUUU=

If find_reloc_by_table_annotate() failed, it means that there
is no relocation info of switch table address in the section
".rela.discard.tablejump_annotate", then objtool can find the
relocation against the nearest instruction before the jump
instruction with find_reloc_by_dest_range(), which points to
the goto table.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/special.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loongarch/special.c
index 65b1ed297d57..d2a6071d772f 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -47,8 +47,18 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	unsigned long table_offset;
 
 	annotate_reloc = find_reloc_by_table_annotate(file, insn);
-	if (!annotate_reloc)
-		return NULL;
+	if (!annotate_reloc) {
+		annotate_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+							  insn->offset, insn->len);
+		if (!annotate_reloc)
+			return NULL;
+
+		if (!annotate_reloc->sym->sec->rodata)
+			return NULL;
+
+		if (reloc_type(annotate_reloc) != R_LARCH_NONE)
+			return NULL;
+	}
 
 	table_sec = annotate_reloc->sym->sec;
 	table_offset = annotate_reloc->sym->offset;
-- 
2.42.0


