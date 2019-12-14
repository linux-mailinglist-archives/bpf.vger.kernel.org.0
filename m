Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C68111EFAE
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2019 02:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfLNBoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 20:44:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58420 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbfLNBoM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Dec 2019 20:44:12 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBE1b1hI025275
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 17:44:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=y9nb0guk8s+pm1LPE2HD0ecVYqhrG9YaWpp6XDZKQsk=;
 b=OQ/WFDkXfV83H2VdQoobwHfvsu1xp+6KGbrrYg+2G8rAegAzkS9daW7HXaNWEdnvnGxS
 bbiSMDLXHja925O7S+oir3Dq63zGZUW0AvaHbmhNlVxo1q+A3czl7kmwiJ7/whqTKh5a
 YK//rSYCOwId8R9n7l+AWXVqan9WA2wVcqc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wvp7hg0mb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 17:44:11 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Dec 2019 17:44:09 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 5A3492EC1D51; Fri, 13 Dec 2019 17:44:06 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 10/17] libbpf: postpone BTF ID finding for TRACING programs to load phase
Date:   Fri, 13 Dec 2019 17:43:34 -0800
Message-ID: <20191214014341.3442258-11-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214014341.3442258-1-andriin@fb.com>
References: <20191214014341.3442258-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_09:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=9 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912140006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move BTF ID determination for BPF_PROG_TYPE_TRACING programs to a load phase.
Performing it at open step is inconvenient, because it prevents BPF skeleton
generation on older host kernel, which doesn't contain BTF_KIND_FUNCs
information in vmlinux BTF. This is a common set up, though, when, e.g.,
selftests are compiled on older host kernel, but the test program itself is
executed in qemu VM with bleeding edge kernel. Having this BTF searching
performed at load time allows to successfully use bpf_object__open() for
codegen and inspection of BPF object file.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 06dfa36ed0bb..3488ac4f7015 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3815,11 +3815,22 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	return ret;
 }
 
-int
-bpf_program__load(struct bpf_program *prog,
-		  char *license, __u32 kern_version)
+static int libbpf_find_attach_btf_id(const char *name,
+				     enum bpf_attach_type attach_type,
+				     __u32 attach_prog_fd);
+
+int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 {
-	int err = 0, fd, i;
+	int err = 0, fd, i, btf_id;
+
+	if (prog->type == BPF_PROG_TYPE_TRACING) {
+		btf_id = libbpf_find_attach_btf_id(prog->section_name,
+						   prog->expected_attach_type,
+						   prog->attach_prog_fd);
+		if (btf_id <= 0)
+			return btf_id;
+		prog->attach_btf_id = btf_id;
+	}
 
 	if (prog->instances.nr < 0 || !prog->instances.fds) {
 		if (prog->preprocessor) {
@@ -3843,7 +3854,7 @@ bpf_program__load(struct bpf_program *prog,
 				prog->section_name, prog->instances.nr);
 		}
 		err = load_program(prog, prog->insns, prog->insns_cnt,
-				   license, kern_version, &fd);
+				   license, kern_ver, &fd);
 		if (!err)
 			prog->instances.fds[0] = fd;
 		goto out;
@@ -3872,9 +3883,7 @@ bpf_program__load(struct bpf_program *prog,
 		}
 
 		err = load_program(prog, result.new_insn_ptr,
-				   result.new_insn_cnt,
-				   license, kern_version, &fd);
-
+				   result.new_insn_cnt, license, kern_ver, &fd);
 		if (err) {
 			pr_warn("Loading the %dth instance of program '%s' failed\n",
 				i, prog->section_name);
@@ -3918,9 +3927,6 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 	return 0;
 }
 
-static int libbpf_find_attach_btf_id(const char *name,
-				     enum bpf_attach_type attach_type,
-				     __u32 attach_prog_fd);
 static struct bpf_object *
 __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 		   const struct bpf_object_open_opts *opts)
@@ -3984,15 +3990,8 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 
 		bpf_program__set_type(prog, prog_type);
 		bpf_program__set_expected_attach_type(prog, attach_type);
-		if (prog_type == BPF_PROG_TYPE_TRACING) {
-			err = libbpf_find_attach_btf_id(prog->section_name,
-							attach_type,
-							attach_prog_fd);
-			if (err <= 0)
-				goto out;
-			prog->attach_btf_id = err;
+		if (prog_type == BPF_PROG_TYPE_TRACING)
 			prog->attach_prog_fd = attach_prog_fd;
-		}
 	}
 
 	return obj;
-- 
2.17.1

