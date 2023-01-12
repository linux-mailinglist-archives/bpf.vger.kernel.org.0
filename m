Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21435667A2D
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjALQBO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbjALQAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:48 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D46638B
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:39 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id jr10so9500137qtb.7
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PdPmTP/6nNwfuUbfoIGYl12UKrMMnWaGWGE68CKK00=;
        b=mN5ObGrhWrxMJkdoooArLIKC8XD0Tvow9VTzY+Dt+bM8q/RM6rw039QTNBaDeGeO3W
         jc5ev4ZPmIqrRhwhGdLdkzTzN8gZKgSqZNiEFBB8OAHgukMGMx+f/InoklehDY6tX4bB
         CUnIWUqLRKGvCWlsJSI5IP1MkFCBw1ZTcSf2C/sDXTI6RYUmopTDbtNDJP+JyheZzkFf
         TzLt3sLAhYi+rdZI7qQ1UV42ayBjgKZFUszSk4A+zhvgOxP4u/jn2S3xHtTb2g+P1y58
         CnyYcLq2SXGRAvEUlWv58eL9NelCvX7CcHE8aby/6geeLc5bxLV+FACVmTuHiL8tHB3/
         36HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PdPmTP/6nNwfuUbfoIGYl12UKrMMnWaGWGE68CKK00=;
        b=NyPQ0r2G5c2h1PxN2Kr/KA0AXpwabFQ1Fq3gPqlLH8z/GFsw0Zyj+AekkH4ewsqDZO
         IFqz62xMVB8wqFQSgd4E+bJin913vT0cmFauDxUJZOWWJZB/sqrsYLnL4YZLmhZsrRR6
         4AqcD/kwWzfC5e+giSpm497gBs4qsRX95iPf3T/DobIGTOcqgJaX6x6PcW5k3bovxqha
         5ehNVNQ+JHoHqRCDx069ywj88Lm6JPhoMBgbzfn9o6T6rzemSiANx2mwsjSR4y9aCntm
         SbyDs8vt77ZQizcFwUS8jsOKHGp11UX62WWFE9BMeaHAKvGnDAVfMHNpIL2KqxEi95RD
         JhCA==
X-Gm-Message-State: AFqh2kqM1/RTrFI+AjpaMSa2hDg6835aAhW61I5k/LbTAMj3dgQNsBOU
        7UUKaPZL6Cy3ElzbTwuSczywwDLd83Baol4Xn1U=
X-Google-Smtp-Source: AMrXdXvcvv5QnOw+ucO2xICHIrhkKnumytKrPNexoUtZMl0/bJueZhRxVfPyCqg8K84Xgk088KoBmg==
X-Received: by 2002:a05:622a:1741:b0:3a8:2716:ac2d with SMTP id l1-20020a05622a174100b003a82716ac2dmr149575319qtk.56.1673538818785;
        Thu, 12 Jan 2023 07:53:38 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:38 -0800 (PST)
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
Subject: [RFC PATCH bpf-next v2 04/11] mm: slab: introduce ksize_full()
Date:   Thu, 12 Jan 2023 15:53:19 +0000
Message-Id: <20230112155326.26902-5-laoar.shao@gmail.com>
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

When the object is charged to kmemcg, it will alloc extra memory to
store the kmemcg ownership, so introduce a new helper to include this
memory size.

The reason we introduce a new helper other than changing the current
helper ksize() is that the allocation of the kmemcg ownership is a
nested allocation, which is independent of the original allocation. Some
user may relays on ksize() to get the layout of this slab, so we'd
better not changing it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/slab.h        |  2 +-
 mm/slab_common.c | 52 ++++++++++++++++++++++++++++++++++++----------------
 mm/slob.c        |  2 +-
 3 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 35e0b3b..e07ae90 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -681,7 +681,7 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 
 #endif /* CONFIG_SLOB */
 
-size_t __ksize(const void *objp);
+size_t ___ksize(const void *objp, bool full);
 
 static inline size_t slab_ksize(const struct kmem_cache *s)
 {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1cba98a..4f1e2bc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1021,21 +1021,11 @@ void kfree(const void *object)
 }
 EXPORT_SYMBOL(kfree);
 
-/**
- * __ksize -- Report full size of underlying allocation
- * @object: pointer to the object
- *
- * This should only be used internally to query the true size of allocations.
- * It is not meant to be a way to discover the usable size of an allocation
- * after the fact. Instead, use kmalloc_size_roundup(). Using memory beyond
- * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
- * and/or FORTIFY_SOURCE.
- *
- * Return: size of the actual memory used by @object in bytes
- */
-size_t __ksize(const void *object)
+size_t ___ksize(const void *object, bool full)
 {
+	size_t kmemcg_size = 0;
 	struct folio *folio;
+	struct slab *slab;
 
 	if (unlikely(object == ZERO_SIZE_PTR))
 		return 0;
@@ -1054,7 +1044,27 @@ size_t __ksize(const void *object)
 	skip_orig_size_check(folio_slab(folio)->slab_cache, object);
 #endif
 
-	return slab_ksize(folio_slab(folio)->slab_cache);
+	slab = folio_slab(folio);
+	if (memcg_kmem_enabled() && full && slab_objcgs(slab))
+		kmemcg_size = sizeof(struct obj_cgroup *);
+	return slab_ksize(slab->slab_cache) + kmemcg_size;
+}
+
+/**
+ * __ksize -- Report full size of underlying allocation
+ * @object: pointer to the object
+ *
+ * This should only be used internally to query the true size of allocations.
+ * It is not meant to be a way to discover the usable size of an allocation
+ * after the fact. Instead, use kmalloc_size_roundup(). Using memory beyond
+ * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
+ * and/or FORTIFY_SOURCE.
+ *
+ * Return: size of the actual memory used by @object in bytes
+ */
+size_t __ksize(const void *object)
+{
+	return ___ksize(object, false);
 }
 
 void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
@@ -1428,7 +1438,7 @@ void kfree_sensitive(const void *p)
 }
 EXPORT_SYMBOL(kfree_sensitive);
 
-size_t ksize(const void *objp)
+size_t _ksize(const void *objp, bool full)
 {
 	/*
 	 * We need to first check that the pointer to the object is valid.
@@ -1448,10 +1458,20 @@ size_t ksize(const void *objp)
 	if (unlikely(ZERO_OR_NULL_PTR(objp)) || !kasan_check_byte(objp))
 		return 0;
 
-	return kfence_ksize(objp) ?: __ksize(objp);
+	return kfence_ksize(objp) ?: ___ksize(objp, full);
 }
 EXPORT_SYMBOL(ksize);
 
+size_t ksize(const void *objp)
+{
+	return _ksize(objp, false);
+}
+
+size_t ksize_full(const void *objp)
+{
+	return _ksize(objp, true);
+}
+
 /* Tracepoints definitions. */
 EXPORT_TRACEPOINT_SYMBOL(kmalloc);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
diff --git a/mm/slob.c b/mm/slob.c
index fe567fcf..8c46bdc 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -579,7 +579,7 @@ size_t kmalloc_size_roundup(size_t size)
 EXPORT_SYMBOL(kmalloc_size_roundup);
 
 /* can't use ksize for kmem_cache_alloc memory, only kmalloc */
-size_t __ksize(const void *block)
+size_t ___ksize(const void *block, bool full)
 {
 	struct folio *folio;
 	unsigned int align;
-- 
1.8.3.1

