Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8511E62E19F
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbiKQQ0h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbiKQQ0W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:22 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C0F7C037
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:24:57 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id p21so2077235plr.7
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RMgIjgVJe7MVFByUyYDinpCRIIO51b3eQdv64g3mNU=;
        b=IKcOc1zf+1U4eRg6dkT9svKpohnADu/IbNud6YKzLZGof/HhIfSKvdkW2Pb+Q4SEcc
         vDEE7/uMedqZHceBXY9AG31GAQp4cgOlEdqxZNIbAHx8HCR9vAPTbR2guMDOqtTGfoIi
         jDhHlmcR5KVoo0bE6muzu4MFuOHMncYuyYnkckhO1+3HLeAWwSox+9JyAroYTSO+ODYr
         zn8XMLeWiwL6i625Xab8V3MznuR1gt3n/oZiuC6d1pDeLjN0rj+h0uaA/RMB7VCvW6MQ
         coo87fLQggTBz4Y46G6eksAawMVyB6IlHxbXWHxkGps/HGg+vvNoFDVRqLd7DCciSgHz
         N1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RMgIjgVJe7MVFByUyYDinpCRIIO51b3eQdv64g3mNU=;
        b=ssFGQNHuTs+VfVPpbR6djxAKDMkJj1iAYElfD0h6QRM6YWeN3IjgHGVdKMP7AldfRu
         Jz8KqT2qCwaQl32cqIc4iAi1ez0RMH/owJtjP89skowtdzE+xRPpJIqSRZkk/l69kkjV
         uC+OoKoeHKfKV77cGdX7mLr4DloM/ray7wHoeO3N4XpKfc5Zi9F6iWeO5VDHyFFA7Vvt
         cMK36F8L56mJQ8/0FPWPwTkQqITm/O1lDxGFTAS/NyqXz5uAER0mNqPnlW9AxzwM7ha7
         nTMvpQmBkO/T/rrlPpKQVSxk5NJ9FO+fsTBDxHHjIoGcQJ4z8kQCO41SHib4k0TFBguK
         deTw==
X-Gm-Message-State: ANoB5plZyuhU6AILRbbH1aD1PaQqwQN0MzAHvbfbii523HtGpIoQibjE
        Kbx5oCKW8FnSEfTnx1K5OPgKMlc3wVg=
X-Google-Smtp-Source: AA0mqf4RUb9absyZahX06UATomYK/9lTXwRkVFFcxHPX6fLH8BamzhfBVpAgv9MmtiyeswD8ZI/+Sg==
X-Received: by 2002:a17:902:7e4a:b0:183:fffb:1c09 with SMTP id a10-20020a1709027e4a00b00183fffb1c09mr3517921pln.69.1668702296682;
        Thu, 17 Nov 2022 08:24:56 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b00188c9c11559sm1617929plj.1.2022.11.17.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:24:56 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 04/22] bpf: Populate field_offs for inner_map_meta
Date:   Thu, 17 Nov 2022 21:54:12 +0530
Message-Id: <20221117162430.1213770-5-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4166; i=memxor@gmail.com; h=from:subject; bh=nLZmTSTmmq1SxBwUC/19jz+E+cIA6c+jP3LcRFmypKE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl7+OXao4LxJm0sucrh7H+9MfBhu7/4f1VF3iIUl 6fGDXIKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3Ze/gAKCRBM4MiGSL8Ryol+EA CChH4o97sedTtWJK3cCAUkdfTXs9mrjmux8zxwVfRthb98WZWOBcLqdHX1XDEKAzwU/Y+JbcE4uUDx jy8hIg33g8fxx98nPw90GcS+4hlQQQp1VWXRgZJC4iPjw6853agbemd51stuabCDkYFKfIbJSq855x ydtOa0HsxvabH7u4QBGYyKs57fp0EztVGDdIvfTUtpRxCc+w5ZQRhty3di4taAYILphsDM5AIcPGAK MywZAo1kOnLDe3j6530p0MqGRxhhqhXrvtV4Jx2awpZ6I93FckK0TsaRC4M2aKReMZlSa56fRYwwDd vXSXrL4jDRNVqLD5Y9oqCDiygfubwKSVvxpp8dSwlcuQkcDT1TFIIGeTYrJJXkZkVa/mT87QLDnkwF tai1e+BY3yU+hmUBkUgKqcKnGWqt4TbnTdZITJYdo+x7jtj6/T6lTySXqtUNn/39HGwNzlpEjk2P+r idtA2PLuTdohVq/wI6jJR8PWSHYa8cSXK4SD1JlvZv5uKp057mT6EKwj4BqcvfiLWOGy42uHSYZJrs GssoxGCnQ0yMu1wFhXZQd/w8t+hG27xKBvmAoO456u8csKBG0eznfZ6eL3XxU6gtTCNLGaL7jkaH1R xdhqVpCF2OWPI10Hh5R7l8AdGhv1Q18mPfUv+XGuNxV4xtSB+cqhuSIpJ8LA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Far too much code simply assumes that both btf_record and btf_field_offs
are set to valid pointers together, or both are unset. They go together
hand in hand as btf_record describes the special fields and
btf_field_offs is compact representation for runtime copying/zeroing.

It is very difficult to make this clear in the code when the only
exception to this universal invariant is inner_map_meta which is used
as reg->map_ptr in the verifier. This is simply a bug waiting to happen,
as in verifier context we cannot easily distinguish if PTR_TO_MAP_VALUE
is coming from an inner map, and if we ever end up using field_offs for
any reason in the future, we will silently ignore the special fields for
inner map case (as NULL is not an error but unset field_offs).

Hence, simply copy field_offs from inner map together with btf_record.

While at it, refactor code to unwind properly on errors with gotos.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/map_in_map.c | 46 ++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 74f91048eee3..b3fa03a84334 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -12,6 +12,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	struct bpf_map *inner_map, *inner_map_meta;
 	u32 inner_map_meta_size;
 	struct fd f;
+	int ret;
 
 	f = fdget(inner_map_ufd);
 	inner_map = __bpf_map_get(f);
@@ -20,18 +21,18 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
 	/* Does not support >1 level map-in-map */
 	if (inner_map->inner_map_meta) {
-		fdput(f);
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto put;
 	}
 
 	if (!inner_map->ops->map_meta_equal) {
-		fdput(f);
-		return ERR_PTR(-ENOTSUPP);
+		ret = -ENOTSUPP;
+		goto put;
 	}
 
 	if (btf_record_has_field(inner_map->record, BPF_SPIN_LOCK)) {
-		fdput(f);
-		return ERR_PTR(-ENOTSUPP);
+		ret = -ENOTSUPP;
+		goto put;
 	}
 
 	inner_map_meta_size = sizeof(*inner_map_meta);
@@ -41,8 +42,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
 	inner_map_meta = kzalloc(inner_map_meta_size, GFP_USER);
 	if (!inner_map_meta) {
-		fdput(f);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto put;
 	}
 
 	inner_map_meta->map_type = inner_map->map_type;
@@ -50,17 +51,30 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	inner_map_meta->value_size = inner_map->value_size;
 	inner_map_meta->map_flags = inner_map->map_flags;
 	inner_map_meta->max_entries = inner_map->max_entries;
+
 	inner_map_meta->record = btf_record_dup(inner_map->record);
 	if (IS_ERR(inner_map_meta->record)) {
-		struct bpf_map *err_ptr = ERR_CAST(inner_map_meta->record);
 		/* btf_record_dup returns NULL or valid pointer in case of
 		 * invalid/empty/valid, but ERR_PTR in case of errors. During
 		 * equality NULL or IS_ERR is equivalent.
 		 */
-		kfree(inner_map_meta);
-		fdput(f);
-		return err_ptr;
+		ret = PTR_ERR(inner_map_meta->record);
+		goto free;
+	}
+
+	if (inner_map_meta->record) {
+		struct btf_field_offs *field_offs;
+		/* If btf_record is !IS_ERR_OR_NULL, then field_offs is always
+		 * valid.
+		 */
+		field_offs = kmemdup(inner_map->field_offs, sizeof(*inner_map->field_offs), GFP_KERNEL | __GFP_NOWARN);
+		if (!field_offs) {
+			ret = -ENOMEM;
+			goto free_rec;
+		}
+		inner_map_meta->field_offs = field_offs;
 	}
+
 	/* It is critical that inner_map btf is set to inner_map_meta btf, as
 	 * the duplicated btf_record's list_head btf_field structs have
 	 * value_rec members which point into the btf_record populated for the
@@ -81,10 +95,18 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
 	fdput(f);
 	return inner_map_meta;
+free_rec:
+	btf_record_free(inner_map_meta->record);
+free:
+	kfree(inner_map_meta);
+put:
+	fdput(f);
+	return ERR_PTR(ret);
 }
 
 void bpf_map_meta_free(struct bpf_map *map_meta)
 {
+	kfree(map_meta->field_offs);
 	btf_record_free(map_meta->record);
 	btf_put(map_meta->btf);
 	kfree(map_meta);
-- 
2.38.1

