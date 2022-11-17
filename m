Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF10A62E8C8
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiKQWz3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiKQWz0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:55:26 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029546339
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:26 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id p21so2986311plr.7
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wm4NNeNJS0H5WokSXilAlhY0JclfcP6xgh+hPFhMKa4=;
        b=TECNGCHc6shJxybBV/P2tgtm0vtj0fhNOiAHOHhrWwI2jXe9jVWDJhLOrJtN3W46MO
         jUy4myEgesWBm/SBi3sVc+YvHar/gSXePYw8JNIAuTZuH0PdP5Fm7I8IjgIKDPvLRjfo
         s+yDPoyBbnsB6YHibBaQ3UFMrbhvkiCEUI2G3ZmXacWIM+Kqo+8F7+2AzKEXHN8SP0XW
         YzbVC12zppgFEbaTpqUUBgLVBSqhGF6UtKusCYhAeybQp3c2sWIGr9DQNRE68e/5XaNG
         WSzI5MHWpWvMa+9+uDPV4YaDi/rE7mLXCIC1BkVx8ThUtEnED49Z4yLGGsMAGQD8b1WU
         FFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wm4NNeNJS0H5WokSXilAlhY0JclfcP6xgh+hPFhMKa4=;
        b=QU6pbK6Vc1lara/aWBIRBDnUB5c7y9gmzKHBOnFrLuovDW7LeQFq+d4tOY7eVZI8Vl
         Tzlwrs1wkpimhhced1/DhoVl99XUhaxTuShqdyiEB25hKeXgBYgIvbnnI0uU5l4a5sA6
         NuIBQIeWSb0av2qCRzyJOUQJZe5bBy1fE0gm3BNpDDsipn9v+sTSTWGBH6Sh/9StwewB
         5is9AzhhKuaAE0yRT43N7goKsHxLsii9LswnNARXa8SClgR6lpMWG+2qRYK99haGnXCd
         8th5aq57EajpBVFLzZ/iaQLGC3msnMHjnonsq0CT7fCM18JIzJb0OwJhx5jJIOlUPLJ7
         reCA==
X-Gm-Message-State: ANoB5pnbVXxrAxhMLf3HRwltO1cc/1b9FWn6Mw2h5mgC+toD1oMH5u4L
        mj8+glG/Y+UIszAdjje1td6x3NxVtqE=
X-Google-Smtp-Source: AA0mqf5cCYUGb/WtluErlpYfo/lYPvJ06D7BRnm73v0P72jARqo3vPBQTcbUmbgcbHwGXwry2R6Yqw==
X-Received: by 2002:a17:903:1109:b0:186:cb27:4e01 with SMTP id n9-20020a170903110900b00186cb274e01mr4705763plh.139.1668725725254;
        Thu, 17 Nov 2022 14:55:25 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id 205-20020a6217d6000000b0056da073b2b7sm1650629pfx.210.2022.11.17.14.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:55:24 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 03/23] bpf: Free inner_map_meta when btf_record_dup fails
Date:   Fri, 18 Nov 2022 04:24:50 +0530
Message-Id: <20221117225510.1676785-4-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=memxor@gmail.com; h=from:subject; bh=MFSSIOz61nwPTf4dvr2OI1CrS/lI0bHuXz3O9ayARiE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkbn5saVkB7HoV0UppUVjO3d8+04YMSFxUNHz9g 7TAArViJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5GwAKCRBM4MiGSL8RytBiD/ 9QkE6U8pkHAevfjjsmoLfxDQOuWXSVnhukSYCZ6MTS0u+ehcAlirOwF5HIK7cRkA3zWNvSNAaiKIIF jpITfglp5040S5GScX5GgnIg2ZQv2ASNMotf4RGa7sl7DWebOLLSegBkB3ClTQUqoV8B/Zi19uOaay QOW0liMhDfGpvCbX7tMC3d0zP17bcZbZJ0ef2GKV2c1iFwJTre/JZXWCiiT3+JLpAV6wIkNtVT/FZ6 e69Yfj427xQyj6Yg/ug+NHeC9Hnpz5Z7H9BvR4AEmQlARvyKjYlm5HLPIy0apvfEVqDRaPEK9D3whp +fVFF0TAzA7JuSSqq7/8w8vXSe9p7obpbO3V7O2l9B4fuB/QquUwWt3O3i/vpZMPyqMBfZRvdQ5BRs RYwuPZVmy+rdzG5qmuohp4FGyt5e60HuyIWGfNnMON7WncJz92zZj8FmhTZQga0Q+KxII0CKDbf9lS DgEfPKK5hTJO7cj5jEzXVxspUSBZExE51/3qEE35jvc/j3wvl5MrOtm9m2EPKV/Hr73BOMvz3D9etz 82s2XRuQkFd4W9ROWKS6HJIJvYKE9hJZY9Asrjxa3rqVsSEgZyWBUTSwerkRaHXlITMQJ9f+W/IhBI OfOW5B3ho7P6UW3JALG9Ik+5GNMWEZiCwzd6NwE/pEgTbRLb7E/trBNk1cbQ==
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

