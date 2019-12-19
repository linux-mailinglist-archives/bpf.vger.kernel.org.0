Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB38125C2E
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 08:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLSHpZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 02:45:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29692 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbfLSHpY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 02:45:24 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ7htPi022170
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:45:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=+GSCC1g/aPOuENmkwlpk55YFK9qHB/9elc+lJufaGjU=;
 b=bEmyXlhAiUDgwTh/ayPV7yjBtuDmIMzlf90/J929VpZfwtUqP9vMUHmI+VjUtcO293Be
 Hif7eYxcAktpbkmA1cZPveE2ESCXiY9SIrwCum8JvMa7eAEfXqh0H+T/9Nb3ROnwcOHn
 GnDMeb08DkDXu9THegt9BoqgajZ0TSSTSGw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wypvwkvnu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:45:23 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 23:45:22 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id AD4D937138B6; Wed, 18 Dec 2019 23:45:19 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 4/6] libbpf: Introduce bpf_prog_attach_xattr
Date:   Wed, 18 Dec 2019 23:44:36 -0800
Message-ID: <bd6e0732303eb14e4b79cb128268d9e9ad6db208.1576741281.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576741281.git.rdna@fb.com>
References: <cover.1576741281.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=588 malwarescore=0 suspectscore=13 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190065
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a new bpf_prog_attach_xattr function that, in addition to
program fd, target fd and attach type, accepts an extendable struct
bpf_prog_attach_opts.

bpf_prog_attach_opts relies on DECLARE_LIBBPF_OPTS macro to maintain
backward and forward compatibility and has the following "optional"
attach attributes:

* existing attach_flags, since it's not required when attaching in NONE
  mode. Even though it's quite often used in MULTI and OVERRIDE mode it
  seems to be a good idea to reduce number of arguments to
  bpf_prog_attach_xattr;

* newly introduced attribute of BPF_PROG_ATTACH command: replace_prog_fd
  that is fd of previously attached cgroup-bpf program to replace if
  BPF_F_REPLACE flag is used.

The new function is named to be consistent with other xattr-functions
(bpf_prog_test_run_xattr, bpf_create_map_xattr, bpf_load_program_xattr).

The struct bpf_prog_attach_opts is supposed to be used with
DECLARE_LIBBPF_OPTS macro.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/lib/bpf/bpf.c      | 17 ++++++++++++++++-
 tools/lib/bpf/bpf.h      | 11 +++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 98596e15390f..a787d53699c8 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -466,14 +466,29 @@ int bpf_obj_get(const char *pathname)
 
 int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
 		    unsigned int flags)
+{
+	DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, opts,
+		.flags = flags,
+	);
+
+	return bpf_prog_attach_xattr(prog_fd, target_fd, type, &opts);
+}
+
+int bpf_prog_attach_xattr(int prog_fd, int target_fd,
+			  enum bpf_attach_type type,
+			  const struct bpf_prog_attach_opts *opts)
 {
 	union bpf_attr attr;
 
+	if (!OPTS_VALID(opts, bpf_prog_attach_opts))
+		return -EINVAL;
+
 	memset(&attr, 0, sizeof(attr));
 	attr.target_fd	   = target_fd;
 	attr.attach_bpf_fd = prog_fd;
 	attr.attach_type   = type;
-	attr.attach_flags  = flags;
+	attr.attach_flags  = OPTS_GET(opts, flags, 0);
+	attr.replace_bpf_fd = OPTS_GET(opts, replace_prog_fd, 0);
 
 	return sys_bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 269807ce9ef5..f0ab8519986e 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -126,8 +126,19 @@ LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
 LIBBPF_API int bpf_obj_get(const char *pathname);
+
+struct bpf_prog_attach_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	unsigned int flags;
+	int replace_prog_fd;
+};
+#define bpf_prog_attach_opts__last_field replace_prog_fd
+
 LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
 			       enum bpf_attach_type type, unsigned int flags);
+LIBBPF_API int bpf_prog_attach_xattr(int prog_fd, int attachable_fd,
+				     enum bpf_attach_type type,
+				     const struct bpf_prog_attach_opts *opts);
 LIBBPF_API int bpf_prog_detach(int attachable_fd, enum bpf_attach_type type);
 LIBBPF_API int bpf_prog_detach2(int prog_fd, int attachable_fd,
 				enum bpf_attach_type type);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index e3a471f38a71..e9713a574243 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -219,6 +219,7 @@ LIBBPF_0.0.7 {
 		bpf_object__detach_skeleton;
 		bpf_object__load_skeleton;
 		bpf_object__open_skeleton;
+		bpf_prog_attach_xattr;
 		bpf_program__attach;
 		bpf_program__name;
 		btf__align_of;
-- 
2.17.1

