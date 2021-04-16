Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA5336292F
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 22:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbhDPUYi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 16 Apr 2021 16:24:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11004 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245498AbhDPUYh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 16:24:37 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GKKI53022045
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 13:24:12 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37yb5j2f62-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 13:24:12 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 13:24:12 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 4B53C2ED4EE0; Fri, 16 Apr 2021 13:24:11 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 03/17] libbpf: suppress compiler warning when using SEC() macro with externs
Date:   Fri, 16 Apr 2021 13:23:50 -0700
Message-ID: <20210416202404.3443623-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416202404.3443623-1-andrii@kernel.org>
References: <20210416202404.3443623-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lnFcmY9Ysjn0MdSmH6hwRUAVpWrwzHDR
X-Proofpoint-ORIG-GUID: lnFcmY9Ysjn0MdSmH6hwRUAVpWrwzHDR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When used on externs SEC() macro will trigger compilation warning about
inapplicable `__attribute__((used))`. That's expected for extern declarations,
so suppress it with the corresponding _Pragma.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index b904128626c2..75c7581b304c 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -25,9 +25,16 @@
 /*
  * Helper macro to place programs, maps, license in
  * different sections in elf_bpf file. Section names
- * are interpreted by elf_bpf loader
+ * are interpreted by libbpf depending on the context (BPF programs, BPF maps,
+ * extern variables, etc).
+ * To allow use of SEC() with externs (e.g., for extern .maps declarations),
+ * make sure __attribute__((unused)) doesn't trigger compilation warning.
  */
-#define SEC(NAME) __attribute__((section(NAME), used))
+#define SEC(name) \
+	_Pragma("GCC diagnostic push")					    \
+	_Pragma("GCC diagnostic ignored \"-Wignored-attributes\"")	    \
+	__attribute__((section(name), used))				    \
+	_Pragma("GCC diagnostic pop")					    \
 
 /* Avoid 'linux/stddef.h' definition of '__always_inline'. */
 #undef __always_inline
-- 
2.30.2

