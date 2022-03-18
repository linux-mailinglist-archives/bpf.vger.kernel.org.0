Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B074DD406
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 05:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiCRE6M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 00:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiCRE6L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 00:58:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2FB268C03
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 21:56:53 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I14ja1024687
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 21:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0W+dWghVG9zVJmkvYMkoNQY2Vh+BYmK1TxmHXwx2p4I=;
 b=boB8OldiSf929Fxl0/w/xy4/0bh4bl26BkKShk9VcWbCxZiJDefrB6GrLS+eVPVn4Kbg
 jdaQ0fH96AbTcxEo3GbKowp1YkMC1NBLSAqzOKzSy1hri5691ddrCkWaE9QvC3jSD9CF
 vktPyV53uoUACiQDoH32iOFhS7PQYqJX/Kc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3evg3kgt3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 21:56:52 -0700
Received: from twshared14141.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 21:56:51 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id F03E89C8E64D; Thu, 17 Mar 2022 21:56:44 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kafai@fb.com>, <kpsingh@kernel.org>, <memxor@gmail.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <tj@kernel.org>, <davemarchevsky@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: Enable non-atomic allocations in local storage
Date:   Thu, 17 Mar 2022 21:55:52 -0700
Message-ID: <20220318045553.3091807-2-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220318045553.3091807-1-joannekoong@fb.com>
References: <20220318045553.3091807-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: QJQCo0FgzxN992x7-UGD9wqnDrYaGPmY
X-Proofpoint-ORIG-GUID: QJQCo0FgzxN992x7-UGD9wqnDrYaGPmY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_05,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Please note that bpf_task/sk/inode_storage_update_elem functions are
invoked by userspace applications through syscalls. Preemption is
disabled before bpf_task/sk/inode_storage_update_elem is called, which
means they will always have to allocate memory atomically.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: KP Singh <kpsingh@kernel.org>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf_local_storage.h |  7 ++--
 kernel/bpf/bpf_inode_storage.c    |  9 ++---
 kernel/bpf/bpf_local_storage.c    | 58 ++++++++++++++++++++-----------
 kernel/bpf/bpf_task_storage.c     | 10 +++---
 kernel/bpf/verifier.c             | 20 +++++++++++
 net/core/bpf_sk_storage.c         | 21 ++++++-----
 6 files changed, 84 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
index 37b3906af8b1..493e63258497 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -154,16 +154,17 @@ void bpf_selem_unlink_map(struct bpf_local_storage_=
elem *selem);
=20
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *v=
alue,
-		bool charge_mem);
+		bool charge_mem, gfp_t gfp_flags);
=20
 int
 bpf_local_storage_alloc(void *owner,
 			struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *first_selem);
+			struct bpf_local_storage_elem *first_selem,
+			gfp_t gfp_flags);
=20
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap=
,
-			 void *value, u64 map_flags);
+			 void *value, u64 map_flags, gfp_t gfp_flags);
=20
 void bpf_local_storage_free_rcu(struct rcu_head *rcu);
=20
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storag=
e.c
index e29d9e3d853e..96be8d518885 100644
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
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *,=
 inode,
+	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
=20
@@ -196,7 +197,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, m=
ap, struct inode *, inode,
 	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
 		sdata =3D bpf_local_storage_update(
 			inode, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST);
+			BPF_NOEXIST, gfp_flags);
 		return IS_ERR(sdata) ? (unsigned long)NULL :
 					     (unsigned long)sdata->data;
 	}
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
index 092a1ac772d7..01aa2b51ec4d 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -63,7 +63,7 @@ static bool selem_linked_to_map(const struct bpf_local_=
storage_elem *selem)
=20
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
-		void *value, bool charge_mem)
+		void *value, bool charge_mem, gfp_t gfp_flags)
 {
 	struct bpf_local_storage_elem *selem;
=20
@@ -71,7 +71,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, voi=
d *owner,
 		return NULL;
=20
 	selem =3D bpf_map_kzalloc(&smap->map, smap->elem_size,
-				GFP_ATOMIC | __GFP_NOWARN);
+				gfp_flags | __GFP_NOWARN);
 	if (selem) {
 		if (value)
 			memcpy(SDATA(selem)->data, value, smap->map.value_size);
@@ -282,7 +282,8 @@ static int check_flags(const struct bpf_local_storage=
_data *old_sdata,
=20
 int bpf_local_storage_alloc(void *owner,
 			    struct bpf_local_storage_map *smap,
-			    struct bpf_local_storage_elem *first_selem)
+			    struct bpf_local_storage_elem *first_selem,
+			    gfp_t gfp_flags)
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
@@ -293,7 +294,7 @@ int bpf_local_storage_alloc(void *owner,
 		return err;
=20
 	storage =3D bpf_map_kzalloc(&smap->map, sizeof(*storage),
-				  GFP_ATOMIC | __GFP_NOWARN);
+				  gfp_flags | __GFP_NOWARN);
 	if (!storage) {
 		err =3D -ENOMEM;
 		goto uncharge;
@@ -350,10 +351,10 @@ int bpf_local_storage_alloc(void *owner,
  */
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap=
,
-			 void *value, u64 map_flags)
+			 void *value, u64 map_flags, gfp_t gfp_flags)
 {
 	struct bpf_local_storage_data *old_sdata =3D NULL;
-	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_elem *selem =3D NULL;
 	struct bpf_local_storage *local_storage;
 	unsigned long flags;
 	int err;
@@ -365,6 +366,9 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
 		     !map_value_has_spin_lock(&smap->map)))
 		return ERR_PTR(-EINVAL);
=20
+	if (gfp_flags =3D=3D GFP_KERNEL && (map_flags & ~BPF_F_LOCK) !=3D BPF_N=
OEXIST)
+		return ERR_PTR(-EINVAL);
+
 	local_storage =3D rcu_dereference_check(*owner_storage(smap, owner),
 					      bpf_rcu_lock_held());
 	if (!local_storage || hlist_empty(&local_storage->list)) {
@@ -373,11 +377,11 @@ bpf_local_storage_update(void *owner, struct bpf_lo=
cal_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
=20
-		selem =3D bpf_selem_alloc(smap, owner, value, true);
+		selem =3D bpf_selem_alloc(smap, owner, value, true, gfp_flags);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
=20
-		err =3D bpf_local_storage_alloc(owner, smap, selem);
+		err =3D bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
 		if (err) {
 			kfree(selem);
 			mem_uncharge(smap, owner, smap->elem_size);
@@ -404,6 +408,12 @@ bpf_local_storage_update(void *owner, struct bpf_loc=
al_storage_map *smap,
 		}
 	}
=20
+	if (gfp_flags =3D=3D GFP_KERNEL) {
+		selem =3D bpf_selem_alloc(smap, owner, value, true, gfp_flags);
+		if (!selem)
+			return ERR_PTR(-ENOMEM);
+	}
+
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
=20
 	/* Recheck local_storage->list under local_storage->lock */
@@ -429,19 +439,21 @@ bpf_local_storage_update(void *owner, struct bpf_lo=
cal_storage_map *smap,
 		goto unlock;
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
-	if (!selem) {
-		err =3D -ENOMEM;
-		goto unlock_err;
+	if (gfp_flags !=3D GFP_KERNEL) {
+		/* local_storage->lock is held.  Hence, we are sure
+		 * we can unlink and uncharge the old_sdata successfully
+		 * later.  Hence, instead of charging the new selem now
+		 * and then uncharge the old selem later (which may cause
+		 * a potential but unnecessary charge failure),  avoid taking
+		 * a charge at all here (the "!old_sdata" check) and the
+		 * old_sdata will not be uncharged later during
+		 * bpf_selem_unlink_storage_nolock().
+		 */
+		selem =3D bpf_selem_alloc(smap, owner, value, !old_sdata, gfp_flags);
+		if (!selem) {
+			err =3D -ENOMEM;
+			goto unlock_err;
+		}
 	}
=20
 	/* First, link the new selem to the map */
@@ -463,6 +475,10 @@ bpf_local_storage_update(void *owner, struct bpf_loc=
al_storage_map *smap,
=20
 unlock_err:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	if (selem) {
+		mem_uncharge(smap, owner, smap->elem_size);
+		kfree(selem);
+	}
 	return ERR_PTR(err);
 }
=20
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
index 5da7bed0f5f6..6638a0ecc3d2 100644
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
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_stru=
ct *,
+	   task, void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
=20
@@ -250,7 +252,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, ma=
p, struct task_struct *,
 	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
 		sdata =3D bpf_local_storage_update(
 			task, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST);
+			BPF_NOEXIST, gfp_flags);
=20
 unlock:
 	bpf_task_storage_unlock();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0db6cd8dcb35..1bad55092c6b 100644
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
+				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__s32)GFP_KERNEL);
+			else
+				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__s32)GFP_ATOMIC);
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
index d9c37fd10809..7aff1206a851 100644
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
+	copy_selem =3D bpf_selem_alloc(smap, newsk, NULL, true, GFP_ATOMIC);
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
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
+	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
=20
@@ -277,7 +278,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map,=
 struct sock *, sk,
 	    refcount_inc_not_zero(&sk->sk_refcnt)) {
 		sdata =3D bpf_local_storage_update(
 			sk, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST);
+			BPF_NOEXIST, gfp_flags);
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
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct soc=
k *, sk,
+	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (in_hardirq() || in_nmi())
 		return (unsigned long)NULL;
=20
-	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags);
+	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags,
+						     gfp_flags);
 }
=20
 BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
--=20
2.30.2

