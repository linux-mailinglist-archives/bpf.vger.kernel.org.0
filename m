Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A876DBE6A
	for <lists+bpf@lfdr.de>; Sun,  9 Apr 2023 05:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDIDeu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 23:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDIDet (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 23:34:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411EC5BB9
        for <bpf@vger.kernel.org>; Sat,  8 Apr 2023 20:34:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so1931159pjb.1
        for <bpf@vger.kernel.org>; Sat, 08 Apr 2023 20:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681011287; x=1683603287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlLYW47o9VHsQgVu1dp+JqdiOZLMyMbCaE7IZrC/EGI=;
        b=O4MJIq49pGRVurldvZC8CagOF5y8ieHu0rd4c0yoNjW+S3clN9cOUkQK2GRJ3hqCSN
         8VMgwn1Q+uFIraTKfT9OqETwpvcz7l82Q34od2Q/254pv/HttUREXFdO+gK7i3RJAwo6
         ZTywQpELge+SSxSaZQzhcW0oGWdoVL8y5tHHBXeMX44u7a3IIirGDhATZeHjGtATgV46
         jZO+T57oFH8B1KhrBNbI8t1SDL7foZYJqlwB6CSd4Fxc8lzPNh5R/3nNn7o7i/IiVbJg
         JGav6dp7QuFSe+ngVd03R9u+KDS2qwsDpNZOmBSQo6owiucNt2zYvXWGGFNT7j9uVorr
         uxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681011287; x=1683603287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlLYW47o9VHsQgVu1dp+JqdiOZLMyMbCaE7IZrC/EGI=;
        b=1MovGM8ntQxbdx9rx/kt7YUkZDgcgNL6Yki5SphYwxjYkQnWHkIS6A4zs/w6SKavGI
         u+pMpFIaGCrQkYeethe4S8CL1PwvnaTR9J1DjUmuL7fU6dqynEOI6B7UVqD8KxrbFsLp
         dyhOVZqckoXPwnvipfBI3qBJXVT+loMbRIIuYqR/71cls0WkpiRX4yCaZDeauDTVy37O
         K8EwZP7aDQq0dXxqwQeNvZmD4eKLxulAZ66T7J+gL5uyYo5P2SX9ufJOYrf7+Oq7WBVw
         iiwkThkmx5Jifod2aq7XfxpPzabHHl7cU6Z8oQ4xPXqovax5u6qg4oavoU4l2y+I4is5
         BvLA==
X-Gm-Message-State: AAQBX9c44Mvg0ayMC0uDvaZzWLTCwlaOPGSvZ5tMOHTFZyZnkK3TvJ1E
        SgzDF509ndJcGLsVHPkJi1RZKdJvuTtPIg==
X-Google-Smtp-Source: AKy350bchrxnrH8/FS991XNypMTq+HUE7e5lzlUpn5GVaCE6J7f1yt75QI5RUHqAntNybDQ8LCzEfQ==
X-Received: by 2002:a17:903:3093:b0:1a2:ca:c6cd with SMTP id u19-20020a170903309300b001a200cac6cdmr7122304plc.43.1681011287597;
        Sat, 08 Apr 2023 20:34:47 -0700 (PDT)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902fe8200b001a212a93295sm5185877plm.189.2023.04.08.20.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 20:34:47 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v1 bpf-next 3/5] bpf: Add bpf_dynptr_get_size and bpf_dynptr_get_offset
Date:   Sat,  8 Apr 2023 20:34:29 -0700
Message-Id: <20230409033431.3992432-4-joannelkoong@gmail.com>
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

bpf_dynptr_get_size returns the number of useable bytes in a dynptr and
bpf_dynptr_get_offset returns the current offset into the dynptr.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h      |  2 +-
 kernel/bpf/helpers.c     | 24 +++++++++++++++++++++---
 kernel/trace/bpf_trace.c |  4 ++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 002a811b6b90..2a73ddd06e55 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1167,7 +1167,7 @@ enum bpf_dynptr_type {
 };
 
 int bpf_dynptr_check_size(u32 size);
-u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr);
+u32 __bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e4e84e92a4c6..bac4c6fe49f0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1443,7 +1443,7 @@ static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *pt
 	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
 }
 
-u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
+u32 __bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
@@ -1476,7 +1476,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 
 static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
 {
-	u32 size = bpf_dynptr_get_size(ptr);
+	u32 size = __bpf_dynptr_get_size(ptr);
 
 	if (len > size || offset > size - len)
 		return -E2BIG;
@@ -2290,7 +2290,7 @@ static int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 off_inc, u32 sz_de
 	if (!ptr->data)
 		return -EINVAL;
 
-	size = bpf_dynptr_get_size(ptr);
+	size = __bpf_dynptr_get_size(ptr);
 
 	if (sz_dec > size)
 		return -ERANGE;
@@ -2335,6 +2335,22 @@ __bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
 	return __bpf_dynptr_is_rdonly(ptr);
 }
 
+__bpf_kfunc __u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
+{
+	if (!ptr->data)
+		return -EINVAL;
+
+	return __bpf_dynptr_get_size(ptr);
+}
+
+__bpf_kfunc __u32 bpf_dynptr_get_offset(const struct bpf_dynptr_kern *ptr)
+{
+	if (!ptr->data)
+		return -EINVAL;
+
+	return ptr->offset;
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -2411,6 +2427,8 @@ BTF_ID_FLAGS(func, bpf_dynptr_trim)
 BTF_ID_FLAGS(func, bpf_dynptr_advance)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
+BTF_ID_FLAGS(func, bpf_dynptr_get_size)
+BTF_ID_FLAGS(func, bpf_dynptr_get_offset)
 BTF_SET8_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bcf91bc7bf71..f30bdc72d26c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1349,9 +1349,9 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 	}
 
 	return verify_pkcs7_signature(data_ptr->data,
-				      bpf_dynptr_get_size(data_ptr),
+				      __bpf_dynptr_get_size(data_ptr),
 				      sig_ptr->data,
-				      bpf_dynptr_get_size(sig_ptr),
+				      __bpf_dynptr_get_size(sig_ptr),
 				      trusted_keyring->key,
 				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
 				      NULL);
-- 
2.34.1

