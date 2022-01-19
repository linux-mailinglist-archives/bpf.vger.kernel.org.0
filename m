Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6578A494355
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 23:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbiASW6O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 19 Jan 2022 17:58:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11076 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357660AbiASW6C (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 17:58:02 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JIs5of031199
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 14:58:01 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dp99dxtht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 14:58:01 -0800
Received: from twshared21922.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 14:57:59 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 02EEAFB338B4; Wed, 19 Jan 2022 14:57:55 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/4] docs/bpf: update BPF map definition example
Date:   Wed, 19 Jan 2022 14:57:41 -0800
Message-ID: <20220119225741.2944240-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119225741.2944240-1-andrii@kernel.org>
References: <20220119225741.2944240-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pstiVQktQVRBDBcci8Wq-5AItnkL3wvz
X-Proofpoint-GUID: pstiVQktQVRBDBcci8Wq-5AItnkL3wvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use BTF-defined map definition in the documentation example.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 Documentation/bpf/btf.rst | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 1ebf4c5c7ddc..07165682da2b 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -565,18 +565,15 @@ A map can be created with ``btf_fd`` and specified key/value type id.::
 In libbpf, the map can be defined with extra annotation like below:
 ::
 
-    struct bpf_map_def SEC("maps") btf_map = {
-        .type = BPF_MAP_TYPE_ARRAY,
-        .key_size = sizeof(int),
-        .value_size = sizeof(struct ipv_counts),
-        .max_entries = 4,
-    };
-    BPF_ANNOTATE_KV_PAIR(btf_map, int, struct ipv_counts);
-
-Here, the parameters for macro BPF_ANNOTATE_KV_PAIR are map name, key and
-value types for the map. During ELF parsing, libbpf is able to extract
-key/value type_id's and assign them to BPF_MAP_CREATE attributes
-automatically.
+    struct {
+        __uint(type, BPF_MAP_TYPE_ARRAY);
+        __type(key, int);
+        __type(value, struct ipv_counts);
+        __uint(max_entries, 4);
+    } btf_map SEC(".maps");
+
+During ELF parsing, libbpf is able to extract key/value type_id's and assign
+them to BPF_MAP_CREATE attributes automatically.
 
 .. _BPF_Prog_Load:
 
-- 
2.30.2

