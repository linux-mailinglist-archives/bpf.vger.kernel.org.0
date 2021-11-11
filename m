Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E52444D1AF
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 06:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhKKFji convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 11 Nov 2021 00:39:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21042 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhKKFjh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 00:39:37 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB5X1PD019818
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:36:49 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c8n6w3ap3-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:36:49 -0800
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 10 Nov 2021 21:36:43 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0A8398B10659; Wed, 10 Nov 2021 21:36:41 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 8/9] tools/runqslower: update perf_buffer__new() calls
Date:   Wed, 10 Nov 2021 21:36:23 -0800
Message-ID: <20211111053624.190580-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111053624.190580-1-andrii@kernel.org>
References: <20211111053624.190580-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: FIGg_Esz03_wXaEKv7XNSF0c4-7F4c4V
X-Proofpoint-ORIG-GUID: FIGg_Esz03_wXaEKv7XNSF0c4-7F4c4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=907
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use v1.0+ compatible variant of perf_buffer__new() call to prepare for
deprecation.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/runqslower/runqslower.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/runqslower/runqslower.c b/tools/bpf/runqslower/runqslower.c
index d89715844952..2414cc764461 100644
--- a/tools/bpf/runqslower/runqslower.c
+++ b/tools/bpf/runqslower/runqslower.c
@@ -123,7 +123,6 @@ int main(int argc, char **argv)
 		.parser = parse_arg,
 		.doc = argp_program_doc,
 	};
-	struct perf_buffer_opts pb_opts;
 	struct perf_buffer *pb = NULL;
 	struct runqslower_bpf *obj;
 	int err;
@@ -165,9 +164,8 @@ int main(int argc, char **argv)
 	printf("Tracing run queue latency higher than %llu us\n", env.min_us);
 	printf("%-8s %-16s %-6s %14s\n", "TIME", "COMM", "PID", "LAT(us)");
 
-	pb_opts.sample_cb = handle_event;
-	pb_opts.lost_cb = handle_lost_events;
-	pb = perf_buffer__new(bpf_map__fd(obj->maps.events), 64, &pb_opts);
+	pb = perf_buffer__new(bpf_map__fd(obj->maps.events), 64,
+			      handle_event, handle_lost_events, NULL, NULL);
 	err = libbpf_get_error(pb);
 	if (err) {
 		pb = NULL;
-- 
2.30.2

