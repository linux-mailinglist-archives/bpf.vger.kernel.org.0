Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E382F6D2B7
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2019 19:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRRZX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jul 2019 13:25:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9594 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728222AbfGRRZW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jul 2019 13:25:22 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x6IHNpxo010392
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2019 10:25:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ZSCN2ijVmDMr5tzdTZ4FSB7LNCvT2IjmKg9o8G3Sl6I=;
 b=buBWYkS/wG1ZJVqSRgRZenCR8yf6SdVFMuevhBuYc2g/cK+L3DmMQzjosIZTK7hconf+
 jPRAp+9i3qAg4Q3hTEVvSPteShptq2jxuYkuoBZgE7GfuDTFgi01JyyE82ll4tj1EIwh
 Z+vXXyZ5NSQqYygfQ1JdsT5Z+ZcpkyXw5ng= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2ttspnruuh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2019 10:25:21 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 18 Jul 2019 10:25:19 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id CD07686161E; Thu, 18 Jul 2019 10:25:18 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <acme@redhat.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <daniel@iogearbox.net>, <ast@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf] libbpf: fix missing __WORDSIZE definition
Date:   Thu, 18 Jul 2019 10:25:13 -0700
Message-ID: <20190718172513.2394157-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=352 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180183
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hashmap.h depends on __WORDSIZE being defined. It is defined by
glibc/musl in different headers. It's an explicit goal for musl to be
"non-detectable" at compilation time, so instead include glibc header if
glibc is explicitly detected and fall back to musl header otherwise.

Fixes: e3b924224028 ("libbpf: add resizable non-thread safe internal hashmap")
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/hashmap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index 03748a742146..46a8cb667994 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -10,7 +10,12 @@
 
 #include <stdbool.h>
 #include <stddef.h>
+#ifdef __GLIBC__
+#include <bits/wordsize.h>
+#else
+#include <bits/reg.h>
 #include "libbpf_internal.h"
+#endif
 
 static inline size_t hash_bits(size_t h, int bits)
 {
-- 
2.17.1

