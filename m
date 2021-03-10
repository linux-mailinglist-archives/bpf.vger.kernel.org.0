Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1833348BB
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 21:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCJUQT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 15:16:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9832 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231273AbhCJUQP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Mar 2021 15:16:15 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AK7Zhj104392;
        Wed, 10 Mar 2021 15:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=z+9PSgltRJ9c+C44ZGtfGaY8sNCiVD6XcrBbcK9MouY=;
 b=p7XunCqyN16mgd5GK8tKM/y/qchGKKwvxan124bw8SvEqGGSPX7mtfAhK3uRRPUR0EO9
 dRRfScatCDTJ54ssra1VQFrlG2Z9YyuNA6nzZzQLjishnx72BLqT3xoFTZJTqbYrba4/
 tWhBLnJ8eQFIYDZdPOFHrAg9h8kZWweU5/rJqQkLWNG7UlCHTuCEbB5k5ETD7oieMKHh
 ZdAnTTz3Cz0tLp1UASOAaYwFbCWzAeHB16x7tVlYm//Ofr+8g8anq4O9b9Qx7oIKcaiw
 1qSNz2fQ4FH7bFtmnHYFRbhte9wI6CmcE1IQG0wJrLQgkj4A5JWFkwIhYn4wkJ7SBvmi 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m50qrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 15:15:57 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12AK7vDP109351;
        Wed, 10 Mar 2021 15:15:57 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m50qr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 15:15:57 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12AKFjUt029857;
        Wed, 10 Mar 2021 20:15:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3768t4h9um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 20:15:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12AKFbDs36176302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 20:15:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 713AAA4064;
        Wed, 10 Mar 2021 20:15:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2DDDA405F;
        Wed, 10 Mar 2021 20:15:51 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Mar 2021 20:15:51 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 dwarves] btf: Add support for the floating-point types
Date:   Wed, 10 Mar 2021 21:15:50 +0100
Message-Id: <20210310201550.170599-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_10:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100095
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some BPF programs compiled on s390 fail to load, because s390
arch-specific linux headers contain float and double types.

Fix as follows:

- Make the DWARF loader fill base_type.float_type.

- Introduce the --btf_gen_floats command-line parameter, so that
  pahole could be used to build both the older and the newer kernels.

- libbpf introduced the support for the floating-point types in commit
  986962fade5, so update the libbpf submodule to that version and use
  the new btf__add_float() function in order to emit the floating-point
  types when not in the compatibility mode.

- Make the BTF loader recognize the new BTF kind.

Example of the resulting entry in the vmlinux BTF:

    [7164] FLOAT 'double' size=8

when building with:

    LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --btf_gen_floats

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/dwarves/20210306022203.152930-1-iii@linux.ibm.com/
v1 -> v2: Introduce libbpf compatibility level command-line parameter.
          The code should now work for both bpf-next/master and
          v5.12-rc2.

v2: https://lore.kernel.org/dwarves/20210308235913.162038-1-iii@linux.ibm.com/
v2 -> v3: Use the feature flag (--encode_btf_kind_float) instead of the
          libbpf version flag.

v3: https://lore.kernel.org/dwarves/20210310141517.169698-1-iii@linux.ibm.com/
v3 -> v4: Rename the flag to --btf_gen_floats.

 btf_loader.c       | 21 +++++++++++++++++++--
 dwarf_loader.c     | 11 +++++++++++
 lib/bpf            |  2 +-
 libbtf.c           | 36 ++++++++++++++++++++++++++++++++++--
 libbtf.h           |  1 +
 man-pages/pahole.1 |  5 +++++
 pahole.c           |  8 ++++++++
 7 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index ec286f4..7cc39aa 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -160,7 +160,7 @@ static struct variable *variable__new(strings_t name, uint32_t linkage)
 	return var;
 }
 
-static int create_new_base_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
+static int create_new_int_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
 {
 	uint32_t attrs = btf_int_encoding(tp);
 	strings_t name = tp->name_off;
@@ -175,6 +175,20 @@ static int create_new_base_type(struct btf_elf *btfe, const struct btf_type *tp,
 	return 0;
 }
 
+static int create_new_float_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
+{
+	strings_t name = tp->name_off;
+	struct base_type *base = base_type__new(name, 0, BT_FP_SINGLE, tp->size * 8);
+
+	if (base == NULL)
+		return -ENOMEM;
+
+	base->tag.tag = DW_TAG_base_type;
+	cu__add_tag_with_id(btfe->priv, &base->tag, id);
+
+	return 0;
+}
+
 static int create_new_array(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
 {
 	struct btf_array *ap = btf_array(tp);
@@ -397,7 +411,7 @@ static int btf_elf__load_types(struct btf_elf *btfe)
 
 		switch (type) {
 		case BTF_KIND_INT:
-			err = create_new_base_type(btfe, type_ptr, type_index);
+			err = create_new_int_type(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_ARRAY:
 			err = create_new_array(btfe, type_ptr, type_index);
@@ -442,6 +456,9 @@ static int btf_elf__load_types(struct btf_elf *btfe)
 			// BTF_KIND_FUNC corresponding to a defined subprogram.
 			err = create_new_function(btfe, type_ptr, type_index);
 			break;
+		case BTF_KIND_FLOAT:
+			err = create_new_float_type(btfe, type_ptr, type_index);
+			break;
 		default:
 			fprintf(stderr, "BTF: idx: %d, Unknown kind %d\n", type_index, type);
 			fflush(stderr);
diff --git a/dwarf_loader.c b/dwarf_loader.c
index b73d786..c5e6681 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -461,6 +461,16 @@ static struct ptr_to_member_type *ptr_to_member_type__new(Dwarf_Die *die,
 	return ptr;
 }
 
+static uint8_t encoding_to_float_type(uint64_t encoding)
+{
+	switch (encoding) {
+	case DW_ATE_complex_float:	return BT_FP_CMPLX;
+	case DW_ATE_float:		return BT_FP_SINGLE;
+	case DW_ATE_imaginary_float:	return BT_FP_IMGRY;
+	default:			return 0;
+	}
+}
+
 static struct base_type *base_type__new(Dwarf_Die *die, struct cu *cu)
 {
 	struct base_type *bt = tag__alloc(cu, sizeof(*bt));
@@ -474,6 +484,7 @@ static struct base_type *base_type__new(Dwarf_Die *die, struct cu *cu)
 		bt->is_signed = encoding == DW_ATE_signed;
 		bt->is_varargs = false;
 		bt->name_has_encoding = true;
+		bt->float_type = encoding_to_float_type(encoding);
 	}
 
 	return bt;
diff --git a/lib/bpf b/lib/bpf
index 5af3d86..986962f 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396
+Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
diff --git a/libbtf.c b/libbtf.c
index 9f76283..7ad7e9c 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -30,6 +30,7 @@
 struct btf *base_btf;
 uint8_t btf_elf__verbose;
 uint8_t btf_elf__force;
+bool btf_gen_floats = false;
 
 static int btf_var_secinfo_cmp(const void *a, const void *b)
 {
@@ -227,6 +228,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
 	[BTF_KIND_VAR]          = "VAR",
 	[BTF_KIND_DATASEC]      = "DATASEC",
+	[BTF_KIND_FLOAT]        = "FLOAT",
 };
 
 static const char *btf_elf__printable_name(const struct btf_elf *btfe, uint32_t offset)
@@ -367,6 +369,27 @@ static void btf_log_func_param(const struct btf_elf *btfe,
 	}
 }
 
+static int32_t btf_elf__add_float_type(struct btf_elf *btfe,
+				       const struct base_type *bt,
+				       const char *name)
+{
+	int32_t id;
+
+	id = btf__add_float(btfe->btf, name, BITS_ROUNDUP_BYTES(bt->bit_size));
+	if (id < 0) {
+		btf_elf__log_err(btfe, BTF_KIND_FLOAT, name, true, "Error emitting BTF type");
+	} else {
+		const struct btf_type *t;
+
+		t = btf__type_by_id(btfe->btf, id);
+		btf_elf__log_type(btfe, t, false, true,
+				  "size=%u nr_bits=%u",
+				  t->size, bt->bit_size);
+	}
+
+	return id;
+}
+
 int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
 			       const char *name)
 {
@@ -379,8 +402,17 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
 		encoding = BTF_INT_SIGNED;
 	} else if (bt->is_bool) {
 		encoding = BTF_INT_BOOL;
-	} else if (bt->float_type) {
-		fprintf(stderr, "float_type is not supported\n");
+	} else if (bt->float_type && btf_gen_floats) {
+		/*
+		 * Encode floats as BTF_KIND_FLOAT if allowed, otherwise (in
+		 * compatibility mode) encode them as BTF_KIND_INT - that's not
+		 * fully correct, but that's what it used to be.
+		 */
+		if (bt->float_type == BT_FP_SINGLE ||
+		    bt->float_type == BT_FP_DOUBLE ||
+		    bt->float_type == BT_FP_LDBL)
+			return btf_elf__add_float_type(btfe, bt, name);
+		fprintf(stderr, "Complex, interval and imaginary float types are not supported\n");
 		return -1;
 	}
 
diff --git a/libbtf.h b/libbtf.h
index 191f586..c7cbe6e 100644
--- a/libbtf.h
+++ b/libbtf.h
@@ -35,6 +35,7 @@ extern struct btf *base_btf;
 extern uint8_t btf_elf__verbose;
 extern uint8_t btf_elf__force;
 #define btf_elf__verbose_log(fmt, ...) { if (btf_elf__verbose) printf(fmt, __VA_ARGS__); }
+extern bool btf_gen_floats;
 
 #define PERCPU_SECTION ".data..percpu"
 
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 352bb5e..e292b2c 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -199,6 +199,11 @@ Path to the base BTF file, for instance: vmlinux when encoding kernel module BTF
 This may be inferred when asking for a /sys/kernel/btf/MODULE, when it will be autoconfigured
 to "/sys/kernel/btf/vmlinux".
 
+.TP
+.B \-\-btf_gen_floats
+Allow producing BTF_KIND_FLOAT entries in systems where the vmlinux DWARF
+information has float types.
+
 .TP
 .B \-l, \-\-show_first_biggest_size_base_type_member
 Show first biggest size base_type member.
diff --git a/pahole.c b/pahole.c
index 4a34ba5..c8d38f5 100644
--- a/pahole.c
+++ b/pahole.c
@@ -825,6 +825,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_just_packed_structs   319
 #define ARGP_numeric_version       320
 #define ARGP_btf_base		   321
+#define ARGP_btf_gen_floats	   322
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1119,6 +1120,11 @@ static const struct argp_option pahole__options[] = {
 		.key  = ARGP_btf_encode_force,
 		.doc  = "Ignore those symbols found invalid when encoding BTF."
 	},
+	{
+		.name = "btf_gen_floats",
+		.key  = ARGP_btf_gen_floats,
+		.doc  = "Allow producing BTF_KIND_FLOAT entries."
+	},
 	{
 		.name = "structs",
 		.key  = ARGP_just_structs,
@@ -1254,6 +1260,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		base_btf_file = arg;			break;
 	case ARGP_numeric_version:
 		print_numeric_version = true;		break;
+	case ARGP_btf_gen_floats:
+		btf_gen_floats = true;			break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.29.2

