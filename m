Return-Path: <bpf+bounces-40777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1921398E17A
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 19:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515A1B27617
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4251D14E4;
	Wed,  2 Oct 2024 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g71HNFdf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690E1D0E19;
	Wed,  2 Oct 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888555; cv=none; b=UWp0jKeoUkNb8kNVuBwex+E0UOJ4JpKSPJLexlTUcod1pitIb29A2oHSmNSbaKVzRyOrAZdL4Gdb6zaSY4vSYKKfraBaprIve8v8kNV1kcp4I5H5xPR/H367mJpJUtxsinFI1906hM9c1JOeAwIOUeCocR71dqd8rq6gI7DqvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888555; c=relaxed/simple;
	bh=2qnD3gcBe6sh/sUSe/VAfQiEfTQxar5VV5mjmhqjanY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBcw5Gm/ZAF542V7ox6ScSREt6kNxWSQVJnff+QRmTFor8/kjfT97lUIZF49AuUdVBb/oxVM1LkkvYFeIaoDjhKD5d6CII+twpBs3MWdwUfQ9QehmoBj60R4EiOhCJG8SQ2A9zI6j147BIhnOPc6oHhqciWsJOceI5iII+ZJcDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g71HNFdf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718816be6cbso69556b3a.1;
        Wed, 02 Oct 2024 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888553; x=1728493353; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j3CAetgPIchZCXGcR59D8f6NwNxq3FYMeL7IhO3SN+4=;
        b=g71HNFdfuv+bBytHj6Kde7USbYcpyUFzoRpcdFQTvBHGWprcmU6aJXsqwDLymAZroT
         U6rzrlMMc61iSjY/R4L2bI+mEs89eWrYIRW8tVVtvodi/PfkNOFsoDWsX0hq2pcBCeOq
         XfxNJGpjuyy8i8oYwAlCUJjpdk5F6KQB+EflQnJB0BQUmWVVJTNnTTHlaQwwBxE1RX+R
         tyJhTnTEfP4CQKPMTkmlNF4AfARZ0NXZzLYSgWwhhU+vS+JuG9RFfyDtKp/ssa2r//hn
         ARwu4ZUaRrYJTk96A9oUVLdS625mWljYINsTXRD7lZ6XgHzbzUDluurcdwasTQOEz0tr
         cQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888553; x=1728493353;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3CAetgPIchZCXGcR59D8f6NwNxq3FYMeL7IhO3SN+4=;
        b=nZsmyhs+joZCoq5rCYz8ZwVUxIQnMezMagqV8PtxYcgVcQZAvDWjFdFgtm7DWfJJpI
         THCdhupAebHjchKhfec/jNxHRbWlsm7NljMorwYIcB8RpBurgMreUwqT1w+tOKCVLV5J
         Do1/fPyKN5dTNzhAppNF3Ptb2Gg+okBmzJnNG3XDwZg/HyNhG+5jrZemQQspzoQCgEm8
         Jl+RzIFSD01l/XuQvADjX+oVDD/uCPSC5A8cD7ppf/foxNl2A3gd8lFgeMJg+JTPhKDl
         z9h6Em8mx9lxcceb3zOgxi4gRL/S/dLNEb5bNHKfSkMZ1wLd5b7VWEXNxzNLpqanOYGk
         kR2w==
X-Forwarded-Encrypted: i=1; AJvYcCW5GOPa6bbWq2smbLignQj6WWPyfFmf0CR5ewEuGUv6fqZrYizc9uYqX+829BcY206NLLPl73YF@vger.kernel.org, AJvYcCXnvY/xCVLX8CVgIjWqAh+VumBU48yYzMimHTw7cbZ4XX38d7M+7OaqDmbMD5aOtY6ec1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qD8YTaDkmzmdFAU6XHlZ5LCxPsX8xFSD8gjHizrQWmFf/L7k
	EJTaxbepbO5D1RSkJf3KwikdR+/z6/b1GsvfI2Up4MTvzUzB0JI=
X-Google-Smtp-Source: AGHT+IGp5S9qADB+5Pu5rzmzU8tU0hkVADw7MBH03DAjOoup+W+fr8dADId0yHouk9LY1IerDa/fzA==
X-Received: by 2002:a05:6a00:807:b0:705:a13b:e740 with SMTP id d2e1a72fcca58-71dc5d6a157mr5638461b3a.19.1727888552645;
        Wed, 02 Oct 2024 10:02:32 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26498b51sm10383673b3a.14.2024.10.02.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 10:02:32 -0700 (PDT)
Date: Wed, 2 Oct 2024 10:02:31 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Arthur Fabre <afabre@cloudflare.com>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
	john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com,
	sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, mst@redhat.com,
	jasowang@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	kernel-team <kernel-team@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
Message-ID: <Zv18pxsiTGTZSTyO@mini-arch>
References: <87wmiysi37.fsf@toke.dk>
 <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
 <87ldzds8bp.fsf@toke.dk>
 <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
 <ZvbKDT-2xqx2unrx@lore-rh-laptop>
 <871q11s91e.fsf@toke.dk>
 <ZvqQOpqnK9hBmXNn@lore-desk>
 <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby>
 <ZvwNQqN4gez1Ksfn@lore-desk>
 <87zfnnq2hs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfnnq2hs.fsf@toke.dk>

On 10/01, Toke Høiland-Jørgensen wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> 
> >> On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
> >> > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> > > 
> >> > > >> > We could combine such a registration API with your header format, so
> >> > > >> > that the registration just becomes a way of allocating one of the keys
> >> > > >> > from 0-63 (and the registry just becomes a global copy of the header).
> >> > > >> > This would basically amount to moving the "service config file" into the
> >> > > >> > kernel, since that seems to be the only common denominator we can rely
> >> > > >> > on between BPF applications (as all attempts to write a common daemon
> >> > > >> > for BPF management have shown).
> >> > > >> 
> >> > > >> That sounds reasonable. And I guess we'd have set() check the global
> >> > > >> registry to enforce that the key has been registered beforehand?
> >> > > >> 
> >> > > >> >
> >> > > >> > -Toke
> >> > > >> 
> >> > > >> Thanks for all the feedback!
> >> > > >
> >> > > > I like this 'fast' KV approach but I guess we should really evaluate its
> >> > > > impact on performances (especially for xdp) since, based on the kfunc calls
> >> > > > order in the ebpf program, we can have one or multiple memmove/memcpy for
> >> > > > each packet, right?
> >> > > 
> >> > > Yes, with Arthur's scheme, performance will be ordering dependent. Using
> >> > > a global registry for offsets would sidestep this, but have the
> >> > > synchronisation issues we discussed up-thread. So on balance, I think
> >> > > the memmove() suggestion will probably lead to the least pain.
> >> > > 
> >> > > For the HW metadata we could sidestep this by always having a fixed
> >> > > struct for it (but using the same set/get() API with reserved keys). The
> >> > > only drawback of doing that is that we statically reserve a bit of
> >> > > space, but I'm not sure that is such a big issue in practice (at least
> >> > > not until this becomes to popular that the space starts to be contended;
> >> > > but surely 256 bytes ought to be enough for everybody, right? :)).
> >> >
> >> > I am fine with the proposed approach, but I think we need to verify what is the
> >> > impact on performances (in the worst case??)
> >> 
> >> If drivers are responsible for populating the hardware metadata before
> >> XDP, we could make sure drivers set the fields in order to avoid any
> >> memove() (and maybe even provide a helper to ensure this?).
> >
> > nope, since the current APIs introduced by Stanislav are consuming NIC
> > metadata in kfuncs (mainly for af_xdp) and, according to my understanding,
> > we want to add a kfunc to store the info for each NIC metadata (e.g rx-hash,
> > timestamping, ..) into the packet (this is what Toke is proposing, right?).
> > In this case kfunc calling order makes a difference.
> > We can think even to add single kfunc to store all the info for all the NIC
> > metadata (maybe via a helping struct) but it seems not scalable to me and we
> > are losing kfunc versatility.
> 
> Yes, I agree we should have separate kfuncs for each metadata field.
> Which means it makes a lot of sense to just use the same setter API that
> we use for the user-registered metadata fields, but using reserved keys.
> So something like:
> 
> #define BPF_METADATA_HW_HASH      BIT(60)
> #define BPF_METADATA_HW_TIMESTAMP BIT(61)
> #define BPF_METADATA_HW_VLAN      BIT(62)
> #define BPF_METADATA_RESERVED (0xffff << 48)
> 
> bpf_packet_metadata_set(pkt, BPF_METADATA_HW_HASH, hash_value);
> 
> 
> As for the internal representation, we can just have the kfunc do
> something like:
> 
> int bpf_packet_metadata_set(field_id, value) {
>   switch(field_id) {
>     case BPF_METADATA_HW_HASH:
>       pkt->xdp_hw_meta.hash = value;
>       break;
>     [...]
>     default:
>       /* do the key packing thing */
>   }
> }
> 
> 
> that way the order of setting the HW fields doesn't matter, only the
> user-defined metadata.

Can you expand on why we need the flexibility of picking the metadata fields
here? Presumably we are talking about the use-cases where the XDP program
is doing redirect/pass and it doesn't really know who's the final
consumer is (might be another xdp program or might be the xdp->skb
kernel case), so the only sensible option here seems to be store everything?

