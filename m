Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAE5512A5A
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 06:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbiD1ES7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 28 Apr 2022 00:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242681AbiD1ES5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 00:18:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA842A26D
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:42 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RLlRZ2025088
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:41 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fprsrsr1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 21:15:41 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 21:15:41 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C160F192F88D9; Wed, 27 Apr 2022 21:15:30 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/4] libbpf: allow to opt-out from creating BPF maps
Date:   Wed, 27 Apr 2022 21:15:22 -0700
Message-ID: <20220428041523.4089853-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428041523.4089853-1-andrii@kernel.org>
References: <20220428041523.4089853-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yQ57rzOaZMSimYzMIkA1BnN3Cw7H5ZvU
X-Proofpoint-GUID: yQ57rzOaZMSimYzMIkA1BnN3Cw7H5ZvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_map__set_autocreate() API that allows user to opt-out from
libbpf automatically creating BPF map during BPF object load.

This is a useful feature when building CO-RE-enabled BPF application
that takes advantage of some new-ish BPF map type (e.g., socket-local
storage) if kernel supports it, but otherwise uses some alternative way
(e.g., extra HASH map). In such case, being able to disable the creation
of a map that kernel doesn't support allows to successfully create and
load BPF object file with all its other maps and programs.

It's still up to user to make sure that no "live" code in any of their BPF
programs are referencing such map instance, which can be achieved by
guarding such code with CO-RE relocation check or by using .rodata
global variables.

If user fails to properly guard such code to turn it into "dead code",
libbpf will helpfully post-process BPF verifier log and will provide
more meaningful error and map name that needs to be guarded properly. As
such, instead of:

  ; value = bpf_map_lookup_elem(&missing_map, &zero);
  4: (85) call unknown#2001000000
  invalid func unknown#2001000000

... user will see:

  ; value = bpf_map_lookup_elem(&missing_map, &zero);
  4: <invalid BPF map reference>
  BPF map 'missing_map' is referenced but wasn't created

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 124 ++++++++++++++++++++++++++++++++++-----
 tools/lib/bpf/libbpf.h   |  22 +++++++
 tools/lib/bpf/libbpf.map |   4 +-
 3 files changed, 133 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ee43719a0376..ad6f8669234a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -357,6 +357,7 @@ enum libbpf_map_type {
 };
 
 struct bpf_map {
+	struct bpf_object *obj;
 	char *name;
 	/* real_name is defined for special internal maps (.rodata*,
 	 * .data*, .bss, .kconfig) and preserves their original ELF section
@@ -386,7 +387,7 @@ struct bpf_map {
 	char *pin_path;
 	bool pinned;
 	bool reused;
-	bool skipped;
+	bool autocreate;
 	__u64 map_extra;
 };
 
@@ -1442,8 +1443,10 @@ static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
 		return ERR_PTR(err);
 
 	map = &obj->maps[obj->nr_maps++];
+	map->obj = obj;
 	map->fd = -1;
 	map->inner_map_fd = -1;
+	map->autocreate = true;
 
 	return map;
 }
@@ -4307,6 +4310,20 @@ static int bpf_get_map_info_from_fdinfo(int fd, struct bpf_map_info *info)
 	return 0;
 }
 
+bool bpf_map__autocreate(const struct bpf_map *map)
+{
+	return map->autocreate;
+}
+
+int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
+{
+	if (map->obj->loaded)
+		return libbpf_err(-EBUSY);
+
+	map->autocreate = autocreate;
+	return 0;
+}
+
 int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 {
 	struct bpf_map_info info = {};
@@ -5163,9 +5180,11 @@ bpf_object__create_maps(struct bpf_object *obj)
 		 * bpf_object loading will succeed just fine even on old
 		 * kernels.
 		 */
-		if (bpf_map__is_internal(map) &&
-		    !kernel_supports(obj, FEAT_GLOBAL_DATA)) {
-			map->skipped = true;
+		if (bpf_map__is_internal(map) && !kernel_supports(obj, FEAT_GLOBAL_DATA))
+			map->autocreate = false;
+
+		if (!map->autocreate) {
+			pr_debug("map '%s': skipped auto-creating...\n", map->name);
 			continue;
 		}
 
@@ -5788,6 +5807,36 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 	return err;
 }
 
+/* base map load ldimm64 special constant, used also for log fixup logic */
+#define MAP_LDIMM64_POISON_BASE 2001000000
+#define MAP_LDIMM64_POISON_PFX "200100"
+
+static void poison_map_ldimm64(struct bpf_program *prog, int relo_idx,
+			       int insn_idx, struct bpf_insn *insn,
+			       int map_idx, const struct bpf_map *map)
+{
+	int i;
+
+	pr_debug("prog '%s': relo #%d: poisoning insn #%d that loads map #%d '%s'\n",
+		 prog->name, relo_idx, insn_idx, map_idx, map->name);
+
+	/* we turn single ldimm64 into two identical invalid calls */
+	for (i = 0; i < 2; i++) {
+		insn->code = BPF_JMP | BPF_CALL;
+		insn->dst_reg = 0;
+		insn->src_reg = 0;
+		insn->off = 0;
+		/* if this instruction is reachable (not a dead code),
+		 * verifier will complain with something like:
+		 * invalid func unknown#2001000123
+		 * where lower 123 is map index into obj->maps[] array
+		 */
+		insn->imm = MAP_LDIMM64_POISON_BASE + map_idx;
+
+		insn++;
+	}
+}
+
 /* Relocate data references within program code:
  *  - map references;
  *  - global variable references;
@@ -5801,33 +5850,35 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 	for (i = 0; i < prog->nr_reloc; i++) {
 		struct reloc_desc *relo = &prog->reloc_desc[i];
 		struct bpf_insn *insn = &prog->insns[relo->insn_idx];
+		const struct bpf_map *map;
 		struct extern_desc *ext;
 
 		switch (relo->type) {
 		case RELO_LD64:
+			map = &obj->maps[relo->map_idx];
 			if (obj->gen_loader) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX;
 				insn[0].imm = relo->map_idx;
-			} else {
+			} else if (map->autocreate) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_FD;
-				insn[0].imm = obj->maps[relo->map_idx].fd;
+				insn[0].imm = map->fd;
+			} else {
+				poison_map_ldimm64(prog, i, relo->insn_idx, insn,
+						   relo->map_idx, map);
 			}
 			break;
 		case RELO_DATA:
+			map = &obj->maps[relo->map_idx];
 			insn[1].imm = insn[0].imm + relo->sym_off;
 			if (obj->gen_loader) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
 				insn[0].imm = relo->map_idx;
-			} else {
-				const struct bpf_map *map = &obj->maps[relo->map_idx];
-
-				if (map->skipped) {
-					pr_warn("prog '%s': relo #%d: kernel doesn't support global data\n",
-						prog->name, i);
-					return -ENOTSUP;
-				}
+			} else if (map->autocreate) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
-				insn[0].imm = obj->maps[relo->map_idx].fd;
+				insn[0].imm = map->fd;
+			} else {
+				poison_map_ldimm64(prog, i, relo->insn_idx, insn,
+						   relo->map_idx, map);
 			}
 			break;
 		case RELO_EXTERN_VAR:
@@ -6952,6 +7003,39 @@ static void fixup_log_failed_core_relo(struct bpf_program *prog,
 	patch_log(buf, buf_sz, log_sz, line1, line3 - line1, patch);
 }
 
+static void fixup_log_missing_map_load(struct bpf_program *prog,
+				       char *buf, size_t buf_sz, size_t log_sz,
+				       char *line1, char *line2, char *line3)
+{
+	/* Expected log for failed and not properly guarded CO-RE relocation:
+	 * line1 -> 123: (85) call unknown#2001000345
+	 * line2 -> invalid func unknown#2001000345
+	 * line3 -> <anything else or end of buffer>
+	 *
+	 * "123" is the index of the instruction that was poisoned.
+	 * "345" in "2001000345" are map index in obj->maps to fetch map name.
+	 */
+	struct bpf_object *obj = prog->obj;
+	const struct bpf_map *map;
+	int insn_idx, map_idx;
+	char patch[128];
+
+	if (sscanf(line1, "%d: (%*d) call unknown#%d\n", &insn_idx, &map_idx) != 2)
+		return;
+
+	map_idx -= MAP_LDIMM64_POISON_BASE;
+	if (map_idx < 0 || map_idx >= obj->nr_maps)
+		return;
+	map = &obj->maps[map_idx];
+
+	snprintf(patch, sizeof(patch),
+		 "%d: <invalid BPF map reference>\n"
+		 "BPF map '%s' is referenced but wasn't created\n",
+		 insn_idx, map->name);
+
+	patch_log(buf, buf_sz, log_sz, line1, line3 - line1, patch);
+}
+
 static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz)
 {
 	/* look for familiar error patterns in last N lines of the log */
@@ -6980,6 +7064,14 @@ static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_s
 			fixup_log_failed_core_relo(prog, buf, buf_sz, log_sz,
 						   prev_line, cur_line, next_line);
 			return;
+		} else if (str_has_pfx(cur_line, "invalid func unknown#"MAP_LDIMM64_POISON_PFX)) {
+			prev_line = find_prev_line(buf, cur_line);
+			if (!prev_line)
+				continue;
+
+			fixup_log_missing_map_load(prog, buf, buf_sz, log_sz,
+						   prev_line, cur_line, next_line);
+			return;
 		}
 	}
 }
@@ -8168,7 +8260,7 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
 		char *pin_path = NULL;
 		char buf[PATH_MAX];
 
-		if (map->skipped)
+		if (!map->autocreate)
 			continue;
 
 		if (path) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index cdbfee60ea3e..114b1f6f73a5 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -866,6 +866,28 @@ struct bpf_map *bpf_map__prev(const struct bpf_map *map, const struct bpf_object
 LIBBPF_API struct bpf_map *
 bpf_object__prev_map(const struct bpf_object *obj, const struct bpf_map *map);
 
+/**
+ * @brief **bpf_map__set_autocreate()** sets whether libbpf has to auto-create
+ * BPF map during BPF object load phase.
+ * @param map the BPF map instance
+ * @param autocreate whether to create BPF map during BPF object load
+ * @return 0 on success; -EBUSY if BPF object was already loaded
+ *
+ * **bpf_map__set_autocreate()** allows to opt-out from libbpf auto-creating
+ * BPF map. By default, libbpf will attempt to create every single BPF map
+ * defined in BPF object file using BPF_MAP_CREATE command of bpf() syscall
+ * and fill in map FD in BPF instructions.
+ *
+ * This API allows to opt-out of this process for specific map instance. This
+ * can be useful if host kernel doesn't support such BPF map type or used
+ * combination of flags and user application wants to avoid creating such
+ * a map in the first place. User is still responsible to make sure that their
+ * BPF-side code that expects to use such missing BPF map is recognized by BPF
+ * verifier as dead code, otherwise BPF verifier will reject such BPF program.
+ */
+LIBBPF_API int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate);
+LIBBPF_API bool bpf_map__autocreate(const struct bpf_map *map);
+
 /**
  * @brief **bpf_map__fd()** gets the file descriptor of the passed
  * BPF map
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 82f6d62176dd..b5bc84039407 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -442,10 +442,12 @@ LIBBPF_0.7.0 {
 
 LIBBPF_0.8.0 {
 	global:
+		bpf_map__autocreate;
+		bpf_map__set_autocreate;
 		bpf_object__destroy_subskeleton;
 		bpf_object__open_subskeleton;
+		bpf_program__attach_kprobe_multi_opts;
 		bpf_program__attach_usdt;
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
-		bpf_program__attach_kprobe_multi_opts;
 } LIBBPF_0.7.0;
-- 
2.30.2

