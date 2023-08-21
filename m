Return-Path: <bpf+bounces-8177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765087830F6
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 21:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A38280F1F
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 19:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD641171B;
	Mon, 21 Aug 2023 19:33:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6773F5684
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 19:33:59 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1609A125
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:57 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LIVLMJ032439
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mME3QSrlT7cRGDPM8LQ9Z8Qey5B3M8r35+ajndPBYpk=;
 b=F0xHOR2sGmav29szmOVEoZ5pAMoA0RAdCn6wDHOeF9fIPjBJB98/pB62S0PuCWtCjWPr
 Un3+E34G4btcLzotd0W4T2YfrSd9yVA9jjntvoItKhz/SJQOsUxhLR5imVmBjTQaoW3z
 wxla9BF5VifrYFPrSyoBjQOrcnt40CxdWIY= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sjs2uy9e2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:57 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 21 Aug 2023 12:33:25 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id AC41423024262; Mon, 21 Aug 2023 12:33:22 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <yonghong.song@linux.dev>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 7/7] selftests/bpf: Add tests for rbtree API interaction in sleepable progs
Date: Mon, 21 Aug 2023 12:33:11 -0700
Message-ID: <20230821193311.3290257-8-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821193311.3290257-1-davemarchevsky@fb.com>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: z0yKZOH3V8DUEzc28sHZcEqDVhmv-PLt
X-Proofpoint-GUID: z0yKZOH3V8DUEzc28sHZcEqDVhmv-PLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_08,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Confirm that the following sleepable prog states fail verification:
  * bpf_rcu_read_unlock before bpf_spin_unlock
     * RCU CS will last at least as long as spin_lock CS

Also confirm that correct usage passes verification, specifically:
  * Explicit use of bpf_rcu_read_{lock, unlock} in sleepable test prog
  * Implied RCU CS due to spin_lock CS

None of the selftest progs actually attach to bpf_testmod's
bpf_testmod_test_read.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/progs/refcounted_kptr.c     | 71 +++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 28 ++++++++
 2 files changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/=
testing/selftests/bpf/progs/refcounted_kptr.c
index c55652fdc63a..893a4fdb4b6e 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -8,6 +8,9 @@
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
=20
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+
 struct node_data {
 	long key;
 	long list_data;
@@ -497,4 +500,72 @@ long rbtree_wrong_owner_remove_fail_a2(void *ctx)
 	return 0;
 }
=20
+SEC("?fentry.s/bpf_testmod_test_read")
+__success
+int BPF_PROG(rbtree_sleepable_rcu,
+	     struct file *file, struct kobject *kobj,
+	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
+{
+	struct bpf_rb_node *rb;
+	struct node_data *n, *m =3D NULL;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 0;
+
+	bpf_rcu_read_lock();
+	bpf_spin_lock(&lock);
+	bpf_rbtree_add(&root, &n->r, less);
+	rb =3D bpf_rbtree_first(&root);
+	if (!rb)
+		goto err_out;
+
+	rb =3D bpf_rbtree_remove(&root, rb);
+	if (!rb)
+		goto err_out;
+
+	m =3D container_of(rb, struct node_data, r);
+
+err_out:
+	bpf_spin_unlock(&lock);
+	bpf_rcu_read_unlock();
+	if (m)
+		bpf_obj_drop(m);
+	return 0;
+}
+
+SEC("?fentry.s/bpf_testmod_test_read")
+__success
+int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_lock,
+	     struct file *file, struct kobject *kobj,
+	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
+{
+	struct bpf_rb_node *rb;
+	struct node_data *n, *m =3D NULL;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 0;
+
+	/* No explicit bpf_rcu_read_lock */
+	bpf_spin_lock(&lock);
+	bpf_rbtree_add(&root, &n->r, less);
+	rb =3D bpf_rbtree_first(&root);
+	if (!rb)
+		goto err_out;
+
+	rb =3D bpf_rbtree_remove(&root, rb);
+	if (!rb)
+		goto err_out;
+
+	m =3D container_of(rb, struct node_data, r);
+
+err_out:
+	bpf_spin_unlock(&lock);
+	/* No explicit bpf_rcu_read_unlock */
+	if (m)
+		bpf_obj_drop(m);
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/t=
ools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 0b09e5c915b1..1ef07f6ee580 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -13,6 +13,9 @@ struct node_acquire {
 	struct bpf_refcount refcount;
 };
=20
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+
 #define private(name) SEC(".data." #name) __hidden __attribute__((aligne=
d(8)))
 private(A) struct bpf_spin_lock glock;
 private(A) struct bpf_rb_root groot __contains(node_acquire, node);
@@ -71,4 +74,29 @@ long rbtree_refcounted_node_ref_escapes_owning_input(v=
oid *ctx)
 	return 0;
 }
=20
+SEC("?fentry.s/bpf_testmod_test_read")
+__failure __msg("function calls are not allowed while holding a lock")
+int BPF_PROG(rbtree_fail_sleepable_lock_across_rcu,
+	     struct file *file, struct kobject *kobj,
+	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
+{
+	struct node_acquire *n;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 0;
+
+	/* spin_{lock,unlock} are in different RCU CS */
+	bpf_rcu_read_lock();
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+	bpf_rcu_read_unlock();
+
+	bpf_rcu_read_lock();
+	bpf_spin_unlock(&glock);
+	bpf_rcu_read_unlock();
+
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


