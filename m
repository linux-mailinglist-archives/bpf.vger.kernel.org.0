Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED13D2BBC58
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 03:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgKUCqi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Nov 2020 21:46:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30802 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbgKUCqh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Nov 2020 21:46:37 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AL2eCAt017777
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 18:46:36 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34xat44x7e-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 18:46:36 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 18:46:35 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 576672EC9CD8; Fri, 20 Nov 2020 18:46:33 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 6/7] selftests/bpf: make BPF sidecar traceable function global
Date:   Fri, 20 Nov 2020 18:46:15 -0800
Message-ID: <20201121024616.1588175-7-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201121024616.1588175-1-andrii@kernel.org>
References: <20201121024616.1588175-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_17:2020-11-20,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=8 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxlogscore=704 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011210019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pahole currently isn't able to generate BTF for static functions in kernel
modules, so make sure traced sidecar function is global.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bpf_sidecar/bpf_sidecar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_sidecar/bpf_sidecar.c b/tools/testing/selftests/bpf/bpf_sidecar/bpf_sidecar.c
index 46f48c20d99b..a2f6d4a15a3f 100644
--- a/tools/testing/selftests/bpf/bpf_sidecar/bpf_sidecar.c
+++ b/tools/testing/selftests/bpf/bpf_sidecar/bpf_sidecar.c
@@ -10,7 +10,7 @@
 #define CREATE_TRACE_POINTS
 #include "bpf_sidecar-events.h"
 
-static noinline ssize_t
+noinline ssize_t
 bpf_sidecar_test_read(struct file *file, struct kobject *kobj,
 		      struct bin_attribute *bin_attr,
 		      char *buf, loff_t off, size_t len)
@@ -25,6 +25,7 @@ bpf_sidecar_test_read(struct file *file, struct kobject *kobj,
 
 	return -EIO; /* always fail */
 }
+EXPORT_SYMBOL(bpf_sidecar_test_read);
 ALLOW_ERROR_INJECTION(bpf_sidecar_test_read, ERRNO);
 
 static struct bin_attribute bin_attr_bpf_sidecar_file __ro_after_init = {
-- 
2.24.1

