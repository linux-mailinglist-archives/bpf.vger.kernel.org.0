Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FA26E8B2F
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 09:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjDTHPZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 03:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbjDTHPX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 03:15:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EADC2D64
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-244a5ccf13eso434965a91.2
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681974918; x=1684566918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciYtZE+NnBP4Wob7rRX5QjZYtK5qsPuWDYIG5C+oJoE=;
        b=fupnlY2NFsWj0r6QmdJ80IEdjeR1e///Pgwz94NW9cJF9PYuStWlhnayfavrOo7xvO
         ffgT8X9+0HBtu+U3BLCNQa31WQnWnKH3RDT9uYPRE61yU23G8MTQn+JSUjnBBj2cUU5d
         XfZOHrofhTr39W5Y4jVlQhv3DSmlcp9iJsgDr3dDpb2XbCVov9Qdl1deVbwe/vZXYocx
         0/83riNAyvs5kIedMTTBH5maPegpNnqJCGq8iOsRU0tWE0wrilpvVpqbUuY6c2KDocos
         QrHXpU3y25FjXqQG0SfGVxuMnNPoooXi7Rgp2uj4ZTfzaSfKr7vWtXu7ijxczdzkrixT
         QPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974918; x=1684566918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciYtZE+NnBP4Wob7rRX5QjZYtK5qsPuWDYIG5C+oJoE=;
        b=ZG6QJpASz8SJohnGdc6Vrzr3Wo/bdBE7YE81nn6sxUvsezwxQSP7LTJFHghNbO5C4j
         CM/P6t4H1SHg8I2L01Ti4m0YlAtTWA45mX9+6eC8U16HTK2NyPI7uDuHPee7Td0VWv5e
         9cvb2rZO32dWkOfAPtcc0mAGVi2QpJR57HMSGyurlwjcTJxtFsAH1kqtplyMaoL0Rz1U
         h5QxVTSMq7PQqPELAL53ck2b1NdF1BGFBp8Yq0wiUhDgYQLUzB+OwmXPvVv9ygtqEjmZ
         NTN6TWjqOaN4n2CDDYNHs7s6eUDMz6A336vpdBhkeJ7aHoPiHFwijWIXISxirWtLx/OC
         wfhA==
X-Gm-Message-State: AAQBX9e6Q0wRqrV51lkWkBnsYCPtWj3XfPDO9bHREaPy5Mt09Wp4CVRk
        WCbJeK299pO7PE3UQpuxbqOXxfCcGzmpPA==
X-Google-Smtp-Source: AKy350bFKUDrRkpi39VflzFTezziBJtz+X4bktQISTcBA4Q1z37xBsOGx7O2EyzXIWu8pEB6vZ1mPw==
X-Received: by 2002:a17:90a:4597:b0:247:42bf:380e with SMTP id v23-20020a17090a459700b0024742bf380emr907329pjg.4.1681974918076;
        Thu, 20 Apr 2023 00:15:18 -0700 (PDT)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090acb8700b00246b5a609d2sm588208pju.27.2023.04.20.00.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:15:17 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
Date:   Thu, 20 Apr 2023 00:14:10 -0700
Message-Id: <20230420071414.570108-2-joannelkoong@gmail.com>
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

Add a new kfunc

int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end);

which adjusts the dynptr to reflect the new [start, end) interval.
In particular, it advances the offset of the dynptr by "start" bytes,
and if end is less than the size of the dynptr, then this will trim the
dynptr accordingly.

Adjusting the dynptr interval may be useful in certain situations.
For example, when hashing which takes in generic dynptrs, if the dynptr
points to a struct but only a certain memory region inside the struct
should be hashed, adjust can be used to narrow in on the
specific region to hash.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/helpers.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 00e5fb0682ac..7ddf63ac93ce 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
 
+static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_size)
+{
+	u32 metadata = ptr->size & ~DYNPTR_SIZE_MASK;
+
+	ptr->size = new_size | metadata;
+}
+
 int bpf_dynptr_check_size(u32 size)
 {
 	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
@@ -2297,6 +2304,24 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 o
 	return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
 }
 
+__bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end)
+{
+	u32 size;
+
+	if (!ptr->data || start > end)
+		return -EINVAL;
+
+	size = bpf_dynptr_get_size(ptr);
+
+	if (start > size || end > size)
+		return -ERANGE;
+
+	ptr->offset += start;
+	bpf_dynptr_set_size(ptr, end - start);
+
+	return 0;
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_SET8_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.34.1

