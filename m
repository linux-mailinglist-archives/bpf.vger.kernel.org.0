Return-Path: <bpf+bounces-46382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8479E9E901E
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 11:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6B718867C4
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 10:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DE8216E18;
	Mon,  9 Dec 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="NCVlobjx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676FD2165E2
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740064; cv=none; b=F3NvAGln4ge0EEOjBK5XNnJpsD1lzPrU+lmYDz+JZzd2P9zx36tQc1Q5ef35a9n9xWWzPMmSe/mOOV0fWp5rPIblxpIZrqxsUZrklvl6OHh6itCOtHIiCNkuZ2VHzNeIkyVckWvnFo8YCD/rFX6vg3SDWSAbyYdisJN0iQy/6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740064; c=relaxed/simple;
	bh=00Uk25wg3i/5m/wChr5F0tQBpW3hRxacXEYnxuYIlas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSa8OmJ0XdoRrvD3qsfM+2y6C4vS48jd015x5m8fOQ+M39TOKRwh8GEEOka5gMWwUZPgWPR2q++IcueAiDr7GH4BlmvQENucogM6F4EyHVCW0yqpHwyRVZkxPhPCwcTkUCZKPeIG9j8Urwqa3TkY+MlgZik1gPRw1NviOcIa5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=NCVlobjx; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-aa692211331so78444166b.1
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 02:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733740060; x=1734344860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlbmGQfq5G0Ubrvzqhqf2rrKqpF4uuetJtxlL0wc5KU=;
        b=NCVlobjxWeoK5/MGu7N8YOzaWiLNkdtZM0w/vTX9TtOqg5VylY9w7EBLvQnJIrcaD4
         GS64m6X7wlCTbKh0rdVWhodznrAVY1FW+eiB9ZTYiNu9NFz8QOEzD5hCvdz4bNHVTN2R
         agKygfvfzUHG1GGhP1aZZwezLSnHpxYLZlyOnWNAKu2zEPgYtWCkx3t6XYrSrMCCFk9Z
         XNexYcdzfutIfKBU1Nk5QgG1K82aCCJkB1TrWuM4AKHTPfagllapJOruGgTH3LilsMmD
         +x6cSY37GGGKqqUL73Bz0595kYa6oS/4c+jVDjgM+4CqHhqqHlwck+4OIrZP+o7Z6Agp
         tp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733740060; x=1734344860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlbmGQfq5G0Ubrvzqhqf2rrKqpF4uuetJtxlL0wc5KU=;
        b=vFHWt4qphFgXZ/DvpsH7S92jBHQtOBKRuu1U4zCHJqXri7dPiM80SRzGDaBn3+V7QU
         EATeAjCOOen1+EQ/sc4p/c5maYMso/s8cNEuwhARvTtu50iuBgLbnre1VWfH7MOhP+2K
         fdxKH7HdT7/HHFrKRJkfTWx8fo2jMs9jTDtOkyEaRrrEA/EdRB+iwcvT42PxRsHkaPPJ
         My0LkW7dMwL/Wl590TOPT6500rRYp2AIs6MHJNRDFLpY4fwX803ahOW7+tbL5ECSK5u3
         Emr8m0usxyxwJWZRH2fSonNR4K+ngLARbInNp5Mj8n1QCp8oK4QRyasy8a/Q2YL9hegA
         DQkQ==
X-Gm-Message-State: AOJu0YyogqeG7twXgy0CI7ko92/DtQbiktypuc5uSdH4KqoC/nwKfdhM
	nL3/XI82o5EAiHtpgocXiLpz9YWs6FkhRGE5UVbwMquBD/Xq1JSGr3N+lYK+62OuJ8yxyzCozdy
	lUEgqBg==
X-Gm-Gg: ASbGncvzJlKpUBtHlG87HvOC+l4LEfiYIyNh/TqQTgUNLhPE5eBeRXn+30VudSS5R9P
	DttqZy9Fs1D+FOOXw9+BKF4k/0xsL8COo1oDlo5BktBtFMn3Jb32AOoV4Ao67WbONkSgUo/t8vg
	0SbDMkSbGYO6E4qJBip7lh9RVtNRqVzT3gRCx94xpXhWGwLmOAvRomzoozkjdl9Jye2a2QBxLaL
	SfHpxcoERCJPURO3Wf8GB1Tp76ttS42cpO8h1O35dZoRw1/SMZUASDhkmqRFGv/ThzXksMuh8Er
	p0bdB8W6IxICa7ygBQ==
X-Google-Smtp-Source: AGHT+IHcLHiW+i3C4vfdNuvKS+CP4hGPAHH5qHxTGtBKQQYaHHQCG09yfEgJph3hMLJevcgwyxZYFw==
X-Received: by 2002:a17:907:d86:b0:aa5:340a:fb48 with SMTP id a640c23a62f3a-aa6202e0911mr1605911666b.6.1733740060554;
        Mon, 09 Dec 2024 02:27:40 -0800 (PST)
Received: from simagnan-ThinkPad-X1-Carbon-Gen-10.. ([87.13.127.164])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa6873814d4sm134849566b.54.2024.12.09.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:27:40 -0800 (PST)
From: Simone Magnani <simone.magnani@isovalent.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	Simone Magnani <simone.magnani@isovalent.com>
Subject: [PATCH bpf-next] bpftool: Probe for ISA v4 instruction set extension
Date: Mon,  9 Dec 2024 11:26:44 +0100
Message-ID: <20241209102644.29880-1-simone.magnani@isovalent.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new probe to check whether the kernel supports
instruction set extensions v4. The v4 extension comprises several new
instructions: BPF_{SDIV,SMOD} (signed div and mod), BPF_{LD,LDX,ST,STX,MOV}
(sign-extended load/store/move), 32-bit BPF_JA (unconditional jump),
target-independent BPF_ALU64 BSWAP (byte-swapping 16/32/64). These have
been introduced in the following commits respectively:

* ec0e2da ("bpf: Support new signed div/mod instructions.")
* 1f9a1ea ("bpf: Support new sign-extension load insns")
* 8100928 ("bpf: Support new sign-extension mov insns")
* 4cd58e9 ("bpf: Support new 32bit offset jmp instruction")
* 0845c3d ("bpf: Support new unconditional bswap instruction")

Support in bpftool for previous ISA extensions were added in commit
0fd800b2 ("bpftool: Probe for instruction set extensions"). These probes
are useful for userspace BPF projects that want to use newer
instruction set extensions on newer kernels, to reduce the programs'
sizes or their complexity. LLVM provides the mcpu=v4 option since commit
"[BPF] support for BPF_ST instruction in codegen"
(https://github.com/llvm/llvm-project/commit/8f28e8069c4ba1110daee8bddc4d5049b6d4646e).

Signed-off-by: Simone Magnani <simone.magnani@isovalent.com>
---
 tools/bpf/bpftool/feature.c  | 23 +++++++++++++++++++++++
 tools/include/linux/filter.h | 10 ++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 4dbc4fcdf473..24fecdf8e430 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -885,6 +885,28 @@ probe_v3_isa_extension(const char *define_prefix, __u32 ifindex)
 			   "V3_ISA_EXTENSION");
 }

+/*
+ * Probe for the v4 instruction set extension introduced in commit 1f9a1ea821ff
+ * ("bpf: Support new sign-extension load insns").
+ */
+static void
+probe_v4_isa_extension(const char *define_prefix, __u32 ifindex)
+{
+	struct bpf_insn insns[5] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
+		BPF_JMP32_A(1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN()
+	};
+
+	probe_misc_feature(insns, ARRAY_SIZE(insns),
+			   define_prefix, ifindex,
+			   "have_v4_isa_extension",
+			   "ISA extension v4",
+			   "V4_ISA_EXTENSION");
+}
+
 static void
 section_system_config(enum probe_component target, const char *define_prefix)
 {
@@ -1029,6 +1051,7 @@ static void section_misc(const char *define_prefix, __u32 ifindex)
 	probe_bounded_loops(define_prefix, ifindex);
 	probe_v2_isa_extension(define_prefix, ifindex);
 	probe_v3_isa_extension(define_prefix, ifindex);
+	probe_v4_isa_extension(define_prefix, ifindex);
 	print_end_section();
 }

diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index 65aa8ce142e5..a2962fc56f27 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -75,6 +75,16 @@
 		.off   = 0,					\
 		.imm   = LEN })

+/* Unconditional jumps, gotol pc + imm32 */
+
+#define BPF_JMP32_A(IMM)					\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP32 | BPF_JA,			\
+		.dst_reg = 0,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = IMM })
+
 /* Short form of mov, dst_reg = src_reg */

 #define BPF_MOV64_REG(DST, SRC)					\
--
2.43.0


