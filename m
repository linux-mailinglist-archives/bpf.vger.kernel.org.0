Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82775476AC3
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 08:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhLPHEz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 16 Dec 2021 02:04:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234316AbhLPHEy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 02:04:54 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG4B8Bs022222
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:04:54 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cyuqssd6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:04:54 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 23:04:53 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 68803D51C039; Wed, 15 Dec 2021 23:04:49 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 3/3] bpftool: reimplement large insn size limit feature probing
Date:   Wed, 15 Dec 2021 23:04:42 -0800
Message-ID: <20211216070442.1492204-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216070442.1492204-1-andrii@kernel.org>
References: <20211216070442.1492204-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: m_hJPwqdoZT-1qoS8KDtKp8Ujcyzj735
X-Proofpoint-ORIG-GUID: m_hJPwqdoZT-1qoS8KDtKp8Ujcyzj735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_02,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reimplement bpf_probe_large_insn_limit() in bpftool, as that libbpf API
is scheduled for deprecation in v0.8.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/feature.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 5397077d0d9e..6719b9282eca 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -642,12 +642,32 @@ probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 		printf("\n");
 }
 
-static void
-probe_large_insn_limit(const char *define_prefix, __u32 ifindex)
+/*
+ * Probe for availability of kernel commit (5.3):
+ *
+ * c04c0d2b968a ("bpf: increase complexity limit and maximum program size")
+ */
+static void probe_large_insn_limit(const char *define_prefix, __u32 ifindex)
 {
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.prog_ifindex = ifindex,
+	);
+	struct bpf_insn insns[BPF_MAXINSNS + 1];
 	bool res;
+	int i, fd;
+
+	for (i = 0; i < BPF_MAXINSNS; i++)
+		insns[i] = BPF_MOV64_IMM(BPF_REG_0, 1);
+	insns[BPF_MAXINSNS] = BPF_EXIT_INSN();
+
+	errno = 0;
+	fd = bpf_prog_load(BPF_PROG_TYPE_SCHED_CLS, NULL, "GPL",
+			   insns, ARRAY_SIZE(insns), &opts);
+	res = fd >= 0 || (errno != E2BIG && errno != EINVAL);
+
+	if (fd >= 0)
+		close(fd);
 
-	res = bpf_probe_large_insn_limit(ifindex);
 	print_bool_feature("have_large_insn_limit",
 			   "Large program size limit",
 			   "LARGE_INSN_LIMIT",
-- 
2.30.2

