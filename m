Return-Path: <bpf+bounces-56761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72432A9D6A9
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 02:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D77A81EA
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 00:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E251DF26E;
	Sat, 26 Apr 2025 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUshpztM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A7D1B422A;
	Sat, 26 Apr 2025 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745627021; cv=none; b=p5UMdvNeXh4RJ+6fg1VdD2nEpYU1KotNlquTCbsKYODnkT9H7lPfBaQi+JCqmF5EloDYKNt6hHAmSR3PqHvn73vp95dolErG/61O6J4DqjR60XtHJ2P1EgUDq2LQIFLaD7ogFvB5QNlZQrhOo/RcGCV7aAkolEtRZ6eBLIt6TO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745627021; c=relaxed/simple;
	bh=iBCYh4blOoG37tCWqPPYJh/s+8WaWGhZe+QEX2JnWZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFhdZz1h3dufMbmFtx4zZqAaD48wQey18/HPqVzb5vFkm6yZyWDg+mWO5IGp4+wAvB/3qZaIElVa5i/cJj7FNwQ6i5qVgy+vaR7/vc9cRUuKUvQemf9gEvWRhD8PlUSidJbxBdo5/YHzT8jd7P5Pzx+RbW4bKD6ZAThZW8q3sAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUshpztM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362BDC4CEE4;
	Sat, 26 Apr 2025 00:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745627020;
	bh=iBCYh4blOoG37tCWqPPYJh/s+8WaWGhZe+QEX2JnWZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SUshpztMP+cuxZ/YpPa93wHrgkJp1a/JZpwYR0+ltsP6P6ALelIdeIR/p+vpJSx8O
	 3PKO5ZweL2DZXhpc0Ks8Uh6zlzAAQ3ZkQ94WuxafKv4RIU5EZZPJcrGKfv1DZ8ZC9b
	 BcE+NYskl5zJrZN4GsgORbvcf68sSJrRDLFJSfGP9lxL0tWqJKuKYZSwBVIhRdxoQX
	 LwRgbRX7MARKRvoJT3DCJz23wglE0TR/k5hxmGj3UNpLdoC1PZdzkmp9kH4dKz+ZYO
	 NpjkVgVu3ozPFQ8EKrOYfjfK8BNuAnEWuCSINEK1WJfIz5Kv2m5q6G8jQhBJOuouhe
	 QMzTiNsToY3jg==
Date: Fri, 25 Apr 2025 17:23:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] xsk: respect the offsets when copying frags
Message-ID: <20250425172339.21a66c9b@kernel.org>
In-Reply-To: <7a6f896f-fade-47ed-b101-72be264dcf2b@gmail.com>
References: <20250423101047.31402-1-minhquangbui99@gmail.com>
	<7a6f896f-fade-47ed-b101-72be264dcf2b@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 22:46:35 +0700 Bui Quang Minh wrote:
> On 4/23/25 17:10, Bui Quang Minh wrote:
> > Add the missing offsets when copying frags in xdp_copy_frags_from_zc().
> >
> > Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > ---
> >   net/core/xdp.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index f86eedad586a..a723dc301f94 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -697,7 +697,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
> >   	nr_frags = xinfo->nr_frags;
> >   
> >   	for (u32 i = 0; i < nr_frags; i++) {
> > -		u32 len = skb_frag_size(&xinfo->frags[i]);
> > +		const skb_frag_t *frag = &xinfo->frags[i];
> > +		u32 len = skb_frag_size(frag);
> >   		u32 offset, truesize = len;
> >   		netmem_ref netmem;
> >   
> > @@ -707,8 +708,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
> >   			return false;
> >   		}
> >   
> > -		memcpy(__netmem_address(netmem),
> > -		       __netmem_address(xinfo->frags[i].netmem),
> > +		memcpy(__netmem_address(netmem) + offset,
> > +		       __netmem_address(frag->netmem) + skb_frag_off(frag),
> >   		       LARGEST_ALIGN(len));
> >   		__skb_fill_netmem_desc_noacc(sinfo, i, netmem, offset, len);
> >     
> 
> I know it's very unlikely but do we need to 
> kmap_local_page(skb_frag_page(frag) before using 
> __netmem_address(frag->netmem) to make sure the frag's page is mapped? 
> Or it is impossible that the frag's page to be highmem and unmapped?

AFAIU these frags come from a AF_XDP umem so they should be mapped
already.

