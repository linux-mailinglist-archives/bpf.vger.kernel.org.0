Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56DC687323
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjBBBmp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBBmo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:42:44 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273B07750D
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 17:42:43 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso383889pjb.4
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 17:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXkRPNUKE8d5ftVBz5595yLHB869PZbpQON83mShRx4=;
        b=YLlTiQVi1W6kOesI/itZUMFMXk0vDTecHCMSOuC1nRnzwzmVJkcWdwmEzp+h6Y0VGF
         6bRLPxE9ercMM/AzdE83khyPtI6P6KjiTMBbOnPOroS+0coKScYO52fdo2es8e9hms3/
         muEbfteiVwr3AlG94kSuXrL/2s9PFdcJM40hPW8VnKV67RoXbSDH99li4/gX7D5XNXxR
         yDPRvkgmp0UJCTbi65CFakuGydXukRwvdFeaUlQffBOvO6OvIGe2xt1Y4hTKY0fUbO3u
         3qxbAi/x9otJLXP49/B+8xf7CThsGjYnhfm0D00n82xNGWGJPDGO4m+YtkXgJUaH8Ofv
         S2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXkRPNUKE8d5ftVBz5595yLHB869PZbpQON83mShRx4=;
        b=plNTTqUOCrPdneLgtFYVU6mgCQ5zOiPrVzD9seGzZz1L0zbv1Z357JHfcX7Vpr4RSx
         NT8RgIk55CKw2b+HpP8dgpFPxrVxFMVpRAIXiBwE1oziLk15cQcPlMN1dHAxWWR4NSxc
         rLLIGuLKKvsOi1ZOuKFoJbTZBqBe/9GRtwOn2pA/XCwJxPWoXWiISX/TQy2bQH0PUiQr
         Won9J+MSTp+Hcyp/vvOZcAeL0TF512bh06cn0iZD5NeFt+0o1bFCPSJyJ/FQz0PVJ2LE
         miXKmy04HZgt+nm84sxgzgKCKkMxW/UlrNFuoitnpsSVPA3T5uMb4YsaYVnzxsWt1c6x
         ZhgA==
X-Gm-Message-State: AO0yUKWCw7s/aywR3qglXk8s3YDcKIDeXMfncn57FSHCZvZ6SkdBXESS
        cT+U6q1kAB6roOBlfnQNjgc=
X-Google-Smtp-Source: AK7set/SrSm3u8TRTQ8rnsLayAXgTID2jYtlbM0umtSssmngdloviUV9lnMNXrqFT2mZKh/SiGuJFQ==
X-Received: by 2002:a05:6a20:1aa5:b0:be:b878:6d71 with SMTP id ci37-20020a056a201aa500b000beb8786d71mr4543762pzb.7.1675302162662;
        Wed, 01 Feb 2023 17:42:42 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:3f48:5400:4ff:fe4a:8c8b])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm6594205pgd.76.2023.02.01.17.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:42:42 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 6/7] bpf: introduce bpf_mem_alloc_size()
Date:   Thu,  2 Feb 2023 01:41:57 +0000
Message-Id: <20230202014158.19616-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202014158.19616-1-laoar.shao@gmail.com>
References: <20230202014158.19616-1-laoar.shao@gmail.com>
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

Introduce helpers to get the memory usage of bpf_mem_alloc, includes the
bpf_mem_alloc pool and the in-use elements size. Note that we only count
the free list size in the bpf_mem_alloc pool but don't count other
lists, because there won't be too many elements on other lists. Ignoring
other lists could make the code simple.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf_mem_alloc.h |  2 ++
 kernel/bpf/memalloc.c         | 70 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 3e164b8..86d8dcf 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -24,5 +24,7 @@ struct bpf_mem_alloc {
 /* kmem_cache_alloc/free equivalent: */
 void *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma);
 void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
+unsigned long bpf_mem_alloc_size(struct bpf_mem_alloc *ma);
+unsigned long bpf_mem_cache_elem_size(struct bpf_mem_alloc *ma, void *ptr);
 
 #endif /* _BPF_MEM_ALLOC_H */
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index ebcc3dd..ebf8964 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -224,6 +224,22 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
 	kfree(obj);
 }
 
+unsigned long bpf_mem_cache_size(struct bpf_mem_cache *c, void *obj)
+{
+	unsigned long size;
+
+	if (!obj)
+		return 0;
+
+	if (c->percpu_size) {
+		size = percpu_size(((void **)obj)[1]);
+		size += ksize(obj);
+		return size;
+	}
+
+	return ksize(obj);
+}
+
 static void __free_rcu(struct rcu_head *head)
 {
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
@@ -559,6 +575,41 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 	}
 }
 
+/* We only account the elements on free list */
+static unsigned long bpf_mem_cache_free_size(struct bpf_mem_cache *c)
+{
+	return c->unit_size * c->free_cnt;
+}
+
+/* Get the free list size of a bpf_mem_alloc pool. */
+unsigned long bpf_mem_alloc_size(struct bpf_mem_alloc *ma)
+{
+	struct bpf_mem_caches *cc;
+	struct bpf_mem_cache *c;
+	unsigned long size = 0;
+	int cpu, i;
+
+	if (ma->cache) {
+		for_each_possible_cpu(cpu) {
+			c = per_cpu_ptr(ma->cache, cpu);
+			size += bpf_mem_cache_free_size(c);
+		}
+		size += percpu_size(ma->cache);
+	}
+	if (ma->caches) {
+		for_each_possible_cpu(cpu) {
+			cc = per_cpu_ptr(ma->caches, cpu);
+			for (i = 0; i < NUM_CACHES; i++) {
+				c = &cc->cache[i];
+				size += bpf_mem_cache_free_size(c);
+			}
+		}
+		size += percpu_size(ma->caches);
+	}
+
+	return size;
+}
+
 /* notrace is necessary here and in other functions to make sure
  * bpf programs cannot attach to them and cause llist corruptions.
  */
@@ -675,3 +726,22 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
 
 	unit_free(this_cpu_ptr(ma->cache), ptr);
 }
+
+/* Get elemet size from the element pointer @ptr */
+unsigned long notrace bpf_mem_cache_elem_size(struct bpf_mem_alloc *ma, void *ptr)
+{
+	struct llist_node *llnode;
+	struct bpf_mem_cache *c;
+	unsigned long size;
+
+	if (!ptr)
+		return 0;
+
+	llnode = ptr - LLIST_NODE_SZ;
+	migrate_disable();
+	c = this_cpu_ptr(ma->cache);
+	size = bpf_mem_cache_size(c, llnode);
+	migrate_enable();
+
+	return size;
+}
-- 
1.8.3.1

