Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2A26E8B31
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 09:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjDTHP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 03:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjDTHP2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 03:15:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E41E3AA8
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:24 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5144043d9d1so495503a12.3
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681974923; x=1684566923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8QTAx0duk2qlOWc4EEWHRFN0AU0IXkRDr5X5he73kM=;
        b=O9p8CchvhtMksXafeURIu7sHjCdTNtcy1aUlOmT3CC6K9C0GMCK5y5al1giI7yxRUU
         iDhWOq8CKGnWP4GDEjn/eKj+CYlnVUEvD8dVdeegPAQb/hTL9ftTWRyY1Y4hGvHOAzDO
         Xq/RzoRuk1ojWerjB2aylK4qVYtE/JAYAWNbY123nhkJdAsgcn+oh7gpJuiWaT+eWdhp
         brgwiTno3HHmBhNOLIDq/XRKWg1wX5n0Mixdeg393hmbgWp3ekd4hMdePBn4VYNiyPnH
         qyEknhP/pjSksLiSkrxpNexgLnyXd1OQ2qWZ5EuefOIJSVlu13affNDBKN2K3NbI6YTh
         dfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974923; x=1684566923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8QTAx0duk2qlOWc4EEWHRFN0AU0IXkRDr5X5he73kM=;
        b=Vn5XVPpAvu1deS2sQ5Koq832qoqzvCUYCcNz1E0qq2MRKLko647fwVLAJNef1kterU
         RzdPWC9XULJkSuQpqP8v40/D1SVCdYAZPVtH7f3qAp0VR5cI0t+QkKJ/oFCGIN/K92oH
         tvFGtA1jW5KZmLO/3GVWkpgOR2InZcJpyfP2CLjl35rcY9CqN6a6m7nlRPR4bVLDUe6M
         V7p31emdGltgozccyUaKzF/ipFjIpUANxB1r5aJT/Tdh0V7SEKMAx0KPkqgEl3KRRXc8
         sCc/eunLJwDhi6Y5wOKuSNI2XUE+5zq1J9wwfKDT8WAJKsRXvUf3fYM/FvWKpcWzR2O3
         NlyA==
X-Gm-Message-State: AAQBX9d4zZr41z+yXFNQ9O+7zs21ekMbRCoydUPMs44ZqdhTvu2HRKXI
        QrBLADCzRzg0YoZARMHsJcPRLaBFWBONRg==
X-Google-Smtp-Source: AKy350ZBaEf8v6UlLxJ3eJ+Yt210F6pNVcvy/yl7MVlzM37/ZmMtgnh2P5WrRU6s5wHz5sQX6qvc9w==
X-Received: by 2002:a17:90b:10c:b0:23f:9fac:6b35 with SMTP id p12-20020a17090b010c00b0023f9fac6b35mr705035pjz.39.1681974923172;
        Thu, 20 Apr 2023 00:15:23 -0700 (PDT)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090acb8700b00246b5a609d2sm588208pju.27.2023.04.20.00.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:15:22 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 2/5] bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
Date:   Thu, 20 Apr 2023 00:14:11 -0700
Message-Id: <20230420071414.570108-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420071414.570108-1-joannelkoong@gmail.com>
References: <20230420071414.570108-1-joannelkoong@gmail.com>
MIME-Version: 1.0
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

bpf_dynptr_is_null returns true if the dynptr is null / invalid
(determined by whether ptr->data is NULL), else false if
the dynptr is a valid dynptr.

bpf_dynptr_is_rdonly returns true if the dynptr is read-only,
else false if the dynptr is read-writable. If the dynptr is
null / invalid, false is returned by default.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/helpers.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7ddf63ac93ce..566ed89f173b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1423,7 +1423,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 #define DYNPTR_SIZE_MASK	0xFFFFFF
 #define DYNPTR_RDONLY_BIT	BIT(31)
 
-static bool bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
+static bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_RDONLY_BIT;
 }
@@ -1570,7 +1570,7 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, v
 	enum bpf_dynptr_type type;
 	int err;
 
-	if (!dst->data || bpf_dynptr_is_rdonly(dst))
+	if (!dst->data || __bpf_dynptr_is_rdonly(dst))
 		return -EINVAL;
 
 	err = bpf_dynptr_check_off_len(dst, offset, len);
@@ -1626,7 +1626,7 @@ BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u32, offset, u3
 	if (err)
 		return 0;
 
-	if (bpf_dynptr_is_rdonly(ptr))
+	if (__bpf_dynptr_is_rdonly(ptr))
 		return 0;
 
 	type = bpf_dynptr_get_type(ptr);
@@ -2276,7 +2276,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
 					void *buffer, u32 buffer__szk)
 {
-	if (!ptr->data || bpf_dynptr_is_rdonly(ptr))
+	if (!ptr->data || __bpf_dynptr_is_rdonly(ptr))
 		return NULL;
 
 	/* bpf_dynptr_slice_rdwr is the same logic as bpf_dynptr_slice.
@@ -2322,6 +2322,19 @@ __bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 en
 	return 0;
 }
 
+__bpf_kfunc bool bpf_dynptr_is_null(struct bpf_dynptr_kern *ptr)
+{
+	return !ptr->data;
+}
+
+__bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
+{
+	if (!ptr->data)
+		return false;
+
+	return __bpf_dynptr_is_rdonly(ptr);
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -2395,6 +2408,8 @@ BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
+BTF_ID_FLAGS(func, bpf_dynptr_is_null)
+BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_SET8_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.34.1

