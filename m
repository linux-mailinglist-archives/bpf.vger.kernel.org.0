Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB829340E79
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 20:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhCRTlX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 18 Mar 2021 15:41:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3698 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232954AbhCRTlK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Mar 2021 15:41:10 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12IJU8JI003931
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 12:41:10 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37bs29pafb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 12:41:09 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 18 Mar 2021 12:41:07 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 76C5C2ED2588; Thu, 18 Mar 2021 12:40:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH v4 bpf-next 08/12] bpftool: add ability to specify custom skeleton object name
Date:   Thu, 18 Mar 2021 12:40:32 -0700
Message-ID: <20210318194036.3521577-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318194036.3521577-1-andrii@kernel.org>
References: <20210318194036.3521577-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_12:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103180139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add optional name OBJECT_NAME parameter to `gen skeleton` command to override
default object name, normally derived from input file name. This allows much
more flexibility during build time.

Cc: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/bpftool/Documentation/bpftool-gen.rst | 13 +++++----
 tools/bpf/bpftool/bash-completion/bpftool     | 11 ++++++-
 tools/bpf/bpftool/gen.c                       | 29 +++++++++++++++++--
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index 84cf0639696f..d4e7338e22e7 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -19,7 +19,7 @@ SYNOPSIS
 GEN COMMANDS
 =============
 
-|	**bpftool** **gen skeleton** *FILE*
+|	**bpftool** **gen skeleton** *FILE* [**name** *OBJECT_NAME*]
 |	**bpftool** **gen help**
 
 DESCRIPTION
@@ -75,10 +75,13 @@ DESCRIPTION
 		  specific maps, programs, etc.
 
 		  As part of skeleton, few custom functions are generated.
-		  Each of them is prefixed with object name, derived from
-		  object file name. I.e., if BPF object file name is
-		  **example.o**, BPF object name will be **example**. The
-		  following custom functions are provided in such case:
+		  Each of them is prefixed with object name. Object name can
+		  either be derived from object file name, i.e., if BPF object
+		  file name is **example.o**, BPF object name will be
+		  **example**. Object name can be also specified explicitly
+		  through **name** *OBJECT_NAME* parameter. The following
+		  custom functions are provided (assuming **example** as
+		  the object name):
 
 		  - **example__open** and **example__open_opts**.
 		    These functions are used to instantiate skeleton. It
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index fdffbc64c65c..bf7b4bdbb23a 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -982,7 +982,16 @@ _bpftool()
         gen)
             case $command in
                 skeleton)
-                    _filedir
+                    case $prev in
+                        $command)
+                            _filedir
+                            return 0
+                            ;;
+                        *)
+                            _bpftool_once_attr 'name'
+                            return 0
+                            ;;
+                    esac
                     ;;
                 *)
                     [[ $prev == $object ]] && \
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 4033c46d83e7..9bff89a66835 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -273,7 +273,7 @@ static int do_skeleton(int argc, char **argv)
 	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
 	size_t i, map_cnt = 0, prog_cnt = 0, file_sz, mmap_sz;
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
-	char obj_name[MAX_OBJ_NAME_LEN], *obj_data;
+	char obj_name[MAX_OBJ_NAME_LEN] = "", *obj_data;
 	struct bpf_object *obj = NULL;
 	const char *file, *ident;
 	struct bpf_program *prog;
@@ -288,6 +288,28 @@ static int do_skeleton(int argc, char **argv)
 	}
 	file = GET_ARG();
 
+	while (argc) {
+		if (!REQ_ARGS(2))
+			return -1;
+
+		if (is_prefix(*argv, "name")) {
+			NEXT_ARG();
+
+			if (obj_name[0] != '\0') {
+				p_err("object name already specified");
+				return -1;
+			}
+
+			strncpy(obj_name, *argv, MAX_OBJ_NAME_LEN - 1);
+			obj_name[MAX_OBJ_NAME_LEN - 1] = '\0';
+		} else {
+			p_err("unknown arg %s", *argv);
+			return -1;
+		}
+
+		NEXT_ARG();
+	}
+
 	if (argc) {
 		p_err("extra unknown arguments");
 		return -1;
@@ -310,7 +332,8 @@ static int do_skeleton(int argc, char **argv)
 		p_err("failed to mmap() %s: %s", file, strerror(errno));
 		goto out;
 	}
-	get_obj_name(obj_name, file);
+	if (obj_name[0] == '\0')
+		get_obj_name(obj_name, file);
 	opts.object_name = obj_name;
 	obj = bpf_object__open_mem(obj_data, file_sz, &opts);
 	if (IS_ERR(obj)) {
@@ -599,7 +622,7 @@ static int do_help(int argc, char **argv)
 	}
 
 	fprintf(stderr,
-		"Usage: %1$s %2$s skeleton FILE\n"
+		"Usage: %1$s %2$s skeleton FILE [name OBJECT_NAME]\n"
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_OPTIONS "\n"
-- 
2.30.2

