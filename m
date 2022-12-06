Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70AA644F60
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLFXKd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLFXKa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:10:30 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF4429B5
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:10:29 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LhOjh000527
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:10:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cKaWZ4JoDPjHkfjAHfVl7L33sgS19nwfFkO0BOGDSyY=;
 b=hN8hDfPVo3mWbDyEecOyggyVtYYxAh6AmqJ5nd0aHDvaaUyCxUe2oLFwmCPcsMfWE8BP
 yFvu9GJfOG6sfdGY0OYprHKxVkrbgZVGMZvYkOg5+XuzG7BAthnO0VsL5aoDRUovEYuS
 hlUw5oxw6HY5c/Aa31lYwBHNDKpD4+QOM6Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m9x70xv50-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:10:29 -0800
Received: from twshared8047.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 15:10:26 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 38784120B3798; Tue,  6 Dec 2022 15:10:08 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 12/13] libbpf: Make BTF mandatory if program BTF has spin_lock or alloc_obj type
Date:   Tue, 6 Dec 2022 15:09:59 -0800
Message-ID: <20221206231000.3180914-13-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206231000.3180914-1-davemarchevsky@fb.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ftqs6UxD-FlDD7k9MuTAPhJkb1PcMvhv
X-Proofpoint-GUID: ftqs6UxD-FlDD7k9MuTAPhJkb1PcMvhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If a BPF program defines a struct or union type which has a field type
that the verifier considers special - spin_lock, next-gen datastructure
heads and nodes - the verifier needs to be able to find fields of that
type using BTF.

For such a program, BTF is required, so modify kernel_needs_btf helper
to ensure that correct "BTF is mandatory" error message is emitted.

The newly-added btf_has_alloc_obj_type looks for BTF_KIND_STRUCTs with a
name corresponding to a special type. If any such struct is found it is
assumed that some variable is using it, and therefore that successful
BTF load is necessary.

Also add a kernel_needs_btf check to bpf_object__create_map where it was
previously missing. When this function calls bpf_map_create, kernel may
reject map creation due to mismatched datastructure owner and ownee
types (e.g. a struct bpf_list_head with __contains tag pointing to
bpf_rbtree_node field). In such a scenario - or any other where BTF is
necessary for verification - bpf_map_create should not be retried
without BTF.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/lib/bpf/libbpf.c | 50 ++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2a82f49ce16f..56a905b502c9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -998,6 +998,31 @@ find_struct_ops_kern_types(const struct btf *btf, co=
nst char *tname,
 	return 0;
 }
=20
+/* Should match alloc_obj_fields in kernel/bpf/btf.c
+ */
+static const char *alloc_obj_fields[] =3D {
+	"bpf_spin_lock",
+	"bpf_list_head",
+	"bpf_list_node",
+	"bpf_rb_root",
+	"bpf_rb_node",
+};
+
+static bool
+btf_has_alloc_obj_type(const struct btf *btf)
+{
+	const char *tname;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(alloc_obj_fields); i++) {
+		tname =3D alloc_obj_fields[i];
+		if (btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT) > 0)
+			return true;
+	}
+
+	return false;
+}
+
 static bool bpf_map__is_struct_ops(const struct bpf_map *map)
 {
 	return map->def.type =3D=3D BPF_MAP_TYPE_STRUCT_OPS;
@@ -2794,7 +2819,8 @@ static bool libbpf_needs_btf(const struct bpf_objec=
t *obj)
=20
 static bool kernel_needs_btf(const struct bpf_object *obj)
 {
-	return obj->efile.st_ops_shndx >=3D 0;
+	return obj->efile.st_ops_shndx >=3D 0 ||
+		(obj->btf && btf_has_alloc_obj_type(obj->btf));
 }
=20
 static int bpf_object__init_btf(struct bpf_object *obj,
@@ -5103,16 +5129,18 @@ static int bpf_object__create_map(struct bpf_obje=
ct *obj, struct bpf_map *map, b
=20
 		err =3D -errno;
 		cp =3D libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-		pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BT=
F.\n",
-			map->name, cp, err);
-		create_attr.btf_fd =3D 0;
-		create_attr.btf_key_type_id =3D 0;
-		create_attr.btf_value_type_id =3D 0;
-		map->btf_key_type_id =3D 0;
-		map->btf_value_type_id =3D 0;
-		map->fd =3D bpf_map_create(def->type, map_name,
-					 def->key_size, def->value_size,
-					 def->max_entries, &create_attr);
+		pr_warn("Error in bpf_create_map_xattr(%s):%s(%d).\n", map->name, cp, =
err);
+		if (!kernel_needs_btf(obj)) {
+			pr_warn("Retrying bpf_map_create_xattr(%s) without BTF.\n", map->name=
);
+			create_attr.btf_fd =3D 0;
+			create_attr.btf_key_type_id =3D 0;
+			create_attr.btf_value_type_id =3D 0;
+			map->btf_key_type_id =3D 0;
+			map->btf_value_type_id =3D 0;
+			map->fd =3D bpf_map_create(def->type, map_name,
+						 def->key_size, def->value_size,
+						 def->max_entries, &create_attr);
+		}
 	}
=20
 	err =3D map->fd < 0 ? -errno : 0;
--=20
2.30.2

