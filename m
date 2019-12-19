Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4421259B5
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 03:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfLSC4M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 21:56:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbfLSC4M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 21:56:12 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBJ2qLV1024286
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 18:56:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=8PtjsHmcO4e94uxV+tseLbxM2F9YHOZWUTfVz/jogkA=;
 b=O3Yl8WNDHeKGxpJdo34+Md2Ahw6S3cnfo22ZNKV3AKWg3aihUf7+yhtDOXN8wus0XUXU
 pis6YEUS5WzoRB/mwhreFaumgRE12i6WS6a7H04DxfMwmC4j1xShVoTTfi2aXbeZEXEi
 SZ585Dy0HgGCGY+lnYBfOc5hoE/zdSe4u7s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2wyc7tdjxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 18:56:10 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 18:56:09 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 9DB77371053A; Wed, 18 Dec 2019 17:56:40 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 4/6] libbpf: Introduce bpf_prog_attach_xattr
Date:   Wed, 18 Dec 2019 17:56:01 -0800
Message-ID: <a47ee7676254d3e94d3ff61afe20477eb8ace561.1576720240.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576720240.git.rdna@fb.com>
References: <cover.1576720240.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=13 clxscore=1015 priorityscore=1501 mlxscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=587
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190022
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
 tools/lib/bpf/bpf.c      | 16 +++++++++++++++-
 tools/lib/bpf/bpf.h      | 11 +++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 98596e15390f..ebb4f8d71bdb 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -466,6 +466,17 @@ int bpf_obj_get(const char *pathname)
 
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
 
@@ -473,7 +484,10 @@ int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
 	attr.target_fd	   = target_fd;
 	attr.attach_bpf_fd = prog_fd;
 	attr.attach_type   = type;
-	attr.attach_flags  = flags;
+	if (opts) {
+		attr.attach_flags = opts->flags;
+		attr.replace_bpf_fd = opts->replace_prog_fd;
+	}
 
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

