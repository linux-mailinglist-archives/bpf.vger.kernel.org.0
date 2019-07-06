Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF5161296
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2019 20:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfGFSGm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Jul 2019 14:06:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727134AbfGFSGl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 6 Jul 2019 14:06:41 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x66I6aru014931
        for <bpf@vger.kernel.org>; Sat, 6 Jul 2019 11:06:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=mvxcXsTXdLBjraFljdqrxDcKeOW9gNsrng4nE7F0sPg=;
 b=JaIDHY8GzDqshkvL/saWbLdxCZxKbvb8LUe8d/xAJQhIzLVJElxyY6wVFbOUxOCSzpWv
 Uhe95hT8Xou4poU/QSgZyIVzGIXCZJIrW11cL6SBCLJpHh8+XSt7Xf7ycfVlFnpZr5R2
 SA8LXM6CVDrgmqt4RjC8D5Zl9V4QthtMOc8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2tjqacsbya-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 06 Jul 2019 11:06:41 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sat, 6 Jul 2019 11:06:39 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 1A98D86170E; Sat,  6 Jul 2019 11:06:39 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v7 bpf-next 5/5] libbpf: add perf_buffer_ prefix to README
Date:   Sat, 6 Jul 2019 11:06:28 -0700
Message-ID: <20190706180628.3919653-6-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190706180628.3919653-1-andriin@fb.com>
References: <20190706180628.3919653-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907060241
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

perf_buffer "object" is part of libbpf API now, add it to the list of
libbpf function prefixes.

Suggested-by: Daniel Borkman <daniel@iogearbox.net>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/README.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/README.rst b/tools/lib/bpf/README.rst
index cef7b77eab69..8928f7787f2d 100644
--- a/tools/lib/bpf/README.rst
+++ b/tools/lib/bpf/README.rst
@@ -9,7 +9,8 @@ described here. It's recommended to follow these conventions whenever a
 new function or type is added to keep libbpf API clean and consistent.
 
 All types and functions provided by libbpf API should have one of the
-following prefixes: ``bpf_``, ``btf_``, ``libbpf_``, ``xsk_``.
+following prefixes: ``bpf_``, ``btf_``, ``libbpf_``, ``xsk_``,
+``perf_buffer_``.
 
 System call wrappers
 --------------------
-- 
2.17.1

