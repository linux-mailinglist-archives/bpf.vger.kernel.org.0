Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F00750EDC5
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 02:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiDZAsz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Apr 2022 20:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbiDZAsu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 20:48:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078F922BED
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:44 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP6um005268
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:44 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmf9pxhcu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:44 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:45:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5232B18FD8F68; Mon, 25 Apr 2022 17:45:34 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 09/10] libbpf: fix up verifier log for unguarded failed CO-RE relos
Date:   Mon, 25 Apr 2022 17:45:10 -0700
Message-ID: <20220426004511.2691730-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426004511.2691730-1-andrii@kernel.org>
References: <20220426004511.2691730-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hZm28JluQiwiGsIfNmDL_prraMF-mVAm
X-Proofpoint-GUID: hZm28JluQiwiGsIfNmDL_prraMF-mVAm
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

Teach libbpf to post-process BPF verifier log on BPF program load
failure and detect known error patterns to provide user with more
context.

Currently there is one such common situation: an "unguarded" failed BPF
CO-RE relocation. While failing CO-RE relocation is expected, it is
expected to be property guarded in BPF code such that BPF verifier
always eliminates BPF instructions corresponding to such failed CO-RE
relos as dead code. In cases when user failed to take such precautions,
BPF verifier provides the best log it can:

  123: (85) call unknown#195896080
  invalid func unknown#195896080

Such incomprehensible log error is due to libbpf "poisoning" BPF
instruction that corresponds to failed CO-RE relocation by replacing it
with invalid `call 0xbad2310` instruction (195896080 == 0xbad2310 reads
"bad relo" if you squint hard enough).

Luckily, libbpf has all the necessary information to look up CO-RE
relocation that failed and provide more human-readable description of
what's going on:

  5: <invalid CO-RE relocation>
  failed to resolve CO-RE relocation <byte_off> [6] struct task_struct___bad.fake_field_subprog (0:2 @ offset 8)

This hopefully makes it much easier to understand what's wrong with
user's BPF program without googling magic constants.

This BPF verifier log fixup is setup to be extensible and is going to be
used for at least one other upcoming feature of libbpf in follow up patches.
Libbpf is parsing lines of BPF verifier log starting from the very end.
Currently it processes up to 10 lines of code looking for familiar
patterns. This avoids wasting lots of CPU processing huge verifier logs
(especially for log_level=2 verbosity level). Actual verification error
should normally be found in last few lines, so this should work
reliably.

If libbpf needs to expand log beyond available log_buf_size, it
truncates the end of the verifier log. Given verifier log normally ends
with something like:

  processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

... truncating this on program load error isn't too bad (end user can
always increase log size, if it needs to get complete log).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c    | 144 ++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/relo_core.c |   8 +--
 tools/lib/bpf/relo_core.h |   6 ++
 3 files changed, 154 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5ebbfe8b5e1c..7cb562f3c8bc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5626,6 +5626,22 @@ static int record_relo_core(struct bpf_program *prog,
 	return 0;
 }
 
+static const struct bpf_core_relo *find_relo_core(struct bpf_program *prog, int insn_idx)
+{
+	struct reloc_desc *relo;
+	int i;
+
+	for (i = 0; i < prog->nr_reloc; i++) {
+		relo = &prog->reloc_desc[i];
+		if (relo->type != RELO_CORE || relo->insn_idx != insn_idx)
+			continue;
+
+		return relo->core_relo;
+	}
+
+	return NULL;
+}
+
 static int bpf_core_resolve_relo(struct bpf_program *prog,
 				 const struct bpf_core_relo *relo,
 				 int relo_idx,
@@ -6696,6 +6712,8 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 	return 0;
 }
 
+static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz);
+
 static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_program *prog,
 					 struct bpf_insn *insns, int insns_cnt,
 					 const char *license, __u32 kern_version,
@@ -6842,6 +6860,10 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 		goto retry_load;
 
 	ret = -errno;
+
+	/* post-process verifier log to improve error descriptions */
+	fixup_verifier_log(prog, log_buf, log_buf_size);
+
 	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 	pr_warn("prog '%s': BPF program load failed: %s\n", prog->name, cp);
 	pr_perm_msg(ret);
@@ -6857,6 +6879,128 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 	return ret;
 }
 
+static char *find_prev_line(char *buf, char *cur)
+{
+	char *p;
+
+	if (cur == buf) /* end of a log buf */
+		return NULL;
+
+	p = cur - 1;
+	while (p - 1 >= buf && *(p - 1) != '\n')
+		p--;
+
+	return p;
+}
+
+static void patch_log(char *buf, size_t buf_sz, size_t log_sz,
+		      char *orig, size_t orig_sz, const char *patch)
+{
+	/* size of the remaining log content to the right from the to-be-replaced part */
+	size_t rem_sz = (buf + log_sz) - (orig + orig_sz);
+	size_t patch_sz = strlen(patch);
+
+	if (patch_sz != orig_sz) {
+		/* If patch line(s) are longer than original piece of verifier log,
+		 * shift log contents by (patch_sz - orig_sz) bytes to the right
+		 * starting from after to-be-replaced part of the log.
+		 *
+		 * If patch line(s) are shorter than original piece of verifier log,
+		 * shift log contents by (orig_sz - patch_sz) bytes to the left
+		 * starting from after to-be-replaced part of the log
+		 *
+		 * We need to be careful about not overflowing available
+		 * buf_sz capacity. If that's the case, we'll truncate the end
+		 * of the original log, as necessary.
+		 */
+		if (patch_sz > orig_sz) {
+			if (orig + patch_sz >= buf + buf_sz) {
+				/* patch is big enough to cover remaining space completely */
+				patch_sz -= (orig + patch_sz) - (buf + buf_sz) + 1;
+				rem_sz = 0;
+			} else if (patch_sz - orig_sz > buf_sz - log_sz) {
+				/* patch causes part of remaining log to be truncated */
+				rem_sz -= (patch_sz - orig_sz) - (buf_sz - log_sz);
+			}
+		}
+		/* shift remaining log to the right by calculated amount */
+		memmove(orig + patch_sz, orig + orig_sz, rem_sz);
+	}
+
+	memcpy(orig, patch, patch_sz);
+}
+
+static void fixup_log_failed_core_relo(struct bpf_program *prog,
+				       char *buf, size_t buf_sz, size_t log_sz,
+				       char *line1, char *line2, char *line3)
+{
+	/* Expected log for failed and not properly guarded CO-RE relocation:
+	 * line1 -> 123: (85) call unknown#195896080
+	 * line2 -> invalid func unknown#195896080
+	 * line3 -> <anything else or end of buffer>
+	 *
+	 * "123" is the index of the instruction that was poisoned. We extract
+	 * instruction index to find corresponding CO-RE relocation and
+	 * replace this part of the log with more relevant information about
+	 * failed CO-RE relocation.
+	 */
+	const struct bpf_core_relo *relo;
+	struct bpf_core_spec spec;
+	char patch[512], spec_buf[256];
+	int insn_idx, err;
+
+	if (sscanf(line1, "%d: (%*d) call unknown#195896080\n", &insn_idx) != 1)
+		return;
+
+	relo = find_relo_core(prog, insn_idx);
+	if (!relo)
+		return;
+
+	err = bpf_core_parse_spec(prog->name, prog->obj->btf, relo, &spec);
+	if (err)
+		return;
+
+	bpf_core_format_spec(spec_buf, sizeof(spec_buf), &spec);
+	snprintf(patch, sizeof(patch),
+		 "%d: <invalid CO-RE relocation>\n"
+		 "failed to resolve CO-RE relocation %s\n",
+		 insn_idx, spec_buf);
+
+	patch_log(buf, buf_sz, log_sz, line1, line3 - line1, patch);
+}
+
+static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz)
+{
+	/* look for familiar error patterns in last N lines of the log */
+	const size_t max_last_line_cnt = 10;
+	char *prev_line, *cur_line, *next_line;
+	size_t log_sz;
+	int i;
+
+	if (!buf)
+		return;
+
+	log_sz = strlen(buf) + 1;
+	next_line = buf + log_sz - 1;
+
+	for (i = 0; i < max_last_line_cnt; i++, next_line = cur_line) {
+		cur_line = find_prev_line(buf, next_line);
+		if (!cur_line)
+			return;
+
+		/* failed CO-RE relocation case */
+		if (str_has_pfx(cur_line, "invalid func unknown#195896080\n")) {
+			prev_line = find_prev_line(buf, cur_line);
+			if (!prev_line)
+				continue;
+
+			fixup_log_failed_core_relo(prog, buf, buf_sz, log_sz,
+						   prev_line, cur_line, next_line);
+			return;
+		}
+	}
+}
+
 static int bpf_program_record_relos(struct bpf_program *prog)
 {
 	struct bpf_object *obj = prog->obj;
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 4a9ad0cfb474..ba4453dfd1ed 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -178,9 +178,9 @@ static bool core_relo_is_enumval_based(enum bpf_core_relo_kind kind)
  * Enum value-based relocations (ENUMVAL_EXISTS/ENUMVAL_VALUE) use access
  * string to specify enumerator's value index that need to be relocated.
  */
-static int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
-			       const struct bpf_core_relo *relo,
-			       struct bpf_core_spec *spec)
+int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
+			const struct bpf_core_relo *relo,
+			struct bpf_core_spec *spec)
 {
 	int access_idx, parsed_len, i;
 	struct bpf_core_accessor *acc;
@@ -1054,7 +1054,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
  * [<type-id>] (<type-name>) + <raw-spec> => <offset>@<spec>,
  * where <spec> is a C-syntax view of recorded field access, e.g.: x.a[3].b
  */
-static int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *spec)
+int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *spec)
 {
 	const struct btf_type *t;
 	const struct btf_enum *e;
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index a28bf3711ce2..073039d8ca4f 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -84,4 +84,10 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 			int insn_idx, const struct bpf_core_relo *relo,
 			int relo_idx, const struct bpf_core_relo_res *res);
 
+int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
+		        const struct bpf_core_relo *relo,
+		        struct bpf_core_spec *spec);
+
+int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *spec);
+
 #endif
-- 
2.30.2

