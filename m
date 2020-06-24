Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A97F2075BA
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 16:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbgFXOb1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 10:31:27 -0400
Received: from sym2.noone.org ([178.63.92.236]:57732 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389909AbgFXOb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 10:31:27 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49sQZ42nCHzvjc1; Wed, 24 Jun 2020 16:31:24 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] tools, bpftool: Define prog_type_name array only once
Date:   Wed, 24 Jun 2020 16:31:24 +0200
Message-Id: <20200624143124.12914-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200623104227.11435-2-tklauser@distanz.ch>
References: <20200623104227.11435-2-tklauser@distanz.ch>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Define prog_type_name in prog.c instead of main.h so it is only defined
once. This leads to a slight decrease in the binary size of bpftool.

Before:

   text	   data	    bss	    dec	    hex	filename
 401032	  11936	1573160	1986128	 1e4e50	bpftool

After:

   text	   data	    bss	    dec	    hex	filename
 399024	  11168	1573160	1983352	 1e4378	bpftool

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
v3: fix typo in commit message as pointed out by Quentin.

 tools/bpf/bpftool/feature.c |  4 ++--
 tools/bpf/bpftool/link.c    |  4 ++--
 tools/bpf/bpftool/main.h    | 33 ++-------------------------------
 tools/bpf/bpftool/map.c     |  4 ++--
 tools/bpf/bpftool/prog.c    | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 768bf77df886..1cd75807673e 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -695,7 +695,7 @@ section_program_types(bool *supported_types, const char *define_prefix,
 			    "/*** eBPF program types ***/",
 			    define_prefix);
 
-	for (i = BPF_PROG_TYPE_UNSPEC + 1; i < ARRAY_SIZE(prog_type_name); i++)
+	for (i = BPF_PROG_TYPE_UNSPEC + 1; i < prog_type_name_size; i++)
 		probe_prog_type(i, supported_types, define_prefix, ifindex);
 
 	print_end_section();
@@ -741,7 +741,7 @@ section_helpers(bool *supported_types, const char *define_prefix, __u32 ifindex)
 		       "	%sBPF__PROG_TYPE_ ## prog_type ## __HELPER_ ## helper\n",
 		       define_prefix, define_prefix, define_prefix,
 		       define_prefix);
-	for (i = BPF_PROG_TYPE_UNSPEC + 1; i < ARRAY_SIZE(prog_type_name); i++)
+	for (i = BPF_PROG_TYPE_UNSPEC + 1; i < prog_type_name_size; i++)
 		probe_helpers_for_progtype(i, supported_types[i], define_prefix,
 					   ifindex);
 
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 7329f3134283..326b8fdf0243 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -108,7 +108,7 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 		if (err)
 			return err;
 
-		if (prog_info.type < ARRAY_SIZE(prog_type_name))
+		if (prog_info.type < prog_type_name_size)
 			jsonw_string_field(json_wtr, "prog_type",
 					   prog_type_name[prog_info.type]);
 		else
@@ -187,7 +187,7 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		if (err)
 			return err;
 
-		if (prog_info.type < ARRAY_SIZE(prog_type_name))
+		if (prog_info.type < prog_type_name_size)
 			printf("\n\tprog_type %s  ",
 			       prog_type_name[prog_info.type]);
 		else
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index ce26271e5f0c..269f1cb6aef5 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -56,37 +56,8 @@
 #define HELP_SPEC_LINK							\
 	"LINK := { id LINK_ID | pinned FILE }"
 
-static const char * const prog_type_name[] = {
-	[BPF_PROG_TYPE_UNSPEC]			= "unspec",
-	[BPF_PROG_TYPE_SOCKET_FILTER]		= "socket_filter",
-	[BPF_PROG_TYPE_KPROBE]			= "kprobe",
-	[BPF_PROG_TYPE_SCHED_CLS]		= "sched_cls",
-	[BPF_PROG_TYPE_SCHED_ACT]		= "sched_act",
-	[BPF_PROG_TYPE_TRACEPOINT]		= "tracepoint",
-	[BPF_PROG_TYPE_XDP]			= "xdp",
-	[BPF_PROG_TYPE_PERF_EVENT]		= "perf_event",
-	[BPF_PROG_TYPE_CGROUP_SKB]		= "cgroup_skb",
-	[BPF_PROG_TYPE_CGROUP_SOCK]		= "cgroup_sock",
-	[BPF_PROG_TYPE_LWT_IN]			= "lwt_in",
-	[BPF_PROG_TYPE_LWT_OUT]			= "lwt_out",
-	[BPF_PROG_TYPE_LWT_XMIT]		= "lwt_xmit",
-	[BPF_PROG_TYPE_SOCK_OPS]		= "sock_ops",
-	[BPF_PROG_TYPE_SK_SKB]			= "sk_skb",
-	[BPF_PROG_TYPE_CGROUP_DEVICE]		= "cgroup_device",
-	[BPF_PROG_TYPE_SK_MSG]			= "sk_msg",
-	[BPF_PROG_TYPE_RAW_TRACEPOINT]		= "raw_tracepoint",
-	[BPF_PROG_TYPE_CGROUP_SOCK_ADDR]	= "cgroup_sock_addr",
-	[BPF_PROG_TYPE_LWT_SEG6LOCAL]		= "lwt_seg6local",
-	[BPF_PROG_TYPE_LIRC_MODE2]		= "lirc_mode2",
-	[BPF_PROG_TYPE_SK_REUSEPORT]		= "sk_reuseport",
-	[BPF_PROG_TYPE_FLOW_DISSECTOR]		= "flow_dissector",
-	[BPF_PROG_TYPE_CGROUP_SYSCTL]		= "cgroup_sysctl",
-	[BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE]	= "raw_tracepoint_writable",
-	[BPF_PROG_TYPE_CGROUP_SOCKOPT]		= "cgroup_sockopt",
-	[BPF_PROG_TYPE_TRACING]			= "tracing",
-	[BPF_PROG_TYPE_STRUCT_OPS]		= "struct_ops",
-	[BPF_PROG_TYPE_EXT]			= "ext",
-};
+extern const char * const prog_type_name[];
+extern const size_t prog_type_name_size;
 
 static const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
 	[BPF_CGROUP_INET_INGRESS] = "ingress",
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 0a6a5d82d380..577a7fdf8d92 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -472,7 +472,7 @@ static int show_map_close_json(int fd, struct bpf_map_info *info)
 		if (owner_prog_type) {
 			unsigned int prog_type = atoi(owner_prog_type);
 
-			if (prog_type < ARRAY_SIZE(prog_type_name))
+			if (prog_type < prog_type_name_size)
 				jsonw_string_field(json_wtr, "owner_prog_type",
 						   prog_type_name[prog_type]);
 			else
@@ -557,7 +557,7 @@ static int show_map_close_plain(int fd, struct bpf_map_info *info)
 		if (owner_prog_type) {
 			unsigned int prog_type = atoi(owner_prog_type);
 
-			if (prog_type < ARRAY_SIZE(prog_type_name))
+			if (prog_type < prog_type_name_size)
 				printf("owner_prog_type %s  ",
 				       prog_type_name[prog_type]);
 			else
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index e21fa8ad2efa..6863c57effd0 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -29,6 +29,40 @@
 #include "main.h"
 #include "xlated_dumper.h"
 
+const char * const prog_type_name[] = {
+	[BPF_PROG_TYPE_UNSPEC]			= "unspec",
+	[BPF_PROG_TYPE_SOCKET_FILTER]		= "socket_filter",
+	[BPF_PROG_TYPE_KPROBE]			= "kprobe",
+	[BPF_PROG_TYPE_SCHED_CLS]		= "sched_cls",
+	[BPF_PROG_TYPE_SCHED_ACT]		= "sched_act",
+	[BPF_PROG_TYPE_TRACEPOINT]		= "tracepoint",
+	[BPF_PROG_TYPE_XDP]			= "xdp",
+	[BPF_PROG_TYPE_PERF_EVENT]		= "perf_event",
+	[BPF_PROG_TYPE_CGROUP_SKB]		= "cgroup_skb",
+	[BPF_PROG_TYPE_CGROUP_SOCK]		= "cgroup_sock",
+	[BPF_PROG_TYPE_LWT_IN]			= "lwt_in",
+	[BPF_PROG_TYPE_LWT_OUT]			= "lwt_out",
+	[BPF_PROG_TYPE_LWT_XMIT]		= "lwt_xmit",
+	[BPF_PROG_TYPE_SOCK_OPS]		= "sock_ops",
+	[BPF_PROG_TYPE_SK_SKB]			= "sk_skb",
+	[BPF_PROG_TYPE_CGROUP_DEVICE]		= "cgroup_device",
+	[BPF_PROG_TYPE_SK_MSG]			= "sk_msg",
+	[BPF_PROG_TYPE_RAW_TRACEPOINT]		= "raw_tracepoint",
+	[BPF_PROG_TYPE_CGROUP_SOCK_ADDR]	= "cgroup_sock_addr",
+	[BPF_PROG_TYPE_LWT_SEG6LOCAL]		= "lwt_seg6local",
+	[BPF_PROG_TYPE_LIRC_MODE2]		= "lirc_mode2",
+	[BPF_PROG_TYPE_SK_REUSEPORT]		= "sk_reuseport",
+	[BPF_PROG_TYPE_FLOW_DISSECTOR]		= "flow_dissector",
+	[BPF_PROG_TYPE_CGROUP_SYSCTL]		= "cgroup_sysctl",
+	[BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE]	= "raw_tracepoint_writable",
+	[BPF_PROG_TYPE_CGROUP_SOCKOPT]		= "cgroup_sockopt",
+	[BPF_PROG_TYPE_TRACING]			= "tracing",
+	[BPF_PROG_TYPE_STRUCT_OPS]		= "struct_ops",
+	[BPF_PROG_TYPE_EXT]			= "ext",
+};
+
+const size_t prog_type_name_size = ARRAY_SIZE(prog_type_name);
+
 enum dump_mode {
 	DUMP_JITED,
 	DUMP_XLATED,
-- 
2.27.0

