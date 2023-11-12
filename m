Return-Path: <bpf+bounces-14902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352827E8DD6
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3045B20A34
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952517E1;
	Sun, 12 Nov 2023 01:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61817EE
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:06:58 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2486324A
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:56 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3AC15p7E022947
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:56 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3ua60du0cm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:55 -0800
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 17:06:54 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id C507C3B5D530E; Sat, 11 Nov 2023 17:06:49 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 12/13] veristat: add ability to set BPF_F_TEST_SANITY_STRICT flag with -r flag
Date: Sat, 11 Nov 2023 17:06:08 -0800
Message-ID: <20231112010609.848406-13-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112010609.848406-1-andrii@kernel.org>
References: <20231112010609.848406-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YhzrlDAWCtTCqVs82Act8px5GaAokIg4
X-Proofpoint-ORIG-GUID: YhzrlDAWCtTCqVs82Act8px5GaAokIg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_21,2023-11-09_01,2023-05-22_02

Add a new flag -r (--test-sanity), similar to -t (--test-states), to add
extra BPF program flags when loading BPF programs.

This allows to use veristat to easily catch sanity violations in
production BPF programs.

reg_bounds tests are also enforcing BPF_F_TEST_SANITY_STRICT flag now.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c |  1 +
 tools/testing/selftests/bpf/veristat.c              | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
index f3f724062b35..fe0cb906644b 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -838,6 +838,7 @@ static int load_range_cmp_prog(struct range x, struct=
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
index 443a29fc6a62..609fd9753af0 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -145,6 +145,7 @@ static struct env {
 	bool debug;
 	bool quiet;
 	bool force_checkpoints;
+	bool strict_range_sanity;
 	enum resfmt out_fmt;
 	bool show_version;
 	bool comparison_mode;
@@ -214,8 +215,6 @@ static const struct argp_option opts[] =3D {
 	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for norm=
al mode, 1 for verbose mode)" },
 	{ "log-fixed", OPT_LOG_FIXED, NULL, 0, "Disable verifier log rotation" =
},
 	{ "log-size", OPT_LOG_SIZE, "BYTES", 0, "Customize verifier log size (d=
efault to 16MB)" },
-	{ "test-states", 't', NULL, 0,
-	  "Force frequent BPF verifier state checkpointing (set BPF_F_TEST_STAT=
E_FREQ program flag)" },
 	{ "top-n", 'n', "N", 0, "Emit only up to first N results." },
 	{ "quiet", 'q', NULL, 0, "Quiet mode" },
 	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
@@ -224,6 +223,10 @@ static const struct argp_option opts[] =3D {
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
@@ -295,6 +298,9 @@ static error_t parse_arg(int key, char *arg, struct a=
rgp_state *state)
 	case 't':
 		env.force_checkpoints =3D true;
 		break;
+	case 'r':
+		env.strict_range_sanity =3D true;
+		break;
 	case 'n':
 		errno =3D 0;
 		env.top_n =3D strtol(arg, NULL, 10);
@@ -302,7 +308,6 @@ static error_t parse_arg(int key, char *arg, struct a=
rgp_state *state)
 			fprintf(stderr, "invalid top N specifier: %s\n", arg);
 			argp_usage(state);
 		}
-		break;
 	case 'C':
 		env.comparison_mode =3D true;
 		break;
@@ -1023,6 +1028,8 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
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


