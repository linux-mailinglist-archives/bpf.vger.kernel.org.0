Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE341FD1E2
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFQQVq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 12:21:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7054 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbgFQQVq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Jun 2020 12:21:46 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HGJh9G030886
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 09:21:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qKyRPnw3dryXu+uIWmha2EysccEdmZ+EjtZCA4qbfzM=;
 b=WUnwdqt4D8HHT9PMNMhHovlGIFYevTAhSMKFvnjugqa4k+vCQ1t60lx9drYI9ZWNZI4o
 Jk2Or/1VQ3rymNxAJasquA1Cay3AHHOh9hhk4UQ5xDhhtZp20VlAcI1RODv+U0lBva3Z
 UYfslWYJMiNyFbDwhxpfrXkcI0Wg+6izMX0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q653db1h-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 09:21:44 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 09:21:38 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 56E6F2EC3738; Wed, 17 Jun 2020 09:19:15 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 9/9] tools/bpftool: add documentation and sample output for process info
Date:   Wed, 17 Jun 2020 09:18:32 -0700
Message-ID: <20200617161832.1438371-10-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200617161832.1438371-1-andriin@fb.com>
References: <20200617161832.1438371-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_06:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 suspectscore=8
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170129
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add statements about bpftool being able to discover process info, holding
reference to BPF map, prog, link, or BTF. Show example output as well.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst  |  5 +++++
 tools/bpf/bpftool/Documentation/bpftool-link.rst | 13 ++++++++++++-
 tools/bpf/bpftool/Documentation/bpftool-map.rst  |  8 +++++++-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 11 +++++++++++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/=
bpftool/Documentation/bpftool-btf.rst
index ce3a724f50c1..85f7c82ebb28 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -36,6 +36,11 @@ DESCRIPTION
 		  otherwise list all BTF objects currently loaded on the
 		  system.
=20
+		  Since Linux 5.8 bpftool is able to discover information about
+		  processes that hold open file descriptors (FDs) against BPF
+		  links. On such kernels bpftool will automatically emit this
+		  information as well.
+
 	**bpftool btf dump** *BTF_SRC*
 		  Dump BTF entries from a given *BTF_SRC*.
=20
diff --git a/tools/bpf/bpftool/Documentation/bpftool-link.rst b/tools/bpf=
/bpftool/Documentation/bpftool-link.rst
index 0e43d7b06c11..1da7ef65b514 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-link.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-link.rst
@@ -37,6 +37,11 @@ DESCRIPTION
 		  zero or more named attributes, some of which depend on type
 		  of link.
=20
+		  Since Linux 5.8 bpftool is able to discover information about
+		  processes that hold open file descriptors (FDs) against BPF
+		  links. On such kernels bpftool will automatically emit this
+		  information as well.
+
 	**bpftool link pin** *LINK* *FILE*
 		  Pin link *LINK* as *FILE*.
=20
@@ -82,6 +87,7 @@ EXAMPLES
=20
     10: cgroup  prog 25
             cgroup_id 614  attach_type egress
+            pids test_progs(2238417)
=20
 **# bpftool --json --pretty link show**
=20
@@ -91,7 +97,12 @@ EXAMPLES
             "type": "cgroup",
             "prog_id": 25,
             "cgroup_id": 614,
-            "attach_type": "egress"
+            "attach_type": "egress",
+            "pids": [{
+                    "pid": 2238417,
+                    "comm": "test_progs"
+                }
+            ]
         }
     ]
=20
diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/=
bpftool/Documentation/bpftool-map.rst
index 31101643e57c..5bc2123e9944 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -62,6 +62,11 @@ DESCRIPTION
 		  Output will start with map ID followed by map type and
 		  zero or more named attributes (depending on kernel version).
=20
+		  Since Linux 5.8 bpftool is able to discover information about
+		  processes that hold open file descriptors (FDs) against BPF
+		  maps. On such kernels bpftool will automatically emit this
+		  information as well.
+
 	**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **valu=
e** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *F=
LAGS*] [**dev** *NAME*]
 		  Create a new map with given parameters and pin it to *bpffs*
 		  as *FILE*.
@@ -180,7 +185,8 @@ EXAMPLES
 ::
=20
   10: hash  name some_map  flags 0x0
-	key 4B  value 8B  max_entries 2048  memlock 167936B
+        key 4B  value 8B  max_entries 2048  memlock 167936B
+        pids systemd(1)
=20
 The following three commands are equivalent:
=20
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf=
/bpftool/Documentation/bpftool-prog.rst
index 2b254959d488..412ea3d9bf7f 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -75,6 +75,11 @@ DESCRIPTION
 		  program run. Activation or deactivation of the feature is
 		  performed via the **kernel.bpf_stats_enabled** sysctl knob.
=20
+		  Since Linux 5.8 bpftool is able to discover information about
+		  processes that hold open file descriptors (FDs) against BPF
+		  programs. On such kernels bpftool will automatically emit this
+		  information as well.
+
 	**bpftool prog dump xlated** *PROG* [{ **file** *FILE* | **opcodes** | =
**visual** | **linum** }]
 		  Dump eBPF instructions of the programs from the kernel. By
 		  default, eBPF will be disassembled and printed to standard
@@ -243,6 +248,7 @@ EXAMPLES
     10: xdp  name some_prog  tag 005a3d2123620c8b  gpl run_time_ns 81632=
 run_cnt 10
             loaded_at 2017-09-29T20:11:00+0000  uid 0
             xlated 528B  jited 370B  memlock 4096B  map_ids 10
+            pids systemd(1)
=20
 **# bpftool --json --pretty prog show**
=20
@@ -262,6 +268,11 @@ EXAMPLES
             "bytes_jited": 370,
             "bytes_memlock": 4096,
             "map_ids": [10
+            ],
+            "pids": [{
+                    "pid": 1,
+                    "comm": "systemd"
+                }
             ]
         }
     ]
--=20
2.24.1

