Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D8447166
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 05:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhKGEGr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 00:06:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhKGEGq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 00:06:46 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A741t0R029977
        for <bpf@vger.kernel.org>; Sat, 6 Nov 2021 21:04:04 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c5qdt440e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 21:04:04 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sat, 6 Nov 2021 21:04:03 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 495A88289C2C; Sat,  6 Nov 2021 21:04:02 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 5/9] selftests/bpf: free inner strings index in btf selftest
Date:   Sat, 6 Nov 2021 21:03:39 -0700
Message-ID: <20211107040343.583332-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107040343.583332-1-andrii@kernel.org>
References: <20211107040343.583332-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 1NbFKWzsIFNEWSu2JvzLKPEOo_7d5jFe
X-Proofpoint-ORIG-GUID: 1NbFKWzsIFNEWSu2JvzLKPEOo_7d5jFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1034 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=996 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111070022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Inner array of allocated strings wasn't freed on success. Now it's
always freed.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index ac596cb06e40..ebd1aa4d09d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4046,11 +4046,9 @@ static void *btf_raw_create(const struct btf_header *hdr,
 			next_str_idx < strs_cnt ? strs_idx[next_str_idx] : NULL;
 
 done:
+	free(strs_idx);
 	if (err) {
-		if (raw_btf)
-			free(raw_btf);
-		if (strs_idx)
-			free(strs_idx);
+		free(raw_btf);
 		return NULL;
 	}
 	return raw_btf;
-- 
2.30.2

