Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450B016F2A0
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2020 23:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgBYWex (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Feb 2020 17:34:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbgBYWew (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Feb 2020 17:34:52 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PMOmcH005509
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2020 14:34:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=akM2W8A6TW4Uelho8bSNdTxM5WIB+PLUCvvCzXFLzeg=;
 b=GxdwrTcOao1eHrR3nkFUV9H42PV66vhnURx6TFnJdqzCcCe4gUPfOEjUx/dH+ZTWwB1Y
 66lJtDr0nhzg6oORiJcyhQMKbzhfY2hJhWzHknZsQn7R4BbA1hU2gWLwmmsBwfw+woHL
 TMxbiDJthIT/ZAkKWducbbFpASLb/KZkqZY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ybn98dm5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2020 14:34:52 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 14:34:50 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id DBB633700801; Tue, 25 Feb 2020 14:34:48 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] bpftool: Support struct_ops, tracing, ext prog types
Date:   Tue, 25 Feb 2020 14:34:41 -0800
Message-ID: <20200225223441.689109-1-rdna@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_09:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=900
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=13 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250157
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for prog types that were added to kernel but not present in
bpftool yet: struct_ops, tracing, ext prog types and corresponding
section names.

Before:
  # bpftool p l
  ...
  184: type 26  name test_subprog3  tag dda135a7dc0daf54  gpl
          loaded_at 2020-02-25T13:28:33-0800  uid 0
          xlated 112B  jited 103B  memlock 4096B  map_ids 136
          btf_id 85
  185: type 28  name new_get_skb_len  tag d2de5b87d8e5dc49  gpl
          loaded_at 2020-02-25T13:28:33-0800  uid 0
          xlated 72B  jited 69B  memlock 4096B  map_ids 136
          btf_id 85

After:
  # bpftool p l
  ...
  184: tracing  name test_subprog3  tag dda135a7dc0daf54  gpl
          loaded_at 2020-02-25T13:28:33-0800  uid 0
          xlated 112B  jited 103B  memlock 4096B  map_ids 136
          btf_id 85
  185: ext  name new_get_skb_len  tag d2de5b87d8e5dc49  gpl
          loaded_at 2020-02-25T13:28:33-0800  uid 0
          xlated 72B  jited 69B  memlock 4096B  map_ids 136
          btf_id 85

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 3 ++-
 tools/bpf/bpftool/bash-completion/bpftool        | 3 ++-
 tools/bpf/bpftool/main.h                         | 3 +++
 tools/bpf/bpftool/prog.c                         | 4 ++--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 64ddf8a4c518..46862e85fed2 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -42,7 +42,8 @@ PROG COMMANDS
 |		**cgroup/bind4** | **cgroup/bind6** | **cgroup/post_bind4** | **cgroup/post_bind6** |
 |		**cgroup/connect4** | **cgroup/connect6** | **cgroup/sendmsg4** | **cgroup/sendmsg6** |
 |		**cgroup/recvmsg4** | **cgroup/recvmsg6** | **cgroup/sysctl** |
-|		**cgroup/getsockopt** | **cgroup/setsockopt**
+|		**cgroup/getsockopt** | **cgroup/setsockopt** |
+|		**struct_ops** | **fentry** | **fexit** | **freplace**
 |	}
 |       *ATTACH_TYPE* := {
 |		**msg_verdict** | **stream_verdict** | **stream_parser** | **flow_dissector**
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 754d8395e451..ad4133b1f0cf 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -469,7 +469,8 @@ _bpftool()
                                 cgroup/recvmsg4 cgroup/recvmsg6 \
                                 cgroup/post_bind4 cgroup/post_bind6 \
                                 cgroup/sysctl cgroup/getsockopt \
-                                cgroup/setsockopt" -- \
+                                cgroup/setsockopt struct_ops \
+                                fentry fexit freplace" -- \
                                                    "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 4e75b58d3989..724ef9d941d3 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -76,6 +76,9 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_CGROUP_SYSCTL]		= "cgroup_sysctl",
 	[BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE]	= "raw_tracepoint_writable",
 	[BPF_PROG_TYPE_CGROUP_SOCKOPT]		= "cgroup_sockopt",
+	[BPF_PROG_TYPE_TRACING]			= "tracing",
+	[BPF_PROG_TYPE_STRUCT_OPS]		= "struct_ops",
+	[BPF_PROG_TYPE_EXT]			= "ext",
 };
 
 extern const char * const map_type_name[];
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index b352ab041160..1996e67a2f00 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1573,8 +1573,8 @@ static int do_help(int argc, char **argv)
 		"                 cgroup/bind4 | cgroup/bind6 | cgroup/post_bind4 |\n"
 		"                 cgroup/post_bind6 | cgroup/connect4 | cgroup/connect6 |\n"
 		"                 cgroup/sendmsg4 | cgroup/sendmsg6 | cgroup/recvmsg4 |\n"
-		"                 cgroup/recvmsg6 | cgroup/getsockopt |\n"
-		"                 cgroup/setsockopt }\n"
+		"                 cgroup/recvmsg6 | cgroup/getsockopt | cgroup/setsockopt |\n"
+		"                 struct_ops | fentry | fexit | freplace }\n"
 		"       ATTACH_TYPE := { msg_verdict | stream_verdict | stream_parser |\n"
 		"                        flow_dissector }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
-- 
2.17.1

