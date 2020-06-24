Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D202075BB
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 16:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbgFXOb6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 10:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390429AbgFXOb6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 10:31:58 -0400
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80385C061573
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2020 07:31:58 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49sQZg0ZMkzvjc1; Wed, 24 Jun 2020 16:31:54 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] tools, bpftool: Define attach_type_name array only once
Date:   Wed, 24 Jun 2020 16:31:54 +0200
Message-Id: <20200624143154.13145-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200623104227.11435-3-tklauser@distanz.ch>
References: <20200623104227.11435-3-tklauser@distanz.ch>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Define attach_type_name in common.c instead of main.h so it is only
defined once. This leads to a slight decrease in the binary size of
bpftool.

Before:

   text	   data	    bss	    dec	    hex	filename
 399024	  11168	1573160	1983352	 1e4378	bpftool

After:

   text	   data	    bss	    dec	    hex	filename
 398256	  10880	1573160	1982296	 1e3f58	bpftool

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
v3: align strings in attach_type_name as suggested by Daniel.

 tools/bpf/bpftool/common.c | 36 ++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/main.h   | 36 +-----------------------------------
 2 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 6c864c3683fc..18e5604fe260 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -29,6 +29,42 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #endif
 
+const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
+	[BPF_CGROUP_INET_INGRESS]	= "ingress",
+	[BPF_CGROUP_INET_EGRESS]	= "egress",
+	[BPF_CGROUP_INET_SOCK_CREATE]	= "sock_create",
+	[BPF_CGROUP_SOCK_OPS]		= "sock_ops",
+	[BPF_CGROUP_DEVICE]		= "device",
+	[BPF_CGROUP_INET4_BIND]		= "bind4",
+	[BPF_CGROUP_INET6_BIND]		= "bind6",
+	[BPF_CGROUP_INET4_CONNECT]	= "connect4",
+	[BPF_CGROUP_INET6_CONNECT]	= "connect6",
+	[BPF_CGROUP_INET4_POST_BIND]	= "post_bind4",
+	[BPF_CGROUP_INET6_POST_BIND]	= "post_bind6",
+	[BPF_CGROUP_INET4_GETPEERNAME]	= "getpeername4",
+	[BPF_CGROUP_INET6_GETPEERNAME]	= "getpeername6",
+	[BPF_CGROUP_INET4_GETSOCKNAME]	= "getsockname4",
+	[BPF_CGROUP_INET6_GETSOCKNAME]	= "getsockname6",
+	[BPF_CGROUP_UDP4_SENDMSG]	= "sendmsg4",
+	[BPF_CGROUP_UDP6_SENDMSG]	= "sendmsg6",
+	[BPF_CGROUP_SYSCTL]		= "sysctl",
+	[BPF_CGROUP_UDP4_RECVMSG]	= "recvmsg4",
+	[BPF_CGROUP_UDP6_RECVMSG]	= "recvmsg6",
+	[BPF_CGROUP_GETSOCKOPT]		= "getsockopt",
+	[BPF_CGROUP_SETSOCKOPT]		= "setsockopt",
+
+	[BPF_SK_SKB_STREAM_PARSER]	= "sk_skb_stream_parser",
+	[BPF_SK_SKB_STREAM_VERDICT]	= "sk_skb_stream_verdict",
+	[BPF_SK_MSG_VERDICT]		= "sk_msg_verdict",
+	[BPF_LIRC_MODE2]		= "lirc_mode2",
+	[BPF_FLOW_DISSECTOR]		= "flow_dissector",
+	[BPF_TRACE_RAW_TP]		= "raw_tp",
+	[BPF_TRACE_FENTRY]		= "fentry",
+	[BPF_TRACE_FEXIT]		= "fexit",
+	[BPF_MODIFY_RETURN]		= "mod_ret",
+	[BPF_LSM_MAC]			= "lsm_mac",
+};
+
 void p_err(const char *fmt, ...)
 {
 	va_list ap;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 269f1cb6aef5..78d34e860713 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -59,41 +59,7 @@
 extern const char * const prog_type_name[];
 extern const size_t prog_type_name_size;
 
-static const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
-	[BPF_CGROUP_INET_INGRESS] = "ingress",
-	[BPF_CGROUP_INET_EGRESS] = "egress",
-	[BPF_CGROUP_INET_SOCK_CREATE] = "sock_create",
-	[BPF_CGROUP_SOCK_OPS] = "sock_ops",
-	[BPF_CGROUP_DEVICE] = "device",
-	[BPF_CGROUP_INET4_BIND] = "bind4",
-	[BPF_CGROUP_INET6_BIND] = "bind6",
-	[BPF_CGROUP_INET4_CONNECT] = "connect4",
-	[BPF_CGROUP_INET6_CONNECT] = "connect6",
-	[BPF_CGROUP_INET4_POST_BIND] = "post_bind4",
-	[BPF_CGROUP_INET6_POST_BIND] = "post_bind6",
-	[BPF_CGROUP_INET4_GETPEERNAME] = "getpeername4",
-	[BPF_CGROUP_INET6_GETPEERNAME] = "getpeername6",
-	[BPF_CGROUP_INET4_GETSOCKNAME] = "getsockname4",
-	[BPF_CGROUP_INET6_GETSOCKNAME] = "getsockname6",
-	[BPF_CGROUP_UDP4_SENDMSG] = "sendmsg4",
-	[BPF_CGROUP_UDP6_SENDMSG] = "sendmsg6",
-	[BPF_CGROUP_SYSCTL] = "sysctl",
-	[BPF_CGROUP_UDP4_RECVMSG] = "recvmsg4",
-	[BPF_CGROUP_UDP6_RECVMSG] = "recvmsg6",
-	[BPF_CGROUP_GETSOCKOPT] = "getsockopt",
-	[BPF_CGROUP_SETSOCKOPT] = "setsockopt",
-
-	[BPF_SK_SKB_STREAM_PARSER] = "sk_skb_stream_parser",
-	[BPF_SK_SKB_STREAM_VERDICT] = "sk_skb_stream_verdict",
-	[BPF_SK_MSG_VERDICT] = "sk_msg_verdict",
-	[BPF_LIRC_MODE2] = "lirc_mode2",
-	[BPF_FLOW_DISSECTOR] = "flow_dissector",
-	[BPF_TRACE_RAW_TP] = "raw_tp",
-	[BPF_TRACE_FENTRY] = "fentry",
-	[BPF_TRACE_FEXIT] = "fexit",
-	[BPF_MODIFY_RETURN] = "mod_ret",
-	[BPF_LSM_MAC] = "lsm_mac",
-};
+extern const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE];
 
 extern const char * const map_type_name[];
 extern const size_t map_type_name_size;
-- 
2.27.0

