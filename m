Return-Path: <bpf+bounces-11923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9BF7C5811
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9D0282516
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73198208B1;
	Wed, 11 Oct 2023 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNBepDMk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B4208B5
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:27:44 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C457EA7
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 08:27:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso5571988a12.3
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697038060; x=1697642860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrBauvKnpQmGwaYtS0oLVEa+f631MCY7UMeKdwZ8kPo=;
        b=DNBepDMkwds4HiWbh+VTYKY9SW1Y8Hj1oFT0pzJ7bSND9SFY/sTikBfMZp7ZYtXKND
         9Za/mPj5kX67J1WwGcv9Nso0tcIVcdR5A74Ohf6BILulAvgU2DDw5eu+eqPy9vdMDmSr
         Ise6AKPVcQNl7jnuQHanlJXXIIhKK3DiJHmxSrkqUatdNAvbI5dlaauHQ61yPvWurYme
         mpKsa3xiqcsxbvIRr6TcthHZMawd7xaAy2yOePAYN7ggvWK/kymtJRGP53jjkUjpbt31
         7maq3vwrhanwUcnvAtG/yYOFR0nnrOeALAMPbS0bZ8BhdJGpWnt9NRJy2JMMISKKmLLp
         YrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697038060; x=1697642860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrBauvKnpQmGwaYtS0oLVEa+f631MCY7UMeKdwZ8kPo=;
        b=rQecFpoihV2JGhCGfqhGJ4WhO/Pa5zUQFvvxM4kyKd6sOj1xA9zKHuPRQI41SMzBsU
         13DJJ14TCZ7W8In2LE6q271mtY5Z8pKgpefZ6ZctK+pUHP4znRFoWdiIksTYigWHBz8O
         uCauf3HTK2xoUE9kx/hE501IgrHvAKrt40a30SjQn7CSh1XjRU5+0T16z9Bh7Nj/47U4
         aeersWbLd0MZqD8/oFnv6T5yAcc+tefrs7TcMiSesdW/8QhBt5D3w0H7gPiuPFp8GLUi
         wGj0R3uQxEbZuRMheWdCLsF0YmA+K4ulb6sFwa/TJeA9sLVWwUNPagX6XX0lUK+gILVc
         R9qg==
X-Gm-Message-State: AOJu0YycEEWVocZIfgw7+MBfsyF24XKUZabhpcANXu8Zsl/+U96ilH1h
	QBu+/36XdZtKqV9gSdXaugDTSHYHyIcPBg==
X-Google-Smtp-Source: AGHT+IEsctwEnNd/NjHHDKnpe40uzAtP9W0sJsZL9D9EtQ6SNOefQw1mNwWcF/hQlfFouaodA7qvFw==
X-Received: by 2002:a05:6a20:2447:b0:154:3f13:1bb7 with SMTP id t7-20020a056a20244700b001543f131bb7mr24200440pzc.49.1697038059744;
        Wed, 11 Oct 2023 08:27:39 -0700 (PDT)
Received: from localhost.localdomain (bb119-74-148-123.singnet.com.sg. [119.74.148.123])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b001c755810f89sm14092070plb.181.2023.10.11.08.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:27:39 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	iii@linux.ibm.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com
Subject: [RFC PATCH bpf-next v2 1/4] bpf, x64: Emit nops for X86_PATCH
Date: Wed, 11 Oct 2023 23:27:22 +0800
Message-ID: <20231011152725.95895-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011152725.95895-1-hffilwlqm@gmail.com>
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For next commit to reuse emit_nops(), move emit_nops() before
emit_prologue().

By the way, change memcpy(prog, x86_nops[5], X86_PATCH_SIZE) to
emit_nops(&prog, X86_PATCH_SIZE).

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 41 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9abc2394..c2a0465d37da4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -304,6 +304,25 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
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
  * Emit x86-64 prologue code for BPF program.
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
@@ -319,8 +338,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
 	EMIT_ENDBR();
-	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
-	prog += X86_PATCH_SIZE;
+	emit_nops(&prog, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog)
 			/* When it's the entry of the whole tailcall context,
@@ -989,25 +1007,6 @@ static void detect_reg_usage(struct bpf_insn *insn, int insn_cnt,
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
-- 
2.41.0


