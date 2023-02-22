Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A7369EC82
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjBVBrO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBVBrM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:47:12 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE18332E6B
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:11 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id h31so3456390pgl.6
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FRkV+75C0Q2Po4iRebChVLt4HaeDBnJ8PdkHmIdHr4=;
        b=Yvpkz/a4zKAFMOI1r9sqcGoSg3IB+oZCZbtLVjURvjwHhKtW8seK9VvKHIWUfbb9Jx
         EPwGUWE4hPpQvtqE73wzvXmzXIOQIkjguu2W2mUIjkgSBbgNX5hxgCRy2exMNxkHbnfP
         kSy9qH+S77xgGYxiH8dvQH/Srd40Tlzft0r3bLeoDyDX8+7K/W34gatu0U2CVkSBHWOq
         JqfX8xlCZO+WPYzmvUzGE3DTr/chgZCwOJ6kOunBEZFmC2tuoa8N6HP2WXTPT2jVYmsu
         CfoRNrZj18MCVPM/sQ+8rtu7leg99kpTQmqiuAKS51wbFVjfmOOokry6K4ccCYs9GkZY
         fiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FRkV+75C0Q2Po4iRebChVLt4HaeDBnJ8PdkHmIdHr4=;
        b=WCQHYbzD3UP9awA0Tk7S0h4MUomcli/d6rY3CceB7Ea66MOQMR7MdCmp7sj+R77wbV
         iVCn0M3oiG2NMAayEQNEzjEBVF0BeRdeUr0Ay5EAcazXZAuBIvM1qfQwvlRFEPI4ZJwp
         XrhICgkMJFAKRomG6QwhMUjSnJpQTu2oj6rQC9tuVcHIAqTDIP7yP/LyEszf1ch+6oLO
         8YgEEdz0w0wDpH1UB8Apk7495baBZ3nJWQniL2gKdUPn7at+PWURbiRUaEsA5D1xv/n8
         vKGFPhEYD8f2ioLNuF2bRqA5EJiUST1BruWJUK3+QfJWg7BJDFHNGprtvpxP7Go8/K1G
         q4hg==
X-Gm-Message-State: AO0yUKViYztUisSLnYVJjHvtTYtY2u7mT0r9GrJrTyVQFbvTGBtgA/QO
        m0EBS4UPnDkqsw0OHdqxzVE=
X-Google-Smtp-Source: AK7set9LzycHaSQtlaWX4h0ABJIvJJgZv+IqXYfG3VpfBjE8dAlo8nyx2KpberLKvLZr5ZjN2MpTug==
X-Received: by 2002:aa7:9eda:0:b0:5a8:5e6d:28d7 with SMTP id r26-20020aa79eda000000b005a85e6d28d7mr4809794pfq.0.1677030431266;
        Tue, 21 Feb 2023 17:47:11 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:47:10 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 14/18] bpf, net: bpf_local_storage memory usage
Date:   Wed, 22 Feb 2023 01:45:49 +0000
Message-Id: <20230222014553.47744-15-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222014553.47744-1-laoar.shao@gmail.com>
References: <20230222014553.47744-1-laoar.shao@gmail.com>
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
index 35f4138..b915721 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -636,6 +636,16 @@ bool bpf_local_storage_unlink_nolock(struct bpf_local_storage *local_storage)
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

