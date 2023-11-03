Return-Path: <bpf+bounces-14054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 714CD7DFD77
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 01:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941051C21099
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 00:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144901380;
	Fri,  3 Nov 2023 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28A17EC
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 00:08:54 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF657195
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:08:52 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2MZgq6016148
	for <bpf@vger.kernel.org>; Thu, 2 Nov 2023 17:08:52 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u4mprrc07-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 17:08:52 -0700
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 17:08:50 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 32BF23AD8A8A9; Thu,  2 Nov 2023 17:08:48 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 12/13] veristat: add ability to set BPF_F_TEST_SANITY_STRICT flag with -r flag
Date: Thu, 2 Nov 2023 17:08:21 -0700
Message-ID: <20231103000822.2509815-13-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103000822.2509815-1-andrii@kernel.org>
References: <20231103000822.2509815-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: I_oo9V2o5Oc6zmBBbKGiDgRE108OnI6e
X-Proofpoint-ORIG-GUID: I_oo9V2o5Oc6zmBBbKGiDgRE108OnI6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02

Add a new flag -r (--test-sanity), similar to -t (--test-states), to add
extra BPF program flags when loading BPF programs.

This allows to use veristat to easily catch sanity violations in
production BPF programs.

reg_bounds tests are also enforcing BPF_F_TEST_SANITY_STRICT flag now.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c |  1 +
 tools/testing/selftests/bpf/veristat.c              | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
index fd6401dec0b7..f980a2555fc7 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -829,6 +829,7 @@ static int load_range_cmp_prog(struct range x, struct=
 range y, enum op op,
 		.log_level =3D 2,
 		.log_buf =3D log_buf,
 		.log_size =3D log_sz,
+		.prog_flags =3D BPF_F_TEST_SANITY_STRICT,
 	);
=20
 	/* ; skip exit block below
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
index 655095810d4a..159e6a97b65a 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -142,6 +142,7 @@ static struct env {
 	bool debug;
 	bool quiet;
 	bool force_checkpoints;
+	bool strict_range_sanity;
 	enum resfmt out_fmt;
 	bool show_version;
 	bool comparison_mode;
@@ -210,8 +211,6 @@ static const struct argp_option opts[] =3D {
 	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for norm=
al mode, 1 for verbose mode)" },
 	{ "log-fixed", OPT_LOG_FIXED, NULL, 0, "Disable verifier log rotation" =
},
 	{ "log-size", OPT_LOG_SIZE, "BYTES", 0, "Customize verifier log size (d=
efault to 16MB)" },
-	{ "test-states", 't', NULL, 0,
-	  "Force frequent BPF verifier state checkpointing (set BPF_F_TEST_STAT=
E_FREQ program flag)" },
 	{ "quiet", 'q', NULL, 0, "Quiet mode" },
 	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
 	{ "sort", 's', "SPEC", 0, "Specify sort order" },
@@ -219,6 +218,10 @@ static const struct argp_option opts[] =3D {
 	{ "compare", 'C', NULL, 0, "Comparison mode" },
 	{ "replay", 'R', NULL, 0, "Replay mode" },
 	{ "filter", 'f', "FILTER", 0, "Filter expressions (or @filename for fil=
e with expressions)." },
+	{ "test-states", 't', NULL, 0,
+	  "Force frequent BPF verifier state checkpointing (set BPF_F_TEST_STAT=
E_FREQ program flag)" },
+	{ "test-sanity", 'r', NULL, 0,
+	  "Force strict BPF verifier register sanity behavior (BPF_F_TEST_SANIT=
Y_STRICT program flag)" },
 	{},
 };
=20
@@ -290,6 +293,9 @@ static error_t parse_arg(int key, char *arg, struct a=
rgp_state *state)
 	case 't':
 		env.force_checkpoints =3D true;
 		break;
+	case 'r':
+		env.strict_range_sanity =3D true;
+		break;
 	case 'C':
 		env.comparison_mode =3D true;
 		break;
@@ -997,6 +1003,8 @@ static int process_prog(const char *filename, struct=
 bpf_object *obj, struct bpf
=20
 	if (env.force_checkpoints)
 		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_STA=
TE_FREQ);
+	if (env.strict_range_sanity)
+		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_SAN=
ITY_STRICT);
=20
 	err =3D bpf_object__load(obj);
 	env.progs_processed++;
--=20
2.34.1


