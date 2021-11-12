Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A847244E13E
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhKLFFj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhKLFFj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 00:05:39 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B093C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:49 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id k4so7458342plx.8
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPUfTonMe1OaYGeaf0KfBSxwXAs39e9TeqQw1e7hzWw=;
        b=Cudoqrx3mW/0JFJoL3gFaBEIQPoZHF5G0ofOC82vFL9MnjDIySIAcK5xPOPQd52/5y
         XRsgl5FTLNWi7JtiP59xALMVPZ4nrytiRquTz/rfZVzTTNCYniojbOOEKEulOzzxfWtD
         sF2oE3MAvbFheesFD7TkdSDy5SSRgH/i08UidOhjo4iq9eKdesrzp4ljLXj2eYFMOW94
         sKZxugrD2RFt0rYt1m6mYEYnp5JYD6nfzyQiPX9trJ7YwS4/KVbXEP03T582NK5VqjFX
         5oKmRqTuEhzFR5LXPAKr3Erv2tV+iVOqlCVfki7unytR1/4uNe5pUn24y92qRRJxjPWP
         cDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPUfTonMe1OaYGeaf0KfBSxwXAs39e9TeqQw1e7hzWw=;
        b=WD0lgmTWa7MHc1lhx315G0Qh3fU1xYzy4BHdQhZcBXyjC1N/3Dq81jA+KW6MPoElw8
         05cll9pKC4BFoCPiLxUpNqPUnsKHB5UkbcCgeUFCo2NduwYkx0GGLPlleerMM2AtRlKs
         YmeHvp463NtVhIUzXKcYK+ImdLcrRxfjlgnr+0i+c/Sco4wUE2FJzsqFY5RnZg6uMx/z
         ew07QweUzoSUONsPY4SsOyqv+hqbR+gL9E3vq94bxt+xBwh9DpA+lZCYWFTF+QjdhOYV
         AHoyMGQiNytBfRzJS2Z5CUb90pBrWQ+GMSlDGVtfTE+g5hqPcpHMZ490SpfpNHvrJUW5
         j05Q==
X-Gm-Message-State: AOAM533vNTSIv2KXwmwwzq0VPuKI9BmVZF8yE/O0+Jv6WPl1tKQPMRFm
        zHIZCDi85xebOOGR+2D9h1Swfwft+Ec=
X-Google-Smtp-Source: ABdhPJxLgT4rJ8HErRD+3q7djCU1LtbX0P1sqZVEQSCqAIz8aI02BYd4uHwxxAVMd7dgsd94TSsk0Q==
X-Received: by 2002:a17:903:1c3:b0:142:3ae:5c09 with SMTP id e3-20020a17090301c300b0014203ae5c09mr5018383plh.52.1636693368700;
        Thu, 11 Nov 2021 21:02:48 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:3dc4])
        by smtp.gmail.com with ESMTPSA id h3sm5319383pfi.207.2021.11.11.21.02.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Nov 2021 21:02:48 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 06/12] bpf: Add bpf_core_add_cands() and wire it into bpf_core_apply_relo_insn().
Date:   Thu, 11 Nov 2021 21:02:24 -0800
Message-Id: <20211112050230.85640-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/btf.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index efb7fa2f81a2..aeb591579282 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -25,6 +25,7 @@
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <net/sock.h>
+#include "../tools/lib/bpf/relo_core.h"
 
 /* BTF (BPF Type Format) is the meta data format which describes
  * the data types of BPF program/map.  Hence, it basically focus
@@ -6440,9 +6441,144 @@ size_t bpf_core_essential_name_len(const char *name)
 	return n;
 }
 
+static void bpf_core_free_cands(struct bpf_core_cand_list *cands)
+{
+	if (!cands)
+		return;
+        kfree(cands->cands);
+        kfree(cands);
+}
+
+static int bpf_core_add_cands(struct bpf_verifier_log *log,
+			      struct bpf_core_cand *local_cand,
+                              size_t local_essent_len,
+                              const struct btf *targ_btf,
+                              int targ_start_id,
+                              struct bpf_core_cand_list *cands)
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
+bpf_core_find_cands(struct bpf_verifier_log *log, const struct btf *local_btf, u32 local_type_id)
+{
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
+	err = bpf_core_add_cands(log, &local_cand, local_essent_len, main_btf, 1, cands);
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
+		err = bpf_core_add_cands(log, &local_cand, local_essent_len,
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
+}
+
 int bpf_core_relo_apply(struct bpf_verifier_log *log, const struct btf *btf,
 			const struct bpf_core_relo *relo, int relo_idx,
 			void *insn)
 {
-	return -EOPNOTSUPP;
+	struct bpf_core_cand_list *cands = NULL;
+	int err;
+
+	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
+		cands = bpf_core_find_cands(log, btf, relo->type_id);
+		if (IS_ERR(cands)) {
+			bpf_log(log, "target candidate search failed for %d\n",
+			       relo->type_id);
+                        return PTR_ERR(cands);
+                }
+	}
+	err = bpf_core_apply_relo_insn((void *)log, insn, relo->insn_off / 8,
+				       relo, relo_idx, btf, cands);
+	bpf_core_free_cands(cands);
+	return err;
 }
-- 
2.30.2

