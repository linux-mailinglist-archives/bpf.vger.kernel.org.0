Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E125E531F13
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiEWXEz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 19:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiEWXEy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 19:04:54 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BB3AFB16
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 16:04:52 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 29F4F240108
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 01:04:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1653347091; bh=r1i6Zm4XBlMxinwnDnUK3JMsnfqp/rLL+73o9DOFolU=;
        h=From:To:Cc:Subject:Date:From;
        b=ov6/GY0EmGhpzxHGfYxlEb+6NfKcnlYGR0b2Rtt56pMry1yHgTI0ix/UH+mP7PL3+
         zYu8VEPdb12OS0vZVoNQx2vZIzf2F72lnUcOsQk08sQmA6afGDNAlKjbpcofYclrKm
         EF5ijku5LL77X6fzsGBxoUMUX7JEkyo++M4iZcVowPTwgtuJ0VQ5qGz908Rb6s0cQk
         5HwdC6ruaYAk1KH1X4oB41yutpROa/QCmwCQJhywHxQx3QrUyw0Wu5kL2Lb9ttI2wn
         iR6KCR7KVi2jfTA6HgxqHXTAN5xvcfb8yN7s2oM/DpQM6JImsfDp5CQMLOQc1E3NxG
         9bgsCVdds2vgw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L6XwL0z49z9rxF;
        Tue, 24 May 2022 01:04:50 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v4 09/12] bpftool: Use libbpf_bpf_attach_type_str
Date:   Mon, 23 May 2022 23:04:25 +0000
Message-Id: <20220523230428.3077108-10-deso@posteo.net>
In-Reply-To: <20220523230428.3077108-1-deso@posteo.net>
References: <20220523230428.3077108-1-deso@posteo.net>
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
maps bpf_attach_type to do not adhere a simple to follow rule. With
bpf_prog_type, for example, the textual representation can easily be
inferred by stripping the BPF_PROG_TYPE_ prefix and lowercasing the
remaining string. bpf_attach_type violates this rule for various
variants.
We decided to fix up this deficiency with this change, meaning that
bpftool uses the same textual representations as libbpf. Supporting
tests, completion scripts, and man pages have been adjusted accordingly.
However, we did add support for accepting (the now undocumented)
original attach type names when they are provided by users.

For the test (test_bpftool_synctypes.py), I have removed the enum
representation checks, because we no longer mirror the various enum
variant names in bpftool source code. For the man page, help text, and
completion script checks we are now using enum definitions from
uapi/linux/bpf.h as the source of truth directly.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 .../bpftool/Documentation/bpftool-cgroup.rst  |  16 ++-
 .../bpftool/Documentation/bpftool-prog.rst    |   5 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  18 +--
 tools/bpf/bpftool/cgroup.c                    |  53 ++++++---
 tools/bpf/bpftool/common.c                    |  82 ++++++--------
 tools/bpf/bpftool/link.c                      |  15 ++-
 tools/bpf/bpftool/main.h                      |  14 +++
 tools/bpf/bpftool/prog.c                      |  26 ++++-
 .../selftests/bpf/test_bpftool_synctypes.py   | 104 +++++++-----------
 9 files changed, 183 insertions(+), 150 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index a17e9a..bd015e 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -31,11 +31,17 @@ CGROUP COMMANDS
 |	**bpftool** **cgroup help**
 |
 |	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
-|	*ATTACH_TYPE* := { **ingress** | **egress** | **sock_create** | **sock_ops** | **device** |
-|		**bind4** | **bind6** | **post_bind4** | **post_bind6** | **connect4** | **connect6** |
-|		**getpeername4** | **getpeername6** | **getsockname4** | **getsockname6** | **sendmsg4** |
-|		**sendmsg6** | **recvmsg4** | **recvmsg6** | **sysctl** | **getsockopt** | **setsockopt** |
-|		**sock_release** }
+|	*ATTACH_TYPE* := { **cgroup_inet_ingress** | **cgroup_inet_egress** |
+|		**cgroup_inet_sock_create** | **cgroup_sock_ops** |
+|		**cgroup_device** | **cgroup_inet4_bind** | **cgroup_inet6_bind** |
+|		**cgroup_inet4_post_bind** | **cgroup_inet6_post_bind** |
+|		**cgroup_inet4_connect** | **cgroup_inet6_connect** |
+|		**cgroup_inet4_getpeername** | **cgroup_inet6_getpeername** |
+|		**cgroup_inet4_getsockname** | **cgroup_inet6_getsockname** |
+|		**cgroup_udp4_sendmsg** | **cgroup_udp6_sendmsg** |
+|		**cgroup_udp4_recvmsg** | **cgroup_udp6_recvmsg** |
+|		**cgroup_sysctl** | **cgroup_getsockopt** | **cgroup_setsockopt** |
+|		**cgroup_inet_sock_release** }
 |	*ATTACH_FLAGS* := { **multi** | **override** }
 
 DESCRIPTION
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index a2e935..eb1b2a 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -53,8 +53,9 @@ PROG COMMANDS
 |		**cgroup/getsockopt** | **cgroup/setsockopt** | **cgroup/sock_release** |
 |		**struct_ops** | **fentry** | **fexit** | **freplace** | **sk_lookup**
 |	}
-|       *ATTACH_TYPE* := {
-|		**msg_verdict** | **skb_verdict** | **stream_verdict** | **stream_parser** | **flow_dissector**
+|	*ATTACH_TYPE* := {
+|		**sk_msg_verdict** | **sk_skb_verdict** | **sk_skb_stream_verdict** |
+|		**sk_skb_stream_parser** | **flow_dissector**
 |	}
 |	*METRICs* := {
 |		**cycles** | **instructions** | **l1d_loads** | **llc_misses** |
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 5df8d7..91f89a 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -407,8 +407,8 @@ _bpftool()
                             return 0
                             ;;
                         5)
-                            local BPFTOOL_PROG_ATTACH_TYPES='msg_verdict \
-                                skb_verdict stream_verdict stream_parser \
+                            local BPFTOOL_PROG_ATTACH_TYPES='sk_msg_verdict \
+                                sk_skb_verdict sk_skb_stream_verdict sk_skb_stream_parser \
                                 flow_dissector'
                             COMPREPLY=( $( compgen -W "$BPFTOOL_PROG_ATTACH_TYPES" -- "$cur" ) )
                             return 0
@@ -1039,12 +1039,14 @@ _bpftool()
                     return 0
                     ;;
                 attach|detach)
-                    local BPFTOOL_CGROUP_ATTACH_TYPES='ingress egress \
-                        sock_create sock_ops device \
-                        bind4 bind6 post_bind4 post_bind6 connect4 connect6 \
-                        getpeername4 getpeername6 getsockname4 getsockname6 \
-                        sendmsg4 sendmsg6 recvmsg4 recvmsg6 sysctl getsockopt \
-                        setsockopt sock_release'
+                    local BPFTOOL_CGROUP_ATTACH_TYPES='cgroup_inet_ingress cgroup_inet_egress \
+                        cgroup_inet_sock_create cgroup_sock_ops cgroup_device cgroup_inet4_bind \
+                        cgroup_inet6_bind cgroup_inet4_post_bind cgroup_inet6_post_bind \
+                        cgroup_inet4_connect cgroup_inet6_connect cgroup_inet4_getpeername \
+                        cgroup_inet6_getpeername cgroup_inet4_getsockname cgroup_inet6_getsockname \
+                        cgroup_udp4_sendmsg cgroup_udp6_sendmsg cgroup_udp4_recvmsg \
+                        cgroup_udp6_recvmsg cgroup_sysctl cgroup_getsockopt cgroup_setsockopt \
+                        cgroup_inet_sock_release'
                     local ATTACH_FLAGS='multi override'
                     local PROG_TYPE='id pinned tag name'
                     # Check for $prev = $command first
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index effe136..42421f 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -21,25 +21,43 @@
 #define HELP_SPEC_ATTACH_FLAGS						\
 	"ATTACH_FLAGS := { multi | override }"
 
-#define HELP_SPEC_ATTACH_TYPES						       \
-	"       ATTACH_TYPE := { ingress | egress | sock_create |\n"	       \
-	"                        sock_ops | device | bind4 | bind6 |\n"	       \
-	"                        post_bind4 | post_bind6 | connect4 |\n"       \
-	"                        connect6 | getpeername4 | getpeername6 |\n"   \
-	"                        getsockname4 | getsockname6 | sendmsg4 |\n"   \
-	"                        sendmsg6 | recvmsg4 | recvmsg6 |\n"           \
-	"                        sysctl | getsockopt | setsockopt |\n"	       \
-	"                        sock_release }"
+#define HELP_SPEC_ATTACH_TYPES						\
+	"       ATTACH_TYPE := { cgroup_inet_ingress | cgroup_inet_egress |\n" \
+	"                        cgroup_inet_sock_create | cgroup_sock_ops |\n" \
+	"                        cgroup_device | cgroup_inet4_bind |\n" \
+	"                        cgroup_inet6_bind | cgroup_inet4_post_bind |\n" \
+	"                        cgroup_inet6_post_bind | cgroup_inet4_connect |\n" \
+	"                        cgroup_inet6_connect | cgroup_inet4_getpeername |\n" \
+	"                        cgroup_inet6_getpeername | cgroup_inet4_getsockname |\n" \
+	"                        cgroup_inet6_getsockname | cgroup_udp4_sendmsg |\n" \
+	"                        cgroup_udp6_sendmsg | cgroup_udp4_recvmsg |\n" \
+	"                        cgroup_udp6_recvmsg | cgroup_sysctl |\n" \
+	"                        cgroup_getsockopt | cgroup_setsockopt |\n" \
+	"                        cgroup_inet_sock_release }"
 
 static unsigned int query_flags;
 
 static enum bpf_attach_type parse_attach_type(const char *str)
 {
+	const char *attach_type_str;
 	enum bpf_attach_type type;
 
-	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
-		if (attach_type_name[type] &&
-		    is_prefix(str, attach_type_name[type]))
+	for (type = 0; ; type++) {
+		attach_type_str = libbpf_bpf_attach_type_str(type);
+		if (!attach_type_str)
+			break;
+		if (!strcmp(str, attach_type_str))
+			return type;
+	}
+
+	/* Also check traditionally used attach type strings. For these we keep
+	 * allowing prefixed usage.
+	 */
+	for (type = 0; ; type++) {
+		attach_type_str = bpf_attach_type_input_str(type);
+		if (!attach_type_str)
+			break;
+		if (is_prefix(str, attach_type_str))
 			return type;
 	}
 
@@ -52,6 +70,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 {
 	char prog_name[MAX_PROG_FULL_NAME];
 	struct bpf_prog_info info = {};
+	const char *attach_type_str;
 	__u32 info_len = sizeof(info);
 	int prog_fd;
 
@@ -64,13 +83,13 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 		return -1;
 	}
 
+	attach_type_str = libbpf_bpf_attach_type_str(attach_type);
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
@@ -79,8 +98,8 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
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
index c74014..a45b42 100644
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
+const char *bpf_attach_type_input_str(enum bpf_attach_type t)
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
index e27108..66a254 100644
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
+	attach_type_str = libbpf_bpf_attach_type_str(attach_type);
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
+	attach_type_str = libbpf_bpf_attach_type_str(attach_type);
+	if (attach_type_str)
+		printf("attach_type %s  ", attach_type_str);
 	else
 		printf("attach_type %u  ", attach_type);
 }
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index e4fdaa0..6c311f4 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -243,6 +243,20 @@ int print_all_levels(__maybe_unused enum libbpf_print_level level,
 size_t hash_fn_for_key_as_id(const void *key, void *ctx);
 bool equal_fn_for_key_as_id(const void *k1, const void *k2, void *ctx);
 
+/* bpf_attach_type_input_str - convert the provided attach type value into a
+ * textual representation that we accept for input purposes.
+ *
+ * This function is similar in nature to libbpf_bpf_attach_type_str, but
+ * recognizes some attach type names that have been used by the program in the
+ * past and which do not follow the string inference scheme that libbpf uses.
+ * These textual representations should only be used for user input.
+ *
+ * @t: The attach type
+ * Returns a pointer to a static string identifying the attach type. NULL is
+ * returned for unknown bpf_attach_type values.
+ */
+const char *bpf_attach_type_input_str(enum bpf_attach_type t);
+
 static inline void *u32_as_hash_field(__u32 x)
 {
 	return (void *)(uintptr_t)x;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 39e1e71..6e08a30 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -41,12 +41,24 @@ enum dump_mode {
 	DUMP_XLATED,
 };
 
+static const bool attach_types[] = {
+	[BPF_SK_SKB_STREAM_PARSER] = true,
+	[BPF_SK_SKB_STREAM_VERDICT] = true,
+	[BPF_SK_SKB_VERDICT] = true,
+	[BPF_SK_MSG_VERDICT] = true,
+	[BPF_FLOW_DISSECTOR] = true,
+	[__MAX_BPF_ATTACH_TYPE] = false,
+};
+
+/*
+ * Textual representations traditionally used by the program and kept around for
+ * the sake of backwards compatibility.
+ */
 static const char * const attach_type_strings[] = {
 	[BPF_SK_SKB_STREAM_PARSER] = "stream_parser",
 	[BPF_SK_SKB_STREAM_VERDICT] = "stream_verdict",
 	[BPF_SK_SKB_VERDICT] = "skb_verdict",
 	[BPF_SK_MSG_VERDICT] = "msg_verdict",
-	[BPF_FLOW_DISSECTOR] = "flow_dissector",
 	[__MAX_BPF_ATTACH_TYPE] = NULL,
 };
 
@@ -57,6 +69,14 @@ static enum bpf_attach_type parse_attach_type(const char *str)
 	enum bpf_attach_type type;
 
 	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
+		if (attach_types[type]) {
+			const char *attach_type_str;
+
+			attach_type_str = libbpf_bpf_attach_type_str(type);
+			if (!strcmp(str, attach_type_str))
+				return type;
+		}
+
 		if (attach_type_strings[type] &&
 		    is_prefix(str, attach_type_strings[type]))
 			return type;
@@ -2341,8 +2361,8 @@ static int do_help(int argc, char **argv)
 		"                 cgroup/sendmsg6 | cgroup/recvmsg4 | cgroup/recvmsg6 |\n"
 		"                 cgroup/getsockopt | cgroup/setsockopt | cgroup/sock_release |\n"
 		"                 struct_ops | fentry | fexit | freplace | sk_lookup }\n"
-		"       ATTACH_TYPE := { msg_verdict | skb_verdict | stream_verdict |\n"
-		"                        stream_parser | flow_dissector }\n"
+		"       ATTACH_TYPE := { sk_msg_verdict | sk_skb_verdict | sk_skb_stream_verdict |\n"
+		"                        sk_skb_stream_parser | flow_dissector }\n"
 		"       METRIC := { cycles | instructions | l1d_loads | llc_misses | itlb_misses | dtlb_misses }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-m|--mapcompat} | {-n|--nomount} |\n"
diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
index 0a08c0..e443e65 100755
--- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
+++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
@@ -58,7 +58,7 @@ class BlockParser(object):
 
 class ArrayParser(BlockParser):
     """
-    A parser for extracting dicionaries of values from some BPF-related arrays.
+    A parser for extracting a set of values from some BPF-related arrays.
     @reader: a pointer to the open file to parse
     @array_name: name of the array to parse
     """
@@ -66,7 +66,7 @@ class ArrayParser(BlockParser):
 
     def __init__(self, reader, array_name):
         self.array_name = array_name
-        self.start_marker = re.compile(f'(static )?const char \* const {self.array_name}\[.*\] = {{\n')
+        self.start_marker = re.compile(f'(static )?const bool {self.array_name}\[.*\] = {{\n')
         super().__init__(reader)
 
     def search_block(self):
@@ -80,15 +80,15 @@ class ArrayParser(BlockParser):
         Parse a block and return data as a dictionary. Items to extract must be
         on separate lines in the file.
         """
-        pattern = re.compile('\[(BPF_\w*)\]\s*= "(.*)",?$')
-        entries = {}
+        pattern = re.compile('\[(BPF_\w*)\]\s*= (true|false),?$')
+        entries = set()
         while True:
             line = self.reader.readline()
             if line == '' or re.match(self.end_marker, line):
                 break
             capture = pattern.search(line)
             if capture:
-                entries[capture.group(1)] = capture.group(2)
+                entries |= {capture.group(1)}
         return entries
 
 class InlineListParser(BlockParser):
@@ -115,7 +115,7 @@ class InlineListParser(BlockParser):
 class FileExtractor(object):
     """
     A generic reader for extracting data from a given file. This class contains
-    several helper methods that wrap arround parser objects to extract values
+    several helper methods that wrap around parser objects to extract values
     from different structures.
     This class does not offer a way to set a filename, which is expected to be
     defined in children classes.
@@ -139,21 +139,19 @@ class FileExtractor(object):
 
     def get_types_from_array(self, array_name):
         """
-        Search for and parse an array associating names to BPF_* enum members,
-        for example:
+        Search for and parse a list of allowed BPF_* enum members, for example:
 
-            const char * const prog_type_name[] = {
-                    [BPF_PROG_TYPE_UNSPEC]                  = "unspec",
-                    [BPF_PROG_TYPE_SOCKET_FILTER]           = "socket_filter",
-                    [BPF_PROG_TYPE_KPROBE]                  = "kprobe",
+            const bool prog_type_name[] = {
+                    [BPF_PROG_TYPE_UNSPEC]                  = true,
+                    [BPF_PROG_TYPE_SOCKET_FILTER]           = true,
+                    [BPF_PROG_TYPE_KPROBE]                  = true,
             };
 
-        Return a dictionary with the enum member names as keys and the
-        associated names as values, for example:
+        Return a set of the enum members, for example:
 
-            {'BPF_PROG_TYPE_UNSPEC': 'unspec',
-             'BPF_PROG_TYPE_SOCKET_FILTER': 'socket_filter',
-             'BPF_PROG_TYPE_KPROBE': 'kprobe'}
+            {'BPF_PROG_TYPE_UNSPEC',
+             'BPF_PROG_TYPE_SOCKET_FILTER',
+             'BPF_PROG_TYPE_KPROBE'}
 
         @array_name: name of the array to parse
         """
@@ -355,7 +353,8 @@ class ProgFileExtractor(SourceFileExtractor):
     filename = os.path.join(BPFTOOL_DIR, 'prog.c')
 
     def get_attach_types(self):
-        return self.get_types_from_array('attach_type_strings')
+        types = self.get_types_from_array('attach_types')
+        return self.make_enum_map(types, 'BPF_')
 
     def get_prog_attach_help(self):
         return self.get_help_list('ATTACH_TYPE')
@@ -378,30 +377,6 @@ class CgroupFileExtractor(SourceFileExtractor):
     def get_prog_attach_help(self):
         return self.get_help_list('ATTACH_TYPE')
 
-class CommonFileExtractor(SourceFileExtractor):
-    """
-    An extractor for bpftool's common.c.
-    """
-    filename = os.path.join(BPFTOOL_DIR, 'common.c')
-
-    def __init__(self):
-        super().__init__()
-        self.attach_types = {}
-
-    def get_attach_types(self):
-        if not self.attach_types:
-            self.attach_types = self.get_types_from_array('attach_type_name')
-        return self.attach_types
-
-    def get_cgroup_attach_types(self):
-        if not self.attach_types:
-            self.get_attach_types()
-        cgroup_types = {}
-        for (key, value) in self.attach_types.items():
-            if key.find('BPF_CGROUP') != -1:
-                cgroup_types[key] = value
-        return cgroup_types
-
 class GenericSourceExtractor(SourceFileExtractor):
     """
     An extractor for generic source code files.
@@ -418,6 +393,10 @@ class BpfHeaderExtractor(FileExtractor):
     """
     filename = os.path.join(INCLUDE_DIR, 'uapi/linux/bpf.h')
 
+    def __init__(self):
+        super().__init__()
+        self.attach_types = {}
+
     def get_prog_types(self):
         return self.get_enum('bpf_prog_type')
 
@@ -425,8 +404,17 @@ class BpfHeaderExtractor(FileExtractor):
         names = self.get_enum('bpf_map_type')
         return self.make_enum_map(names, 'BPF_MAP_TYPE_')
 
-    def get_attach_types(self):
-        return self.get_enum('bpf_attach_type')
+    def get_attach_type_map(self):
+        if not self.attach_types:
+          names = self.get_enum('bpf_attach_type')
+          self.attach_types = self.make_enum_map(names, 'BPF_')
+        return self.attach_types
+
+    def get_cgroup_attach_type_map(self):
+        if not self.attach_types:
+            self.get_attach_type_map()
+        return {name: text for name, text in self.attach_types.items()
+            if name.startswith('BPF_CGROUP')}
 
 class ManPageExtractor(FileExtractor):
     """
@@ -540,17 +528,6 @@ def main():
     verify(source_map_types, bashcomp_map_types,
             f'Comparing {BpfHeaderExtractor.filename} (bpf_map_type) and {BashcompExtractor.filename} (BPFTOOL_MAP_CREATE_TYPES):')
 
-    # Attach types (enum)
-
-    ref = bpf_info.get_attach_types()
-    bpf_info.close()
-
-    common_info = CommonFileExtractor()
-    attach_types = common_info.get_attach_types()
-
-    verify(ref, attach_types,
-            f'Comparing BPF header (enum bpf_attach_type) and {CommonFileExtractor.filename} (attach_type_name):')
-
     # Attach types (names)
 
     prog_info = ProgFileExtractor()
@@ -569,18 +546,17 @@ def main():
     bashcomp_prog_attach_types = bashcomp_info.get_prog_attach_types()
 
     verify(source_prog_attach_types, help_prog_attach_types,
-            f'Comparing {ProgFileExtractor.filename} (attach_type_strings) and {ProgFileExtractor.filename} (do_help() ATTACH_TYPE):')
+            f'Comparing {ProgFileExtractor.filename} (bpf_attach_type) and {ProgFileExtractor.filename} (do_help() ATTACH_TYPE):')
     verify(source_prog_attach_types, man_prog_attach_types,
-            f'Comparing {ProgFileExtractor.filename} (attach_type_strings) and {ManProgExtractor.filename} (ATTACH_TYPE):')
+            f'Comparing {ProgFileExtractor.filename} (bpf_attach_type) and {ManProgExtractor.filename} (ATTACH_TYPE):')
     verify(help_prog_options, man_prog_options,
             f'Comparing {ProgFileExtractor.filename} (do_help() OPTIONS) and {ManProgExtractor.filename} (OPTIONS):')
     verify(source_prog_attach_types, bashcomp_prog_attach_types,
-            f'Comparing {ProgFileExtractor.filename} (attach_type_strings) and {BashcompExtractor.filename} (BPFTOOL_PROG_ATTACH_TYPES):')
+            f'Comparing {ProgFileExtractor.filename} (bpf_attach_type) and {BashcompExtractor.filename} (BPFTOOL_PROG_ATTACH_TYPES):')
 
     # Cgroup attach types
-
-    source_cgroup_attach_types = set(common_info.get_cgroup_attach_types().values())
-    common_info.close()
+    source_cgroup_attach_types = set(bpf_info.get_cgroup_attach_type_map().values())
+    bpf_info.close()
 
     cgroup_info = CgroupFileExtractor()
     help_cgroup_attach_types = cgroup_info.get_prog_attach_help()
@@ -596,13 +572,13 @@ def main():
     bashcomp_info.close()
 
     verify(source_cgroup_attach_types, help_cgroup_attach_types,
-            f'Comparing {CommonFileExtractor.filename} (attach_type_strings) and {CgroupFileExtractor.filename} (do_help() ATTACH_TYPE):')
+            f'Comparing {BpfHeaderExtractor.filename} (bpf_attach_type) and {CgroupFileExtractor.filename} (do_help() ATTACH_TYPE):')
     verify(source_cgroup_attach_types, man_cgroup_attach_types,
-            f'Comparing {CommonFileExtractor.filename} (attach_type_strings) and {ManCgroupExtractor.filename} (ATTACH_TYPE):')
+            f'Comparing {BpfHeaderExtractor.filename} (bpf_attach_type) and {ManCgroupExtractor.filename} (ATTACH_TYPE):')
     verify(help_cgroup_options, man_cgroup_options,
             f'Comparing {CgroupFileExtractor.filename} (do_help() OPTIONS) and {ManCgroupExtractor.filename} (OPTIONS):')
     verify(source_cgroup_attach_types, bashcomp_cgroup_attach_types,
-            f'Comparing {CommonFileExtractor.filename} (attach_type_strings) and {BashcompExtractor.filename} (BPFTOOL_CGROUP_ATTACH_TYPES):')
+            f'Comparing {BpfHeaderExtractor.filename} (bpf_attach_type) and {BashcompExtractor.filename} (BPFTOOL_CGROUP_ATTACH_TYPES):')
 
     # Options for remaining commands
 
-- 
2.30.2

