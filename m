Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D9D6AAF9E
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCEMql (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCEMqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:40 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D76F748
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:38 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id i4so4817555ils.1
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7v/ESz869l8hOPmt9s29UAAocP8YuswFSiq16NrLEg=;
        b=o8hwnC7EcJ97IuM6vVHKWdaXAXcXAaaRDGpAaUFZxKVMrH2wkqVBva4AMAC4ls72e8
         7z2w9/oqtS/ZlrDwUNffzYWl35nonmwN2Kx0NBWNAh4ub0PsLmqZkIfUDlNUAtvbPr2I
         Cs65YyY6MUc85+uZYyrOgavz3QaHNI0zIHYD4Foltb99VUxHQgmAv1YZlxN3oAJc2WN2
         Biu93jrZBHmZvCg6YSvaiyOtj4TwbuPG9HTkF+thJST1EGTRNi7qjpuIsQGd7HXvh7ce
         adDNC5VxkpgtvRszhEN7YKHdHOqKNR7DLMfuxJX97eOzOtRTn5V8S2cPcdrEEPIiYtQx
         uCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7v/ESz869l8hOPmt9s29UAAocP8YuswFSiq16NrLEg=;
        b=XN6BN7XMKMmRCXmzq97YOGYDwPnk2ZBDDOtDWKUIjl4JjYDAB9oeJz39ziNzlKbZXS
         Zk0un6uTIunX2oMxKocKZXojEO+IvvESImxP/uM4XdwOS0J0qCkIq/nGLjeuBQa9Houj
         W33thaDafdgKJ3oGt++ejbCgLnux/xL6SjJZAQ8W5kKqyC0ozyZ8wlOx1AUD+dO+/c9f
         eu332WJYH0qpLrqRQMFDlQbBFp3/F+zg6Ihk6xly1ZZqSk3iWPFFp5skkTsDi7Ruw+nU
         SbPTTxw3H8h+Y5QhZAjXqFXLWYP0ytfzYWOVnOyDTeLH4tdHmRZde88OEfRR52U80rsb
         f6vQ==
X-Gm-Message-State: AO0yUKXH05kL7atPHMM1erSAViU1qlrcLHQNZgytJc7+hECfoePby5L4
        1I9SF1EWgu6CkguVKBYI7qI=
X-Google-Smtp-Source: AK7set+MvXL4vlzkKP++Ylq1XblB8jqnmcCxYNLKIppjfhs45pckWpXNm6UZNgqA0tgeLQf7yJe4Jg==
X-Received: by 2002:a92:c54a:0:b0:313:bf44:b4a5 with SMTP id a10-20020a92c54a000000b00313bf44b4a5mr6838558ilj.13.1678020398192;
        Sun, 05 Mar 2023 04:46:38 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:37 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 14/18] bpf, net: bpf_local_storage memory usage
Date:   Sun,  5 Mar 2023 12:46:11 +0000
Message-Id: <20230305124615.12358-15-laoar.shao@gmail.com>
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
index 3d32039..d3ba3f2 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -685,6 +685,16 @@ bool bpf_local_storage_unlink_nolock(struct bpf_local_storage *local_storage)
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

