Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0984155D352
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiF0VQT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Jun 2022 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbiF0VQS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:16:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141CC186C9
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:18 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25RJ1SEh018850
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:17 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gwx1v5qkx-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:16:17 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:16:05 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B5D241BAC2805; Mon, 27 Jun 2022 14:16:00 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 15/15] libbpf: fix up few libbpf.map problems
Date:   Mon, 27 Jun 2022 14:15:27 -0700
Message-ID: <20220627211527.2245459-16-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627211527.2245459-1-andrii@kernel.org>
References: <20220627211527.2245459-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: egHxNNs9DG1UBbNmmvu0R45FysMgSx0z
X-Proofpoint-GUID: egHxNNs9DG1UBbNmmvu0R45FysMgSx0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Seems like we missed to add 2 APIs to libbpf.map and another API was
misspelled. Fix it in libbpf.map.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.map      | 3 ++-
 tools/lib/bpf/libbpf_legacy.h | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 236efc7338f1..43c6697a6d27 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -326,10 +326,11 @@ LIBBPF_0.7.0 {
 		bpf_xdp_detach;
 		bpf_xdp_query;
 		bpf_xdp_query_id;
+		btf_ext__raw_data;
 		libbpf_probe_bpf_helper;
 		libbpf_probe_bpf_map_type;
 		libbpf_probe_bpf_prog_type;
-		libbpf_set_memlock_rlim_max;
+		libbpf_set_memlock_rlim;
 } LIBBPF_0.6.0;
 
 LIBBPF_0.8.0 {
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index 863f49df8bf4..5b7e0155db6a 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -76,8 +76,8 @@ enum libbpf_strict_mode {
 	 * first BPF program or map creation operation. This is done only if
 	 * kernel is too old to support memcg-based memory accounting for BPF
 	 * subsystem. By default, RLIMIT_MEMLOCK limit is set to RLIM_INFINITY,
-	 * but it can be overriden with libbpf_set_memlock_rlim_max() API.
-	 * Note that libbpf_set_memlock_rlim_max() needs to be called before
+	 * but it can be overriden with libbpf_set_memlock_rlim() API.
+	 * Note that libbpf_set_memlock_rlim() needs to be called before
 	 * the very first bpf_prog_load(), bpf_map_create() or bpf_object__load()
 	 * operation.
 	 */
-- 
2.30.2

