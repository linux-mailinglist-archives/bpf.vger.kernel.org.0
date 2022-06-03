Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B19C53D227
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 21:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347977AbiFCTGh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 3 Jun 2022 15:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350034AbiFCTG2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 15:06:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7659C31232
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 12:06:27 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253GmQVb031332
        for <bpf@vger.kernel.org>; Fri, 3 Jun 2022 12:06:27 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3geubb1tyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 12:06:26 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 3 Jun 2022 12:06:25 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4E1761AC9C469; Fri,  3 Jun 2022 12:04:02 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 15/15] libbpf: fix up few libbpf.map problems
Date:   Fri, 3 Jun 2022 12:01:55 -0700
Message-ID: <20220603190155.3924899-16-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603190155.3924899-1-andrii@kernel.org>
References: <20220603190155.3924899-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oUxE6nz70_pEK5h-swzYilaDU3161L0v
X-Proofpoint-ORIG-GUID: oUxE6nz70_pEK5h-swzYilaDU3161L0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_06,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 38054248c942..9817ba8b61bd 100644
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

