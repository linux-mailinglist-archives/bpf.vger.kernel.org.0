Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A33443C80
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 06:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhKCFRg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Nov 2021 01:17:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41012 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229650AbhKCFRg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 01:17:36 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LcIN2001301
        for <bpf@vger.kernel.org>; Tue, 2 Nov 2021 22:15:00 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3ddpaa7h-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 22:15:00 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 22:14:54 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 60B2E7C60C3D; Tue,  2 Nov 2021 22:14:51 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: deprecate bpf_program__load() API
Date:   Tue, 2 Nov 2021 22:14:49 -0700
Message-ID: <20211103051449.1884903-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 1p-ezNVEEpXrc1ad49e51DXTNqqQPXGD
X-Proofpoint-GUID: 1p-ezNVEEpXrc1ad49e51DXTNqqQPXGD
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_01,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111030030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mark bpf_program__load() as deprecated ([0]) since v0.6. Also rename few
internal program loading bpf_object helper functions to have more
consistent naming.

  [0] Closes: https://github.com/libbpf/libbpf/issues/301

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 36 ++++++++++++++++++++++--------------
 tools/lib/bpf/libbpf.h |  4 ++--
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a1bea1953df6..f22ad2a9372a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6411,12 +6411,12 @@ static int libbpf_preload_prog(struct bpf_program *prog,
 	return 0;
 }
 
-static int
-load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
-	     char *license, __u32 kern_version, int *pfd)
+static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_program *prog,
+					 struct bpf_insn *insns, int insns_cnt,
+					 const char *license, __u32 kern_version,
+					 int *prog_fd)
 {
 	struct bpf_prog_load_params load_attr = {};
-	struct bpf_object *obj = prog->obj;
 	char *cp, errmsg[STRERR_BUFSIZE];
 	size_t log_buf_size = 0;
 	char *log_buf = NULL;
@@ -6477,7 +6477,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	if (obj->gen_loader) {
 		bpf_gen__prog_load(obj->gen_loader, &load_attr,
 				   prog - obj->programs);
-		*pfd = -1;
+		*prog_fd = -1;
 		return 0;
 	}
 retry_load:
@@ -6515,7 +6515,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 			}
 		}
 
-		*pfd = ret;
+		*prog_fd = ret;
 		ret = 0;
 		goto out;
 	}
@@ -6591,11 +6591,12 @@ static int bpf_program__record_externs(struct bpf_program *prog)
 	return 0;
 }
 
-int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
+static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
+				const char *license, __u32 kern_ver)
 {
 	int err = 0, fd, i;
 
-	if (prog->obj->loaded) {
+	if (obj->loaded) {
 		pr_warn("prog '%s': can't load after object was loaded\n", prog->name);
 		return libbpf_err(-EINVAL);
 	}
@@ -6621,10 +6622,11 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 			pr_warn("prog '%s': inconsistent nr(%d) != 1\n",
 				prog->name, prog->instances.nr);
 		}
-		if (prog->obj->gen_loader)
+		if (obj->gen_loader)
 			bpf_program__record_externs(prog);
-		err = load_program(prog, prog->insns, prog->insns_cnt,
-				   license, kern_ver, &fd);
+		err = bpf_object_load_prog_instance(obj, prog,
+						    prog->insns, prog->insns_cnt,
+						    license, kern_ver, &fd);
 		if (!err)
 			prog->instances.fds[0] = fd;
 		goto out;
@@ -6652,8 +6654,9 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 			continue;
 		}
 
-		err = load_program(prog, result.new_insn_ptr,
-				   result.new_insn_cnt, license, kern_ver, &fd);
+		err = bpf_object_load_prog_instance(obj, prog,
+						    result.new_insn_ptr, result.new_insn_cnt,
+						    license, kern_ver, &fd);
 		if (err) {
 			pr_warn("Loading the %dth instance of program '%s' failed\n",
 				i, prog->name);
@@ -6670,6 +6673,11 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 	return libbpf_err(err);
 }
 
+int bpf_program__load(struct bpf_program *prog, const char *license, __u32 kern_ver)
+{
+	return bpf_object_load_prog(prog->obj, prog, license, kern_ver);
+}
+
 static int
 bpf_object__load_progs(struct bpf_object *obj, int log_level)
 {
@@ -6693,7 +6701,7 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 			continue;
 		}
 		prog->log_level |= log_level;
-		err = bpf_program__load(prog, obj->license, obj->kern_version);
+		err = bpf_object_load_prog(obj, prog, obj->license, obj->kern_version);
 		if (err)
 			return err;
 	}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9de0f299706b..9b761050447a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -262,8 +262,8 @@ LIBBPF_API const struct bpf_insn *bpf_program__insns(const struct bpf_program *p
  */
 LIBBPF_API size_t bpf_program__insn_cnt(const struct bpf_program *prog);
 
-LIBBPF_API int bpf_program__load(struct bpf_program *prog, char *license,
-				 __u32 kern_version);
+LIBBPF_DEPRECATED_SINCE(0, 6, "use bpf_object__load() instead")
+LIBBPF_API int bpf_program__load(struct bpf_program *prog, const char *license, __u32 kern_version);
 LIBBPF_API int bpf_program__fd(const struct bpf_program *prog);
 LIBBPF_DEPRECATED_SINCE(0, 7, "multi-instance bpf_program support is deprecated")
 LIBBPF_API int bpf_program__pin_instance(struct bpf_program *prog,
-- 
2.30.2

