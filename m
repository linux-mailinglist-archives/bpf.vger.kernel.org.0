Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BBF687321
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBBBmf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjBBBme (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:42:34 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B4C77DDB
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 17:42:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso4150103pjj.1
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 17:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3aayDdIilVnW+ECMQQHHSm0J0IUJbFKBuiVmS/NUpY=;
        b=eXFJpIeXYVUSPivkytSVbl5Cx+bVouw4PGsZHvBMRjAggVZwRnnFxImsPUSa20NFrE
         iQaQCSoHR1+JgPHA480wcfU17dzZ6o6TjbyiXSVZ5mNF78+C+MWigkULQtnu04SPA1+u
         cg6adFij+OS202omImD6F+tFUMNBlxcb9Rp9mqPPGl+5JGMzZO6SjgnQWEHtHToUrhWn
         jIGii/ALcIlvUnzD0Exx3izAAq1GKvujASyQhprQEQbd8Rk8OCjePs9KmtHRSEvOtp+e
         jU+hziToxxaaSZYcyDEDGzDbL20GWelRB54kK2WL+32kFgH54EfHI751dKUP6YwQSVl5
         nrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3aayDdIilVnW+ECMQQHHSm0J0IUJbFKBuiVmS/NUpY=;
        b=TOrEHIY16BESTTIZN9Ap/tHlO1l3Ak1TXtroqSD1uzrHmG4+dSsDPg0My/ghj7Tj68
         3OSEyT4zcVcD2Emj7ajgYhgPwSFg2kGFib5XY+hpLSPtF8aysxjWKf9j94EMcdybIZog
         8TYaNCFjG2M1psgRk/liNWJSzldhM7Chp4yRsddwtBDWz0h/mmfCSEX3Hu3EThMKKY0L
         PY3g7ShYKTrZt/yDdGkYQbAD+NgIOfasaCsrR+U+wvRJWckOfS7MTRf1L4e98sz9g9vT
         7J24AsP4Er8QLxKr17h7IYyniPtJJDTrptQcU7IbhhvG2VIJQSUUzZFU3a8A65jcPMOX
         XQFw==
X-Gm-Message-State: AO0yUKU7P9H8H1LaWo4odzeoxPQzEL5xW4eK1N454OnLiJAtl1T8oLnw
        oBF73bZylFvk4+gTce/TxJ46t3UvOFN4hbd30N8=
X-Google-Smtp-Source: AK7set+dNLy+KLgiWVd1XMiLsrgHNgux7c0+iUY8ZD/JtU9eRdmRWRIuCrfznCo3Dy7IZq+ZnnpkmA==
X-Received: by 2002:a05:6a21:3990:b0:bf:8840:ffd0 with SMTP id ad16-20020a056a21399000b000bf8840ffd0mr1013419pzc.29.1675302152581;
        Wed, 01 Feb 2023 17:42:32 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:3f48:5400:4ff:fe4a:8c8b])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm6594205pgd.76.2023.02.01.17.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:42:32 -0800 (PST)
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
Subject: [PATCH bpf-next 4/7] mm: util: introduce kvsize()
Date:   Thu,  2 Feb 2023 01:41:55 +0000
Message-Id: <20230202014158.19616-5-laoar.shao@gmail.com>
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

Introduce a new help kvsize() to report full size of underlying allocation
of a kmalloc'ed addr or vmalloc'ed addr.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/slab.h |  1 +
 mm/util.c            | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 45af703..cccb4d8 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -762,6 +762,7 @@ static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t fla
 
 extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
 		      __realloc_size(3);
+extern size_t kvsize(void *addr);
 extern void kvfree(const void *addr);
 extern void kvfree_sensitive(const void *addr, size_t len);
 
diff --git a/mm/util.c b/mm/util.c
index b56c92f..f77d0cc 100644
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
+size_t kvsize(void *addr)
+{
+	if (is_vmalloc_addr(addr))
+		return vsize(addr);
+
+	return ksize(addr);
+}
+
+/**
  * kvfree() - Free memory.
  * @addr: Pointer to allocated memory.
  *
-- 
1.8.3.1

