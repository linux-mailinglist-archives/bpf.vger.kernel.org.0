Return-Path: <bpf+bounces-73185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D877C26A62
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 19:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAEAE4F2066
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0A2D3737;
	Fri, 31 Oct 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvRBJp/a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA52222A0;
	Fri, 31 Oct 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936594; cv=none; b=R2+6KNx82if1A7Pd7YLn/LnWaSCbzd8uwXw+W6m3elHW5Y0nFOkinorgbbVD1siUeSL/MkUuV3nW7OdrYrE3QF/x1IaleXIGMXDBIiJAkuppMXbe8Ua5rXi/GylAFBeH1PtQjV/6NtGBLJujUmd3AoGw4weMUo5ZO02YvxA9B10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936594; c=relaxed/simple;
	bh=lr0rrZQ3dBRapUwBB5AFJe6Ah19DqQH2VRMHIh7KpKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuigrQzygDi0RTHxEPtvJa4NB/iUQatN8u/cFAEg0VouZ9Z7boFR8aLq907P8a3EeLDZ+X7Dl0okj7mlAT/C1U9pAus2uPsi6H6Oq+nCorUdozU/wGZsSaoeSKOH1g/im87srxRXM1Tu/szLob/FNm0RJRaq+LwJawza7UWiAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvRBJp/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4DCC4CEE7;
	Fri, 31 Oct 2025 18:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761936594;
	bh=lr0rrZQ3dBRapUwBB5AFJe6Ah19DqQH2VRMHIh7KpKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nvRBJp/aTCzNJLP4/VB3WDUdMPJxJpflJdl9qJKihaOQDsGkFnQlKGfK0f8hPRQLt
	 dRjtAWXaOjCyBRLSkb7CvKjyrXQb6qAzYOIJDmkjoXJ0ghPEfYEvLTFPBlgJ0RlhXf
	 kdCQzCwwtkRCBGTw8grYVSLk5sx/IER4L7E8q/x99irKHPwZqbSj8v0ZIUJxCXbuNo
	 ChyHEk6IFoE3rtUGRWwoIw6tBWqbooWpInm0+9R1l3xFp1t3/cR9QvJa81aCcaxzsu
	 YXQQX/ghI+WPgJbw7HkZCPVkZGU9aY5Uvn8iLSszUDKWorrgI2GSmDxf6mXBtM764p
	 cfbuAdEATH/6g==
Date: Fri, 31 Oct 2025 11:49:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
 <aleksander.lobakin@intel.com>, <ilias.apalodimas@linaro.org>,
 <toke@redhat.com>, <lorenzo@kernel.org>,
 <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v5 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <20251031114952.37d1cb1f@kernel.org>
In-Reply-To: <aQSfgQ9+Jc8dkdhg@boxer>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
	<20251029221315.2694841-2-maciej.fijalkowski@intel.com>
	<20251029165020.26b5dd90@kernel.org>
	<aQNWlB5UL+rK8ZE5@boxer>
	<20251030082519.5db297f3@kernel.org>
	<aQPJCvBgR3d7lY+g@boxer>
	<20251030190511.62575480@kernel.org>
	<aQSfgQ9+Jc8dkdhg@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 12:37:37 +0100 Maciej Fijalkowski wrote:
> > > would be fine for you? Plus AI reviewer has kicked me in the nuts on veth
> > > patch so have to send v6 anyways.  
> > 
> > The veth side unfortunately needs more work than Mr Robot points out.
> > For some reason veth tries to turn skb into an xdp_frame..  
> 
> That is beyond the scope of the fix that I started doing as you're
> undermining overall XDP support in veth, IMHO.
> 
> I can follow up on this on some undefined future but right now I will
> have to switch to some other work.
> 
> If you disagree and insist on addressing skb->xdp_frame in veth within
> this patchset then I'm sorry but I will have to postpone my activities
> here.

Yeah, I understand. A lot of the skb<>XDP integration is a steaming
pile IMO, as mentioned elsewhere. I'd like to keep the core clean
tho, so if there's some corner cases in veth after your changes
I'll live. But I'm worried that the bugs in veth will make you
want to preserve the conditional in xdp_convert_skb_to_buff() :(

