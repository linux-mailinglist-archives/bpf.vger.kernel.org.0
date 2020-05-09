Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC031CC370
	for <lists+bpf@lfdr.de>; Sat,  9 May 2020 19:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgEIR7X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 May 2020 13:59:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57134 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728713AbgEIR7W (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 9 May 2020 13:59:22 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 049HwD8O016627
        for <bpf@vger.kernel.org>; Sat, 9 May 2020 10:59:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=2r5VzWCEcS0eYMTCBsdSSoGI4H0lnHK7Kw4E10LqepY=;
 b=orFieEXJQWVvvtYExEmFlOxlBLMa3P8Fl+aIl/KONw2gfyEG4oPCsHUV7hRFUdfY3cG/
 B/GCddvrD7wmpg0iHJhp4W+zYkiJGl210aLUGR+jCOU29WIoPW3hjszNDK4cs8SQY2Hi
 2TDnVkuFAiNKvHjt/nKY8DxVE9BTpgOrSak= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30wsmfsg07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 09 May 2020 10:59:21 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Sat, 9 May 2020 10:59:20 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 1270E37008E2; Sat,  9 May 2020 10:59:19 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v4 17/21] tools/libpf: add offsetof/container_of macro in bpf_helpers.h
Date:   Sat, 9 May 2020 10:59:19 -0700
Message-ID: <20200509175919.2477104-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200509175859.2474608-1-yhs@fb.com>
References: <20200509175859.2474608-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-09_06:2020-05-08,2020-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005090156
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These two helpers will be used later in bpf_iter bpf program
bpf_iter_netlink.c. Put them in bpf_helpers.h since they could
be useful in other cases.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/bpf_helpers.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index da00b87aa199..f67dce2af802 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -36,6 +36,20 @@
 #define __weak __attribute__((weak))
 #endif
=20
+/*
+ * Helper macro to manipulate data structures
+ */
+#ifndef offsetof
+#define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
+#endif
+#ifndef container_of
+#define container_of(ptr, type, member)				\
+	({							\
+		void *__mptr =3D (void *)(ptr);			\
+		((type *)(__mptr - offsetof(type, member)));	\
+	})
+#endif
+
 /*
  * Helper structure used by eBPF C program
  * to describe BPF map attributes to libbpf loader
--=20
2.24.1

