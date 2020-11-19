Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACB62B8B0F
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 06:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKSFfA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 00:35:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64922 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgKSFfA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Nov 2020 00:35:00 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ5Vcex014072
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2020 21:34:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Id+HyCEudedyTKebTDT+ZEdWEJjCn2qtG2UxpPl+z0M=;
 b=A8SNPerH4hRhWpJGLCPt/R6TiSf1zYND1M8V+zWtNG8dqnIbUqXi/MKh5UEJD6x8HTOS
 imqpXE18QbJb7b8DQ+7a30zQse6jBJDmXxbGrzHxC6J3qaDlF8Wn8JP0wwvgqOOZD1dj
 AUUjzRFAG+TolYXquwKqcEI7Xu3OztO8IU4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34wjmx815s-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2020 21:34:54 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 20:23:37 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 595D637056D0; Wed, 18 Nov 2020 20:23:32 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next] bpftool: add {i,d}tlb_misses support for bpftool profile
Date:   Wed, 18 Nov 2020 20:23:32 -0800
Message-ID: <20201119042332.3343146-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_01:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=13
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 47c09d6a9f67("bpftool: Introduce "prog profile" command")
introduced "bpftool prog profile" command which can be used
to profile bpf program with metrics like # of instructions,

This patch added support for itlb_misses and dtlb_misses.
During an internal bpf program performance evaluation,
I found these two metrics are also very useful. The following
is an example output:

 $ bpftool prog profile id 324 duration 3 cycles itlb_misses

           1885029 run_cnt
        5134686073 cycles
            306893 itlb_misses
 $ bpftool prog profile id 324 duration 3 cycles dtlb_misses

           1827382 run_cnt
        4943593648 cycles
           5975636 dtlb_misses
 $ bpftool prog profile id 324 duration 3 cycles llc_misses

           1836527 run_cnt
        5019612972 cycles
           4161041 llc_misses

From the above, we can see quite some dtlb misses, 3 dtlb misses
perf prog run. This might be something worth further investigation.

Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/prog.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index acdb2c245f0a..e33f27b950a5 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1717,11 +1717,39 @@ struct profile_metric {
 		.ratio_desc =3D "LLC misses per million insns",
 		.ratio_mul =3D 1e6,
 	},
+	{
+		.name =3D "itlb_misses",
+		.attr =3D {
+			.type =3D PERF_TYPE_HW_CACHE,
+			.config =3D
+				PERF_COUNT_HW_CACHE_ITLB |
+				(PERF_COUNT_HW_CACHE_OP_READ << 8) |
+				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
+			.exclude_user =3D 1
+		},
+		.ratio_metric =3D 2,
+		.ratio_desc =3D "itlb misses per million insns",
+		.ratio_mul =3D 1e6,
+	},
+	{
+		.name =3D "dtlb_misses",
+		.attr =3D {
+			.type =3D PERF_TYPE_HW_CACHE,
+			.config =3D
+				PERF_COUNT_HW_CACHE_DTLB |
+				(PERF_COUNT_HW_CACHE_OP_READ << 8) |
+				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
+			.exclude_user =3D 1
+		},
+		.ratio_metric =3D 2,
+		.ratio_desc =3D "dtlb misses per million insns",
+		.ratio_mul =3D 1e6,
+	},
 };
=20
 static __u64 profile_total_count;
=20
-#define MAX_NUM_PROFILE_METRICS 4
+#define MAX_NUM_PROFILE_METRICS 6
=20
 static int profile_parse_metrics(int argc, char **argv)
 {
@@ -2109,7 +2137,7 @@ static int do_help(int argc, char **argv)
 		"                 struct_ops | fentry | fexit | freplace | sk_lookup }=
\n"
 		"       ATTACH_TYPE :=3D { msg_verdict | stream_verdict | stream_parse=
r |\n"
 		"                        flow_dissector }\n"
-		"       METRIC :=3D { cycles | instructions | l1d_loads | llc_misses }=
\n"
+		"       METRIC :=3D { cycles | instructions | l1d_loads | llc_misses |=
 itlb_misses | dtlb_misses }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, argv[-2]);
--=20
2.24.1

