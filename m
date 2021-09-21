Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4054413BF0
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 23:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhIUVFr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 21 Sep 2021 17:05:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29112 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232953AbhIUVFq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 17:05:46 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LH9ajI003908
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:04:18 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b73aqfhfv-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:04:18 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 14:00:45 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 283BA49ACEFD; Tue, 21 Sep 2021 14:00:40 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 1/4] libbpf: fix memory leak in legacy kprobe attach logic
Date:   Tue, 21 Sep 2021 14:00:33 -0700
Message-ID: <20210921210036.1545557-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921210036.1545557-1-andrii@kernel.org>
References: <20210921210036.1545557-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: yryCP_yOzAs1fTfAbJmGd5goche0F_8j
X-Proofpoint-ORIG-GUID: yryCP_yOzAs1fTfAbJmGd5goche0F_8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_06,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=897 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In some error scenarios legacy_probe string won't be free()'d. Fix this.
This was reported by Coverity static analysis.

Fixes: ca304b40c20d ("libbpf: Introduce legacy kprobe events support")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index da65a1666a5e..6d2f12db6034 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9365,10 +9365,11 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 						    offset, -1 /* pid */);
 	}
 	if (pfd < 0) {
+		err = pfd;
 		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
-			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
-		return libbpf_err_ptr(pfd);
+			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		goto err_out;
 	}
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
@@ -9377,7 +9378,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		pr_warn("prog '%s': failed to attach to %s '%s': %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
 			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
-		return libbpf_err_ptr(err);
+		goto err_out;
 	}
 	if (legacy) {
 		struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
@@ -9387,6 +9388,9 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	}
 
 	return link;
+err_out:
+	free(legacy_probe);
+	return libbpf_err_ptr(err);
 }
 
 struct bpf_link *bpf_program__attach_kprobe(const struct bpf_program *prog,
-- 
2.30.2

