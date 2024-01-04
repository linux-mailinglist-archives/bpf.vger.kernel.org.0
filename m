Return-Path: <bpf+bounces-19025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D6F8243A7
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 15:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DB0283458
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFD2224FE;
	Thu,  4 Jan 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL1nCyqd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840F7224E3
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28c9d424cceso360546a91.0
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 06:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704378186; x=1704982986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ7lDyfIT+vign2NgNFpx2bbU589QIKd3RiKfIK/eXI=;
        b=aL1nCyqdgTg/AMoAh+RhjkEg3g6kdNOT+LUBEJTGO+FwOsMOzvOkpsOHHINkN2xay9
         uP9Zw4j9iDmc7vHxNDsW2PcNQeYlsoswTr0qdifWFoaMJ+HG08rVFbYdMSVE1PjJmKDK
         qyXV61cEbbCFdYz9J4XamOBQjDe5BGxt8FMpKLSlsgPEI7hqtxUlXGTlbwYCohePA//x
         aFG3iHH0Ca4GZYgthEMysU9T00GLBgQB5zCzfEpUbeGrc4SLp8cC9zjBcEW4ylkWi9bL
         gzMH55RiBWlb6fBI1M6tEihzRFG6mv5qomMiPjWbFgYj9mU3ZMBO/4/abR0XfyVTHnO4
         ukVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704378186; x=1704982986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ7lDyfIT+vign2NgNFpx2bbU589QIKd3RiKfIK/eXI=;
        b=Agg5qtQqIMioBIJ84T86tr2eInl3KKGonfbhpgbR/iFGy4e5PErqr6PMH9anCgeKX+
         u8Dmz5f6nWrn+KH04vBKmxRhh179bb6MotCOXiwdK+alXn3IG2jXltiSTdq62ayjARmO
         B4pId71/3F7pCReNT6aUUWxltpWR7BAM84268mSIwKyUzOF/awtciwD3hG8hRdwz2aTs
         oQJdbwQrnAeQ1AeAQ9Dofjn/nAUnwvBP9Xratb1a4v/A3c8MhFPWKvnEkPMyoKvzP1hV
         L7ZBTkV5yTj0iqx+HL6WdClWCqYjY/UG3JtNB79fIMqzef/oRt7Vmfj5Hzw7TdWJ3kmk
         c23g==
X-Gm-Message-State: AOJu0Yz15CdAaUreoToLguXm4SKNivI06asK3Ptz0X8qKHslsIWvc49v
	jfK/+Rd1oqfM0cuRJZbSxImwARs8Lpo=
X-Google-Smtp-Source: AGHT+IHurWuZz3EHCSi6055kTvq08kZ7uIIlV3xU+0F/yS2bFfBHSF03lN+opSSpjF9JBaBSB7VDug==
X-Received: by 2002:a17:90a:9a92:b0:28c:18a:9b20 with SMTP id e18-20020a17090a9a9200b0028c018a9b20mr702771pjp.6.1704378185908;
        Thu, 04 Jan 2024 06:23:05 -0800 (PST)
Received: from localhost.localdomain (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090a020a00b0028cb82a8da0sm4081507pjc.31.2024.01.04.06.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:23:05 -0800 (PST)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	iii@linux.ibm.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/4] bpf, x64: Use emit_nops() to replace memcpy()'ing x86_nops[5]
Date: Thu,  4 Jan 2024 22:22:23 +0800
Message-ID: <20240104142226.87869-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240104142226.87869-1-hffilwlqm@gmail.com>
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For next commit to reuse emit_nops(), move emit_nops() before
emit_prologue().

By the way, replace all memcpy(prog, x86_nops[5], X86_PATCH_SIZE) with
emit_nops(&prog, X86_PATCH_SIZE).

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 47 +++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index bdacbb84456d9..fe30b9ebb8de4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -307,6 +307,25 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
 	*pprog = prog;
 }
 
+static void emit_nops(u8 **pprog, int len)
+{
+	u8 *prog = *pprog;
+	int i, noplen;
+
+	while (len > 0) {
+		noplen = len;
+
+		if (noplen > ASM_NOP_MAX)
+			noplen = ASM_NOP_MAX;
+
+		for (i = 0; i < noplen; i++)
+			EMIT1(x86_nops[noplen][i]);
+		len -= noplen;
+	}
+
+	*pprog = prog;
+}
+
 /*
  * Emit the various CFI preambles, see asm/cfi.h and the comments about FineIBT
  * in arch/x86/kernel/alternative.c
@@ -385,8 +404,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
-	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
-	prog += X86_PATCH_SIZE;
+	emit_nops(&prog, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog)
 			/* When it's the entry of the whole tailcall context,
@@ -692,8 +710,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
 
-	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
-	prog += X86_PATCH_SIZE;
+	emit_nops(&prog, X86_PATCH_SIZE);
 
 	/* out: */
 	ctx->tail_call_direct_label = prog - start;
@@ -1055,25 +1072,6 @@ static void detect_reg_usage(struct bpf_insn *insn, int insn_cnt,
 	}
 }
 
-static void emit_nops(u8 **pprog, int len)
-{
-	u8 *prog = *pprog;
-	int i, noplen;
-
-	while (len > 0) {
-		noplen = len;
-
-		if (noplen > ASM_NOP_MAX)
-			noplen = ASM_NOP_MAX;
-
-		for (i = 0; i < noplen; i++)
-			EMIT1(x86_nops[noplen][i]);
-		len -= noplen;
-	}
-
-	*pprog = prog;
-}
-
 /* emit the 3-byte VEX prefix
  *
  * r: same as rex.r, extra bit for ModRM reg field
@@ -2700,8 +2698,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 		im->ip_after_call = image + (prog - (u8 *)rw_image);
-		memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
-		prog += X86_PATCH_SIZE;
+		emit_nops(&prog, X86_PATCH_SIZE);
 	}
 
 	if (fmod_ret->nr_links) {
-- 
2.42.1


