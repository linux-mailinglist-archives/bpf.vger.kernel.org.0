Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944DF62EB65
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbiKRB4d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiKRB42 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:28 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D00742FB
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:27 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id k7so3308261pll.6
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wm4NNeNJS0H5WokSXilAlhY0JclfcP6xgh+hPFhMKa4=;
        b=ig0YjqlFuamtF3nf1nCc8wrXeuVmFZ8+dYTxtspcOfVNGUrrTI2t9ptlhYKrgsheIS
         sC/jRvAItXFWnUpSySAL5byOBF1IHd2VoiJcByg3/qoO25BpM8JY+tnedfDwLwSFpNEp
         zPLLuE4IhDOPZBwZ5wo27jpCJy7ahgERzdvoYxtuy3XYtd2tmNp+6fn8+aVvWbmveT2R
         czxGKdx32Bzd++Nz2fGx/XzsM412mQRaR8J1wUl7n4IKgin489paEaW7rxP9w3dY6fVl
         WnkrD3CeBoPb7MwKeN8qCiu8i7LWy8T0OuT/kHKdvo/JlowQfkJCi4rh3LmaG43AJMCh
         xstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wm4NNeNJS0H5WokSXilAlhY0JclfcP6xgh+hPFhMKa4=;
        b=f0MofuMDnUCiRg/CDdqfSsI9LNJzcIPMI9BrEVUws9AZXqqgy1Vsgz25LNIjkGt+Ka
         uCjW75YL6uSg4kScmjAu+Ch+1Czg6cWKv0dwlnmiy8NNR4BkcwB8LuJos9jdGbuSJnni
         jpp1UJD+ytiwo5ye0UVo09lcmehuLzEWG+aGStrG2C6hGOvOkCW8GLU8ylUg+Q0vvM+k
         aTRjCsSii3lvL9pLrvhGccnyhXoGzHMmT5ll5PqK3Lj6LYNt8nrSxii861clI+/M3Rzt
         3JWSpSmoWPKU/+U8zfoXYWAyzdMXFG2ED/4SgeHzrThWe2LuNoozGV7C3hfRk/cpxx7r
         z07g==
X-Gm-Message-State: ANoB5pkAPT3557B32g4UH4AmF0lLHBBawtTs0zCQfmxvXkPOjstaLN63
        4B5oK8hBoxy57o9VGBgO5Hrn4i0Rb/c=
X-Google-Smtp-Source: AA0mqf5NiQxO+osobsD4LSJ7rse6hX/M2nMIp+w4EEBpKa+DC6oKHpoN8lm8LhFzmxIC0zCm0PyvtQ==
X-Received: by 2002:a17:902:ce04:b0:187:3a54:9b93 with SMTP id k4-20020a170902ce0400b001873a549b93mr5552669plg.2.1668736587209;
        Thu, 17 Nov 2022 17:56:27 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b0017f73dc1549sm2085988plf.263.2022.11.17.17.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:26 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 03/24] bpf: Free inner_map_meta when btf_record_dup fails
Date:   Fri, 18 Nov 2022 07:25:53 +0530
Message-Id: <20221118015614.2013203-4-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=memxor@gmail.com; h=from:subject; bh=MFSSIOz61nwPTf4dvr2OI1CrS/lI0bHuXz3O9ayARiE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXOn5saVkB7HoV0UppUVjO3d8+04YMSFxUNHz9g 7TAArViJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzgAKCRBM4MiGSL8RylwCD/ 9TV7kikI3aKz5Sbug6gRwcKshVP3QiOU68MhjgIm8BVEmwK8g3BGeFSTSAkWXecEEeYyLZoRDmxIOM xxe7krITuTAPN83mlUpyoP/SGMMXs9DKrc78kMDsMJPU6oXRT70ObmPjk4jJr+Xoxen3CSMAkwwYF0 8bqi60vDcqS67nvi9ZDQVu3CHrvh5s9SiTx78e7iJ5864UM/KqfnlP2jIrBT4vUQvN/oaQ5AawcpaH K4g0uFqwKmigP1nrpKTfD5mTebW9nxssXISio4WEpiBLglee+BqYrSksdK+BE7WZucyn0R/z3myReH J6fYE9eBi3fBOv/Khuf4XlG2++X53/EcZ170lGGCEbZvTk1Gk0SNcjLzTPscH3kZo29Y2I+5umQWD5 yecSQMRk57b3CebyzzgFCE1E6hR80XOrjyTLFkGRdr3EdXP5YICNVZ/cfD/K/eh7urnw4LRBwZdZtW oDJOA1TaZOL7dyT+tgrGq3ogxb8IX3ldwJAow5A8P0Op9iHidB4LzcWDGqJKosw+LvG0ojggLJvqgR zIqktURCdBm1JchuVb8l3QtonUoLMxW6qSrvofaxBgkU2VNkR0ln7eIdRkyJHd/l8oA1jKbh+FxSC0 mybJt3bsTrp4rvIF684+l9jzOhEPWKE9euqR4exMGLhrLsuX4SANO78KzsEQ==
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

Whenever btf_record_dup fails, we must free inner_map_meta that was
allocated before.

This fixes a memory leak (in case of errors) during inner map creation.

Fixes: aa3496accc41 ("bpf: Refactor kptr_off_tab into btf_record")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/map_in_map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 8ca0cca39d49..a423130a8720 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -52,12 +52,14 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	inner_map_meta->max_entries = inner_map->max_entries;
 	inner_map_meta->record = btf_record_dup(inner_map->record);
 	if (IS_ERR(inner_map_meta->record)) {
+		struct bpf_map *err_ptr = ERR_CAST(inner_map_meta->record);
 		/* btf_record_dup returns NULL or valid pointer in case of
 		 * invalid/empty/valid, but ERR_PTR in case of errors. During
 		 * equality NULL or IS_ERR is equivalent.
 		 */
+		kfree(inner_map_meta);
 		fdput(f);
-		return ERR_CAST(inner_map_meta->record);
+		return err_ptr;
 	}
 	if (inner_map->btf) {
 		btf_get(inner_map->btf);
-- 
2.38.1

