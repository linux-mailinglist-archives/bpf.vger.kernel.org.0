Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B282949E21F
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 13:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiA0MMs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 07:12:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44192 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241043AbiA0MMr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 07:12:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E57FB82229
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 12:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059FBC340E4;
        Thu, 27 Jan 2022 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643285565;
        bh=wgcHJFhCZ9qCRG1fCzIXc6gdNyX8YjOj+nw9LyDPWIw=;
        h=From:To:Cc:Subject:Date:From;
        b=fhanXZ8fKa7bjSo1nnqRnSLwIlhrew6U0fvHqh90NWYXOZlnx1GEuy1lrfUxpt1G7
         CH9CDiBhgrQkYoT4qpNRlW4GM5+kh9lmzRT9ECqTp99N+9dSo+GIiH9TeMXAEbS74w
         cJViRqCrXdDm0AwldueOcZr7EzHbA92SD/44OQya6ZpSTpi1a/D0qoa+ab8UXtRSIo
         4ARSAl/fkQz4mzsPTv/3Kl9v6Sl7opupYi+Qf0B85+IiAJ4/dVjhqJJB8brJWE5pkM
         fDenXht+pvOE++7AtmV/IfrBu5sBEJpy6slsrf5boguIub8A17NqKkfgGMJHBG02dJ
         1G7jIZfECYskA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, dsahern@kernel.org,
        brouer@redhat.com, toke@redhat.com, lorenzo.bianconi@redhat.com,
        andrii@kernel.org, john.fastabend@gmail.com
Subject: [PATCH bpf-next] libbpf: deprecate xdp_cpumap and xdp_devmap sec definitions
Date:   Thu, 27 Jan 2022 13:12:33 +0100
Message-Id: <d7f8f9e3370d33be0a3385c7604d8925e10c91d1.1643285321.git.lorenzo@kernel.org>
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
index 4ce94f4ed34a..1d97bc346be6 100644
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
+		pr_warn("sec '%s' is deprecated, please use new version instead\n",
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

