Return-Path: <bpf+bounces-63055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA32B0212D
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 18:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 431747BACBF
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AA12EF2B7;
	Fri, 11 Jul 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQe9E1DJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0982ED853;
	Fri, 11 Jul 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249884; cv=none; b=LD3Qj6X5uWlOIsRnX73yMDt2FekZbjpd6f7rWXcd9OFdUPAZayN6d/2vzwQVQHhu9xfROHHjHIw8bwb4EqFi29UPkjE5lvM5mNxjAoskbNsFjunzIqyqWoUf+j1TYL4xS7xgQ7zLQahNhN9J4m/p/HgKwn9Ty7v4BKKO7wYyLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249884; c=relaxed/simple;
	bh=I2dYXcpKkPtWDTmSTK5R5s0PMWT6R/FKdCjvABiaqUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9z27T2CkCzGaO/DhEuXHAdVYaiJe9SSPVL1LZfG+ef3oncdlwChAXV+svYsclmlCoS514wi59H5BlAYKreer/wwU5IyHkrgf6csxPC9GJUxwUOWwg1huZPBDOYqt9l/e56s9QpQ08adbZngjNq+LejSCoGmLQJ0ElsAtWTjir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQe9E1DJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23c8a5053c2so23552515ad.1;
        Fri, 11 Jul 2025 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752249882; x=1752854682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MS+ckbuk1c9/PJPIYEkMVs8xknKIT/dzRnotRzmAfwg=;
        b=TQe9E1DJezcQg4pAH6ub/OiS9D8o+wWmaPa0vO0wMbUiNs+t0xd22HRje280FBLz2t
         E2e0XEfJTp8vJhh+zQW3Z1lha8A8pMAuu7JXEU5MZmN1Pw+TGn+jytAkwf2VaHCfmc27
         cfPoGFFIr9dyvBUmRoc738//pOxbj8uhCpKBIchkmJUb0T3a52NmbYcadkW9Zp9PXUd5
         fNE8FJQtfDsJHOrE8Jova+WzgaHlzDmy4+GfFK0pmxs0TOXJrM5BJWIe3OdIwRCrhggC
         FZ9C/xwIwWLgSzYYSD1s7G7NBGCsXIgxOO1pJlU20+vWhcP733ToHxhRhkUP8j9R+4qW
         joTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249882; x=1752854682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS+ckbuk1c9/PJPIYEkMVs8xknKIT/dzRnotRzmAfwg=;
        b=ivL7/lDb4NVO2fBVE1einE9t3nZlNkr2vs1sGS3atbflSgRHohoGynqPnlG6UVVFUb
         nzL4AO9aw+DqZzt9Ya5kNvVFmZMjb8XAnNJ7OG7hHeM2OrDbdH7YFuHZmjnS8gnfRWLX
         kowxS5+7gdgCBTDo50FyfMW74pz8PB96SI3oJ4Q+SGZsYotfPwKH9avqSAr23T0Orkg8
         XSbPwRI0s5cCI3reQ9Z3irIZPRlP7zss+tyy7Fi9MsVQBDOGXkdWJHNA51PdlXfAan8Z
         G7Zus2iTK3heUGktFbI0z1b4SmOtzQAxyWryL5DaoCnRf1+h2zLHnlUjTg59LzlptES/
         kQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGKFgq5k9nGW+9vIADYG/oLBxxIkXBzvRvSZ8tyOeV/SlylCAf2KIt44vHYjrWkrozqUX+DLrt@vger.kernel.org, AJvYcCWHXjmep7IxokSMOY5/WdoP8ta6O+/GR794kIi15mJqf+BrMpP/rCZK5GPl5C2r/jp1O60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/UMqFn+DO8rpviM++2iMLJxmFqS4cvJOrAeNpq4DXhWEb9Qv
	DOMQgnUQtVpUvmV9sp3mf6Lw2wDB0kLqNGxlNgq6+ZhreM0X8o6mEckyPe7J
X-Gm-Gg: ASbGncs+gdpY8xQkaxFEIb7rFnNhsxTyZXmOJmWte7uzwC5+LqLtDS0pa4L6FB1ibUI
	Guapw0hip+hIapyVT79RQjxZQilKE650vLWHIiGJDezGKaO8j+BxY9wvrd6fucrKbz3+VzQqWW2
	BG5LuU3Xu/5LH+I4LJIrWjXnyewEN7Jz8kE/YaPW7Bc5smGQWaAbcViqEBSE+5xIfQUnq8A31+G
	8lhyX0289AfMYIssSpHb5PlV+Letnorh6038TaeSfK9aVQAQl2AVb+pj5hpkDmqaPeGUAdPyO1u
	lvOk0OwwVIxCr7xoquJpbzXZ/KT+OURbZt4dd3dEU4BGBnm+4q24WvFe9sPtqJyYNm4put9l6Pe
	a1M92cWBmwfAUsZfYQHd2DzPnYS9L7a8BAHMeXwZMSg6YLrKYVXws1kmDDMI=
X-Google-Smtp-Source: AGHT+IGnKre23WdGxuk5/d4b4IaGPXQqv/k4oOVKVaUtNA0IxIfsfNJriUKeV0j3CZwOg2u51/Lp8g==
X-Received: by 2002:a17:902:f70a:b0:235:f3b0:ae81 with SMTP id d9443c01a7336-23df08e5e30mr45436935ad.27.1752249881331;
        Fri, 11 Jul 2025 09:04:41 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4322754sm49666405ad.120.2025.07.11.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:04:40 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:04:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <aHE2F1FJlYc37eIz@mini-arch>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
 <aGVY2MQ18BWOisWa@mini-arch>
 <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
 <aGvcb53APFXR8eJb@mini-arch>
 <aG427EcHHn9yxaDv@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aG427EcHHn9yxaDv@lore-desk>

On 07/09, Lorenzo Bianconi wrote:
> On Jul 07, Stanislav Fomichev wrote:
> > On 07/03, Jesper Dangaard Brouer wrote:
> > > 
> > > 
> > > On 02/07/2025 18.05, Stanislav Fomichev wrote:
> > > > On 07/02, Jesper Dangaard Brouer wrote:
> > > > > This patch series introduces a mechanism for an XDP program to store RX
> > > > > metadata hints - specifically rx_hash, rx_vlan_tag, and rx_timestamp -
> > > > > into the xdp_frame. These stored hints are then used to populate the
> > > > > corresponding fields in the SKB that is created from the xdp_frame
> > > > > following an XDP_REDIRECT.
> > > > > 
> > > > > The chosen RX metadata hints intentionally map to the existing NIC
> > > > > hardware metadata that can be read via kfuncs [1]. While this design
> > > > > allows a BPF program to read and propagate existing hardware hints, our
> > > > > primary motivation is to enable setting custom values. This is important
> > > > > for use cases where the hardware-provided information is insufficient or
> > > > > needs to be calculated based on packet contents unavailable to the
> > > > > hardware.
> > > > > 
> > > > > The primary motivation for this feature is to enable scalable load
> > > > > balancing of encapsulated tunnel traffic at the XDP layer. When tunnelled
> > > > > packets (e.g., IPsec, GRE) are redirected via cpumap or to a veth device,
> > > > > the networking stack later calculates a software hash based on the outer
> > > > > headers. For a single tunnel, these outer headers are often identical,
> > > > > causing all packets to be assigned the same hash. This collapses all
> > > > > traffic onto a single RX queue, creating a performance bottleneck and
> > > > > defeating receive-side scaling (RSS).
> > > > > 
> > > > > Our immediate use case involves load balancing IPsec traffic. For such
> > > > > tunnelled traffic, any hardware-provided RX hash is calculated on the
> > > > > outer headers and is therefore incorrect for distributing inner flows.
> > > > > There is no reason to read the existing value, as it must be recalculated.
> > > > > In our XDP program, we perform a partial decryption to access the inner
> > > > > headers and calculate a new load-balancing hash, which provides better
> > > > > flow distribution. However, without this patch set, there is no way to
> > > > > persist this new hash for the network stack to use post-redirect.
> > > > > 
> > > > > This series solves the problem by introducing new BPF kfuncs that allow an
> > > > > XDP program to write e.g. the hash value into the xdp_frame. The
> > > > > __xdp_build_skb_from_frame() function is modified to use this stored value
> > > > > to set skb->hash on the newly created SKB. As a result, the veth driver's
> > > > > queue selection logic uses the BPF-supplied hash, achieving proper
> > > > > traffic distribution across multiple CPU cores. This also ensures that
> > > > > consumers, like the GRO engine, can operate effectively.
> > > > > 
> > > > > We considered XDP traits as an alternative to adding static members to
> > > > > struct xdp_frame. Given the immediate need for this functionality and the
> > > > > current development status of traits, we believe this approach is a
> > > > > pragmatic solution. We are open to migrating to a traits-based
> > > > > implementation if and when they become a generally accepted mechanism for
> > > > > such extensions.
> > > > > 
> > > > > [1] https://docs.kernel.org/networking/xdp-rx-metadata.html
> > > > > ---
> > > > > V1: https://lore.kernel.org/all/174897271826.1677018.9096866882347745168.stgit@firesoul/
> > > > 
> > > > No change log?
> > > 
> > > We have fixed selftest as requested by Alexie.
> > > And we have updated cover-letter and doc as you Stanislav requested.
> > > 
> > > > 
> > > > Btw, any feedback on the following from v1?
> > > > - https://lore.kernel.org/netdev/aFHUd98juIU4Rr9J@mini-arch/
> > > 
> > > Addressed as updated cover-letter and documentation. I hope this helps
> > > reviewers understand the use-case, as the discussion turn into "how do we
> > > transfer all HW metadata", which is NOT what we want (and a waste of
> > > precious cycles).
> > > 
> > > For our use-case, it doesn't make sense to "transfer all HW metadata".
> > > In fact we don't even want to read the hardware RH-hash, because we already
> > > know it is wrong (for tunnels), we just want to override the RX-hash used at
> > > SKB creation.  We do want the BPF programmers flexibility to call these
> > > kfuncs individually (when relevant).
> > > 
> > > > - https://lore.kernel.org/netdev/20250616145523.63bd2577@kernel.org/
> > > 
> > > I feel pressured into critiquing Jakub's suggestion, hope this is not too
> > > harsh.  First of all it is not relevant to our this patchset use-case, as it
> > > focus on all HW metadata.
> > 
> > [..]
> > 
> > > Second, I disagree with the idea/mental model of storing in a
> > > "driver-specific format". The current implementation of driver-specific
> > > kfunc helpers that "get the metadata" is already doing a conversion to a
> > > common format, because the BPF-programmer naturally needs this to be the
> > > same across drivers.  Thus, it doesn't make sense to store it back in a
> > > "driver-specific format", as that just complicate things.  My mental model
> > > is thus, that after the driver-specific "get" operation to result is in a
> > > common format, that is simply defined by the struct type of the kfunc, which
> > > is both known by the kernel and BPF-prog.
> > 
> > Having get/set model seems a bit more generic, no? Potentially giving us the
> > ability to "correct" HW metadata for the non-redirected cases as well.
> > Plus we don't hard-code the (internal) layout. Solving only xdp_redirect
> > seems a bit too narrow, idk..
> 
> I can't see what the non-redirected use-case could be. Can you please provide
> more details?
> Moreover, can it be solved without storing the rx_hash (or the other
> hw-metadata) in a non-driver specific format?

Having setters feels more generic than narrowly solving only the redirect,
but I don't have a good use-case in mind.

> Storing the hw-metadata in some of hw-specific format in xdp_frame will not
> allow to consume them directly building the skb and we will require to decode
> them again. What is the upside/use-case of this approach? (not considering the
> orthogonality with the get method).

If we add the store kfuncs to regular drivers, the metadata  won't be stored
in the xdp_frame; it will go into the rx descriptors so regular path that
builds skbs will use it.

