Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F06352DF57
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 23:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiESVaM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 17:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbiESVaJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 17:30:09 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFCDA76C3
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 14:30:07 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 9FD71240027
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 23:30:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652995806; bh=zhp/Av1QmialMiCVM6cQOVLUoyoWJhEL9vUY0WSbfvQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FT//IDXaisDtbBthlZ5fBNFF7bHcCrUNwYLfGEUQnjZEFB80pqP061PBmXYs4g8Fx
         rkYHtvyGW5SNOVbUTtClvGMlVPTF6qFN0tKCyH7hDDeXUtRkP5aXtLJKP8bxNiVdQ5
         XurBvpQlE4nNOV4AXHMSdkMNOh/7VzglP1DAVbVbuUas1x9It58gtho2zEqTcuJvkt
         T03dv3uLrCtG2gY3Z93nNG9O/ikCngCj7mXWf8FMZP84AZgWL9ze599wkuwGoD1CPZ
         dWzYxOyn5lW8jce4ujtV65k/VLkCO9IN2NSw2rrUOezraOq4ZcKaRVB2DXas23jaBi
         BYns38ZvhMH1g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L430s6WCbz6tp6;
        Thu, 19 May 2022 23:30:05 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v3 01/12] libbpf: Introduce libbpf_bpf_prog_type_str
Date:   Thu, 19 May 2022 21:29:50 +0000
Message-Id: <20220519213001.729261-2-deso@posteo.net>
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

This change introduces a new function, libbpf_bpf_prog_type_str, to the
public libbpf API. The function allows users to get a string
representation for a bpf_prog_type variant.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/libbpf.c   | 43 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  9 +++++++++
 tools/lib/bpf/libbpf.map |  3 +++
 3 files changed, 55 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ef7f30..6b9c0f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -72,6 +72,41 @@
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
 
+static const char * const prog_type_name[] = {
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
+	[BPF_PROG_TYPE_LSM]			= "lsm",
+	[BPF_PROG_TYPE_SK_LOOKUP]		= "sk_lookup",
+	[BPF_PROG_TYPE_SYSCALL]			= "syscall",
+};
+
 static int __base_pr(enum libbpf_print_level level, const char *format,
 		     va_list args)
 {
@@ -9300,6 +9335,14 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 	return libbpf_err(-ESRCH);
 }
 
+const char *libbpf_bpf_prog_type_str(enum bpf_prog_type t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(prog_type_name))
+		return NULL;
+
+	return prog_type_name[t];
+}
+
 static struct bpf_map *find_struct_ops_map_by_offset(struct bpf_object *obj,
 						     size_t offset)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9e9a3f..11b5f8c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -51,6 +51,15 @@ enum libbpf_errno {
 
 LIBBPF_API int libbpf_strerror(int err, char *buf, size_t size);
 
+/**
+ * @brief **libbpf_bpf_prog_type_str()** converts the provided program type
+ * value into a textual representation.
+ * @param t The program type.
+ * @return Pointer to a static string identifying the program type. NULL is
+ * returned for unknown **bpf_prog_type** values.
+ */
+LIBBPF_API const char *libbpf_bpf_prog_type_str(enum bpf_prog_type t);
+
 enum libbpf_print_level {
         LIBBPF_WARN,
         LIBBPF_INFO,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 52973c..b12d290 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -461,5 +461,8 @@ LIBBPF_0.8.0 {
 } LIBBPF_0.7.0;
 
 LIBBPF_1.0.0 {
+	global:
+		libbpf_bpf_prog_type_str;
+
 	local: *;
 };
-- 
2.30.2

