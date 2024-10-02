Return-Path: <bpf+bounces-40799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC598E645
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 00:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2572815BB
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 22:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFB819ABD1;
	Wed,  2 Oct 2024 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKNEXWOK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5397DDD2;
	Wed,  2 Oct 2024 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909352; cv=none; b=a18BaE7DhSv3oLwlwjjPEOiaxW9xPQZ8EdJDdMEayETvspF1cYlEd+VnwaTA3Eg41rFFEFQheJZW37EmqQcBepcWWlq5p7m0PAd/yNssqX9pu0R0TrewqbduMjYfejEU/3H6BwlUpKf+MdR6SDNtc4UUVfVDWWSMK4NhiigZbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909352; c=relaxed/simple;
	bh=0njY4Mh8CsAOEu2AtUQvLKSCiJQGignTfsfSAJlVnog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOgh7xEGfZjab8k7ktm7qQXznzlvMJMYyMMQG1QcHQ7WZ5nlIU+8uc5TXADFXfKuAtDJypML4S9wR0iW3WwamBkVa8D1iQRQzXLYZ3grV6qcEHCw3FohOH96CjWi8FTXiY5+xkofCT6qsQ/bMdJTA/BYzWzyG0EC2Fd2z23GmXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKNEXWOK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so360363b3a.0;
        Wed, 02 Oct 2024 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727909350; x=1728514150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UXDXvRFM94w5MqJowhi1d6zXnKyNcEoMXW98gFOO60M=;
        b=VKNEXWOKncRrt+iPMxR9/Scz6wvEIKCNREZzRE9+ekTcgVRl97yexfoQh3JdLQ/gkL
         oR5QSQUoH3c5EbtMC/k+q25NFXvPyJfT8uOqple6ayDhjvMrZbno2Ez5LfQq/ctHavd+
         n99ejoha2ayhPOiTpM0FdXaJsL0WpFT3+TGL3Vejk0Ul7H1YIg2LVx7uWEvCQAgG2g/9
         SxAYVZoz+7IiezzOzZ25Ywx1y5X5neH6+0DwGhOSEIQai8psDd+Y4n+7SuRxEnHwbQpx
         5cQ71jUlDd0UU67D50azQiooiixwwkTU1KRtsJFYR6VYFso3tJmu2cxvI8w8OaIJztXJ
         Iuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727909350; x=1728514150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXDXvRFM94w5MqJowhi1d6zXnKyNcEoMXW98gFOO60M=;
        b=vnBTkCXfMx3xPwTlZY7USfZERchCwaC65OWLgfsjuSHTAkJ0JcVD27e4JmpxFrCkQ6
         YRyFG3zfVoI34QKGCwhvPAyAn84Xbb1RG2bt4EXIPkCbLbCTaS0eGLSLNybGI46SdOuj
         UJAd4xrQypjMNihzLDIYB7OV/gag0YQ6skIDE2dEamQbCg0FOV/FD5yvvYfl53BA90de
         ZdIx9PM2y3zza0FOXYyXpf91bJjt31SVstLdTC8h22WYdq4Uwp/TyEtsVTmLuzfGZd75
         aR37rTIfH66EY3jjgiMeWxWgQORHvWmTXP4YHzVYsGzPSpI1ijw5HmLi5Kampl1l0JNb
         0Y7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCXJt3EEOUgz5IeEAY7wfcDqE8taqzt3IMeTENNLfgnXz3gxzPpipZUDgPr+vunVdk1YQWLSrM@vger.kernel.org, AJvYcCUeB/37+6xry+4SN1k36BBnP8iD2S/M1oFTlOK5kY7U1qeMOnVa3nqw6Zkld3UIuz4Y6pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1lZGzcNscO719oZkAkDMDTlXNvEcaJ8PQwOI4AVZ0nxImttS
	FqoIEEcuP2VABBxQpfMMytwI3ZkYI5O0nOjt/wUGYnL3bjyrWFA=
X-Google-Smtp-Source: AGHT+IGqdAUUCQdaLu4NF4SkJSuSWlMoYFhXa+Il8GmNxRyqFcCKtXv5enFt8b6pCjXYAmmMTsruKw==
X-Received: by 2002:a05:6a20:c704:b0:1cf:2b8c:b5e0 with SMTP id adf61e73a8af0-1d5e2cb12famr6561148637.37.1727909349731;
        Wed, 02 Oct 2024 15:49:09 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265249b7sm10741652b3a.148.2024.10.02.15.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:49:09 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:49:08 -0700
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
Message-ID: <Zv3N5G8swr100EXm@mini-arch>
References: <87ldzds8bp.fsf@toke.dk>
 <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
 <ZvbKDT-2xqx2unrx@lore-rh-laptop>
 <871q11s91e.fsf@toke.dk>
 <ZvqQOpqnK9hBmXNn@lore-desk>
 <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby>
 <ZvwNQqN4gez1Ksfn@lore-desk>
 <87zfnnq2hs.fsf@toke.dk>
 <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttdunydz.fsf@toke.dk>

On 10/02, Toke Høiland-Jørgensen wrote:
> Stanislav Fomichev <stfomichev@gmail.com> writes:
> 
> > On 10/01, Toke Høiland-Jørgensen wrote:
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> 
> >> >> On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
> >> >> > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> >> > > 
> >> >> > > >> > We could combine such a registration API with your header format, so
> >> >> > > >> > that the registration just becomes a way of allocating one of the keys
> >> >> > > >> > from 0-63 (and the registry just becomes a global copy of the header).
> >> >> > > >> > This would basically amount to moving the "service config file" into the
> >> >> > > >> > kernel, since that seems to be the only common denominator we can rely
> >> >> > > >> > on between BPF applications (as all attempts to write a common daemon
> >> >> > > >> > for BPF management have shown).
> >> >> > > >> 
> >> >> > > >> That sounds reasonable. And I guess we'd have set() check the global
> >> >> > > >> registry to enforce that the key has been registered beforehand?
> >> >> > > >> 
> >> >> > > >> >
> >> >> > > >> > -Toke
> >> >> > > >> 
> >> >> > > >> Thanks for all the feedback!
> >> >> > > >
> >> >> > > > I like this 'fast' KV approach but I guess we should really evaluate its
> >> >> > > > impact on performances (especially for xdp) since, based on the kfunc calls
> >> >> > > > order in the ebpf program, we can have one or multiple memmove/memcpy for
> >> >> > > > each packet, right?
> >> >> > > 
> >> >> > > Yes, with Arthur's scheme, performance will be ordering dependent. Using
> >> >> > > a global registry for offsets would sidestep this, but have the
> >> >> > > synchronisation issues we discussed up-thread. So on balance, I think
> >> >> > > the memmove() suggestion will probably lead to the least pain.
> >> >> > > 
> >> >> > > For the HW metadata we could sidestep this by always having a fixed
> >> >> > > struct for it (but using the same set/get() API with reserved keys). The
> >> >> > > only drawback of doing that is that we statically reserve a bit of
> >> >> > > space, but I'm not sure that is such a big issue in practice (at least
> >> >> > > not until this becomes to popular that the space starts to be contended;
> >> >> > > but surely 256 bytes ought to be enough for everybody, right? :)).
> >> >> >
> >> >> > I am fine with the proposed approach, but I think we need to verify what is the
> >> >> > impact on performances (in the worst case??)
> >> >> 
> >> >> If drivers are responsible for populating the hardware metadata before
> >> >> XDP, we could make sure drivers set the fields in order to avoid any
> >> >> memove() (and maybe even provide a helper to ensure this?).
> >> >
> >> > nope, since the current APIs introduced by Stanislav are consuming NIC
> >> > metadata in kfuncs (mainly for af_xdp) and, according to my understanding,
> >> > we want to add a kfunc to store the info for each NIC metadata (e.g rx-hash,
> >> > timestamping, ..) into the packet (this is what Toke is proposing, right?).
> >> > In this case kfunc calling order makes a difference.
> >> > We can think even to add single kfunc to store all the info for all the NIC
> >> > metadata (maybe via a helping struct) but it seems not scalable to me and we
> >> > are losing kfunc versatility.
> >> 
> >> Yes, I agree we should have separate kfuncs for each metadata field.
> >> Which means it makes a lot of sense to just use the same setter API that
> >> we use for the user-registered metadata fields, but using reserved keys.
> >> So something like:
> >> 
> >> #define BPF_METADATA_HW_HASH      BIT(60)
> >> #define BPF_METADATA_HW_TIMESTAMP BIT(61)
> >> #define BPF_METADATA_HW_VLAN      BIT(62)
> >> #define BPF_METADATA_RESERVED (0xffff << 48)
> >> 
> >> bpf_packet_metadata_set(pkt, BPF_METADATA_HW_HASH, hash_value);
> >> 
> >> 
> >> As for the internal representation, we can just have the kfunc do
> >> something like:
> >> 
> >> int bpf_packet_metadata_set(field_id, value) {
> >>   switch(field_id) {
> >>     case BPF_METADATA_HW_HASH:
> >>       pkt->xdp_hw_meta.hash = value;
> >>       break;
> >>     [...]
> >>     default:
> >>       /* do the key packing thing */
> >>   }
> >> }
> >> 
> >> 
> >> that way the order of setting the HW fields doesn't matter, only the
> >> user-defined metadata.
> >
> > Can you expand on why we need the flexibility of picking the metadata fields
> > here? Presumably we are talking about the use-cases where the XDP program
> > is doing redirect/pass and it doesn't really know who's the final
> > consumer is (might be another xdp program or might be the xdp->skb
> > kernel case), so the only sensible option here seems to be store everything?
> 
> For the same reason that we have separate kfuncs for each metadata field
> when getting it from the driver: XDP programs should have the
> flexibility to decide which pieces of metadata they need, and skip the
> overhead of stuff that is not needed.
> 
> For instance, say an XDP program knows that nothing in the system uses
> timestamps; in that case, it can skip both the getter and the setter
> call for timestamps.

But doesn't it put us in the same place? Where the first (native) xdp program
needs to know which metadata the final consumer wants. At this point
why not propagate metadata layout as well?

(or maybe I'm still missing what exact use-case we are trying to solve)

> I suppose we *could* support just a single call to set the skb meta,
> like:
> 
> bpf_set_skb_meta(struct xdp_md *pkt, struct xdp_hw_meta *data);
> 
> ...but in that case, we'd need to support some fields being unset
> anyway, and the program would have to populate the struct on the stack
> before performing the call. So it seems simpler to just have symmetry
> between the get (from HW) and set side? :)

Why not simply bpf_set_skb_meta(struct xdp_md *pkt) and let it store
the metadata somewhere in xdp_md directly? (also presumably by
reusing most of the existing kfuncs/xmo_xxx helpers)

