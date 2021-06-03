Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863C239970B
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 02:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFCAmZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Jun 2021 20:42:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2334 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229746AbhFCAmW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Jun 2021 20:42:22 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1530eG7c025773
        for <bpf@vger.kernel.org>; Wed, 2 Jun 2021 17:40:38 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 38xby4bhqh-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Jun 2021 17:40:38 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:40:37 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id DB6022EDE105; Wed,  2 Jun 2021 17:40:30 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/4] libbpf: move few APIs from 0.4 to 0.5 version
Date:   Wed, 2 Jun 2021 17:40:23 -0700
Message-ID: <20210603004026.2698513-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603004026.2698513-1-andrii@kernel.org>
References: <20210603004026.2698513-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NGCTSvtF0UCv-p8VABds2z32ASuHQJXD
X-Proofpoint-GUID: NGCTSvtF0UCv-p8VABds2z32ASuHQJXD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=751 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106030002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Official libbpf 0.4 release doesn't include three APIs that were tentatively
put into 0.4 section. Fix libbpf.map and move these three APIs:
  - bpf_map__initial_value;
  - bpf_map_lookup_and_delete_elem_flags;
  - bpf_object__gen_loader.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.map | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index bbe99b1db1a9..944c99d1ded3 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -359,10 +359,7 @@ LIBBPF_0.4.0 {
 		bpf_linker__finalize;
 		bpf_linker__free;
 		bpf_linker__new;
-		bpf_map__initial_value;
 		bpf_map__inner_map;
-		bpf_map_lookup_and_delete_elem_flags;
-		bpf_object__gen_loader;
 		bpf_object__set_kversion;
 		bpf_tc_attach;
 		bpf_tc_detach;
@@ -373,5 +370,8 @@ LIBBPF_0.4.0 {
 
 LIBBPF_0.5.0 {
 	global:
+		bpf_map__initial_value;
+		bpf_map_lookup_and_delete_elem_flags;
+		bpf_object__gen_loader;
 		libbpf_set_strict_mode;
 } LIBBPF_0.4.0;
-- 
2.30.2

