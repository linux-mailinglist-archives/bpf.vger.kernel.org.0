Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333554A5EBB
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 15:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbiBAO6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 09:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239609AbiBAO6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 09:58:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B302C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 06:58:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF9AD61657
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 14:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E13C340ED;
        Tue,  1 Feb 2022 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643727518;
        bh=cA8/N+3KIhE+AcK7+B/F6sqCZ5JJ6hctxvnOeEsJ9oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7YJ/aOh31DH/L1FWpkSzRHSZvmtdXI8GpZjRIfzMOJRoIBtrxmQkyWh4jkASFqm8
         JPNr8U2TFPrnfimuPLZ1cD8WtGjGugrtHQRi8C31ur4CqNsj1c+fWRg/Jc/KIBQjUT
         WQeXufK9dYqzmA3XQSS5CN8U4E3OwM2VzW7GxFCophSQgDuVLzm+g3dpnny7R81dVR
         fWNuGOA0o4XIv+wPlKscswZU0AOQierbjheJBJ8Kop0cjKyS1uyZDJ3Vh1+LKD6cPr
         fY1qfcV9PEp5zuNM2f2DRC6CivnWVZuyorhnGjLW6dflLbofOi9GPJZU9i/wpap0EZ
         /RWEJy9zI0ZAA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, dsahern@kernel.org,
        brouer@redhat.com, toke@redhat.com, lorenzo.bianconi@redhat.com,
        andrii@kernel.org, john.fastabend@gmail.com
Subject: [PATCH v3 bpf-next 2/3] selftests/bpf: update cpumap/devmap sec_name
Date:   Tue,  1 Feb 2022 15:58:09 +0100
Message-Id: <9a4286cd36781e2c31ba3773bfdcf45cf1bbaa9e.1643727185.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643727185.git.lorenzo@kernel.org>
References: <cover.1643727185.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Substitute deprecated xdp_cpumap and xdp_devmap sec_name with
xdp/cpumap and xdp/devmap respectively in bpf kselftests.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../selftests/bpf/progs/test_xdp_with_cpumap_frags_helpers.c    | 2 +-
 .../testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c  | 2 +-
 .../selftests/bpf/progs/test_xdp_with_devmap_frags_helpers.c    | 2 +-
 .../testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c  | 2 +-
 tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

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

