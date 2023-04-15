Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845FE6E3379
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 22:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjDOUSc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 16:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjDOUSb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 16:18:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4FA3AB3
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:29 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33FJwG9b020309
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=5WaBXznjyEcSLW13jADCHvpyIjYyEiWeASFmXxmqEa4=;
 b=pxi9yy88lKXsMoKk2WT4a626UFTnWXFvhsXvunAsQIxRCBYxxqZHif3gyOLksKssRKkf
 F4DXEZ/YyvspJCOp0guQdGCNhLpOMPAa5VlLT+YrhZnBItA+WDi6nrk5RYoa9NuIQkbF
 iR8D+KwuJdvBmtxEWhcqHxetJR2NiqMaQtg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3pyqeaa474-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:28 -0700
Received: from twshared8568.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 15 Apr 2023 13:18:26 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 11A0F1C270232; Sat, 15 Apr 2023 13:18:17 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 3/9] bpf: Support refcounted local kptrs in existing semantics
Date:   Sat, 15 Apr 2023 13:18:05 -0700
Message-ID: <20230415201811.343116-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415201811.343116-1-davemarchevsky@fb.com>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: U-5hJXaTTeoIsduDx5S3ryYLEW4P4bLC
X-Proofpoint-GUID: U-5hJXaTTeoIsduDx5S3ryYLEW4P4bLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_10,2023-04-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A local kptr is considered 'refcounted' when it is of a type that has a
bpf_refcount field. When such a kptr is created, its refcount should be
initialized to 1; when destroyed, the object should be free'd only if a
refcount decr results in 0 refcount.

Existing logic always frees the underlying memory when destroying a
local kptr, and 0-initializes all btf_record fields. This patch adds
checks for "is local kptr refcounted?" and new logic for that case in
the appropriate places.

This patch focuses on changing existing semantics and thus conspicuously
does _not_ provide a way for BPF programs in increment refcount. That
follows later in the series.

__bpf_obj_drop_impl is modified to do the right thing when it sees a
refcounted type. Container types for graph nodes (list, tree, stashed in
map) are migrated to use __bpf_obj_drop_impl as a destructor for their
nodes instead of each having custom destruction code in their _free
paths. Now that "drop" isn't a synonym for "free" when the type is
refcounted it makes sense to centralize this logic.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h  |  3 +++
 kernel/bpf/helpers.c | 21 +++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index be44d765b7a4..b065de2cfcea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -370,6 +370,9 @@ static inline void bpf_obj_init(const struct btf_reco=
rd *rec, void *obj)
 		return;
 	for (i =3D 0; i < rec->cnt; i++)
 		memset(obj + rec->fields[i].offset, 0, rec->fields[i].size);
+
+	if (rec->refcount_off >=3D 0)
+		refcount_set((refcount_t *)(obj + rec->refcount_off), 1);
 }
=20
 /* 'dst' must be a temporary buffer and should not point to memory that =
is being
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e989b6460147..e2dbd9644e5c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1798,6 +1798,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	}
 }
=20
+void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
+
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock)
 {
@@ -1828,13 +1830,8 @@ void bpf_list_head_free(const struct btf_field *fi=
eld, void *list_head,
 		/* The contained type can also have resources, including a
 		 * bpf_list_head which needs to be freed.
 		 */
-		bpf_obj_free_fields(field->graph_root.value_rec, obj);
-		/* bpf_mem_free requires migrate_disable(), since we can be
-		 * called from map free path as well apart from BPF program (as
-		 * part of map ops doing bpf_obj_free_fields).
-		 */
 		migrate_disable();
-		bpf_mem_free(&bpf_global_ma, obj);
+		__bpf_obj_drop_impl(obj, field->graph_root.value_rec);
 		migrate_enable();
 	}
 }
@@ -1871,10 +1868,9 @@ void bpf_rb_root_free(const struct btf_field *fiel=
d, void *rb_root,
 		obj =3D pos;
 		obj -=3D field->graph_root.node_offset;
=20
-		bpf_obj_free_fields(field->graph_root.value_rec, obj);
=20
 		migrate_disable();
-		bpf_mem_free(&bpf_global_ma, obj);
+		__bpf_obj_drop_impl(obj, field->graph_root.value_rec);
 		migrate_enable();
 	}
 }
@@ -1897,8 +1893,17 @@ __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_=
id__k, void *meta__ign)
 	return p;
 }
=20
+/* Must be called under migrate_disable(), as required by bpf_mem_free *=
/
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
 {
+	if (rec && rec->refcount_off >=3D 0 &&
+	    !refcount_dec_and_test((refcount_t *)(p + rec->refcount_off))) {
+		/* Object is refcounted and refcount_dec didn't result in 0
+		 * refcount. Return without freeing the object
+		 */
+		return;
+	}
+
 	if (rec)
 		bpf_obj_free_fields(rec, p);
 	bpf_mem_free(&bpf_global_ma, p);
--=20
2.34.1

