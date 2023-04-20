Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6BD6E8B30
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 09:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjDTHP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 03:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjDTHP2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 03:15:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D2C35BE
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24986c7cf2dso544619a91.2
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681974926; x=1684566926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avaNQJACzMkp3LFkwVWmDzFw4o9gXtdfTz3/P7b1LP4=;
        b=iwn5BSZJAyEG5mBRvrnXCf7sanVr4Nk7+21JtEJ72IZEqiXa8VLmp6195eOlBxVsg9
         J5nZ0uf9w5Gs+4aUZ4Q9LVDzBrwPATUpjopleSCG1NaKFyN8RDRH/JFL2Zji7A0NXK2k
         2nZGMFXye+Hbhya8ideuB0tMfWaLBMz88VohxfDtAgFRf0hFDthuQAPTEcCMNXpF0o5Y
         VrF2avFgpPzPHfedIzYKFSt/2mC5t7DzqDbba5NHo4iCBj5rQ1Qe+L17vgot/n3OEgNt
         090IflXvUM83KWXcH3/WcRof+3LiTh7kwl06UktcTJQbewPausqLuv2gE0RhOq233ZZz
         AaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974926; x=1684566926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avaNQJACzMkp3LFkwVWmDzFw4o9gXtdfTz3/P7b1LP4=;
        b=JgbUdHYLtqANMqJF9/9GUaNgAakd116YEEWlqSp8IShmIz5QqbWZLeXZRvMqQHd92U
         NwjUYSaTUTUFVF+DSnucJxbvsq9nIVgfqeEvzvnGjsqlsLtb/o5MaBV+PfKwRre/gc8k
         1pqt7Gajk4yDncwhyW4xa4oeAA9VJlk37ABxb7RvswLLcYwIvwAzYAviAyiXLsts0mlm
         r2MV1BiTo/LTlwXpVFc8r2If8mky6K8GRSNcwAqKGu8qWiT6Z/DOWoTicSq+PoSZ3yHd
         gx6Nj8r3eG61byevQVKn6ydIRfgS//50dvmn+OLGcVjtZnU84DzINzj9zmw7frlgMh97
         qLYw==
X-Gm-Message-State: AAQBX9doyX63v/cEH+qp0reIx3JpdEUwFKCwhYfrdW9DFUEDn1uLmTQa
        XCRU1wPvVqQdYs7hKD+pvfnHtTkwYYyVEQ==
X-Google-Smtp-Source: AKy350YAH4+VIaQu3sAuSRpLY7EFTIpiubCVCb7JcOHr0eESt90gPhDooQ9dqnuUGAsHJRRwCt+Low==
X-Received: by 2002:a17:90b:f89:b0:247:13f5:47de with SMTP id ft9-20020a17090b0f8900b0024713f547demr639294pjb.44.1681974926458;
        Thu, 20 Apr 2023 00:15:26 -0700 (PDT)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090acb8700b00246b5a609d2sm588208pju.27.2023.04.20.00.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:15:26 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 3/5] bpf: Add bpf_dynptr_size
Date:   Thu, 20 Apr 2023 00:14:12 -0700
Message-Id: <20230420071414.570108-4-joannelkoong@gmail.com>
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

bpf_dynptr_size returns the number of useable bytes in a dynptr.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h      |  2 +-
 kernel/bpf/helpers.c     | 15 ++++++++++++---
 kernel/trace/bpf_trace.c |  4 ++--
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 18b592fde896..a4429dac3a1b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1197,7 +1197,7 @@ enum bpf_dynptr_type {
 };
 
 int bpf_dynptr_check_size(u32 size);
-u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr);
+u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 566ed89f173b..9018646b86db 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1443,7 +1443,7 @@ static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *pt
 	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
 }
 
-u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
+u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
@@ -1476,7 +1476,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 
 static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
 {
-	u32 size = bpf_dynptr_get_size(ptr);
+	u32 size = __bpf_dynptr_size(ptr);
 
 	if (len > size || offset > size - len)
 		return -E2BIG;
@@ -2311,7 +2311,7 @@ __bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 en
 	if (!ptr->data || start > end)
 		return -EINVAL;
 
-	size = bpf_dynptr_get_size(ptr);
+	size = __bpf_dynptr_size(ptr);
 
 	if (start > size || end > size)
 		return -ERANGE;
@@ -2335,6 +2335,14 @@ __bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
 	return __bpf_dynptr_is_rdonly(ptr);
 }
 
+__bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
+{
+	if (!ptr->data)
+		return -EINVAL;
+
+	return __bpf_dynptr_size(ptr);
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -2410,6 +2418,7 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
+BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_SET8_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bcf91bc7bf71..8deb22a99abe 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1349,9 +1349,9 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 	}
 
 	return verify_pkcs7_signature(data_ptr->data,
-				      bpf_dynptr_get_size(data_ptr),
+				      __bpf_dynptr_size(data_ptr),
 				      sig_ptr->data,
-				      bpf_dynptr_get_size(sig_ptr),
+				      __bpf_dynptr_size(sig_ptr),
 				      trusted_keyring->key,
 				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
 				      NULL);
-- 
2.34.1

