Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E063676EE
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 03:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhDVBqj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 21 Apr 2021 21:46:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62562 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234099AbhDVBqi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Apr 2021 21:46:38 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13M1hfte019611
        for <bpf@vger.kernel.org>; Wed, 21 Apr 2021 18:46:04 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 382ksdcwnu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 21 Apr 2021 18:46:03 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 18:46:02 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id A78362ED59F8; Wed, 21 Apr 2021 18:46:00 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/6] selftests/bpf: document latest Clang fix expectations for linking tests
Date:   Wed, 21 Apr 2021 18:45:51 -0700
Message-ID: <20210422014556.3451936-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422014556.3451936-1-andrii@kernel.org>
References: <20210422014556.3451936-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _4tmNP3ZVSI-vNVgOO9AkmOqssUVbe3l
X-Proofpoint-ORIG-GUID: _4tmNP3ZVSI-vNVgOO9AkmOqssUVbe3l
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_08:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1034 mlxscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220014
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Document which fixes are required to generate correct static linking
selftests.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/README.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index 65fe318d1e71..3353778c30f8 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -193,3 +193,12 @@ Without it, the error from compiling bpf selftests looks like:
   libbpf: failed to find BTF for extern 'tcp_slow_start' [25] section: -2
 
 __ https://reviews.llvm.org/D93563
+
+Clang dependencies for static linking tests
+===========================================
+
+linked_vars, linked_maps, and linked_funcs tests depend on `Clang fix`__ to
+generate valid BTF information for weak variables. Please make sure you use
+Clang that contains the fix.
+
+__ https://reviews.llvm.org/D100362
-- 
2.30.2

