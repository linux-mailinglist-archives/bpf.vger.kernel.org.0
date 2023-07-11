Return-Path: <bpf+bounces-4704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D05C74E464
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D852815C8
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 02:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10541C01;
	Tue, 11 Jul 2023 02:42:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDA7F
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:42:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D82B1A7
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 19:42:10 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AKnHmc011276
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 19:42:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rq746hf54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 19:42:09 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Jul 2023 19:42:08 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id C99CA3454BB11; Mon, 10 Jul 2023 19:41:51 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] libbpf: fix realloc API handling in zero-sized edge cases
Date: Mon, 10 Jul 2023 19:41:50 -0700
Message-ID: <20230711024150.1566433-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: S875nfdGwZAgo962PJbUR0nSw-VPoTB_
X-Proofpoint-GUID: S875nfdGwZAgo962PJbUR0nSw-VPoTB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_18,2023-07-06_02,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

realloc() and reallocarray() can either return NULL or a special
non-NULL pointer, if their size argument is zero. This requires a bit
more care to handle NULL-as-valid-result situation differently from
NULL-as-error case. This has caused real issues before ([0]), and just
recently bit again in production when performing bpf_program__attach_usdt=
().

This patch fixes 4 places that do or potentially could suffer from this
mishandling of NULL, including the reported USDT-related one.

There are many other places where realloc()/reallocarray() is used and
NULL is always treated as an error value, but all those have guarantees
that their size is always non-zero, so those spot don't need any extra
handling.

  [0] d08ab82f59d5 ("libbpf: Fix double-free when linker processes empty =
sections")

Fixes: 999783c8bbda ("libbpf: Wire up spec management and other arch-inde=
pendent USDT logic")
Fixes: b63b3c490eee ("libbpf: Add bpf_program__set_insns function")
Fixes: 697f104db8a6 ("libbpf: Support custom SEC() handlers")
Fixes: b12688267280 ("libbpf: Change the order of data and text relocatio=
ns.")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 15 ++++++++++++---
 tools/lib/bpf/usdt.c   |  5 ++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 78635feb1946..63311a73c16d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6161,7 +6161,11 @@ static int append_subprog_relos(struct bpf_program=
 *main_prog, struct bpf_progra
 	if (main_prog =3D=3D subprog)
 		return 0;
 	relos =3D libbpf_reallocarray(main_prog->reloc_desc, new_cnt, sizeof(*r=
elos));
-	if (!relos)
+	/* if new count is zero, reallocarray can return a valid NULL result;
+	 * in this case the previous pointer will be freed, so we *have to*
+	 * reassign old pointer to the new value (even if it's NULL)
+	 */
+	if (!relos && new_cnt)
 		return -ENOMEM;
 	if (subprog->nr_reloc)
 		memcpy(relos + main_prog->nr_reloc, subprog->reloc_desc,
@@ -8532,7 +8536,8 @@ int bpf_program__set_insns(struct bpf_program *prog=
,
 		return -EBUSY;
=20
 	insns =3D libbpf_reallocarray(prog->insns, new_insn_cnt, sizeof(*insns)=
);
-	if (!insns) {
+	/* NULL is a valid return from reallocarray if the new count is zero */
+	if (!insns && new_insn_cnt) {
 		pr_warn("prog '%s': failed to realloc prog code\n", prog->name);
 		return -ENOMEM;
 	}
@@ -8841,7 +8846,11 @@ int libbpf_unregister_prog_handler(int handler_id)
=20
 	/* try to shrink the array, but it's ok if we couldn't */
 	sec_defs =3D libbpf_reallocarray(custom_sec_defs, custom_sec_def_cnt, s=
izeof(*sec_defs));
-	if (sec_defs)
+	/* if new count is zero, reallocarray can return a valid NULL result;
+	 * in this case the previous pointer will be freed, so we *have to*
+	 * reassign old pointer to the new value (even if it's NULL)
+	 */
+	if (sec_defs || custom_sec_def_cnt =3D=3D 0)
 		custom_sec_defs =3D sec_defs;
=20
 	return 0;
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index f1a141555f08..37455d00b239 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -852,8 +852,11 @@ static int bpf_link_usdt_detach(struct bpf_link *lin=
k)
 		 * system is so exhausted on memory, it's the least of user's
 		 * concerns, probably.
 		 * So just do our best here to return those IDs to usdt_manager.
+		 * Another edge case when we can legitimately get NULL is when
+		 * new_cnt is zero, which can happen in some edge cases, so we
+		 * need to be careful about that.
 		 */
-		if (new_free_ids) {
+		if (new_free_ids || new_cnt =3D=3D 0) {
 			memcpy(new_free_ids + man->free_spec_cnt, usdt_link->spec_ids,
 			       usdt_link->spec_cnt * sizeof(*usdt_link->spec_ids));
 			man->free_spec_ids =3D new_free_ids;
--=20
2.34.1


