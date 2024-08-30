Return-Path: <bpf+bounces-38508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5CA9654E4
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 03:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0E31F2474E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCB54278;
	Fri, 30 Aug 2024 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPLqhMEG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC927473;
	Fri, 30 Aug 2024 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982934; cv=none; b=dVxQGvXJl5L8dFCgsSLwABAnD7gC9HtK/9pQhgUuiohvubUhy991b3Ph28cNMzqJqJYs/ABqw58LeXRZeYF7TilON0PsehLKCasl2fvThJQNY3ps81DkzY6hul3t2qyUqv9bAWhGhIS2jIYuhzdfX/rLyoipae3R9aH2fDLVIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982934; c=relaxed/simple;
	bh=ixaudXjydPQWqGwW6i0tvFoJa2z+92+ZszjJYy4wsfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVwXM47EtGQYd0pElrAw3uKSQKlqbOVoBmt76qGfgnkOMi54KCveTFmM8M0f3a75qa40vv2bVNqZV9fo2EY38sM0MEH9JyIIJksFTmAOxmbPwQMnasQw5x0eQ/WS0SdbBVIMAfcCVg5nIifLRfuHe6WkMu6NkkUM7lrLRbA5eUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPLqhMEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B2CC4CEC1;
	Fri, 30 Aug 2024 01:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724982933;
	bh=ixaudXjydPQWqGwW6i0tvFoJa2z+92+ZszjJYy4wsfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JPLqhMEGxt5wUdNsS6na9V0n93df0kngWwoyVclEoqbcDhaDhsMgZQlBioYY/XowC
	 gc4Q0YVUfIUxSx9Smdg9sNfEZUT+hOR1hA8McYNaZidychT6aWCDJBI+3p+k+IQRGq
	 3/LHP6NnevRKG+Ejoy6yp1rwZjyBWJTJacxV8ow/4ozbFHawrPaSf/sHT+AWM1P3S4
	 sIvbJ+rDRKF4Bpw08pb3uo98xwPZtGdlSdQ7Z/dK1aSkWpEv8hgdYOfZUi4bhjYbGV
	 2fNqCpmfaRZ2qiHPZf2qVQidg5iRCKZvDNuWsy4lqqd+s1j6Ci694dLu4kkZFefEBe
	 AihapTtLj8nZg==
Message-ID: <a9603de2-3ff3-40aa-9bb1-2a02c2ed3e5e@kernel.org>
Date: Thu, 29 Aug 2024 18:55:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12] Unmask upper DSCP bits - part 2
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, gnault@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, john.fastabend@gmail.com,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 bpf@vger.kernel.org
References: <20240829065459.2273106-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240829065459.2273106-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/24 12:54 AM, Ido Schimmel wrote:
> tl;dr - This patchset continues to unmask the upper DSCP bits in the
> IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> DSCP. No functional changes are expected. Part 1 was merged in commit
> ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> 
> The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> lookup to match against the TOS selector in FIB rules and routes.
> 
> It is currently impossible for user space to configure FIB rules that
> match on the DSCP value as the upper DSCP bits are either masked in the
> various call sites that initialize the IPv4 flow key or along the path
> to the FIB core.
> 
> In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> need to make sure the entire DSCP value is present in the IPv4 flow key.
> This patchset continues to unmask the upper DSCP bits, but this time in
> the output route path.
> 
> Patches #1-#3 unmask the upper DSCP bits in the various places that
> invoke the core output route lookup functions directly.
> 
> Patches #4-#6 do the same in three helpers that are widely used in the
> output path to initialize the TOS field in the IPv4 flow key.
> 
> The rest of the patches continue to unmask these bits in call sites that
> invoke the following wrappers around the core lookup functions:
> 
> Patch #7 - __ip_route_output_key()
> Patches #8-#12 - ip_route_output_flow()
> 
> The next patchset will handle the callers of ip_route_output_ports() and
> ip_route_output_key().
> 
> No functional changes are expected as commit 1fa3314c14c6 ("ipv4:
> Centralize TOS matching") moved the masking of the upper DSCP bits to
> the core where 'flowi4_tos' is matched against the TOS selector.
> 
> Changes since v1 [1]:
> 
> * Remove IPTOS_RT_MASK in patch #7 instead of in patch #6
> 
> [1] https://lore.kernel.org/netdev/20240827111813.2115285-1-idosch@nvidia.com/
> 
> Ido Schimmel (12):
>   ipv4: Unmask upper DSCP bits in RTM_GETROUTE output route lookup
>   ipv4: Unmask upper DSCP bits in ip_route_output_key_hash()
>   ipv4: icmp: Unmask upper DSCP bits in icmp_route_lookup()
>   ipv4: Unmask upper DSCP bits in ip_sock_rt_tos()
>   ipv4: Unmask upper DSCP bits in get_rttos()
>   ipv4: Unmask upper DSCP bits when building flow key
>   xfrm: Unmask upper DSCP bits in xfrm_get_tos()
>   ipv4: Unmask upper DSCP bits in ip_send_unicast_reply()
>   ipv6: sit: Unmask upper DSCP bits in ipip6_tunnel_xmit()
>   ipvlan: Unmask upper DSCP bits in ipvlan_process_v4_outbound()
>   vrf: Unmask upper DSCP bits in vrf_process_v4_outbound()
>   bpf: Unmask upper DSCP bits in __bpf_redirect_neigh_v4()
> 
>  drivers/net/ipvlan/ipvlan_core.c | 4 +++-
>  drivers/net/vrf.c                | 3 ++-
>  include/net/ip.h                 | 5 ++++-
>  include/net/route.h              | 5 ++---
>  net/core/filter.c                | 2 +-
>  net/ipv4/icmp.c                  | 3 ++-
>  net/ipv4/ip_output.c             | 3 ++-
>  net/ipv4/route.c                 | 8 ++++----
>  net/ipv6/sit.c                   | 5 +++--
>  net/xfrm/xfrm_policy.c           | 3 ++-
>  10 files changed, 25 insertions(+), 16 deletions(-)
> 

For the set:

Reviewed-by: David Ahern <dsahern@kernel.org>


