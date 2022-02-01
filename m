Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B854A5EBC
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 15:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbiBAO6o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 09:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiBAO6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 09:58:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C649FC061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 06:58:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81A6BB82E89
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 14:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C913C340EB;
        Tue,  1 Feb 2022 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643727521;
        bh=/efpGREpin3vZev7MQPvVFm8IJ8aGX26qhLLLxYwDpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/Rjtod1Mz9FlwgJNR2v9M76akPHqH9s2n44DNDGPlFn/u32l36LPouSerIY2elmC
         0D1V3pSDzaiTcfkE6UH7q3OiCd1Wa8TZmYjjmZ6zNCDNccbVcjTrURYdr6tkI755tp
         kIaB4BYRAxCMjlczgJEWV5vNamVCElqKYXzuEEDYLEpumqOzQ18gnlbk6SnqVwmeGd
         j7O8H018QM+bPK6WI4X2fP7TlfrKLccPtqSlSmxLx8S5y/AQWetcKduypr5pdPZRdq
         pYMAhSXOzdE9Ica+LhI2R7wkD/UZDEimNto/yBsRQ1HNpeY/SQ5XriuCUZO5m9tvVM
         jz1SxVkx2cqOw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, dsahern@kernel.org,
        brouer@redhat.com, toke@redhat.com, lorenzo.bianconi@redhat.com,
        andrii@kernel.org, john.fastabend@gmail.com
Subject: [PATCH v3 bpf-next 3/3] samples/bpf: update cpumap/devmap sec_name
Date:   Tue,  1 Feb 2022 15:58:10 +0100
Message-Id: <509201497c6c4926bc941f1cba24173cf500e760.1643727185.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643727185.git.lorenzo@kernel.org>
References: <cover.1643727185.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Substitute deprecated xdp_cpumap and xdp_devmap sec_name with
xdp/cpumap and xdp/devmap respectively.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 samples/bpf/xdp_redirect_cpu.bpf.c       | 8 ++++----
 samples/bpf/xdp_redirect_map.bpf.c       | 2 +-
 samples/bpf/xdp_redirect_map_multi.bpf.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

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
-- 
2.34.1

