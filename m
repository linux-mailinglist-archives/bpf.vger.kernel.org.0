Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A03A49471C
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 07:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiATGGI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 01:06:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358659AbiATGGF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 01:06:05 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K3RW4S011677
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:06:04 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpyup0mqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:06:04 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 22:06:03 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id F0854FB9D583; Wed, 19 Jan 2022 22:05:50 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 4/4] docs/bpf: update BPF map definition example
Date:   Wed, 19 Jan 2022 22:05:29 -0800
Message-ID: <20220120060529.1890907-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120060529.1890907-1-andrii@kernel.org>
References: <20220120060529.1890907-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uWyWFcycAV0cfDJuYDl_Ww7WCgZ3bp6L
X-Proofpoint-GUID: uWyWFcycAV0cfDJuYDl_Ww7WCgZ3bp6L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=3
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use BTF-defined map definition in the documentation example.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 Documentation/bpf/btf.rst | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 1ebf4c5c7ddc..ab08852e53ae 100644
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
+    struct {
+        __uint(type, BPF_MAP_TYPE_ARRAY);
+        __type(key, int);
+        __type(value, struct ipv_counts);
+        __uint(max_entries, 4);
+    } btf_map SEC(".maps");
 
-Here, the parameters for macro BPF_ANNOTATE_KV_PAIR are map name, key and
-value types for the map. During ELF parsing, libbpf is able to extract
-key/value type_id's and assign them to BPF_MAP_CREATE attributes
-automatically.
+During ELF parsing, libbpf is able to extract key/value type_id's and assign
+them to BPF_MAP_CREATE attributes automatically.
 
 .. _BPF_Prog_Load:
 
@@ -824,13 +821,12 @@ structure has bitfields. For example, for the following map,::
            ___A b1:4;
            enum A b2:4;
       };
-      struct bpf_map_def SEC("maps") tmpmap = {
-           .type = BPF_MAP_TYPE_ARRAY,
-           .key_size = sizeof(__u32),
-           .value_size = sizeof(struct tmp_t),
-           .max_entries = 1,
-      };
-      BPF_ANNOTATE_KV_PAIR(tmpmap, int, struct tmp_t);
+      struct {
+           __uint(type, BPF_MAP_TYPE_ARRAY);
+           __type(key, int);
+           __type(value, struct tmp_t);
+           __uint(max_entries, 1);
+      } tmpmap SEC(".maps");
 
 bpftool is able to pretty print like below:
 ::
-- 
2.30.2

