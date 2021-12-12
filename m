Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75D8471C77
	for <lists+bpf@lfdr.de>; Sun, 12 Dec 2021 20:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhLLTNu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 12 Dec 2021 14:13:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39486 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229749AbhLLTNt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 12 Dec 2021 14:13:49 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BCHCpd3029980
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 11:13:49 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cwbxajhq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 11:13:49 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 12 Dec 2021 11:13:47 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D8EA9CD64F42; Sun, 12 Dec 2021 11:13:43 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: remove last bpf_create_map_xattr from test_verifier
Date:   Sun, 12 Dec 2021 11:13:41 -0800
Message-ID: <20211212191341.2529573-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: UlLfy9fMd6T3_pM8do7u7TTzys2OT8Nh
X-Proofpoint-GUID: UlLfy9fMd6T3_pM8do7u7TTzys2OT8Nh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-12_08,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=873 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112120118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_create_map_xattr() call was reintroduced after merging bpf tree into
bpf-next tree. Convert the last instance into bpf_map_create() call.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 16ce2ad097f4..ad5d30bafd93 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -701,22 +701,18 @@ static int create_sk_storage_map(void)
 
 static int create_map_timer(void)
 {
-	struct bpf_create_map_attr attr = {
-		.name = "test_map",
-		.map_type = BPF_MAP_TYPE_ARRAY,
-		.key_size = 4,
-		.value_size = 16,
-		.max_entries = 1,
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
 		.btf_key_type_id = 1,
 		.btf_value_type_id = 5,
-	};
+	);
 	int fd, btf_fd;
 
 	btf_fd = load_btf();
 	if (btf_fd < 0)
 		return -1;
-	attr.btf_fd = btf_fd;
-	fd = bpf_create_map_xattr(&attr);
+
+	opts.btf_fd = btf_fd;
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "test_map", 4, 16, 1, &opts);
 	if (fd < 0)
 		printf("Failed to create map with timer\n");
 	return fd;
-- 
2.30.2

