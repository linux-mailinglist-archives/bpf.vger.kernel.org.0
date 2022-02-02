Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2733D4A7B5C
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 23:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiBBW7g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Feb 2022 17:59:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8658 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1347968AbiBBW7f (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 17:59:35 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 212LW648019064
        for <bpf@vger.kernel.org>; Wed, 2 Feb 2022 14:59:35 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dybqp8btj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 14:59:34 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:59:32 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2C989103F6E49; Wed,  2 Feb 2022 14:59:24 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 2/6] bpftool: stop supporting BPF offload-enabled feature probing
Date:   Wed, 2 Feb 2022 14:59:12 -0800
Message-ID: <20220202225916.3313522-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202225916.3313522-1-andrii@kernel.org>
References: <20220202225916.3313522-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: d8hmHgHKZQzMVubFvxPHWq_uVNEBTKFI
X-Proofpoint-ORIG-GUID: d8hmHgHKZQzMVubFvxPHWq_uVNEBTKFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=835 mlxscore=0 impostorscore=0 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf 1.0 is not going to support passing ifindex to BPF
prog/map/helper feature probing APIs. Remove the support for BPF offload
feature probing.

Cc: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/feature.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index e999159fa28d..9c894b1447de 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -487,17 +487,12 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
 	size_t maxlen;
 	bool res;
 
-	if (ifindex)
-		/* Only test offload-able program types */
-		switch (prog_type) {
-		case BPF_PROG_TYPE_SCHED_CLS:
-		case BPF_PROG_TYPE_XDP:
-			break;
-		default:
-			return;
-		}
+	if (ifindex) {
+		p_info("BPF offload feature probing is not supported");
+		return;
+	}
 
-	res = bpf_probe_prog_type(prog_type, ifindex);
+	res = libbpf_probe_bpf_prog_type(prog_type, NULL);
 #ifdef USE_LIBCAP
 	/* Probe may succeed even if program load fails, for unprivileged users
 	 * check that we did not fail because of insufficient permissions
@@ -535,7 +530,12 @@ probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
 	size_t maxlen;
 	bool res;
 
-	res = bpf_probe_map_type(map_type, ifindex);
+	if (ifindex) {
+		p_info("BPF offload feature probing is not supported");
+		return;
+	}
+
+	res = libbpf_probe_bpf_map_type(map_type, NULL);
 
 	/* Probe result depends on the success of map creation, no additional
 	 * check required for unprivileged users
@@ -567,7 +567,12 @@ probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 	bool res = false;
 
 	if (supported_type) {
-		res = bpf_probe_helper(id, prog_type, ifindex);
+		if (ifindex) {
+			p_info("BPF offload feature probing is not supported");
+			return;
+		}
+
+		res = libbpf_probe_bpf_helper(prog_type, id, NULL);
 #ifdef USE_LIBCAP
 		/* Probe may succeed even if program load fails, for
 		 * unprivileged users check that we did not fail because of
-- 
2.30.2

