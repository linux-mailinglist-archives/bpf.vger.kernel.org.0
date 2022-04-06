Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64B14F550C
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 07:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359399AbiDFFZj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 01:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354500AbiDFEmc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 00:42:32 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290961B84F2
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 17:41:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d185so787551pgc.13
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 17:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNIkX0cIxSTx1cEGWiPXk1sRwkxti5aN0q8XCwmOdVs=;
        b=BQ3mlkcqgMmWN75B7yBnykBtkfW2mEIjJZzSw3vB7d6CaYDZ2SybGUxBSjAFyTGoP8
         MInLYKr+MVRnD6uNkJrtKFTNyBtSY1WtBtp8ANsJefxp2qBogEHpXfB/b9cVgU77yxRS
         wFpVUqHa/dWTdqCtuG2bufxhxfgF8RS68OK/9mGYTHpBDc2tVRPfyh3XmMb4SCUd0cre
         kVJh83h5Bz9DW1F/RyF6yz88Qi6IcoTLThDfYDAbfMDyZdDrfNFZ/hO/wvxLVUpenqKo
         WBqdq1ohxBzRU/93ucoVanNiLYrbuFeLE/kZlzzkwJp5mLDy+WNJKP7XZ5GCR4irwf2c
         Bjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNIkX0cIxSTx1cEGWiPXk1sRwkxti5aN0q8XCwmOdVs=;
        b=AseqTRksyyMSVdF383z3oYVxzdPd18armpCZf9mxR17qUmAHhtmy5qjn3+et9KeCQn
         5hz4czD04Cid0MjDzOgctjBnNocpczjfL9ZXw3/GL2BNwdeJklGf7+lFdivFhF8CyhJF
         TEdgi0qM2PBVsrkPlFrJHywiOZMi0/g+ANoa9W1cxRSbI3N0z9o4nudX8JOIkfY0uhFL
         0dypFbZYZxd0H6M7QhxvKi6aGIsPTbk/TDYrrMzZV9kE+h7dVwePPPmeY1J2aRKYzpC3
         utfAwsGypdbGxUs10AcVyugFFQDLW+j55jCFJSiXr5hrMYwv7N9GZkiZTWABHqK7dZeb
         CZJQ==
X-Gm-Message-State: AOAM5331kHKgcbvwlWCPb0L5Uxvoy6hBCoh9enQwPLj8CUYg8qp8Y5o3
        IFW9bqzPX5s73o7hVYzEMjIJ6XDH0n5jwg==
X-Google-Smtp-Source: ABdhPJz+komkEUBZzriD9xwWZrWqZ3pHzgygOww8SokPJgvbkV45bGaYhCVWA26bUqdYA9pvoMXA3A==
X-Received: by 2002:a63:5317:0:b0:399:58e9:882b with SMTP id h23-20020a635317000000b0039958e9882bmr5003470pgb.306.1649205691829;
        Tue, 05 Apr 2022 17:41:31 -0700 (PDT)
Received: from localhost ([112.79.140.207])
        by smtp.gmail.com with ESMTPSA id z2-20020aa79902000000b004fb05c04b53sm17795392pff.103.2022.04.05.17.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 17:41:31 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 1/2] bpf: Ensure type tags precede modifiers in BTF
Date:   Wed,  6 Apr 2022 06:11:20 +0530
Message-Id: <20220406004121.282699-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406004121.282699-1-memxor@gmail.com>
References: <20220406004121.282699-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3281; h=from:subject; bh=J/cmcMe/JMBC1AyOKGN0Jr2OdkeowJ/jpyva+PhQfQw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiTOGSBpnvBG/guav7uNTAxHj7muG1Zo16nnRskmaJ B6npiYOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYkzhkgAKCRBM4MiGSL8RyqsnEA CPoE3x9CpuNZ4qZRhUbx4AIFffesoVy0OtFKJip4DOy78DxjQFEZyjCIN/K3lIx4O/QV7BowfMMtk5 9InfyYHFBqqymQMuQha3dl3Lh8PVVWiDsWnNoBvPaI4Cl4/CiquvKh1cWgEP8Mr3lyrpW3QTUfSuxI TfJT92zo98Ox9zvhbo7jdRfXR1BxNjD0Bry55Cs2Y0I/CSY3MK34/ZjvsfLSsZWUOm0FtO7KDtZNha v8j7bxJfnVqwuBJLM4Yvw+2fzD7zLXdtxpl/kJXSGasyDvDe867dhDQXgJR9Q12VSO959sCCfb29Si 4j+TyWD1cAqExFuIxGRmdPJ8sPIZbzByccNhvhL4qVRyFFjia2V7/yd0y95dbDzGPD2J5XLLnlKXGb TOYA8bGKyvNpW2E/jtX3WOmDsQHUgAaDLRc/LJamhTHjwDNZW5UBI3TqAdoMcCo/SpZ5ip6bO29KHK YSn0Q+t7Sl3PCY5BTGYFGMRmnV6Yf4sy9It2QX8QJjUMH0epDd4mlg7R2TB5z6o77J6pngTKjYq2HM lGMlwPEijlZVQ4s6rpQCcPZ0iWznDWW/8cc0VD+LCbg8+bC0/X9UJukDVWdHYGWmJaFQLMwcCN/8DJ aYUhZN3PmoKLWJ9wHcrvbeveOVcjNw/SzcFyFHsY31n2qT03wdBdiKMok+kA==
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0918a39279f6..4a73f5b8127e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4541,6 +4541,45 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
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
+			if (t->type <= good_id)
+				break;
+			t = btf_type_by_id(btf, t->type);
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
@@ -4608,6 +4647,10 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	if (err)
 		goto errout;
 
+	err = btf_check_type_tags(env, btf, 1);
+	if (err)
+		goto errout;
+
 	if (log->level && bpf_verifier_log_full(log)) {
 		err = -ENOSPC;
 		goto errout;
@@ -4809,6 +4852,10 @@ struct btf *btf_parse_vmlinux(void)
 	if (err)
 		goto errout;
 
+	err = btf_check_type_tags(env, btf, 1);
+	if (err)
+		goto errout;
+
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 
@@ -4894,6 +4941,10 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
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

