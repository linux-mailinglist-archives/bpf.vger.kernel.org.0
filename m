Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9011B2FBB7B
	for <lists+bpf@lfdr.de>; Tue, 19 Jan 2021 16:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391111AbhASPnE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jan 2021 10:43:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9670 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389991AbhASPgJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Jan 2021 10:36:09 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10JFWx6i010109
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 07:35:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=uVPBmzR+FnTbFvxqeQzOTybg2DWGiKxlEDuUr8uELO0=;
 b=EAe+9pLJTGGq95+it8IWGOT9/dSGHvSilOJbTbGICcXVXC5nb4oVnF5qxmojsDf2Kp0M
 bIjFwawTmxpVpk8xCy02xUTqV2/txEm38Bk9Ut3cjQqMEMKmWbONWadMOECn3Jk/K4cz
 QejosmBLmGZ1QtRoA7/Rm73LLc9+zX0Zz+Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 364h3bhnbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 07:35:22 -0800
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 19 Jan 2021 07:35:20 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 0D74C37014B4; Tue, 19 Jan 2021 07:35:19 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] bpf: permit size-0 datasec
Date:   Tue, 19 Jan 2021 07:35:18 -0800
Message-ID: <20210119153519.3901963-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-19_05:2021-01-18,2021-01-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

llvm patch https://reviews.llvm.org/D84002 permitted
to emit empty rodata datasec if the elf .rodata section
contains read-only data from local variables. These
local variables will be not emitted as BTF_KIND_VARs
since llvm converted these local variables as
static variables with private linkage without debuginfo
types. Such an empty rodata datasec will make
skeleton code generation easy since for skeleton
a rodata struct will be generated if there is a
.rodata elf section. The existence of a rodata
btf datasec is also consistent with the existence
of a rodata map created by libbpf.

The btf with such an empty rodata datasec will fail
in the kernel though as kernel will reject a datasec
with zero vlen and zero size. For example, for the below code,
    int sys_enter(void *ctx)
    {
       int fmt[6] =3D {1, 2, 3, 4, 5, 6};
       int dst[6];

       bpf_probe_read(dst, sizeof(dst), fmt);
       return 0;
    }
We got the below btf (bpftool btf dump ./test.o):
    [1] PTR '(anon)' type_id=3D0
    [2] FUNC_PROTO '(anon)' ret_type_id=3D3 vlen=3D1
            'ctx' type_id=3D1
    [3] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
    [4] FUNC 'sys_enter' type_id=3D2 linkage=3Dglobal
    [5] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSIGNED
    [6] ARRAY '(anon)' type_id=3D5 index_type_id=3D7 nr_elems=3D4
    [7] INT '__ARRAY_SIZE_TYPE__' size=3D4 bits_offset=3D0 nr_bits=3D32 enc=
oding=3D(none)
    [8] VAR '_license' type_id=3D6, linkage=3Dglobal-alloc
    [9] DATASEC '.rodata' size=3D0 vlen=3D0
    [10] DATASEC 'license' size=3D0 vlen=3D1
            type_id=3D8 offset=3D0 size=3D4
When loading the ./test.o to the kernel with bpftool,
we see the following error:
    libbpf: Error loading BTF: Invalid argument(22)
    libbpf: magic: 0xeb9f
    ...
    [6] ARRAY (anon) type_id=3D5 index_type_id=3D7 nr_elems=3D4
    [7] INT __ARRAY_SIZE_TYPE__ size=3D4 bits_offset=3D0 nr_bits=3D32 encod=
ing=3D(none)
    [8] VAR _license type_id=3D6 linkage=3D1
    [9] DATASEC .rodata size=3D24 vlen=3D0 vlen =3D=3D 0
    libbpf: Error loading .BTF into kernel: -22. BTF is optional, ignoring.

Basically, libbpf changed .rodata datasec size to 24 since elf .rodata
section size is 24. The kernel then rejected the BTF since vlen =3D 0.
Note that the above kernel verifier failure can be worked around with
changing local variable "fmt" to a static or global, optionally const, vari=
able.

This patch permits a datasec with vlen =3D 0 in kernel.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/btf.c                             |  5 -----
 tools/testing/selftests/bpf/prog_tests/btf.c | 21 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7ccc0133723a..71e6c2fa4830 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3540,11 +3540,6 @@ static s32 btf_datasec_check_meta(struct btf_verifie=
r_env *env,
 		return -EINVAL;
 	}
=20
-	if (!btf_type_vlen(t)) {
-		btf_verifier_log_type(env, t, "vlen =3D=3D 0");
-		return -EINVAL;
-	}
-
 	if (!t->size) {
 		btf_verifier_log_type(env, t, "size =3D=3D 0");
 		return -EINVAL;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/s=
elftests/bpf/prog_tests/btf.c
index 8ae97e2a4b9d..055d2c0486ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3509,6 +3509,27 @@ static struct btf_raw_test raw_tests[] =3D {
 	.value_type_id =3D 3 /* arr_t */,
 	.max_entries =3D 4,
 },
+/*
+ * elf .rodata section size 4 and btf .rodata section vlen 0.
+ */
+{
+	.descr =3D "datasec: vlen =3D=3D 0",
+	.raw_types =3D {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* .rodata section */
+		BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 0), 4),
+								 /* [2] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0.rodata"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.key_size =3D sizeof(int),
+	.value_size =3D sizeof(int),
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+},
=20
 }; /* struct btf_raw_test raw_tests[] */
=20
--=20
2.24.1

