Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7E843A6CB
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 00:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhJYWsF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Oct 2021 18:48:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7968 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232470AbhJYWsF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 18:48:05 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMiVIj011788
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:45:42 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4e7rhhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:45:42 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 15:45:41 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4987474E664C; Mon, 25 Oct 2021 15:45:39 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/4] libbpf: deprecate multi-instance bpf_program APIs
Date:   Mon, 25 Oct 2021 15:45:30 -0700
Message-ID: <20211025224531.1088894-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025224531.1088894-1-andrii@kernel.org>
References: <20211025224531.1088894-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 3dTKI77ouxaTnqpxPFPeBocKYtYJyFGC
X-Proofpoint-GUID: 3dTKI77ouxaTnqpxPFPeBocKYtYJyFGC
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110250129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Schedule deprecation of a set of APIs that are related to multi-instance
bpf_programs:
  - bpf_program__set_prep() ([0]);
  - bpf_program__{set,unset}_instance() ([1]);
  - bpf_program__nth_fd().

These APIs are obscure, very niche, and don't seem to be used much in
practice. bpf_program__set_prep() is pretty useless for anything but the
simplest BPF programs, as it doesn't allow to adjust BPF program load
attributes, among other things. In short, it already bitrotted and will
bitrot some more if not removed.

With bpf_program__insns() API, which gives access to post-processed BPF
program instructions of any given entry-point BPF program, it's now
possible to do whatever necessary adjustments were possible with
set_prep() API before, but also more. Given any such use case is
automatically an advanced use case, requiring users to stick to
low-level bpf_prog_load() APIs and managing their own prog FDs is
reasonable.

  [0] Closes: https://github.com/libbpf/libbpf/issues/299
  [1] Closes: https://github.com/libbpf/libbpf/issues/300

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 22 +++++++++++++---------
 tools/lib/bpf/libbpf.h |  6 +++++-
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dc86ad24dfcb..4b2158657507 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7358,8 +7358,7 @@ static int check_path(const char *path)
 	return err;
 }
 
-int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
-			      int instance)
+static int bpf_program_pin_instance(struct bpf_program *prog, const char *path, int instance)
 {
 	char *cp, errmsg[STRERR_BUFSIZE];
 	int err;
@@ -7394,8 +7393,7 @@ int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
 	return 0;
 }
 
-int bpf_program__unpin_instance(struct bpf_program *prog, const char *path,
-				int instance)
+static int bpf_program_unpin_instance(struct bpf_program *prog, const char *path, int instance)
 {
 	int err;
 
@@ -7423,6 +7421,12 @@ int bpf_program__unpin_instance(struct bpf_program *prog, const char *path,
 	return 0;
 }
 
+__attribute__((alias("bpf_program_pin_instance")))
+int bpf_object__pin_instance(struct bpf_program *prog, const char *path, int instance);
+
+__attribute__((alias("bpf_program_unpin_instance")))
+int bpf_program__unpin_instance(struct bpf_program *prog, const char *path, int instance);
+
 int bpf_program__pin(struct bpf_program *prog, const char *path)
 {
 	int i, err;
@@ -7447,7 +7451,7 @@ int bpf_program__pin(struct bpf_program *prog, const char *path)
 
 	if (prog->instances.nr == 1) {
 		/* don't create subdirs when pinning single instance */
-		return bpf_program__pin_instance(prog, path, 0);
+		return bpf_program_pin_instance(prog, path, 0);
 	}
 
 	for (i = 0; i < prog->instances.nr; i++) {
@@ -7463,7 +7467,7 @@ int bpf_program__pin(struct bpf_program *prog, const char *path)
 			goto err_unpin;
 		}
 
-		err = bpf_program__pin_instance(prog, buf, i);
+		err = bpf_program_pin_instance(prog, buf, i);
 		if (err)
 			goto err_unpin;
 	}
@@ -7481,7 +7485,7 @@ int bpf_program__pin(struct bpf_program *prog, const char *path)
 		else if (len >= PATH_MAX)
 			continue;
 
-		bpf_program__unpin_instance(prog, buf, i);
+		bpf_program_unpin_instance(prog, buf, i);
 	}
 
 	rmdir(path);
@@ -7509,7 +7513,7 @@ int bpf_program__unpin(struct bpf_program *prog, const char *path)
 
 	if (prog->instances.nr == 1) {
 		/* don't create subdirs when pinning single instance */
-		return bpf_program__unpin_instance(prog, path, 0);
+		return bpf_program_unpin_instance(prog, path, 0);
 	}
 
 	for (i = 0; i < prog->instances.nr; i++) {
@@ -7522,7 +7526,7 @@ int bpf_program__unpin(struct bpf_program *prog, const char *path)
 		else if (len >= PATH_MAX)
 			return libbpf_err(-ENAMETOOLONG);
 
-		err = bpf_program__unpin_instance(prog, buf, i);
+		err = bpf_program_unpin_instance(prog, buf, i);
 		if (err)
 			return err;
 	}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c6bcc5b98906..449eeed80be6 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -263,9 +263,11 @@ LIBBPF_API size_t bpf_program__insn_cnt(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__load(struct bpf_program *prog, char *license,
 				 __u32 kern_version);
 LIBBPF_API int bpf_program__fd(const struct bpf_program *prog);
+LIBBPF_DEPRECATED_SINCE(0, 7, "multi-instance bpf_program support is deprecated")
 LIBBPF_API int bpf_program__pin_instance(struct bpf_program *prog,
 					 const char *path,
 					 int instance);
+LIBBPF_DEPRECATED_SINCE(0, 7, "multi-instance bpf_program support is deprecated")
 LIBBPF_API int bpf_program__unpin_instance(struct bpf_program *prog,
 					   const char *path,
 					   int instance);
@@ -427,7 +429,7 @@ bpf_program__attach_iter(const struct bpf_program *prog,
  * one instance. In this case bpf_program__fd(prog) is equal to
  * bpf_program__nth_fd(prog, 0).
  */
-
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_program__insns() for getting bpf_program instructions")
 struct bpf_prog_prep_result {
 	/*
 	 * If not NULL, load new instruction array.
@@ -456,9 +458,11 @@ typedef int (*bpf_program_prep_t)(struct bpf_program *prog, int n,
 				  struct bpf_insn *insns, int insns_cnt,
 				  struct bpf_prog_prep_result *res);
 
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_program__insns() for getting bpf_program instructions")
 LIBBPF_API int bpf_program__set_prep(struct bpf_program *prog, int nr_instance,
 				     bpf_program_prep_t prep);
 
+LIBBPF_DEPRECATED_SINCE(0, 7, "multi-instance bpf_program support is deprecated")
 LIBBPF_API int bpf_program__nth_fd(const struct bpf_program *prog, int n);
 
 /*
-- 
2.30.2

