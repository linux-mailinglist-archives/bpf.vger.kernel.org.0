Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEA34659D6
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 00:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353750AbhLAXcK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 1 Dec 2021 18:32:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54068 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353780AbhLAXcJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 18:32:09 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1B1Ldbgg005352
        for <bpf@vger.kernel.org>; Wed, 1 Dec 2021 15:28:47 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3cp48gxm99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 15:28:46 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:28:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5FAA6B7A0B15; Wed,  1 Dec 2021 15:28:43 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 9/9] libbpf: deprecate bpf_prog_load_xattr() API
Date:   Wed, 1 Dec 2021 15:28:24 -0800
Message-ID: <20211201232824.3166325-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201232824.3166325-1-andrii@kernel.org>
References: <20211201232824.3166325-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Tc57im5T9atR-HAFxxEeFOv3-dEb9OKH
X-Proofpoint-ORIG-GUID: Tc57im5T9atR-HAFxxEeFOv3-dEb9OKH
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=835 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_prog_load_xattr() is high-level API that's named as a low-level
BPF_PROG_LOAD wrapper APIs, but it actually operates on struct
bpf_object. It's badly and confusingly misnamed as it will load all the
progs insige bpf_object, returning prog_fd of the very first BPF
program. It also has a bunch of ad-hoc things like log_level override,
map_ifindex auto-setting, etc. All this can be expressed more explicitly
and cleanly through existing libbpf APIs. This patch marks
bpf_prog_load_xattr() for deprecation in libbpf v0.8 ([0]).

  [0] Closes: https://github.com/libbpf/libbpf/issues/308

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.h        | 1 +
 tools/lib/bpf/libbpf_common.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 148fa85bab33..c0d62dd37c5d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -682,6 +682,7 @@ struct bpf_prog_load_attr {
 	int prog_flags;
 };
 
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__open() and bpf_object__load() instead")
 LIBBPF_API int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 				   struct bpf_object **pobj, int *prog_fd);
 LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__open() and bpf_object__load() instead")
diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index b21cefc9c3b6..000e37798ff2 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -40,6 +40,11 @@
 #else
 #define __LIBBPF_MARK_DEPRECATED_0_7(X)
 #endif
+#if __LIBBPF_CURRENT_VERSION_GEQ(0, 8)
+#define __LIBBPF_MARK_DEPRECATED_0_8(X) X
+#else
+#define __LIBBPF_MARK_DEPRECATED_0_8(X)
+#endif
 
 /* This set of internal macros allows to do "function overloading" based on
  * number of arguments provided by used in backwards-compatible way during the
-- 
2.30.2

