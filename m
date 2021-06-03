Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D0D399708
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 02:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFCAmV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Jun 2021 20:42:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52312 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbhFCAmV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Jun 2021 20:42:21 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1530VArQ020395
        for <bpf@vger.kernel.org>; Wed, 2 Jun 2021 17:40:37 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38wn32u7b2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Jun 2021 17:40:37 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:40:36 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id F3B652EDE105; Wed,  2 Jun 2021 17:40:34 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/4] libbpf: install skel_internal.h header used from light skeletons
Date:   Wed, 2 Jun 2021 17:40:25 -0700
Message-ID: <20210603004026.2698513-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603004026.2698513-1-andrii@kernel.org>
References: <20210603004026.2698513-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vnvFI0FHJpG_QnS351NULwV05ZyW7CWP
X-Proofpoint-ORIG-GUID: vnvFI0FHJpG_QnS351NULwV05ZyW7CWP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1034 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Light skeleton code assumes skel_internal.h header to be installed system-wide
by libbpf package. Make sure it is actually installed.

Fixes: 67234743736a ("libbpf: Generate loader program out of BPF ELF file.")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index d1b909e005dc..ec14aa725bb0 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -225,7 +225,7 @@ install_lib: all_cmd
 
 INSTALL_HEADERS = bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk.h \
 		  bpf_helpers.h $(BPF_HELPER_DEFS) bpf_tracing.h	     \
-		  bpf_endian.h bpf_core_read.h
+		  bpf_endian.h bpf_core_read.h skel_internal.h
 
 install_headers: $(BPF_HELPER_DEFS)
 	$(call QUIET_INSTALL, headers)					     \
-- 
2.30.2

