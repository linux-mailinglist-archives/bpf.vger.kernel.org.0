Return-Path: <bpf+bounces-14456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222667E4FDF
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5A52814D3
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 05:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852AA6AAB;
	Wed,  8 Nov 2023 05:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDF944C
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 05:15:02 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122D2198
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:15:02 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7NHQ2Q007580
	for <bpf@vger.kernel.org>; Tue, 7 Nov 2023 21:15:01 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u7w3djx1n-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 21:15:01 -0800
Received: from twshared9518.03.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 21:14:46 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 21AB83B23943B; Tue,  7 Nov 2023 21:14:35 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/2] veristat: add ability to filter top N results
Date: Tue, 7 Nov 2023 21:14:30 -0800
Message-ID: <20231108051430.1830950-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108051430.1830950-1-andrii@kernel.org>
References: <20231108051430.1830950-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IcSAofn3YUhEryuZqxLUYcz-IWZAIY0e
X-Proofpoint-GUID: IcSAofn3YUhEryuZqxLUYcz-IWZAIY0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02

Add ability to filter top B results, both in replay/verifier mode and
comparison mode. Just adding `-n10` will emit only first 10 rows, or
less, if there is not enough rows.

This is not just a shortcut instead of passing veristat output through
`head`, though. Filtering out all the other rows influences final table
formatting, as table column widths are calculated based on actual
emitted test.

To demonstrate the difference, compare two "equivalent" forms below, one
using head and another using -n argument.

TOP N FEATURE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[vmuser@archvm bpf]$ sudo ./veristat -C ~/baseline-results-selftests.csv =
~/sanity2-results-selftests.csv -e file,prog,insns,states -s '|insns_diff=
|' -n10
File                                      Program                Insns (A=
)  Insns (B)  Insns (DIFF)  States (A)  States (B)  States (DIFF)
----------------------------------------  ---------------------  --------=
-  ---------  ------------  ----------  ----------  -------------
test_seg6_loop.bpf.linked3.o              __add_egr_x                1244=
0      12360  -80 (-0.64%)         364         357    -7 (-1.92%)
async_stack_depth.bpf.linked3.o           async_call_root_check        14=
5        145   +0 (+0.00%)           3           3    +0 (+0.00%)
async_stack_depth.bpf.linked3.o           pseudo_call_check            13=
9        139   +0 (+0.00%)           3           3    +0 (+0.00%)
atomic_bounds.bpf.linked3.o               sub                            =
7          7   +0 (+0.00%)           0           0    +0 (+0.00%)
bench_local_storage_create.bpf.linked3.o  kmalloc                        =
5          5   +0 (+0.00%)           0           0    +0 (+0.00%)
bench_local_storage_create.bpf.linked3.o  sched_process_fork            2=
2         22   +0 (+0.00%)           2           2    +0 (+0.00%)
bench_local_storage_create.bpf.linked3.o  socket_post_create            2=
3         23   +0 (+0.00%)           2           2    +0 (+0.00%)
bind4_prog.bpf.linked3.o                  bind_v4_prog                 35=
8        358   +0 (+0.00%)          33          33    +0 (+0.00%)
bind6_prog.bpf.linked3.o                  bind_v6_prog                 42=
9        429   +0 (+0.00%)          37          37    +0 (+0.00%)
bind_perm.bpf.linked3.o                   bind_v4_prog                  1=
5         15   +0 (+0.00%)           1           1    +0 (+0.00%)

PIPING TO HEAD
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[vmuser@archvm bpf]$ sudo ./veristat -C ~/baseline-results-selftests.csv =
~/sanity2-results-selftests.csv -e file,prog,insns,states -s '|insns_diff=
|' | head -n12
File                                                   Program           =
                                    Insns (A)  Insns (B)  Insns (DIFF)  S=
tates (A)  States (B)  States (DIFF)
-----------------------------------------------------  ------------------=
----------------------------------  ---------  ---------  ------------  -=
---------  ----------  -------------
test_seg6_loop.bpf.linked3.o                           __add_egr_x       =
                                        12440      12360  -80 (-0.64%)   =
      364         357    -7 (-1.92%)
async_stack_depth.bpf.linked3.o                        async_call_root_ch=
eck                                       145        145   +0 (+0.00%)   =
        3           3    +0 (+0.00%)
async_stack_depth.bpf.linked3.o                        pseudo_call_check =
                                          139        139   +0 (+0.00%)   =
        3           3    +0 (+0.00%)
atomic_bounds.bpf.linked3.o                            sub               =
                                            7          7   +0 (+0.00%)   =
        0           0    +0 (+0.00%)
bench_local_storage_create.bpf.linked3.o               kmalloc           =
                                            5          5   +0 (+0.00%)   =
        0           0    +0 (+0.00%)
bench_local_storage_create.bpf.linked3.o               sched_process_fork=
                                           22         22   +0 (+0.00%)   =
        2           2    +0 (+0.00%)
bench_local_storage_create.bpf.linked3.o               socket_post_create=
                                           23         23   +0 (+0.00%)   =
        2           2    +0 (+0.00%)
bind4_prog.bpf.linked3.o                               bind_v4_prog      =
                                          358        358   +0 (+0.00%)   =
       33          33    +0 (+0.00%)
bind6_prog.bpf.linked3.o                               bind_v6_prog      =
                                          429        429   +0 (+0.00%)   =
       37          37    +0 (+0.00%)
bind_perm.bpf.linked3.o                                bind_v4_prog      =
                                           15         15   +0 (+0.00%)   =
        1           1    +0 (+0.00%)

Note all the wasted whitespace in the "PIPING TO HEAD" variant.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
index 102914f70573..443a29fc6a62 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -149,6 +149,7 @@ static struct env {
 	bool show_version;
 	bool comparison_mode;
 	bool replay_mode;
+	int top_n;
=20
 	int log_level;
 	int log_size;
@@ -215,6 +216,7 @@ static const struct argp_option opts[] =3D {
 	{ "log-size", OPT_LOG_SIZE, "BYTES", 0, "Customize verifier log size (d=
efault to 16MB)" },
 	{ "test-states", 't', NULL, 0,
 	  "Force frequent BPF verifier state checkpointing (set BPF_F_TEST_STAT=
E_FREQ program flag)" },
+	{ "top-n", 'n', "N", 0, "Emit only up to first N results." },
 	{ "quiet", 'q', NULL, 0, "Quiet mode" },
 	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
 	{ "sort", 's', "SPEC", 0, "Specify sort order" },
@@ -293,6 +295,14 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
 	case 't':
 		env.force_checkpoints =3D true;
 		break;
+	case 'n':
+		errno =3D 0;
+		env.top_n =3D strtol(arg, NULL, 10);
+		if (errno) {
+			fprintf(stderr, "invalid top N specifier: %s\n", arg);
+			argp_usage(state);
+		}
+		break;
 	case 'C':
 		env.comparison_mode =3D true;
 		break;
--=20
2.34.1


