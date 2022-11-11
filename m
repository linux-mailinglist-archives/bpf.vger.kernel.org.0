Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E46261F8
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiKKTdI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKKTdH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:33:07 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283D576FB2
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:07 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id k22so5703735pfd.3
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnrYmyFxoGEM6OlddgT2gVaTsDC543yW1/JtZQJqlOM=;
        b=m2Nv0IPc6x707CE04/zSUXq9xwtM8EpbXyPz3t+7nL5+evVEraxHLJ11lRhcgRu3A3
         MKv5n2AhXYVT6Agd8YIhVJ1bu3J9D+Of5mO2efKrbhK8tmLwF0wqJo1D+T1ZOjQfsSnD
         xerEhyyXq/04KAUjWuB237cvaYxYm9KZrm4qQ1W/6y1Z4yApWUHfJlR4T/eAEFvn4qqR
         8jp7dSz+SpmXpGbM3061vNR9qL/DgIX26+uhC8Lxh51I4ajPvYgBp5ytBCcNFkw9DQeW
         WGNiQWDcI5J5IcijqSkmvDLFiRvyN3y6ZDLWbFCjSfWQPSVf1TGg86R3Ht+tz8H/dEAr
         d/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnrYmyFxoGEM6OlddgT2gVaTsDC543yW1/JtZQJqlOM=;
        b=UAG1/baSxihJWVtM39le32IN132uPp2s8yd+O1niq91Z2cvVU0V5JmUIBYPoufdrlW
         S6nhMv4P70xUq4aFGHreKL6U62XImwf1xAEH4pmOt4z83vkz0Pk/cFmkkucxHnmeZsHA
         MCTKN2I80AuvzFC8NIwP8r3aZQQU3jMpZUjbDtvWhoB04TJfvg8BTb3KIatXzVmbsyEu
         GtHhWuNj7+uw/fOpocmf4Hj49s1684k2CF9Kv0hDcVYwRkt5wve0lVhWWJ1w0b7qlKTE
         3N7zc9WX/bPVCOn9eqqL8Cvz1c2MtJSBREVnIhuooPgP09mRZVURK7uz043WC3AIYFF1
         5DvA==
X-Gm-Message-State: ANoB5pm93+RWqvcDCy9K2oJwR0GItLm8IQhfXR6kFzCuoZmhnOokfaOx
        SCmAER+8AbITM+hNPxrBNxQDqshjlxjMIg==
X-Google-Smtp-Source: AA0mqf7Bg8B9uVgnQbdERbcYfnpIBVkMv4kNuoIMG2psSBaO1hEFMkgnjwNrF+ObdoA0nJ/k3lOMew==
X-Received: by 2002:a63:5f15:0:b0:46f:7e1c:aa2e with SMTP id t21-20020a635f15000000b0046f7e1caa2emr2939742pgb.145.1668195186442;
        Fri, 11 Nov 2022 11:33:06 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id w9-20020a17090a780900b00208c58d5a0esm5213875pjk.40.2022.11.11.11.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:33:06 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 02/26] bpf: Remove BPF_MAP_OFF_ARR_MAX
Date:   Sat, 12 Nov 2022 01:02:00 +0530
Message-Id: <20221111193224.876706-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=memxor@gmail.com; h=from:subject; bh=ZTLueoxLQrjQVPDjxfufu3gtMYHhhFj4zDRgWCv34xw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqInKwPAD2afMKABKxB3GU1fQw0uIn5UXRBoG2Y8 3eCPBMaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iJwAKCRBM4MiGSL8RymkzD/ 9pShJ6gZc8JUSqnAtlGbDErdEmvHfqDne3mrCD8k6rv2Y0imZiaAvxtade4tumCbQdvntbfz3VxLAl vHQb4qBE2W0LLUi0TN7OU+Jt1H7wHuk4+W8sRyDBNXsbfCgaMEjT20mxsRG3uEF3q3/Ia5NNVLZyCK 7jkKgU0IekrNusx9A/vg5emLxr8cIVVneWaDw+eM0HlyiAbF9cKqkWOpm97LIbnHY0x9S1PVgfGlE8 15aPF3bcWd6c0NMrem6xhaSpZ/OXKWuqB5jOGVdWEuuFPYFq0C+0GqAPAUU/bWI3E3ZlUpBXC/0h1F BwjMqrQPcRRunKmyMY6ZJSNIdwNISQqQqS2zqhx4TsVbMaOav5/2Yg2mB2JYbAoe+J596WRSPOiun0 Wu5auMr9pX6PwK2jem4BAkl3AVGQhjRr6imaBq0HwIDyYEs0U4sahziffYWU4TN0xl/sEbbrJ88WXo WzoqHcqII9jCPVUFleE2S5gYWyLI3CMX1TjZb0SiqOou/RkuTzNVDZit/0HvhRSfKWlNsRgZsuiIgx bH0uTy5CbXrmHHqshbjKi7BzYQLRnwQx1AhP+Dry0Yz9FIHaII4BZ9rrOD5/6bTjFKOYHy2CrwkeD7 8V7iXboAdqn+jLCw3Hcv3w2Ut0gFx3BBRPulqwj/DJWdPiDPSqI78DQ7HeZw==
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

In f71b2f64177a ("bpf: Refactor map->off_arr handling"), map->off_arr
was refactored to be btf_field_offs. The number of field offsets is
equal to maximum possible fields limited by BTF_FIELDS_MAX. Hence, reuse
BTF_FIELDS_MAX as spin_lock and timer no longer are to be handled
specially for offset sorting, fix the comment, and remove incorrect
WARN_ON as its rec->cnt can never exceed this value. The reason to keep
separate constant was the it was always more 2 more than total kptrs.
This is no longer the case.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 9 ++++-----
 kernel/bpf/btf.c    | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 798aec816970..1a66a1df1af1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -165,9 +165,8 @@ struct bpf_map_ops {
 };
 
 enum {
-	/* Support at most 8 pointers in a BTF type */
-	BTF_FIELDS_MAX	      = 10,
-	BPF_MAP_OFF_ARR_MAX   = BTF_FIELDS_MAX,
+	/* Support at most 10 fields in a BTF type */
+	BTF_FIELDS_MAX	   = 10,
 };
 
 enum btf_field_type {
@@ -203,8 +202,8 @@ struct btf_record {
 
 struct btf_field_offs {
 	u32 cnt;
-	u32 field_off[BPF_MAP_OFF_ARR_MAX];
-	u8 field_sz[BPF_MAP_OFF_ARR_MAX];
+	u32 field_off[BTF_FIELDS_MAX];
+	u8 field_sz[BTF_FIELDS_MAX];
 };
 
 struct bpf_map {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5579ff3a5b54..12361d7b2498 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3584,7 +3584,7 @@ struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec)
 	u8 *sz;
 
 	BUILD_BUG_ON(ARRAY_SIZE(foffs->field_off) != ARRAY_SIZE(foffs->field_sz));
-	if (IS_ERR_OR_NULL(rec) || WARN_ON_ONCE(rec->cnt > sizeof(foffs->field_off)))
+	if (IS_ERR_OR_NULL(rec))
 		return NULL;
 
 	foffs = kzalloc(sizeof(*foffs), GFP_KERNEL | __GFP_NOWARN);
-- 
2.38.1

