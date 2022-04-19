Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F18507586
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 18:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350189AbiDSQuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355264AbiDSQsu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 12:48:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA2BA1AF
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:46:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n18so16323913plg.5
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c37MbpGfpC1y4eNNQMlHO6tqIhjoG56may+GPEi+dm4=;
        b=oh5Td1tgE17EaZkGSZChrYn9bAcqSeAdgKYWjZpWs3VDzH7o5N9FoMrE+VVlmEMtp9
         UMCftI9DGCZa+WT5pp315j9jAU52ZUe6NYnRVZNa0IHFNt+CWiubW74cXCQA+lQKknp0
         LGftrxk43h2xvzpIqwBFSfon+4+hxd5j3Wb/QpN4YiKWQtkgjKDHN5oTHZPLfWcSrk1I
         6U0DZEi46nNvSaQ9ZW4K95WngwPL9b4mE1QlOrfOHls6kJgcfgy6hWBgirafcwedkTE0
         XJjxtlaP3mM/XvphJdMy3ISdWwWDqUZAnJ7/RO7PiUgVlFsrSM3hT2Vui+RQwdgRumpd
         xTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c37MbpGfpC1y4eNNQMlHO6tqIhjoG56may+GPEi+dm4=;
        b=UKph6XNXFeO6K1TWD/J/0rhy44kkNmOHezIffq8dsOTrRhNgKUVbfvhQCIGBZEHFBn
         kv7DcKiaHZGlWn0mHv30SvSpQr+j7Rp63sRubxUVhqJm9oAGzL2VCCKULrtJgs2EqM8d
         7AFI25wOppg4zb6pVb3rtvpAS7sklUmXdjtNkKfwJyCK1slfN0rc3M5/xqS0WMzINqCE
         4BOsxaM+FWRx8PxoqZETLIEPCKZfFZ+/iCngR7T2S1utMmQb1uNKeFx3tvDWNgyMBmU9
         MALIkQytIRXtD0/rnlb97XztjuVbTkYLN4jLHvgUDX+SlcIc0IMz5PpsshfqIx1fmDK+
         xTSw==
X-Gm-Message-State: AOAM532/m1fMTGzIBWCG1divAtwZgDF92WbdaeKMp87hquRj3EdrMaKB
        UWyHugnmSzTNXKAHdg3rJ4xySsiKDJMmqA==
X-Google-Smtp-Source: ABdhPJzrmvZL26I4GlcBaO0M3zcAcj1f1ErTGm21V/sUFNefJxRae5s/dhOz3I5hlNYIkSMuJb0e8A==
X-Received: by 2002:a17:902:7c8c:b0:156:5651:1d51 with SMTP id y12-20020a1709027c8c00b0015656511d51mr16280826pll.107.1650386765480;
        Tue, 19 Apr 2022 09:46:05 -0700 (PDT)
Received: from localhost ([112.79.142.99])
        by smtp.gmail.com with ESMTPSA id j63-20020a636e42000000b003987df110edsm17029903pgc.42.2022.04.19.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:46:05 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 1/2] bpf: Ensure type tags precede modifiers in BTF
Date:   Tue, 19 Apr 2022 22:16:07 +0530
Message-Id: <20220419164608.1990559-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419164608.1990559-1-memxor@gmail.com>
References: <20220419164608.1990559-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3389; h=from:subject; bh=kNw2vpeZ9j26B4cnJsLM50Uud66R0+M5Q8ZUCQNxMs0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiXucwnlb5ZojaUdpKOWgyfGj6RtEeO5Zq/9zOcU/q rDCaiD6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYl7nMAAKCRBM4MiGSL8Rysj8D/ 9nRBNjGTmzFFsPNcUvwvHk+5lRGjqKokZ/1nV38cTlFFX7xCJww1b3DOEGieUxu0Jksa+qTOb30dPW SgYs7HGqN78nOJpZD+d/lYki3TZHCa3/9DFy5jSmb2E5y00u09aYGd6Lkoss/FqAJCN/QRusT3RnRP AwXEtg1GoUbijiWJgSTlBbCowKE5byJHUNNbdEZHw4rCbkPiVgE68+unVTjNBkhQ7ZIKQ8CRKga/B0 rq8Wi37aSNwWbPAa9rIteTFx3326csZwYC37lD2A3Zj+5q4Yxb14yjbB+mdTmxBWBeYeUyM6/84T0y Znn2C8q1KjiAxAgHt9nQ2P1Y0/OR9QqrMnByMkzIhlvhY1b4Ur38rEBo+pf9M7hgiX65z7G6ksbJi+ r5J4wzW6uBwMAKaQWsMLtqjiPgAqIjbIwDzahKqi17eeZbNbINb47aIdUZSJpEu7LrxF86xbDKMzLX TeG6gEIdokzFQMtqrjG+7aeGrr1VPYIePmPR+baWY5FxgKor8rO6tnvcv9mjHaQbnAzGnN8mI8FOIz m3BAXSVhq4R2pSvry0mtUViZUEbPQkVdaSxxPA59ftbb1CC0op+c/M9rb6AVmZQ9/4DLwEvg6RnDG9 QcMB2gqoh7ePFrU0zwzHtTndO97XTDDomr5VXZAUrWeZ7s2wxCl6Sfe3VZBw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is guaranteed that for modifiers, clang always places type tags
before other modifiers, and then the base type. We would like to rely on
this guarantee inside the kernel to make it simple to parse type tags
from BTF.

However, a user would be allowed to construct a BTF without such
guarantees. Hence, add a pass to check that in modifier chains, type
tags only occur at the head of the chain, and then don't occur later in
the chain.

If we see a type tag, we can have one or more type tags preceding other
modifiers that then never have another type tag. If we see other
modifiers, all modifiers following them should never be a type tag.

Instead of having to walk chains we verified previously, we can remember
the last good modifier type ID which headed a good chain. At that point,
we must have verified all other chains headed by type IDs less than it.
This makes the verification process less costly, and it becomes a simple
O(n) pass.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0918a39279f6..7906b9bf7ff8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4541,6 +4541,48 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 	return 0;
 }
 
+static int btf_check_type_tags(struct btf_verifier_env *env,
+			       struct btf *btf, int start_id)
+{
+	int i, n, good_id = start_id - 1;
+	bool in_tags;
+
+	n = btf_nr_types(btf);
+	for (i = start_id; i < n; i++) {
+		const struct btf_type *t;
+		u32 cur_id = i;
+
+		t = btf_type_by_id(btf, i);
+		if (!t)
+			return -EINVAL;
+		if (!btf_type_is_modifier(t))
+			continue;
+
+		cond_resched();
+
+		in_tags = btf_type_is_type_tag(t);
+		while (btf_type_is_modifier(t)) {
+			if (btf_type_is_type_tag(t)) {
+				if (!in_tags) {
+					btf_verifier_log(env, "Type tags don't precede modifiers");
+					return -EINVAL;
+				}
+			} else if (in_tags) {
+				in_tags = false;
+			}
+			if (cur_id <= good_id)
+				break;
+			/* Move to next type */
+			cur_id = t->type;
+			t = btf_type_by_id(btf, cur_id);
+			if (!t)
+				return -EINVAL;
+		}
+		good_id = i;
+	}
+	return 0;
+}
+
 static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 			     u32 log_level, char __user *log_ubuf, u32 log_size)
 {
@@ -4608,6 +4650,10 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	if (err)
 		goto errout;
 
+	err = btf_check_type_tags(env, btf, 1);
+	if (err)
+		goto errout;
+
 	if (log->level && bpf_verifier_log_full(log)) {
 		err = -ENOSPC;
 		goto errout;
@@ -4809,6 +4855,10 @@ struct btf *btf_parse_vmlinux(void)
 	if (err)
 		goto errout;
 
+	err = btf_check_type_tags(env, btf, 1);
+	if (err)
+		goto errout;
+
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 
@@ -4894,6 +4944,10 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
 	if (err)
 		goto errout;
 
+	err = btf_check_type_tags(env, btf, btf_nr_types(base_btf));
+	if (err)
+		goto errout;
+
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
-- 
2.35.1

