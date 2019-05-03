Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7499612BC8
	for <lists+bpf@lfdr.de>; Fri,  3 May 2019 12:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfECKoY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 May 2019 06:44:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52353 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfECKnx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 May 2019 06:43:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id y26so1392892wma.2
        for <bpf@vger.kernel.org>; Fri, 03 May 2019 03:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=URszv7/t7QfVZUhW0Uggw2iCKFbU+bZsnFS6vq2iMu0=;
        b=gCmkMzLq+4d8OMDZcK3SuIIpZzR7oeVaJw1sj/oswdNSztjGHDJdTDhaLkww9nT4dL
         9+WJL2XdIvGLmai/O07m6j8g3hXTwNsZMYRnBXXF1s8MJImuA8YwS1bt831ocV0hlN/U
         PUmFXJOkD7avuNBCmmhI8yrvjZ42ErTMLpPFSpGG29YmjKwBXtK/tqFkd4dsSP/m6bgN
         yxDu2mD+SHVPjbp0mZJacf/wRTHoQ7WK1GzLm0FnWppH83zHw6RQvVoGXRZeE1OcqhFW
         3DaLc4AvbAy0EVGveDplOuOlcsd2ANlhBjNtz9UOnO6qz9pIZ02IN0eJnemhyd/LzZdH
         /Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=URszv7/t7QfVZUhW0Uggw2iCKFbU+bZsnFS6vq2iMu0=;
        b=RtAB+lc3SV90Bf5PSaCi8O6/jQGatfT7/KJ//iI3aTQLNkbY3SzRy8CUA/5klwp05n
         QQ/4Bjn+chvi2uCqS2xsgdBQKxEM0KhjA2D9zYpDE9gLbcggJ6qJX0pLlf3azDCxa1ac
         nadANQS93i/qfSNCe1hmP1UT/bQA6Eq0B0ajo9/tWnqZFHDaKRcMCNXbG7sVWkWQ5q8N
         YRc3TTqUDS/C14+tkDkuCBk92kjyaRo+u2Z/37veSczIyuW1cRiBCmLru2LTaWtjYB5v
         yDy4VSJIrNcd9qYGWqZDDxdsaviHIvkQxAxISzQm9PCoJW2NR71LFN/99AjNGprN1oJT
         fD8A==
X-Gm-Message-State: APjAAAUWpCD0ZTY3fxoTFobBAEfcffwWI0pEGYsv4dYtK9uxpVNZi8Sv
        Xx0EIEyfQ7EqI+rHI2sADRd8Lg==
X-Google-Smtp-Source: APXvYqx5/wFlr9efZAyheV4bxwliZnPxzHL3nwMdWviqU7NPlMuG8DD6eBF70unGFB1L8YoYasXbUg==
X-Received: by 2002:a1c:f901:: with SMTP id x1mr5987805wmh.136.1556880230835;
        Fri, 03 May 2019 03:43:50 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id r29sm1716999wra.56.2019.05.03.03.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 May 2019 03:43:49 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v6 bpf-next 07/17] bpf: verifier: randomize high 32-bit when BPF_F_TEST_RND_HI32 is set
Date:   Fri,  3 May 2019 11:42:34 +0100
Message-Id: <1556880164-10689-8-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556880164-10689-1-git-send-email-jiong.wang@netronome.com>
References: <1556880164-10689-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch randomizes high 32-bit of a definition when BPF_F_TEST_RND_HI32
is set.

It does this once the flag set no matter there is hardware zero extension
support or not. Because this is a test feature and we want to deliver the
most stressful test.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 69 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 999da02..31ffbef 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7648,32 +7648,79 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static int opt_subreg_zext_lo32(struct bpf_verifier_env *env)
+static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
+					 const union bpf_attr *attr)
 {
+	struct bpf_insn *patch, zext_patch[2], rnd_hi32_patch[4];
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int i, patch_len, delta = 0, len = env->prog->len;
 	struct bpf_insn *insns = env->prog->insnsi;
-	int i, delta = 0, len = env->prog->len;
-	struct bpf_insn zext_patch[2];
 	struct bpf_prog *new_prog;
+	bool rnd_hi32;
+
+	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
 
 	zext_patch[1] = BPF_ALU32_IMM(BPF_ZEXT, 0, 0);
+	rnd_hi32_patch[1] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
+	rnd_hi32_patch[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
+	rnd_hi32_patch[3] = BPF_ALU64_REG(BPF_OR, 0, BPF_REG_AX);
 	for (i = 0; i < len; i++) {
 		int adj_idx = i + delta;
 		struct bpf_insn insn;
 
-		if (!aux[adj_idx].zext_dst)
+		insn = insns[adj_idx];
+		if (!aux[adj_idx].zext_dst) {
+			u8 code, class;
+			u32 imm_rnd;
+
+			if (!rnd_hi32)
+				continue;
+
+			code = insn.code;
+			class = BPF_CLASS(code);
+			if (insn_no_def(&insn))
+				continue;
+
+			/* NOTE: arg "reg" (the fourth one) is only used for
+			 *       BPF_STX which has been ruled out in above
+			 *       check, it is safe to pass NULL here.
+			 */
+			if (is_reg64(env, &insn, insn.dst_reg, NULL, DST_OP)) {
+				if (class == BPF_LD &&
+				    BPF_MODE(code) == BPF_IMM)
+					i++;
+				continue;
+			}
+
+			/* ctx load could be transformed into wider load. */
+			if (class == BPF_LDX &&
+			    aux[adj_idx].ptr_type == PTR_TO_CTX)
+				continue;
+
+			imm_rnd = get_random_int();
+			rnd_hi32_patch[0] = insn;
+			rnd_hi32_patch[1].imm = imm_rnd;
+			rnd_hi32_patch[3].dst_reg = insn.dst_reg;
+			patch = rnd_hi32_patch;
+			patch_len = 4;
+			goto apply_patch_buffer;
+		}
+
+		if (bpf_jit_hardware_zext())
 			continue;
 
-		insn = insns[adj_idx];
 		zext_patch[0] = insn;
 		zext_patch[1].dst_reg = insn.dst_reg;
-		new_prog = bpf_patch_insn_data(env, adj_idx, zext_patch, 2);
+		patch = zext_patch;
+		patch_len = 2;
+apply_patch_buffer:
+		new_prog = bpf_patch_insn_data(env, adj_idx, patch, patch_len);
 		if (!new_prog)
 			return -ENOMEM;
 		env->prog = new_prog;
 		insns = new_prog->insnsi;
 		aux = env->insn_aux_data;
-		delta += 2;
+		delta += patch_len - 1;
 	}
 
 	return 0;
@@ -8533,10 +8580,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	/* do 32-bit optimization after insn patching has done so those patched
 	 * insns could be handled correctly.
 	 */
-	if (ret == 0 && !bpf_jit_hardware_zext() &&
-	    !bpf_prog_is_dev_bound(env->prog->aux)) {
-		ret = opt_subreg_zext_lo32(env);
-		env->prog->aux->verifier_zext = !ret;
+	if (ret == 0 && !bpf_prog_is_dev_bound(env->prog->aux)) {
+		ret = opt_subreg_zext_lo32_rnd_hi32(env, attr);
+		env->prog->aux->verifier_zext =
+			bpf_jit_hardware_zext() ? false : !ret;
 	}
 
 	if (ret == 0)
-- 
2.7.4

