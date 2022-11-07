Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76183620355
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiKGXKD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiKGXKB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:01 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE41FCD6
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:10:01 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso11780788pjc.5
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnrYmyFxoGEM6OlddgT2gVaTsDC543yW1/JtZQJqlOM=;
        b=CCIf1Zl8L1pIbAa66zDav4h3KJfv9e29otLCp362cEdzu5UdHXXpr+kBtj38FKn8dp
         A2Oe9cmNGL8UDN+bIIbOLyJ7WKT3l0yNtcbnA4FKGg6yo6dGsJiqhr6IzrBiDsO1clrJ
         dz+Rv2Uj/eByaUB+8O3Xd5NT+yBmsxzjF+IYWOMAGIhDrC7ajoes3pJlE9euizIWPRpr
         qHzB5TC/rIuVcYiANpXFKSCiMa4/txovmNgYBA+ZZLp6xh8nLkmo0x1u32obOu3pjWgM
         dV6I8vfQGNIAwcToBYp03/JUW1P2VAZZ7TnFRmWpxYwMI87KpA/lqJ1PWN6y0CVO6FT8
         tOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnrYmyFxoGEM6OlddgT2gVaTsDC543yW1/JtZQJqlOM=;
        b=z3j6f0D4NcHj3RJeHTfBWG7A2ykCqLQdy+7tLFUNy2tzrcQ0B7gOqJKtLhHoNK3ax9
         5n6ZnRVql7U8OfTbcgIeF2Pz1JSDihdL84PQJSixmjyptl/wE9kzZfm6nrPKLx8YbO+4
         kfbbhiGT3vd7laJAYvV8ljIzgFPIby3AIef3+ROLbfQcNXvSbUCBFyvFmu47o+XgvdnS
         Cu2xHbYYIm6JqdVh6iZVY2nNkEKqMAOGPTMKPlPQsni4O8j5+lfzODW0095w7DRuGd8w
         LDyTYZE4Xh+MClhLumyBAf8FJd9it+H1nEZUHf+dwxr88zz4D2+Wtz0ZqJWaOmCoo5xz
         Afug==
X-Gm-Message-State: ACrzQf3CfrZuQi9y1QaS7pbE02MBKU2yyj/Ym+y0lqKaEkhH9QAu2HPg
        T+Qq7MbsVnVy+7rNfxaD02exClWvn2huFA==
X-Google-Smtp-Source: AMsMyM5S/xFcXoNrA2pFpM8NOY+8A4Y59O7QidUZJd0jlgazxLxQKDtqwe4yAiEsFRVgCjCps8CgcQ==
X-Received: by 2002:a17:903:40cb:b0:187:1d3:461a with SMTP id t11-20020a17090340cb00b0018701d3461amr51461392pld.155.1667862600295;
        Mon, 07 Nov 2022 15:10:00 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id 72-20020a62194b000000b00562677968aesm5015198pfz.72.2022.11.07.15.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:10:00 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 01/25] bpf: Remove BPF_MAP_OFF_ARR_MAX
Date:   Tue,  8 Nov 2022 04:39:26 +0530
Message-Id: <20221107230950.7117-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=memxor@gmail.com; h=from:subject; bh=ZTLueoxLQrjQVPDjxfufu3gtMYHhhFj4zDRgWCv34xw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+1KwPAD2afMKABKxB3GU1fQw0uIn5UXRBoG2Y8 3eCPBMaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtQAKCRBM4MiGSL8RyjRGD/ 9zWZyEgaQonvxWtrYbCRq/2YKaDZn7Rs5l+hDP4WwoevVpWs1djjvSaP/2aP80sxDZJOgmdMtZ1x1Y B0+K5nB7RrIQK4GpI+wayscJKe/aYETPS0kTApDoSe3j5fjuX9w91V+/JnC+Q+XO4GCWz55ANkjLa1 vWwd1PLVPOU/85364+y4NwPURQ6u5BoePev/hKIlMxQ5KHYvdxiaNYf8X/aza1eyznsuJlybLfqz5V QCrJtT/TPnKTzXeKrPZ77PXUr6ccVgq8vuXm2mARxjOHiVulfvZloQ3fe72aPO4dFs2oXG1gG/JoJS Yc55IuxJDkMlK3bJzWXxq51XULpS7ebiBM1gi9Ggl1KQz3bsTTTLahyEPnnMDepy5c95RjghMwtpc2 8tmjmuWixB4Smz2C8sQgC0nDnApm3p4ZqQnJiaKyGUstkqnOtS95icRTQZZwk5PXYoGk+enysvYbay BzgR4IFRPEccHhqwZj0fZyISl1eUZO3/8EmUXJbrg5Od/ige4IJEPCCbecnv7hm8dzVwE1VXIYzaF0 Zzdv/dmd/hgEIHelZT5U4iO8CEQpPF4pl1Ei0IlBWyJwXKxre6YQG1zmSr2PpSp4KSF0diCwtLxbfA jk6EYOWecoJI56NmH3kZlJIgzmVQtzUj4TSxG2uk5Uegq4DmEwgH6bckkIUw==
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

