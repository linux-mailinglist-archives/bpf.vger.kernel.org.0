Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E83A474E7E
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 00:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbhLNXVF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 14 Dec 2021 18:21:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9140 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231684AbhLNXVF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Dec 2021 18:21:05 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BELbRqp017649
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 15:21:04 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cxqrbegn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 15:21:04 -0800
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 15:21:03 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5D683D22F502; Tue, 14 Dec 2021 15:20:55 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: avoid reading past ELF data section end when copying license
Date:   Tue, 14 Dec 2021 15:20:54 -0800
Message-ID: <20211214232054.3458774-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: j1IF2uemKKLW8QHpRZUmXmJz81VhnXzw
X-Proofpoint-ORIG-GUID: j1IF2uemKKLW8QHpRZUmXmJz81VhnXzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix possible read beyond ELF "license" data section if the license
string is not properly zero-terminated. Use the fact that libbpf_strlcpy
never accesses the (N-1)st byte of the source string because it's
replaced with '\0' anyways.

If this happens, it's a violation of contract between libbpf and a user,
but not handling this more robustly upsets CIFuzz, so given the fix is
trivial, let's fix the potential issue.

Fixes: 9fc205b413b3 ("libbpf: Add sane strncpy alternative and use it internally")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 684c34ce1a26..cf862a19222b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1320,7 +1320,10 @@ static int bpf_object__check_endianness(struct bpf_object *obj)
 static int
 bpf_object__init_license(struct bpf_object *obj, void *data, size_t size)
 {
-	libbpf_strlcpy(obj->license, data, sizeof(obj->license));
+	/* libbpf_strlcpy() only copies first N - 1 bytes, so size + 1 won't
+	 * go over allowed ELF data section buffer
+	 */
+	libbpf_strlcpy(obj->license, data, min(size + 1, sizeof(obj->license)));
 	pr_debug("license of %s is %s\n", obj->path, obj->license);
 	return 0;
 }
-- 
2.30.2

