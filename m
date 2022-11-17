Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAAF62E8C9
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiKQWzf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiKQWzc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:55:32 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02C015829
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:31 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so6699039pjs.4
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tXOFlrxPDdAO4C616SqFABGb25iFnv7FGs3Eokwgsw=;
        b=BDYv/f0X6+L65aWH/F2hogFfh/s+OIMhTkTYwIAtL0uH53cZSRv/u9MWd1npzS4qdj
         CGzAUhhYFsC2uDbbnwbrVjxABWI4TrqHPQvSfjgDjsT4DX9/rzpXpx7FOTdLcEvUU7yp
         46Eiy/Y8s53tSvjYCkV62SR+MAFj6hp1PI/s35xsGE9Hwh3Ehj5CWisqB09iaQoE3kYb
         v/RWv2IkYeycJu2FVjzgRr1ofYmhDabB+af6soa5H/aogKMoyR1doJlVE0NWuz4gZoS3
         LgZMZcpoE3eZixxv1+k4PUU61VuhMbRuniCRBGHkEQLXeQ6aTUi9njECHnwmKJfM+a5V
         CIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tXOFlrxPDdAO4C616SqFABGb25iFnv7FGs3Eokwgsw=;
        b=53vCwUDzjY3IO15IqerS8pVaxFKTfKVvrWOXVhbSAbMSj6W1eCOew+b5PCEvAGhIJ2
         mPniyYlsbA62IcCQ9VFk1DDKn1l1MuMNyA9dulQjqW9NSlxkF2wr9dWuFWyLLCRkegeQ
         DxmR07p76hdAf0eHrFl6O+M6dT22tY1vuqHfVTzcsCowxya3xsyfUtitigHVVXWUrko9
         OzzwVToZA+8a0Isx8KOM5l9hG83AAZDM5aTeyMds5KVGoE87S1SJXviTHQJFWcwDCc7I
         Mn1pCwbv4SBPvERrnFb8ZC8ElFau+ASaDq5aHlfV7Ml1mKwt/gQh9TWF1ZW4s/u1vckl
         blmA==
X-Gm-Message-State: ANoB5plB3G/j/PbtYp/vnCpuo3nr4+dpVGjs2+EtAiIcNyyBZ/sR6Phh
        Qs8PoNaxEJf1Wnv/eIBEE4JITuhz2zM=
X-Google-Smtp-Source: AA0mqf7ppHP78R6DoyaSEfdabFN93hGLedM5frzCx5lU0qVbL8x8mv7KVs5D4ri0MCkTZLrnYexjfQ==
X-Received: by 2002:a17:902:bd01:b0:188:bed6:3fb8 with SMTP id p1-20020a170902bd0100b00188bed63fb8mr4963505pls.38.1668725730992;
        Thu, 17 Nov 2022 14:55:30 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id i6-20020a626d06000000b00572275e68f8sm1658620pfc.166.2022.11.17.14.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:55:28 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 04/23] bpf: Populate field_offs for inner_map_meta
Date:   Fri, 18 Nov 2022 04:24:51 +0530
Message-Id: <20221117225510.1676785-5-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3996; i=memxor@gmail.com; h=from:subject; bh=Cqk0Hx/89vbzoryLz1qsgSw+UY1K0G5tz50Zkumpm18=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkb7cn/1S2dSq5Ou2R0Cg/ljrzysHHZhFc1ctec pCWcA1qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5GwAKCRBM4MiGSL8RypAgEA C7dn+S9wJ2v5o+3OVJW5/jKjC7vmbzEl0GsNwrrp6SuvJwgXZI6YV9ewh9TPfxvroo72oPTeX9CZPC YMy8zBXLy8NkEIQk1/APTvmL/8/0xc12obsfHUJchmoTjUDsKD7ylxYEEbK2NJnj7tS1NGWPfoOCu3 iycwJW3WSCgxfujqsBk3EUzUfieS27lk2Q/+Y0lxSEJSq1wzyHNmorAJwjF1FGGEobvugUO/LkwXD5 FmC9E+Zhuzbqhh/NDhwRGh5KnXCG1O52ZEcXjSrz18mDz2wmuBJOX2/iO8kjW6lyu3zZAxzE03ObmF e2sGwIt0mfX54zuPVcBvk303kopSbnMDVNcIzFkFqUOSz2XlxcGBfEBg31qB23At+V0JJ08AE3hQwQ EJ5fi9LpnbsyzADFGM9Hvx/qMrGW8kKlOi9FDnhGkWV0R8nUZQgWrU4HJOvo9m6PvavOapTXDKf/ED RjCkyERAbm/DCvh3Xs7v1umD5yr6IkOHs18vdbcO1LKbSK/ms0PvL665a6waQD+26WfSXTEjIEMMg4 C0wvSWjooPhqoyVUnbuDQRQxKV8wjuKfj1uadw33mouaIAQtm07Gny4qWLAtWznSFlzGM2kGZekTmX JAlmPf/CVfFZssZyTfm8l9YvUdS8gx+/pgqJe/g1GeF0WQ35wTjuPrOEcB4g==
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
 kernel/bpf/map_in_map.c | 44 ++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index a423130a8720..fae6a6c33e2d 100644
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
@@ -50,16 +51,27 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
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
 	if (inner_map->btf) {
 		btf_get(inner_map->btf);
@@ -76,10 +88,18 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
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
 	bpf_map_free_record(map_meta);
 	btf_put(map_meta->btf);
 	kfree(map_meta);
-- 
2.38.1

