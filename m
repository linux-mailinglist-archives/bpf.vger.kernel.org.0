Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20A2635E7
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 20:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIISYv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 14:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgIISYL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 14:24:11 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5315C061756
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 11:24:10 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c19so1889926qkk.20
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Mb1wpxLg+WPshxg8hW0KZaBe8xQNVYj08rdgm6WIKUs=;
        b=v3rHy8l4O4XcgnS/SG1JoVGdg/JxSSNnU4zRmO6uYEW1x9Ou0xuv0i6pwtMFYmajqR
         VHDp1wFDL0imgnrk860wI9IBTn0xMKL/5MpJvFqDPTWcHCF7aLgORm97TaCluInrjqiu
         aYidRYGPZrc+H2UnZaqBg0bhEOq/E42v0qB2MCEelYBzDY9dPeRuINpbP+AryczO/PU5
         b1PY2Q8FT4gy0QEXtZdSmtb3c/gaY9IUpFfXDYS+ATm4gUn2rKCHFPWTP8Cr29GbUVaD
         ds/+Bh7zwSLVV2JjyGTIhyFwGNBfUpYYHuH0i+dUHFJhuN0wzYNOiQczaY/uOZLJOjDL
         9nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mb1wpxLg+WPshxg8hW0KZaBe8xQNVYj08rdgm6WIKUs=;
        b=kppGSfG8AnlLeScCRO0Q0X+5PnFo7W/42+ge+X7vTjBSvFh9cJnxJSVVAoEWKDo3jk
         1A0HuaMt5o7IzYc6P2Suht+lTLct1Sj9vSdb0QvFKGnvgRBGgQzR4EprR/SmXLbhRsXb
         /t/YrpJM0gew4REE162N9guwe7EmqrtsDV4iHbiOZ58ItjzykJvuxkAHlGfBzn//ImtZ
         MrIpX+J2J5wtvWxUIbdXSvhIhYXn5dAH6Dkpb2GaGZIPnVjRu5BwEt+fQPol/ViTvVZr
         IeQ4Xr08YBGkHKNgZj3JBwWzqcBz31k3Bzmaycdo17z7Cg34F/+J+e3HJK4RtD+TjOq+
         q9AQ==
X-Gm-Message-State: AOAM532rAEJVnlVofRYcM11mKI8d+X5Zd5o1RmraDcM3RvXJqhuHSm+g
        ijfqfDqGPmfyzH5opMixOKv20Bw=
X-Google-Smtp-Source: ABdhPJw/dtX0CYJkOR/cCr/DLoGe3D3nkdQom6YXgODmilt5Gi8WcMGqNU/oMtLqIeVxt1s3jSX07+A=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a05:6214:7a1:: with SMTP id
 v1mr5442131qvz.19.1599675849865; Wed, 09 Sep 2020 11:24:09 -0700 (PDT)
Date:   Wed,  9 Sep 2020 11:24:02 -0700
In-Reply-To: <20200909182406.3147878-1-sdf@google.com>
Message-Id: <20200909182406.3147878-2-sdf@google.com>
Mime-Version: 1.0
References: <20200909182406.3147878-1-sdf@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH bpf-next v4 1/5] bpf: Mutex protect used_maps array and count
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        YiFei Zhu <zhuyifei@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
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
index c6d9f2c444f4..5dcce0364634 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -751,6 +751,7 @@ struct bpf_prog_aux {
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
index 4108ef3b828b..a67b8c6746be 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3162,21 +3162,25 @@ static const struct bpf_map *bpf_map_from_imm(const struct bpf_prog *prog,
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
@@ -3294,6 +3298,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	memcpy(info.tag, prog->tag, sizeof(prog->tag));
 	memcpy(info.name, prog->aux->name, sizeof(prog->aux->name));
 
+	mutex_lock(&prog->aux->used_maps_mutex);
 	ulen = info.nr_map_ids;
 	info.nr_map_ids = prog->aux->used_map_cnt;
 	ulen = min_t(u32, info.nr_map_ids, ulen);
@@ -3303,9 +3308,12 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 
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
index d42c9ea0c3c0..75d7f91337d9 100644
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
2.28.0.526.ge36021eeef-goog

