Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB5B667A2E
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjALQBQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjALQAt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:49 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22B63FE
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:41 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a25so9627101qto.10
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uihgwx1T6nkcpHBqU4nGrP1KTt8QoN0fwfvzg1wucPQ=;
        b=YodB935w9n5znFspbhXFeVSzFSE5JsGjdXO3T7QxM4mYUliNC+TPtRxw2JuS3qxGjU
         I2i8BfBS5PcscctdPUhc//YULRIwAZeg1mS5UNvHjm9u/Zq0t8pH/dyxAZz5micRnLjo
         e9u6Pz9RSOvxKChnvdrDNq5sufGnV3XuasdTaZw30pseNUm8v1DjX0A8FUR+KM2BkclZ
         qGgHThyqikGWYyWV81ZlED6FUAeDFbhe+Z7dvttH3V4gRa3OZMZhslzzSITLkPBaTLoy
         eMSdtv+WJhmL/l2hEXvVt+Aczvbpaz13WvZDnwvZLHETZHye1E7tiOLO2wLcwF+0sVFp
         wgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uihgwx1T6nkcpHBqU4nGrP1KTt8QoN0fwfvzg1wucPQ=;
        b=r7PX8bakeuap6cvXHIJT7GPt92elV2IAtx+3sLFH8zFv/g8kmrNw6/NCpH2RPgH5Ua
         nNMVREe26Bqve2jLgIL0DDb0vE4f3RwSzVC3o/vlyh1L6ZTMtLO2H85SKbMxkMTKuMdE
         GxvppDcG7BuxA5pr0KM4e9VZDN7EYkhp0U2ks4VT5GUXTtzpHdRRMi6kVxBcMgGcca+L
         jQdvqXWRqWf8OUUV29bRAbMRFVKRgFnBPeyVLPJC1YXTn41RKFcLUiJ75Ec5eY46fqaI
         lRmWwPJX4cbLF8T6zOBl16MIGQcncFqAuHLjrTujTHRWB2fK+8cAHcYv7kADL1l9080y
         /97A==
X-Gm-Message-State: AFqh2kr40Tl7QAdfVx5bjpFwpe/8LvRSpRDFcIwUeBmduqEYb49S3Pgm
        pc30iIllxVrOZB1uS3FDO6g=
X-Google-Smtp-Source: AMrXdXs0Up2USZyI0o43Vk0+bBMZSWgXv+eJ2HsxBP+9FPA9u+0LO7bceUcOwMvSq9Zd58JbXWCPBg==
X-Received: by 2002:a05:622a:5a98:b0:3ab:8c3f:328b with SMTP id fz24-20020a05622a5a9800b003ab8c3f328bmr94053633qtb.4.1673538821529;
        Thu, 12 Jan 2023 07:53:41 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:40 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     42.hyeyoo@gmail.com, vbabka@suse.cz, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 06/11] mm: util: introduce kvsize()
Date:   Thu, 12 Jan 2023 15:53:21 +0000
Message-Id: <20230112155326.26902-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230112155326.26902-1-laoar.shao@gmail.com>
References: <20230112155326.26902-1-laoar.shao@gmail.com>
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

Introduce a new help kvsize() to report full size of underlying allocation
of a kmalloc'ed addr or vmalloc'ed addr.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/slab.h | 10 ++++++++++
 mm/util.c            | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 45af703..740ddf7 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -226,6 +226,15 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
  */
 size_t ksize(const void *objp);
 
+/**
+ * ksize_full - Report full size of each accounted objp
+ * @objp: pointer to the object
+ *
+ * The difference between ksize() and ksize_full() is that ksize_full()
+ * includes the extra space which is used to store obj_cgroup membership.
+ */
+size_t ksize_full(const void *objp);
+
 #ifdef CONFIG_PRINTK
 bool kmem_valid_obj(void *object);
 void kmem_dump_obj(void *object);
@@ -762,6 +771,7 @@ static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t fla
 
 extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
 		      __realloc_size(3);
+extern size_t kvsize(const void *addr);
 extern void kvfree(const void *addr);
 extern void kvfree_sensitive(const void *addr, size_t len);
 
diff --git a/mm/util.c b/mm/util.c
index b56c92f..d6be4f94 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -610,6 +610,21 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 EXPORT_SYMBOL(kvmalloc_node);
 
 /**
+ * kvsize() - Report full size of underlying allocation of adddr
+ * @addr: Pointer to kmalloc'ed or vmalloc'ed memory
+ *
+ * kvsize reports full size of underlying allocation of a kmalloc'ed addr
+ * or a vmalloc'ed addr.
+ */
+size_t kvsize(const void *addr)
+{
+	if (is_vmalloc_addr(addr))
+		return vsize(addr);
+
+	return ksize_full(addr);
+}
+
+/**
  * kvfree() - Free memory.
  * @addr: Pointer to allocated memory.
  *
-- 
1.8.3.1

