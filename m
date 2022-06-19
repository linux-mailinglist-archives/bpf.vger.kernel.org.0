Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC7550BF5
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 17:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiFSPvC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 11:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiFSPvA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 11:51:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73D1BC94
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m2so492142plx.3
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wupU3s6HDHFwU6sdzvBeIV5oXRSNq7jyoLqRbCJxYac=;
        b=ouUobzlqmq8S/Azfyps3usSVZ5UvHYpdVP1vu+gtd0yfCYf+Bzj6oDe+t+ss7KLBSf
         49dFjjsYRk7VFsjhV3FODdJpDko/alFqgElQMsTdQ7rE3prZj2MIR3wBldkL29tmg8hY
         WdHG53fBco4KiIraG/2iAZgtIVMOvMVToF33Rx2Q9+oc4GQX/3Q5aq8Wo8P4nysP+w5e
         2eUFBCQxRzJk2HamKYvCj0plIjvc0hhDGIC8v68RlNWj6n0rlOJa48Ff1QOKAuzhCW93
         gS4S70/+InEZ+SY8uBkQpCQ9xW4bcbu79d4WCk/f6OGain7VFBSaQrtbwWMxyWF6uwKH
         17fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wupU3s6HDHFwU6sdzvBeIV5oXRSNq7jyoLqRbCJxYac=;
        b=RnNM5AJV21A9OjZvJEKPTleStJp/1StNo9j1BsnDINtd8ZUWocxA3M8x5vzczy7Fb6
         cVxg+1DxnxXtyOyI9pwM+IMueMfvZkLAe6Ddl/Il+oqcf/N3NhSpX2nTV/eUBtEePDaS
         T75teyg8H+Is21DD33Z7jPnrojjjEgaXS3IVSr3UYdoxUh5ZCy+W6buM6LlN6lGvMLLR
         ejvoTgno898iIBT/6hn5cVn0NH12HpJITw1l46C7Q+SDqGOOabNP7sLfizolFqfk1nOe
         ekhYRNmgLzy8rK9XMnGwWNNt+6ZhXy3IVIBkLZFha8lgyC3H5ujtt9HjjZB8r2nThzjK
         wCYg==
X-Gm-Message-State: AJIora9uoLjQe68hhymLaEteVGG4YZL8ytwZvR3NHK7XWA+gwdmt6NCF
        73GdTBF0JPNkReYbbwYAb/0=
X-Google-Smtp-Source: AGRyM1vEp6+rL+Wouq6U3Uc3dHqIACyRg+BpnCyHuM0NN5vXImRir63qLU15/bkknG3MjEs3GQ/aPw==
X-Received: by 2002:a17:902:bb86:b0:169:caf:895c with SMTP id m6-20020a170902bb8600b001690caf895cmr16028267pls.13.1655653859261;
        Sun, 19 Jun 2022 08:50:59 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:2b24:5400:4ff:fe09:b144])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001690a7df347sm6381761pla.96.2022.06.19.08.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:50:58 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 08/10] bpf: Recharge memory when reuse bpf map
Date:   Sun, 19 Jun 2022 15:50:30 +0000
Message-Id: <20220619155032.32515-9-laoar.shao@gmail.com>
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

When we reuse a pinned bpf map, if it belongs to a memcg which needs to
be recharged, we will uncharge the pages of this bpf map from its
original memcg and then charge its pages to the current memcg.

We have to explicitly tell the kernel if it is a reuse path as the
kernel can't detect it intelligently. That can be done in libbpf, then the
user code don't need to be changed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h            |  2 ++
 include/uapi/linux/bpf.h       |  2 +-
 kernel/bpf/syscall.c           | 10 ++++++++++
 tools/include/uapi/linux/bpf.h |  2 +-
 tools/lib/bpf/libbpf.c         |  2 +-
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0edd7d2c0064..b18a30e70507 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -152,6 +152,8 @@ struct bpf_map_ops {
 				     bpf_callback_t callback_fn,
 				     void *callback_ctx, u64 flags);
 
+	bool (*map_memcg_recharge)(struct bpf_map *map);
+
 	/* BTF id of struct allocated by map_alloc */
 	int *map_btf_id;
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f2f658e224a7..ffbe15c1c8c6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6093,7 +6093,7 @@ struct bpf_map_info {
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
 	__s8  memcg_state;
-	__s8  :8;	/* alignment pad */
+	__s8  memcg_recharge;
 	__u16 :16;	/* alignment pad */
 	__u64 map_extra;
 } __attribute__((aligned(8)));
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d4659d58d288..8817c40275f3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4170,12 +4170,22 @@ static int bpf_map_get_info_by_fd(struct file *file,
 
 #ifdef CONFIG_MEMCG_KMEM
 	if (map->memcg) {
+		size_t offset = offsetof(struct bpf_map_info, memcg_recharge);
 		struct mem_cgroup *memcg = map->memcg;
+		char recharge;
 
 		if (memcg == root_mem_cgroup)
 			info.memcg_state = 0;
 		else
 			info.memcg_state = memcg_need_recharge(memcg) ? -1 : 1;
+
+		if (copy_from_user(&recharge, (char __user *)uinfo + offset, sizeof(char)))
+			return -EFAULT;
+
+		if (recharge && memcg_need_recharge(memcg)) {
+			if (map->ops->map_memcg_recharge)
+				map->ops->map_memcg_recharge(map);
+		}
 	}
 #endif
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f2f658e224a7..ffbe15c1c8c6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6093,7 +6093,7 @@ struct bpf_map_info {
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
 	__s8  memcg_state;
-	__s8  :8;	/* alignment pad */
+	__s8  memcg_recharge;
 	__u16 :16;	/* alignment pad */
 	__u64 map_extra;
 } __attribute__((aligned(8)));
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 49e359cd34df..f0eb67c983d8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4488,7 +4488,7 @@ int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
 
 int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 {
-	struct bpf_map_info info = {};
+	struct bpf_map_info info = {.memcg_recharge = 1};
 	__u32 len = sizeof(info);
 	int new_fd, err;
 	char *new_name;
-- 
2.17.1

