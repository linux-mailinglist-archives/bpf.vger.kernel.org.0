Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428454100FC
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhIQV67 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbhIQV67 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:58:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FBBC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so4634378pjb.4
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3xdfnAhPeYsJW3K728i6NRwxfey9R4TXFFFF030MORg=;
        b=RaVReRh38Sv5RdK4IKeWQB3P4y/KTQ07BUNFpLSyCxAPk6c5a+XYoCJZpYGob2jMqW
         o9wg9cuEWRbwJbXU8643Q+6B3omoI2en5EOZiwAnnudjU4ljeNvdfJDI5hsOGBrpXqjW
         sJLI58iDPPBk8ZxmeLVG6VAUKaUKs1g/5jhGStxSv79EUH7r46W6rL1R4EWTghtJuJJ1
         VuBXXiXYzFIZMr7hJBkG0a6klLWm6fKnJ3HjJIWCJSgTfIyffQO8NsmdyruZUxoKxEIY
         f9NbMw2KMmJRKmqYOcXQL+PDKg2IzSawlgyo4Wmy180iyaHP9/D8xbmCeUYr1H4nr6Ox
         HaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xdfnAhPeYsJW3K728i6NRwxfey9R4TXFFFF030MORg=;
        b=PsFO906jksLr132xXJkqbkyL4vWh6kdFZRn7vvcG1iotfI1yFXmOGlGDQv2gR9d2TN
         2VcX1nFMOBTfjIILNGsbMDzwdQoAIneha1n9gxEJUhSBuaJxdy8EDUW9S0P1ty81LSFW
         Cg0YfPvFp3BScM/bXnP0MZqqU5MMGmey5jp0HUOzbiea8vehbQstdC0hkQU7EZocG5Ck
         +nuIXoG52jDAPcZzlHxmxLlCJkLzyMUee3QOIcuSCxFVhEaZmJOCe5WlUy8kNtWXe0CK
         M4qiojnRKy3259IU40oZboiJfgLyrkvNBwhWE0heTNbaSuPTQ6Q5BMWvwm60QYCdfiPK
         YYxQ==
X-Gm-Message-State: AOAM5302IpEy9qfYtQoSJPJvk71xB5GCxQOpVNIazHig3wW1tyb0GYlQ
        y3eiE5oCzrAR3YwYS3TgZDTz72LNyDg=
X-Google-Smtp-Source: ABdhPJzzg1fSF6ZUCiOjQiTYaGfnfmHMnZYsrAbjOUpJY99UvNDZhlicYpGF6cmRPiH9ezxg3fM5iQ==
X-Received: by 2002:a17:902:9689:b0:138:d2ac:44f with SMTP id n9-20020a170902968900b00138d2ac044fmr11508381plp.85.1631915856218;
        Fri, 17 Sep 2021 14:57:36 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::6:db29])
        by smtp.gmail.com with ESMTPSA id cm5sm6610863pjb.24.2021.09.17.14.57.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 14:57:35 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        lmb@cloudflare.com, mcroce@microsoft.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC bpf-next 04/10] bpf: Add bpf_core_add_cands() and wire it into bpf_core_apply_relo_insn().
Date:   Fri, 17 Sep 2021 14:57:15 -0700
Message-Id: <20210917215721.43491-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/btf.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9bb1247346ce..e04b5e669d12 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -25,6 +25,7 @@
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <net/sock.h>
+#include "../tools/lib/bpf/relo_core.h"
 
 /* BTF (BPF Type Format) is the meta data format which describes
  * the data types of BPF program/map.  Hence, it basically focus
@@ -6370,15 +6371,159 @@ size_t bpf_core_essential_name_len(const char *name)
 	return n;
 }
 
+static void bpf_core_free_cands(struct bpf_core_cand_list *cands)
+{
+        kfree(cands->cands);
+        kfree(cands);
+}
+
+static int bpf_core_add_cands(struct bpf_core_cand *local_cand,
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
+		t = btf__type_by_id(targ_btf, i);
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
+/*		printk("CO-RE relocating [%d] %s %s: found target candidate [%d] %s %s\n",
+		       local_cand->id, btf_type_str(local_cand->t),
+		       local_cand->name, i, btf_type_str(t), targ_name);*/
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
+bpf_core_find_cands(const struct btf *local_btf, u32 local_type_id)
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
+	local_cand.t = btf__type_by_id(local_btf, local_type_id);
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
+	err = bpf_core_add_cands(&local_cand, local_essent_len, main_btf, 1, cands);
+	if (err)
+		goto err_out;
+
+	/* if vmlinux BTF has any candidate, don't got for module BTFs */
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
+		err = bpf_core_add_cands(&local_cand, local_essent_len,
+					 mod_btf,
+					 btf_nr_types(main_btf),
+					 cands);
+		if (err)
+			btf_put(mod_btf);
+		goto err_out;
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
 BPF_CALL_5(bpf_core_apply_relo, int, btf_fd, struct bpf_core_relo_desc *, relo,
 	   int, relo_sz, void *, insn, int, flags)
 {
+	struct bpf_core_cand_list *cands = NULL;
+	struct bpf_core_relo core_relo = {};
 	struct btf *btf;
-	long ret;
+	int err;
 
 	if (flags)
 		return -EINVAL;
-	return -EOPNOTSUPP;
+
+	if (sizeof(*relo) != relo_sz)
+		return -EINVAL;
+	btf = btf_get_by_fd(btf_fd);
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+	if (btf_is_kernel(btf)) {
+		btf_put(btf);
+		return -EACCES;
+	}
+	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
+		cands = bpf_core_find_cands(btf, relo->type_id);
+		if (IS_ERR(cands)) {
+			btf_put(btf);
+			printk("target candidate search failed for %d\n",
+			       relo->type_id);
+                        return PTR_ERR(cands);
+                }
+	}
+	core_relo.type_id = relo->type_id;
+	core_relo.access_str_off = relo->access_str_off;
+	core_relo.kind = relo->kind;
+	err = bpf_core_apply_relo_insn("prog_name", insn, 0, &core_relo, 0, btf, cands);
+	btf_put(btf);
+	return 0;
 }
 
 const struct bpf_func_proto bpf_core_apply_relo_proto = {
-- 
2.30.2

