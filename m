Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F5457AD0
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 04:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhKTDgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 22:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbhKTDgS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 22:36:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AA3C061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso12403847pji.0
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KLLz454IRnVZFbi69I8H8nscFxOh6BUtGV6EFfgWZI=;
        b=BeneOets/jOiB9KPVpPac0r0Bhh3DFJM5b03E2I8mQOMzW2K6Wc4KMkd+UAYV/Y2s8
         6tDF9KLcLwiaz9Ewj6kN2X9w0DuPxkDu0B7SWJH+MWAVzFRmQm7Frgeae17IGAcGHy4b
         D/DfMhqZb4864RzH+S1sfo9BR1NHgJrIU0NehWlq0+90YWrtOayEml+Hoxem1VBs/Lad
         SB7zBj5lrTUjV4N2kTzzF6xuqx+9LFgrCMQSfoz53/JztAjSKpK3kq3+o3ES9jclvmVH
         lR+rAfBu0qpjmm8OnKeviRd5Dk/XObdMU+x76xXLEn55gk5D5PuABtJlhvK+Vk/eEWfI
         IU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KLLz454IRnVZFbi69I8H8nscFxOh6BUtGV6EFfgWZI=;
        b=sJXTia0VG7qcN77/PCy1fV1DseY22/aWDs+O8t46H98thHvIHaA7ix961sKRCVJdj6
         9loEv1x5HnJ6ICmnRgJ0+wwB82Pd7tn6IM0SrD3VG+uYb1pfRaEtaOnXSgDiFCKdwd7l
         kaEFeV2mU7OahpPbquxVn7CU9btLFaUxpXn+8oFS8fIEeIN/Kh0jA0LBfmvYquBF9bZs
         I61Z6dt2pFluCDeJ9gUMHlwcMqa6P7rcTJyPrygH0/a6jtuhaH/OTZGRrDT7opistpdR
         CBZKfrhRPYCjvq7g6Ad2ogdQJFrFi8kmhXo7cowMpGkv7HTS7kWx4Hepte2OYUcYSmfZ
         IvoA==
X-Gm-Message-State: AOAM533eCR2epCczM79lEBncSYgwGCz8I4mNWko4Poq3uqscwZrl8pPk
        CAVgBBot4bdGa4ldYe99D6aZrvy3Lfk=
X-Google-Smtp-Source: ABdhPJxp02htRdpP40x5J1sB3O9C6cIA8rU4BwDLNXcBLUzJoo4SRnfrUyiuOr7FrTCM4FMPHKdPYQ==
X-Received: by 2002:a17:90b:1c07:: with SMTP id oc7mr6183502pjb.127.1637379195081;
        Fri, 19 Nov 2021 19:33:15 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:a858])
        by smtp.gmail.com with ESMTPSA id il7sm796786pjb.54.2021.11.19.19.33.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 19:33:14 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 06/13] bpf: Add bpf_core_add_cands() and wire it into bpf_core_apply_relo_insn().
Date:   Fri, 19 Nov 2021 19:32:48 -0800
Message-Id: <20211120033255.91214-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Given BPF program's BTF perform a linear search through kernel BTFs for
a possible candidate.
Then wire the result into bpf_core_apply_relo_insn().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5fd690ea04ea..8a87de8b33c2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -25,6 +25,7 @@
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <net/sock.h>
+#include "../tools/lib/bpf/relo_core.h"
 
 /* BTF (BPF Type Format) is the meta data format which describes
  * the data types of BPF program/map.  Hence, it basically focus
@@ -6440,12 +6441,145 @@ size_t bpf_core_essential_name_len(const char *name)
 	return n;
 }
 
+static void bpf_core_free_cands(struct bpf_core_cand_list *cands)
+{
+	if (!cands)
+		return;
+	kfree(cands->cands);
+	kfree(cands);
+}
+
 void bpf_core_finish(struct bpf_core_ctx *ctx)
 {
+	bpf_core_free_cands(ctx->cands);
+}
+
+static int bpf_core_add_cands(struct bpf_verifier_log *log,
+			      struct bpf_core_cand *local_cand,
+			      size_t local_essent_len, const struct btf *targ_btf,
+			      int targ_start_id, struct bpf_core_cand_list *cands)
+{
+	struct bpf_core_cand *new_cands, *cand;
+	const struct btf_type *t;
+	const char *targ_name;
+	size_t targ_essent_len;
+	int n, i;
+
+	n = btf_nr_types(targ_btf);
+	for (i = targ_start_id; i < n; i++) {
+		t = btf_type_by_id(targ_btf, i);
+		if (btf_kind(t) != btf_kind(local_cand->t))
+			continue;
+
+		targ_name = btf_name_by_offset(targ_btf, t->name_off);
+		if (str_is_empty(targ_name))
+			continue;
+
+		targ_essent_len = bpf_core_essential_name_len(targ_name);
+		if (targ_essent_len != local_essent_len)
+			continue;
+
+		if (strncmp(local_cand->name, targ_name, local_essent_len) != 0)
+			continue;
+
+		bpf_log(log,
+			"CO-RE relocating [%d] %s %s: found target candidate [%d] %s %s\n",
+			local_cand->id, btf_type_str(local_cand->t),
+			local_cand->name, i, btf_type_str(t), targ_name);
+		new_cands = krealloc(cands->cands,
+				     (cands->len + 1) * sizeof(*cands->cands), GFP_KERNEL);
+		if (!new_cands)
+			return -ENOMEM;
+
+		cand = &new_cands[cands->len];
+		cand->btf = targ_btf;
+		cand->t = t;
+		cand->name = targ_name;
+		cand->id = i;
+
+		cands->cands = new_cands;
+		cands->len++;
+	}
+	return 0;
+}
+
+static struct bpf_core_cand_list *
+bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
+{
+	const struct btf *local_btf = ctx->btf;
+	struct bpf_core_cand local_cand = {};
+	struct bpf_core_cand_list *cands;
+	const struct btf *main_btf;
+	size_t local_essent_len;
+	struct btf *mod_btf;
+	int err;
+	int id;
+
+	local_cand.btf = local_btf;
+	local_cand.t = btf_type_by_id(local_btf, local_type_id);
+	if (!local_cand.t)
+		return ERR_PTR(-EINVAL);
+
+	local_cand.name = btf_name_by_offset(local_btf, local_cand.t->name_off);
+	if (str_is_empty(local_cand.name))
+		return ERR_PTR(-EINVAL);
+	local_essent_len = bpf_core_essential_name_len(local_cand.name);
+
+	cands = kcalloc(1, sizeof(*cands), GFP_KERNEL);
+	if (!cands)
+		return ERR_PTR(-ENOMEM);
+
+	/* Attempt to find target candidates in vmlinux BTF first */
+	main_btf = bpf_get_btf_vmlinux();
+	err = bpf_core_add_cands(ctx->log, &local_cand, local_essent_len, main_btf, 1, cands);
+	if (err)
+		goto err_out;
+
+	/* if vmlinux BTF has any candidate, don't go for module BTFs */
+	if (cands->len)
+		return cands;
+
+	/* If candidate is not found in vmlinux's BTF then search in module's BTFs */
+	spin_lock_bh(&btf_idr_lock);
+	idr_for_each_entry(&btf_idr, mod_btf, id) {
+		if (!btf_is_module(mod_btf))
+			continue;
+		/* linear search could be slow hence unlock/lock
+		 * the IDR to avoiding holding it for too long
+		 */
+		btf_get(mod_btf);
+		spin_unlock_bh(&btf_idr_lock);
+		err = bpf_core_add_cands(ctx->log, &local_cand, local_essent_len,
+					 mod_btf, btf_nr_types(main_btf), cands);
+		if (err) {
+			btf_put(mod_btf);
+			goto err_out;
+		}
+		spin_lock_bh(&btf_idr_lock);
+		btf_put(mod_btf);
+	}
+	spin_unlock_bh(&btf_idr_lock);
+
+	return cands;
+err_out:
+	bpf_core_free_cands(cands);
+	return ERR_PTR(err);
 }
 
 int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		   int relo_idx, void *insn)
 {
-	return -EOPNOTSUPP;
+	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
+		struct bpf_core_cand_list *cands;
+
+		cands = bpf_core_find_cands(ctx, relo->type_id);
+		if (IS_ERR(cands)) {
+			bpf_log(ctx->log, "target candidate search failed for %d\n",
+				relo->type_id);
+			return PTR_ERR(cands);
+		}
+		ctx->cands = cands;
+	}
+	return bpf_core_apply_relo_insn((void *)ctx->log, insn, relo->insn_off / 8,
+					relo, relo_idx, ctx->btf, ctx->cands);
 }
-- 
2.30.2

