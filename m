Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD041641879
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 19:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLCSqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 13:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiLCSqR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 13:46:17 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB9417E3A
        for <bpf@vger.kernel.org>; Sat,  3 Dec 2022 10:46:11 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B39mdkd009421
        for <bpf@vger.kernel.org>; Sat, 3 Dec 2022 10:46:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8Gj46RiFpBzfgqLtbEDiPpyRXq7Ny4snNxFZKZ4N8z8=;
 b=Slu/cRzmk5Gi1qrelWViLOHauZsN4mrsLEL9rUdY+5xdjwpYsCS+57ahakmJ8qVwzoLR
 nHoqD7TmbdYHcQHzZt+8BKozeNGdMqngK/ufjzFWLua+hOQjgnqpy7SHiP/l7RDRgZOi
 RDhjBPF1JFGLjQl/WEr9xZgWEDmccNU9e7E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m83cs2pvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 03 Dec 2022 10:46:11 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub104.TheFacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 10:46:11 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 10:46:10 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id C86251320E704; Sat,  3 Dec 2022 10:46:07 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        "Martin KaFai Lau" <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Fix rcu_read_lock test with new MEM_RCU semantics
Date:   Sat, 3 Dec 2022 10:46:07 -0800
Message-ID: <20221203184607.478314-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221203184557.476871-1-yhs@fb.com>
References: <20221203184557.476871-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aTuGwf0aEFZLvJzn1ERbZYBw3PwhE079
X-Proofpoint-ORIG-GUID: aTuGwf0aEFZLvJzn1ERbZYBw3PwhE079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-03_10,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add MEM_RCU pointer null checking for related tests. Also
modified task_acquire test so it takes a rcu ptr 'ptr' where
'ptr =3D rcu_ptr->rcu_field'.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/progs/rcu_read_lock.c       | 55 +++++++++++++++----
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
index 94a970076b98..cf06a34fcb02 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -23,13 +23,14 @@ struct bpf_key *bpf_lookup_user_key(__u32 serial, __u=
64 flags) __ksym;
 void bpf_key_put(struct bpf_key *key) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
-struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p) __k=
sym;
 void bpf_task_release(struct task_struct *p) __ksym;
=20
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 int get_cgroup_id(void *ctx)
 {
 	struct task_struct *task;
+	struct css_set *cgroups;
=20
 	task =3D bpf_get_current_task_btf();
 	if (task->pid !=3D target_pid)
@@ -37,7 +38,11 @@ int get_cgroup_id(void *ctx)
=20
 	/* simulate bpf_get_current_cgroup_id() helper */
 	bpf_rcu_read_lock();
-	cgroup_id =3D task->cgroups->dfl_cgrp->kn->id;
+	cgroups =3D task->cgroups;
+	if (!cgroups)
+		goto unlock;
+	cgroup_id =3D cgroups->dfl_cgrp->kn->id;
+unlock:
 	bpf_rcu_read_unlock();
 	return 0;
 }
@@ -56,6 +61,8 @@ int task_succ(void *ctx)
 	bpf_rcu_read_lock();
 	/* region including helper using rcu ptr real_parent */
 	real_parent =3D task->real_parent;
+	if (!real_parent)
+		goto out;
 	ptr =3D bpf_task_storage_get(&map_a, real_parent, &init_val,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!ptr)
@@ -92,7 +99,10 @@ int two_regions(void *ctx)
 	bpf_rcu_read_unlock();
 	bpf_rcu_read_lock();
 	real_parent =3D task->real_parent;
+	if (!real_parent)
+		goto out;
 	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
+out:
 	bpf_rcu_read_unlock();
 	return 0;
 }
@@ -105,7 +115,10 @@ int non_sleepable_1(void *ctx)
 	task =3D bpf_get_current_task_btf();
 	bpf_rcu_read_lock();
 	real_parent =3D task->real_parent;
+	if (!real_parent)
+		goto out;
 	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
+out:
 	bpf_rcu_read_unlock();
 	return 0;
 }
@@ -121,7 +134,10 @@ int non_sleepable_2(void *ctx)
=20
 	bpf_rcu_read_lock();
 	real_parent =3D task->real_parent;
+	if (!real_parent)
+		goto out;
 	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
+out:
 	bpf_rcu_read_unlock();
 	return 0;
 }
@@ -129,16 +145,28 @@ int non_sleepable_2(void *ctx)
 SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
 int task_acquire(void *ctx)
 {
-	struct task_struct *task, *real_parent;
+	struct task_struct *task, *real_parent, *gparent;
=20
 	task =3D bpf_get_current_task_btf();
 	bpf_rcu_read_lock();
 	real_parent =3D task->real_parent;
+	if (!real_parent)
+		goto out;
+
+	/* rcu_ptr->rcu_field */
+	gparent =3D real_parent->real_parent;
+	if (!gparent)
+		goto out;
+
 	/* acquire a reference which can be used outside rcu read lock region *=
/
-	real_parent =3D bpf_task_acquire(real_parent);
+	gparent =3D bpf_task_acquire_not_zero(gparent);
+	if (!gparent)
+		goto out;
+
+	(void)bpf_task_storage_get(&map_a, gparent, 0, 0);
+	bpf_task_release(gparent);
+out:
 	bpf_rcu_read_unlock();
-	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
-	bpf_task_release(real_parent);
 	return 0;
 }
=20
@@ -181,9 +209,12 @@ int non_sleepable_rcu_mismatch(void *ctx)
 	/* non-sleepable: missing bpf_rcu_read_unlock() in one path */
 	bpf_rcu_read_lock();
 	real_parent =3D task->real_parent;
+	if (!real_parent)
+		goto out;
 	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
 	if (real_parent)
 		bpf_rcu_read_unlock();
+out:
 	return 0;
 }
=20
@@ -199,16 +230,17 @@ int inproper_sleepable_helper(void *ctx)
 	/* sleepable helper in rcu read lock region */
 	bpf_rcu_read_lock();
 	real_parent =3D task->real_parent;
+	if (!real_parent)
+		goto out;
 	regs =3D (struct pt_regs *)bpf_task_pt_regs(real_parent);
-	if (!regs) {
-		bpf_rcu_read_unlock();
-		return 0;
-	}
+	if (!regs)
+		goto out;
=20
 	ptr =3D (void *)PT_REGS_IP(regs);
 	(void)bpf_copy_from_user_task(&value, sizeof(uint32_t), ptr, task, 0);
 	user_data =3D value;
 	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
+out:
 	bpf_rcu_read_unlock();
 	return 0;
 }
@@ -239,7 +271,10 @@ int nested_rcu_region(void *ctx)
 	bpf_rcu_read_lock();
 	bpf_rcu_read_lock();
 	real_parent =3D task->real_parent;
+	if (!real_parent)
+		goto out;
 	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
+out:
 	bpf_rcu_read_unlock();
 	bpf_rcu_read_unlock();
 	return 0;
--=20
2.30.2

