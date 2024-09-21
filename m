Return-Path: <bpf+bounces-40168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCCA97DF1B
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 23:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FD0FB2128C
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9BE15383E;
	Sat, 21 Sep 2024 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6bE5Ggw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B57257B;
	Sat, 21 Sep 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726954621; cv=none; b=knNIdleRNXnYnygv6HGJzvTtgKkrwdk6ST0EMYlT1enKyi1BRIFJi7DbI/LsiRYRDqVTvPSDPdZwTuq5nLdDyxA35H0ZmzgziqSS0XQO48m/ZF/uk6pNpNgFLzMHK4biRbBtrkcrlglUzUWy0HzlZf7eYoDWToxOee80GDbFAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726954621; c=relaxed/simple;
	bh=Cz/rB1tfpIcjVKvJ0kABbjer56WE7Iki57K7hUdDn94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2EwScVXhbmuWhI7BUZYNEi/Qon5tyCTduRJbJ62BTFmwDJODpE+eT0JhYEcN5IAuXK9rLIC0eT03gW4UIbdTPJRgGck5BhK1ZdlZOiMtQXZscslkM78NuKC2iBzACP6MRpofFD+4ZWLDcVHS4zTkWNlckZ7DrLByMK/M6jAAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6bE5Ggw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBDBC4CEC2;
	Sat, 21 Sep 2024 21:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726954621;
	bh=Cz/rB1tfpIcjVKvJ0kABbjer56WE7Iki57K7hUdDn94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q6bE5Ggwl5v3ct+ug5zFyt/0bzFy5s1cFkfCfT3WROGt/FJcwaBFONP2PxVDLvegm
	 tTdQyN/Fl4adzefPlGHX0gba5NGCzEiCqty+bSAWuW7R6z45HwJGscHsrZT6Mf9+SC
	 TtYCwozu0Bs4PcjFQnrCadbOUyz8VsXOVRvaqNlnDFrpv9LnFPmtAZ1umWrJQUpKam
	 gVoCxKZ/1kw5CV+b4WlWlmqua60oY4mGlHTPh+iyzD/KM4f17pPzVhV1CbGJysjAVM
	 EuaVu0ydjIVomSR3Zgj454AFffuqbqKXQwpdQ1VFQOsS4KzQ4m1qYMUqSDL2M9oZFo
	 /Y6wFjLp+HIog==
Message-ID: <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
Date: Sat, 21 Sep 2024 23:36:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com,
 lorenzo.bianconi@redhat.com, toke@toke.dk, sdf@google.com,
 tariqt@nvidia.com, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 mst@redhat.com, jasowang@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel-team <kernel-team@cloudflare.com>,
 Yan Zhai <yan@cloudflare.com>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/09/2024 22.17, Alexander Lobakin wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Sat, 21 Sep 2024 18:52:56 +0200
> 
>> This series introduces the xdp_rx_meta struct in the xdp_buff/xdp_frame
> 
> &xdp_buff is on the stack.
> &xdp_frame consumes headroom.
> 
> IOW they're size-sensitive and putting metadata directly there might
> play bad; if not now, then later.
> 
> Our idea (me + Toke) was as follows:
> 
> - new BPF kfunc to build generic meta. If called, the driver builds a
>    generic meta with hash, csum etc., in the data_meta area.

I do agree that it should be the XDP prog (via a new BPF kfunc) that
decide if xdp_frame should be updated to contain a generic meta struct.
*BUT* I think we should use the xdp_frame area, and not the
xdp->data_meta area.

A details is that I think this kfunc should write data directly into
xdp_frame area, even then we are only operating on the xdp_buff, as we
do have access to the area xdp_frame will be created in.


When using data_meta area, then netstack encap/decap needs to move the
data_meta area (extra cycles).  The xdp_frame area (live in top) don't
have this issue.

It is easier to allow xdp_frame area to survive longer together with the
SKB. Today we "release" this xdp_frame area to be used by SKB for extra
headroom (see xdp_scrub_frame).  I can imagine that we can move SKB
fields to this area, and reduce the size of the SKB alloc. (This then
becomes the mini-SKB we discussed a couple of years ago).


>    Yes, this also consumes headroom, but only when the corresponding func
>    is called. Introducing new fields like you're doing will consume it
>    unconditionally;

We agree on the kfunc call marks area as consumed/in-use.  We can extend
xdp_frame statically like Lorenzo does (with struct xdp_rx_meta), but
xdp_frame->flags can be used for marking this area as used or not.


> - when &xdp_frame gets converted to sk_buff, the function checks whether
>    data_meta contains a generic structure filled with hints.
> 

Agree, but take data from xdp_frame->xdp_rx_meta.

When XDP returns XDP_PASS, then I also want to see this data applied to
the SKB. In patchset[1] Yan called this xdp_frame_fixup_skb_offloading()
and xdp_buff_fixup_skb_offloading(). (Perhaps "fixup" isn't the right
term, "apply" is perhaps better).  Having this generic-name allow us to
extend with newer offloads, and eventually move members out of SKB.

We called it "fixup", because our use-case is that our XDP load-balancer
(Unimog) XDP_TX bounce packets with in GRE header encap, and on the
receiving NIC (due to encap) we lost the HW hash/csum, which we want to
transfer from the original NIC, decap in XDP and apply the original HW
hash/csum via this "fixup" call.

--Jesper

[1] https://lore.kernel.org/all/cover.1718919473.git.yan@cloudflare.com/

> We also thought about &skb_shared_info, but it's also size-sensitive as
> it consumes tailroom.
> 
>> one as a container to store the already supported xdp rx hw hints (rx_hash
>> and rx_vlan, rx_timestamp will be stored in skb_shared_info area) when the
>> eBPF program running on the nic performs XDP_REDIRECT. Doing so, we are able
>> to set the skb metadata converting the xdp_buff/xdp_frame to a skb.
> 
> Thanks,
> Olek

