Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D608A369C14
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 23:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhDWViQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 17:38:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22726 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244030AbhDWViP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Apr 2021 17:38:15 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NLSs4A018750
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 14:37:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JMwRiruzwLjUfp1BmuQQf6DxklxeQP2VsoaRvXsf3x0=;
 b=P2tTTPr/stbTV16hH1JKuQJfEX5PI2B8O53GRU0mDUU8VtRyS7VvoZT5sEP4/f/3GqJK
 O1anUdEr4GzEZvjSlesUU9FP5TSBh0uq4fN7Hmrh1Q6q6oQkn/KZrq1ZFIGyyBH+NPBJ
 q7mWMjAA1rJ5vOgUrR79oGPctxEEPyQpfjs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3839usskbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 14:37:38 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 14:37:36 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 4979929429AD; Fri, 23 Apr 2021 14:37:28 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids section
Date:   Fri, 23 Apr 2021 14:37:28 -0700
Message-ID: <20210423213728.3538141-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -Ktn-wg-A77z9dOzZiwFlKoPcGa2rdyE
X-Proofpoint-ORIG-GUID: -Ktn-wg-A77z9dOzZiwFlKoPcGa2rdyE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_13:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF is currently generated for functions that are in ftrace list
or extern.

A recent use case also needs BTF generated for functions included in
allowlist.  In particular, the kernel
commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist =
for bpf-tcp-cc")
allows bpf program to directly call a few tcp cc kernel functions.  Those
functions are specified under an ELF section .BTF_ids.  The symbols
in this ELF section is like __BTF_ID__func__<kernel_func>__[digit]+.
For example, __BTF_ID__func__cubictcp_init__1.  Those kernel
functions are currently allowed only if CONFIG_DYNAMIC_FTRACE is
set to ensure they are in the ftrace list but this kconfig dependency
is unnecessary.

pahole can generate BTF for those kernel functions if it knows they
are in the allowlist.  This patch is to capture those symbols
in the .BTF_ids section and generate BTF for them.

Cc: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 btf_encoder.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++---
 libbtf.c      |  10 ++++
 libbtf.h      |   2 +
 3 files changed, 142 insertions(+), 6 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 80e896961d4e..48c183915ddd 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -106,6 +106,121 @@ static int collect_function(struct btf_elf *btfe, G=
Elf_Sym *sym,
 	return 0;
 }
=20
+#define BTF_ID_FUNC_PREFIX "__BTF_ID__func__"
+#define BTF_ID_FUNC_PREFIX_LEN (sizeof(BTF_ID_FUNC_PREFIX) - 1)
+
+static char **listed_functions;
+static int listed_functions_alloc;
+static int listed_functions_cnt;
+
+static void delete_listed_functions(void)
+{
+	int i;
+
+	for (i =3D 0; i < listed_functions_cnt; i++)
+		free(listed_functions[i]);
+
+	free(listed_functions);
+	/* In case btf_encoder__encode() will be called multiple times */
+	listed_functions_alloc =3D 0;
+	listed_functions_cnt =3D 0;
+	listed_functions =3D NULL;
+}
+
+static int listed_function_cmp(const void *_a, const void *_b)
+{
+	const char *a =3D *(const char **)_a;
+	const char *b =3D *(const char **)_b;
+
+	return strcmp(a, b);
+}
+
+static bool is_listed_func(const char *name)
+{
+	return !!bsearch(&name, listed_functions, listed_functions_cnt,
+			 sizeof(*listed_functions), listed_function_cmp);
+}
+
+static int collect_listed_functions(struct btf_elf *btfe, GElf_Sym *sym,
+				    size_t sym_sec_idx)
+{
+	int len, digits =3D 0, underscores =3D 0;
+	const char *name;
+	char *func_name;
+
+	if (!btfe->btf_ids_shndx ||
+	    btfe->btf_ids_shndx !=3D sym_sec_idx)
+		return 0;
+
+	/* The kernel function in the btf id list will have symbol like:
+	 * __BTF_ID__func__<kernel_func_name>__[digit]+
+	 */
+	name =3D elf_sym__name(sym, btfe->symtab);
+	if (strncmp(name, BTF_ID_FUNC_PREFIX, BTF_ID_FUNC_PREFIX_LEN))
+		return 0;
+
+	name +=3D BTF_ID_FUNC_PREFIX_LEN;
+
+	/* name: <kernel_func_name>__[digit]+
+	 * Strip the ending __[digit]+
+	 */
+	for (len =3D strlen(name); len && underscores !=3D 2; len--) {
+		char c =3D name[len - 1];
+
+		if (c =3D=3D '_') {
+			if (!digits)
+				return 0;
+			underscores++;
+		} else if (isdigit(c)) {
+			if (underscores)
+				return 0;
+			digits++;
+		} else {
+			return 0;
+		}
+	}
+
+	if (!len)
+		return 0;
+
+	func_name =3D strndup(name, len);
+	if (!func_name) {
+		fprintf(stderr,
+			"Failed to alloc memory for listed function %s%s\n",
+			BTF_ID_FUNC_PREFIX, name);
+		return -1;
+	}
+
+	if (is_listed_func(func_name)) {
+		/* already captured */
+		free(func_name);
+		return 0;
+	}
+
+	/* grow listed_functions */
+	if (listed_functions_cnt =3D=3D listed_functions_alloc) {
+		char **new;
+
+		listed_functions_alloc =3D max(100,
+					     listed_functions_alloc * 3 / 2);
+		new =3D realloc(listed_functions,
+			      listed_functions_alloc * sizeof(*listed_functions));
+		if (!new) {
+			fprintf(stderr,
+				"Failed to alloc memory for listed function %s%s\n",
+				BTF_ID_FUNC_PREFIX, name);
+			free(func_name);
+			return -1;
+		}
+		listed_functions =3D new;
+	}
+
+	listed_functions[listed_functions_cnt++] =3D func_name;
+	qsort(listed_functions, listed_functions_cnt,
+	      sizeof(*listed_functions), listed_function_cmp);
+	return 0;
+}
+
 static int addrs_cmp(const void *_a, const void *_b)
 {
 	const __u64 *a =3D _a;
@@ -294,14 +409,15 @@ static int setup_functions(struct btf_elf *btfe, st=
ruct funcs_layout *fl)
 		kmod =3D true;
 	}
=20
-	if (!addrs) {
+	if (!addrs && !listed_functions_cnt) {
 		if (btf_elf__verbose)
-			printf("ftrace symbols not detected, falling back to DWARF data\n");
+			printf("ftrace symbols and btf listed functions are not detected, fal=
ling back to DWARF data\n");
 		delete_functions();
 		return 0;
 	}
=20
-	qsort(addrs, count, sizeof(addrs[0]), addrs_cmp);
+	if (addrs)
+		qsort(addrs, count, sizeof(addrs[0]), addrs_cmp);
 	qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
=20
 	/*
@@ -321,8 +437,12 @@ static int setup_functions(struct btf_elf *btfe, str=
uct funcs_layout *fl)
 		if (kmod)
 			func->addr +=3D func->sh_addr;
=20
-		/* Make sure function is within ftrace addresses. */
-		if (is_ftrace_func(func, addrs, count)) {
+		/*
+		 * Make sure function is within ftrace addresses or
+		 * is a listed function in the .BTF_ids section.
+		 */
+		if (is_ftrace_func(func, addrs, count) ||
+		    is_listed_func(func->name)) {
 			/*
 			 * We iterate over sorted array, so we can easily skip
 			 * not valid item and move following valid field into
@@ -533,6 +653,7 @@ int btf_encoder__encode()
=20
 	err =3D btf_elf__encode(btfe, 0);
 	delete_functions();
+	delete_listed_functions();
 	btf_elf__delete(btfe);
 	btfe =3D NULL;
=20
@@ -650,6 +771,8 @@ static int collect_symbols(struct btf_elf *btfe, bool=
 collect_percpu_vars)
 			return -1;
 		if (collect_function(btfe, &sym, sym_sec_idx))
 			return -1;
+		if (collect_listed_functions(btfe, &sym, sym_sec_idx))
+			return -1;
 		collect_symbol(&sym, &fl, sym_sec_idx);
 	}
=20
@@ -764,7 +887,8 @@ int cu__encode_btf(struct cu *cu, int verbose, bool f=
orce,
 		 *   - are marked as declarations
 		 *   - do not have full argument names
 		 *   - are not in ftrace list (if it's available)
-		 *   - are not external (in case ftrace filter is not available)
+		 *   - are not in the .BTF_ids section
+		 *   - are not external (in case ftrace and .BTF_ids filter are not av=
ailable)
 		 */
 		if (fn->declaration)
 			continue;
diff --git a/libbtf.c b/libbtf.c
index c2360ff1f804..d9729bd4680d 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -168,6 +168,16 @@ try_as_raw_btf:
 		return btfe;
 	}
=20
+	sec =3D elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr,
+				  BTF_IDS_SECTION, NULL);
+	if (!sec) {
+		if (btf_elf__verbose)
+			printf("%s: '%s' doesn't have '%s' section\n", __func__,
+			       btfe->filename, BTF_IDS_SECTION);
+	} else {
+		btfe->btf_ids_shndx =3D elf_ndxscn(sec);
+	}
+
 	/* find percpu section's shndx */
 	sec =3D elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr, PERCPU_SECTI=
ON,
 				  NULL);
diff --git a/libbtf.h b/libbtf.h
index c7cbe6e17ee7..6caaac306f77 100644
--- a/libbtf.h
+++ b/libbtf.h
@@ -24,6 +24,7 @@ struct btf_elf {
 	uint8_t		  wordsize;
 	bool		  is_big_endian;
 	bool		  raw_btf; // "/sys/kernel/btf/vmlinux"
+	uint32_t	  btf_ids_shndx;
 	uint32_t	  percpu_shndx;
 	uint64_t	  percpu_base_addr;
 	uint64_t	  percpu_sec_sz;
@@ -38,6 +39,7 @@ extern uint8_t btf_elf__force;
 extern bool btf_gen_floats;
=20
 #define PERCPU_SECTION ".data..percpu"
+#define BTF_IDS_SECTION ".BTF_ids"
=20
 struct cu;
 struct base_type;
--=20
2.30.2

