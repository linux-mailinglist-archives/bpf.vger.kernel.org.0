Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7AA24B32D
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgHTJmx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 05:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgHTJmR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 05:42:17 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D683C061383
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:16 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t13so1073658ile.9
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1rlIyE7c4KLlxD5gCyeY6MsqamG9FBghZ8kzijQ88sA=;
        b=tBshSWyoA0N+bBpWnAjAML9ZxB867uOitrL8sJlvnJQHtpnENzIScjXAjSD3+u2qpI
         xk5y/IH8Ahf+7AZqL8UHj01e2xY9v/2mKKgNnSOg6SHUeTkI42L4O23z+8inKSI2PZu/
         sJj3Sy6Im9B99NXo71LFBd9erPGwIJZzg5Gm3cchmSvLl2nM8xZMSBj5l3jSdty+y5nd
         X/CUIEyfLIEEf141fjpY5Y+Kv34pvNiQ0d6xHW6rYKI1EWo9zpnkdIRZCEQxfZk+G0gu
         7LfZaITG3SaFoykt6FOv/2MMfqpHveRHWsWcIltybFszsIjXYw7/Ul/wUcnwDci604p9
         bSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rlIyE7c4KLlxD5gCyeY6MsqamG9FBghZ8kzijQ88sA=;
        b=oKu0U7n0dQLIhmJN7B4fbZS7L2aLF063vspkbdweargUbGI4YfNNI4fOYxYNvivv8t
         5ZlAA+3HfBEUAfhEBXpqAl8dzLEswklcYT8L8h3N2beV+qBx47PBqzSyqYzCOZXYaSWz
         e78STLzj1viSXbNriwGysRJQP+k97OuSg/zA6r3GEoTU9bd6saaDcishgNax2Arkw1Xd
         AxR7sL8olk5TK2kR3EgiI6/dpuA/ymv3+MQiwob8u5JURUtNTNO0uV18ecIpUwNDVO65
         F11WTJTGOB+koqesU6TpBe4P0/rwyVzY9km/NpfRBu5mSOXpD8VB4gUxM0wXWZrh+M1x
         cYvA==
X-Gm-Message-State: AOAM532OdW8L//SgH7pa21pOkDBK4T8IcuSuegnM/6CuV1pKHVMy5xy3
        vPc1F1ZGZDbE3Xb36Y/4P98ZRe9DODylIXPM
X-Google-Smtp-Source: ABdhPJwM+Le0kpsS4XAe70Q255qS58KMTRAe6lo4CuhMNc+0TbQ8nSyxul9/zb9qmvzshG1yN2INYA==
X-Received: by 2002:a92:b106:: with SMTP id t6mr1831630ilh.122.1597916535962;
        Thu, 20 Aug 2020 02:42:15 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id r3sm1145597iov.22.2020.08.20.02.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 02:42:15 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 1/5] bpf: Mutex protect used_maps array and count
Date:   Thu, 20 Aug 2020 04:42:07 -0500
Message-Id: <d8dd3a17e80558f9b57815f2165e403c1aa24858.1597915265.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597915265.git.zhuyifei@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

To support modifying the used_maps array, we use a mutex to protect
the use of the counter and the array. The mutex is initialized right
after the prog aux is allocated, and destroyed right before prog
aux is freed. This way we guarantee it's initialized for both cBPF
and eBPF.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../net/ethernet/netronome/nfp/bpf/offload.c   | 18 ++++++++++++------
 include/linux/bpf.h                            |  1 +
 kernel/bpf/core.c                              | 15 +++++++++++----
 kernel/bpf/syscall.c                           | 16 ++++++++++++----
 net/core/dev.c                                 | 11 ++++++++---
 5 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/offload.c b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
index ac02369174a9..53851853562c 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
@@ -111,7 +111,9 @@ static int
 nfp_map_ptrs_record(struct nfp_app_bpf *bpf, struct nfp_prog *nfp_prog,
 		    struct bpf_prog *prog)
 {
-	int i, cnt, err;
+	int i, cnt, err = 0;
+
+	mutex_lock(&prog->aux->used_maps_mutex);
 
 	/* Quickly count the maps we will have to remember */
 	cnt = 0;
@@ -119,13 +121,15 @@ nfp_map_ptrs_record(struct nfp_app_bpf *bpf, struct nfp_prog *nfp_prog,
 		if (bpf_map_offload_neutral(prog->aux->used_maps[i]))
 			cnt++;
 	if (!cnt)
-		return 0;
+		goto out;
 
 	nfp_prog->map_records = kmalloc_array(cnt,
 					      sizeof(nfp_prog->map_records[0]),
 					      GFP_KERNEL);
-	if (!nfp_prog->map_records)
-		return -ENOMEM;
+	if (!nfp_prog->map_records) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	for (i = 0; i < prog->aux->used_map_cnt; i++)
 		if (bpf_map_offload_neutral(prog->aux->used_maps[i])) {
@@ -133,12 +137,14 @@ nfp_map_ptrs_record(struct nfp_app_bpf *bpf, struct nfp_prog *nfp_prog,
 						 prog->aux->used_maps[i]);
 			if (err) {
 				nfp_map_ptrs_forget(bpf, nfp_prog);
-				return err;
+				goto out;
 			}
 		}
 	WARN_ON(cnt != nfp_prog->map_records_cnt);
 
-	return 0;
+out:
+	mutex_unlock(&prog->aux->used_maps_mutex);
+	return err;
 }
 
 static int
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 55f694b63164..abbdde104cea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -723,6 +723,7 @@ struct bpf_prog_aux {
 	struct bpf_ksym ksym;
 	const struct bpf_prog_ops *ops;
 	struct bpf_map **used_maps;
+	struct mutex used_maps_mutex; /* mutex for used_maps and used_map_cnt */
 	struct bpf_prog *prog;
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ed0b3578867c..2a20c2833996 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -98,6 +98,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	fp->jit_requested = ebpf_jit_enabled();
 
 	INIT_LIST_HEAD_RCU(&fp->aux->ksym.lnode);
+	mutex_init(&fp->aux->used_maps_mutex);
 
 	return fp;
 }
@@ -253,6 +254,7 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 void __bpf_prog_free(struct bpf_prog *fp)
 {
 	if (fp->aux) {
+		mutex_destroy(&fp->aux->used_maps_mutex);
 		free_percpu(fp->aux->stats);
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
@@ -1747,8 +1749,9 @@ bool bpf_prog_array_compatible(struct bpf_array *array,
 static int bpf_check_tail_call(const struct bpf_prog *fp)
 {
 	struct bpf_prog_aux *aux = fp->aux;
-	int i;
+	int i, ret = 0;
 
+	mutex_lock(&aux->used_maps_mutex);
 	for (i = 0; i < aux->used_map_cnt; i++) {
 		struct bpf_map *map = aux->used_maps[i];
 		struct bpf_array *array;
@@ -1757,11 +1760,15 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
 			continue;
 
 		array = container_of(map, struct bpf_array, map);
-		if (!bpf_prog_array_compatible(array, fp))
-			return -EINVAL;
+		if (!bpf_prog_array_compatible(array, fp)) {
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
-	return 0;
+out:
+	mutex_unlock(&aux->used_maps_mutex);
+	return ret;
 }
 
 static void bpf_prog_select_func(struct bpf_prog *fp)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 86299a292214..f49fd709ccd5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3152,21 +3152,25 @@ static const struct bpf_map *bpf_map_from_imm(const struct bpf_prog *prog,
 	const struct bpf_map *map;
 	int i;
 
+	mutex_lock(&prog->aux->used_maps_mutex);
 	for (i = 0, *off = 0; i < prog->aux->used_map_cnt; i++) {
 		map = prog->aux->used_maps[i];
 		if (map == (void *)addr) {
 			*type = BPF_PSEUDO_MAP_FD;
-			return map;
+			goto out;
 		}
 		if (!map->ops->map_direct_value_meta)
 			continue;
 		if (!map->ops->map_direct_value_meta(map, addr, off)) {
 			*type = BPF_PSEUDO_MAP_VALUE;
-			return map;
+			goto out;
 		}
 	}
+	map = NULL;
 
-	return NULL;
+out:
+	mutex_unlock(&prog->aux->used_maps_mutex);
+	return map;
 }
 
 static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
@@ -3284,6 +3288,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	memcpy(info.tag, prog->tag, sizeof(prog->tag));
 	memcpy(info.name, prog->aux->name, sizeof(prog->aux->name));
 
+	mutex_lock(&prog->aux->used_maps_mutex);
 	ulen = info.nr_map_ids;
 	info.nr_map_ids = prog->aux->used_map_cnt;
 	ulen = min_t(u32, info.nr_map_ids, ulen);
@@ -3293,9 +3298,12 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 
 		for (i = 0; i < ulen; i++)
 			if (put_user(prog->aux->used_maps[i]->id,
-				     &user_map_ids[i]))
+				     &user_map_ids[i])) {
+				mutex_unlock(&prog->aux->used_maps_mutex);
 				return -EFAULT;
+			}
 	}
+	mutex_unlock(&prog->aux->used_maps_mutex);
 
 	err = set_info_rec_size(&info);
 	if (err)
diff --git a/net/core/dev.c b/net/core/dev.c
index b5d1129d8310..6957b31127d9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5441,15 +5441,20 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 	if (new) {
 		u32 i;
 
+		mutex_lock(&new->aux->used_maps_mutex);
+
 		/* generic XDP does not work with DEVMAPs that can
 		 * have a bpf_prog installed on an entry
 		 */
 		for (i = 0; i < new->aux->used_map_cnt; i++) {
-			if (dev_map_can_have_prog(new->aux->used_maps[i]))
-				return -EINVAL;
-			if (cpu_map_prog_allowed(new->aux->used_maps[i]))
+			if (dev_map_can_have_prog(new->aux->used_maps[i]) ||
+			    cpu_map_prog_allowed(new->aux->used_maps[i])) {
+				mutex_unlock(&new->aux->used_maps_mutex);
 				return -EINVAL;
+			}
 		}
+
+		mutex_unlock(&new->aux->used_maps_mutex);
 	}
 
 	switch (xdp->command) {
-- 
2.28.0

