Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0A652DF4C
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 23:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiESVaX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 17:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbiESVaW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 17:30:22 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A836E8CD
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 14:30:21 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E4DE1240026
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 23:30:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652995819; bh=u9Jd+TbDO+WD+UVzQwWIk+r5wq4Y9nsIqef3KzU10UE=;
        h=From:To:Cc:Subject:Date:From;
        b=mbact/0zVeBMTb1+auaYNGAz37mZLt/qpGzRpHbKOm3Z9vBbf5zDfyHxPQXflOahM
         kfqbeoBnkuYMsdWMNEc2Q/bGwINFrcpg+3/wQpfLchtbluukVObys8udJXmHTNrGH2
         J5o9lqIAFbfBRoot9o7iLyjRMA0qFilxBGZkvYPyncXXUSH3H6++IYqzBWq32qcuEE
         +LzOZj1mpHF2zSpKCXVgTIJV3lSZnyoR/53b9lyfzbKqX0HuldanS62y6IG6Y8Wfmn
         3yUjPdKLkrd445k8zj7tZuQXwsCLz+tGTeBuv/HyTurXYvUXwrm8JpgbXHbkA5pSzM
         68x2nEYiFfkLg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L431718C2z6tpy;
        Thu, 19 May 2022 23:30:19 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v3 07/12] libbpf: Introduce libbpf_bpf_attach_type_str
Date:   Thu, 19 May 2022 21:29:56 +0000
Message-Id: <20220519213001.729261-8-deso@posteo.net>
In-Reply-To: <20220519213001.729261-1-deso@posteo.net>
References: <20220519213001.729261-1-deso@posteo.net>
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

This change introduces a new function, libbpf_bpf_attach_type_str, to
the public libbpf API. The function allows users to get a string
representation for a bpf_attach_type variant.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/libbpf.c   | 54 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  9 +++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 64 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1cbe90..bc56e9c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -72,6 +72,52 @@
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
 
+static const char * const attach_type_name[] = {
+	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
+	[BPF_CGROUP_INET_EGRESS]	= "cgroup_inet_egress",
+	[BPF_CGROUP_INET_SOCK_CREATE]	= "cgroup_inet_sock_create",
+	[BPF_CGROUP_INET_SOCK_RELEASE]	= "cgroup_inet_sock_release",
+	[BPF_CGROUP_SOCK_OPS]		= "cgroup_sock_ops",
+	[BPF_CGROUP_DEVICE]		= "cgroup_device",
+	[BPF_CGROUP_INET4_BIND]		= "cgroup_inet4_bind",
+	[BPF_CGROUP_INET6_BIND]		= "cgroup_inet6_bind",
+	[BPF_CGROUP_INET4_CONNECT]	= "cgroup_inet4_connect",
+	[BPF_CGROUP_INET6_CONNECT]	= "cgroup_inet6_connect",
+	[BPF_CGROUP_INET4_POST_BIND]	= "cgroup_inet4_post_bind",
+	[BPF_CGROUP_INET6_POST_BIND]	= "cgroup_inet6_post_bind",
+	[BPF_CGROUP_INET4_GETPEERNAME]	= "cgroup_inet4_getpeername",
+	[BPF_CGROUP_INET6_GETPEERNAME]	= "cgroup_inet6_getpeername",
+	[BPF_CGROUP_INET4_GETSOCKNAME]	= "cgroup_inet4_getsockname",
+	[BPF_CGROUP_INET6_GETSOCKNAME]	= "cgroup_inet6_getsockname",
+	[BPF_CGROUP_UDP4_SENDMSG]	= "cgroup_udp4_sendmsg",
+	[BPF_CGROUP_UDP6_SENDMSG]	= "cgroup_udp6_sendmsg",
+	[BPF_CGROUP_SYSCTL]		= "cgroup_sysctl",
+	[BPF_CGROUP_UDP4_RECVMSG]	= "cgroup_udp4_recvmsg",
+	[BPF_CGROUP_UDP6_RECVMSG]	= "cgroup_udp6_recvmsg",
+	[BPF_CGROUP_GETSOCKOPT]		= "cgroup_getsockopt",
+	[BPF_CGROUP_SETSOCKOPT]		= "cgroup_setsockopt",
+	[BPF_SK_SKB_STREAM_PARSER]	= "sk_skb_stream_parser",
+	[BPF_SK_SKB_STREAM_VERDICT]	= "sk_skb_stream_verdict",
+	[BPF_SK_SKB_VERDICT]		= "sk_skb_verdict",
+	[BPF_SK_MSG_VERDICT]		= "sk_msg_verdict",
+	[BPF_LIRC_MODE2]		= "lirc_mode2",
+	[BPF_FLOW_DISSECTOR]		= "flow_dissector",
+	[BPF_TRACE_RAW_TP]		= "trace_raw_tp",
+	[BPF_TRACE_FENTRY]		= "trace_fentry",
+	[BPF_TRACE_FEXIT]		= "trace_fexit",
+	[BPF_MODIFY_RETURN]		= "modify_return",
+	[BPF_LSM_MAC]			= "lsm_mac",
+	[BPF_SK_LOOKUP]			= "sk_lookup",
+	[BPF_TRACE_ITER]		= "trace_iter",
+	[BPF_XDP_DEVMAP]		= "xdp_devmap",
+	[BPF_XDP_CPUMAP]		= "xdp_cpumap",
+	[BPF_XDP]			= "xdp",
+	[BPF_SK_REUSEPORT_SELECT]	= "sk_reuseport_select",
+	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	= "sk_reuseport_select_or_migrate",
+	[BPF_PERF_EVENT]		= "perf_event",
+	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
+};
+
 static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_UNSPEC]			= "unspec",
 	[BPF_MAP_TYPE_HASH]			= "hash",
@@ -9369,6 +9415,14 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 	return libbpf_err(-ESRCH);
 }
 
+const char *libbpf_bpf_attach_type_str(enum bpf_attach_type t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(attach_type_name))
+		return NULL;
+
+	return attach_type_name[t];
+}
+
 const char *libbpf_bpf_map_type_str(enum bpf_map_type t)
 {
 	if (t < 0 || t >= ARRAY_SIZE(map_type_name))
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6c5b07..37a234 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -51,6 +51,15 @@ enum libbpf_errno {
 
 LIBBPF_API int libbpf_strerror(int err, char *buf, size_t size);
 
+/**
+ * @brief **libbpf_bpf_attach_type_str()** converts the provided attach type
+ * value into a textual representation.
+ * @param t The attach type.
+ * @return Pointer to a static string identifying the attach type. NULL is
+ * returned for unknown **bpf_attach_type** values.
+ */
+LIBBPF_API const char *libbpf_bpf_attach_type_str(enum bpf_attach_type t);
+
 /**
  * @brief **libbpf_bpf_map_type_str()** converts the provided map type value
  * into a textual representation.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 16065ac..44c536 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -462,6 +462,7 @@ LIBBPF_0.8.0 {
 
 LIBBPF_1.0.0 {
 	global:
+		libbpf_bpf_attach_type_str;
 		libbpf_bpf_map_type_str;
 		libbpf_bpf_prog_type_str;
 
-- 
2.30.2

