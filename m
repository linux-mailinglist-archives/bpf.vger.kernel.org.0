Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C332A8EDB
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 06:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgKFFZ5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 6 Nov 2020 00:25:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45190 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbgKFFZ4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Nov 2020 00:25:56 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A65FAQO018023
        for <bpf@vger.kernel.org>; Thu, 5 Nov 2020 21:25:56 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34m5rr7rb8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 21:25:56 -0800
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 21:25:54 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 7D1582EC8EF6; Thu,  5 Nov 2020 21:25:53 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH dwarves 1/4] btf_encoder: fix array index type numbering
Date:   Thu, 5 Nov 2020 21:25:46 -0800
Message-ID: <20201106052549.3782099-2-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201106052549.3782099-1-andrii@kernel.org>
References: <20201106052549.3782099-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_01:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1034 lowpriorityscore=0 bulkscore=0 suspectscore=8
 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0 impostorscore=0
 spamscore=0 mlxlogscore=948 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011060036
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Take into account type ID offset, accumulated from previous CUs, when
calculating a new type ID for the generated array index type.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 btf_encoder.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 4c92908beab2..b3e47f172bb3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -358,22 +358,22 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 			printf("File %s:\n", btfe->filename);
 	}
 
+	btf_elf__verbose = verbose;
+	btf_elf__force = force;
+	type_id_off = btf__get_nr_types(btfe->btf);
+
 	if (!has_index_type) {
 		/* cu__find_base_type_by_name() takes "type_id_t *id" */
 		type_id_t id;
 		if (cu__find_base_type_by_name(cu, "int", &id)) {
 			has_index_type = true;
-			array_index_id = id;
+			array_index_id = type_id_off + id;
 		} else {
 			has_index_type = false;
-			array_index_id = cu->types_table.nr_entries;
+			array_index_id = type_id_off + cu->types_table.nr_entries;
 		}
 	}
 
-	btf_elf__verbose = verbose;
-	btf_elf__force = force;
-	type_id_off = btf__get_nr_types(btfe->btf);
-
 	cu__for_each_type(cu, core_id, pos) {
 		int32_t btf_type_id = tag__encode_btf(cu, pos, core_id, btfe, array_index_id, type_id_off);
 
-- 
2.24.1

