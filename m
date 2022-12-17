Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852C064F83E
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiLQIZy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiLQIZr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:25:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AFB38B5
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:45 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BH8JXIx029430
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=KB57jh03uJxm3bHlAFbifzEMwT5zMcWsl4Qlg6QYGQk=;
 b=N1tcf2LXZlE3cJDUJXiR2HA+gPEtRQvkPpvk19++FfSS+UktdVAq+QCW7F3Cw8E7e7lV
 VYcQ6gp9iAhjQXWle6Stv0h0mHR7UxgOgWUSAATO8yqAvCOjccNyY+7WzG27LpnsqJ8N
 bbp06/AJZ8cj5CqJKHlPSMfPgek0xSEaziE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mha5br0pv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:44 -0800
Received: from twshared8047.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 00:25:42 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 7AC1712A9E02E; Sat, 17 Dec 2022 00:25:21 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 11/13] libbpf: Make BTF mandatory if program BTF has spin_lock or alloc_obj type
Date:   Sat, 17 Dec 2022 00:25:04 -0800
Message-ID: <20221217082506.1570898-12-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221217082506.1570898-1-davemarchevsky@fb.com>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -KLJF9VhMggav3sKnNWBczMk0fv55msP
X-Proofpoint-ORIG-GUID: -KLJF9VhMggav3sKnNWBczMk0fv55msP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_03,2022-12-15_02,2022-06-22_01
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
that the verifier considers special - spin_lock, graph datastructure
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
reject map creation due to mismatched graph owner and ownee
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

