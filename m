Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51C334BEBC
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhC1UOe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 16:14:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2482 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231366AbhC1UOW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Mar 2021 16:14:22 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12SKE1rb016998
        for <bpf@vger.kernel.org>; Sun, 28 Mar 2021 13:14:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=geRhSKt2Zjm6sy3uVlEuP2/5mX3VnMoKqsv1eIUVdF4=;
 b=ZuQoDI/hQ4vUBQIZstHGmwFcoFMj1ZSeEIOp1hkUT7Nb3eBvTfdwZkw3kySok1V+xXi/
 MOtiPdrBgyIGqFJL5I8XbMzbA69HSzhAjEf5SNu14kbTut7Q4nsuKcs5Xa7fLPMT33ys
 Md30QOgdstskSsdxe9pzjFdJNf9Td37RNAc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37jmv21t64-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 28 Mar 2021 13:14:22 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 28 Mar 2021 13:14:21 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id ED34FCDDE01; Sun, 28 Mar 2021 13:14:15 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH dwarves v3 3/3] dwarf_loader: permit merging all dwarf cu's for clang lto built binary
Date:   Sun, 28 Mar 2021 13:14:15 -0700
Message-ID: <20210328201415.1428856-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210328201400.1426437-1-yhs@fb.com>
References: <20210328201400.1426437-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Us47tk8bksXQlHu4xhdLA_ajaq8l-Otx
X-Proofpoint-ORIG-GUID: Us47tk8bksXQlHu4xhdLA_ajaq8l-Otx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_12:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280155
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For vmlinux built with clang thin-lto or lto, there exist
cross cu type references. For example, the below can happen:
  compile unit 1:
     tag 10:  type A
  compile unit 2:
     ...
       refer to type A (tag 10 in compile unit 1)
I only checked a few but have seen type A may be a simple type
like "unsigned char" or a complex type like an array of base types.

To resolve this issue, the tag DW_AT_producer of the first
DW_TAG_compile_unit is checked. If the binary is built
with clang lto, all debuginfo dwarf cu's will be merged
into one pahole cu which will resolve the above
cross-cu tag reference issue. To test whether a binary
is built with clang lto or not, The "clang version"
and "-flto" will be checked against DW_AT_producer string
for the first 5 debuginfo cu's. The reason is that
a few linux files disabled lto for various reasons.

Merging cu's will create a single cu with lots of types, tags
and functions. For example with clang thin-lto built vmlinux,
I saw 9M entries in types table, 5.2M in tags table. The
below are pahole wallclock time for different hashbits:
command line: time pahole -J vmlinux
      # of hashbits            wallclock time in seconds
          15                       460
          16                       255
          17                       131
          18                       97
          19                       75
          20                       69
          21                       64
          22                       62
          23                       58
          24                       64

The problem is with hashtags__find(), esp. the loop
    uint32_t bucket =3D hashtags__fn(id);
    const struct hlist_head *head =3D hashtable + bucket;
    hlist_for_each_entry(tpos, pos, head, hash_node) {
            if (tpos->id =3D=3D id)
                    return tpos;
    }

Say we have 9M types and (1 << 15) buckets, that means each bucket
will have roughly 64 elements. So each lookup will traverse
the loop 32 iterations on average.

If we have 1 << 21 buckets, then each buckets will have 4 elements,
and the average number of loop iterations for hashtags__find()
will be 2.

Note that the number of hashbits 24 makes performance worse
than 23. The reason could be that 23 hashbits can cover 8M
buckets (close to 9M for the number of entries in types table).
Higher number of hash bits allocates more memory and becomes
less cache efficient compared to 23 hashbits.

This patch picks # of hashbits 21 as the starting value
and will try to allocate memory based on that, if memory
allocation fails, we will go with less hashbits until
we reach hashbits 15 which is the default for
non merge-cu case.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 dwarf_loader.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index aa6372a..a51391e 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -51,6 +51,7 @@ struct strings *strings;
 #endif
=20
 static uint32_t hashtags__bits =3D 15;
+static uint32_t max_hashtags__bits =3D 21;
=20
 static uint32_t hashtags__fn(Dwarf_Off key)
 {
@@ -2484,6 +2485,115 @@ static int cus__load_debug_types(struct cus *cus,=
 struct conf_load *conf,
 	return 0;
 }
=20
+static bool cus__merging_cu(Dwarf *dw)
+{
+	uint8_t pointer_size, offset_size;
+	Dwarf_Off off =3D 0, noff;
+	size_t cuhl;
+	int cnt =3D 0;
+
+	/*
+	 * Just checking the first cu is not enough.
+	 * In linux, some C files may have LTO is disabled, e.g.,
+	 *   e242db40be27  x86, vdso: disable LTO only for vDSO
+	 *   d2dcd3e37475  x86, cpu: disable LTO for cpu.c
+	 * Fortunately, disabling LTO for a particular file in a LTO build
+	 * is rather an exception. Iterating 5 cu's to check whether
+	 * LTO is used or not should be enough.
+	 */
+	while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
+			    &offset_size) =3D=3D 0) {
+		Dwarf_Die die_mem;
+		Dwarf_Die *cu_die =3D dwarf_offdie(dw, off + cuhl, &die_mem);
+
+		if (cu_die =3D=3D NULL)
+			break;
+
+		if (++cnt > 5)
+			break;
+
+		const char *producer =3D attr_string(cu_die, DW_AT_producer);
+		if (strstr(producer, "clang version") !=3D NULL &&
+		    strstr(producer, "-flto") !=3D NULL)
+			return true;
+
+		off =3D noff;
+	}
+
+	return false;
+}
+
+static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *=
conf,
+				     Dwfl_Module *mod, Dwarf *dw, Elf *elf,
+				     const char *filename,
+				     const unsigned char *build_id,
+				     int build_id_len,
+				     struct dwarf_cu *type_dcu)
+{
+	uint8_t pointer_size, offset_size;
+	struct dwarf_cu *dcu =3D NULL;
+	Dwarf_Off off =3D 0, noff;
+	struct cu *cu =3D NULL;
+	size_t cuhl;
+
+	while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
+			    &offset_size) =3D=3D 0) {
+		Dwarf_Die die_mem;
+		Dwarf_Die *cu_die =3D dwarf_offdie(dw, off + cuhl, &die_mem);
+
+		if (cu_die =3D=3D NULL)
+			break;
+
+		if (cu =3D=3D NULL) {
+			cu =3D cu__new("", pointer_size, build_id, build_id_len,
+				     filename);
+			if (cu =3D=3D NULL || cu__set_common(cu, conf, mod, elf) !=3D 0)
+				return DWARF_CB_ABORT;
+
+			dcu =3D malloc(sizeof(struct dwarf_cu));
+			if (dcu =3D=3D NULL)
+				return DWARF_CB_ABORT;
+
+			/* Merged cu tends to need a lot more memory.
+			 * Let us start with max_hashtags__bits and
+			 * go down to find a proper hashtag bit value.
+			 */
+			uint32_t default_hbits =3D hashtags__bits;
+			for (hashtags__bits =3D max_hashtags__bits;
+			     hashtags__bits >=3D default_hbits;
+			     hashtags__bits--) {
+				if (dwarf_cu__init(dcu) =3D=3D 0)
+					break;
+			}
+			if (hashtags__bits < default_hbits)
+				return DWARF_CB_ABORT;
+
+			dcu->cu =3D cu;
+			dcu->type_unit =3D type_dcu;
+			cu->priv =3D dcu;
+			cu->dfops =3D &dwarf__ops;
+			cu->language =3D attr_numeric(cu_die, DW_AT_language);
+		}
+
+		Dwarf_Die child;
+		if (dwarf_child(cu_die, &child) =3D=3D 0) {
+			if (die__process_unit(&child, cu) !=3D 0)
+				return DWARF_CB_ABORT;
+		}
+
+		off =3D noff;
+	}
+
+	/* process merged cu */
+	if (cu__recode_dwarf_types(cu) !=3D LSK__KEEPIT)
+		return DWARF_CB_ABORT;
+	if (finalize_cu_immediately(cus, cu, dcu, conf)
+	    =3D=3D LSK__STOP_LOADING)
+		return DWARF_CB_ABORT;
+
+	return 0;
+}
+
 static int cus__load_module(struct cus *cus, struct conf_load *conf,
 			    Dwfl_Module *mod, Dwarf *dw, Elf *elf,
 			    const char *filename)
@@ -2518,6 +2628,15 @@ static int cus__load_module(struct cus *cus, struc=
t conf_load *conf,
 		}
 	}
=20
+	if (cus__merging_cu(dw)) {
+		res =3D cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
+						build_id, build_id_len,
+						type_cu ? &type_dcu : NULL);
+		if (res)
+			return res;
+		goto out;
+	}
+
 	while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
 			    &offset_size) =3D=3D 0) {
 		Dwarf_Die die_mem;
@@ -2557,6 +2676,7 @@ static int cus__load_module(struct cus *cus, struct=
 conf_load *conf,
 		off =3D noff;
 	}
=20
+out:
 	if (type_lsk =3D=3D LSK__DELETE)
 		cu__delete(type_cu);
=20
--=20
2.30.2

