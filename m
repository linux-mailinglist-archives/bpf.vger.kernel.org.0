Return-Path: <bpf+bounces-7540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18427778E71
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 13:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40BF2821C4
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A6579CF;
	Fri, 11 Aug 2023 11:58:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D56FC2;
	Fri, 11 Aug 2023 11:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DD9C433C7;
	Fri, 11 Aug 2023 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691755086;
	bh=wfvu3TMRQPeIB4HmfbwwbhKQnTjDQldHSGkl2C9S4iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyYGu5/uMiK9TbeMZWJXnCV0oyAzsE/5JBPkWDkQxRT1DPbMJKbg6ybKFOhqlQBDn
	 2J/GJqc/efbNVLfEHCl+H5JMaS9pWI/EWw6wNjsqSLbRycjiuxPvy/UhRs1UxYt/54
	 QWJBo35BVFe3gB4cAqk2uFW83L3i8Is5s9gc0mcV11fY0atqQDnG37c6A9NMeecrNt
	 bhfGMxbB71i3YSrVfZVpakn6FU57rVxT+vznHJIHkITxk/VZOK5/8VOb1T+e6VK/WV
	 64uPt3PViRq8P7IHgOHEKLkqryLiXUOQVk0/xE484D5Q0S+p6d1wFwVhI5dq0jp2z9
	 pQfJqRNA/xlcA==
Date: Fri, 11 Aug 2023 13:58:00 +0200
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com, jbrouer@redhat.com,
	netdev@vger.kernel.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH V5 net-next 1/2] net: fec: add XDP_TX feature support
Message-ID: <ZNYiSEG5/0cJIZ3f@vergenet.net>
References: <20230810064514.104470-1-wei.fang@nxp.com>
 <20230810064514.104470-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810064514.104470-2-wei.fang@nxp.com>

On Thu, Aug 10, 2023 at 02:45:13PM +0800, Wei Fang wrote:
> The XDP_TX feature is not supported before, and all the frames
> which are deemed to do XDP_TX action actually do the XDP_DROP
> action. So this patch adds the XDP_TX support to FEC driver.
> 
> I tested the performance of XDP_TX in XDP_DRV mode and XDP_SKB
> mode respectively on i.MX8MP-EVK platform, and as suggested by
> Jesper, I also tested the performance of XDP_REDIRECT on the
> same platform. And the test steps and results are as follows.
> 
> XDP_TX test:
> Step 1: One board is used as generator and connects to switch,and
> the FEC port of DUT also connects to the switch. Both boards with
> flow control off. Then the generator runs the
> pktgen_sample03_burst_single_flow.sh script to generate and send
> burst traffic to DUT. Note that the size of packet was set to 64
> bytes and the procotol of packet was UDP in my test scenario. In
> addtion, the SMAC of the packet need to be different from the MAC

nit: addtion -> addition

     checkpatch.pl --codespell is your friend here.

...

