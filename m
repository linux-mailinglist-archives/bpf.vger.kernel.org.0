Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408A1348971
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 07:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhCYGxy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 02:53:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22322 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229664AbhCYGxf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Mar 2021 02:53:35 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12P6pWho029566
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 23:53:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uGv19X6Jg7UiY365DY9yx28kp6nGdDll8V+NVR/yBFY=;
 b=mUjwPA4PS7NGOiYe7w6T42/3brGPjjf7WhbdeFo5goHjYwBG6Fxx4CZhhM60ac2rqFr8
 YyDwUB74wiW2YATIh6qU9ova7mrG6ZbYj9+EDVUQ/wHrn7V26+LObnxdJZDeQ5pVzodN
 nxy0ouwL0m8bXYugWgkqcpSxbKIeEL24yBQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37fpbm9xtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 23:53:35 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 23:53:34 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 8AA0FAE26D9; Wed, 24 Mar 2021 23:53:32 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf cu's into one pahole cu
Date:   Wed, 24 Mar 2021 23:53:32 -0700
Message-ID: <20210325065332.3122473-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325065316.3121287-1-yhs@fb.com>
References: <20210325065316.3121287-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_01:2021-03-24,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250050
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch added an option "merge_cus", which will permit
to merge all debug info cu's into one pahole cu.
For vmlinux built with clang thin-lto or lto, there exist
cross cu type references. For example, you could have
  compile unit 1:
     tag 10:  type A
  compile unit 2:
     ...
       refer to type A (tag 10 in compile unit 1)
I only checked a few but have seen type A may be a simple type
like "unsigned char" or a complex type like an array of base types.

There are two different ways to resolve this issue:
(1). merge all compile units as one pahole cu so tags/types
     can be resolved easily, or
(2). try to do on-demand type traversal in other debuginfo cu's
     when we do die_process().
The method (2) is much more complicated so I picked method (1).
An option "merge_cus" is added to permit such an operation.

Merging cu's will create a single cu with lots of types, tags
and functions. For example with clang thin-lto built vmlinux,
I saw 9M entries in types table, 5.2M in tags table. The
below are pahole wallclock time for different hashbits:
command line: time pahole -J --merge_cus vmlinux
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
 dwarf_loader.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h      |  2 ++
 pahole.c       |  8 +++++
 3 files changed, 100 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index dc66df0..ed4f0da 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -51,6 +51,7 @@ struct strings *strings;
 #endif
=20
 static uint32_t hashtags__bits =3D 15;
+static uint32_t max_hashtags__bits =3D 21;
=20
 uint32_t hashtags__fn(Dwarf_Off key)
 {
@@ -2484,6 +2485,85 @@ static int cus__load_debug_types(struct cus *cus, =
struct conf_load *conf,
 	return 0;
 }
=20
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
+	/* Merge all cus */
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
+		const uint16_t tag =3D dwarf_tag(cu_die);
+		if (tag !=3D DW_TAG_compile_unit && tag !=3D DW_TAG_type_unit) {
+			fprintf(stderr, "%s: DW_TAG_compile_unit or DW_TAG_type_unit expected=
 got %s!\n",
+				__FUNCTION__, dwarf_tag_name(tag));
+			return DWARF_CB_ABORT;
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
@@ -2518,6 +2598,15 @@ static int cus__load_module(struct cus *cus, struc=
t conf_load *conf,
 		}
 	}
=20
+	if (conf->merge_cus =3D=3D true) {
+		res =3D cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
+						build_id, build_id_len,
+						type_cu ? &type_dcu : NULL);
+		if (res !=3D 0)
+			return res;
+		goto out;
+	}
+
 	while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
 			    &offset_size) =3D=3D 0) {
 		Dwarf_Die die_mem;
@@ -2557,6 +2646,7 @@ static int cus__load_module(struct cus *cus, struct=
 conf_load *conf,
 		off =3D noff;
 	}
=20
+out:
 	if (type_lsk =3D=3D LSK__DELETE)
 		cu__delete(type_cu);
=20
diff --git a/dwarves.h b/dwarves.h
index 98caf1a..29b518d 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -40,6 +40,7 @@ struct conf_fprintf;
  * @extra_dbg_info - keep original debugging format extra info
  *		     (e.g. DWARF's decl_{line,file}, id, etc)
  * @fixup_silly_bitfields - Fixup silly things such as "int foo:32;"
+ * @merge_cus - Merge compile units except possible types_cu
  * @get_addr_info - wheter to load DW_AT_location and other addr info
  */
 struct conf_load {
@@ -50,6 +51,7 @@ struct conf_load {
 	bool			extra_dbg_info;
 	bool			fixup_silly_bitfields;
 	bool			get_addr_info;
+	bool			merge_cus;
 	struct conf_fprintf	*conf_fprintf;
 };
=20
diff --git a/pahole.c b/pahole.c
index df6aa83..29fbe1d 100644
--- a/pahole.c
+++ b/pahole.c
@@ -827,6 +827,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =3D dwarves_print_versi=
on;
 #define ARGP_btf_base		   321
 #define ARGP_btf_gen_floats	   322
 #define ARGP_btf_gen_all	   323
+#define ARGP_merge_cus		   324
=20
 static const struct argp_option pahole__options[] =3D {
 	{
@@ -1151,6 +1152,11 @@ static const struct argp_option pahole__options[] =
=3D {
 		.key  =3D ARGP_numeric_version,
 		.doc  =3D "Print a numeric version, i.e. 119 instead of v1.19"
 	},
+	{
+		.name =3D "merge_cus",
+		.key  =3D ARGP_merge_cus,
+		.doc  =3D "Merge all cus (except possible types_cu)"
+	},
 	{
 		.name =3D NULL,
 	}
@@ -1270,6 +1276,8 @@ static error_t pahole__options_parser(int key, char=
 *arg,
 		btf_gen_floats =3D true;			break;
 	case ARGP_btf_gen_all:
 		btf_gen_floats =3D true;			break;
+	case ARGP_merge_cus:
+		conf_load.merge_cus =3D true;		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
--=20
2.30.2

