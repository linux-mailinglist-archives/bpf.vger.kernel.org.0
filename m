Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DD826A2C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 20:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfEVSzx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 14:55:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40529 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfEVSzw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 14:55:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id f10so3477354wre.7
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WvolCAZHYDvaiAYPxomdmAQHiIl1pgEJcOAEMTx9MPg=;
        b=x304nVrc2CQT79PBpF8/gnDr4xFOm6Q/YqYGjuCOjpMQOU/0PH/JbrR6ymzJVSeP6m
         XFf7qIYFXudNK/MiYOE1ts+QuBo/TrkOh8VBYps003qdENz096FED/Tuvpz7G2Gcjg0R
         X4uxMCWPtg83CSPJH8a7OCemB8ha7fqhJJxIpbecmGpGMvLKx27jTPCo41P8CMpZ37G6
         yR01u49WmM1rwCcPNPhs/4R/MFqhgWLEq9xcdA/VuHGDs8x9cGv5+T7If7jZ+333s9Je
         1EuOyTXfgY8e7jMgaRg84vulBpVrne98aY2JHL9AMVTxXJhgW0otK1vSzHq9ovoxuAtS
         sfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WvolCAZHYDvaiAYPxomdmAQHiIl1pgEJcOAEMTx9MPg=;
        b=aAYZShEAgYf4Zja6JKIx+lobOr+Dta+vmLaAVa7ZT7nih+++Q4uPM01B0wsfZ7rs/1
         BD+9yAkJaUzzx4Afzq/RyLR6nIO8B7IMKsW7tpnBVzKjWOnHdMxkQh5bYvcHwAH7X7ft
         yGpn0hb/kObKFY5IxEvRkwP/gPKohvhPFjdbz8rKapSfkeDW6B/T/dCiBCDsvZ60w+Y9
         OeTaIs8KVT6O7Hmlp77eZBuoVAwuXHirzrlwZGxlPSxGYbrS4Aqr1zrxh2/mMUmG7oG7
         SFIUqgFi+FZMeo4pG1AGDyPZ1REnPPyxmVMNnQ6F52WJT2rqAd2tcJVU/mxT5Clir65h
         Fg4Q==
X-Gm-Message-State: APjAAAVoz7AW0gDVmh5arcH0wTWB8Rvo2e//HNgTVFlnQdv+Do4boSL1
        ZsOUGGlFg0LYxqggXAIxympVqQ==
X-Google-Smtp-Source: APXvYqyPQDP0TNVhKTt5MK2oy4uKTcOttnRv6JCB4gQVUmy4GILSfxR9R4iUxST24QGuSxWFiZ0KBw==
X-Received: by 2002:a5d:4946:: with SMTP id r6mr5106106wrs.310.1558551351365;
        Wed, 22 May 2019 11:55:51 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id t12sm16328801wro.2.2019.05.22.11.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 May 2019 11:55:50 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v7 bpf-next 02/16] bpf: verifier: mark patched-insn with sub-register zext flag
Date:   Wed, 22 May 2019 19:54:58 +0100
Message-Id: <1558551312-17081-3-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558551312-17081-1-git-send-email-jiong.wang@netronome.com>
References: <1558551312-17081-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Patched insns do not go through generic verification, therefore doesn't has
zero extension information collected during insn walking.

We don't bother analyze them at the moment, for any sub-register def comes
from them, just conservatively mark it as needing zero extension.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 kernel/bpf/verifier.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0efccf8..16d8ed9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1268,6 +1268,24 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return true;
 }
 
+/* Return TRUE if INSN doesn't have explicit value define. */
+static bool insn_no_def(struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+
+	return (class == BPF_JMP || class == BPF_JMP32 ||
+		class == BPF_STX || class == BPF_ST);
+}
+
+/* Return TRUE if INSN has defined any 32-bit value explicitly. */
+static bool insn_has_def32(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	if (insn_no_def(insn))
+		return false;
+
+	return !is_reg64(env, insn, insn->dst_reg, NULL, DST_OP);
+}
+
 static void mark_insn_zext(struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg)
 {
@@ -7279,14 +7297,23 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
  * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
  * [0, off) and [off, end) to new locations, so the patched range stays zero
  */
-static int adjust_insn_aux_data(struct bpf_verifier_env *env, u32 prog_len,
-				u32 off, u32 cnt)
+static int adjust_insn_aux_data(struct bpf_verifier_env *env,
+				struct bpf_prog *new_prog, u32 off, u32 cnt)
 {
 	struct bpf_insn_aux_data *new_data, *old_data = env->insn_aux_data;
+	struct bpf_insn *insn = new_prog->insnsi;
+	u32 prog_len;
 	int i;
 
+	/* aux info at OFF always needs adjustment, no matter fast path
+	 * (cnt == 1) is taken or not. There is no guarantee INSN at OFF is the
+	 * original insn at old prog.
+	 */
+	old_data[off].zext_dst = insn_has_def32(env, insn + off + cnt - 1);
+
 	if (cnt == 1)
 		return 0;
+	prog_len = new_prog->len;
 	new_data = vzalloc(array_size(prog_len,
 				      sizeof(struct bpf_insn_aux_data)));
 	if (!new_data)
@@ -7294,8 +7321,10 @@ static int adjust_insn_aux_data(struct bpf_verifier_env *env, u32 prog_len,
 	memcpy(new_data, old_data, sizeof(struct bpf_insn_aux_data) * off);
 	memcpy(new_data + off + cnt - 1, old_data + off,
 	       sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
-	for (i = off; i < off + cnt - 1; i++)
+	for (i = off; i < off + cnt - 1; i++) {
 		new_data[i].seen = true;
+		new_data[i].zext_dst = insn_has_def32(env, insn + i);
+	}
 	env->insn_aux_data = new_data;
 	vfree(old_data);
 	return 0;
@@ -7328,7 +7357,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 				env->insn_aux_data[off].orig_idx);
 		return NULL;
 	}
-	if (adjust_insn_aux_data(env, new_prog->len, off, len))
+	if (adjust_insn_aux_data(env, new_prog, off, len))
 		return NULL;
 	adjust_subprog_starts(env, off, len);
 	return new_prog;
-- 
2.7.4

