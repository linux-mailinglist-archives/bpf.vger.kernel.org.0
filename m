Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BDA331B32
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 01:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhCHX77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 18:59:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhCHX7f (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Mar 2021 18:59:35 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128NXfpv080010;
        Mon, 8 Mar 2021 18:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ZuO8XYR+ae2vnhCtVSms90sUT6dBOv0QsedIzOJk3Hg=;
 b=tNYWadGVZZjxxuxOHeE/Co7RVLBrQ9oOoEfrJDDD0Ozny2kC+aXlJTsYLNvsqPMODyDa
 zrXH5YJ35z+q6ND3MbYh6YMyWTyhElKm3fQIIbdmIN3sEpNSbw0FS6tyFbW8dj7/DMwR
 AgMaw6KqQqeJTllgwkp/Vm/eE4gVCehpasJB0YxaH4kv3DrNKCofQStCnSNBu9erqKVJ
 jTrFVAChk6Vg5kQQdCNpwe8YCVbiZ2pH4e4P6QjURPMDIEUqlUOmJuY0NjtvbywqDjw2
 1OTAWrpZ3a8y8ZxhTbKUXj81LLUY1xVaTrxP4jzgOIfHb5Wieh7gw59ObLDgGYXOq8Oy nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375whm0jx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 18:59:22 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 128Nsfp5010628;
        Mon, 8 Mar 2021 18:59:22 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375whm0jwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 18:59:22 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 128Nn4m5029181;
        Mon, 8 Mar 2021 23:59:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 37410h964e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 23:59:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 128NxGqe47513920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Mar 2021 23:59:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63C6EA4060;
        Mon,  8 Mar 2021 23:59:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D470DA4054;
        Mon,  8 Mar 2021 23:59:15 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Mar 2021 23:59:15 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH dwarves v2] btf: Add support for the floating-point types
Date:   Tue,  9 Mar 2021 00:59:13 +0100
Message-Id: <20210308235913.162038-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_22:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080124
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some BPF programs compiled on s390 fail to load, because s390
arch-specific linux headers contain float and double types.

Fix as follows:

- Make the DWARF loader fill base_type.float_type.

- Introduce libbpf compatibility level command-line parameter, so that
  pahole could be used to build both the older and the newer kernels.

- libbpf introduced the support for the floating-point types in commit
  986962fade5, so update the libbpf submodule to that version and use
  the new btf__add_float() function in order to emit the floating-point
  types when not in the compatibility mode and base_type.float_type is
  set.

- Make the BTF loader recognize the new BTF kind.

Example of the resulting entry in the vmlinux BTF:

    [7164] FLOAT 'double' size=8

when building with:

    LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1} --libbpf_compat=0.4.0

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/dwarves/20210306022203.152930-1-iii@linux.ibm.com/
v1 -> v2: Introduce libbpf compatibility level command-line parameter.
          The code should now work for both bpf-next/master and
          v5.12-rc2.

 btf_loader.c   | 21 +++++++++++++++++++--
 dwarf_loader.c | 11 +++++++++++
 lib/bpf        |  2 +-
 libbtf.c       | 36 ++++++++++++++++++++++++++++++++++--
 libbtf.h       |  8 ++++++++
 pahole.c       | 26 ++++++++++++++++++++++++++
 6 files changed, 99 insertions(+), 5 deletions(-)

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
index 9f76283..c8a1dc1 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -30,6 +30,7 @@
 struct btf *base_btf;
 uint8_t btf_elf__verbose;
 uint8_t btf_elf__force;
+int libbpf_compat = LIBBPF_COMPAT_MIN;
 
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
+	} else if (bt->float_type && libbpf_compat >= LIBBPF_COMPAT_FLOAT) {
+		/*
+		 * Encode floats using libbpf. In compatibility mode, encode
+		 * them as ints - that's not fully correct, but that's what it
+		 * used to be.
+		 */
+		if (bt->float_type == BT_FP_SINGLE ||
+		    bt->float_type == BT_FP_DOUBLE ||
+		    bt->float_type == BT_FP_LDBL)
+			return btf_elf__add_float_type(btfe, bt, name);
+		fprintf(stderr, "Complex, interval and imaginary float types are not supported\n");
 		return -1;
 	}
 
diff --git a/libbtf.h b/libbtf.h
index 191f586..9fe42be 100644
--- a/libbtf.h
+++ b/libbtf.h
@@ -36,6 +36,14 @@ extern uint8_t btf_elf__verbose;
 extern uint8_t btf_elf__force;
 #define btf_elf__verbose_log(fmt, ...) { if (btf_elf__verbose) printf(fmt, __VA_ARGS__); }
 
+/* DEBUG_INFO_BTF was added in Linux 5.2, which corresponds to libbpf 0.0.3. */
+#define LIBBPF_COMPAT_MIN 0x000003
+
+/* The floating-point types were added in libbpf 0.4.0. */
+#define LIBBPF_COMPAT_FLOAT 0x000400
+
+extern int libbpf_compat;
+
 #define PERCPU_SECTION ".data..percpu"
 
 struct cu;
diff --git a/pahole.c b/pahole.c
index 4a34ba5..74d2cbb 100644
--- a/pahole.c
+++ b/pahole.c
@@ -825,6 +825,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_just_packed_structs   319
 #define ARGP_numeric_version       320
 #define ARGP_btf_base		   321
+#define ARGP_libbpf_compat	   322
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1119,6 +1120,12 @@ static const struct argp_option pahole__options[] = {
 		.key  = ARGP_btf_encode_force,
 		.doc  = "Ignore those symbols found invalid when encoding BTF."
 	},
+	{
+		.name = "libbpf_compat",
+		.key  = ARGP_libbpf_compat,
+		.arg  = "LIBBPF_VERSION",
+		.doc  = "Produce output compatible with this libbpf version."
+	},
 	{
 		.name = "structs",
 		.key  = ARGP_just_structs,
@@ -1144,6 +1151,23 @@ static const struct argp_option pahole__options[] = {
 	}
 };
 
+static int parse_version(char *arg)
+{
+	int version, patchlevel = 0, extraversion = 0;
+	char *dot;
+
+	version = atoi(arg);
+	dot = strchr(arg, '.');
+	if (dot) {
+		patchlevel = atoi(dot + 1);
+		dot = strchr(dot + 1, '.');
+		if (dot)
+			extraversion = atoi(dot + 1);
+	}
+
+	return (version << 16) | (patchlevel << 8) | extraversion;
+}
+
 static error_t pahole__options_parser(int key, char *arg,
 				      struct argp_state *state)
 {
@@ -1254,6 +1278,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		base_btf_file = arg;			break;
 	case ARGP_numeric_version:
 		print_numeric_version = true;		break;
+	case ARGP_libbpf_compat:
+		libbpf_compat = parse_version(arg);	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.29.2

