Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84054659D1
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 00:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343978AbhLAXb6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 1 Dec 2021 18:31:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48696 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240449AbhLAXb5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 18:31:57 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LciVQ026376
        for <bpf@vger.kernel.org>; Wed, 1 Dec 2021 15:28:35 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cpd6atnub-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 15:28:35 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:28:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0B2EBB7A0ABA; Wed,  1 Dec 2021 15:28:29 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/9] libbpf: add API to get/set log_level at per-program level
Date:   Wed, 1 Dec 2021 15:28:17 -0800
Message-ID: <20211201232824.3166325-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201232824.3166325-1-andrii@kernel.org>
References: <20211201232824.3166325-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: UF7GAc1XphBZsX6catxzSd3vJBJIuLsL
X-Proofpoint-GUID: UF7GAc1XphBZsX6catxzSd3vJBJIuLsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_program__set_log_level() and bpf_program__log_level() to fetch
and adjust log_level sent during BPF_PROG_LOAD command. This allows to
selectively request more or less verbose output in BPF verifier log.

Also bump libbpf version to 0.7 and make these APIs the first in v0.7.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c         | 14 ++++++++++++++
 tools/lib/bpf/libbpf.h         |  2 ++
 tools/lib/bpf/libbpf.map       |  6 ++++++
 tools/lib/bpf/libbpf_version.h |  2 +-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5a2f5a6ae2f9..d40c83cc7152 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8422,6 +8422,20 @@ int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
 	return 0;
 }
 
+__u32 bpf_program__log_level(const struct bpf_program *prog)
+{
+	return prog->log_level;
+}
+
+int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_level)
+{
+	if (prog->obj->loaded)
+		return libbpf_err(-EBUSY);
+
+	prog->log_level = log_level;
+	return 0;
+}
+
 #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
 	.sec = sec_pfx,							    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d02139fec4ac..148fa85bab33 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -499,6 +499,8 @@ bpf_program__set_expected_attach_type(struct bpf_program *prog,
 
 LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_flags(struct bpf_program *prog, __u32 flags);
+LIBBPF_API __u32 bpf_program__log_level(const struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_level);
 
 LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 623002b83b2b..715df3a27389 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -419,3 +419,9 @@ LIBBPF_0.6.0 {
 		perf_buffer__new_raw;
 		perf_buffer__new_raw_deprecated;
 } LIBBPF_0.5.0;
+
+LIBBPF_0.7.0 {
+	global:
+		bpf_program__log_level;
+		bpf_program__set_log_level;
+};
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index dd56d76f291c..0fefefc3500b 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 0
-#define LIBBPF_MINOR_VERSION 6
+#define LIBBPF_MINOR_VERSION 7
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.30.2

