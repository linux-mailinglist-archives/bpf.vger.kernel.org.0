Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF66A45F2
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjB0PVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjB0PVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:36 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C45B22A00
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:34 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id n2so3715761pfo.12
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsHGBYYFhohyQndeZKCRssCyWfovKITpIREysK6LA6M=;
        b=b2tUuU19zAoiFdNL1rpmyfWLSSnq0DQ70VjNdC2uFGxQ/MUQEQQpgCLfalIA0QnI3X
         7yYo6wtqAPiP/WQhdapiohEaUWSCMgzoR2SfGRHvXLPlwnoSM03zArIGeORN0or1Vhvf
         dqgIxIDrhm6mjw5Ugt8wxD0T2Mo2D66m0X2YrEXUAxw2XuuuXRo/qYWwi1ghGmR7NqDg
         PsvKoR3jne00lJD+S/NwxSMqSw3loDJobvamAML/yOgptw8wY9FHPh0r7NbaCAu1eK4J
         TT8RfNDwWRSH7lzLcaJp7YlLcLYnLLzmpXwfumm2w3fnZ+dnRZmsmbFx7Y7Vvqs4DGeB
         C8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsHGBYYFhohyQndeZKCRssCyWfovKITpIREysK6LA6M=;
        b=UkmqqCOSDwz0I4rKOdhRaFgJxFKFpBo4DLzoyz9lXJDoZktMdDNG6ioILIsG8Iqdek
         MkcnJNO62q6V7uWtL8fC3FXyERjgzKWdsr/9LciY+BMVwko2zdnOgs2yttiSXZo5y3zp
         9yGrgFnxLoq9myswhRCXrynbrifv/uRVXr/IClZO7Ox0C2r3TiMA3zzx1IhgE7Q0hF4T
         G0Qp0ndZc9h3wbAjZhiZho+ITiyOwb/aMe56FT2sEZweDABX2Ko85vu+dfeOFi1CBJjU
         b7EOMA5ZqmSthCKBOtwENZ+q5YW0NSHWeeOp6YiomM8TEvdz1aHMtxipq/xZhkecZiXG
         BO/g==
X-Gm-Message-State: AO0yUKUO8nrM3vt6Ke33+IFqm0ujsVhQ+7ktjeT52LyABjMqt5SzPCCc
        8ylQxlnBzP5uSXamww5G0V4=
X-Google-Smtp-Source: AK7set9hRuOgOcZ8KI6onLtqd3ZORSanLrKkr++V3BnzHtj7mqXY5ogT1BYJfy7nOicf/jy6ruE50w==
X-Received: by 2002:a62:1ccb:0:b0:5a9:d5c7:199a with SMTP id c194-20020a621ccb000000b005a9d5c7199amr21227108pfc.8.1677511293867;
        Mon, 27 Feb 2023 07:21:33 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:33 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 14/18] bpf, net: bpf_local_storage memory usage
Date:   Mon, 27 Feb 2023 15:20:28 +0000
Message-Id: <20230227152032.12359-15-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227152032.12359-1-laoar.shao@gmail.com>
References: <20230227152032.12359-1-laoar.shao@gmail.com>
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

A new helper is introduced into bpf_local_storage map to calculate the
memory usage. This helper is also used by other maps like
bpf_cgrp_storage, bpf_inode_storage, bpf_task_storage and etc.

Note that currently the dynamically allocated storage elements are not
counted in the usage, since it will take extra runtime overhead in the
elements update or delete path. So let's put it aside now, and implement
it in the future when someone really need it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf_local_storage.h |  1 +
 kernel/bpf/bpf_cgrp_storage.c     |  1 +
 kernel/bpf/bpf_inode_storage.c    |  1 +
 kernel/bpf/bpf_local_storage.c    | 10 ++++++++++
 kernel/bpf/bpf_task_storage.c     |  1 +
 net/core/bpf_sk_storage.c         |  1 +
 6 files changed, 15 insertions(+)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 6d37a40..d934248 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -164,5 +164,6 @@ struct bpf_local_storage_data *
 			 void *value, u64 map_flags, gfp_t gfp_flags);
 
 void bpf_local_storage_free_rcu(struct rcu_head *rcu);
+u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map);
 
 #endif /* _BPF_LOCAL_STORAGE_H */
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 6cdf6d9..9ae07ae 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -221,6 +221,7 @@ static void cgroup_storage_map_free(struct bpf_map *map)
 	.map_update_elem = bpf_cgrp_storage_update_elem,
 	.map_delete_elem = bpf_cgrp_storage_delete_elem,
 	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_mem_usage = bpf_local_storage_map_mem_usage,
 	.map_btf_id = &bpf_local_storage_map_btf_id[0],
 	.map_owner_storage_ptr = cgroup_storage_ptr,
 };
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 05f4c66..43e2619c 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -223,6 +223,7 @@ static void inode_storage_map_free(struct bpf_map *map)
 	.map_update_elem = bpf_fd_inode_storage_update_elem,
 	.map_delete_elem = bpf_fd_inode_storage_delete_elem,
 	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_mem_usage = bpf_local_storage_map_mem_usage,
 	.map_btf_id = &bpf_local_storage_map_btf_id[0],
 	.map_owner_storage_ptr = inode_storage_ptr,
 };
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 58da17a..0d4d108 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -646,6 +646,16 @@ bool bpf_local_storage_unlink_nolock(struct bpf_local_storage *local_storage)
 	return free_storage;
 }
 
+u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_local_storage_map *smap = (struct bpf_local_storage_map *)map;
+	u64 usage = sizeof(*smap);
+
+	/* The dynamically callocated selems are not counted currently. */
+	usage += sizeof(*smap->buckets) * (1ULL << smap->bucket_log);
+	return usage;
+}
+
 struct bpf_map *
 bpf_local_storage_map_alloc(union bpf_attr *attr,
 			    struct bpf_local_storage_cache *cache)
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 1e48605..20f9422 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -335,6 +335,7 @@ static void task_storage_map_free(struct bpf_map *map)
 	.map_update_elem = bpf_pid_task_storage_update_elem,
 	.map_delete_elem = bpf_pid_task_storage_delete_elem,
 	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_mem_usage = bpf_local_storage_map_mem_usage,
 	.map_btf_id = &bpf_local_storage_map_btf_id[0],
 	.map_owner_storage_ptr = task_storage_ptr,
 };
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index bb378c3..7a36353 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -324,6 +324,7 @@ static void bpf_sk_storage_uncharge(struct bpf_local_storage_map *smap,
 	.map_local_storage_charge = bpf_sk_storage_charge,
 	.map_local_storage_uncharge = bpf_sk_storage_uncharge,
 	.map_owner_storage_ptr = bpf_sk_storage_ptr,
+	.map_mem_usage = bpf_local_storage_map_mem_usage,
 };
 
 const struct bpf_func_proto bpf_sk_storage_get_proto = {
-- 
1.8.3.1

