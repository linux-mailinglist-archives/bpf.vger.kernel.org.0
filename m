Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E646E528C14
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiEPRg1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbiEPRgM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 13:36:12 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4E620F72
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 10:36:07 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 0E653240029
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 19:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652722566; bh=rJqip8fzS15QL+iepAhRfjj7fcGN1jxW6fT3HE9YFjQ=;
        h=From:To:Subject:Date:From;
        b=SZtLEd7z1qySmmRVV6z80p9IZ0KR6pUFzXWPlaoeMCFRz5iZcugJJjb2q4r2Y0pTj
         rmXC4j5R5annwJRADt+bkwxc5zGRehw3h7zjRIeoKQJmvJVnkfeGfTTYJT+ffKeOv3
         weXj4aTndHIQdcxt0/rS/b2kcColxnCXAXYw1DhgVHZxqtQm2sBw/8mXGjrl1B24Cz
         dQ/whTdexuVOAwZw5lpHTWWDZEexTfHPJD6aoz1+boqiUJdvgxtwN/LiNspz8n3zpu
         90eoXcCpGB1hs3LZD2BpUYJ7qX5mgDiVdvsumUoCqUbKraojOgNMBibevOePgZfo/U
         r41rvihCn1wWg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L25yD6NFzz6tmj;
        Mon, 16 May 2022 19:36:04 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next 09/12] bpftool: Use libbpf_bpf_attach_type_str
Date:   Mon, 16 May 2022 17:35:37 +0000
Message-Id: <20220516173540.3520665-10-deso@posteo.net>
In-Reply-To: <20220516173540.3520665-1-deso@posteo.net>
References: <20220516173540.3520665-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change switches bpftool over to using the recently introduced
libbpf_bpf_attach_type_str function instead of maintaining its own
string representation for the bpf_attach_type enum.

Note that contrary to other enum types, the variant names that bpftool
maps bpf_attach_type to do not follow a simple to follow rule. With
bpf_prog_type, for example, the textual representation can easily be
inferred by stripping the BPF_PROG_TYPE_ prefix and lowercasing the
remaining string. bpf_attach_type violates this rule for various
variants. In order to not brake compatibility (these textual
representations appear in JSON and are used to parse user input), we
introduce a program local bpf_attach_type_str that overrides the
variants in question.
We should consider removing this function and expect the libbpf string
representation with the next backwards compatibility breaking release,
if possible.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/bpf/bpftool/cgroup.c | 20 ++++++----
 tools/bpf/bpftool/common.c | 82 +++++++++++++++++---------------------
 tools/bpf/bpftool/link.c   | 15 ++++---
 tools/bpf/bpftool/main.h   | 15 +++++++
 4 files changed, 73 insertions(+), 59 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index effe136..fdaef2 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -35,11 +35,14 @@ static unsigned int query_flags;
 
 static enum bpf_attach_type parse_attach_type(const char *str)
 {
+	const char *attach_type_str;
 	enum bpf_attach_type type;
 
-	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
-		if (attach_type_name[type] &&
-		    is_prefix(str, attach_type_name[type]))
+	for (type = 0; ; type++) {
+		attach_type_str = bpf_attach_type_str(type);
+		if (!attach_type_str)
+			break;
+		if (is_prefix(str, attach_type_str))
 			return type;
 	}
 
@@ -52,6 +55,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 {
 	char prog_name[MAX_PROG_FULL_NAME];
 	struct bpf_prog_info info = {};
+	const char *attach_type_str;
 	__u32 info_len = sizeof(info);
 	int prog_fd;
 
@@ -64,13 +68,13 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 		return -1;
 	}
 
+	attach_type_str = bpf_attach_type_str(attach_type);
 	get_prog_full_name(&info, prog_fd, prog_name, sizeof(prog_name));
 	if (json_output) {
 		jsonw_start_object(json_wtr);
 		jsonw_uint_field(json_wtr, "id", info.id);
-		if (attach_type < ARRAY_SIZE(attach_type_name))
-			jsonw_string_field(json_wtr, "attach_type",
-					   attach_type_name[attach_type]);
+		if (attach_type_str)
+			jsonw_string_field(json_wtr, "attach_type", attach_type_str);
 		else
 			jsonw_uint_field(json_wtr, "attach_type", attach_type);
 		jsonw_string_field(json_wtr, "attach_flags",
@@ -79,8 +83,8 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 		jsonw_end_object(json_wtr);
 	} else {
 		printf("%s%-8u ", level ? "    " : "", info.id);
-		if (attach_type < ARRAY_SIZE(attach_type_name))
-			printf("%-15s", attach_type_name[attach_type]);
+		if (attach_type_str)
+			printf("%-15s", attach_type_str);
 		else
 			printf("type %-10u", attach_type);
 		printf(" %-15s %-15s\n", attach_flags_str, prog_name);
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index c74014..00ab85 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -31,52 +31,6 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #endif
 
-const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
-	[BPF_CGROUP_INET_INGRESS]	= "ingress",
-	[BPF_CGROUP_INET_EGRESS]	= "egress",
-	[BPF_CGROUP_INET_SOCK_CREATE]	= "sock_create",
-	[BPF_CGROUP_INET_SOCK_RELEASE]	= "sock_release",
-	[BPF_CGROUP_SOCK_OPS]		= "sock_ops",
-	[BPF_CGROUP_DEVICE]		= "device",
-	[BPF_CGROUP_INET4_BIND]		= "bind4",
-	[BPF_CGROUP_INET6_BIND]		= "bind6",
-	[BPF_CGROUP_INET4_CONNECT]	= "connect4",
-	[BPF_CGROUP_INET6_CONNECT]	= "connect6",
-	[BPF_CGROUP_INET4_POST_BIND]	= "post_bind4",
-	[BPF_CGROUP_INET6_POST_BIND]	= "post_bind6",
-	[BPF_CGROUP_INET4_GETPEERNAME]	= "getpeername4",
-	[BPF_CGROUP_INET6_GETPEERNAME]	= "getpeername6",
-	[BPF_CGROUP_INET4_GETSOCKNAME]	= "getsockname4",
-	[BPF_CGROUP_INET6_GETSOCKNAME]	= "getsockname6",
-	[BPF_CGROUP_UDP4_SENDMSG]	= "sendmsg4",
-	[BPF_CGROUP_UDP6_SENDMSG]	= "sendmsg6",
-	[BPF_CGROUP_SYSCTL]		= "sysctl",
-	[BPF_CGROUP_UDP4_RECVMSG]	= "recvmsg4",
-	[BPF_CGROUP_UDP6_RECVMSG]	= "recvmsg6",
-	[BPF_CGROUP_GETSOCKOPT]		= "getsockopt",
-	[BPF_CGROUP_SETSOCKOPT]		= "setsockopt",
-	[BPF_SK_SKB_STREAM_PARSER]	= "sk_skb_stream_parser",
-	[BPF_SK_SKB_STREAM_VERDICT]	= "sk_skb_stream_verdict",
-	[BPF_SK_SKB_VERDICT]		= "sk_skb_verdict",
-	[BPF_SK_MSG_VERDICT]		= "sk_msg_verdict",
-	[BPF_LIRC_MODE2]		= "lirc_mode2",
-	[BPF_FLOW_DISSECTOR]		= "flow_dissector",
-	[BPF_TRACE_RAW_TP]		= "raw_tp",
-	[BPF_TRACE_FENTRY]		= "fentry",
-	[BPF_TRACE_FEXIT]		= "fexit",
-	[BPF_MODIFY_RETURN]		= "mod_ret",
-	[BPF_LSM_MAC]			= "lsm_mac",
-	[BPF_SK_LOOKUP]			= "sk_lookup",
-	[BPF_TRACE_ITER]		= "trace_iter",
-	[BPF_XDP_DEVMAP]		= "xdp_devmap",
-	[BPF_XDP_CPUMAP]		= "xdp_cpumap",
-	[BPF_XDP]			= "xdp",
-	[BPF_SK_REUSEPORT_SELECT]	= "sk_skb_reuseport_select",
-	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	= "sk_skb_reuseport_select_or_migrate",
-	[BPF_PERF_EVENT]		= "perf_event",
-	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
-};
-
 void p_err(const char *fmt, ...)
 {
 	va_list ap;
@@ -1009,3 +963,39 @@ bool equal_fn_for_key_as_id(const void *k1, const void *k2, void *ctx)
 {
 	return k1 == k2;
 }
+
+const char *bpf_attach_type_str(enum bpf_attach_type t)
+{
+	switch (t) {
+	case BPF_CGROUP_INET_INGRESS:		return "ingress";
+	case BPF_CGROUP_INET_EGRESS:		return "egress";
+	case BPF_CGROUP_INET_SOCK_CREATE:	return "sock_create";
+	case BPF_CGROUP_INET_SOCK_RELEASE:	return "sock_release";
+	case BPF_CGROUP_SOCK_OPS:		return "sock_ops";
+	case BPF_CGROUP_DEVICE:			return "device";
+	case BPF_CGROUP_INET4_BIND:		return "bind4";
+	case BPF_CGROUP_INET6_BIND:		return "bind6";
+	case BPF_CGROUP_INET4_CONNECT:		return "connect4";
+	case BPF_CGROUP_INET6_CONNECT:		return "connect6";
+	case BPF_CGROUP_INET4_POST_BIND:	return "post_bind4";
+	case BPF_CGROUP_INET6_POST_BIND:	return "post_bind6";
+	case BPF_CGROUP_INET4_GETPEERNAME:	return "getpeername4";
+	case BPF_CGROUP_INET6_GETPEERNAME:	return "getpeername6";
+	case BPF_CGROUP_INET4_GETSOCKNAME:	return "getsockname4";
+	case BPF_CGROUP_INET6_GETSOCKNAME:	return "getsockname6";
+	case BPF_CGROUP_UDP4_SENDMSG:		return "sendmsg4";
+	case BPF_CGROUP_UDP6_SENDMSG:		return "sendmsg6";
+	case BPF_CGROUP_SYSCTL:			return "sysctl";
+	case BPF_CGROUP_UDP4_RECVMSG:		return "recvmsg4";
+	case BPF_CGROUP_UDP6_RECVMSG:		return "recvmsg6";
+	case BPF_CGROUP_GETSOCKOPT:		return "getsockopt";
+	case BPF_CGROUP_SETSOCKOPT:		return "setsockopt";
+	case BPF_TRACE_RAW_TP:			return "raw_tp";
+	case BPF_TRACE_FENTRY:			return "fentry";
+	case BPF_TRACE_FEXIT:			return "fexit";
+	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
+	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
+	default:	return libbpf_bpf_attach_type_str(t);
+	}
+}
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index e27108..2dd0d01 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -78,9 +78,11 @@ show_link_header_json(struct bpf_link_info *info, json_writer_t *wtr)
 
 static void show_link_attach_type_json(__u32 attach_type, json_writer_t *wtr)
 {
-	if (attach_type < ARRAY_SIZE(attach_type_name))
-		jsonw_string_field(wtr, "attach_type",
-				   attach_type_name[attach_type]);
+	const char *attach_type_str;
+
+	attach_type_str = bpf_attach_type_str(attach_type);
+	if (attach_type_str)
+		jsonw_string_field(wtr, "attach_type", attach_type_str);
 	else
 		jsonw_uint_field(wtr, "attach_type", attach_type);
 }
@@ -196,8 +198,11 @@ static void show_link_header_plain(struct bpf_link_info *info)
 
 static void show_link_attach_type_plain(__u32 attach_type)
 {
-	if (attach_type < ARRAY_SIZE(attach_type_name))
-		printf("attach_type %s  ", attach_type_name[attach_type]);
+	const char *attach_type_str;
+
+	attach_type_str = bpf_attach_type_str(attach_type);
+	if (attach_type_str)
+		printf("attach_type %s  ", attach_type_str);
 	else
 		printf("attach_type %u  ", attach_type);
 }
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index e4fdaa0..e27237c 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -243,6 +243,21 @@ int print_all_levels(__maybe_unused enum libbpf_print_level level,
 size_t hash_fn_for_key_as_id(const void *key, void *ctx);
 bool equal_fn_for_key_as_id(const void *k1, const void *k2, void *ctx);
 
+/**
+ * bpf_attach_type_str - convert the provided attach type value into a textual
+ * representation.
+ *
+ * This function acts as a wrapper around libbpf_bpf_attach_type_str which
+ * overrides some of the variant names with ones that have traditionally been
+ * used in the program (and that do not follow the string inference scheme that
+ * libbpf uses).
+ *
+ * @t: The attach type
+ * Returns a pointer to a static string identifying the attach type. NULL is
+ * returned for unknown bpf_attach_type values.
+ */
+const char *bpf_attach_type_str(enum bpf_attach_type t);
+
 static inline void *u32_as_hash_field(__u32 x)
 {
 	return (void *)(uintptr_t)x;
-- 
2.30.2

