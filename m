Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1562EB66
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbiKRB4g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbiKRB4d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:33 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BEB7C023
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:31 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id k5so3240637pjo.5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tXOFlrxPDdAO4C616SqFABGb25iFnv7FGs3Eokwgsw=;
        b=X1zfDKv8Aat9HDb3DSgjGZGpdwr5AMnziPsW7POihD9F+35REWUjQ7XwVF9liIzTaZ
         Ztxj060vFT8GRAfUxWrSAHQoxfzVJ9iLRqZHsf9JZMuUAitp9Vo659KXxxXwpd0wdJuz
         Q6fZXY/mw5XuN9t9NCsnz0FxSCNkD59Wl6h1HuuGWKk/CqF/Sc94KTrSGV4BDU8OyySP
         lbKmdDNfZ+2YsHu5bW8SFl1yDCKKkY8o/YXl7B+q+7hSeWxWFk0RX2jHvn7N1lAGosnw
         K4yL+k4PtVzi+AvwvOOgZDQ+mVZ+EsUFLahI+acCQleEsYg1/ASEcoIX0fLfcK+MiR9/
         SeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tXOFlrxPDdAO4C616SqFABGb25iFnv7FGs3Eokwgsw=;
        b=aKTp9751caLUCRu+vnRuI6oydfVhm0jXQXVQyEKrHDel5WeT/fxKIokjG9Z0Zb19ze
         z616NWRhENRozrzNboidBcGNxU4Ed7ARZg9ZJyRzl6rSaKkSsjya/1xSdECLajCFAFJj
         xWDfkW1akaAnV+UZiMMvkPKUvFaqFTA45o6Y+lUIMxN8qT6lPR4CPvqsR0eDuRMmn0oE
         Jn0wvY2A9XZrsDVqua2hH4FMCNcpBR3V4ZVK0MMxjv5Rnw9qRsWtytWIKJSJUW9X2WH8
         xPY+z5+yMP8P8jx1qtsL+ZuFft4Rs6Y35lJ39vgQ03/WaET+9dZJCzZId5lb/tJJ60XQ
         oCXQ==
X-Gm-Message-State: ANoB5pl9yxTiTUzg+mrlZWFOHTpQ/iJQdgfjLok0SSY2hwBnyf+9XqgC
        tY59s/VJxKpcc1GRPp9SOSqqG2W4UUA=
X-Google-Smtp-Source: AA0mqf54qGOt5DOVrpQqjK+f2mFvu9BjFyFOdORCwSnhpIR44zaVbfkenzURIcL28yRmgleaHtlxOg==
X-Received: by 2002:a17:90a:c685:b0:218:7b33:60c with SMTP id n5-20020a17090ac68500b002187b33060cmr3632106pjt.99.1668736590436;
        Thu, 17 Nov 2022 17:56:30 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id b22-20020a17090a011600b00202618f0df4sm4249996pjb.0.2022.11.17.17.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:30 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 04/24] bpf: Populate field_offs for inner_map_meta
Date:   Fri, 18 Nov 2022 07:25:54 +0530
Message-Id: <20221118015614.2013203-5-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3996; i=memxor@gmail.com; h=from:subject; bh=Cqk0Hx/89vbzoryLz1qsgSw+UY1K0G5tz50Zkumpm18=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXO7cn/1S2dSq5Ou2R0Cg/ljrzysHHZhFc1ctec pCWcA1qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzgAKCRBM4MiGSL8RyjAtEA C82xod5+caDgBe0g+x7dLV7Lq0X+hCaR8gEQ/BJo7iuHk28Ew1xydPHtky5ehWKSDBEU1wdfDH/3NY Z807h67dGtVmZCWMlaXg7XlDLBz8X3NZUC138SJcfp6SEPug7LsAlF/2cspjQ8h0bcpW8MRgvGpq6l biyAISLULjVtrOK6eoXzWeKmC0a7q8HseuSHLzizZTLAmyGwitRpBFy89BVzVHWCZc95+9p+9GOWLg L68UqzZ77I2LF7Sdc/PXiE4EK8T8p5oDVQypjYCC2QrRA3nvrcbo9dZVDiRL7HlOqv+EoxOjrmPE1w FzDcXQ9E7VnRN+Qf7wb23Li5VAA2xqdVWVE8EceJ6agTdCDbAeVPQeu1pnz026zfaVRgKu6eIjfJhh IzUnpi9KHpudXV/gx5XZgnHg9R1XaSZ9fxoukCy9+k7lzOMpkHQh5g7ffd/3mtHiIwngi/c+WNqEZZ 2HCp8gPR3d5wklx3G2ZogHdx67vR/RiUw6SqbXD7z5kHW5hd9lBaxJblT/hcp361lpl5BMxZg/+Xm2 BN9lUBQcSKlfFDMHjldDOKMfWGThYoN2D3IO5w3oOiQ8EE6ARXCc4lMhSTrSbxx+kzPWrEbUmwrInL ebRsDgn56FipXWxIi8QnB2EyGz6sE01S20JDZl+s2K66/TOVf30B7M5RlqzA==
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

