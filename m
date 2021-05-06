Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18A6375C7D
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 22:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhEFU52 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 May 2021 16:57:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45022 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229784AbhEFU52 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 May 2021 16:57:28 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146KrSkb021980
        for <bpf@vger.kernel.org>; Thu, 6 May 2021 13:56:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=UVuoeie4W/uvhn/gjl14h8pD+Nen+MT5hyL24stVGb8=;
 b=omEFgy7Qr0mOjBuwWQvH41lol7X8UgMItjX5DfbZbcWQDK3lxmvA092Tepq+wzCdiitQ
 KBqaQUkjGY8wovefnxj4MUvpQLmqtnFb5ENmcMkv6k4lLLdg2wMwlrlDXNX3e1PgERke
 /mMrnqgNsK/W5zbHh19i5IL0/LG28P4GAcc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38bebhvjgg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 May 2021 13:56:30 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 6 May 2021 13:56:26 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 2DD6129418C3; Thu,  6 May 2021 13:56:22 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>, <bpf@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 dwarves] btf: Remove ftrace filter
Date:   Thu, 6 May 2021 13:56:22 -0700
Message-ID: <20210506205622.3663956-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: APOdUvK9ZWpTtlhZb-8M9G43dObj5oiG
X-Proofpoint-GUID: APOdUvK9ZWpTtlhZb-8M9G43dObj5oiG
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF is currently generated for functions that are in ftrace list
or extern.

A recent use case also needs BTF generated for functions included in
allowlist.  In particular, the kernel
commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist fo=
r bpf-tcp-cc")
allows bpf program to directly call a few tcp cc kernel functions. Those
kernel functions are currently allowed only if CONFIG_DYNAMIC_FTRACE
is set to ensure they are in the ftrace list but this kconfig dependency
is unnecessary.

Those kernel functions are specified under an ELF section .BTF_ids.
There was an earlier attempt [0] to add another filter for the functions in
the .BTF_ids section.  That discussion concluded that the ftrace filter
should be removed instead.

This patch is to remove the ftrace filter and its related functions.

Number of BTF FUNC with and without is_ftrace_func():
My kconfig in x86: 40643 vs 46225
Jiri reported on arm: 25022 vs 55812

[0]: https://lore.kernel.org/dwarves/20210423213728.3538141-1-kafai@fb.com/

Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
v2: Remove sym_sec_idx, last_idx, and sh. (Jiri Olsa)

 btf_encoder.c | 285 ++------------------------------------------------
 1 file changed, 7 insertions(+), 278 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 80e896961d4e..c711f124b31e 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -27,17 +27,8 @@
  */
 #define KSYM_NAME_LEN 128
=20
-struct funcs_layout {
-	unsigned long mcount_start;
-	unsigned long mcount_stop;
-	unsigned long mcount_sec_idx;
-};
-
 struct elf_function {
 	const char	*name;
-	unsigned long	 addr;
-	unsigned long	 size;
-	unsigned long	 sh_addr;
 	bool		 generated;
 };
=20
@@ -64,12 +55,9 @@ static void delete_functions(void)
 #define max(x, y) ((x) < (y) ? (y) : (x))
 #endif
=20
-static int collect_function(struct btf_elf *btfe, GElf_Sym *sym,
-			    size_t sym_sec_idx)
+static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
 {
 	struct elf_function *new;
-	static GElf_Shdr sh;
-	static size_t last_idx;
 	const char *name;
=20
 	if (elf_sym__type(sym) !=3D STT_FUNC)
@@ -91,257 +79,12 @@ static int collect_function(struct btf_elf *btfe, GElf=
_Sym *sym,
 		functions =3D new;
 	}
=20
-	if (sym_sec_idx !=3D last_idx) {
-		if (!elf_section_by_idx(btfe->elf, &sh, sym_sec_idx))
-			return 0;
-		last_idx =3D sym_sec_idx;
-	}
-
 	functions[functions_cnt].name =3D name;
-	functions[functions_cnt].addr =3D elf_sym__value(sym);
-	functions[functions_cnt].size =3D elf_sym__size(sym);
-	functions[functions_cnt].sh_addr =3D sh.sh_addr;
 	functions[functions_cnt].generated =3D false;
 	functions_cnt++;
 	return 0;
 }
=20
-static int addrs_cmp(const void *_a, const void *_b)
-{
-	const __u64 *a =3D _a;
-	const __u64 *b =3D _b;
-
-	if (*a =3D=3D *b)
-		return 0;
-	return *a < *b ? -1 : 1;
-}
-
-static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
-			     __u64 **paddrs, __u64 *pcount)
-{
-	__u64 *addrs, count, offset;
-	unsigned int addr_size, i;
-	Elf_Data *data;
-	GElf_Shdr shdr;
-	Elf_Scn *sec;
-
-	/* Initialize for the sake of all error paths below. */
-	*paddrs =3D NULL;
-	*pcount =3D 0;
-
-	if (!fl->mcount_start || !fl->mcount_stop)
-		return 0;
-
-	/*
-	 * Find mcount addressed marked by __start_mcount_loc
-	 * and __stop_mcount_loc symbols and load them into
-	 * sorted array.
-	 */
-	sec =3D elf_getscn(btfe->elf, fl->mcount_sec_idx);
-	if (!sec || !gelf_getshdr(sec, &shdr)) {
-		fprintf(stderr, "Failed to get section(%lu) header.\n",
-			fl->mcount_sec_idx);
-		return -1;
-	}
-
-	/* Get address size from processed file's ELF class. */
-	addr_size =3D gelf_getclass(btfe->elf) =3D=3D ELFCLASS32 ? 4 : 8;
-
-	offset =3D fl->mcount_start - shdr.sh_addr;
-	count  =3D (fl->mcount_stop - fl->mcount_start) / addr_size;
-
-	data =3D elf_getdata(sec, 0);
-	if (!data) {
-		fprintf(stderr, "Failed to get section(%lu) data.\n",
-			fl->mcount_sec_idx);
-		return -1;
-	}
-
-	addrs =3D malloc(count * sizeof(addrs[0]));
-	if (!addrs) {
-		fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
-		return -1;
-	}
-
-	if (addr_size =3D=3D sizeof(__u64)) {
-		memcpy(addrs, data->d_buf + offset, count * addr_size);
-	} else {
-		for (i =3D 0; i < count; i++)
-			addrs[i] =3D (__u64) *((__u32 *) (data->d_buf + offset + i * addr_size)=
);
-	}
-
-	*paddrs =3D addrs;
-	*pcount =3D count;
-	return 0;
-}
-
-static int
-get_kmod_addrs(struct btf_elf *btfe, __u64 **paddrs, __u64 *pcount)
-{
-	__u64 *addrs, count;
-	unsigned int addr_size, i;
-	GElf_Shdr shdr_mcount;
-	Elf_Data *data;
-	Elf_Scn *sec;
-
-	/* Initialize for the sake of all error paths below. */
-	*paddrs =3D NULL;
-	*pcount =3D 0;
-
-	/* get __mcount_loc */
-	sec =3D elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr_mcount,
-				  "__mcount_loc", NULL);
-	if (!sec) {
-		if (btf_elf__verbose) {
-			printf("%s: '%s' doesn't have __mcount_loc section\n", __func__,
-			       btfe->filename);
-		}
-		return 0;
-	}
-
-	data =3D elf_getdata(sec, NULL);
-	if (!data) {
-		fprintf(stderr, "Failed to data for __mcount_loc section.\n");
-		return -1;
-	}
-
-	/* Get address size from processed file's ELF class. */
-	addr_size =3D gelf_getclass(btfe->elf) =3D=3D ELFCLASS32 ? 4 : 8;
-
-	count =3D data->d_size / addr_size;
-
-	addrs =3D malloc(count * sizeof(addrs[0]));
-	if (!addrs) {
-		fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
-		return -1;
-	}
-
-	if (addr_size =3D=3D sizeof(__u64)) {
-		memcpy(addrs, data->d_buf, count * addr_size);
-	} else {
-		for (i =3D 0; i < count; i++)
-			addrs[i] =3D (__u64) *((__u32 *) (data->d_buf + i * addr_size));
-	}
-
-	/*
-	 * We get Elf object from dwfl_module_getelf function,
-	 * which performs all possible relocations, including
-	 * __mcount_loc section.
-	 *
-	 * So addrs array now contains relocated values, which
-	 * we need take into account when we compare them to
-	 * functions values, see comment in setup_functions
-	 * function.
-	 */
-	*paddrs =3D addrs;
-	*pcount =3D count;
-	return 0;
-}
-
-static int is_ftrace_func(struct elf_function *func, __u64 *addrs, __u64 c=
ount)
-{
-	__u64 start =3D func->addr;
-	__u64 addr, end =3D func->addr + func->size;
-
-	/*
-	 * The invariant here is addr[r] that is the smallest address
-	 * that is >=3D than function start addr. Except the corner case
-	 * where there is no such r, but for that we have a final check
-	 * in the return.
-	 */
-	size_t l =3D 0, r =3D count - 1, m;
-
-	/* make sure we don't use invalid r */
-	if (count =3D=3D 0)
-		return false;
-
-	while (l < r) {
-		m =3D l + (r - l) / 2;
-		addr =3D addrs[m];
-
-		if (addr >=3D start) {
-			/* we satisfy invariant, so tighten r */
-			r =3D m;
-		} else {
-			/* m is not good enough as l, maybe m + 1 will be */
-			l =3D m + 1;
-		}
-	}
-
-	return start <=3D addrs[r] && addrs[r] < end;
-}
-
-static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
-{
-	__u64 *addrs, count, i;
-	int functions_valid =3D 0;
-	bool kmod =3D false;
-
-	/*
-	 * Check if we are processing vmlinux image and
-	 * get mcount data if it's detected.
-	 */
-	if (get_vmlinux_addrs(btfe, fl, &addrs, &count))
-		return -1;
-
-	/*
-	 * Check if we are processing kernel module and
-	 * get mcount data if it's detected.
-	 */
-	if (!addrs) {
-		if (get_kmod_addrs(btfe, &addrs, &count))
-			return -1;
-		kmod =3D true;
-	}
-
-	if (!addrs) {
-		if (btf_elf__verbose)
-			printf("ftrace symbols not detected, falling back to DWARF data\n");
-		delete_functions();
-		return 0;
-	}
-
-	qsort(addrs, count, sizeof(addrs[0]), addrs_cmp);
-	qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
-
-	/*
-	 * Let's got through all collected functions and filter
-	 * out those that are not in ftrace.
-	 */
-	for (i =3D 0; i < functions_cnt; i++) {
-		struct elf_function *func =3D &functions[i];
-		/*
-		 * For vmlinux image both addrs[x] and functions[x]::addr
-		 * values are final address and are comparable.
-		 *
-		 * For kernel module addrs[x] is final address, but
-		 * functions[x]::addr is relative address within section
-		 * and needs to be relocated by adding sh_addr.
-		 */
-		if (kmod)
-			func->addr +=3D func->sh_addr;
-
-		/* Make sure function is within ftrace addresses. */
-		if (is_ftrace_func(func, addrs, count)) {
-			/*
-			 * We iterate over sorted array, so we can easily skip
-			 * not valid item and move following valid field into
-			 * its place, and still keep the 'new' array sorted.
-			 */
-			if (i !=3D functions_valid)
-				functions[functions_valid] =3D functions[i];
-			functions_valid++;
-		}
-	}
-
-	functions_cnt =3D functions_valid;
-	free(addrs);
-
-	if (btf_elf__verbose)
-		printf("Found %d functions!\n", functions_cnt);
-	return 0;
-}
-
 static struct elf_function *find_function(const struct btf_elf *btfe,
 					  const char *name)
 {
@@ -620,23 +363,8 @@ static int collect_percpu_var(struct btf_elf *btfe, GE=
lf_Sym *sym,
 	return 0;
 }
=20
-static void collect_symbol(GElf_Sym *sym, struct funcs_layout *fl,
-			   size_t sym_sec_idx)
-{
-	if (!fl->mcount_start &&
-	    !strcmp("__start_mcount_loc", elf_sym__name(sym, btfe->symtab))) {
-		fl->mcount_start =3D sym->st_value;
-		fl->mcount_sec_idx =3D sym_sec_idx;
-	}
-
-	if (!fl->mcount_stop &&
-	    !strcmp("__stop_mcount_loc", elf_sym__name(sym, btfe->symtab)))
-		fl->mcount_stop =3D sym->st_value;
-}
-
 static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 {
-	struct funcs_layout fl =3D { };
 	Elf32_Word sym_sec_idx;
 	uint32_t core_id;
 	GElf_Sym sym;
@@ -648,9 +376,8 @@ static int collect_symbols(struct btf_elf *btfe, bool c=
ollect_percpu_vars)
 	elf_symtab__for_each_symbol_index(btfe->symtab, core_id, sym, sym_sec_idx=
) {
 		if (collect_percpu_vars && collect_percpu_var(btfe, &sym, sym_sec_idx))
 			return -1;
-		if (collect_function(btfe, &sym, sym_sec_idx))
+		if (collect_function(btfe, &sym))
 			return -1;
-		collect_symbol(&sym, &fl, sym_sec_idx);
 	}
=20
 	if (collect_percpu_vars) {
@@ -661,9 +388,11 @@ static int collect_symbols(struct btf_elf *btfe, bool =
collect_percpu_vars)
 			printf("Found %d per-CPU variables!\n", percpu_var_cnt);
 	}
=20
-	if (functions_cnt && setup_functions(btfe, &fl)) {
-		fprintf(stderr, "Failed to filter DWARF functions\n");
-		return -1;
+	if (functions_cnt) {
+		qsort(functions, functions_cnt, sizeof(functions[0]),
+		      functions_cmp);
+		if (btf_elf__verbose)
+			printf("Found %d functions!\n", functions_cnt);
 	}
=20
 	return 0;
--=20
2.30.2

