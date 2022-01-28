Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B549349FAA7
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 14:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiA1N3F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 08:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbiA1N3E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 08:29:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82265C06173B
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 05:29:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1492C61D5F
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 13:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70033C340E0;
        Fri, 28 Jan 2022 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643376543;
        bh=XhJouF0Tf1tFgkzQTm82TsPLnPTLo1KGUgNsLxV23sc=;
        h=From:To:Cc:Subject:Date:From;
        b=WsKm5bftXLKT4P+s9HTAU71R577SYKwclKvCPI26M/vG2XqyBRlmuFljNEDNP5VRY
         IaefbjjBVg+Eg632N4lvS77eXi0Mmnz4ZASTeSEn/XMVvg8Yt8GI7l3fyavPvpJKDY
         eoQI3LAzkcf68xPlOj22fkehg9gap7x/ot5ESpXL2a7Evs/ey3R9ihPUiBf3o7bQUu
         Ki/UsYXlF2dOuq23ewK6x0NcK89PFcVYX5dA6aVLOziixDsAzsY5nuJtSbLQuLmBlg
         YUW7ZgAB2NAnkwvZ3lhsGOUkyZViN1fe5eQWubK5D8bVew3b5Qt/r0q+s68gaNU0AE
         1+wMhnd44RzSw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, dsahern@kernel.org,
        brouer@redhat.com, toke@redhat.com, lorenzo.bianconi@redhat.com,
        andrii@kernel.org, john.fastabend@gmail.com
Subject: [PATCH v2 bpf-next] libbpf: deprecate xdp_cpumap and xdp_devmap sec definitions
Date:   Fri, 28 Jan 2022 14:28:48 +0100
Message-Id: <d456931681fe2344ae56225a698a0bd1d5c63b88.1643375942.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate xdp_cpumap xdp_devmap sec definitions.
Introduce xdp/devmap and xdp/cpumap definitions according to the standard
for SEC("") in libbpf:
- prog_type.prog_flags/attach_place
Update cpumap/devmap samples and kselftests

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- refer to Libbpf-1.0-migration-guide in the warning rised by libbpf
---
 samples/bpf/xdp_redirect_cpu.bpf.c                   |  8 ++++----
 samples/bpf/xdp_redirect_map.bpf.c                   |  2 +-
 samples/bpf/xdp_redirect_map_multi.bpf.c             |  2 +-
 tools/lib/bpf/libbpf.c                               | 12 ++++++++++--
 .../bpf/progs/test_xdp_with_cpumap_frags_helpers.c   |  2 +-
 .../bpf/progs/test_xdp_with_cpumap_helpers.c         |  2 +-
 .../bpf/progs/test_xdp_with_devmap_frags_helpers.c   |  2 +-
 .../bpf/progs/test_xdp_with_devmap_helpers.c         |  2 +-
 .../selftests/bpf/progs/xdp_redirect_multi_kern.c    |  2 +-
 9 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/samples/bpf/xdp_redirect_cpu.bpf.c b/samples/bpf/xdp_redirect_cpu.bpf.c
index 25e3a405375f..87c54bfdbb70 100644
--- a/samples/bpf/xdp_redirect_cpu.bpf.c
+++ b/samples/bpf/xdp_redirect_cpu.bpf.c
@@ -491,7 +491,7 @@ int  xdp_prognum5_lb_hash_ip_pairs(struct xdp_md *ctx)
 	return bpf_redirect_map(&cpu_map, cpu_dest, 0);
 }
 
-SEC("xdp_cpumap/redirect")
+SEC("xdp/cpumap")
 int xdp_redirect_cpu_devmap(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
@@ -507,19 +507,19 @@ int xdp_redirect_cpu_devmap(struct xdp_md *ctx)
 	return bpf_redirect_map(&tx_port, 0, 0);
 }
 
-SEC("xdp_cpumap/pass")
+SEC("xdp/cpumap")
 int xdp_redirect_cpu_pass(struct xdp_md *ctx)
 {
 	return XDP_PASS;
 }
 
-SEC("xdp_cpumap/drop")
+SEC("xdp/cpumap")
 int xdp_redirect_cpu_drop(struct xdp_md *ctx)
 {
 	return XDP_DROP;
 }
 
-SEC("xdp_devmap/egress")
+SEC("xdp/devmap")
 int xdp_redirect_egress_prog(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
diff --git a/samples/bpf/xdp_redirect_map.bpf.c b/samples/bpf/xdp_redirect_map.bpf.c
index 59efd656e1b2..415bac1758e3 100644
--- a/samples/bpf/xdp_redirect_map.bpf.c
+++ b/samples/bpf/xdp_redirect_map.bpf.c
@@ -68,7 +68,7 @@ int xdp_redirect_map_native(struct xdp_md *ctx)
 	return xdp_redirect_map(ctx, &tx_port_native);
 }
 
-SEC("xdp_devmap/egress")
+SEC("xdp/devmap")
 int xdp_redirect_map_egress(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
diff --git a/samples/bpf/xdp_redirect_map_multi.bpf.c b/samples/bpf/xdp_redirect_map_multi.bpf.c
index bb0a5a3bfcf0..8b2fd4ec2c76 100644
--- a/samples/bpf/xdp_redirect_map_multi.bpf.c
+++ b/samples/bpf/xdp_redirect_map_multi.bpf.c
@@ -53,7 +53,7 @@ int xdp_redirect_map_native(struct xdp_md *ctx)
 	return xdp_redirect_map(ctx, &forward_map_native);
 }
 
-SEC("xdp_devmap/egress")
+SEC("xdp/devmap")
 int xdp_devmap_prog(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4ce94f4ed34a..ba003cabe4a4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -237,6 +237,8 @@ enum sec_def_flags {
 	SEC_SLOPPY_PFX = 16,
 	/* BPF program support non-linear XDP buffer */
 	SEC_XDP_FRAGS = 32,
+	/* deprecated sec definitions not supposed to be used */
+	SEC_DEPRECATED = 64,
 };
 
 struct bpf_sec_def {
@@ -6575,6 +6577,10 @@ static int libbpf_preload_prog(struct bpf_program *prog,
 	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
 		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
 
+	if (def & SEC_DEPRECATED)
+		pr_warn("sec '%s' is deprecated, please take a look at https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide\n",
+			prog->sec_name);
+
 	if ((prog->type == BPF_PROG_TYPE_TRACING ||
 	     prog->type == BPF_PROG_TYPE_LSM ||
 	     prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
@@ -8618,9 +8624,11 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("iter.s/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
 	SEC_DEF("xdp.frags/devmap",	XDP, BPF_XDP_DEVMAP, SEC_XDP_FRAGS),
-	SEC_DEF("xdp_devmap/",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
+	SEC_DEF("xdp/devmap",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
+	SEC_DEF("xdp_devmap/",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE | SEC_DEPRECATED),
 	SEC_DEF("xdp.frags/cpumap",	XDP, BPF_XDP_CPUMAP, SEC_XDP_FRAGS),
-	SEC_DEF("xdp_cpumap/",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
+	SEC_DEF("xdp/cpumap",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
+	SEC_DEF("xdp_cpumap/",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE | SEC_DEPRECATED),
 	SEC_DEF("xdp.frags",		XDP, BPF_XDP, SEC_XDP_FRAGS),
 	SEC_DEF("xdp",			XDP, BPF_XDP, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
 	SEC_DEF("perf_event",		PERF_EVENT, 0, SEC_NONE | SEC_SLOPPY_PFX),
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_frags_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_frags_helpers.c
index 62fb7cd4d87a..97ed625bb70a 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_frags_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_frags_helpers.c
@@ -12,7 +12,7 @@ struct {
 	__uint(max_entries, 4);
 } cpu_map SEC(".maps");
 
-SEC("xdp_cpumap/dummy_cm")
+SEC("xdp/cpumap")
 int xdp_dummy_cm(struct xdp_md *ctx)
 {
 	return XDP_PASS;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
index 48007f17dfa8..20ec6723df18 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
@@ -24,7 +24,7 @@ int xdp_dummy_prog(struct xdp_md *ctx)
 	return XDP_PASS;
 }
 
-SEC("xdp_cpumap/dummy_cm")
+SEC("xdp/cpumap")
 int xdp_dummy_cm(struct xdp_md *ctx)
 {
 	if (ctx->ingress_ifindex == IFINDEX_LO)
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_frags_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_frags_helpers.c
index e1caf510b7d2..cdcf7de7ec8c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_frags_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_frags_helpers.c
@@ -12,7 +12,7 @@ struct {
 /* valid program on DEVMAP entry via SEC name;
  * has access to egress and ingress ifindex
  */
-SEC("xdp_devmap/map_prog")
+SEC("xdp/devmap")
 int xdp_dummy_dm(struct xdp_md *ctx)
 {
 	return XDP_PASS;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
index 8ae11fab8316..4139a14f9996 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
@@ -27,7 +27,7 @@ int xdp_dummy_prog(struct xdp_md *ctx)
 /* valid program on DEVMAP entry via SEC name;
  * has access to egress and ingress ifindex
  */
-SEC("xdp_devmap/map_prog")
+SEC("xdp/devmap")
 int xdp_dummy_dm(struct xdp_md *ctx)
 {
 	char fmt[] = "devmap redirect: dev %u -> dev %u len %u\n";
diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
index 8395782b6e0a..97b26a30b59a 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
@@ -70,7 +70,7 @@ int xdp_redirect_map_all_prog(struct xdp_md *ctx)
 				BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
 }
 
-SEC("xdp_devmap/map_prog")
+SEC("xdp/devmap")
 int xdp_devmap_prog(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
-- 
2.34.1

