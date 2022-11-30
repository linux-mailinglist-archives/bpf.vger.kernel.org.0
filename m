Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D02463CEAA
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 06:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiK3FWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 00:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiK3FVz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 00:21:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDF66A775
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 21:21:53 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AU1DFDX030455
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 21:21:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=F706FCPPbXAqL7k/3QMMJhPU9owrkeGf7q6NHOE7Exw=;
 b=S4grmzmaUJIEkdSKSVGaBlRdxy7IGJjKsL9Zocf3n5ZqqCNw9WJTttjXWiTRUtIfZBwJ
 OPuweHU++BgeN2HgoWdW6p23IJQvkRTJCpkZExoDri+jspEbbTjjQ0oRCDPCryiE3G37
 r6mT9ZElZLtbmsVKH+wlj4Pri1rTUGRAhbM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3m5wahhe6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 21:21:52 -0800
Received: from twshared2003.08.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 21:21:51 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 7DE8212F3633A; Tue, 29 Nov 2022 21:21:47 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Fix a compilation failure with clang lto build
Date:   Tue, 29 Nov 2022 21:21:47 -0800
Message-ID: <20221130052147.1591625-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wfDRm7ZGaEZ8N1FuaAFqIcfyaZgy503U
X-Proofpoint-ORIG-GUID: wfDRm7ZGaEZ8N1FuaAFqIcfyaZgy503U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-29_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When building the kernel with clang lto (CONFIG_LTO_CLANG_FULL=3Dy), the
following compilation error will appear:

  $ make LLVM=3D1 LLVM_IAS=3D1 -j
  ...
  ld.lld: error: ld-temp.o <inline asm>:26889:1: symbol 'cgroup_storage_m=
ap_btf_ids' is already defined
  cgroup_storage_map_btf_ids:;
  ^
  make[1]: *** [/.../bpf-next/scripts/Makefile.vmlinux_o:61: vmlinux.o] E=
rror 1

In local_storage.c, we have
  BTF_ID_LIST_SINGLE(cgroup_storage_map_btf_ids, struct, bpf_local_storag=
e_map)
Commit c4bcfb38a95e ("bpf: Implement cgroup storage available to
non-cgroup-attached bpf progs") added the above identical BTF_ID_LIST_SIN=
GLE
definition in bpf_cgrp_storage.c. With duplicated definitions, llvm linke=
r
complains with lto build.

Also, extracting btf_id of 'struct bpf_local_storage_map' is defined four=
 times
for sk, inode, task and cgrp local storages. Let us define a single globa=
l one
with a different name than cgroup_storage_map_btf_ids, which also fixed
the lto compilation error.

Fixes: c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgro=
up-attached bpf progs")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/btf_ids.h        | 1 +
 kernel/bpf/bpf_cgrp_storage.c  | 3 +--
 kernel/bpf/bpf_inode_storage.c | 4 +---
 kernel/bpf/bpf_task_storage.c  | 4 ++--
 net/core/bpf_sk_storage.c      | 3 +--
 5 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 93397711a68c..3a4f7cd882ca 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -266,5 +266,6 @@ MAX_BTF_TRACING_TYPE,
=20
 extern u32 btf_tracing_ids[];
 extern u32 bpf_cgroup_btf_id[];
+extern u32 bpf_local_storage_map_btf_id[];
=20
 #endif
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.=
c
index 309403800f82..6cdf6d9ed91d 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -211,7 +211,6 @@ BPF_CALL_2(bpf_cgrp_storage_delete, struct bpf_map *,=
 map, struct cgroup *, cgro
 	return ret;
 }
=20
-BTF_ID_LIST_SINGLE(cgroup_storage_map_btf_ids, struct, bpf_local_storage=
_map)
 const struct bpf_map_ops cgrp_storage_map_ops =3D {
 	.map_meta_equal =3D bpf_map_meta_equal,
 	.map_alloc_check =3D bpf_local_storage_map_alloc_check,
@@ -222,7 +221,7 @@ const struct bpf_map_ops cgrp_storage_map_ops =3D {
 	.map_update_elem =3D bpf_cgrp_storage_update_elem,
 	.map_delete_elem =3D bpf_cgrp_storage_delete_elem,
 	.map_check_btf =3D bpf_local_storage_map_check_btf,
-	.map_btf_id =3D &cgroup_storage_map_btf_ids[0],
+	.map_btf_id =3D &bpf_local_storage_map_btf_id[0],
 	.map_owner_storage_ptr =3D cgroup_storage_ptr,
 };
=20
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storag=
e.c
index 6a1d4d22816a..05f4c66c9089 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -213,8 +213,6 @@ static void inode_storage_map_free(struct bpf_map *ma=
p)
 	bpf_local_storage_map_free(map, &inode_cache, NULL);
 }
=20
-BTF_ID_LIST_SINGLE(inode_storage_map_btf_ids, struct,
-		   bpf_local_storage_map)
 const struct bpf_map_ops inode_storage_map_ops =3D {
 	.map_meta_equal =3D bpf_map_meta_equal,
 	.map_alloc_check =3D bpf_local_storage_map_alloc_check,
@@ -225,7 +223,7 @@ const struct bpf_map_ops inode_storage_map_ops =3D {
 	.map_update_elem =3D bpf_fd_inode_storage_update_elem,
 	.map_delete_elem =3D bpf_fd_inode_storage_delete_elem,
 	.map_check_btf =3D bpf_local_storage_map_check_btf,
-	.map_btf_id =3D &inode_storage_map_btf_ids[0],
+	.map_btf_id =3D &bpf_local_storage_map_btf_id[0],
 	.map_owner_storage_ptr =3D inode_storage_ptr,
 };
=20
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
index 8e832db8151a..1e486055a523 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -324,7 +324,7 @@ static void task_storage_map_free(struct bpf_map *map=
)
 	bpf_local_storage_map_free(map, &task_cache, &bpf_task_storage_busy);
 }
=20
-BTF_ID_LIST_SINGLE(task_storage_map_btf_ids, struct, bpf_local_storage_m=
ap)
+BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_loca=
l_storage_map)
 const struct bpf_map_ops task_storage_map_ops =3D {
 	.map_meta_equal =3D bpf_map_meta_equal,
 	.map_alloc_check =3D bpf_local_storage_map_alloc_check,
@@ -335,7 +335,7 @@ const struct bpf_map_ops task_storage_map_ops =3D {
 	.map_update_elem =3D bpf_pid_task_storage_update_elem,
 	.map_delete_elem =3D bpf_pid_task_storage_delete_elem,
 	.map_check_btf =3D bpf_local_storage_map_check_btf,
-	.map_btf_id =3D &task_storage_map_btf_ids[0],
+	.map_btf_id =3D &bpf_local_storage_map_btf_id[0],
 	.map_owner_storage_ptr =3D task_storage_ptr,
 };
=20
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 9d2288c0736e..bb378c33f542 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -310,7 +310,6 @@ bpf_sk_storage_ptr(void *owner)
 	return &sk->sk_bpf_storage;
 }
=20
-BTF_ID_LIST_SINGLE(sk_storage_map_btf_ids, struct, bpf_local_storage_map=
)
 const struct bpf_map_ops sk_storage_map_ops =3D {
 	.map_meta_equal =3D bpf_map_meta_equal,
 	.map_alloc_check =3D bpf_local_storage_map_alloc_check,
@@ -321,7 +320,7 @@ const struct bpf_map_ops sk_storage_map_ops =3D {
 	.map_update_elem =3D bpf_fd_sk_storage_update_elem,
 	.map_delete_elem =3D bpf_fd_sk_storage_delete_elem,
 	.map_check_btf =3D bpf_local_storage_map_check_btf,
-	.map_btf_id =3D &sk_storage_map_btf_ids[0],
+	.map_btf_id =3D &bpf_local_storage_map_btf_id[0],
 	.map_local_storage_charge =3D bpf_sk_storage_charge,
 	.map_local_storage_uncharge =3D bpf_sk_storage_uncharge,
 	.map_owner_storage_ptr =3D bpf_sk_storage_ptr,
--=20
2.30.2

