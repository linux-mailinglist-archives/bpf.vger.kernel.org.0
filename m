Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F4C52C884
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 02:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiESAS2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 20:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiESAS1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 20:18:27 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9860163F79
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 17:18:25 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5B6D3240027
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 02:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652919504; bh=j20Gk1DC+JWIZo+Ph64+yPqH+z6bgueMByJv+lEjems=;
        h=From:To:Cc:Subject:Date:From;
        b=AT4UT7XnI0QTaH0ASO27mMm4Hr1ACDKhx19oz1NsPh+ijggfk/yMmt3jy0mIaPH/q
         OKb115L2XI922FUvt2PrWSoHZhGUJuQnX/fqMenOcgzsXQfLTikj3wsE+MWQyVLmUN
         JdN2r4DiAgsc9Xt2eEQ4TqcfZMVmnEZwqqZM6nk7n/IY4Km1DFPjeQFblNaMtUVpIJ
         FUHWMDqiWQpTpNeV+EJMW37pSWbpxKboztUoAhgwuQC2XAiKy23V+/BNxRXCB1m+pm
         Z0qSv23QykuVzKxckUmqAa1+54Vn/6Wwd8/YsCzpc+X7pKMaSVbM+ySCfTiyOpL7Tm
         /I/jdkXU63lGg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L3VnW2GQmz6tpj;
        Thu, 19 May 2022 02:18:23 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v2 03/12] bpftool: Use libbpf_bpf_prog_type_str
Date:   Thu, 19 May 2022 00:18:06 +0000
Message-Id: <20220519001815.1944959-4-deso@posteo.net>
In-Reply-To: <20220519001815.1944959-1-deso@posteo.net>
References: <20220519001815.1944959-1-deso@posteo.net>
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
libbpf_bpf_prog_type_str function instead of maintaining its own string
representation for the bpf_prog_type enum.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/bpf/bpftool/feature.c | 57 +++++++++++++++++++++++--------------
 tools/bpf/bpftool/link.c    | 19 +++++++------
 tools/bpf/bpftool/main.h    |  3 --
 tools/bpf/bpftool/map.c     | 13 +++++----
 tools/bpf/bpftool/prog.c    | 51 ++++++---------------------------
 5 files changed, 64 insertions(+), 79 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index d12f460..02753f 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -548,8 +548,8 @@ static bool probe_prog_type_ifindex(enum bpf_prog_type prog_type, __u32 ifindex)
 }
 
 static void
-probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
-		const char *define_prefix, __u32 ifindex)
+probe_prog_type(enum bpf_prog_type prog_type, const char *prog_type_str,
+		bool *supported_types, const char *define_prefix, __u32 ifindex)
 {
 	char feat_name[128], plain_desc[128], define_name[128];
 	const char *plain_comment = "eBPF program_type ";
@@ -580,20 +580,16 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
 
 	supported_types[prog_type] |= res;
 
-	if (!prog_type_name[prog_type]) {
-		p_info("program type name not found (type %d)", prog_type);
-		return;
-	}
 	maxlen = sizeof(plain_desc) - strlen(plain_comment) - 1;
-	if (strlen(prog_type_name[prog_type]) > maxlen) {
+	if (strlen(prog_type_str) > maxlen) {
 		p_info("program type name too long");
 		return;
 	}
 
-	sprintf(feat_name, "have_%s_prog_type", prog_type_name[prog_type]);
-	sprintf(define_name, "%s_prog_type", prog_type_name[prog_type]);
+	sprintf(feat_name, "have_%s_prog_type", prog_type_str);
+	sprintf(define_name, "%s_prog_type", prog_type_str);
 	uppercase(define_name, sizeof(define_name));
-	sprintf(plain_desc, "%s%s", plain_comment, prog_type_name[prog_type]);
+	sprintf(plain_desc, "%s%s", plain_comment, prog_type_str);
 	print_bool_feature(feat_name, plain_desc, define_name, res,
 			   define_prefix);
 }
@@ -728,10 +724,10 @@ probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 }
 
 static void
-probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
+probe_helpers_for_progtype(enum bpf_prog_type prog_type,
+			   const char *prog_type_str, bool supported_type,
 			   const char *define_prefix, __u32 ifindex)
 {
-	const char *ptype_name = prog_type_name[prog_type];
 	char feat_name[128];
 	unsigned int id;
 	bool probe_res = false;
@@ -747,12 +743,12 @@ probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 		}
 
 	if (json_output) {
-		sprintf(feat_name, "%s_available_helpers", ptype_name);
+		sprintf(feat_name, "%s_available_helpers", prog_type_str);
 		jsonw_name(json_wtr, feat_name);
 		jsonw_start_array(json_wtr);
 	} else if (!define_prefix) {
 		printf("eBPF helpers supported for program type %s:",
-		       ptype_name);
+		       prog_type_str);
 	}
 
 	for (id = 1; id < ARRAY_SIZE(helper_name); id++) {
@@ -768,7 +764,7 @@ probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 			/* fallthrough */
 		default:
 			probe_res |= probe_helper_for_progtype(prog_type, supported_type,
-						  define_prefix, id, ptype_name,
+						  define_prefix, id, prog_type_str,
 						  ifindex);
 		}
 	}
@@ -943,15 +939,24 @@ static void
 section_program_types(bool *supported_types, const char *define_prefix,
 		      __u32 ifindex)
 {
-	unsigned int i;
+	unsigned int prog_type = BPF_PROG_TYPE_UNSPEC;
+	const char *prog_type_str;
 
 	print_start_section("program_types",
 			    "Scanning eBPF program types...",
 			    "/*** eBPF program types ***/",
 			    define_prefix);
 
-	for (i = BPF_PROG_TYPE_UNSPEC + 1; i < prog_type_name_size; i++)
-		probe_prog_type(i, supported_types, define_prefix, ifindex);
+	while (true) {
+		prog_type++;
+		prog_type_str = libbpf_bpf_prog_type_str(prog_type);
+		/* libbpf will return NULL for variants unknown to it. */
+		if (!prog_type_str)
+			break;
+
+		probe_prog_type(prog_type, prog_type_str, supported_types, define_prefix,
+				ifindex);
+	}
 
 	print_end_section();
 }
@@ -974,7 +979,8 @@ static void section_map_types(const char *define_prefix, __u32 ifindex)
 static void
 section_helpers(bool *supported_types, const char *define_prefix, __u32 ifindex)
 {
-	unsigned int i;
+	unsigned int prog_type = BPF_PROG_TYPE_UNSPEC;
+	const char *prog_type_str;
 
 	print_start_section("helpers",
 			    "Scanning eBPF helper functions...",
@@ -996,9 +1002,18 @@ section_helpers(bool *supported_types, const char *define_prefix, __u32 ifindex)
 		       "	%sBPF__PROG_TYPE_ ## prog_type ## __HELPER_ ## helper\n",
 		       define_prefix, define_prefix, define_prefix,
 		       define_prefix);
-	for (i = BPF_PROG_TYPE_UNSPEC + 1; i < prog_type_name_size; i++)
-		probe_helpers_for_progtype(i, supported_types[i], define_prefix,
+	while (true) {
+		prog_type++;
+		prog_type_str = libbpf_bpf_prog_type_str(prog_type);
+		/* libbpf will return NULL for variants unknown to it. */
+		if (!prog_type_str)
+			break;
+
+		probe_helpers_for_progtype(prog_type, prog_type_str,
+					   supported_types[prog_type],
+					   define_prefix,
 					   ifindex);
+	}
 
 	print_end_section();
 }
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 6353a78..e27108 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -121,6 +121,7 @@ static int get_prog_info(int prog_id, struct bpf_prog_info *info)
 static int show_link_close_json(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
+	const char *prog_type_str;
 	int err;
 
 	jsonw_start_object(json_wtr);
@@ -137,12 +138,12 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 		if (err)
 			return err;
 
-		if (prog_info.type < prog_type_name_size)
-			jsonw_string_field(json_wtr, "prog_type",
-					   prog_type_name[prog_info.type]);
+		prog_type_str = libbpf_bpf_prog_type_str(prog_info.type);
+		/* libbpf will return NULL for variants unknown to it. */
+		if (prog_type_str)
+			jsonw_string_field(json_wtr, "prog_type", prog_type_str);
 		else
-			jsonw_uint_field(json_wtr, "prog_type",
-					 prog_info.type);
+			jsonw_uint_field(json_wtr, "prog_type", prog_info.type);
 
 		show_link_attach_type_json(info->tracing.attach_type,
 					   json_wtr);
@@ -214,6 +215,7 @@ static void show_iter_plain(struct bpf_link_info *info)
 static int show_link_close_plain(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
+	const char *prog_type_str;
 	int err;
 
 	show_link_header_plain(info);
@@ -228,9 +230,10 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		if (err)
 			return err;
 
-		if (prog_info.type < prog_type_name_size)
-			printf("\n\tprog_type %s  ",
-			       prog_type_name[prog_info.type]);
+		prog_type_str = libbpf_bpf_prog_type_str(prog_info.type);
+		/* libbpf will return NULL for variants unknown to it. */
+		if (prog_type_str)
+			printf("\n\tprog_type %s  ", prog_type_str);
 		else
 			printf("\n\tprog_type %u  ", prog_info.type);
 
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index aa99ff..74204d 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -63,9 +63,6 @@ static inline void *u64_to_ptr(__u64 ptr)
 #define HELP_SPEC_LINK							\
 	"LINK := { id LINK_ID | pinned FILE }"
 
-extern const char * const prog_type_name[];
-extern const size_t prog_type_name_size;
-
 extern const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE];
 
 extern const char * const map_type_name[];
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 877387..70a1fd5 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -513,10 +513,12 @@ static int show_map_close_json(int fd, struct bpf_map_info *info)
 
 		if (owner_prog_type) {
 			unsigned int prog_type = atoi(owner_prog_type);
+			const char *prog_type_str;
 
-			if (prog_type < prog_type_name_size)
+			prog_type_str = libbpf_bpf_prog_type_str(prog_type);
+			if (prog_type_str)
 				jsonw_string_field(json_wtr, "owner_prog_type",
-						   prog_type_name[prog_type]);
+						   prog_type_str);
 			else
 				jsonw_uint_field(json_wtr, "owner_prog_type",
 						 prog_type);
@@ -597,10 +599,11 @@ static int show_map_close_plain(int fd, struct bpf_map_info *info)
 			printf("\n\t");
 		if (owner_prog_type) {
 			unsigned int prog_type = atoi(owner_prog_type);
+			const char *prog_type_str;
 
-			if (prog_type < prog_type_name_size)
-				printf("owner_prog_type %s  ",
-				       prog_type_name[prog_type]);
+			prog_type_str = libbpf_bpf_prog_type_str(prog_type);
+			if (prog_type_str)
+				printf("owner_prog_type %s  ", prog_type_str);
 			else
 				printf("owner_prog_type %d  ", prog_type);
 		}
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 5c2c63..39e1e71 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -36,43 +36,6 @@
 #define BPF_METADATA_PREFIX "bpf_metadata_"
 #define BPF_METADATA_PREFIX_LEN (sizeof(BPF_METADATA_PREFIX) - 1)
 
-const char * const prog_type_name[] = {
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
-	[BPF_PROG_TYPE_LSM]			= "lsm",
-	[BPF_PROG_TYPE_SK_LOOKUP]		= "sk_lookup",
-	[BPF_PROG_TYPE_SYSCALL]			= "syscall",
-};
-
-const size_t prog_type_name_size = ARRAY_SIZE(prog_type_name);
-
 enum dump_mode {
 	DUMP_JITED,
 	DUMP_XLATED,
@@ -428,12 +391,14 @@ static void show_prog_metadata(int fd, __u32 num_maps)
 
 static void print_prog_header_json(struct bpf_prog_info *info, int fd)
 {
+	const char *prog_type_str;
 	char prog_name[MAX_PROG_FULL_NAME];
 
 	jsonw_uint_field(json_wtr, "id", info->id);
-	if (info->type < ARRAY_SIZE(prog_type_name))
-		jsonw_string_field(json_wtr, "type",
-				   prog_type_name[info->type]);
+	prog_type_str = libbpf_bpf_prog_type_str(info->type);
+
+	if (prog_type_str)
+		jsonw_string_field(json_wtr, "type", prog_type_str);
 	else
 		jsonw_uint_field(json_wtr, "type", info->type);
 
@@ -515,11 +480,13 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
 
 static void print_prog_header_plain(struct bpf_prog_info *info, int fd)
 {
+	const char *prog_type_str;
 	char prog_name[MAX_PROG_FULL_NAME];
 
 	printf("%u: ", info->id);
-	if (info->type < ARRAY_SIZE(prog_type_name))
-		printf("%s  ", prog_type_name[info->type]);
+	prog_type_str = libbpf_bpf_prog_type_str(info->type);
+	if (prog_type_str)
+		printf("%s  ", prog_type_str);
 	else
 		printf("type %u  ", info->type);
 
-- 
2.30.2

