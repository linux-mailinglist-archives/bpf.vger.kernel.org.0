Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5278F50EDC3
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 02:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiDZAso convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Apr 2022 20:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbiDZAsm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 20:48:42 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240331BE97
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:37 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PNidiC003561
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:36 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmeytxkey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:36 -0700
Received: from twshared39027.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:45:34 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3FBBE18FD8F5A; Mon, 25 Apr 2022 17:45:32 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 08/10] libbpf: simplify bpf_core_parse_spec() signature
Date:   Mon, 25 Apr 2022 17:45:09 -0700
Message-ID: <20220426004511.2691730-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426004511.2691730-1-andrii@kernel.org>
References: <20220426004511.2691730-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: u1Z7xFjeSlWBoY5FpYSSoN_rkW0wrkFH
X-Proofpoint-ORIG-GUID: u1Z7xFjeSlWBoY5FpYSSoN_rkW0wrkFH
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

Simplify bpf_core_parse_spec() signature to take struct bpf_core_relo as
an input instead of requiring callers to decompose them into type_id,
relo, spec_str, etc. This makes using and reusing this helper easier.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/relo_core.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 13d36a705464..4a9ad0cfb474 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -179,28 +179,27 @@ static bool core_relo_is_enumval_based(enum bpf_core_relo_kind kind)
  * string to specify enumerator's value index that need to be relocated.
  */
 static int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
-			       __u32 type_id,
-			       const char *spec_str,
-			       enum bpf_core_relo_kind relo_kind,
+			       const struct bpf_core_relo *relo,
 			       struct bpf_core_spec *spec)
 {
 	int access_idx, parsed_len, i;
 	struct bpf_core_accessor *acc;
 	const struct btf_type *t;
-	const char *name;
+	const char *name, *spec_str;
 	__u32 id;
 	__s64 sz;
 
+	spec_str = btf__name_by_offset(btf, relo->access_str_off);
 	if (str_is_empty(spec_str) || *spec_str == ':')
 		return -EINVAL;
 
 	memset(spec, 0, sizeof(*spec));
 	spec->btf = btf;
-	spec->root_type_id = type_id;
-	spec->relo_kind = relo_kind;
+	spec->root_type_id = relo->type_id;
+	spec->relo_kind = relo->kind;
 
 	/* type-based relocations don't have a field access string */
-	if (core_relo_is_type_based(relo_kind)) {
+	if (core_relo_is_type_based(relo->kind)) {
 		if (strcmp(spec_str, "0"))
 			return -EINVAL;
 		return 0;
@@ -221,7 +220,7 @@ static int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
 	if (spec->raw_len == 0)
 		return -EINVAL;
 
-	t = skip_mods_and_typedefs(btf, type_id, &id);
+	t = skip_mods_and_typedefs(btf, relo->type_id, &id);
 	if (!t)
 		return -EINVAL;
 
@@ -231,7 +230,7 @@ static int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
 	acc->idx = access_idx;
 	spec->len++;
 
-	if (core_relo_is_enumval_based(relo_kind)) {
+	if (core_relo_is_enumval_based(relo->kind)) {
 		if (!btf_is_enum(t) || spec->raw_len > 1 || access_idx >= btf_vlen(t))
 			return -EINVAL;
 
@@ -240,7 +239,7 @@ static int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
 		return 0;
 	}
 
-	if (!core_relo_is_field_based(relo_kind))
+	if (!core_relo_is_field_based(relo->kind))
 		return -EINVAL;
 
 	sz = btf__resolve_size(btf, id);
@@ -301,7 +300,7 @@ static int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
 			spec->bit_offset += access_idx * sz * 8;
 		} else {
 			pr_warn("prog '%s': relo for [%u] %s (at idx %d) captures type [%d] of unexpected kind %s\n",
-				prog_name, type_id, spec_str, i, id, btf_kind_str(t));
+				prog_name, relo->type_id, spec_str, i, id, btf_kind_str(t));
 			return -EINVAL;
 		}
 	}
@@ -1182,7 +1181,6 @@ int bpf_core_calc_relo_insn(const char *prog_name,
 	const struct btf_type *local_type;
 	const char *local_name;
 	__u32 local_id;
-	const char *spec_str;
 	char spec_buf[256];
 	int i, j, err;
 
@@ -1192,17 +1190,15 @@ int bpf_core_calc_relo_insn(const char *prog_name,
 	if (!local_name)
 		return -EINVAL;
 
-	spec_str = btf__name_by_offset(local_btf, relo->access_str_off);
-	if (str_is_empty(spec_str))
-		return -EINVAL;
-
-	err = bpf_core_parse_spec(prog_name, local_btf, local_id, spec_str,
-				  relo->kind, local_spec);
+	err = bpf_core_parse_spec(prog_name, local_btf, relo, local_spec);
 	if (err) {
+		const char *spec_str;
+
+		spec_str = btf__name_by_offset(local_btf, relo->access_str_off);
 		pr_warn("prog '%s': relo #%d: parsing [%d] %s %s + %s failed: %d\n",
 			prog_name, relo_idx, local_id, btf_kind_str(local_type),
 			str_is_empty(local_name) ? "<anon>" : local_name,
-			spec_str, err);
+			spec_str ?: "<?>", err);
 		return -EINVAL;
 	}
 
-- 
2.30.2

