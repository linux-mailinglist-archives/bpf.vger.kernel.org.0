Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073DC50EDC2
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 02:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbiDZAso convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Apr 2022 20:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbiDZAsn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 20:48:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA65422BED
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:37 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP8il005375
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:37 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmf9pxhbx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:37 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:45:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3568418FD8F54; Mon, 25 Apr 2022 17:45:30 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 07/10] libbpf: refactor CO-RE relo human description formatting routine
Date:   Mon, 25 Apr 2022 17:45:08 -0700
Message-ID: <20220426004511.2691730-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426004511.2691730-1-andrii@kernel.org>
References: <20220426004511.2691730-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UNJ5vG0zZ0RGf3JNEYBTVuuuqbqTE1I5
X-Proofpoint-GUID: UNJ5vG0zZ0RGf3JNEYBTVuuuqbqTE1I5
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

Refactor how CO-RE relocation is formatted. Now it dumps human-readable
representation, currently used by libbpf in either debug or error
message output during CO-RE relocation resolution process, into provided
buffer. This approach allows for better reuse of this functionality
outside of CO-RE relocation resolution, which we'll use in next patch
for providing better error message for BPF verifier rejecting BPF
program due to unguarded failed CO-RE relocation.

It also gets rid of annoying "stitching" of libbpf_print() calls, which
was the only place where we did this.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/relo_core.c | 64 +++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index adaa22160692..13d36a705464 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1055,51 +1055,66 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
  * [<type-id>] (<type-name>) + <raw-spec> => <offset>@<spec>,
  * where <spec> is a C-syntax view of recorded field access, e.g.: x.a[3].b
  */
-static void bpf_core_dump_spec(const char *prog_name, int level, const struct bpf_core_spec *spec)
+static int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *spec)
 {
 	const struct btf_type *t;
 	const struct btf_enum *e;
 	const char *s;
 	__u32 type_id;
-	int i;
+	int i, len = 0;
+
+#define append_buf(fmt, args...)				\
+	({							\
+		int r;						\
+		r = snprintf(buf, buf_sz, fmt, ##args);		\
+		len += r;					\
+		if (r >= buf_sz)				\
+			r = buf_sz;				\
+		buf += r;					\
+		buf_sz -= r;					\
+	})
 
 	type_id = spec->root_type_id;
 	t = btf_type_by_id(spec->btf, type_id);
 	s = btf__name_by_offset(spec->btf, t->name_off);
 
-	libbpf_print(level, "[%u] %s %s", type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
+	append_buf("<%s> [%u] %s %s",
+		   core_relo_kind_str(spec->relo_kind),
+		   type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
 
 	if (core_relo_is_type_based(spec->relo_kind))
-		return;
+		return len;
 
 	if (core_relo_is_enumval_based(spec->relo_kind)) {
 		t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
 		e = btf_enum(t) + spec->raw_spec[0];
 		s = btf__name_by_offset(spec->btf, e->name_off);
 
-		libbpf_print(level, "::%s = %u", s, e->val);
-		return;
+		append_buf("::%s = %u", s, e->val);
+		return len;
 	}
 
 	if (core_relo_is_field_based(spec->relo_kind)) {
 		for (i = 0; i < spec->len; i++) {
 			if (spec->spec[i].name)
-				libbpf_print(level, ".%s", spec->spec[i].name);
+				append_buf(".%s", spec->spec[i].name);
 			else if (i > 0 || spec->spec[i].idx > 0)
-				libbpf_print(level, "[%u]", spec->spec[i].idx);
+				append_buf("[%u]", spec->spec[i].idx);
 		}
 
-		libbpf_print(level, " (");
+		append_buf(" (");
 		for (i = 0; i < spec->raw_len; i++)
-			libbpf_print(level, "%s%d", i == 0 ? "" : ":", spec->raw_spec[i]);
+			append_buf("%s%d", i == 0 ? "" : ":", spec->raw_spec[i]);
 
 		if (spec->bit_offset % 8)
-			libbpf_print(level, " @ offset %u.%u)",
-				     spec->bit_offset / 8, spec->bit_offset % 8);
+			append_buf(" @ offset %u.%u)", spec->bit_offset / 8, spec->bit_offset % 8);
 		else
-			libbpf_print(level, " @ offset %u)", spec->bit_offset / 8);
-		return;
+			append_buf(" @ offset %u)", spec->bit_offset / 8);
+		return len;
 	}
+
+	return len;
+#undef append_buf
 }
 
 /*
@@ -1168,6 +1183,7 @@ int bpf_core_calc_relo_insn(const char *prog_name,
 	const char *local_name;
 	__u32 local_id;
 	const char *spec_str;
+	char spec_buf[256];
 	int i, j, err;
 
 	local_id = relo->type_id;
@@ -1190,10 +1206,8 @@ int bpf_core_calc_relo_insn(const char *prog_name,
 		return -EINVAL;
 	}
 
-	pr_debug("prog '%s': relo #%d: kind <%s> (%d), spec is ", prog_name,
-		 relo_idx, core_relo_kind_str(relo->kind), relo->kind);
-	bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, local_spec);
-	libbpf_print(LIBBPF_DEBUG, "\n");
+	bpf_core_format_spec(spec_buf, sizeof(spec_buf), local_spec);
+	pr_debug("prog '%s': relo #%d: %s\n", prog_name, relo_idx, spec_buf);
 
 	/* TYPE_ID_LOCAL relo is special and doesn't need candidate search */
 	if (relo->kind == BPF_CORE_TYPE_ID_LOCAL) {
@@ -1217,17 +1231,15 @@ int bpf_core_calc_relo_insn(const char *prog_name,
 		err = bpf_core_spec_match(local_spec, cands->cands[i].btf,
 					  cands->cands[i].id, cand_spec);
 		if (err < 0) {
-			pr_warn("prog '%s': relo #%d: error matching candidate #%d ",
-				prog_name, relo_idx, i);
-			bpf_core_dump_spec(prog_name, LIBBPF_WARN, cand_spec);
-			libbpf_print(LIBBPF_WARN, ": %d\n", err);
+			bpf_core_format_spec(spec_buf, sizeof(spec_buf), cand_spec);
+			pr_warn("prog '%s': relo #%d: error matching candidate #%d %s: %d\n ",
+				prog_name, relo_idx, i, spec_buf, err);
 			return err;
 		}
 
-		pr_debug("prog '%s': relo #%d: %s candidate #%d ", prog_name,
-			 relo_idx, err == 0 ? "non-matching" : "matching", i);
-		bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, cand_spec);
-		libbpf_print(LIBBPF_DEBUG, "\n");
+		bpf_core_format_spec(spec_buf, sizeof(spec_buf), cand_spec);
+		pr_debug("prog '%s': relo #%d: %s candidate #%d %s\n", prog_name,
+			 relo_idx, err == 0 ? "non-matching" : "matching", i, spec_buf);
 
 		if (err == 0)
 			continue;
-- 
2.30.2

