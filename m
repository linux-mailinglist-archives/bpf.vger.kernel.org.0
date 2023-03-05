Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB646AAFA1
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCEMqn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCEMqm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:42 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648FCEFBB
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:41 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id b12so1203063ilf.9
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HN2rAcYUn7jZvakDvBEUWKRCMQqKtSQ/uWq6kAxCHY=;
        b=aObpSZED69kq8e+/TytOEfo/js+sfMmz3wuTKx4u7b0ZipF9D2dNieHXL7wqWHAWHE
         xsxIorPwnRTAzoqdsNUMHNHBQRZzz0CEtZBBqQsRpbOqnGoKXnfvuafJgbT+dgVOROTg
         2MVQ0RW4/7KbFF2/xn2pyZ2oJo+n4WcU3C7FFl4U31M088AaRaIHdKkqOM/kL9Py6VY3
         dBAVcG4s45JX5Ce5qwx9kCNRnrCErcg554EnHOYauXAUsEO3pL00MrIbxsAN1L/VjMKw
         4etkDRGH3Cj8x7rb3k5QNWLLki+iHfSaYb0CoriaYW3A74jHYhxBGDcl0BtLwFxRBBh5
         P4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HN2rAcYUn7jZvakDvBEUWKRCMQqKtSQ/uWq6kAxCHY=;
        b=Qw6FM+Vd85SycvIIc9ZA7GVpC4juu7qqkQQWQD6n6cVY36faHEqlBxy4QCkLIgDzeC
         osvUhEBDebZ7frCP4LY3tZnvEwYakUOkUypoxAdOUnfwaz8hz2dM/LazTriX/Mpd8qOV
         wtOZHoCBFMBs6NrVI56Mfow69KzIF8mPKJ/TX2EQ0fCXwHhPx9JWSVsxXf4L2ydEGHr2
         y5BVBiNFkJll8AzBTUGwzMccvp/swLW/b7F0nrqz0Rd682EGmhvGWG7yQIRvZwyLMkqQ
         RgXumeoHpXO9U1aOJ2bbYEZD2/jbWbDrlfZ3EBXMa5y37kFlW73fFASwqyXtscfztQvr
         o7Ww==
X-Gm-Message-State: AO0yUKVIidJ9pteKblRKgJeXIab0ZJ77KJUl6lUNXN5FZF+7oEufluci
        9d5B8tN+zuT1Sq5bxHPV5i2Nh3xOXaAmzfhHF94=
X-Google-Smtp-Source: AK7set/07EKa7Ig4p6YQHWgNBdU/NlsFrTDIV3ELmaJ2jLGO0c+vehs3gARJksK8LqWkJnR9niyzqw==
X-Received: by 2002:a05:6e02:18ce:b0:315:9b3a:2f56 with SMTP id s14-20020a056e0218ce00b003159b3a2f56mr6291223ilu.28.1678020401085;
        Sun, 05 Mar 2023 04:46:41 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:40 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 17/18] bpf: offload map memory usage
Date:   Sun,  5 Mar 2023 12:46:14 +0000
Message-Id: <20230305124615.12358-18-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230305124615.12358-1-laoar.shao@gmail.com>
References: <20230305124615.12358-1-laoar.shao@gmail.com>
MIME-Version: 1.0
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

A new helper is introduced to calculate offload map memory usage. But
currently the memory dynamically allocated in netdev dev_ops, like
nsim_map_update_elem, is not counted. Let's just put it aside now.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h  | 6 ++++++
 kernel/bpf/offload.c | 6 ++++++
 kernel/bpf/syscall.c | 1 +
 3 files changed, 13 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9059520..6792a79 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2624,6 +2624,7 @@ static inline bool bpf_map_is_offloaded(struct bpf_map *map)
 
 struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr);
 void bpf_map_offload_map_free(struct bpf_map *map);
+u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
 int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 			      const union bpf_attr *kattr,
 			      union bpf_attr __user *uattr);
@@ -2695,6 +2696,11 @@ static inline void bpf_map_offload_map_free(struct bpf_map *map)
 {
 }
 
+static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map)
+{
+	return 0;
+}
+
 static inline int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 					    const union bpf_attr *kattr,
 					    union bpf_attr __user *uattr)
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0c85e06..d9c9f45 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -563,6 +563,12 @@ void bpf_map_offload_map_free(struct bpf_map *map)
 	bpf_map_area_free(offmap);
 }
 
+u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map)
+{
+	/* The memory dynamically allocated in netdev dev_ops is not counted */
+	return sizeof(struct bpf_offloaded_map);
+}
+
 int bpf_map_offload_lookup_elem(struct bpf_map *map, void *key, void *value)
 {
 	struct bpf_offloaded_map *offmap = map_to_offmap(map);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 073957c..3532c1e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -105,6 +105,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr,
 	.map_alloc = bpf_map_offload_map_alloc,
 	.map_free = bpf_map_offload_map_free,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = bpf_map_offload_map_mem_usage,
 };
 
 static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
-- 
1.8.3.1

