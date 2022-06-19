Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F8550BF4
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 17:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiFSPu7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiFSPu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 11:50:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB287BC94
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i15so7752505plr.1
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8axVjIKJzoKX7/vYAqMF/TYbFLVxAIKs18CKF3m+oFs=;
        b=PuPpsRhrY7YHspdQWWpU1xoiN04UvGnMB4vC75wdnvBWiS+Y1ytnUMJqu3Ho9YMv7j
         yUVPddPMbPZG1XjtCjIyGWJoikOcQ0GatJvErGEg6QrKCQj3dvmPOZSUtiXTU+dFvoSp
         YcIX9PwU4tdeb+QuUi7/vdBpJBPcFXrepnvYHjd/drtSfgthuwT/jXJ9dp48KqVK1jGQ
         L78qryWdc++QJK17LRHW7muc+RPiMWMgaJ4tfBg+wB226QbRz/Vy32swaf+QXSEiOP6S
         DXPQMqrQ0zysXkG87o3+oTm4V7pbmv2EYd17jJv4SCOll+2gRmAW4MAkIbBXsxPkuf++
         IiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8axVjIKJzoKX7/vYAqMF/TYbFLVxAIKs18CKF3m+oFs=;
        b=E1bY3wJ/Mw5U7l7+4nzU7SIc94pr9+YJFUIrs2M6PAw9rDRyocY5pYZYZtWjM8hFad
         IqyiMW8QbfvKw3RMhTxsCH8OARUpEj2i3RQNwldVHaFhAUMNRldrmfjLHmPedbi0UuZN
         PyNJqTIOiNkc0SuQ2nHzATvoEaCXSZZ/P3JDV/9UIAf7NwD26LxsiyPeqGE58MnVKhy8
         ZrOO8E7hNeM4Hk9h+J/UcnEGb8hVqGA9EovepnNDW1TEE4KJ+cpujnFk1E30fjXCY6Jd
         g47+z1RmKVVbLPp2WAR3y+9rjWcEjFyew91ZpJcmgz4iTL/Ck7I5BjvP2GEmmK63lOue
         D5iQ==
X-Gm-Message-State: AJIora/4nC/hGI2Kv6x1V+9+NxFrWDwJ0CkGvAuQDjUqD89kvrX2fgko
        Czqaq8PYtKF3cw+WH5CcBH4=
X-Google-Smtp-Source: AGRyM1tWFLmDZ1xZ4c7PpIxT4CG5PqHtIf/jPAzTTqfH8RQEghLLoAKdBEQZ9RMRcWjmMK8GqJOEtA==
X-Received: by 2002:a17:902:7686:b0:168:de55:8c45 with SMTP id m6-20020a170902768600b00168de558c45mr19518921pll.129.1655653857305;
        Sun, 19 Jun 2022 08:50:57 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:2b24:5400:4ff:fe09:b144])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001690a7df347sm6381761pla.96.2022.06.19.08.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:50:56 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 07/10] mm: Add helper to recharge percpu address
Date:   Sun, 19 Jun 2022 15:50:29 +0000
Message-Id: <20220619155032.32515-8-laoar.shao@gmail.com>
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

This patch introduces a helper to recharge the corresponding pages of
a given percpu address. It is similar with how to recharge a kmalloc'ed
address.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/percpu.h |  1 +
 mm/percpu.c            | 98 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index f1ec5ad1351c..e88429410179 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -128,6 +128,7 @@ extern void __init setup_per_cpu_areas(void);
 extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
 extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
 extern void free_percpu(void __percpu *__pdata);
+bool recharge_percpu(void __percpu *__pdata, int step);
 extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 
 #define alloc_percpu_gfp(type, gfp)					\
diff --git a/mm/percpu.c b/mm/percpu.c
index 3633eeefaa0d..fd81f4d79f2f 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2310,6 +2310,104 @@ void free_percpu(void __percpu *ptr)
 }
 EXPORT_SYMBOL_GPL(free_percpu);
 
+#ifdef CONFIG_MEMCG_KMEM
+bool recharge_percpu(void __percpu *ptr, int step)
+{
+	int bit_off, off, bits, size, end;
+	struct obj_cgroup *objcg_old;
+	struct obj_cgroup *objcg_new;
+	struct pcpu_chunk *chunk;
+	unsigned long flags;
+	void *addr;
+
+	WARN_ON(!in_task());
+
+	if (!ptr)
+		return true;
+
+	addr = __pcpu_ptr_to_addr(ptr);
+	spin_lock_irqsave(&pcpu_lock, flags);
+	chunk = pcpu_chunk_addr_search(addr);
+	off = addr - chunk->base_addr;
+	objcg_old = chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT];
+	if (!objcg_old && step != MEMCG_KMEM_POST_CHARGE) {
+		spin_unlock_irqrestore(&pcpu_lock, flags);
+		return true;
+	}
+
+	bit_off = off / PCPU_MIN_ALLOC_SIZE;
+	/* find end index */
+	end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk),
+			bit_off + 1);
+	bits = end - bit_off;
+	size = bits * PCPU_MIN_ALLOC_SIZE;
+
+	switch (step) {
+	case MEMCG_KMEM_PRE_CHARGE:
+		objcg_new = get_obj_cgroup_from_current();
+		WARN_ON(!objcg_new);
+		if (obj_cgroup_charge(objcg_new, GFP_KERNEL,
+				      size * num_possible_cpus())) {
+			obj_cgroup_put(objcg_new);
+			spin_unlock_irqrestore(&pcpu_lock, flags);
+			return false;
+		}
+		break;
+	case MEMCG_KMEM_UNCHARGE:
+		obj_cgroup_uncharge(objcg_old, size * num_possible_cpus());
+		rcu_read_lock();
+		mod_memcg_state(obj_cgroup_memcg(objcg_old), MEMCG_PERCPU_B,
+			-(size * num_possible_cpus()));
+		rcu_read_unlock();
+		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = NULL;
+		obj_cgroup_put(objcg_old);
+		break;
+	case MEMCG_KMEM_POST_CHARGE:
+		rcu_read_lock();
+		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = obj_cgroup_from_current();
+		mod_memcg_state(mem_cgroup_from_task(current), MEMCG_PERCPU_B,
+			(size * num_possible_cpus()));
+		rcu_read_unlock();
+		break;
+	case MEMCG_KMEM_CHARGE_ERR:
+		/*
+		 * In case fail to charge to the new one in the pre charge state,
+		 * for example, we have pre-charged one memcg successfully but fail
+		 * to pre-charge the second memcg, then we should uncharge the first
+		 * memcg.
+		 */
+		objcg_new = obj_cgroup_from_current();
+		obj_cgroup_uncharge(objcg_new, size * num_possible_cpus());
+		obj_cgroup_put(objcg_new);
+		rcu_read_lock();
+		mod_memcg_state(obj_cgroup_memcg(objcg_new), MEMCG_PERCPU_B,
+			-(size * num_possible_cpus()));
+		rcu_read_unlock();
+
+		break;
+	}
+
+	spin_unlock_irqrestore(&pcpu_lock, flags);
+
+	return true;
+}
+EXPORT_SYMBOL(recharge_percpu);
+
+#else /* CONFIG_MEMCG_KMEM */
+
+bool charge_percpu(void __percpu *ptr, bool charge)
+{
+	return true;
+}
+EXPORT_SYMBOL(charge_percpu);
+
+void uncharge_percpu(void __percpu *ptr)
+{
+}
+EXPORT_SYMBOL(uncharge_percpu);
+
+#endif /* CONFIG_MEMCG_KMEM */
+
 bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr)
 {
 #ifdef CONFIG_SMP
-- 
2.17.1

