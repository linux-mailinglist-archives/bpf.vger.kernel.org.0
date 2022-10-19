Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0965E60371F
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 02:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJSAcU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 18 Oct 2022 20:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJSAcT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 20:32:19 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E00DBE78
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:32:17 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J049aA012668
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:32:17 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k9j40mcv6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:32:16 -0700
Received: from twshared26494.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 17:32:14 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 229B52051287A; Tue, 18 Oct 2022 17:32:06 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 1/3] libbpf: clean up and refactor BTF fixup step
Date:   Tue, 18 Oct 2022 17:28:14 -0700
Message-ID: <20221019002816.359650-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019002816.359650-1-andrii@kernel.org>
References: <20221019002816.359650-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CGNcE1GT5DTke0qjBuo2PvehyHBXZfxH
X-Proofpoint-GUID: CGNcE1GT5DTke0qjBuo2PvehyHBXZfxH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_09,2022-10-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor libbpf's BTF fixup step during BPF object open phase. The only
functional change is that we now ignore BTF_VAR_GLOBAL_EXTERN variables
during fix up, not just BTF_VAR_STATIC ones, which shouldn't cause any
change in behavior as there shouldn't be any extern variable in data
sections for valid BPF object anyways.

Otherwise it's just collapsing two functions that have no reason to be
separate, and switching find_elf_var_offset() helper to return entire
symbol pointer, not just its offset. This will be used by next patch to
get ELF symbol visibility.

While refactoring, also "normalize" debug messages inside
btf_fixup_datasec() to follow general libbpf style and print out data
section name consistently, where it's available.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 96 ++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 54 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8c3f236c86e4..8802e06c5569 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1461,15 +1461,12 @@ static int find_elf_sec_sz(const struct bpf_object *obj, const char *name, __u32
 	return -ENOENT;
 }
 
-static int find_elf_var_offset(const struct bpf_object *obj, const char *name, __u32 *off)
+static Elf64_Sym *find_elf_var_sym(const struct bpf_object *obj, const char *name)
 {
 	Elf_Data *symbols = obj->efile.symbols;
 	const char *sname;
 	size_t si;
 
-	if (!name || !off)
-		return -EINVAL;
-
 	for (si = 0; si < symbols->d_size / sizeof(Elf64_Sym); si++) {
 		Elf64_Sym *sym = elf_sym_by_idx(obj, si);
 
@@ -1483,15 +1480,13 @@ static int find_elf_var_offset(const struct bpf_object *obj, const char *name, _
 		sname = elf_sym_str(obj, sym->st_name);
 		if (!sname) {
 			pr_warn("failed to get sym name string for var %s\n", name);
-			return -EIO;
-		}
-		if (strcmp(name, sname) == 0) {
-			*off = sym->st_value;
-			return 0;
+			return ERR_PTR(-EIO);
 		}
+		if (strcmp(name, sname) == 0)
+			return sym;
 	}
 
-	return -ENOENT;
+	return ERR_PTR(-ENOENT);
 }
 
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
@@ -2850,57 +2845,63 @@ static int compare_vsi_off(const void *_a, const void *_b)
 static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 			     struct btf_type *t)
 {
-	__u32 size = 0, off = 0, i, vars = btf_vlen(t);
-	const char *name = btf__name_by_offset(btf, t->name_off);
-	const struct btf_type *t_var;
+	__u32 size = 0, i, vars = btf_vlen(t);
+	const char *sec_name = btf__name_by_offset(btf, t->name_off);
 	struct btf_var_secinfo *vsi;
-	const struct btf_var *var;
-	int ret;
+	int err;
 
-	if (!name) {
+	if (!sec_name) {
 		pr_debug("No name found in string section for DATASEC kind.\n");
 		return -ENOENT;
 	}
 
-	/* .extern datasec size and var offsets were set correctly during
-	 * extern collection step, so just skip straight to sorting variables
+	/* extern-backing datasecs (.ksyms, .kconfig) have their size and
+	 * variable offsets set at the previous step, so we skip any fixups
+	 * for such sections
 	 */
 	if (t->size)
 		goto sort_vars;
 
-	ret = find_elf_sec_sz(obj, name, &size);
-	if (ret || !size) {
-		pr_debug("Invalid size for section %s: %u bytes\n", name, size);
+	err = find_elf_sec_sz(obj, sec_name, &size);
+	if (err || !size) {
+		pr_debug("sec '%s': failed to determine size from ELF: size %u, err %d\n",
+			 sec_name, size, err);
 		return -ENOENT;
 	}
 
 	t->size = size;
 
 	for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
+		const struct btf_type *t_var;
+		struct btf_var *var;
+		const char *var_name;
+		Elf64_Sym *sym;
+
 		t_var = btf__type_by_id(btf, vsi->type);
 		if (!t_var || !btf_is_var(t_var)) {
-			pr_debug("Non-VAR type seen in section %s\n", name);
+			pr_debug("sec '%s': unexpected non-VAR type found\n", sec_name);
 			return -EINVAL;
 		}
 
 		var = btf_var(t_var);
-		if (var->linkage == BTF_VAR_STATIC)
+		if (var->linkage == BTF_VAR_STATIC || var->linkage == BTF_VAR_GLOBAL_EXTERN)
 			continue;
 
-		name = btf__name_by_offset(btf, t_var->name_off);
-		if (!name) {
-			pr_debug("No name found in string section for VAR kind\n");
+		var_name = btf__name_by_offset(btf, t_var->name_off);
+		if (!var_name) {
+			pr_debug("sec '%s': failed to find name of DATASEC's member #%d\n",
+				 sec_name, i);
 			return -ENOENT;
 		}
 
-		ret = find_elf_var_offset(obj, name, &off);
-		if (ret) {
-			pr_debug("No offset found in symbol table for VAR %s\n",
-				 name);
+		sym = find_elf_var_sym(obj, var_name);
+		if (IS_ERR(sym)) {
+			pr_debug("sec '%s': failed to find ELF symbol for VAR '%s'\n",
+				 sec_name, var_name);
 			return -ENOENT;
 		}
 
-		vsi->offset = off;
+		vsi->offset = sym->st_value;
 	}
 
 sort_vars:
@@ -2908,13 +2909,16 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 	return 0;
 }
 
-static int btf_finalize_data(struct bpf_object *obj, struct btf *btf)
+static int bpf_object_fixup_btf(struct bpf_object *obj)
 {
-	int err = 0;
-	__u32 i, n = btf__type_cnt(btf);
+	int i, n, err = 0;
 
+	if (!obj->btf)
+		return 0;
+
+	n = btf__type_cnt(obj->btf);
 	for (i = 1; i < n; i++) {
-		struct btf_type *t = btf_type_by_id(btf, i);
+		struct btf_type *t = btf_type_by_id(obj->btf, i);
 
 		/* Loader needs to fix up some of the things compiler
 		 * couldn't get its hands on while emitting BTF. This
@@ -2922,28 +2926,12 @@ static int btf_finalize_data(struct bpf_object *obj, struct btf *btf)
 		 * the info from the ELF itself for this purpose.
 		 */
 		if (btf_is_datasec(t)) {
-			err = btf_fixup_datasec(obj, btf, t);
+			err = btf_fixup_datasec(obj, obj->btf, t);
 			if (err)
-				break;
+				return err;
 		}
 	}
 
-	return libbpf_err(err);
-}
-
-static int bpf_object__finalize_btf(struct bpf_object *obj)
-{
-	int err;
-
-	if (!obj->btf)
-		return 0;
-
-	err = btf_finalize_data(obj, obj->btf);
-	if (err) {
-		pr_warn("Error finalizing %s: %d.\n", BTF_ELF_SEC, err);
-		return err;
-	}
-
 	return 0;
 }
 
@@ -7233,7 +7221,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	err = err ? : bpf_object__check_endianness(obj);
 	err = err ? : bpf_object__elf_collect(obj);
 	err = err ? : bpf_object__collect_externs(obj);
-	err = err ? : bpf_object__finalize_btf(obj);
+	err = err ? : bpf_object_fixup_btf(obj);
 	err = err ? : bpf_object__init_maps(obj, opts);
 	err = err ? : bpf_object_init_progs(obj, opts);
 	err = err ? : bpf_object__collect_relos(obj);
-- 
2.30.2

