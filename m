Return-Path: <bpf+bounces-65682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF3CB26ECC
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 20:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A3D189133B
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 18:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA9223328;
	Thu, 14 Aug 2025 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAcms378"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C59319855;
	Thu, 14 Aug 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195884; cv=none; b=fmUmH+/1z7G6cCb40952VAym3rXR5jhxbjeRqJO1KXKNMdrggr9JP5LXvv16e/+7MBXDGdKo8C1qJPLkMGweF3tfDTRCXnHnp5kFmw315K3Yjb8aoGo/937e1N0OcrHqg9svh31MMgoOlTdrpC4nyCzA9dlAd17XwpjYG+4w3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195884; c=relaxed/simple;
	bh=cmrj8KeLzigsMCLdXBz/YsgLbulEKsMvd1PG5n4Iz1g=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=d6nOThGB7RhXpKnC3HLpNj0NL2uvwxW5BaY4J5BW3xpn4YJHRLrYiefe8J3Q0vRms2ASVDbDedozuVwqVzQzWYWVuvkEABsmyBeI+4YQMrrycriIULjRQtV2Mi4nnBcTOwKvF99i/XYj234CPa/VsSbTlUbwwIeI2ekaHCIVXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAcms378; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0141CC4CEED;
	Thu, 14 Aug 2025 18:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755195883;
	bh=cmrj8KeLzigsMCLdXBz/YsgLbulEKsMvd1PG5n4Iz1g=;
	h=Subject:From:To:Cc:Date:From;
	b=OAcms378TgtnSyNlFAHryczzmx+PD71h7QQOG8aH5f2p7zLJfPszR5/qfdIG9Kd/4
	 byN1VYjCAU0QchJ9lo1ruW05fGNKCa8+Y4Oh/wjxBjJ9rrhWDBWX5GWr30huwNSx7R
	 GWk9RhacLnQ9TDv7D25r0VvCf0iRzZ368E7SsxRGIpZurv3swtq8+tMoUP4C/qcxtc
	 mX+0Az9zc+6PMCVhYVEH7qZBQn+Gs+XznXEYyyN/rcbO0P5XLjh6nvuUx0VYe3wXNp
	 HG7Z6CB6SSK8J5t9m1/jSTMPc3FFwG4jks0Caxlj338EBXMCZf8FpytDxCsAnCjYoj
	 KcXxmz36eyPvg==
Subject: [PATCH bpf] cpumap: disable page_pool direct xdp_return need larger
 scope
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, dtatulea@nvidia.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 tariqt@nvidia.com, tariqt@nvidia.com, memxor@gmail.com,
 john.fastabend@gmail.com, kernel-team@cloudflare.com, yan@cloudflare.com,
 jbrandeburg@cloudflare.com, carges@cloudflare.com, arzeznik@cloudflare.com
Date: Thu, 14 Aug 2025 20:24:37 +0200
Message-ID: <175519587755.3008742.1088294435150406835.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

When running an XDP bpf_prog on the remote CPU in cpumap code
then we must disable the direct return optimization that
xdp_return can perform for mem_type page_pool.  This optimization
assumes code is still executing under RX-NAPI of the original
receiving CPU, which isn't true on this remote CPU.

The cpumap code already disabled this via helpers
xdp_set_return_frame_no_direct() and xdp_clear_return_frame_no_direct(),
but the scope didn't include xdp_do_flush().

When doing XDP_REDIRECT towards e.g devmap this causes the
function bq_xmit_all() to run with direct return optimization
enabled. This can lead to hard to find bugs.  The issue
only happens when bq_xmit_all() cannot ndo_xdp_xmit all
frames and them frees them via xdp_return_frame_rx_napi().

Fix by expanding scope to include xdp_do_flush().

Fixes: 11941f8a8536 ("bpf: cpumap: Implement generic cpumap")
Found-by: Dragos Tatulea <dtatulea@nvidia.com>
Reported-by: Chris Arges <carges@cloudflare.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 kernel/bpf/cpumap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index b2b7b8ec2c2a..c46360b27871 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -186,7 +186,6 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
-	xdp_set_return_frame_no_direct();
 	xdp.rxq = &rxq;
 
 	for (i = 0; i < n; i++) {
@@ -231,7 +230,6 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 		}
 	}
 
-	xdp_clear_return_frame_no_direct();
 	stats->pass += nframes;
 
 	return nframes;
@@ -255,6 +253,7 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 
 	rcu_read_lock();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+	xdp_set_return_frame_no_direct();
 
 	ret->xdp_n = cpu_map_bpf_prog_run_xdp(rcpu, frames, ret->xdp_n, stats);
 	if (unlikely(ret->skb_n))
@@ -264,6 +263,7 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	if (stats->redirect)
 		xdp_do_flush();
 
+	xdp_clear_return_frame_no_direct();
 	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 



