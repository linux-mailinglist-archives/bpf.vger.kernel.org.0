Return-Path: <bpf+bounces-59-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77876F79EF
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E441C21606
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC12EDE;
	Fri,  5 May 2023 00:09:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52F621
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:09:39 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9B512E8C
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 17:09:32 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 344JkM6e027962
	for <bpf@vger.kernel.org>; Thu, 4 May 2023 17:09:31 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3qck50sfuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 May 2023 17:09:31 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 17:09:29 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 474433002F927; Thu,  4 May 2023 17:09:17 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 01/10] veristat: add -t flag for adding BPF_F_TEST_STATE_FREQ program flag
Date: Thu, 4 May 2023 17:08:59 -0700
Message-ID: <20230505000908.1265044-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505000908.1265044-1-andrii@kernel.org>
References: <20230505000908.1265044-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XEvTAcU2slGsL-iwHTLRguqZCz_GiUlV
X-Proofpoint-GUID: XEvTAcU2slGsL-iwHTLRguqZCz_GiUlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sometimes during debugging it's important that BPF program is loaded
with BPF_F_TEST_STATE_FREQ flag set to force verifier to do frequent
state checkpointing. Teach veristat to do this when -t ("test state")
flag is specified.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
index 1db7185181da..655095810d4a 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -141,6 +141,7 @@ static struct env {
 	bool verbose;
 	bool debug;
 	bool quiet;
+	bool force_checkpoints;
 	enum resfmt out_fmt;
 	bool show_version;
 	bool comparison_mode;
@@ -209,6 +210,8 @@ static const struct argp_option opts[] =3D {
 	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for norm=
al mode, 1 for verbose mode)" },
 	{ "log-fixed", OPT_LOG_FIXED, NULL, 0, "Disable verifier log rotation" =
},
 	{ "log-size", OPT_LOG_SIZE, "BYTES", 0, "Customize verifier log size (d=
efault to 16MB)" },
+	{ "test-states", 't', NULL, 0,
+	  "Force frequent BPF verifier state checkpointing (set BPF_F_TEST_STAT=
E_FREQ program flag)" },
 	{ "quiet", 'q', NULL, 0, "Quiet mode" },
 	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
 	{ "sort", 's', "SPEC", 0, "Specify sort order" },
@@ -284,6 +287,9 @@ static error_t parse_arg(int key, char *arg, struct a=
rgp_state *state)
 			argp_usage(state);
 		}
 		break;
+	case 't':
+		env.force_checkpoints =3D true;
+		break;
 	case 'C':
 		env.comparison_mode =3D true;
 		break;
@@ -989,6 +995,9 @@ static int process_prog(const char *filename, struct =
bpf_object *obj, struct bpf
 	/* increase chances of successful BPF object loading */
 	fixup_obj(obj, prog, base_filename);
=20
+	if (env.force_checkpoints)
+		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_STA=
TE_FREQ);
+
 	err =3D bpf_object__load(obj);
 	env.progs_processed++;
=20
--=20
2.34.1


