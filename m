Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C533411A168
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 03:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfLKCeg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 21:34:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6596 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727731AbfLKCeg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Dec 2019 21:34:36 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBB2YShh004998
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 18:34:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=D14/qC9lRS9yY+z0Ur90BFsfGzDzELUnPuWjVwYBREc=;
 b=jfQZtevl3ZT/6P6umeFJxeXBkkiXYZRDkEZokWZxnqcoluVsLAERieDqq2RpkaUtHhrP
 0W0+UdxJ6pdbPp56FyAaNwe/tIZKl3Ye4gdjODNAsdLtC3tQkT0MdNbdj/g48y1/awGU
 E4TCirhe71aE6miMQ6JaEhNKNin3cueckUQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2wtpneg7a7-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 18:34:34 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 18:34:32 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id B76703713892; Tue, 10 Dec 2019 18:34:30 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 4/5] libbpf: Introduce bpf_prog_attach_xattr
Date:   Tue, 10 Dec 2019 18:33:30 -0800
Message-ID: <ceaea4e9eacdd0f75840f6c2684967342a6af164.1576031228.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576031228.git.rdna@fb.com>
References: <cover.1576031228.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_08:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 suspectscore=13 phishscore=0 mlxlogscore=425 mlxscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110022
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a new bpf_prog_attach_xattr function that accepts an
extendable structure and supports passing a new attribute to
BPF_PROG_ATTACH command: replace_prog_fd that is fd of previously
attached cgroup-bpf program to replace if recently introduced
BPF_F_REPLACE flag is used.

The new function is named to be consistent with other xattr-functions
(bpf_prog_test_run_xattr, bpf_create_map_xattr, bpf_load_program_xattr).

NOTE: DECLARE_LIBBPF_OPTS macro is not used here because it's available
in libbpf.h, and unavailable in bpf.h. Please let me know if the macro
should be shared in a common place and used here instead of declaring
struct bpf_prog_attach_attr directly.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/lib/bpf/bpf.c      | 22 ++++++++++++++++++----
 tools/lib/bpf/bpf.h      | 10 ++++++++++
 tools/lib/bpf/libbpf.map |  5 +++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 98596e15390f..5a2830fac227 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -466,14 +466,28 @@ int bpf_obj_get(const char *pathname)
 
 int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
 		    unsigned int flags)
+{
+	struct bpf_prog_attach_attr attach_attr;
+
+	memset(&attach_attr, 0, sizeof(attach_attr));
+	attach_attr.target_fd	= target_fd;
+	attach_attr.prog_fd	= prog_fd;
+	attach_attr.type	= type;
+	attach_attr.flags	= flags;
+
+	return bpf_prog_attach_xattr(&attach_attr);
+}
+
+int bpf_prog_attach_xattr(const struct bpf_prog_attach_attr *attach_attr)
 {
 	union bpf_attr attr;
 
 	memset(&attr, 0, sizeof(attr));
-	attr.target_fd	   = target_fd;
-	attr.attach_bpf_fd = prog_fd;
-	attr.attach_type   = type;
-	attr.attach_flags  = flags;
+	attr.target_fd	   = attach_attr->target_fd;
+	attr.attach_bpf_fd = attach_attr->prog_fd;
+	attr.attach_type   = attach_attr->type;
+	attr.attach_flags  = attach_attr->flags;
+	attr.replace_bpf_fd = attach_attr->replace_prog_fd;
 
 	return sys_bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 3c791fa8e68e..4b7269d3bae7 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -128,8 +128,18 @@ LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
 LIBBPF_API int bpf_obj_get(const char *pathname);
+
+struct bpf_prog_attach_attr {
+	int target_fd;
+	int prog_fd;
+	enum bpf_attach_type type;
+	unsigned int flags;
+	int replace_prog_fd;
+};
+
 LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
 			       enum bpf_attach_type type, unsigned int flags);
+LIBBPF_API int bpf_prog_attach_xattr(const struct bpf_prog_attach_attr *attr);
 LIBBPF_API int bpf_prog_detach(int attachable_fd, enum bpf_attach_type type);
 LIBBPF_API int bpf_prog_detach2(int prog_fd, int attachable_fd,
 				enum bpf_attach_type type);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ddc2c40e482..42b065454031 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -208,3 +208,8 @@ LIBBPF_0.0.6 {
 		btf__find_by_name_kind;
 		libbpf_find_vmlinux_btf_id;
 } LIBBPF_0.0.5;
+
+LIBBPF_0.0.7 {
+	global:
+		bpf_prog_attach_xattr;
+} LIBBPF_0.0.6;
-- 
2.17.1

