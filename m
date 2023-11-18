Return-Path: <bpf+bounces-15284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF5F7EFCF6
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05F11F2785D
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 01:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF78C17DB;
	Sat, 18 Nov 2023 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4I1oyH5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27A3D6D
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso365799366b.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700271251; x=1700876051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w62LLoEjTXnkM+W53menCF5/ZkICA5xbRxjBHI/VULA=;
        b=l4I1oyH5Dkd19301VJlJ/m7crAKWL0OSAHmtEI4JaaxzVBeH4IX6NHPZonmL/lmyKv
         cOrhVBCFma7p+iumUzjr4OIglAdP+OfhCCmca16vyZ/+aBo1sZHlVxHeWYkOTIey4O5G
         j/jMGKqw7eU38oxM9+E8wFe3gKE9cfryAGNtCdnjtupVOnwSZpA5qDl/J5sJPP3WnEqE
         fSqWFickMxcodpcLGnCSPaoakKqgIHHyG8XHxfSI8MjPPzHad5aQZMPkUVsN6yzURKmY
         S4HCULBxDEx5oTkoZ/8IbBV/lYohxNBcE6y8zD4VsdHj7vBAjsoeXoatT5/hJ8x0v1wW
         WfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271251; x=1700876051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w62LLoEjTXnkM+W53menCF5/ZkICA5xbRxjBHI/VULA=;
        b=eoavifjgQsGIVRzLIVNNi/KHKRwcO8GeDBwl+B5NMvXkbjJeNhl+j9sf5nGj7xaHYN
         bF4kCyo0LfTylnBwrO3lvwu11zhQAE4WNT1f+jSTuSpgL5tBZA6tLJM0dd+N098BskS5
         IReEN8Qr2Xx1d1kk+gOCYJrcvBPxDdFajvfG0hEWFDPWSOrmy42OovU37RP7S9q1CZrj
         TOtfe67gVrTjHY5KHnXzftsxyb1U5klvXh6Y5oBwCAQv9aKOPy1Lx2w1pFz63Gso+nfm
         UkMrvUlm/7Gvh32PajJVnIJM+LS+4oubRN3TYApea9LlKle0aV10oOPAdn/pRjP79McP
         R73Q==
X-Gm-Message-State: AOJu0YwkTSv1QVKVPzxruA+oE3T8KkZIzaPo4A1W3Yt3Hbg9GX51jojg
	5F6ydyLTMZLExYj8jLpKryKzXlH4XRw=
X-Google-Smtp-Source: AGHT+IF0J4gKbmQivG2utFl1J0W5KB7kgbqWuQMzJp2gG2z3H/xoORV2bP9xFFja3YzsG7dhtCD5ZA==
X-Received: by 2002:a17:907:9384:b0:9e3:add9:438d with SMTP id cm4-20020a170907938400b009e3add9438dmr583895ejc.24.1700271250915;
        Fri, 17 Nov 2023 17:34:10 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm1359284ejq.33.2023.11.17.17.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 17:34:10 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v2 04/11] bpf: extract __check_reg_arg() utility function
Date: Sat, 18 Nov 2023 03:33:48 +0200
Message-ID: <20231118013355.7943-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118013355.7943-1-eddyz87@gmail.com>
References: <20231118013355.7943-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split check_reg_arg() into two utility functions:
- check_reg_arg() operating on registers from current verifier state;
- __check_reg_arg() operating on a specific set of registers passed as
  a parameter;

The __check_reg_arg() function would be used by a follow-up change for
callbacks handling.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7c3461b89513..ca54f738cfae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3586,13 +3586,11 @@ static void mark_insn_zext(struct bpf_verifier_env *env,
 	reg->subreg_def = DEF_NOT_SUBREG;
 }
 
-static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
-			 enum reg_arg_type t)
+static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *regs, u32 regno,
+			   enum reg_arg_type t)
 {
-	struct bpf_verifier_state *vstate = env->cur_state;
-	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_insn *insn = env->prog->insnsi + env->insn_idx;
-	struct bpf_reg_state *reg, *regs = state->regs;
+	struct bpf_reg_state *reg;
 	bool rw64;
 
 	if (regno >= MAX_BPF_REG) {
@@ -3633,6 +3631,15 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 	return 0;
 }
 
+static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
+			 enum reg_arg_type t)
+{
+	struct bpf_verifier_state *vstate = env->cur_state;
+	struct bpf_func_state *state = vstate->frame[vstate->curframe];
+
+	return __check_reg_arg(env, state->regs, regno, t);
+}
+
 static void mark_jmp_point(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].jmp_point = true;
@@ -9528,7 +9535,7 @@ static void clear_caller_saved_regs(struct bpf_verifier_env *env,
 	/* after the call registers r0 - r5 were scratched */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
-		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		__check_reg_arg(env, regs, caller_saved[i], DST_OP_NO_MARK);
 	}
 }
 
-- 
2.42.1


