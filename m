Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E9524152B
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 05:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHKDI5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 23:08:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38212 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726981AbgHKDI4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Aug 2020 23:08:56 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07B31Eah015348
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 20:08:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=r284x+pzXxM98zmqb06X1ZyRuBg/Pi7MGlQzYyqTIUE=;
 b=R1mXliCaqZ0sewcPiaY7DWz3BDyGo5FNGsCCDkDJvQQc78qqiQAqojeJj5D43bVm7t8t
 EsPvwJILa95oFUD6UvdVlFk8vCYOf8lvQ25wTAJHyn7gpzpON75KpeT9AvTRz1cqOn8M
 cPPRBPYQFAe8s6hXXmb4w3u3qS/U7gWX8Y8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32u81nucy6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 20:08:56 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 10 Aug 2020 20:08:54 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 014103704F26; Mon, 10 Aug 2020 20:08:52 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Ian Rogers <irogers@google.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf] libbpf: do not use __builtin_offsetof for offsetof
Date:   Mon, 10 Aug 2020 20:08:52 -0700
Message-ID: <20200811030852.3396929-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_02:2020-08-06,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=584 suspectscore=1 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008110020
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 5fbc220862fc ("tools/libpf: Add offsetof/container_of macro
in bpf_helpers.h") added a macro offsetof() to get the offset of a
structure member:
   #define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)

In certain use cases, size_t type may not be available so
Commit da7a35062bcc ("libbpf bpf_helpers: Use __builtin_offsetof
for offsetof") changed to use __builtin_offsetof which removed
the dependency on type size_t, which I suggested.

But using __builtin_offsetof will prevent CO-RE relocation
generation in case that, e.g., TYPE is annotated with "preserve_access_in=
fo"
where a relocation is desirable in case the member offset is changed
in a different kernel version. So this patch reverted back to
the original macro but using "unsigned long" instead of "site_t".

Cc: Ian Rogers <irogers@google.com>
Fixes: da7a35062bcc ("libbpf bpf_helpers: Use __builtin_offsetof for offs=
etof")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/bpf_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index bc14db706b88..e9a4ecddb7a5 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -40,7 +40,7 @@
  * Helper macro to manipulate data structures
  */
 #ifndef offsetof
-#define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
+#define offsetof(TYPE, MEMBER)	((unsigned long)&((TYPE *)0)->MEMBER)
 #endif
 #ifndef container_of
 #define container_of(ptr, type, member)				\
--=20
2.24.1

