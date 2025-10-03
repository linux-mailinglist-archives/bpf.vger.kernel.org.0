Return-Path: <bpf+bounces-70355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB47BB85EE
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 01:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89023B0E6C
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 23:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A904274FD0;
	Fri,  3 Oct 2025 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYGevoed"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B116EED8;
	Fri,  3 Oct 2025 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759533028; cv=none; b=Cs28uCO4iP00eNbIIFpoTud7I7dz8wA69xoX5pCdxZ1oRDlps07OdQRpju5njS7ofUOr8xn+x4iqdvjdEwXnLzKmwAYAGQnhDgbJO3F2v6ppfgkat5lU+PdYbE05dONtXmcp1cZvPc/eEtsGFiiVqHqWHR0CHGeh2cJe2iTAzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759533028; c=relaxed/simple;
	bh=DGCFwTHdzwoyUt2airE4UfS1rzXskWvCAT/NjTMw5kE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1AwhSmaXQcu6wfbThbn4c8PUF3z8/LYht0nlr2gZWESpnTZQ5b0E5g5FvMDBTqke6x9IWSpfAJAghNfIpiiCSqJy7vyEioNTy27ywu/YRs3CHk1BlIGsOepQGtdD0gtrQNxWeFdWMsQ/Yexi28J2wmtm697c//splw662zGFnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYGevoed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DB2C4CEF5;
	Fri,  3 Oct 2025 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759533028;
	bh=DGCFwTHdzwoyUt2airE4UfS1rzXskWvCAT/NjTMw5kE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IYGevoedU4k5uOJYbDIBOhb/iK0EXt0Z6nffEeR0L2BMMVKZcuNgKfFEWbyeXTWcl
	 wx0nhCJn0UgqXoRPi2HYfgLME59iR+CYHKONpFO/+6JN+0WL4NVnhG49HJauxrG1NP
	 BkZI6RCihoMunUgTJbiYGp5xWsK1r7xDdhNKnucyMxmUWrxMB3jxFQoHkes1Mf9Qwo
	 50HVYqdNzgQ6UpjGpYLaKNanM8cAxABVFBIVNdRpdRkwWGytgO1mGb5cUmEI7b1wW4
	 0rtFlNMiVbG8v5XH92Gb3CnkUpBnLMXxgbBXBQEnWGW4yIozQl4iL8KcLAvaHqMdKX
	 lwfHN8r46ZpZg==
Date: Fri, 3 Oct 2025 16:10:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, ilias.apalodimas@linaro.org, toke@redhat.com,
 lorenzo@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 andrii@kernel.org, stfomichev@gmail.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH bpf 2/2] veth: update mem type in xdp_buff
Message-ID: <20251003161026.5190fcd2@kernel.org>
In-Reply-To: <20251003140243.2534865-3-maciej.fijalkowski@intel.com>
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
	<20251003140243.2534865-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Oct 2025 16:02:43 +0200 Maciej Fijalkowski wrote:
> +	xdp_update_mem_type(xdp);
> +
>  	act = bpf_prog_run_xdp(xdp_prog, xdp);

The new helper doesn't really express what's going on. Developers
won't know what are we updating mem_type() to, and why. Right?

My thinking was that we should try to bake the rxq into "conversion"
APIs, draft diff below, very much unfinished and I'm probably missing
some cases but hopefully gets the point across:

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..e7f75d551d8f 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -384,9 +384,21 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
+/* Initialize rxq struct on the stack for processing @frame.
+ * Not necessary when processing in context of a driver which has a real rxq,
+ * and passes it to xdp_convert_frame_to_buff().
+ */
+static inline
+void xdp_rxq_prep_on_stack(const struct xdp_frame *frame,
+			   struct xdp_rxq_info *rxq)
+{
+	rxq->dev = xdpf->dev_rx;
+	/* TODO: report queue_index to xdp_rxq_info */
+}
+
 static inline
 void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
-			       struct xdp_buff *xdp)
+			       struct xdp_buff *xdp, struct xdp_rxq_info *rxq)
 {
 	xdp->data_hard_start = frame->data - frame->headroom - sizeof(*frame);
 	xdp->data = frame->data;
@@ -394,6 +406,22 @@ void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
 	xdp->data_meta = frame->data - frame->metasize;
 	xdp->frame_sz = frame->frame_sz;
 	xdp->flags = frame->flags;
+
+	rxq->mem.type = xdpf->mem_type;
+}
+
+/* Initialize an xdp_buff from an skb.
+ *
+ * Note: if skb has frags skb_cow_data_for_xdp() must be called first,
+ * or caller must otherwise guarantee that the frags come from a page pool
+ */
+static inline
+void xdp_convert_skb_to_buff(const struct xdp_frame *frame,
+			     struct xdp_buff *xdp, struct xdp_rxq_info *rxq)
+{
+	// copy the init_buff / prep_buff here
+
+	rxq->mem.type = MEM_TYPE_PAGE_POOL; /* see note above the function */
 }
 
 static inline
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..60ba15bbec59 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -193,11 +193,8 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 		u32 act;
 		int err;
 
-		rxq.dev = xdpf->dev_rx;
-		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
-
-		xdp_convert_frame_to_buff(xdpf, &xdp);
+		xdp_rxq_prep_on_stack(xdpf, &rxq);
+		xdp_convert_frame_to_buff(xdpf, &xdp, &rxq);
 
 		act = bpf_prog_run_xdp(rcpu->prog, &xdp);
 		switch (act) {


