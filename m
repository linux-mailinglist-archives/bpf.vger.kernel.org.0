Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F717505FE4
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 00:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiDRWuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiDRWuE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 18:50:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D5F2BB20
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:47:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso589906pju.1
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbXBJzKGwtXEljHi6De2HSN7DKaU9eGbmH4L4iYQ4CU=;
        b=jXTzkqBxXluO5xDeGaZE3VESTGg6BovcSjIegmusw+TD1VGAtk5pOEXAxNQQWuMvxr
         wGzey+IQ3j0GHaqH+ucogNc0emhTW0ZEDRTfJru/C/sgT28xIiJh4rXIs/0VCEdI4V5V
         f1MJ7Hj2jxvgT4h6eF8CIi6zMhOGT+4LLtX79o0iXf2M4PwyrA5iZ2vCXJrX5OtEoM7R
         yP6NWt/U6RFUJYeuilbutI80iaT9UGjc90Xed669UR0CYBYNQomd+tAvCQ1UwXP/Gyhd
         BwYZ4NhgW9Ny50TzrzVr6JHtkknellXrxZtzQpu2IqJpeMucxodL5ov7UKrIm9qExz6F
         RdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbXBJzKGwtXEljHi6De2HSN7DKaU9eGbmH4L4iYQ4CU=;
        b=OvEP07Z4rqMyCEzj4uMGDxlsPebGfU1vEjw67gFZvN9J27BDgcBf5P/c+q3Rz1l03m
         IfMeOFB9BjgfIVN5Y1riLcbt1KJueHw1/gIOVI/GK8GJrRqknKMVUrV/Oqy7xSMM8Wdr
         xLbYD7yg9p2C37cnbroJQ0IqvxSvZHRPfj4hgMr84n0BAhsvL8LoM94yiLvMGSCUqvlo
         fpY0riB/oBYocn/eX0I3D+XW+qKFPcoudQQlYOTuqWjm9XIzpenf9Rdf0lXz8CtJrH42
         HYzfDNb2ztsImRkh1qxZokJn4Z4pyjhNOLaS/ypQwaFUayM/OiZcmoDDdMKE+deghJMI
         1wuA==
X-Gm-Message-State: AOAM533Mo2bB7Fjj/hn3SruxPLivenI/2shSm3lAXp9aW+dXZydgcAmK
        wJrLIgnOUfKSiWWTZaV3YyuBCVFyZCdyDg==
X-Google-Smtp-Source: ABdhPJzo+xFZyNqltQkfejPl7Qd9DHEr4NxlPaYlZKAEIDLgXhzF2unUYgxvMKiv8AtzXkOSoKjjWg==
X-Received: by 2002:a17:90a:e7ca:b0:1d1:22ce:86c3 with SMTP id kb10-20020a17090ae7ca00b001d122ce86c3mr18358461pjb.10.1650322042665;
        Mon, 18 Apr 2022 15:47:22 -0700 (PDT)
Received: from localhost ([112.79.142.143])
        by smtp.gmail.com with ESMTPSA id o2-20020a17090a55c200b001ce0843e0d9sm13808039pjm.38.2022.04.18.15.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 15:47:22 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for type tag order validation
Date:   Tue, 19 Apr 2022 04:17:19 +0530
Message-Id: <20220418224719.1604889-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418224719.1604889-1-memxor@gmail.com>
References: <20220418224719.1604889-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3521; h=from:subject; bh=205W/sh8MXIGSTzmVy97vNb6BqtXW/sT31fW0n1/73I=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiXenT0egvInWI52WssI3nb9bYLZUe3ehYHY1n8J7O C+By3KiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYl3p0wAKCRBM4MiGSL8Ryhg1D/ 405eGzXZBIeQcp37k6MUZF/ox7Sy56VGbW3NKYyW35OOpleT6oYUTUv21wHss8QlxPVB8tI78HtKKN WDTLrCeiWPjLwrJEFyhQk4H9V4QxkQ7wZXQZDMneTwFNTdP2PIn7ejzVNR3iJoOI1BiJ1NzvSd2ByI PW6nG68PDkv3Du0lzIgqZFGLubW9+w4wWwkBJQ+STbmIRyRnotiRhwZ8PJHbrSZhH0hmdxLy7z5cLb 9/hPnUSQ1NJLncNn0JcbtrFyPXntI7mQz7V9xZGnVaRx5It4CeZT8fbAuws7KfgOqmGtU1Mw9LPdJW ZwBLK9Er/lyRtmFVRoCA1pqDH0gF0FFYXew1QdE08aqWUx8JGZ6Rgi8Yg+c/RLrgUN4E9mvb5SWWpN jF35CVQlIMmzW/+X+3RQxjLcThFC07/Qaj0dZtcxD9Bq8PoKHs6w9q1ymcpPTCN6KDvl9T7zkQqioQ gdMC6u3T1myPQicqskv3GcAgmreYr3BL774kr/h/A+4Eu8kbd5q1QZfJWJg6omuTIEykmJHbjaD2HD aSiuEYt0JmJyTJ0tg1hdJnO0nY+/GfjC357KPYAI31o/O6ffho6hDAFTTGzY3WJbRBv5BtA0ycygY5 pgEPiOl5H0CW6OdrHyOf3VL4e+ZdUwpwdg1frWe9L2U7S3atBypI1uUJsi8A==
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

Add a few test cases that ensure we catch cases of badly ordered type
tags in modifier chains.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 99 ++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 84aae639ddb5..ba5bde53d418 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3973,6 +3973,105 @@ static struct btf_raw_test raw_tests[] = {
 	.value_type_id = 1,
 	.max_entries = 1,
 },
+{
+	.descr = "type_tag test #2, type tag order",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_CONST_ENC(3),				/* [2] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 1),			/* [3] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "tag_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Type tags don't precede modifiers",
+},
+{
+	.descr = "type_tag test #3, type tag order",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 3),			/* [2] */
+		BTF_CONST_ENC(4),				/* [3] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 1),			/* [4] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag\0tag"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "tag_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Type tags don't precede modifiers",
+},
+{
+	.descr = "type_tag test #4, type tag order",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPEDEF_ENC(NAME_TBD, 3),			/* [2] */
+		BTF_CONST_ENC(4),				/* [3] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 1),			/* [4] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag\0tag"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "tag_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Type tags don't precede modifiers",
+},
+{
+	.descr = "type_tag test #5, type tag order",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 3),			/* [2] */
+		BTF_CONST_ENC(1),				/* [3] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 2),			/* [4] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag\0tag"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "tag_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 1,
+},
+{
+	.descr = "type_tag test #6, type tag order",
+	.raw_types = {
+		BTF_PTR_ENC(2),					/* [1] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 3),			/* [2] */
+		BTF_CONST_ENC(4),				/* [3] */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [4] */
+		BTF_PTR_ENC(6),					/* [5] */
+		BTF_CONST_ENC(2),				/* [6] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "tag_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Type tags don't precede modifiers",
+},
 
 }; /* struct btf_raw_test raw_tests[] */
 
-- 
2.35.1

