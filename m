Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B77F447165
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 05:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhKGEGq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 00:06:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16290 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhKGEGp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 00:06:45 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A73mO6c019316
        for <bpf@vger.kernel.org>; Sat, 6 Nov 2021 21:04:04 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c5ptvv7r3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 21:04:03 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sat, 6 Nov 2021 21:04:01 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2A8A28289BE6; Sat,  6 Nov 2021 21:03:58 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 3/9] selftests/bpf: fix memory leaks in btf_type_c_dump() helper
Date:   Sat, 6 Nov 2021 21:03:37 -0700
Message-ID: <20211107040343.583332-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107040343.583332-1-andrii@kernel.org>
References: <20211107040343.583332-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Bl--qta2Mwa73Ze9-kvEqwngZ0dEhlpx
X-Proofpoint-ORIG-GUID: Bl--qta2Mwa73Ze9-kvEqwngZ0dEhlpx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=857 malwarescore=0 phishscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111070023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Free up memory and resources used by temporary allocated memstream and
btf_dump instance.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/btf_helpers.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index b5b6b013a245..3d1a748d09d8 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -251,18 +251,23 @@ const char *btf_type_c_dump(const struct btf *btf)
 	d = btf_dump__new(btf, NULL, &opts, btf_dump_printf);
 	if (libbpf_get_error(d)) {
 		fprintf(stderr, "Failed to create btf_dump instance: %ld\n", libbpf_get_error(d));
-		return NULL;
+		goto err_out;
 	}
 
 	for (i = 1; i < btf__type_cnt(btf); i++) {
 		err = btf_dump__dump_type(d, i);
 		if (err) {
 			fprintf(stderr, "Failed to dump type [%d]: %d\n", i, err);
-			return NULL;
+			goto err_out;
 		}
 	}
 
+	btf_dump__free(d);
 	fflush(buf_file);
 	fclose(buf_file);
 	return buf;
+err_out:
+	btf_dump__free(d);
+	fclose(buf_file);
+	return NULL;
 }
-- 
2.30.2

