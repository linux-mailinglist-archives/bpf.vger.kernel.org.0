Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284D7498F41
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 20:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347732AbiAXTvj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 24 Jan 2022 14:51:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347983AbiAXTnO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 14:43:14 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20OHVkSC005042
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 11:43:13 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dssx9umv8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 11:43:13 -0800
Received: from twshared10426.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 11:43:12 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 699B6FF02B13; Mon, 24 Jan 2022 11:43:09 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 7/7] perf: use generic bpf_program__set_type() to set BPF prog type
Date:   Mon, 24 Jan 2022 11:42:54 -0800
Message-ID: <20220124194254.2051434-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124194254.2051434-1-andrii@kernel.org>
References: <20220124194254.2051434-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sAUg6fM5XRzckxPIHZ7vwyd5xaj-oQmp
X-Proofpoint-GUID: sAUg6fM5XRzckxPIHZ7vwyd5xaj-oQmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=957 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201240129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_program__set_<type>() APIs are deprecated, use generic
bpf_program__set_type() APIs instead.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/util/bpf-loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 4631cac3957f..b54415f2495d 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -651,11 +651,11 @@ int bpf__probe(struct bpf_object *obj)
 		}
 
 		if (priv->is_tp) {
-			bpf_program__set_tracepoint(prog);
+			bpf_program__set_type(prog, BPF_PROG_TYPE_TRACEPOINT);
 			continue;
 		}
 
-		bpf_program__set_kprobe(prog);
+		bpf_program__set_type(prog, BPF_PROG_TYPE_KPROBE);
 		pev = &priv->pev;
 
 		err = convert_perf_probe_events(pev, 1);
-- 
2.30.2

