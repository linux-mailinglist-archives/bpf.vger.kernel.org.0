Return-Path: <bpf+bounces-11471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BAB7BA89F
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 20:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ECA00281FBD
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 18:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E973D3A8;
	Thu,  5 Oct 2023 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8U/1MOe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89A3B79D;
	Thu,  5 Oct 2023 18:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165D8C433C8;
	Thu,  5 Oct 2023 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696529197;
	bh=j3yuvekkRlzjwP+X1S3U4vfcJhX90l/G2jFB+lby8J8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H8U/1MOeMmkz/fiYJ2qC5kivExGxkQv0jc+YIUGCD2lx/oVojDyCXXJzZzp8GMDMB
	 shzSmWgYDBdDBvuwnGbuQItv1J9OAJVcvSj/0gkxC13lAgmlTESieos2oyzy/J/ZIW
	 hm8HD/c9RMPS1kjYVjS6+h1JIR/rlQv6Z1oN8BgyQUkpa4cxJT9k1LvERFAvBG7SdN
	 VVIkkOPef/5ppA0reFHX8UzRBaitvus71DYsGBtG8ZBO/VTHuj41x+58sc+eqahJET
	 r9rvl6KLYHj/Dm5xDqcFdOQ6qb50vEkeknx/0uUYq7SsxfK1t0gf3vQp0IVKdGpiAr
	 QJeMGU/UR2uZg==
Date: Thu, 5 Oct 2023 11:06:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, Willem de Bruijn
 <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly
 Burakov <anatoly.burakov@intel.com>, Alexander Lobakin
 <alexandr.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, Simon Horman
 <simon.horman@corigine.com>, Tariq Toukan <tariqt@mellanox.com>, Saeed
 Mahameed <saeedm@mellanox.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [xdp-hints] Re: [RFC bpf-next v2 09/24] xdp: Add VLAN tag hint
Message-ID: <20231005110635.7020d23b@kernel.org>
In-Reply-To: <0be2e89e-8a08-e52c-fecd-3064262c2ecb@gmail.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
	<20230927075124.23941-10-larysa.zaremba@intel.com>
	<20231003053519.74ae8938@kernel.org>
	<8e9d830b-556b-b8e6-45df-0bf7971b4237@intel.com>
	<20231004110850.5501cd52@kernel.org>
	<e4bbe997-326f-b6cf-b6d6-f0a24f5aef39@intel.com>
	<20231005101604.33b382d8@kernel.org>
	<0be2e89e-8a08-e52c-fecd-3064262c2ecb@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 11:20:49 -0600 David Ahern wrote:
> > Every time I'm involved in conversations about NIC datapath host
> > interfaces I cringe at this stupid VLAN offload. Maybe I'm too
> > daft to understand it's amazing value but we just shift 2B from
> > the packet to the descriptor and then we have to worry about all
> > the corner cases that come from vlan stacking :(  
> 
> 4B (vlan tci + protocol).
> 
> VLAN stripping in S/W and pushing the header on Tx is measurable and
> does have a noticeable performance impact.
> 
> XDP programs need to co-exist with enabled offloads. If the tag is not
> stripped, XDP program needs to handle it. If the tag is stripped, the
> XDP program needs to access to the value.

Well, I thought I'd ask :) I'm not opposed.

But if either of you have the data on how much slower well-implemented
Rx stripping in the driver is than putting the info in the descriptor,
I'd be very interested.

Tx is a different situation.

