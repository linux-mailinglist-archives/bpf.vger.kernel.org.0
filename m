Return-Path: <bpf+bounces-40376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A32A0987CAA
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 03:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD6B1F23E9F
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 01:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C59414B94A;
	Fri, 27 Sep 2024 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSZK14v4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E914A09E;
	Fri, 27 Sep 2024 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401392; cv=none; b=Oe0T0lCHWzgbjRmMK08rA6Sh4YTG6VA0V1/JlrxRDHsui/D335LpuMJoEcR1jXqpnVw4BZKiyWK0lpa/0QAvRzOtCgy8csXeND36ijT9kyW3tUOGTXfh+2THRJz/DQIQIr7POmzrU+jTgErqpfCPmip758LFdrqiQnnk67y/1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401392; c=relaxed/simple;
	bh=vO+LHsJGtoPwPjSq3QNJ7PtmP50p+WXR2S0ccd9+was=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFUoV3iS7OS1I9D7HfQI3+lAWdwd+O7S7LY/A3jHMhJYegvUhmm1J1eRDa9NG+zdtH2FiBWqtNUpfnN2eVZxhwfJAVbMv4PNiRibb2PjBXjyZKwfFfcJf95vShtsgKkWKepOpLG0fpM/G7nqUFDh+Y49NFctv9Avt21h3X2GgWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSZK14v4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so914607a12.0;
        Thu, 26 Sep 2024 18:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727401390; x=1728006190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q653sQOlcSyRs9hPuoG+zXvugHIxRtEH110Wy2TqD8I=;
        b=mSZK14v4sVVeEvbhjyCwrHjsHfd5scnhadKLCgKuZRiRJOt+PzJuU8/d4NpTJ1S0Em
         WvDkU2TdPn1+hylXfuFXTgGZ3x9xAkjU0PuUXYQM8dIiXRn6NjqgBGB2mr4zVDSX61nL
         w328AFQpzPPAtavsvg5MLc1MjhBStdTH9TEhMgBXzPqJh3V19u4WSwV8TBeeHGE0uBdm
         jWcuJ51t8LWijUoZnoKTSICE2YIVpi87vD8GS9rg6bHD70m3OvymYsVtANlNvvPFkKbs
         XNEktdkjFk9EU8dRk4VP7E04p5X5GTJ0BeleBXLJTmZo9GIwUGGTsQTedYvZEw/UUKGk
         HMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727401390; x=1728006190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q653sQOlcSyRs9hPuoG+zXvugHIxRtEH110Wy2TqD8I=;
        b=ZEgbNHg687g2rRkfAQHMktSpm+WsI+XtNFm8c4R7c3N27cb/DkkT5fL3RZo8npungu
         73wtF2uVBkR4nM5mk98WWZgebfifZUfYgpVCJ4vHOVdwjy2yJwqNgzOSsBhCesZFMVdJ
         JniEUpcJPcq/+4Zo0s5oWU92tmo7o8/cvX8fVA0KrO271J0G+L899n2LGd45NwD9duiK
         4VOInR4zM7qL8dW4mapsG40HbTT3YvHNOeKhqIJXib+EzwFhiX/w8mB8aVBB2RX4MJxT
         b0dAEUKfxeOOh+BIM7vBZskh2VNehJmCQR1a1E/i/WpEVarqbrglaQvqhsdg9Py3HiY7
         eFDg==
X-Forwarded-Encrypted: i=1; AJvYcCWm0bm1Ub4sxsFl2R6QS/e2mOpS6lao4urUw3B+hJv1vkmtmXwXhZrZc/EqLiBZxrFFF9rjQGss@vger.kernel.org, AJvYcCXmwatrfqqtOgHFCqdckH8myrZyjn3p0hI27VDSH6PWVrn8uwW63slQISBdPjLMi9PIrjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1rSmgo7+p1HGPbwOhj7bGrg0CtY/TZxDLNAUv+ESwVYl8qAQ
	62k99PJN2TCzVLyF+MWd0YfVNpH6EmZ2fmvGWy8EVGuxgFq/EAY=
X-Google-Smtp-Source: AGHT+IGk0A4RXFQ/svtxe8Nnc5iMxuLjkwJyk+b8Okdd8PJts4jl3XgDUgU/jpUwuW/i3drWNQgrpg==
X-Received: by 2002:a05:6a21:33a6:b0:1cf:3f39:c469 with SMTP id adf61e73a8af0-1d4ebe2733bmr8274266637.2.1727401390353;
        Thu, 26 Sep 2024 18:43:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db612f6fsm542081a12.86.2024.09.26.18.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 18:43:09 -0700 (PDT)
Date: Thu, 26 Sep 2024 18:43:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Arthur Fabre <afabre@cloudflare.com>,
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
Message-ID: <ZvYNranHf9X5ZjK-@mini-arch>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk>
 <87ldzkndqk.fsf@toke.dk>
 <ZvA6hIl6XWJ4UEJW@lore-desk>
 <874j62u1lb.fsf@toke.dk>
 <ZvV2WLUa1KB8qu3L@lore-rh-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvV2WLUa1KB8qu3L@lore-rh-laptop>

On 09/26, Lorenzo Bianconi wrote:
> > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
> > 
> > >> I'm hinting at some complications here (with the EFAULT return) that
> > >> needs to be resolved: there is no guarantee that a given packet will be
> > >> in sync with the current status of the registered metadata, so we need
> > >> explicit checks for this. If metadata entries are de-registered again
> > >> this also means dealing with holes and/or reshuffling the metadata
> > >> layout to reuse the released space (incidentally, this is the one place
> > >> where a TLV format would have advantages).
> > >
> > > I like this approach but it seems to me more suitable for 'sw' metadata
> > > (this is main Arthur and Jakub use case iiuc) where the userspace would
> > > enable/disable these functionalities system-wide.
> > > Regarding device hw metadata (e.g. checksum offload) I can see some issues
> > > since on a system we can have multiple NICs with different capabilities.
> > > If we consider current codebase, stmmac driver supports only rx timestamp,
> > > while mlx5 supports all of them. In a theoretical system with these two
> > > NICs, since pkt_metadata_registry is global system-wide, we will end-up
> > > with quite a lot of holes for the stmmac, right? (I am not sure if this
> > > case is relevant or not). In other words, we will end-up with a fixed
> > > struct for device rx hw metadata (like xdp_rx_meta). So I am wondering
> > > if we really need all this complexity for xdp rx hw metadata?
> > 
> > Well, the "holes" will be there anyway (in your static struct approach).
> > They would just correspond to parts of the "struct xdp_rx_meta" being
> > unset.
> 
> yes, what I wanted to say is I have the feeling we will end up 90% of the
> times in the same fields architecture and the cases where we can save some
> space seem very limited. Anyway, I am fine to discuss about a common
> architecture.
> 
> > 
> > What the "userspace can turn off the fields system wide" would
> > accomplish is to *avoid* the holes if you know that you will never need
> > them. E.g., say a system administrator know that they have no networks
> > that use (offloaded) VLANs. They could then disable the vlan offload
> > field system-wide, and thus reclaim the four bytes taken up by the
> > "vlan" member of struct xdp_rx_meta, freeing that up for use by
> > application metadata.
> 
> Even if I like the idea of having a common approach for this kernel feature,
> hw metadata seems to me quite a corner case with respect of 'user-defined
> metadata', since:
> - I do not think it is a common scenario to disable hw offload capabilities
>   (e.g checksum offload in production)
> - I guess it is not just enough to disable them via bpf, but the user/sysadmin
>   will need even to configure the NIC via ethtool (so a 2-steps process).
> 
> I think we should pay attention to not overcomplicate something that is 99%
> enabled and just need to be fast. E.g I can see an issue of putting the hw rx
> metadata in metadata field since metadata grows backward and we will probably
> end up putting them in a different cacheline with respect to xdp_frame
> (xdp_headroom is usually 256B).
> 
> > 
> > However, it may well be that the complexity of allowing fields to be
> > turned off is not worth the gains. At least as long as there are only
> > the couple of HW metadata fields that we have currently. Having the
> > flexibility to change our minds later would be good, though, which is
> > mostly a matter of making the API exposed to BPF and/or userspace
> > flexible enough to allow us to move things around in memory in the
> > future. Which was basically my thought with the API I sketched out in
> > the previous email. I.e., you could go:
> > 
> > ret = bpf_get_packet_metadata_field(pkt, METADATA_ID_HW_HASH,
> >                                     &my_hash_vlaue, sizeof(u32))
> 
> yes, my plan is to add dedicated bpf kfuncs to store hw metadata in
> xdp_frame/xdp_buff
> 
> > 
> > 
> > ...and the METADATA_ID_HW_HASH would be a constant defined by the
> > kernel, for which the bpf_get_packet_metadata_field() kfunc just has a
> > hardcoded lookup into struct xdp_rx_meta. And then, if we decide to move
> > the field in the future, we just change the kfunc implementation, with
> > no impact to the BPF programs calling it.
> > 
> 
> maybe we can use what we Stanislav have already added (maybe removing xdp
> prefix):
> 
> enum xdp_rx_metadata {
> 	XDP_METADATA_KFUNC_RX_TIMESTAMP,
> 	XDP_METADATA_KFUNC_RX_HASH,
> 	XDP_METADATA_KFUNC_RX_VLAN_TAG
> };

I think it was one of the ideas floating around back then for the
xdp->skb case (including redirection): have an extra kfunc that the bpf
program can call and make this kfunc store the metadata (in the metadata area)
in some fixed format. Then the kernel can consume it.

