Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D9827DF7C
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 06:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgI3E2R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 00:28:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26514 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbgI3E2R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 00:28:17 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U4Plgr003642
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jMWzajsOzYPyL+veJikMgTzCQD8avh8xXgYd/cqVjl0=;
 b=mOSfltDeceLEbnGJtJqQuwdLvcri6VLVgQUb2e0hnhreCgrUABlk4LyIIUm8qdgoMMRb
 bT3OpalYL1/oHt7sUf2WV4AvDH1naD2hx8vfQ1gV4RbnpNtqzstHrkmN1/kZ3NogCF2v
 xIvDxRdA5cSK6GLmhyib6WNCugKZlYXKDtY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33tn4tpgwx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:15 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:28:13 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 618BA2EC77F1; Tue, 29 Sep 2020 21:28:09 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 08/11] btf_encoder: revamp how per-CPU variables are encoded
Date:   Tue, 29 Sep 2020 21:27:39 -0700
Message-ID: <20200930042742.2525310-9-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930042742.2525310-1-andriin@fb.com>
References: <20200930042742.2525310-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 adultscore=0
 suspectscore=13 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Right now to encode per-CPU variables in BTF, pahole iterates complete vm=
linux
symbol table for each CU. There are 2500 CUs for a typical kernel image.
Overall, to encode 287 per-CPU variables pahole spends more than 10% of i=
ts CPU
budget, this is incredibly wasteful.

This patch revamps how this is done. Now it pre-processes symbol table on=
ce
before any of per-CU processing starts. It remembers each per-CPU variabl=
e
symbol, including its address, size, and name. Then during processing eac=
h CU,
binary search is used to correlate DWARF variable with per-CPU symbols an=
d
figure out if variable belongs to per-CPU data section. If the match is f=
ound,
BTF_KIND_VAR is emitted and var_secinfo is recorded, just like before. At=
 the
very end, after all CUs are processed, BTF_KIND_DATASEC is emitted with s=
orted
variables.

This change makes per-CPU variables generation overhead pretty negligible=
 and
returns back about 10% of CPU usage.

Performance counter stats for './pahole -J /home/andriin/linux-build/defa=
ult/vmlinux':

BEFORE:
      19.160149000 seconds user
       1.304873000 seconds sys

         24,114.05 msec task-clock                #    0.999 CPUs utilize=
d
                83      context-switches          #    0.003 K/sec
                 0      cpu-migrations            #    0.000 K/sec
           622,417      page-faults               #    0.026 M/sec
    72,897,315,125      cycles                    #    3.023 GHz         =
             (25.02%)
   127,807,316,959      instructions              #    1.75  insn per cyc=
le           (25.01%)
    29,087,179,117      branches                  # 1206.234 M/sec       =
             (25.01%)
       464,105,921      branch-misses             #    1.60% of all branc=
hes          (25.01%)
    30,252,119,368      L1-dcache-loads           # 1254.543 M/sec       =
             (25.01%)
     1,156,336,207      L1-dcache-load-misses     #    3.82% of all L1-dc=
ache hits    (25.05%)
       343,373,503      LLC-loads                 #   14.240 M/sec       =
             (25.02%)
        12,044,977      LLC-load-misses           #    3.51% of all LL-ca=
che hits     (25.01%)

      24.136198321 seconds time elapsed

      22.729693000 seconds user
       1.384859000 seconds sys

AFTER:
      16.781455000 seconds user
       1.343956000 seconds sys

         23,398.77 msec task-clock                #    1.000 CPUs utilize=
d
                86      context-switches          #    0.004 K/sec
                 0      cpu-migrations            #    0.000 K/sec
           622,420      page-faults               #    0.027 M/sec
    68,395,641,468      cycles                    #    2.923 GHz         =
             (25.05%)
   114,241,327,034      instructions              #    1.67  insn per cyc=
le           (25.01%)
    26,330,711,718      branches                  # 1125.303 M/sec       =
             (25.01%)
       465,926,869      branch-misses             #    1.77% of all branc=
hes          (25.00%)
    24,662,984,772      L1-dcache-loads           # 1054.029 M/sec       =
             (25.00%)
     1,054,052,064      L1-dcache-load-misses     #    4.27% of all L1-dc=
ache hits    (25.00%)
       340,970,622      LLC-loads                 #   14.572 M/sec       =
             (25.00%)
        16,032,297      LLC-load-misses           #    4.70% of all LL-ca=
che hits     (25.03%)

      23.402259654 seconds time elapsed

      21.916437000 seconds user
       1.482826000 seconds sys

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 btf_encoder.c | 239 +++++++++++++++++++++++++++++---------------------
 libbtf.c      |   6 +-
 libbtf.h      |   1 +
 3 files changed, 142 insertions(+), 104 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 91b68694bca5..a6be35b2daac 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -17,6 +17,7 @@
 #include "btf_encoder.h"
=20
 #include <ctype.h> /* for isalpha() and isalnum() */
+#include <stdlib.h> /* for qsort() and bsearch() */
 #include <inttypes.h>
=20
 /*
@@ -53,17 +54,17 @@ static bool btf_name_valid(const char *p)
 	return !*p;
 }
=20
-static void dump_invalid_symbol(const char *msg, const char *sym, const =
char *cu,
+static void dump_invalid_symbol(const char *msg, const char *sym,
 				int verbose, bool force)
 {
 	if (force) {
 		if (verbose)
-			fprintf(stderr, "PAHOLE: Warning: %s, ignored (sym: '%s', cu: '%s').\=
n",
-				msg, sym, cu);
+			fprintf(stderr, "PAHOLE: Warning: %s, ignored (sym: '%s').\n",
+				msg, sym);
 		return;
 	}
=20
-	fprintf(stderr, "PAHOLE: Error: %s (sym: '%s', cu: '%s').\n", msg, sym,=
 cu);
+	fprintf(stderr, "PAHOLE: Error: %s (sym: '%s').\n", msg, sym);
 	fprintf(stderr, "PAHOLE: Error: Use '-j' or '--force' to ignore such sy=
mbols and force emit the btf.\n");
 }
=20
@@ -202,6 +203,9 @@ int btf_encoder__encode()
 {
 	int err;
=20
+	if (gobuffer__size(&btfe->percpu_secinfo) !=3D 0)
+		btf_elf__add_datasec_type(btfe, PERCPU_SECTION, &btfe->percpu_secinfo)=
;
+
 	err =3D btf_elf__encode(btfe, 0);
 	btf_elf__delete(btfe);
 	btfe =3D NULL;
@@ -209,24 +213,117 @@ int btf_encoder__encode()
 	return err;
 }
=20
-#define HASHADDR__BITS 8
-#define HASHADDR__SIZE (1UL << HASHADDR__BITS)
-#define hashaddr__fn(key) hash_64(key, HASHADDR__BITS)
+#define MAX_PERCPU_VAR_CNT 4096
+
+struct var_info {
+	uint64_t addr;
+	uint32_t sz;
+	const char *name;
+};
+
+static struct var_info percpu_vars[MAX_PERCPU_VAR_CNT];
+static int percpu_var_cnt;
+
+static int percpu_var_cmp(const void *_a, const void *_b)
+{
+	const struct var_info *a =3D _a;
+	const struct var_info *b =3D _b;
+
+	if (a->addr =3D=3D b->addr)
+		return 0;
+	return a->addr < b->addr ? -1 : 1;
+}
+
+static bool percpu_var_exists(uint64_t addr, uint32_t *sz, const char **=
name)
+{
+	const struct var_info *p;
+	struct var_info key =3D { .addr =3D addr };
+
+	p =3D bsearch(&key, percpu_vars, percpu_var_cnt,
+		    sizeof(percpu_vars[0]), percpu_var_cmp);
+
+	if (!p)
+		return false;
+
+	*sz =3D p->sz;
+	*name =3D p->name;
+	return true;
+}
=20
-static struct variable *hashaddr__find_variable(const struct hlist_head =
hashtable[],
-						const uint64_t addr)
+static int find_all_percpu_vars(struct btf_elf *btfe)
 {
-	struct variable *variable;
-	struct hlist_node *pos;
-	uint16_t bucket =3D hashaddr__fn(addr);
-	const struct hlist_head *head =3D &hashtable[bucket];
-
-	hlist_for_each_entry(variable, pos, head, tool_hnode) {
-		if (variable->ip.addr =3D=3D addr)
-			return variable;
+	uint32_t core_id;
+	GElf_Sym sym;
+
+	/* cache variables' addresses, preparing for searching in symtab. */
+	percpu_var_cnt =3D 0;
+
+	/* search within symtab for percpu variables */
+	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
+		const char *sym_name;
+		uint64_t addr;
+		uint32_t size;
+
+		/* compare a symbol's shndx to determine if it's a percpu variable */
+		if (elf_sym__section(&sym) !=3D btfe->percpu_shndx)
+			continue;
+		if (elf_sym__type(&sym) !=3D STT_OBJECT)
+			continue;
+
+		addr =3D elf_sym__value(&sym);
+		/*
+		 * Store only those symbols that have allocated space in the percpu se=
ction.
+		 * This excludes the following three types of symbols:
+		 *
+		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
+		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique id=
s.
+		 *  3. __exitcall(fn), functions which are labeled as exit calls.
+		 *
+		 * In addition, the variables defined using DEFINE_PERCPU_FIRST are
+		 * also not included, which currently includes:
+		 *
+		 *  1. fixed_percpu_data
+		 */
+		if (!addr)
+			continue;
+
+		sym_name =3D elf_sym__name(&sym, btfe->symtab);
+		if (!btf_name_valid(sym_name)) {
+			dump_invalid_symbol("Found symbol of invalid name when encoding btf",
+					    sym_name, btf_elf__verbose, btf_elf__force);
+			if (btf_elf__force)
+				continue;
+			return -1;
+		}
+		size =3D elf_sym__size(&sym);
+		if (!size) {
+			dump_invalid_symbol("Found symbol of zero size when encoding btf",
+					    sym_name, btf_elf__verbose, btf_elf__force);
+			if (btf_elf__force)
+				continue;
+			return -1;
+		}
+
+		if (btf_elf__verbose)
+			printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr=
);
+
+		if (percpu_var_cnt =3D=3D MAX_PERCPU_VAR_CNT) {
+			fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
+				MAX_PERCPU_VAR_CNT);
+			return -1;
+		}
+		percpu_vars[percpu_var_cnt].addr =3D addr;
+		percpu_vars[percpu_var_cnt].sz =3D size;
+		percpu_vars[percpu_var_cnt].name =3D sym_name;
+		percpu_var_cnt++;
 	}
=20
-	return NULL;
+	if (percpu_var_cnt)
+		qsort(percpu_vars, percpu_var_cnt, sizeof(percpu_vars[0]), percpu_var_=
cmp);
+
+	if (btf_elf__verbose)
+		printf("Found %d per-CPU variables!\n", percpu_var_cnt);
+	return 0;
 }
=20
 int cu__encode_btf(struct cu *cu, int verbose, bool force,
@@ -234,13 +331,10 @@ int cu__encode_btf(struct cu *cu, int verbose, bool=
 force,
 {
 	uint32_t type_id_off;
 	uint32_t core_id;
+	struct variable *var;
 	struct function *fn;
 	struct tag *pos;
 	int err =3D 0;
-	struct hlist_head hash_addr[HASHADDR__SIZE];
-	struct variable *var;
-	bool has_global_var =3D false;
-	GElf_Sym sym;
=20
 	if (btfe && strcmp(btfe->filename, cu->filename)) {
 		err =3D btf_encoder__encode();
@@ -257,6 +351,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool f=
orce,
 		if (!btfe)
 			return -1;
=20
+		if (!skip_encoding_vars && find_all_percpu_vars(btfe))
+			goto out;
+
 		has_index_type =3D false;
 		need_index_type =3D false;
 		array_index_id =3D 0;
@@ -278,6 +375,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool f=
orce,
 	}
=20
 	btf_elf__verbose =3D verbose;
+	btf_elf__force =3D force;
 	type_id_off =3D btf__get_nr_types(btfe->btf);
=20
 	cu__for_each_type(cu, core_id, pos) {
@@ -325,12 +423,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool=
 force,
 	if (verbose)
 		printf("search cu '%s' for percpu global variables.\n", cu->name);
=20
-	/* cache variables' addresses, preparing for searching in symtab. */
-	for (core_id =3D 0; core_id < HASHADDR__SIZE; ++core_id)
-		INIT_HLIST_HEAD(&hash_addr[core_id]);
-
 	cu__for_each_variable(cu, core_id, pos) {
-		struct hlist_head *head;
+		uint32_t size, type, linkage, offset;
+		const char *name;
+		uint64_t addr;
+		int id;
=20
 		var =3D tag__variable(pos);
 		if (var->declaration)
@@ -338,79 +435,24 @@ int cu__encode_btf(struct cu *cu, int verbose, bool=
 force,
 		/* percpu variables are allocated in global space */
 		if (variable__scope(var) !=3D VSCOPE_GLOBAL)
 			continue;
-		has_global_var =3D true;
-		head =3D &hash_addr[hashaddr__fn(var->ip.addr)];
-		hlist_add_head(&var->tool_hnode, head);
-	}
-	if (!has_global_var) {
-		if (verbose)
-			printf("cu has no global variable defined, skip.\n");
-		goto out;
-	}
-
-	/* search within symtab for percpu variables */
-	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
-		uint32_t linkage, type, size, offset;
-		int32_t btf_var_id, btf_var_secinfo_id;
-		uint64_t addr;
-		const char *sym_name;
-
-		/* compare a symbol's shndx to determine if it's a percpu variable */
-		if (elf_sym__section(&sym) !=3D btfe->percpu_shndx)
-			continue;
-		if (elf_sym__type(&sym) !=3D STT_OBJECT)
-			continue;
=20
-		addr =3D elf_sym__value(&sym);
-		/*
-		 * Store only those symbols that have allocated space in the percpu se=
ction.
-		 * This excludes the following three types of symbols:
-		 *
-		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
-		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique id=
s.
-		 *  3. __exitcall(fn), functions which are labeled as exit calls.
-		 *
-		 * In addition, the variables defined using DEFINE_PERCPU_FIRST are
-		 * also not included, which currently includes:
-		 *
-		 *  1. fixed_percpu_data
-		 */
-		if (!addr)
-			continue;
-		var =3D hashaddr__find_variable(hash_addr, addr);
-		if (var =3D=3D NULL)
-			continue;
-
-		sym_name =3D elf_sym__name(&sym, btfe->symtab);
-		if (!btf_name_valid(sym_name)) {
-			dump_invalid_symbol("Found symbol of invalid name when encoding btf",
-					    sym_name, cu->name, verbose, force);
-			if (force)
-				continue;
-			err =3D -1;
-			break;
-		}
 		type =3D var->ip.tag.type + type_id_off;
-		size =3D elf_sym__size(&sym);
-		if (!size) {
-			dump_invalid_symbol("Found symbol of zero size when encoding btf",
-					    sym_name, cu->name, verbose, force);
-			if (force)
-				continue;
-			err =3D -1;
-			break;
-		}
+		addr =3D var->ip.addr;
+		linkage =3D var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
+		if (!percpu_var_exists(addr, &size, &name))
+			continue; /* not a per-CPU variable */
=20
-		if (verbose)
-			printf("symbol '%s' of address 0x%lx encoded\n",
-			       sym_name, addr);
+		if (btf_elf__verbose) {
+			printf("Variable '%s' from CI '%s' at address 0x%lx encoded\n",
+			       name, cu->name, addr);
+		}
=20
 		/* add a BTF_KIND_VAR in btfe->types */
-		linkage =3D var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
-		btf_var_id =3D btf_elf__add_var_type(btfe, type, sym_name, linkage);
-		if (btf_var_id < 0) {
+		id =3D btf_elf__add_var_type(btfe, type, name, linkage);
+		if (id < 0) {
 			err =3D -1;
-			printf("error: failed to encode variable '%s'\n", sym_name);
+			fprintf(stderr, "error: failed to encode variable '%s' at addr 0x%lx\=
n",
+			        name, addr);
 			break;
 		}
=20
@@ -418,13 +460,12 @@ int cu__encode_btf(struct cu *cu, int verbose, bool=
 force,
 		 * add a BTF_VAR_SECINFO in btfe->percpu_secinfo, which will be added =
into
 		 * btfe->types later when we add BTF_VAR_DATASEC.
 		 */
-		type =3D btf_var_id;
 		offset =3D addr - btfe->percpu_base_addr;
-		btf_var_secinfo_id =3D btf_elf__add_var_secinfo(&btfe->percpu_secinfo,
-							      type, offset, size);
-		if (btf_var_secinfo_id < 0) {
+		id =3D btf_elf__add_var_secinfo(&btfe->percpu_secinfo, id, offset, siz=
e);
+		if (id < 0) {
 			err =3D -1;
-			printf("error: failed to encode var secinfo '%s'\n", sym_name);
+			fprintf(stderr, "error: failed to encode section info for variable '%=
s' at addr 0x%lx\n",
+			        name, addr);
 			break;
 		}
 	}
diff --git a/libbtf.c b/libbtf.c
index d74e4eb03393..4829651b76c4 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -28,6 +28,7 @@
 #include "elf_symtab.h"
=20
 uint8_t btf_elf__verbose;
+uint8_t btf_elf__force;
=20
 static int btf_var_secinfo_cmp(const void *a, const void *b)
 {
@@ -62,7 +63,6 @@ int btf_elf__load(struct btf_elf *btfe)
 	return 0;
 }
=20
-
 struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
 {
 	struct btf_elf *btfe =3D zalloc(sizeof(*btfe));
@@ -768,10 +768,6 @@ int btf_elf__encode(struct btf_elf *btfe, uint8_t fl=
ags)
 {
 	struct btf *btf =3D btfe->btf;
=20
-	if (gobuffer__size(&btfe->percpu_secinfo) !=3D 0)
-		btf_elf__add_datasec_type(btfe, PERCPU_SECTION,
-					  &btfe->percpu_secinfo);
-
 	/* Empty file, nothing to do, so... done! */
 	if (btf__get_nr_types(btf) =3D=3D 0)
 		return 0;
diff --git a/libbtf.h b/libbtf.h
index 9b3d396da31f..887b5bc55c8e 100644
--- a/libbtf.h
+++ b/libbtf.h
@@ -30,6 +30,7 @@ struct btf_elf {
 };
=20
 extern uint8_t btf_elf__verbose;
+extern uint8_t btf_elf__force;
 #define btf_elf__verbose_log(fmt, ...) { if (btf_elf__verbose) printf(fm=
t, __VA_ARGS__); }
=20
 #define PERCPU_SECTION ".data..percpu"
--=20
2.24.1

