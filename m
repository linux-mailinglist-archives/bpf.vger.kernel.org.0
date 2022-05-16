Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE6528C13
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbiEPRg0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 13:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344359AbiEPRgQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 13:36:16 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDFA240AF
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 10:36:09 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6FA8924010C
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 19:36:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652722568; bh=beWd3+1ktjcNiK74XyhTIcuOy51CsvxBWvw9zd54nRQ=;
        h=From:To:Subject:Date:From;
        b=ZGLLssZq1tX7TNgTo7LKyeBMwAAEJCV6yPHBFRflFNcmcWdKCuqkJ1h2UBS9zQe+v
         0QjcnwcnYbPD4n0hBBSJmhex24juNXFSjAMvcivxPSYterUSKUrdN9LYbHCFHBunkj
         r7aNyCK/kpUwT0rUK9l2xzAuN75eO03vlo6W/SZteJiuswPpzahx+L/X3yFkaGVP4i
         TOk4F7cyuCWBIBuNmLVnuzB3qdtGsoZDwrGYXqmLlznFbnfLcXdbsWSGiuIYyQKL+P
         jLr91Zp7X5vH70nTbnq4mekcZ2JgF7m6R4qPgTlilv9WsuIiR/VVywl7plgVYEYUs0
         kO13wdgL0WSAA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L25yH2p0qz6tmj;
        Mon, 16 May 2022 19:36:07 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next 10/12] libbpf: Introduce libbpf_bpf_link_type_str
Date:   Mon, 16 May 2022 17:35:38 +0000
Message-Id: <20220516173540.3520665-11-deso@posteo.net>
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

This change introduces a new function, libbpf_bpf_link_type_str, to the
public libbpf API. The function allows users to get a string
representation for a bpf_link_type enum variant.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/libbpf.c   | 21 +++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  9 +++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 31 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a69a752..5596679 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -118,6 +118,19 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
 };
 
+static const char * const link_type_name[] = {
+	[BPF_LINK_TYPE_UNSPEC]			= "unspec",
+	[BPF_LINK_TYPE_RAW_TRACEPOINT]		= "raw_tracepoint",
+	[BPF_LINK_TYPE_TRACING]			= "tracing",
+	[BPF_LINK_TYPE_CGROUP]			= "cgroup",
+	[BPF_LINK_TYPE_ITER]			= "iter",
+	[BPF_LINK_TYPE_NETNS]			= "netns",
+	[BPF_LINK_TYPE_XDP]			= "xdp",
+	[BPF_LINK_TYPE_PERF_EVENT]		= "perf_event",
+	[BPF_LINK_TYPE_KPROBE_MULTI]		= "kprobe_multi",
+	[BPF_LINK_TYPE_STRUCT_OPS]		= "struct_ops",
+};
+
 static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_UNSPEC]			= "unspec",
 	[BPF_MAP_TYPE_HASH]			= "hash",
@@ -9423,6 +9436,14 @@ const char *libbpf_bpf_attach_type_str(enum bpf_attach_type t)
 	return attach_type_name[t];
 }
 
+const char *libbpf_bpf_link_type_str(enum bpf_link_type t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(link_type_name))
+		return NULL;
+
+	return link_type_name[t];
+}
+
 const char *libbpf_bpf_map_type_str(enum bpf_map_type t)
 {
 	if (t < 0 || t >= ARRAY_SIZE(map_type_name))
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 37a234..5b34ca 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -60,6 +60,15 @@ LIBBPF_API int libbpf_strerror(int err, char *buf, size_t size);
  */
 LIBBPF_API const char *libbpf_bpf_attach_type_str(enum bpf_attach_type t);
 
+/**
+ * @brief **libbpf_bpf_link_type_str()** converts the provided link type value
+ * into a textual representation.
+ * @param t The link type.
+ * @return Pointer to a static string identifying the link type. NULL is
+ * returned for unknown **bpf_link_type** values.
+ */
+LIBBPF_API const char *libbpf_bpf_link_type_str(enum bpf_link_type t);
+
 /**
  * @brief **libbpf_bpf_map_type_str()** converts the provided map type value
  * into a textual representation.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d045d6..c7cf4b6 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -457,6 +457,7 @@ LIBBPF_0.8.0 {
 		bpf_program__attach_usdt;
 		bpf_program__set_insns;
 		libbpf_bpf_attach_type_str;
+		libbpf_bpf_link_type_str;
 		libbpf_bpf_map_type_str;
 		libbpf_bpf_prog_type_str;
 		libbpf_register_prog_handler;
-- 
2.30.2

