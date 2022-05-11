Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025B7523FDC
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 00:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiEKWC6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 18:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiEKWC5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 18:02:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D773B7
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 15:02:56 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24BJg6ZX009576
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 15:02:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wG+TyC5sQQzFrOs2Hg2vznQCUWMiDbTiNRH/a5wVJDM=;
 b=PWU6vbILFORfTkR5Zzic7RGnC6T6NHjggJz6jdF3fMlN3h7ZOJAcCcYgrgj5hLqbmzDH
 aNQil8IiRC6T0Y/Kp2BZbynjTYn5WBQJ1G0uodmIqezQr2NTKFCw5+1e4jQXTPh6VzrS
 lMiw0u2YSTAQ5+Z7DkQw6Y4xE7uKUZruIuE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fyx1h91jq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 15:02:55 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 15:02:53 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 0DA40A2C7786; Wed, 11 May 2022 15:02:49 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves 2/2] btf_encoder: Normalize array index type for parallel dwarf loading case
Date:   Wed, 11 May 2022 15:02:49 -0700
Message-ID: <20220511220249.525908-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511220243.525215-1-yhs@fb.com>
References: <20220511220243.525215-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0GytbrvbTT9uNqaJcEYsAoIPAJh96Aor
X-Proofpoint-ORIG-GUID: 0GytbrvbTT9uNqaJcEYsAoIPAJh96Aor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With latest llvm15 built kernel (make -j LLVM=3D1), I hit the following
error when build selftests (make -C tools/testing/selftests/bpf -j LLVM=3D=
1):
  In file included from skeleton/pid_iter.bpf.c:3:
  .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown=
 type name
       '__builtin_va_list___2'; did you mean '__builtin_va_list'?
  typedef __builtin_va_list___2 va_list___2;
          ^~~~~~~~~~~~~~~~~~~~~
          __builtin_va_list
  note: '__builtin_va_list' declared here
  In file included from skeleton/profiler.bpf.c:3:
  .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown=
 type name
       '__builtin_va_list__ _2'; did you mean '__builtin_va_list'?
  typedef __builtin_va_list___2 va_list___2;
          ^~~~~~~~~~~~~~~~~~~~~
          __builtin_va_list
  note: '__builtin_va_list' declared here

The error can be easily explained with after-dedup vmlinux btf:
  [21] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
  [2300] STRUCT '__va_list_tag' size=3D24 vlen=3D4
        'gp_offset' type_id=3D2 bits_offset=3D0
        'fp_offset' type_id=3D2 bits_offset=3D32
        'overflow_arg_area' type_id=3D32 bits_offset=3D64
        'reg_save_area' type_id=3D32 bits_offset=3D128
  [2308] TYPEDEF 'va_list' type_id=3D2309
  [2309] TYPEDEF '__builtin_va_list' type_id=3D2310
  [2310] ARRAY '(anon)' type_id=3D2300 index_type_id=3D21 nr_elems=3D1

  [5289] PTR '(anon)' type_id=3D2308
  [158520] STRUCT 'warn_args' size=3D32 vlen=3D2
        'fmt' type_id=3D14 bits_offset=3D0
        'args' type_id=3D2308 bits_offset=3D64
  [27299] INT '__ARRAY_SIZE_TYPE__' size=3D4 bits_offset=3D0 nr_bits=3D32=
 encoding=3D(none)
  [34590] TYPEDEF '__builtin_va_list' type_id=3D34591
  [34591] ARRAY '(anon)' type_id=3D2300 index_type_id=3D27299 nr_elems=3D=
1

The typedef __builtin_va_list is a builtin type for the compiler.
In the above case, two typedef __builtin_va_list are generated.
The reason is due to different array index_type_id. This happened
when pahole is running with more than one jobs when parsing dwarf
and generating btfs.

Function btf_encoder__encode_cu() is used to do btf encoding for
each cu. The function will try to find an "int" type for the cu
if it is available, otherwise, it will create a special type
with name __ARRAY_SIZE_TYPE__. For example,
  file1: yes 'int' type
  file2: no 'int' type

In serial mode, file1 is processed first, followed by file2.
both will have 'int' type as the array index type since file2
will inherit the index type from file1.

In parallel mode though, arrays in file1 will have index type 'int',
and arrays in file2 wil have index type '__ARRAY_SIZE_TYPE__'.
This will prevent some legitimate dedup and may have generated
vmlinux.h having compilation error.

This patch fixed the issue by normalizing all array_index types
to be the first array_index type in the whole btf.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 btf_encoder.c | 24 +++++++++++++++++++++---
 btf_encoder.h |  2 +-
 pahole.c      |  2 +-
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 1a42094..6164a3d 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1056,17 +1056,35 @@ out:
 	return err;
 }
=20
-int btf_encoder__encode(struct btf_encoder *encoder)
+int btf_encoder__encode(struct btf_encoder *encoder, bool normalize_arra=
y_index_tid)
 {
-	int err;
+	int i, err, nr_types, index_type_id =3D 0;
=20
 	if (gobuffer__size(&encoder->percpu_secinfo) !=3D 0)
 		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
=20
 	/* Empty file, nothing to do, so... done! */
-	if (btf__type_cnt(encoder->btf) =3D=3D 1)
+	nr_types =3D btf__type_cnt(encoder->btf);
+	if (nr_types =3D=3D 1)
 		return 0;
=20
+	if (normalize_array_index_tid) {
+		for (i =3D 1; i < nr_types; i++) {
+			/* remove the 'const' qualifier so the index_type can be changed. */
+			struct btf_type *t =3D (struct btf_type *)btf__type_by_id(encoder->bt=
f, i);
+			struct btf_array *arr_info;
+
+			if (!btf_is_array(t))
+				continue;
+
+			arr_info =3D btf_array(t);
+			if (index_type_id =3D=3D 0)
+				index_type_id =3D arr_info->index_type;
+			else
+				arr_info->index_type =3D index_type_id;
+		}
+	}
+
 	if (btf__dedup(encoder->btf, NULL)) {
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
diff --git a/btf_encoder.h b/btf_encoder.h
index 339fae2..9a4c79e 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -19,7 +19,7 @@ struct list_head;
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached=
_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, boo=
l gen_floats, bool verbose);
 void btf_encoder__delete(struct btf_encoder *encoder);
=20
-int btf_encoder__encode(struct btf_encoder *encoder);
+int btf_encoder__encode(struct btf_encoder *encoder, bool normalize_arra=
y_index_tid);
=20
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu);
=20
diff --git a/pahole.c b/pahole.c
index 78caa08..2c3b2ac 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3530,7 +3530,7 @@ try_sole_arg_as_class_names:
 	header =3D NULL;
=20
 	if (btf_encode && btf_encoder) { // maybe all CUs were filtered out and=
 thus we don't have an encoder?
-		err =3D btf_encoder__encode(btf_encoder);
+		err =3D btf_encoder__encode(btf_encoder, conf_load.nr_jobs > 1);
 		if (err) {
 			fputs("Failed to encode BTF\n", stderr);
 			goto out_cus_delete;
--=20
2.30.2

