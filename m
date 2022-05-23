Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EED531F16
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 01:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiEWXFA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 19:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiEWXE7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 19:04:59 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D6AAF1E7
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 16:04:58 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 94345240107
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 01:04:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1653347097; bh=sEvAvuGroNenp0h5cZGzweIugy+4i5CSOvFNirmBm7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=gz8zfe7oql+CbE+p8V1kkMf+8DN2B3DBGxBiSPsSptpDNlGjpSW0PzNakCBoXEdqw
         wbTPlBa07zq/CSFylKT6DslZBViydy+1Nb/vK7URB7gkncS+an1sOOUXuJ6sqou66l
         PCxOEgcwWrTvKCE4Y4ue7/j/SKCkk/2XUufaisoZsPi/wvjaUWSzzc/ISGIbmJrC0n
         VVlab04MnlvQvrSbI4yo1+vk4VIxqyV3tXH9dY6M5thUAD5q93e2FZu0cMJhsLQFYm
         xh5NeqmRbWT73wzErgTFwR3IpTFEkwL2Qy4DMrNG+HsKxMi95PZLUWsC4yZUfvr8g9
         PlDd1+oxV7wpQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L6XwS6Bynz6tpY;
        Tue, 24 May 2022 01:04:56 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v4 12/12] bpftool: Use libbpf_bpf_link_type_str
Date:   Mon, 23 May 2022 23:04:28 +0000
Message-Id: <20220523230428.3077108-13-deso@posteo.net>
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
libbpf_bpf_link_type_str function instead of maintaining its own string
representation for the bpf_link_type enum.

Signed-off-by: Daniel Müller <deso@posteo.net>
Acked-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/link.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 66a254..7a2093 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -13,19 +13,6 @@
 #include "json_writer.h"
 #include "main.h"
 
-static const char * const link_type_name[] = {
-	[BPF_LINK_TYPE_UNSPEC]			= "unspec",
-	[BPF_LINK_TYPE_RAW_TRACEPOINT]		= "raw_tracepoint",
-	[BPF_LINK_TYPE_TRACING]			= "tracing",
-	[BPF_LINK_TYPE_CGROUP]			= "cgroup",
-	[BPF_LINK_TYPE_ITER]			= "iter",
-	[BPF_LINK_TYPE_NETNS]			= "netns",
-	[BPF_LINK_TYPE_XDP]			= "xdp",
-	[BPF_LINK_TYPE_PERF_EVENT]		= "perf_event",
-	[BPF_LINK_TYPE_KPROBE_MULTI]		= "kprobe_multi",
-	[BPF_LINK_TYPE_STRUCT_OPS]               = "struct_ops",
-};
-
 static struct hashmap *link_table;
 
 static int link_parse_fd(int *argc, char ***argv)
@@ -67,9 +54,12 @@ static int link_parse_fd(int *argc, char ***argv)
 static void
 show_link_header_json(struct bpf_link_info *info, json_writer_t *wtr)
 {
+	const char *link_type_str;
+
 	jsonw_uint_field(wtr, "id", info->id);
-	if (info->type < ARRAY_SIZE(link_type_name))
-		jsonw_string_field(wtr, "type", link_type_name[info->type]);
+	link_type_str = libbpf_bpf_link_type_str(info->type);
+	if (link_type_str)
+		jsonw_string_field(wtr, "type", link_type_str);
 	else
 		jsonw_uint_field(wtr, "type", info->type);
 
@@ -187,9 +177,12 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 
 static void show_link_header_plain(struct bpf_link_info *info)
 {
+	const char *link_type_str;
+
 	printf("%u: ", info->id);
-	if (info->type < ARRAY_SIZE(link_type_name))
-		printf("%s  ", link_type_name[info->type]);
+	link_type_str = libbpf_bpf_link_type_str(info->type);
+	if (link_type_str)
+		printf("%s  ", link_type_str);
 	else
 		printf("type %u  ", info->type);
 
-- 
2.30.2

