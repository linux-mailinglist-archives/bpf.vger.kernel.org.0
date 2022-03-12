Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1773E4D6BA4
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 02:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiCLBSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 20:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiCLBSj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 20:18:39 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B871A195329
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 17:17:34 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22BIF5UP030041
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 17:17:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=V3ocobQlSUFEQqVZlISDvsn2bQa3VqJo5hFrdrp+/oc=;
 b=BjwHip/5NrsBVwNY/L8gJliSSwNj7yYtdCNgGQ/zyz5Eh+cmaTv0qPKQb65us2RgM+EZ
 dX+4QE0spA15MIAwEXUn3O+Cv8d0GuMtxIi8FWfZ2FKw//fUimKtZqaK9lv1I1Iblbzm
 skfca6FT0Nd7erz/vx/itqIk8aGhMSxuSSo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqee3p1x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 17:17:34 -0800
Received: from twshared36250.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 17:17:33 -0800
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id C33DB98121A2; Fri, 11 Mar 2022 17:17:27 -0800 (PST)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <tj@kernel.org>, <davemarchevsky@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1] bpf: Enable non-atomic allocations in local storage
Date:   Fri, 11 Mar 2022 17:16:43 -0800
Message-ID: <20220312011643.2136370-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wTwwlxqx04lwBtIdhylGa-gpot4YHL9u
X-Proofpoint-ORIG-GUID: wTwwlxqx04lwBtIdhylGa-gpot4YHL9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_10,2022-03-11_02,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

Currently, local storage memory can only be allocated atomically
(GFP_ATOMIC). This restriction is too strict for sleepable bpf
programs.

In this patch, the verifier detects whether the program is sleepable,
and passes the corresponding GFP_KERNEL or GFP_ATOMIC flag as a
5th argument to bpf_task/sk/inode_storage_get. This flag will propagate
down to the local storage functions that allocate memory.

A few things to note:
* bpf_task/sk/inode_storage_update_elem functions are invoked by
userspace applications through syscalls. Preemption is disabled before
bpf_task/sk/inode_storage_update_elem is called, which means they will
always have to allocate memory atomically.

* In bpf_local_storage_update, we have to do the memory charging and
allocation outside the spinlock. There are some cases where it is
permissible for the memory charging and/or allocation to fail, so in
these failure cases, we continue on to determine at a later time whether
the failure is relevant.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf_local_storage.h |  7 +--
 kernel/bpf/bpf_inode_storage.c    |  9 ++--
 kernel/bpf/bpf_local_storage.c    | 77 +++++++++++++++++++++----------
 kernel/bpf/bpf_task_storage.c     | 10 ++--
 kernel/bpf/verifier.c             | 20 ++++++++
 net/core/bpf_sk_storage.c         | 21 +++++----
 6 files changed, 99 insertions(+), 45 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
index 37b3906af8b1..d6905e85399d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -154,16 +154,17 @@ void bpf_selem_unlink_map(struct bpf_local_storage_=
elem *selem);
=20
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *v=
alue,
-		bool charge_mem);
+		gfp_t mem_flags);
=20
 int
 bpf_local_storage_alloc(void *owner,
 			struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *first_selem);
+			struct bpf_local_storage_elem *first_selem,
+			gfp_t mem_flags);
=20
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap=
,
-			 void *value, u64 map_flags);
+			 void *value, u64 map_flags, gfp_t mem_flags);
=20
 void bpf_local_storage_free_rcu(struct rcu_head *rcu);
=20
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storag=
e.c
index e29d9e3d853e..41b0bec1e7e9 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -136,7 +136,7 @@ static int bpf_fd_inode_storage_update_elem(struct bp=
f_map *map, void *key,
=20
 	sdata =3D bpf_local_storage_update(f->f_inode,
 					 (struct bpf_local_storage_map *)map,
-					 value, map_flags);
+					 value, map_flags, GFP_ATOMIC);
 	fput(f);
 	return PTR_ERR_OR_ZERO(sdata);
 }
@@ -169,8 +169,9 @@ static int bpf_fd_inode_storage_delete_elem(struct bp=
f_map *map, void *key)
 	return err;
 }
=20
-BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *,=
 inode,
-	   void *, value, u64, flags)
+/* *mem_flags* is set by the bpf verifier */
+BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *,=
 inode,
+	   void *, value, u64, flags, gfp_t, mem_flags)
 {
 	struct bpf_local_storage_data *sdata;
=20
@@ -196,7 +197,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, m=
ap, struct inode *, inode,
 	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
 		sdata =3D bpf_local_storage_update(
 			inode, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST);
+			BPF_NOEXIST, mem_flags);
 		return IS_ERR(sdata) ? (unsigned long)NULL :
 					     (unsigned long)sdata->data;
 	}
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
index 092a1ac772d7..ca402f9cf1a5 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -63,23 +63,22 @@ static bool selem_linked_to_map(const struct bpf_loca=
l_storage_elem *selem)
=20
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
-		void *value, bool charge_mem)
+		void *value, gfp_t mem_flags)
 {
 	struct bpf_local_storage_elem *selem;
=20
-	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
+	if (mem_charge(smap, owner, smap->elem_size))
 		return NULL;
=20
 	selem =3D bpf_map_kzalloc(&smap->map, smap->elem_size,
-				GFP_ATOMIC | __GFP_NOWARN);
+				mem_flags | __GFP_NOWARN);
 	if (selem) {
 		if (value)
 			memcpy(SDATA(selem)->data, value, smap->map.value_size);
 		return selem;
 	}
=20
-	if (charge_mem)
-		mem_uncharge(smap, owner, smap->elem_size);
+	mem_uncharge(smap, owner, smap->elem_size);
=20
 	return NULL;
 }
@@ -282,7 +281,8 @@ static int check_flags(const struct bpf_local_storage=
_data *old_sdata,
=20
 int bpf_local_storage_alloc(void *owner,
 			    struct bpf_local_storage_map *smap,
-			    struct bpf_local_storage_elem *first_selem)
+			    struct bpf_local_storage_elem *first_selem,
+			    gfp_t mem_flags)
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
@@ -293,7 +293,7 @@ int bpf_local_storage_alloc(void *owner,
 		return err;
=20
 	storage =3D bpf_map_kzalloc(&smap->map, sizeof(*storage),
-				  GFP_ATOMIC | __GFP_NOWARN);
+				  mem_flags | __GFP_NOWARN);
 	if (!storage) {
 		err =3D -ENOMEM;
 		goto uncharge;
@@ -350,13 +350,13 @@ int bpf_local_storage_alloc(void *owner,
  */
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap=
,
-			 void *value, u64 map_flags)
+			 void *value, u64 map_flags, gfp_t mem_flags)
 {
 	struct bpf_local_storage_data *old_sdata =3D NULL;
 	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage *local_storage;
 	unsigned long flags;
-	int err;
+	int err, charge_err;
=20
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
 	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
@@ -373,11 +373,11 @@ bpf_local_storage_update(void *owner, struct bpf_lo=
cal_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
=20
-		selem =3D bpf_selem_alloc(smap, owner, value, true);
+		selem =3D bpf_selem_alloc(smap, owner, value, mem_flags);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
=20
-		err =3D bpf_local_storage_alloc(owner, smap, selem);
+		err =3D bpf_local_storage_alloc(owner, smap, selem, mem_flags);
 		if (err) {
 			kfree(selem);
 			mem_uncharge(smap, owner, smap->elem_size);
@@ -404,6 +404,19 @@ bpf_local_storage_update(void *owner, struct bpf_loc=
al_storage_map *smap,
 		}
 	}
=20
+	/* Since mem_flags can be non-atomic, we need to do the memory
+	 * allocation outside the spinlock.
+	 *
+	 * There are a few cases where it is permissible for the memory charge
+	 * and allocation to fail (eg if BPF_F_LOCK is set and a local storage
+	 * value already exists, we can swap values without needing an
+	 * allocation), so in the case of a failure here, continue on and see
+	 * if the failure is relevant.
+	 */
+	charge_err =3D mem_charge(smap, owner, smap->elem_size);
+	selem =3D bpf_map_kzalloc(&smap->map, smap->elem_size,
+				mem_flags | __GFP_NOWARN);
+
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
=20
 	/* Recheck local_storage->list under local_storage->lock */
@@ -425,25 +438,37 @@ bpf_local_storage_update(void *owner, struct bpf_lo=
cal_storage_map *smap,
 	if (old_sdata && (map_flags & BPF_F_LOCK)) {
 		copy_map_value_locked(&smap->map, old_sdata->data, value,
 				      false);
-		selem =3D SELEM(old_sdata);
-		goto unlock;
+
+		raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+
+		if (!charge_err)
+			mem_uncharge(smap, owner, smap->elem_size);
+		kfree(selem);
+
+		return old_sdata;
+	}
+
+	if (!old_sdata && charge_err) {
+		/* If there is no existing local storage value, then this means
+		 * we needed the charge to succeed. We must make sure this did not
+		 * return an error.
+		 *
+		 * Please note that if an existing local storage value exists, then
+		 * it doesn't matter if the charge failed because we can just
+		 * "reuse" the charge from the existing local storage element.
+		 */
+		err =3D charge_err;
+		goto unlock_err;
 	}
=20
-	/* local_storage->lock is held.  Hence, we are sure
-	 * we can unlink and uncharge the old_sdata successfully
-	 * later.  Hence, instead of charging the new selem now
-	 * and then uncharge the old selem later (which may cause
-	 * a potential but unnecessary charge failure),  avoid taking
-	 * a charge at all here (the "!old_sdata" check) and the
-	 * old_sdata will not be uncharged later during
-	 * bpf_selem_unlink_storage_nolock().
-	 */
-	selem =3D bpf_selem_alloc(smap, owner, value, !old_sdata);
 	if (!selem) {
 		err =3D -ENOMEM;
 		goto unlock_err;
 	}
=20
+	if (value)
+		memcpy(SDATA(selem)->data, value, smap->map.value_size);
+
 	/* First, link the new selem to the map */
 	bpf_selem_link_map(smap, selem);
=20
@@ -454,15 +479,17 @@ bpf_local_storage_update(void *owner, struct bpf_lo=
cal_storage_map *smap,
 	if (old_sdata) {
 		bpf_selem_unlink_map(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
-						false);
+						!charge_err);
 	}
=20
-unlock:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	return SDATA(selem);
=20
 unlock_err:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	if (!charge_err)
+		mem_uncharge(smap, owner, smap->elem_size);
+	kfree(selem);
 	return ERR_PTR(err);
 }
=20
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
index 5da7bed0f5f6..bb9e22bad42b 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -174,7 +174,8 @@ static int bpf_pid_task_storage_update_elem(struct bp=
f_map *map, void *key,
=20
 	bpf_task_storage_lock();
 	sdata =3D bpf_local_storage_update(
-		task, (struct bpf_local_storage_map *)map, value, map_flags);
+		task, (struct bpf_local_storage_map *)map, value, map_flags,
+		GFP_ATOMIC);
 	bpf_task_storage_unlock();
=20
 	err =3D PTR_ERR_OR_ZERO(sdata);
@@ -226,8 +227,9 @@ static int bpf_pid_task_storage_delete_elem(struct bp=
f_map *map, void *key)
 	return err;
 }
=20
-BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_stru=
ct *,
-	   task, void *, value, u64, flags)
+/* *mem_flags* is set by the bpf verifier */
+BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_stru=
ct *,
+	   task, void *, value, u64, flags, gfp_t, mem_flags)
 {
 	struct bpf_local_storage_data *sdata;
=20
@@ -250,7 +252,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, ma=
p, struct task_struct *,
 	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
 		sdata =3D bpf_local_storage_update(
 			task, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST);
+			BPF_NOEXIST, mem_flags);
=20
 unlock:
 	bpf_task_storage_unlock();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0db6cd8dcb35..392fdaabedbd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13491,6 +13491,26 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
 			goto patch_call_imm;
 		}
=20
+		if (insn->imm =3D=3D BPF_FUNC_task_storage_get ||
+		    insn->imm =3D=3D BPF_FUNC_sk_storage_get ||
+		    insn->imm =3D=3D BPF_FUNC_inode_storage_get) {
+			if (env->prog->aux->sleepable)
+				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, GFP_KERNEL);
+			else
+				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, GFP_ATOMIC);
+			insn_buf[1] =3D *insn;
+			cnt =3D 2;
+
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta +=3D cnt - 1;
+			env->prog =3D prog =3D new_prog;
+			insn =3D new_prog->insnsi + i + delta;
+			goto patch_call_imm;
+		}
+
 		/* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
 		 * and other inlining handlers are currently limited to 64 bit
 		 * only.
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d9c37fd10809..8790a3791d39 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -141,7 +141,7 @@ static int bpf_fd_sk_storage_update_elem(struct bpf_m=
ap *map, void *key,
 	if (sock) {
 		sdata =3D bpf_local_storage_update(
 			sock->sk, (struct bpf_local_storage_map *)map, value,
-			map_flags);
+			map_flags, GFP_ATOMIC);
 		sockfd_put(sock);
 		return PTR_ERR_OR_ZERO(sdata);
 	}
@@ -172,7 +172,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 {
 	struct bpf_local_storage_elem *copy_selem;
=20
-	copy_selem =3D bpf_selem_alloc(smap, newsk, NULL, true);
+	copy_selem =3D bpf_selem_alloc(smap, newsk, NULL, GFP_ATOMIC);
 	if (!copy_selem)
 		return NULL;
=20
@@ -230,7 +230,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struc=
t sock *newsk)
 			bpf_selem_link_map(smap, copy_selem);
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
-			ret =3D bpf_local_storage_alloc(newsk, smap, copy_selem);
+			ret =3D bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
 			if (ret) {
 				kfree(copy_selem);
 				atomic_sub(smap->elem_size,
@@ -255,8 +255,9 @@ int bpf_sk_storage_clone(const struct sock *sk, struc=
t sock *newsk)
 	return ret;
 }
=20
-BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
-	   void *, value, u64, flags)
+/* *mem_flags* is set by the bpf verifier */
+BPF_CALL_5(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
+	   void *, value, u64, flags, gfp_t, mem_flags)
 {
 	struct bpf_local_storage_data *sdata;
=20
@@ -277,7 +278,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map,=
 struct sock *, sk,
 	    refcount_inc_not_zero(&sk->sk_refcnt)) {
 		sdata =3D bpf_local_storage_update(
 			sk, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST);
+			BPF_NOEXIST, mem_flags);
 		/* sk must be a fullsock (guaranteed by verifier),
 		 * so sock_gen_put() is unnecessary.
 		 */
@@ -417,14 +418,16 @@ static bool bpf_sk_storage_tracing_allowed(const st=
ruct bpf_prog *prog)
 	return false;
 }
=20
-BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct soc=
k *, sk,
-	   void *, value, u64, flags)
+/* *mem_flags* is set by the bpf verifier */
+BPF_CALL_5(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct soc=
k *, sk,
+	   void *, value, u64, flags, gfp_t, mem_flags)
 {
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (in_hardirq() || in_nmi())
 		return (unsigned long)NULL;
=20
-	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags);
+	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags,
+						     mem_flags);
 }
=20
 BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
--=20
2.30.2

