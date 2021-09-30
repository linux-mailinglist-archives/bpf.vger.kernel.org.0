Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBE341DEA1
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349188AbhI3QRR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349053AbhI3QRR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 12:17:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7103C06176A
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 09:15:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t11so4382730plq.11
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GPxZYEwEPLyaL4sGBIOEKgDR0HgZcBX+bzEFvD7h6tw=;
        b=LG2zPM1NHybY9awMGWEuc11if/i1DKB3mpBs0AZmLA6soQGs2X4NXWvhqVJ+aWIJc3
         bZk7LrLeUp2CcrRxbAjVcJDGVgMUfLYFlVcYFknb0J3UkJ13f2FQ3QEylxGrfOsfRd9b
         FWUPLFjMTHfY4WN38cWpzJ7KW5h4SpeftX1S5QHV2bhINDEuRCJvQjiNxdlnebmOZVDM
         kJ39AtF7Vbusph5jSq8lLv+PfVmJHJm6gWtsUzSZD+ljlcFoNc06tlnU9QgaxEqVoX4n
         ROwxsXSn2P6QqAiBBUn+99NeNx3l6nYvBJUKKQDPK5gLqqq49dCr5udIQFGX8vwVQfZ/
         +28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GPxZYEwEPLyaL4sGBIOEKgDR0HgZcBX+bzEFvD7h6tw=;
        b=aiprKqG8HS50/uBkhnyvP5gjaJGpZWrMCLwDxBqU/n5GmOZtOXmcNAkirA2/yPB7t5
         zYaG7S/5OfAgsxXE+sTjzCAWGrKLQwY7kkjKIZXulAB7DgUI1TerxCzeFiZfR+acut4o
         9bGKR0wws8QefZLMLWTragCISA5QRLADTis5OT2tElXT2Hg7rrKisHgq4unQRvPkGlqQ
         32qhFsKXsqosTV5ZjYsXmnPDFbzDrWAp1vO/j9GmdftrcJ9PGcLICSz60mMLWNFuSjh3
         CEVpknz2t24wG7yoA9Y5HLbOUSAo2S7Wp7rlchZE2O5ugPGy4Db/kHf/iXhJquGnljz1
         cZHw==
X-Gm-Message-State: AOAM530CLP/NPCN6Qinq5q+oQd1G7/6se62P4JQf4iNcN34dBj/Ct32T
        9CqY/SfzYoeTwfwUSA2/iYT2x/Jt6lIgBg==
X-Google-Smtp-Source: ABdhPJzM35U77SUR0PGqbqs0hteeD6NF9dspDRoLOgcsdsDlentfJ+8W9xYV7DzUXb2PUqNCBzevjQ==
X-Received: by 2002:a17:90a:16:: with SMTP id 22mr14257557pja.25.1633018533948;
        Thu, 30 Sep 2021 09:15:33 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id p17sm5278090pjg.54.2021.09.30.09.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 09:15:33 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Use BTF-defined key/value for map definitions
Date:   Fri,  1 Oct 2021 00:14:56 +0800
Message-Id: <20210930161456.3444544-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930161456.3444544-1-hengqi.chen@gmail.com>
References: <20210930161456.3444544-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change map definitions in BPF selftests to use BTF-defined
key/value types. This unifies the map definitions and ensures
libbpf won't emit warning about retrying map creation.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/bpf/progs/kfree_skb.c      |  4 ++--
 .../selftests/bpf/progs/perf_event_stackmap.c      |  4 ++--
 .../selftests/bpf/progs/sockmap_verdict_prog.c     | 12 ++++++------
 .../selftests/bpf/progs/test_btf_map_in_map.c      | 14 +++++++-------
 .../testing/selftests/bpf/progs/test_map_in_map.c  | 10 ++++------
 .../selftests/bpf/progs/test_map_in_map_invalid.c  |  2 +-
 .../selftests/bpf/progs/test_pe_preserve_elems.c   |  8 ++++----
 .../testing/selftests/bpf/progs/test_perf_buffer.c |  4 ++--
 .../bpf/progs/test_select_reuseport_kern.c         |  4 ++--
 .../selftests/bpf/progs/test_stacktrace_build_id.c |  4 ++--
 .../selftests/bpf/progs/test_stacktrace_map.c      |  4 ++--
 .../selftests/bpf/progs/test_tcpnotify_kern.c      |  4 ++--
 .../testing/selftests/bpf/progs/test_xdp_bpf2bpf.c |  4 ++--
 13 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/kfree_skb.c b/tools/testing/selftests/bpf/progs/kfree_skb.c
index 55e283050cab..7236da72ce80 100644
--- a/tools/testing/selftests/bpf/progs/kfree_skb.c
+++ b/tools/testing/selftests/bpf/progs/kfree_skb.c
@@ -9,8 +9,8 @@
 char _license[] SEC("license") = "GPL";
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
+	__type(key, int);
+	__type(value, int);
 } perf_buf_map SEC(".maps");

 #define _(P) (__builtin_preserve_access_index(P))
diff --git a/tools/testing/selftests/bpf/progs/perf_event_stackmap.c b/tools/testing/selftests/bpf/progs/perf_event_stackmap.c
index 25467d13c356..b3fcb5274ee0 100644
--- a/tools/testing/selftests/bpf/progs/perf_event_stackmap.c
+++ b/tools/testing/selftests/bpf/progs/perf_event_stackmap.c
@@ -11,8 +11,8 @@ typedef __u64 stack_trace_t[PERF_MAX_STACK_DEPTH];
 struct {
 	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
 	__uint(max_entries, 16384);
-	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(stack_trace_t));
+	__type(key, __u32);
+	__type(value, stack_trace_t);
 } stackmap SEC(".maps");

 struct {
diff --git a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
index 4797dc985064..73872c535cbb 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
@@ -7,22 +7,22 @@ int _version SEC("version") = 1;
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
 	__uint(max_entries, 20);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
+	__type(key, int);
+	__type(value, int);
 } sock_map_rx SEC(".maps");

 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
 	__uint(max_entries, 20);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
+	__type(key, int);
+	__type(value, int);
 } sock_map_tx SEC(".maps");

 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
 	__uint(max_entries, 20);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
+	__type(key, int);
+	__type(value, int);
 } sock_map_msg SEC(".maps");

 struct {
diff --git a/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c b/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c
index c1e0c8c7c55f..c218cf8989a9 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c
@@ -21,8 +21,8 @@ struct inner_map_sz2 {
 struct outer_arr {
 	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
 	__uint(max_entries, 3);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
+	__type(key, int);
+	__type(value, int);
 	/* it's possible to use anonymous struct as inner map definition here */
 	__array(values, struct {
 		__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -61,8 +61,8 @@ struct inner_map_sz4 {
 struct outer_arr_dyn {
 	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
 	__uint(max_entries, 3);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
+	__type(key, int);
+	__type(value, int);
 	__array(values, struct {
 		__uint(type, BPF_MAP_TYPE_ARRAY);
 		__uint(map_flags, BPF_F_INNER_MAP);
@@ -81,7 +81,7 @@ struct outer_arr_dyn {
 struct outer_hash {
 	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
 	__uint(max_entries, 5);
-	__uint(key_size, sizeof(int));
+	__type(key, int);
 	/* Here everything works flawlessly due to reuse of struct inner_map
 	 * and compiler will complain at the attempt to use non-inner_map
 	 * references below. This is great experience.
@@ -111,8 +111,8 @@ struct sockarr_sz2 {
 struct outer_sockarr_sz1 {
 	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
 	__uint(max_entries, 1);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
+	__type(key, int);
+	__type(value, int);
 	__array(values, struct sockarr_sz1);
 } outer_sockarr SEC(".maps") = {
 	.values = { (void *)&sockarr_sz1 },
diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
index 1cfeb940cf9f..68a984695184 100644
--- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
@@ -9,18 +9,16 @@ struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
 	__uint(max_entries, 1);
 	__uint(map_flags, 0);
-	__uint(key_size, sizeof(__u32));
-	/* must be sizeof(__u32) for map in map */
-	__uint(value_size, sizeof(__u32));
+	__type(key, __u32);
+	__type(value, __u32);
 } mim_array SEC(".maps");

 struct {
 	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
 	__uint(max_entries, 1);
 	__uint(map_flags, 0);
-	__uint(key_size, sizeof(int));
-	/* must be sizeof(__u32) for map in map */
-	__uint(value_size, sizeof(__u32));
+	__type(key, int);
+	__type(value, __u32);
 } mim_hash SEC(".maps");

 SEC("xdp_mimtest")
diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
index 703c08e06442..9c7d75cf0bd6 100644
--- a/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
@@ -13,7 +13,7 @@ struct inner {
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
 	__uint(max_entries, 0); /* This will make map creation to fail */
-	__uint(key_size, sizeof(__u32));
+	__type(key, __u32);
 	__array(values, struct inner);
 } mim SEC(".maps");

diff --git a/tools/testing/selftests/bpf/progs/test_pe_preserve_elems.c b/tools/testing/selftests/bpf/progs/test_pe_preserve_elems.c
index fb22de7c365d..1249a945699f 100644
--- a/tools/testing/selftests/bpf/progs/test_pe_preserve_elems.c
+++ b/tools/testing/selftests/bpf/progs/test_pe_preserve_elems.c
@@ -7,15 +7,15 @@
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
 	__uint(max_entries, 1);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
+	__type(key, int);
+	__type(value, int);
 } array_1 SEC(".maps");

 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
 	__uint(max_entries, 1);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
+	__type(key, int);
+	__type(value, int);
 	__uint(map_flags, BPF_F_PRESERVE_ELEMS);
 } array_2 SEC(".maps");

diff --git a/tools/testing/selftests/bpf/progs/test_perf_buffer.c b/tools/testing/selftests/bpf/progs/test_perf_buffer.c
index 8207a2dc2f9d..d37ce29fd393 100644
--- a/tools/testing/selftests/bpf/progs/test_perf_buffer.c
+++ b/tools/testing/selftests/bpf/progs/test_perf_buffer.c
@@ -8,8 +8,8 @@

 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
+	__type(key, int);
+	__type(value, int);
 } perf_buf_map SEC(".maps");

 SEC("tp/raw_syscalls/sys_enter")
diff --git a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
index 26e77dcc7e91..0f9bc258225e 100644
--- a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
@@ -24,8 +24,8 @@ int _version SEC("version") = 1;
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
 	__uint(max_entries, 1);
-	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(__u32));
+	__type(key, __u32);
+	__type(value, __u32);
 } outer_map SEC(".maps");

 struct {
diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
index 0cf0134631b4..7449fdb1763b 100644
--- a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
+++ b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
@@ -28,8 +28,8 @@ struct {
 	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
 	__uint(max_entries, 128);
 	__uint(map_flags, BPF_F_STACK_BUILD_ID);
-	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(stack_trace_t));
+	__type(key, __u32);
+	__type(value, stack_trace_t);
 } stackmap SEC(".maps");

 struct {
diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
index 00ed48672620..a8233e7f173b 100644
--- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
+++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
@@ -27,8 +27,8 @@ typedef __u64 stack_trace_t[PERF_MAX_STACK_DEPTH];
 struct {
 	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
 	__uint(max_entries, 16384);
-	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(stack_trace_t));
+	__type(key, __u32);
+	__type(value, stack_trace_t);
 } stackmap SEC(".maps");

 struct {
diff --git a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
index ac63410bb541..24e9344994ef 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
@@ -24,8 +24,8 @@ struct {
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
 	__uint(max_entries, 2);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(__u32));
+	__type(key, int);
+	__type(value, __u32);
 } perf_event_map SEC(".maps");

 int _version SEC("version") = 1;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c b/tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
index a038e827f850..58cf4345f5cc 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
@@ -36,8 +36,8 @@ struct meta {

 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
+	__type(key, int);
+	__type(value, int);
 } perf_buf_map SEC(".maps");

 __u64 test_result_fentry = 0;
--
2.30.2
