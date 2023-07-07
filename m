Return-Path: <bpf+bounces-4500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC274B9CF
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 01:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96389281940
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 23:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058717FE7;
	Fri,  7 Jul 2023 23:12:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553DC2F28
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 23:12:13 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB57B110
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 16:12:11 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367HVJr0001778
	for <bpf@vger.kernel.org>; Fri, 7 Jul 2023 16:12:10 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rpaun8de4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 16:12:10 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Jul 2023 16:12:08 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B9B62342E9F6D; Fri,  7 Jul 2023 16:12:02 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <ravi.bangoria@amd.com>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] libbpf: only reset sec_def handler when necessary
Date: Fri, 7 Jul 2023 16:11:56 -0700
Message-ID: <20230707231156.1711948-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: m3yExccdK7ir8SdvvhHHmoAXK3Ko6zFo
X-Proofpoint-ORIG-GUID: m3yExccdK7ir8SdvvhHHmoAXK3Ko6zFo
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_14,2023-07-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Don't reset recorded sec_def handler unconditionally on
bpf_program__set_type(). There are two situations where this is wrong.

First, if the program type didn't actually change. In that case original
SEC handler should work just fine.

Second, catch-all custom SEC handler is supposed to work with any BPF
program type and SEC() annotation, so it also doesn't make sense to
reset that.

This patch fixes both issues. This was reported recently in the context
of breaking perf tool, which uses custom catch-all handler for fancy BPF
prologue generation logic. This patch should fix the issue.

  [0] https://lore.kernel.org/linux-perf-users/ab865e6d-06c5-078e-e404-7f90=
686db50d@amd.com/

Fixes: d6e6286a12e7 ("libbpf: disassociate section handler on explicit bpf_=
program__set_type() call")
Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fd4f1875df65..78635feb1946 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8562,13 +8562,31 @@ enum bpf_prog_type bpf_program__type(const struct b=
pf_program *prog)
 	return prog->type;
 }
=20
+static size_t custom_sec_def_cnt;
+static struct bpf_sec_def *custom_sec_defs;
+static struct bpf_sec_def custom_fallback_def;
+static bool has_custom_fallback_def;
+static int last_custom_sec_def_handler_id;
+
 int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type typ=
e)
 {
 	if (prog->obj->loaded)
 		return libbpf_err(-EBUSY);
=20
+	/* if type is not changed, do nothing */
+	if (prog->type =3D=3D type)
+		return 0;
+
 	prog->type =3D type;
-	prog->sec_def =3D NULL;
+
+	/* If a program type was changed, we need to reset associated SEC()
+	 * handler, as it will be invalid now. The only exception is a generic
+	 * fallback handler, which by definition is program type-agnostic and
+	 * is a catch-all custom handler, optionally set by the application,
+	 * so should be able to handle any type of BPF program.
+	 */
+	if (prog->sec_def !=3D &custom_fallback_def)
+		prog->sec_def =3D NULL;
 	return 0;
 }
=20
@@ -8744,13 +8762,6 @@ static const struct bpf_sec_def section_defs[] =3D {
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
 };
=20
-static size_t custom_sec_def_cnt;
-static struct bpf_sec_def *custom_sec_defs;
-static struct bpf_sec_def custom_fallback_def;
-static bool has_custom_fallback_def;
-
-static int last_custom_sec_def_handler_id;
-
 int libbpf_register_prog_handler(const char *sec,
 				 enum bpf_prog_type prog_type,
 				 enum bpf_attach_type exp_attach_type,
--=20
2.34.1


