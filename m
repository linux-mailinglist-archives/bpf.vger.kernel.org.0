Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277414659D3
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 00:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhLAXcE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 1 Dec 2021 18:32:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23230 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353778AbhLAXcC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 18:32:02 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LcidI026450
        for <bpf@vger.kernel.org>; Wed, 1 Dec 2021 15:28:40 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cpd6atnua-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 15:28:40 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:28:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id F0F23B7A0AB2; Wed,  1 Dec 2021 15:28:26 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/9] libbpf: use __u32 fields in bpf_map_create_opts
Date:   Wed, 1 Dec 2021 15:28:16 -0800
Message-ID: <20211201232824.3166325-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201232824.3166325-1-andrii@kernel.org>
References: <20211201232824.3166325-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: gXn2NLEyEe2VGf5Apn0QSi_5lbO7A6L1
X-Proofpoint-GUID: gXn2NLEyEe2VGf5Apn0QSi_5lbO7A6L1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=541 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Corresponding Linux UAPI struct uses __u32, not int, so keep it
consistent.

Fixes: 992c4225419a3 ("992c4225419a libbpf: Unify low-level map creation APIs w/ new bpf_map_create()")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 70b6f44fc8b0..f79e5fbcf1c1 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -43,12 +43,12 @@ struct bpf_map_create_opts {
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_value_type_id;
 
-	int inner_map_fd;
-	int map_flags;
+	__u32 inner_map_fd;
+	__u32 map_flags;
 	__u64 map_extra;
 
-	int numa_node;
-	int map_ifindex;
+	__u32 numa_node;
+	__u32 map_ifindex;
 };
 #define bpf_map_create_opts__last_field map_ifindex
 
-- 
2.30.2

