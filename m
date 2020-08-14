Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C78A244EBD
	for <lists+bpf@lfdr.de>; Fri, 14 Aug 2020 21:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHNTQE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Aug 2020 15:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgHNTQD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Aug 2020 15:16:03 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88598C061385
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2020 12:16:03 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z3so9368522ilh.3
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2020 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvPRHFnkNbXE5owds5CXbk8m7oRd00WsS93Qd2kI5oU=;
        b=CAYVXZPXrm/OasK0OIzMTI5vGoL8CgANydQRipm0ZTQztufWJyjL7uW2XmkW9AUB1a
         LAdAQO8pmXpvUWOuQIUxhWTIV1FVRQkXBcRBeCJIxFvMfnkVcdg5AmcTm5Wqr+kbb68C
         ocvADRP/7QGbFEP+swpgKGUQdSqkaN/WzIXfU+GRzemjXVkQQYimolFnbxfUxy2ADfBe
         ankkfcsK25HQcqRoYgwrUrI1Zzrc8oEFE9F67HrerrWS4pCLqAS5QEn0dLLRQqLulcfD
         q8XzKm2s4p+AgzD9dt5v8aQCi/nqJGk7gd8X8n+hDy+MUSPSAMyGX6LH2YRVPoDB8xuV
         mtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvPRHFnkNbXE5owds5CXbk8m7oRd00WsS93Qd2kI5oU=;
        b=rh1ALitL7NGEKhhpgpClvQnZSTZFJX3A0u/88IIw8b2YSWR6CcGryLSkETQe5H14Cl
         9AxxxHKXZ3b+WwaY0ytcZkHRKWBfiYDFKTE8nHWONYPe6lFHLT+leLLUZX7h9A5D2nzy
         amAKpZK86SBRgQDZHlb2DlRDqnZ2qs0kK1vPF4586XQeaFSM+qo7KMUCYTNMyt5rcwrI
         oKypeJyPlMSx+qRf1QCJRg/4WlH6TZ+EWc9jfUq/GFphGo5CeA3S5yzmWCdUzltvxOjS
         D3G793Mc13b5fCVJRh5i9izFrE3rhJwpmkX8ORdbAd2oBatq5+jUlT3Bs5mongO7nN+u
         C8pQ==
X-Gm-Message-State: AOAM533+rKCAKQujLhUD0vAomKv3DlOmljWcmNd49ETIPo2I5FmNPBPZ
        6BJr+w9Cfr/PElAo6IEmT34FqFpQ91nJiQ==
X-Google-Smtp-Source: ABdhPJzdV8h+iysJ2bfLqCQNIGyArmmIQumgtiqWJuJYXJJVOWDFmZDSAOeCfQ01AVJN+IXKdVi4Qw==
X-Received: by 2002:a92:8708:: with SMTP id m8mr3861964ild.19.1597432562598;
        Fri, 14 Aug 2020 12:16:02 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id f15sm4521028ilc.51.2020.08.14.12.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 12:16:01 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [RFC PATCH bpf-next 1/5] bpf: RCU protect used_maps array and count
Date:   Fri, 14 Aug 2020 14:15:54 -0500
Message-Id: <7e37411ca33ae89e2a98dd95707a35caf2fd542e.1597427271.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597427271.git.zhuyifei@google.com>
References: <cover.1597427271.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

To support modifying the used_maps array, we use RCU to protect the
use of the counter and the array. A mutex is used as the write-side
lock, and it is initialized in the verifier where the rcu struct is
allocated.

Most uses are non-sleeping and very straight forward, just holding
rcu_read_lock. bpf_check_tail_call can be called for a cBPF map
(by bpf_prog_select_runtime, bpf_migrate_filter) so an extra check
is added for the case when the program did not pass through the
eBPF verifier and the used_maps pointer is NULL.

The Netronome driver does allocate memory while reading the used_maps
array so for simplicity it is made to hold the write-side lock.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../net/ethernet/netronome/nfp/bpf/offload.c  | 33 +++++++++++------
 include/linux/bpf.h                           | 11 +++++-
 kernel/bpf/core.c                             | 25 ++++++++++---
 kernel/bpf/syscall.c                          | 19 ++++++++--
 kernel/bpf/verifier.c                         | 37 +++++++++++++------
 net/core/dev.c                                | 12 ++++--
 6 files changed, 100 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/offload.c b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
index ac02369174a9..74ed42b678e2 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
@@ -111,34 +111,45 @@ static int
 nfp_map_ptrs_record(struct nfp_app_bpf *bpf, struct nfp_prog *nfp_prog,
 		    struct bpf_prog *prog)
 {
-	int i, cnt, err;
+	struct bpf_used_maps *used_maps;
+	int i, cnt, err = 0;
+
+	/* We are calling sleepable functions while reading used_maps array */
+	mutex_lock(&prog->aux->used_maps_mutex);
+
+	used_maps = rcu_dereference_protected(prog->aux->used_maps,
+			lockdep_is_held(&prog->aux->used_maps_mutex));
 
 	/* Quickly count the maps we will have to remember */
 	cnt = 0;
-	for (i = 0; i < prog->aux->used_map_cnt; i++)
-		if (bpf_map_offload_neutral(prog->aux->used_maps[i]))
+	for (i = 0; i < used_maps->cnt; i++)
+		if (bpf_map_offload_neutral(used_maps->arr[i]))
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
 
-	for (i = 0; i < prog->aux->used_map_cnt; i++)
-		if (bpf_map_offload_neutral(prog->aux->used_maps[i])) {
+	for (i = 0; i < used_maps->cnt; i++)
+		if (bpf_map_offload_neutral(used_maps->arr[i])) {
 			err = nfp_map_ptr_record(bpf, nfp_prog,
-						 prog->aux->used_maps[i]);
+						 used_maps->arr[i]);
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
index cef4ef0d2b4e..417189b4061d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -689,9 +689,15 @@ struct bpf_ctx_arg_aux {
 	u32 btf_id;
 };
 
+/* rcu struct for prog used_maps */
+struct bpf_used_maps {
+	u32 cnt;
+	struct bpf_map **arr;
+	struct rcu_head rcu;
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
-	u32 used_map_cnt;
 	u32 max_ctx_offset;
 	u32 max_pkt_offset;
 	u32 max_tp_access;
@@ -722,7 +728,8 @@ struct bpf_prog_aux {
 	u32 size_poke_tab;
 	struct bpf_ksym ksym;
 	const struct bpf_prog_ops *ops;
-	struct bpf_map **used_maps;
+	struct mutex used_maps_mutex; /* write-side mutex for used_maps */
+	struct bpf_used_maps __rcu *used_maps;
 	struct bpf_prog *prog;
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index bde93344164d..9766aa0337d9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1746,11 +1746,16 @@ bool bpf_prog_array_compatible(struct bpf_array *array,
 
 static int bpf_check_tail_call(const struct bpf_prog *fp)
 {
-	struct bpf_prog_aux *aux = fp->aux;
+	const struct bpf_used_maps *used_maps;
 	int i;
 
-	for (i = 0; i < aux->used_map_cnt; i++) {
-		struct bpf_map *map = aux->used_maps[i];
+	rcu_read_lock();
+	used_maps = rcu_dereference(fp->aux->used_maps);
+	if (!used_maps)
+		goto out;
+
+	for (i = 0; i < used_maps->cnt; i++) {
+		struct bpf_map *map = used_maps->arr[i];
 		struct bpf_array *array;
 
 		if (map->map_type != BPF_MAP_TYPE_PROG_ARRAY)
@@ -1761,6 +1766,8 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
 			return -EINVAL;
 	}
 
+out:
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -2113,8 +2120,16 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 
 static void bpf_free_used_maps(struct bpf_prog_aux *aux)
 {
-	__bpf_free_used_maps(aux, aux->used_maps, aux->used_map_cnt);
-	kfree(aux->used_maps);
+	struct bpf_used_maps *used_maps = aux->used_maps;
+
+	if (!used_maps)
+		return;
+
+	__bpf_free_used_maps(aux, used_maps->arr, used_maps->cnt);
+	kfree(used_maps->arr);
+	kfree(used_maps);
+
+	mutex_destroy(&aux->used_maps_mutex);
 }
 
 static void bpf_prog_free_deferred(struct work_struct *work)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2f343ce15747..3fde9dc4b595 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3149,11 +3149,15 @@ static const struct bpf_map *bpf_map_from_imm(const struct bpf_prog *prog,
 					      unsigned long addr, u32 *off,
 					      u32 *type)
 {
+	const struct bpf_used_maps *used_maps;
 	const struct bpf_map *map;
 	int i;
 
-	for (i = 0, *off = 0; i < prog->aux->used_map_cnt; i++) {
-		map = prog->aux->used_maps[i];
+	rcu_read_lock();
+	used_maps = rcu_dereference(prog->aux->used_maps);
+
+	for (i = 0, *off = 0; i < used_maps->cnt; i++) {
+		map = used_maps->arr[i];
 		if (map == (void *)addr) {
 			*type = BPF_PSEUDO_MAP_FD;
 			return map;
@@ -3166,6 +3170,7 @@ static const struct bpf_map *bpf_map_from_imm(const struct bpf_prog *prog,
 		}
 	}
 
+	rcu_read_unlock();
 	return NULL;
 }
 
@@ -3263,6 +3268,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	struct bpf_prog_stats stats;
 	char __user *uinsns;
 	u32 ulen;
+	const struct bpf_used_maps *used_maps;
 	int err;
 
 	err = bpf_check_uarg_tail_zero(uinfo, sizeof(info), info_len);
@@ -3284,19 +3290,24 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	memcpy(info.tag, prog->tag, sizeof(prog->tag));
 	memcpy(info.name, prog->aux->name, sizeof(prog->aux->name));
 
+	rcu_read_lock();
+	used_maps = rcu_dereference(prog->aux->used_maps);
+
 	ulen = info.nr_map_ids;
-	info.nr_map_ids = prog->aux->used_map_cnt;
+	info.nr_map_ids = used_maps->cnt;
 	ulen = min_t(u32, info.nr_map_ids, ulen);
 	if (ulen) {
 		u32 __user *user_map_ids = u64_to_user_ptr(info.map_ids);
 		u32 i;
 
 		for (i = 0; i < ulen; i++)
-			if (put_user(prog->aux->used_maps[i]->id,
+			if (put_user(used_maps->arr[i]->id,
 				     &user_map_ids[i]))
 				return -EFAULT;
 	}
 
+	rcu_read_unlock();
+
 	err = set_info_rec_size(&info);
 	if (err)
 		return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6ccfce3bf4c..9a6ca16667c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11232,25 +11232,38 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 		goto err_release_maps;
 	}
 
-	if (ret == 0 && env->used_map_cnt) {
+	if (ret == 0) {
 		/* if program passed verifier, update used_maps in bpf_prog_info */
-		env->prog->aux->used_maps = kmalloc_array(env->used_map_cnt,
-							  sizeof(env->used_maps[0]),
+		struct bpf_used_maps *used_maps = kzalloc(sizeof(*used_maps),
 							  GFP_KERNEL);
-
-		if (!env->prog->aux->used_maps) {
+		if (!used_maps) {
 			ret = -ENOMEM;
 			goto err_release_maps;
 		}
 
-		memcpy(env->prog->aux->used_maps, env->used_maps,
-		       sizeof(env->used_maps[0]) * env->used_map_cnt);
-		env->prog->aux->used_map_cnt = env->used_map_cnt;
+		if (env->used_map_cnt) {
+			used_maps->arr = kmalloc_array(env->used_map_cnt,
+						       sizeof(env->used_maps[0]),
+						       GFP_KERNEL);
 
-		/* program is valid. Convert pseudo bpf_ld_imm64 into generic
-		 * bpf_ld_imm64 instructions
-		 */
-		convert_pseudo_ld_imm64(env);
+			if (!used_maps->arr) {
+				kfree(used_maps);
+				ret = -ENOMEM;
+				goto err_release_maps;
+			}
+
+			memcpy(used_maps->arr, env->used_maps,
+			       sizeof(env->used_maps[0]) * env->used_map_cnt);
+			used_maps->cnt = env->used_map_cnt;
+
+			/* program is valid. Convert pseudo bpf_ld_imm64 into generic
+			 * bpf_ld_imm64 instructions
+			 */
+			convert_pseudo_ld_imm64(env);
+		}
+
+		env->prog->aux->used_maps = used_maps;
+		mutex_init(&env->prog->aux->used_maps_mutex);
 	}
 
 	if (ret == 0)
diff --git a/net/core/dev.c b/net/core/dev.c
index 7df6c9617321..bebbf8abd9a7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5439,17 +5439,23 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 	int ret = 0;
 
 	if (new) {
+		const struct bpf_used_maps *used_maps;
 		u32 i;
 
+		rcu_read_lock();
+		used_maps = rcu_dereference(new->aux->used_maps);
+
 		/* generic XDP does not work with DEVMAPs that can
 		 * have a bpf_prog installed on an entry
 		 */
-		for (i = 0; i < new->aux->used_map_cnt; i++) {
-			if (dev_map_can_have_prog(new->aux->used_maps[i]))
+		for (i = 0; i < used_maps->cnt; i++) {
+			if (dev_map_can_have_prog(used_maps->arr[i]))
 				return -EINVAL;
-			if (cpu_map_prog_allowed(new->aux->used_maps[i]))
+			if (cpu_map_prog_allowed(used_maps->arr[i]))
 				return -EINVAL;
 		}
+
+		rcu_read_unlock();
 	}
 
 	switch (xdp->command) {
-- 
2.28.0

