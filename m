Return-Path: <bpf+bounces-11464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E18F7BA77E
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 19:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BA109281F20
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A4E38FA5;
	Thu,  5 Oct 2023 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQgZ4R74"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6911358B5;
	Thu,  5 Oct 2023 17:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6398EC433CA;
	Thu,  5 Oct 2023 17:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696526166;
	bh=6TQPomYGzW80iUud7BEbLiiItfun6wvVQP2bFLm/bWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OQgZ4R74PH/6FVF4WXTtHbAPY4fs3kBrO1oPh4677MYWPjNQRLnppFa63YkDQtCZV
	 lDT+5a+MV1b275EQ5LYdUwoj2juDbcHv3LlqDGJhZlkg6CnMLpXX2NbCoSAdhiQevH
	 J0VuMf0Jp7gW6AjCHUnH2ScMM6/y60bnSr3nJI38IKuFSw/ExgOy7xj6bIRIfWZ4mr
	 AftudFVaHtmN05gZZa1Vqfu65P64Cv+Ri8n3duDa3yt1/1XeCJ94VduIV9OWCQHkjz
	 LU5JbVwIB7UJ2HDjLDyrt2gCs5iPYbaJ6JZS9pqZCy1v/XIr/kbfl1vVhKJiT9bEiX
	 rMPagj8eXtI1A==
Date: Thu, 5 Oct 2023 10:16:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
 <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
 <haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
 Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer
 <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 "Alexander Lobakin" <alexandr.lobakin@intel.com>, Magnus Karlsson
 <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
 <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
 Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [xdp-hints] Re: [RFC bpf-next v2 09/24] xdp: Add VLAN tag hint
Message-ID: <20231005101604.33b382d8@kernel.org>
In-Reply-To: <e4bbe997-326f-b6cf-b6d6-f0a24f5aef39@intel.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
	<20230927075124.23941-10-larysa.zaremba@intel.com>
	<20231003053519.74ae8938@kernel.org>
	<8e9d830b-556b-b8e6-45df-0bf7971b4237@intel.com>
	<20231004110850.5501cd52@kernel.org>
	<e4bbe997-326f-b6cf-b6d6-f0a24f5aef39@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 18:58:33 +0200 Alexander Lobakin wrote:
> > No unsharing - you can still strip it in the driver.  
> 
> Nobody manually strips VLAN tags in the drivers. You either have HW
> stripping or pass VLAN-tagged skb to the stack, so that skb_vlan_untag()
> takes care of it.

Isn't it just a case of circular logic tho?
We don't optimize the stack for SW stripping because HW does it.
Then HW does it because SW is not optimized.

> > Do you really think that for XDP kfunc call will be cheaper?  
> 
> Wait, you initially asked:
> 
> * discussion about the validity of VLAN stripping as an offload?
> * Do people actually care about having it enabled?
> 
> I did read this as "do we still need HW VLAN stripping in general?", not
> only for XDP. So I replied for "in general" -- yes.
> Forcefully disabling stripping when XDP is active is obscure IMO, let
> the user decide.

Every time I'm involved in conversations about NIC datapath host
interfaces I cringe at this stupid VLAN offload. Maybe I'm too
daft to understand it's amazing value but we just shift 2B from
the packet to the descriptor and then we have to worry about all
the corner cases that come from vlan stacking :(

