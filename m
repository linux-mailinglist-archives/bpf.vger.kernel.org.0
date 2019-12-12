Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C39B311DA06
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 00:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLLXbY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 18:31:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51780 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730934AbfLLXbY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Dec 2019 18:31:24 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBCNUoa7019162
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 15:31:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Xh6BKSTnCMYVO8T/wonHy5xbs5J2/Ki4m6r3HeUBtUs=;
 b=PY331Nh8gOlBxIeSAuNTK9v2clAVJklBkXr+UrcBe1P4pyMGPCDQL5fPBCF8YyX2+6EN
 PocVS14I9eJfm9TO5FH3loGJ0QHssju1gNGn1+RyepEMvCYRz+dkH5DBAPH7qe0ocF8z
 H51kw5fm9hV/FNqNdrzW2VEk8sbdb9NhGJk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2wuke1kpks-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 15:31:22 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 12 Dec 2019 15:31:21 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 99CD73712A1F; Thu, 12 Dec 2019 15:31:20 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 5/6] libbpf: Introduce bpf_prog_attach_xattr
Date:   Thu, 12 Dec 2019 15:30:52 -0800
Message-ID: <364944f93a1d77eab769eeba79bb74122a688338.1576193131.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576193131.git.rdna@fb.com>
References: <cover.1576193131.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 suspectscore=13 adultscore=0 clxscore=1015 spamscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=355
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912120181
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a new bpf_prog_attach_xattr function that accepts an
extendable struct bpf_prog_attach_opts and supports passing a new
attribute to BPF_PROG_ATTACH command: replace_prog_fd that is fd of
previously attached cgroup-bpf program to replace if recently introduced
BPF_F_REPLACE flag is used.

The new function is named to be consistent with other xattr-functions
(bpf_prog_test_run_xattr, bpf_create_map_xattr, bpf_load_program_xattr).

The struct bpf_prog_attach_opts is supposed to be used with
DECLARE_LIBBPF_OPTS framework.

The opts argument is used directly in bpf_prog_attach_xattr
implementation since at the time of adding all fields already exist in
the kernel. New fields, if added, will need to be used via OPTS_* macros
from libbpf_internal.h.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/lib/bpf/bpf.c      | 21 +++++++++++++++++----
 tools/lib/bpf/bpf.h      | 12 ++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 98596e15390f..9f4e42abd185 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -466,14 +466,27 @@ int bpf_obj_get(const char *pathname)
 
 int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
 		    unsigned int flags)
+{
+	DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, opts,
+		.target_fd = target_fd,
+		.prog_fd = prog_fd,
+		.type = type,
+		.flags = flags,
+	);
+
+	return bpf_prog_attach_xattr(&opts);
+}
+
+int bpf_prog_attach_xattr(const struct bpf_prog_attach_opts *opts)
 {
 	union bpf_attr attr;
 
 	memset(&attr, 0, sizeof(attr));
-	attr.target_fd	   = target_fd;
-	attr.attach_bpf_fd = prog_fd;
-	attr.attach_type   = type;
-	attr.attach_flags  = flags;
+	attr.target_fd	   = opts->target_fd;
+	attr.attach_bpf_fd = opts->prog_fd;
+	attr.attach_type   = opts->type;
+	attr.attach_flags  = opts->flags;
+	attr.replace_bpf_fd = opts->replace_prog_fd;
 
 	return sys_bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 5cfe6e0a1aef..5b5f9b374074 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -150,8 +150,20 @@ LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
 LIBBPF_API int bpf_obj_get(const char *pathname);
+
+struct bpf_prog_attach_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	int target_fd;
+	int prog_fd;
+	enum bpf_attach_type type;
+	unsigned int flags;
+	int replace_prog_fd;
+};
+#define bpf_prog_attach_opts__last_field replace_prog_fd
+
 LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
 			       enum bpf_attach_type type, unsigned int flags);
+LIBBPF_API int bpf_prog_attach_xattr(const struct bpf_prog_attach_opts *opts);
 LIBBPF_API int bpf_prog_detach(int attachable_fd, enum bpf_attach_type type);
 LIBBPF_API int bpf_prog_detach2(int prog_fd, int attachable_fd,
 				enum bpf_attach_type type);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 495df575f87f..42b065454031 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -210,4 +210,6 @@ LIBBPF_0.0.6 {
 } LIBBPF_0.0.5;
 
 LIBBPF_0.0.7 {
+	global:
+		bpf_prog_attach_xattr;
 } LIBBPF_0.0.6;
-- 
2.17.1

