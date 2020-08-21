Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B4924D811
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgHUPLv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 11:11:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36222 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727885AbgHUPLq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 11:11:46 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LF9iKH016935
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:11:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rOMcJoqO6LoNoNGEqRkGc+B9+ZjVTndOVm1AgL/XIzw=;
 b=hJy2l3x4znissEWg360nkJxc29XUdTwZnWrdKYwOorfD4ofwh+PYRHopPw6E5/29tXrZ
 D62nsn2ldO46gSyS1/DzDJi6dIZjil5XmmDSrBncvybNwTpsOvhgplmwI6B5I7mwxrT1
 lWc3D+0MNHzn1w8BH0GRA4cl+wOSxx8a7TQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 331crbj7m2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 08:11:45 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 08:11:43 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id B9D4C3441081; Fri, 21 Aug 2020 08:01:35 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v4 29/30] bpf: eliminate rlimit-based memory accounting for bpf progs
Date:   Fri, 21 Aug 2020 08:01:33 -0700
Message-ID: <20200821150134.2581465-30-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200821150134.2581465-1-guro@fb.com>
References: <20200821150134.2581465-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 suspectscore=38 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for bpf progs. It has been
replaced with memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 include/linux/bpf.h  | 11 ------
 kernel/bpf/core.c    | 12 ++-----
 kernel/bpf/syscall.c | 86 ++++++--------------------------------------
 3 files changed, 12 insertions(+), 97 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7f81cbb981a6..148fdc8755b2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1126,8 +1126,6 @@ void bpf_prog_sub(struct bpf_prog *prog, int i);
 void bpf_prog_inc(struct bpf_prog *prog);
 struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *pr=
og);
 void bpf_prog_put(struct bpf_prog *prog);
-int __bpf_prog_charge(struct user_struct *user, u32 pages);
-void __bpf_prog_uncharge(struct user_struct *user, u32 pages);
 void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 			  struct bpf_map **used_maps, u32 len);
=20
@@ -1388,15 +1386,6 @@ bpf_prog_inc_not_zero(struct bpf_prog *prog)
 	return ERR_PTR(-EOPNOTSUPP);
 }
=20
-static inline int __bpf_prog_charge(struct user_struct *user, u32 pages)
-{
-	return 0;
-}
-
-static inline void __bpf_prog_uncharge(struct user_struct *user, u32 pag=
es)
-{
-}
-
 static inline void bpf_link_init(struct bpf_link *link, enum bpf_link_ty=
pe type,
 				 const struct bpf_link_ops *ops,
 				 struct bpf_prog *prog)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 021fff2df81b..fe94ccad8059 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -219,23 +219,15 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *=
fp_old, unsigned int size,
 {
 	gfp_t gfp_flags =3D GFP_KERNEL_ACCOUNT | __GFP_ZERO | gfp_extra_flags;
 	struct bpf_prog *fp;
-	u32 pages, delta;
-	int ret;
+	u32 pages;
=20
 	size =3D round_up(size, PAGE_SIZE);
 	pages =3D size / PAGE_SIZE;
 	if (pages <=3D fp_old->pages)
 		return fp_old;
=20
-	delta =3D pages - fp_old->pages;
-	ret =3D __bpf_prog_charge(fp_old->aux->user, delta);
-	if (ret)
-		return NULL;
-
 	fp =3D __vmalloc(size, gfp_flags);
-	if (fp =3D=3D NULL) {
-		__bpf_prog_uncharge(fp_old->aux->user, delta);
-	} else {
+	if (fp) {
 		memcpy(fp, fp_old, fp_old->pages * PAGE_SIZE);
 		fp->pages =3D pages;
 		fp->aux->prog =3D fp;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 392e3b2f58e4..0996507ac1e8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -338,23 +338,6 @@ void bpf_map_init_from_attr(struct bpf_map *map, uni=
on bpf_attr *attr)
 	map->numa_node =3D bpf_map_attr_numa_node(attr);
 }
=20
-static int bpf_charge_memlock(struct user_struct *user, u32 pages)
-{
-	unsigned long memlock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
-	if (atomic_long_add_return(pages, &user->locked_vm) > memlock_limit) {
-		atomic_long_sub(pages, &user->locked_vm);
-		return -EPERM;
-	}
-	return 0;
-}
-
-static void bpf_uncharge_memlock(struct user_struct *user, u32 pages)
-{
-	if (user)
-		atomic_long_sub(pages, &user->locked_vm);
-}
-
 static int bpf_map_alloc_id(struct bpf_map *map)
 {
 	int id;
@@ -1588,51 +1571,6 @@ static void bpf_audit_prog(const struct bpf_prog *=
prog, unsigned int op)
 	audit_log_end(ab);
 }
=20
-int __bpf_prog_charge(struct user_struct *user, u32 pages)
-{
-	unsigned long memlock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	unsigned long user_bufs;
-
-	if (user) {
-		user_bufs =3D atomic_long_add_return(pages, &user->locked_vm);
-		if (user_bufs > memlock_limit) {
-			atomic_long_sub(pages, &user->locked_vm);
-			return -EPERM;
-		}
-	}
-
-	return 0;
-}
-
-void __bpf_prog_uncharge(struct user_struct *user, u32 pages)
-{
-	if (user)
-		atomic_long_sub(pages, &user->locked_vm);
-}
-
-static int bpf_prog_charge_memlock(struct bpf_prog *prog)
-{
-	struct user_struct *user =3D get_current_user();
-	int ret;
-
-	ret =3D __bpf_prog_charge(user, prog->pages);
-	if (ret) {
-		free_uid(user);
-		return ret;
-	}
-
-	prog->aux->user =3D user;
-	return 0;
-}
-
-static void bpf_prog_uncharge_memlock(struct bpf_prog *prog)
-{
-	struct user_struct *user =3D prog->aux->user;
-
-	__bpf_prog_uncharge(user, prog->pages);
-	free_uid(user);
-}
-
 static int bpf_prog_alloc_id(struct bpf_prog *prog)
 {
 	int id;
@@ -1682,7 +1620,7 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu=
)
=20
 	kvfree(aux->func_info);
 	kfree(aux->func_info_aux);
-	bpf_prog_uncharge_memlock(aux->prog);
+	free_uid(aux->user);
 	security_bpf_prog_free(aux);
 	bpf_prog_free(aux->prog);
 }
@@ -2115,7 +2053,7 @@ static int bpf_prog_load(union bpf_attr *attr, unio=
n bpf_attr __user *uattr)
 		tgt_prog =3D bpf_prog_get(attr->attach_prog_fd);
 		if (IS_ERR(tgt_prog)) {
 			err =3D PTR_ERR(tgt_prog);
-			goto free_prog_nouncharge;
+			goto free_prog;
 		}
 		prog->aux->linked_prog =3D tgt_prog;
 	}
@@ -2124,18 +2062,15 @@ static int bpf_prog_load(union bpf_attr *attr, un=
ion bpf_attr __user *uattr)
=20
 	err =3D security_bpf_prog_alloc(prog->aux);
 	if (err)
-		goto free_prog_nouncharge;
-
-	err =3D bpf_prog_charge_memlock(prog);
-	if (err)
-		goto free_prog_sec;
+		goto free_prog;
=20
+	prog->aux->user =3D get_current_user();
 	prog->len =3D attr->insn_cnt;
=20
 	err =3D -EFAULT;
 	if (copy_from_user(prog->insns, u64_to_user_ptr(attr->insns),
 			   bpf_prog_insn_size(prog)) !=3D 0)
-		goto free_prog;
+		goto free_prog_sec;
=20
 	prog->orig_prog =3D NULL;
 	prog->jited =3D 0;
@@ -2146,19 +2081,19 @@ static int bpf_prog_load(union bpf_attr *attr, un=
ion bpf_attr __user *uattr)
 	if (bpf_prog_is_dev_bound(prog->aux)) {
 		err =3D bpf_prog_offload_init(prog, attr);
 		if (err)
-			goto free_prog;
+			goto free_prog_sec;
 	}
=20
 	/* find program type: socket_filter vs tracing_filter */
 	err =3D find_prog_type(type, prog);
 	if (err < 0)
-		goto free_prog;
+		goto free_prog_sec;
=20
 	prog->aux->load_time =3D ktime_get_boottime_ns();
 	err =3D bpf_obj_name_cpy(prog->aux->name, attr->prog_name,
 			       sizeof(attr->prog_name));
 	if (err < 0)
-		goto free_prog;
+		goto free_prog_sec;
=20
 	/* run eBPF verifier */
 	err =3D bpf_check(&prog, attr, uattr);
@@ -2203,11 +2138,10 @@ static int bpf_prog_load(union bpf_attr *attr, un=
ion bpf_attr __user *uattr)
 	 */
 	__bpf_prog_put_noref(prog, prog->aux->func_cnt);
 	return err;
-free_prog:
-	bpf_prog_uncharge_memlock(prog);
 free_prog_sec:
+	free_uid(prog->aux->user);
 	security_bpf_prog_free(prog->aux);
-free_prog_nouncharge:
+free_prog:
 	bpf_prog_free(prog);
 	return err;
 }
--=20
2.26.2

