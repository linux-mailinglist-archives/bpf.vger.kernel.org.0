Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2803950EDC0
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 02:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbiDZAsl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Apr 2022 20:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240431AbiDZAsj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 20:48:39 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76092316A
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:33 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP73K003560
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:33 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmeytxke7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:32 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:45:30 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 061E618FD8EFF; Mon, 25 Apr 2022 17:45:23 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 04/10] libbpf: avoid joining .BTF.ext data with BPF programs by section name
Date:   Mon, 25 Apr 2022 17:45:05 -0700
Message-ID: <20220426004511.2691730-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426004511.2691730-1-andrii@kernel.org>
References: <20220426004511.2691730-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _tZis_Ihrr9UcX7dR9CsNS93Ddd6xTGc
X-Proofpoint-ORIG-GUID: _tZis_Ihrr9UcX7dR9CsNS93Ddd6xTGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of using ELF section names as a joining key between .BTF.ext and
corresponding BPF programs, pre-build .BTF.ext section number to ELF
section index mapping during bpf_object__open() and use it later for
matching .BTF.ext information (func/line info or CO-RE relocations) to
their respective BPF programs and subprograms.

This simplifies corresponding joining logic and let's libbpf do
manipulations with BPF program's ELF sections like dropping leading '?'
character for non-autoloaded programs. Original joining logic in
bpf_object__relocate_core() (see relevant comment that's now removed)
was never elegant, so it's a good improvement regardless. But it also
avoids unnecessary internal assumptions about preserving original ELF
section name as BPF program's section name (which was broken when
SEC("?abc") support was added).

Fixes: a3820c481112 ("libbpf: Support opting out from autoloading BPF programs declaratively")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c             |  9 +++-
 tools/lib/bpf/libbpf.c          | 78 +++++++++++++++++++++------------
 tools/lib/bpf/libbpf_internal.h |  7 +++
 3 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d124e9e533f0..bb1e06eb1eca 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2626,6 +2626,7 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
 	const struct btf_ext_info_sec *sinfo;
 	struct btf_ext_info *ext_info;
 	__u32 info_left, record_size;
+	size_t sec_cnt = 0;
 	/* The start of the info sec (including the __u32 record_size). */
 	void *info;
 
@@ -2689,8 +2690,7 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
 			return -EINVAL;
 		}
 
-		total_record_size = sec_hdrlen +
-				    (__u64)num_records * record_size;
+		total_record_size = sec_hdrlen + (__u64)num_records * record_size;
 		if (info_left < total_record_size) {
 			pr_debug("%s section has incorrect num_records in .BTF.ext\n",
 			     ext_sec->desc);
@@ -2699,12 +2699,14 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
 
 		info_left -= total_record_size;
 		sinfo = (void *)sinfo + total_record_size;
+		sec_cnt++;
 	}
 
 	ext_info = ext_sec->ext_info;
 	ext_info->len = ext_sec->len - sizeof(__u32);
 	ext_info->rec_size = record_size;
 	ext_info->info = info + sizeof(__u32);
+	ext_info->sec_cnt = sec_cnt;
 
 	return 0;
 }
@@ -2788,6 +2790,9 @@ void btf_ext__free(struct btf_ext *btf_ext)
 {
 	if (IS_ERR_OR_NULL(btf_ext))
 		return;
+	free(btf_ext->func_info.sec_idxs);
+	free(btf_ext->line_info.sec_idxs);
+	free(btf_ext->core_relo_info.sec_idxs);
 	free(btf_ext->data);
 	free(btf_ext);
 }
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 840a26428937..efc1ea91e12e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2765,6 +2765,9 @@ static int bpf_object__init_btf(struct bpf_object *obj,
 		btf__set_pointer_size(obj->btf, 8);
 	}
 	if (btf_ext_data) {
+		struct btf_ext_info *ext_segs[3];
+		int seg_num, sec_num;
+
 		if (!obj->btf) {
 			pr_debug("Ignore ELF section %s because its depending ELF section %s is not found.\n",
 				 BTF_EXT_ELF_SEC, BTF_ELF_SEC);
@@ -2778,6 +2781,43 @@ static int bpf_object__init_btf(struct bpf_object *obj,
 			obj->btf_ext = NULL;
 			goto out;
 		}
+
+		/* setup .BTF.ext to ELF section mapping */
+		ext_segs[0] = &obj->btf_ext->func_info;
+		ext_segs[1] = &obj->btf_ext->line_info;
+		ext_segs[2] = &obj->btf_ext->core_relo_info;
+		for (seg_num = 0; seg_num < ARRAY_SIZE(ext_segs); seg_num++) {
+			struct btf_ext_info *seg = ext_segs[seg_num];
+			const struct btf_ext_info_sec *sec;
+			const char *sec_name;
+			Elf_Scn *scn;
+
+			if (seg->sec_cnt == 0)
+				continue;
+
+			seg->sec_idxs = calloc(seg->sec_cnt, sizeof(*seg->sec_idxs));
+			if (!seg->sec_idxs) {
+				err = -ENOMEM;
+				goto out;
+			}
+
+			sec_num = 0;
+			for_each_btf_ext_sec(seg, sec) {
+				/* preventively increment index to avoid doing
+				 * this before every continue below
+				 */
+				sec_num++;
+
+				sec_name = btf__name_by_offset(obj->btf, sec->sec_name_off);
+				if (str_is_empty(sec_name))
+					continue;
+				scn = elf_sec_by_name(obj, sec_name);
+				if (!scn)
+					continue;
+
+				seg->sec_idxs[sec_num - 1] = elf_ndxscn(scn);
+			}
+		}
 	}
 out:
 	if (err && libbpf_needs_btf(obj)) {
@@ -5642,7 +5682,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 	struct bpf_program *prog;
 	struct bpf_insn *insn;
 	const char *sec_name;
-	int i, err = 0, insn_idx, sec_idx;
+	int i, err = 0, insn_idx, sec_idx, sec_num;
 
 	if (obj->btf_ext->core_relo_info.len == 0)
 		return 0;
@@ -5663,33 +5703,18 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 	}
 
 	seg = &obj->btf_ext->core_relo_info;
+	sec_num = 0;
 	for_each_btf_ext_sec(seg, sec) {
+		sec_idx = seg->sec_idxs[sec_num];
+		sec_num++;
+
 		sec_name = btf__name_by_offset(obj->btf, sec->sec_name_off);
 		if (str_is_empty(sec_name)) {
 			err = -EINVAL;
 			goto out;
 		}
-		/* bpf_object's ELF is gone by now so it's not easy to find
-		 * section index by section name, but we can find *any*
-		 * bpf_program within desired section name and use it's
-		 * prog->sec_idx to do a proper search by section index and
-		 * instruction offset
-		 */
-		prog = NULL;
-		for (i = 0; i < obj->nr_programs; i++) {
-			if (strcmp(obj->programs[i].sec_name, sec_name) == 0) {
-				prog = &obj->programs[i];
-				break;
-			}
-		}
-		if (!prog) {
-			pr_warn("sec '%s': failed to find a BPF program\n", sec_name);
-			return -ENOENT;
-		}
-		sec_idx = prog->sec_idx;
 
-		pr_debug("sec '%s': found %d CO-RE relocations\n",
-			 sec_name, sec->num_info);
+		pr_debug("sec '%s': found %d CO-RE relocations\n", sec_name, sec->num_info);
 
 		for_each_btf_ext_rec(seg, sec, i, rec) {
 			if (rec->insn_off % BPF_INSN_SZ)
@@ -5873,14 +5898,13 @@ static int adjust_prog_btf_ext_info(const struct bpf_object *obj,
 	void *rec, *rec_end, *new_prog_info;
 	const struct btf_ext_info_sec *sec;
 	size_t old_sz, new_sz;
-	const char *sec_name;
-	int i, off_adj;
+	int i, sec_num, sec_idx, off_adj;
 
+	sec_num = 0;
 	for_each_btf_ext_sec(ext_info, sec) {
-		sec_name = btf__name_by_offset(obj->btf, sec->sec_name_off);
-		if (!sec_name)
-			return -EINVAL;
-		if (strcmp(sec_name, prog->sec_name) != 0)
+		sec_idx = ext_info->sec_idxs[sec_num];
+		sec_num++;
+		if (prog->sec_idx != sec_idx)
 			continue;
 
 		for_each_btf_ext_rec(ext_info, sec, i, rec) {
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 054cd8e93d7c..4abdbe2fea9d 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -376,6 +376,13 @@ struct btf_ext_info {
 	void *info;
 	__u32 rec_size;
 	__u32 len;
+	/* optional (maintained internally by libbpf) mapping between .BTF.ext
+	 * section and corresponding ELF section. This is used to join
+	 * information like CO-RE relocation records with corresponding BPF
+	 * programs defined in ELF sections
+	 */
+	__u32 *sec_idxs;
+	int sec_cnt;
 };
 
 #define for_each_btf_ext_sec(seg, sec)					\
-- 
2.30.2

