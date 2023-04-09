Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C0C6DBE69
	for <lists+bpf@lfdr.de>; Sun,  9 Apr 2023 05:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjDIDet (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 23:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjDIDer (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 23:34:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC74EDC
        for <bpf@vger.kernel.org>; Sat,  8 Apr 2023 20:34:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w11so2068159plp.13
        for <bpf@vger.kernel.org>; Sat, 08 Apr 2023 20:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681011286; x=1683603286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmHAmUMzUYEeB3nfvemfvISCtgRUqRW78d11epxTKNM=;
        b=GCaxeNkfxoBgyscuKnWbpwRHEhygbxXFpwbF150cYRNj9U5orbflkC3Ul/N3qTtbmS
         7Mg2x+7L8IoA0FsudN55XWLSjlTi8jQsIYydMcwJtr8fFtzos6Lrr7bnaTwsYIXkQ1Tk
         QHEYmmKoeBhSaQnmGbZh7wxpUvZ8m3S7qZZhakCtlvc09cBzKgo5iKAd38UXtkghH+hz
         U/+WxgbNTLw/pKjs1ZOp6ajDh7RSB30X+im9kBhILMrojEv0TGKtObczCRbjYi9AVvvO
         wD7Et0BosvqKkRPq3/TQGz8z8MtQ99sa+35xzy5/Ozo7jJbiZx6jVr+B7Ocx0gEj8lXR
         1H9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681011286; x=1683603286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmHAmUMzUYEeB3nfvemfvISCtgRUqRW78d11epxTKNM=;
        b=2bDbIU2LgkiIQ6FrU6Bj9G7ymeHLm/qoR2w6vGtaecLeYmzF5FynjhiMxzM34COBfz
         5NgdIyLtZpBV53nGv083qBKV9d/7aLoPjzsMo8Kd0eOia+XPwMk7GqRCh98psQbxzF4D
         LIQNRNlJcqgOGLv42P8C2I/Rk0J2ss+x3XsfTLZgUnIIAo46F9qH/gH5/lpXBoQMWUmm
         Wr2LXKLaSShfdE9uTAtfyfX6lS1juaKCt1koebBqVV5ZjjBcLDo9jUwrjxWeq8jhGoFo
         wNMO4RN1bs+wJstTqHITJfeLO8b+2PH1l6IRi213IopsfQnQqo6ojX03hohImR3/4OHT
         KRAQ==
X-Gm-Message-State: AAQBX9ff1QYgquaSnUwkdeviFDQM8HMeHGVdEY2cxR7DGuQvpmfnueic
        TPx9zZMpep7dlTLhcefEPUP94a7wKyDf/w==
X-Google-Smtp-Source: AKy350atIiGWPYoUdOo1IbLjiQgko/0Bg0/MbyY0b4KLR1Ifu0PidtYjnc64khp0cUVgC5hJkKBxeA==
X-Received: by 2002:a17:903:124d:b0:1a1:ca37:525a with SMTP id u13-20020a170903124d00b001a1ca37525amr5005454plh.36.1681011285932;
        Sat, 08 Apr 2023 20:34:45 -0700 (PDT)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902fe8200b001a212a93295sm5185877plm.189.2023.04.08.20.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 20:34:45 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v1 bpf-next 2/5] bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
Date:   Sat,  8 Apr 2023 20:34:28 -0700
Message-Id: <20230409033431.3992432-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230409033431.3992432-1-joannelkoong@gmail.com>
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_dynptr_is_null returns true if the dynptr is null / invalid
(determined by whether ptr->data is NULL), else false if
the dynptr is a valid dynptr.

bpf_dynptr_is_rdonly returns true if the dynptr is read-only,
else false if the dynptr is read-writable.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/helpers.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 51b4c4b5dbed..e4e84e92a4c6 100644
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
@@ -2254,7 +2254,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
 					void *buffer, u32 buffer__szk)
 {
-	if (!ptr->data || bpf_dynptr_is_rdonly(ptr))
+	if (!ptr->data || __bpf_dynptr_is_rdonly(ptr))
 		return NULL;
 
 	/* bpf_dynptr_slice_rdwr is the same logic as bpf_dynptr_slice.
@@ -2322,6 +2322,19 @@ __bpf_kfunc int bpf_dynptr_trim(struct bpf_dynptr_kern *ptr, u32 len)
 	return bpf_dynptr_adjust(ptr, 0, len);
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
@@ -2396,6 +2409,8 @@ BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_trim)
 BTF_ID_FLAGS(func, bpf_dynptr_advance)
+BTF_ID_FLAGS(func, bpf_dynptr_is_null)
+BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_SET8_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.34.1

