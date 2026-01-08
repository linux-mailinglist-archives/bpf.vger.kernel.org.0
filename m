Return-Path: <bpf+bounces-78226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0C1D03542
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 15:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D663308C8C3
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EAC2C326D;
	Thu,  8 Jan 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlLnLvAA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048E3BFE3D;
	Thu,  8 Jan 2026 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879127; cv=none; b=dhAi9XVhxQByS6sL3Gbj3k4v8Y377/Ib19wmGo82KkuOfzaM0xVRuVFfEzvwDvA2C7jHRg0PYezZQZ3/3RcpDC1TzldSoRVtRHlKGjhBc/rONSsJllgHXdP5VMa3AshrEP7s1lmBea3MbFd0w+eRe2f8ydwuueRe9tL+mRUVNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879127; c=relaxed/simple;
	bh=GUwF1Yg/W4LjgNFNJ59UKOdN4qBNr5ji6szGlMiVl8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmBCHvwAFJuBG5LBfisG8aCyArg3gIzzfpEpe4alh1cl4zYIpAb9RZViM2urLG+3z+62wc6of/uA4Bxmvtka4jhpgwfFlGTa6ZHOq/WCt8sBdSTWtRbjdNr/gqbhCjtl/jBmS7LPB0PoVoyPBXzJ0wYhh4EviF0e9hEdZ/vgm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlLnLvAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D9DC116C6;
	Thu,  8 Jan 2026 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767879125;
	bh=GUwF1Yg/W4LjgNFNJ59UKOdN4qBNr5ji6szGlMiVl8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlLnLvAAm26tW7Ctjnm5MqUtY9rPp2aVYNTbNQuurD4bq9pBxfY00Bj/GAkOFhp51
	 yczSV7P+ZVBnrkELUpujSrlPFab4mPu6U2ItYEx/UMLQ4+AY4ZixCoPH4UQ0HZlOdd
	 RVW0OzHhFsBAaEvhbbMKicN1d906C+t3jd5Wrwo92EJqdZuiGkwmmedYufoIbfwSSS
	 fq2hN7WZI7TRSOCl7miC/LH7kx5Wt1k722f/J9ug4g42elVQRKtH/J/o5eyiuleF5L
	 TPiI7kOFppldobk/V88cMgg9bgi1ohXDzRSApU8mARNZ1YC4NjTlhOQwzFGouyXqlH
	 h89oV/6RvmY3w==
Date: Thu, 8 Jan 2026 13:31:59 +0000
From: Simon Horman <horms@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, YiFei Zhu <zhuyifei@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v4] idpf: export RX hardware timestamping
 information to XDP
Message-ID: <20260108133159.GH345651@kernel.org>
References: <20251223194649.3050648-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223194649.3050648-1-almasrymina@google.com>

On Tue, Dec 23, 2025 at 07:46:46PM +0000, Mina Almasry wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> The logic is similar to idpf_rx_hwtstamp, but the data is exported
> as a BPF kfunc instead of appended to an skb to support grabbing
> timestamps in xsk packets.
> 
> A idpf_queue_has(PTP, rxq) condition is added to check the queue
> supports PTP similar to idpf_rx_process_skb_fields.
> 
> Tested using an xsk connection and checking xdp timestamps are
> retreivable in received packets.
> 
> Cc: intel-wired-lan@lists.osuosl.org
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


