Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A426A550BEE
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 17:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiFSPuq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 11:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFSPuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 11:50:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37068BC94
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso5326877pjn.2
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pbJcR0JCgnnBinC8hqBQ8PqrT65xvYVhQt3SCbh4L30=;
        b=gL00DEY/pyx6xquZdsMWkhU03MRL9mGCjCzvdQLvuCKP+h0F+pUJpIDb/Fok05wmTd
         2+CfJ8htUDSpBIWHUdOUWZDWShYErmlvKY3bZtamer8ejyjCB/hXwyjExzv6synKSlRs
         8IQp9bwHIZhN1pxPrkMCIbL9fzBCKegJ3aAxkT1SuGFDU6Upkuza0BdySmGk/VIQC3nz
         RiYOA7kjCPEnstqkceUyef3q7WKD5xMbvP/9EPQ5yRxnxpt13eziLgEEHUKqzjxM8QwR
         HANv+Klf9VzXVYgF6saPC9cZFvotG47okLI1KN63Koldz7qt8xAz+8tuWfWejJNZl5YA
         12JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbJcR0JCgnnBinC8hqBQ8PqrT65xvYVhQt3SCbh4L30=;
        b=2K9omQ3VaUhhXJ6wKJrEqSP186YVsII6FRUOTKAS8kGoQDlm0Vx6+gPHNpts0E712p
         VEwocV63fc4da7ax7iNuaanmpXKKZ1gdf/AVz5zp0rOVQW6pA7Julst06aM76Rknag6W
         xaEyo6aZRYfCfcEVpXlj0s8UOzC37U4JUL1JBr9m0WeZcsqtM1GOR7Phv00Yl4iGqM8U
         b1+HtR3MbZ8B7c1Ccc2eF2bfQUdhBh0hK3BdNQvjSXinrQeifOnEEUQR3uc5u81jYy2A
         7B1dtB2edFhi2/a9nHWNj9rG6XkD+KfYrhKdo81w9F4lDAPcOska+ATkoRbXw3EWf41S
         vMxw==
X-Gm-Message-State: AJIora/fyDAzphdl7hAlKjYcOjMCzSW3D59LTlhQPBtNOfqLl1t2T9Bc
        gDHA1SUHTPrMwg3ZzgONz5g=
X-Google-Smtp-Source: AGRyM1sijBY2x0OKk+fpSwQADGBG+54XL0sh/Ig4fH5KnHiRM32aoKLh3IZrhd4oeJ52rbEU+RGMGw==
X-Received: by 2002:a17:90a:740e:b0:1e2:a631:87e6 with SMTP id a14-20020a17090a740e00b001e2a63187e6mr21950473pjg.115.1655653844671;
        Sun, 19 Jun 2022 08:50:44 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:2b24:5400:4ff:fe09:b144])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001690a7df347sm6381761pla.96.2022.06.19.08.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:50:43 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 01/10] mm, memcg: Add a new helper memcg_should_recharge()
Date:   Sun, 19 Jun 2022 15:50:23 +0000
Message-Id: <20220619155032.32515-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619155032.32515-1-laoar.shao@gmail.com>
References: <20220619155032.32515-1-laoar.shao@gmail.com>
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

Currently we only recharge pages from an offline memcg or reparented
memcg. In the future we may explicitly introduce a need_recharge
state for the memcg which should be recharged.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9ecead1042b9..cf074156c6ac 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1755,6 +1755,18 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
+static inline bool memcg_need_recharge(struct mem_cgroup *memcg)
+{
+	if (!memcg || memcg == root_mem_cgroup)
+		return false;
+	/*
+	 * Currently we only recharge pages from an offline memcg,
+	 * in the future we may explicitly introduce a need_recharge
+	 * state for the memcg which should be recharged.
+	 */
+	return memcg->kmemcg_id == memcg->id.id ? false : true;
+}
+
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1806,6 +1818,11 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 {
 }
 
+static inline bool memcg_need_recharge(struct mem_cgroup *memcg)
+{
+	return false;
+}
+
 #endif /* CONFIG_MEMCG_KMEM */
 
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
-- 
2.17.1

