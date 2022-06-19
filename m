Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E61550BF0
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 17:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiFSPuv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiFSPuu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 11:50:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66486BE09
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so8109699pjg.5
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WaE/WLiaH5o5ki3TY2BjGi6nEsbC9ev3Bayiew634jE=;
        b=lg4hLmrvx1aAxFRgX2lydGh2RYsS+K8/vHGdBT3GPJM2V/iumEKMc9+bns60t1/KuB
         J1TuHcq8XADBIaFEVzyfvThx9pJUKJuJOKByFLFtB3cvZod6/1K+3pO5KBTrbMAriRSp
         0aA84OhCbo1cxE5mjGwVS8OjVkf8uyLxSG96ru3xWftJyjaRYeDWc//IT0jYdBNtRhPn
         WcloU6qqNmA+04BwAXt7Tyjzl/yvXQUfBqUwQO+iOJ6GZB91CgEPWKZXrsjb0Cphc5pp
         f7Z0OMdpQ6lWNQjBQSjPrk9BqXMbRzM5/bOul+57dEAkay+yUKbMpZ9MsZadWBKuXs7W
         AYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WaE/WLiaH5o5ki3TY2BjGi6nEsbC9ev3Bayiew634jE=;
        b=NtIELYtTa53onP1YqKpRKZmMctJQ3OHdYZ/euxgndkqw8wOTB9rb/ziVuURSploSE9
         y6S7EX3OsVl6Go5qboj0Ueah3IK4BD8Y4uxl2/faXvZ5A2zd/RfLYiyGdHcbZkHszDcQ
         +74uFr9vK2mzAruXLqabpQuvtRrP1oCaa7Lwh2dPY3HIxiS8ARV1QeQxDJGRdyOb5mGP
         cymfuA2Onwksj4890kJ6SclKjGknACmOtwyiQPWL+GhTDQymXh30cBnMV3pC6vbI2heI
         Vr/mOQQr/kbWyi6Xjo1o/Z3m4uo3pS/jlP0428tCuJl06EYIMJf0OcEqGv/g30Av8DwD
         Aemw==
X-Gm-Message-State: AJIora/jptJ2Dg/5K61rRLJlC7gzalBlEb+MYiB2qtsCHaGNR7y1iRRU
        8Mrns7HDVu/vWMOWcFpqzh0=
X-Google-Smtp-Source: AGRyM1tw+4VoyM5S+fxLBlskF4kAB2xCBsbZchmj1iffm8dIiAU8+M1iozEcYYLSnyvhMrmeJK+cAw==
X-Received: by 2002:a17:903:11cd:b0:167:90e6:5d83 with SMTP id q13-20020a17090311cd00b0016790e65d83mr19355523plh.136.1655653848680;
        Sun, 19 Jun 2022 08:50:48 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:2b24:5400:4ff:fe09:b144])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001690a7df347sm6381761pla.96.2022.06.19.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:50:47 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 03/10] mm, memcg: Add new helper obj_cgroup_from_current()
Date:   Sun, 19 Jun 2022 15:50:25 +0000
Message-Id: <20220619155032.32515-4-laoar.shao@gmail.com>
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

The difference between get_obj_cgroup_from_current() and obj_cgroup_from_current()
is that the later one doesn't add objcg's refcnt.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index cf074156c6ac..402b42670bcd 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1703,6 +1703,7 @@ bool mem_cgroup_kmem_disabled(void);
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
 
+struct obj_cgroup *obj_cgroup_from_current(void);
 struct obj_cgroup *get_obj_cgroup_from_current(void);
 struct obj_cgroup *get_obj_cgroup_from_page(struct page *page);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index abec50f31fe6..350a7849dac3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2950,6 +2950,30 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
 	return objcg;
 }
 
+__always_inline struct obj_cgroup *obj_cgroup_from_current(void)
+{
+	struct obj_cgroup *objcg = NULL;
+	struct mem_cgroup *memcg;
+
+	if (memcg_kmem_bypass())
+		return NULL;
+
+	rcu_read_lock();
+	if (unlikely(active_memcg()))
+		memcg = active_memcg();
+	else
+		memcg = mem_cgroup_from_task(current);
+
+	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
+		objcg = rcu_dereference(memcg->objcg);
+		if (objcg)
+			break;
+	}
+	rcu_read_unlock();
+
+	return objcg;
+}
+
 static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 {
 	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
-- 
2.17.1

