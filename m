Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE06DCB48
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 21:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjDJTIz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 15:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJTIy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 15:08:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A8C170B
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:51 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33AFLjY2031307
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rWLXjnov+xlVFu8wWeEHKvIEhKOhtM5HdM845nyXZKc=;
 b=QHiqmjE2O9mWcterkbOE/kJFBTLYS9Ji54pAHFo9dreTHVP81Nlkk2MffXTNbLWnhSRw
 C7DhJyG1bzOuGusyCYIlpuia4+fTUGlF5ni+5oVsy+Uonp6ydhsHGsv3LCITn21Ec+yB
 K8Hpe7BW+wycDn8qJtUrGTqXKgOpRvPm12Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3pvn1b1gna-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:50 -0700
Received: from twshared7147.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 12:08:48 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id BCDDA1BB3FCDF; Mon, 10 Apr 2023 12:08:41 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 3/9] bpf: Support refcounted local kptrs in existing semantics
Date:   Mon, 10 Apr 2023 12:07:47 -0700
Message-ID: <20230410190753.2012798-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410190753.2012798-1-davemarchevsky@fb.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jk8uwseUZSdpa1juaPPgfoAOXBlyNG-Q
X-Proofpoint-GUID: jk8uwseUZSdpa1juaPPgfoAOXBlyNG-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_14,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
index afb82e623663..4fc29f9aeaac 100644
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
index b37a44c9e5dc..67acbb9c4b3d 100644
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

