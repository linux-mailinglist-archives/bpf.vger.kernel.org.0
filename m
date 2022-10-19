Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8AB60371E
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 02:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJSAcQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 18 Oct 2022 20:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJSAcQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 20:32:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3DDDBE41
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:32:14 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J048JG021928
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:32:14 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k9d1jyrps-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:32:14 -0700
Received: from twshared1458.22.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 17:32:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 30F822051287E; Tue, 18 Oct 2022 17:32:08 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 2/3] libbpf: only add BPF_F_MMAPABLE flag for data maps with global vars
Date:   Tue, 18 Oct 2022 17:28:15 -0700
Message-ID: <20221019002816.359650-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019002816.359650-1-andrii@kernel.org>
References: <20221019002816.359650-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: g5tn8eCMvudar25sssUzjLZVKjdWxMUP
X-Proofpoint-GUID: g5tn8eCMvudar25sssUzjLZVKjdWxMUP
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

Teach libbpf to not add BPF_F_MMAPABLE flag unnecessarily for ARRAY maps
that are backing data sections, if such data sections don't expose any
variables to user-space. Exposed variables are those that have
STB_GLOBAL or STB_WEAK ELF binding and correspond to BTF VAR's
BTF_VAR_GLOBAL_ALLOCATED linkage.

The overall idea is that if some data section doesn't have any variable that
is exposed through BPF skeleton, then there is no reason to make such
BPF array mmapable. Making BPF array mmapable is not a free no-op
action, because BPF verifier doesn't allow users to put special objects
(such as BPF spin locks, RB tree nodes, linked list nodes, kptrs, etc;
anything that has a sensitive internal state that should not be modified
arbitrarily from user space) into mmapable arrays, as there is no way to
prevent user space from corrupting such sensitive state through direct
memory access through memory-mapped region.

By making sure that libbpf doesn't add BPF_F_MMAPABLE flag to BPF array
maps corresponding to data sections that only have static variables
(which are not supposed to be visible to user space according to libbpf
and BPF skeleton rules), users now can have spinlocks, kptrs, etc in
either default .bss/.data sections or custom .data.* sections (assuming
there are no global variables in such sections).

The only possible hiccup with this approach is the need to use global
variables during BPF static linking, even if it's not intended to be
shared with user space through BPF skeleton. To allow such scenarios,
extend libbpf's STV_HIDDEN ELF visibility attribute handling to
variables. Libbpf is already treating global hidden BPF subprograms as
static subprograms and adjusts BTF accordingly to make BPF verifier
verify such subprograms as static subprograms with preserving entire BPF
verifier state between subprog calls. This patch teaches libbpf to treat
global hidden variables as static ones and adjust BTF information
accordingly as well. This allows to share variables between multiple
object files during static linking, but still keep them internal to BPF
program and not get them exposed through BPF skeleton.

Note, that if the user has some advanced scenario where they absolutely
need BPF_F_MMAPABLE flag on .data/.bss/.rodata BPF array map despite
only having static variables, they still can achieve this by forcing it
through explicit bpf_map__set_map_flags() API.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 97 +++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8802e06c5569..027fd9565c16 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1577,7 +1577,38 @@ static char *internal_map_name(struct bpf_object *obj, const char *real_name)
 }
 
 static int
-bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map);
+map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map *map);
+
+/* Internal BPF map is mmap()'able only if at least one of corresponding
+ * DATASEC's VARs are to be exposed through BPF skeleton. I.e., it's a GLOBAL
+ * variable and it's not marked as __hidden (which turns it into, effectively,
+ * a STATIC variable).
+ */
+static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
+{
+	const struct btf_type *t, *vt;
+	struct btf_var_secinfo *vsi;
+	int i, n;
+
+	if (!map->btf_value_type_id)
+		return false;
+
+	t = btf__type_by_id(obj->btf, map->btf_value_type_id);
+	if (!btf_is_datasec(t))
+		return false;
+
+	vsi = btf_var_secinfos(t);
+	for (i = 0, n = btf_vlen(t); i < n; i++, vsi++) {
+		vt = btf__type_by_id(obj->btf, vsi->type);
+		if (!btf_is_var(vt))
+			continue;
+
+		if (btf_var(vt)->linkage != BTF_VAR_STATIC)
+			return true;
+	}
+
+	return false;
+}
 
 static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
@@ -1609,7 +1640,12 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	def->max_entries = 1;
 	def->map_flags = type == LIBBPF_MAP_RODATA || type == LIBBPF_MAP_KCONFIG
 			 ? BPF_F_RDONLY_PROG : 0;
-	def->map_flags |= BPF_F_MMAPABLE;
+
+	/* failures are fine because of maps like .rodata.str1.1 */
+	(void) map_fill_btf_type_info(obj, map);
+
+	if (map_is_mmapable(obj, map))
+		def->map_flags |= BPF_F_MMAPABLE;
 
 	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
 		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
@@ -1626,9 +1662,6 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 		return err;
 	}
 
-	/* failures are fine because of maps like .rodata.str1.1 */
-	(void) bpf_map_find_btf_info(obj, map);
-
 	if (data)
 		memcpy(map->mmaped, data, data_sz);
 
@@ -2540,7 +2573,7 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 		fill_map_from_def(map->inner_map, &inner_def);
 	}
 
-	err = bpf_map_find_btf_info(obj, map);
+	err = map_fill_btf_type_info(obj, map);
 	if (err)
 		return err;
 
@@ -2848,6 +2881,7 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 	__u32 size = 0, i, vars = btf_vlen(t);
 	const char *sec_name = btf__name_by_offset(btf, t->name_off);
 	struct btf_var_secinfo *vsi;
+	bool fixup_offsets = false;
 	int err;
 
 	if (!sec_name) {
@@ -2855,21 +2889,34 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 		return -ENOENT;
 	}
 
-	/* extern-backing datasecs (.ksyms, .kconfig) have their size and
-	 * variable offsets set at the previous step, so we skip any fixups
-	 * for such sections
+	/* Extern-backing datasecs (.ksyms, .kconfig) have their size and
+	 * variable offsets set at the previous step. Further, not every
+	 * extern BTF VAR has corresponding ELF symbol preserved, so we skip
+	 * all fixups altogether for such sections and go straight to sorting
+	 * VARs within their DATASEC.
 	 */
-	if (t->size)
+	if (strcmp(sec_name, KCONFIG_SEC) == 0 || strcmp(sec_name, KSYMS_SEC) == 0)
 		goto sort_vars;
 
-	err = find_elf_sec_sz(obj, sec_name, &size);
-	if (err || !size) {
-		pr_debug("sec '%s': failed to determine size from ELF: size %u, err %d\n",
-			 sec_name, size, err);
-		return -ENOENT;
-	}
+	/* Clang leaves DATASEC size and VAR offsets as zeroes, so we need to
+	 * fix this up. But BPF static linker already fixes this up and fills
+	 * all the sizes and offsets during static linking. So this step has
+	 * to be optional. But the STV_HIDDEN handling is non-optional for any
+	 * non-extern DATASEC, so the variable fixup loop below handles both
+	 * functions at the same time, paying the cost of BTF VAR <-> ELF
+	 * symbol matching just once.
+	 */
+	if (t->size == 0) {
+		err = find_elf_sec_sz(obj, sec_name, &size);
+		if (err || !size) {
+			pr_debug("sec '%s': failed to determine size from ELF: size %u, err %d\n",
+				 sec_name, size, err);
+			return -ENOENT;
+		}
 
-	t->size = size;
+		t->size = size;
+		fixup_offsets = true;
+	}
 
 	for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
 		const struct btf_type *t_var;
@@ -2901,7 +2948,19 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 			return -ENOENT;
 		}
 
-		vsi->offset = sym->st_value;
+		if (fixup_offsets)
+			vsi->offset = sym->st_value;
+
+		/* if variable is a global/weak symbol, but has restricted
+		 * (STV_HIDDEN or STV_INTERNAL) visibility, mark its BTF VAR
+		 * as static. This follows similar logic for functions (BPF
+		 * subprogs) and influences libbpf's further decisions about
+		 * whether to make global data BPF array maps as
+		 * BPF_F_MMAPABLE.
+		 */
+		if (ELF64_ST_VISIBILITY(sym->st_other) == STV_HIDDEN
+		    || ELF64_ST_VISIBILITY(sym->st_other) == STV_INTERNAL)
+			var->linkage = BTF_VAR_STATIC;
 	}
 
 sort_vars:
@@ -4223,7 +4282,7 @@ bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr, Elf_Dat
 	return 0;
 }
 
-static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map)
+static int map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map *map)
 {
 	int id;
 
-- 
2.30.2

