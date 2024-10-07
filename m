Return-Path: <bpf+bounces-41153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312CC99368D
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 20:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88451F23834
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 18:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BC51DDC0D;
	Mon,  7 Oct 2024 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gau3tt7I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A09320F;
	Mon,  7 Oct 2024 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326916; cv=none; b=nA9+TuL/2g4C4N3axkzF9ceqRR0gEy6op4LkNWuabjFjSv5MgOpsZs/MK5HMgWUBdhh1u9X9RZoHBLZSAgLn8WjRYwaTulgGCHPnkVIB2sY8CCiVjZCORN8ufp+mRsgPIDTXsdTzbpcqevzg9lG0rtEeWVL/xdiRxpmqwZakHvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326916; c=relaxed/simple;
	bh=2JRdkrq7ibC3AxPdWBaT0qkhzD1BlGvDutrusNteXmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ3jaVjN2kFfhSb7ruOY2+fmQ0qMw2IXaYoaTwnv/VQRIX0NwoVMyP3Up5q/Lls+Up6WEMQ9ww/fJAPMAp/ZWKzdTM642sLFxbKwIIKkVhPdQoWiGe79XQLJExI4PcnBeagR8fLp/e8r4p+afbEedAGCzWFqWNG/3NOSsqsBZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gau3tt7I; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e3b79b4858so2704413b6e.2;
        Mon, 07 Oct 2024 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728326913; x=1728931713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DxIo6SBDZQXc37oWyxERlpu6l1Wa+ULpd6grGxBigoc=;
        b=Gau3tt7IM5pHUxf37EnGP/Tk8m67cPPopn4OWYga5z2EIgZAVYqgdff/klB0DyqLQ0
         otmb9mXzPFITCoWBQT20vGz+ejzazYa51hvxyLmnaxoWBZ3flLYYPYoALaLqZRMb9YNo
         i3basQYLw6wtsLswhd8t97QspPhDi4UP4+Dl2M9w4CCYkNMeoCEkI//im5Sog76Vqp+l
         1Ymazo/sW5+HQuX1ubT79SAtIQG8sOUKFvsoOZbFqhtQBqMGQq+aJCux7tjErF+vvrC8
         +tEAr7LFxA2bp6GZgwBWf86FKj/oY3xUxPc9be63OJV6RXAQfq0XDCAKhf9sVa5r8nKA
         zkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326913; x=1728931713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxIo6SBDZQXc37oWyxERlpu6l1Wa+ULpd6grGxBigoc=;
        b=qQiArVy7SFAPCYAqrixZTkscfwcoucdedSYZSIpb0BdLml8Fzf7EHGdCXZfd3zIiY/
         5F3s8Ve/5GDGAFj4NAY8TxPH0ONs2U69VTazW9gzTxvmjan+hPDLbA/9ER6p5dBwv6dx
         LeiRODbWocMAuO3uD5qQDABJn0HxyPVaPDqmzgVVGNb2rEx3YBI562gfNyjb+Wv9tjfj
         XF3lyZ97IAeKM5otAGsv+MC3VFB6SIoRi1QAoIfaplXVKAJIV/+D0T0BdVhMAdo15pNI
         zEsH3kVQQ0WvRK15cUhT4+Ov0vpEGovCc+RY+1xgwbftGFAQXdS3XeV1OZsvuIk77jgf
         rXFw==
X-Forwarded-Encrypted: i=1; AJvYcCUB2wl8I0Ox3LGEnGFTD5pORfsP5KrADlroeZH3ZC+EB1VbmpxgCosEZ0rJNt9qr8c1SJA=@vger.kernel.org, AJvYcCXIn44juVAkBqsaOZW4oy+rgKA6O9CY2EPXBb5Mq9ziw2VSc6iko9w8x+SDki7pOX1FmKXEsIVz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4nt/fI+QVSX2Q6rhjK5Mr8hzZS/LjVJL4jGILuA+A3kwxCB7k
	rs+4Rbkz5bzXw4egtrJWfhXFX8oX/qACy+bFaQGRITr1KwBbEmc=
X-Google-Smtp-Source: AGHT+IHidoJ5KUJ6/hc4eJOnHC4cWCklIOkHi42bJtWHz6oCLeuYegsjuUpsou49IAVpUwzcvXsFXg==
X-Received: by 2002:a05:6808:2e86:b0:3e0:7005:3f86 with SMTP id 5614622812f47-3e3c15345a3mr10727871b6e.28.1728326913536;
        Mon, 07 Oct 2024 11:48:33 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4a65esm5253615a12.94.2024.10.07.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:48:33 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:48:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
	Arthur Fabre <afabre@cloudflare.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
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
Message-ID: <ZwQtAHpg2LB-7en_@mini-arch>
References: <87zfnnq2hs.fsf@toke.dk>
 <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk>
 <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby>
 <Zv794Ot-kOq1pguM@mini-arch>
 <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
 <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>
 <ZwArrsqrYx7IM5tq@mini-arch>
 <87ldz1edaz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldz1edaz.fsf@toke.dk>

On 10/06, Toke Høiland-Jørgensen wrote:
> Stanislav Fomichev <stfomichev@gmail.com> writes:
> 
> > On 10/04, Jesper Dangaard Brouer wrote:
> >> 
> >> 
> >> On 04/10/2024 04.13, Daniel Xu wrote:
> >> > On Thu, Oct 03, 2024 at 01:26:08PM GMT, Stanislav Fomichev wrote:
> >> > > On 10/03, Arthur Fabre wrote:
> >> > > > On Thu Oct 3, 2024 at 12:49 AM CEST, Stanislav Fomichev wrote:
> >> > > > > On 10/02, Toke Høiland-Jørgensen wrote:
> >> > > > > > Stanislav Fomichev <stfomichev@gmail.com> writes:
> >> > > > > > 
> >> > > > > > > On 10/01, Toke Høiland-Jørgensen wrote:
> >> > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> > > > > > > > 
> >> > > > > > > > > > On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
> >> > > > > > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> > > > > > > > > > > > 
> >> [...]
> >> > > > > > > > > > > > > 
> >> > > > > > > > > > > > > I like this 'fast' KV approach but I guess we should really evaluate its
> >> > > > > > > > > > > > > impact on performances (especially for xdp) since, based on the kfunc calls
> >> > > > > > > > > > > > > order in the ebpf program, we can have one or multiple memmove/memcpy for
> >> > > > > > > > > > > > > each packet, right?
> >> > > > > > > > > > > > 
> >> > > > > > > > > > > > Yes, with Arthur's scheme, performance will be ordering dependent. Using
> >> 
> >> I really like the *compact* Key-Value (KV) store idea from Arthur.
> >>  - The question is it is fast enough?
> >> 
> >> I've promised Arthur to XDP micro-benchmark this, if he codes this up to
> >> be usable in the XDP code path.  Listening to the LPC recording I heard
> >> that Alexei also saw potential and other use-case for this kind of
> >> fast-and-compact KV approach.
> >> 
> >> I have high hopes for the performance, as Arthur uses POPCNT instruction
> >> which is *very* fast[1]. I checked[2] AMD Zen 3 and 4 have Ops/Latency=1
> >> and Reciprocal throughput 0.25.
> >> 
> >>  [1] https://www.agner.org/optimize/blog/read.php?i=853#848
> >>  [2] https://www.agner.org/optimize/instruction_tables.pdf
> >> 
> >> [...]
> >> > > > There are two different use-cases for the metadata:
> >> > > > 
> >> > > > * "Hardware" metadata (like the hash, rx_timestamp...). There are only a
> >> > > >    few well known fields, and only XDP can access them to set them as
> >> > > >    metadata, so storing them in a struct somewhere could make sense.
> >> > > > 
> >> > > > * Arbitrary metadata used by services. Eg a TC filter could set a field
> >> > > >    describing which service a packet is for, and that could be reused for
> >> > > >    iptables, routing, socket dispatch...
> >> > > >    Similarly we could set a "packet_id" field that uniquely identifies a
> >> > > >    packet so we can trace it throughout the network stack (through
> >> > > >    clones, encap, decap, userspace services...).
> >> > > >    The skb->mark, but with more room, and better support for sharing it.
> >> > > > 
> >> > > > We can only know the layout ahead of time for the first one. And they're
> >> > > > similar enough in their requirements (need to be stored somewhere in the
> >> > > > SKB, have a way of retrieving each one individually, that it seems to
> >> > > > make sense to use a common API).
> >> > > 
> >> > > Why not have the following layout then?
> >> > > 
> >> > > +---------------+-------------------+----------------------------------------+------+
> >> > > | more headroom | user-defined meta | hw-meta (potentially fixed skb format) | data |
> >> > > +---------------+-------------------+----------------------------------------+------+
> >> > >                  ^                                                            ^
> >> > >              data_meta                                                      data
> >> > > 
> >> > > You obviously still have a problem of communicating the layout if you
> >> > > have some redirects in between, but you, in theory still have this
> >> > > problem with user-defined metadata anyway (unless I'm missing
> >> > > something).
> >> > > 
> >> 
> >> Hmm, I think you are missing something... As far as I'm concerned we are
> >> discussing placing the KV data after the xdp_frame, and not in the XDP
> >> data_meta area (as your drawing suggests).  The xdp_frame is stored at
> >> the very top of the headroom.  Lorenzo's patchset is extending struct
> >> xdp_frame and now we are discussing to we can make a more flexible API
> >> for extending this. I understand that Toke confirmed this here [3].  Let
> >> me know if I missed something :-)
> >> 
> >>  [3] https://lore.kernel.org/all/874j62u1lb.fsf@toke.dk/
> >>
> >> As part of designing this flexible API, we/Toke are trying hard not to
> >> tie this to a specific data area.  This is a good API design, keeping it
> >> flexible enough that we can move things around should the need arise.
> >> 
> >> I don't think it is viable to store this KV data in XDP data_meta area,
> >> because existing BPF-prog's already have direct memory (write) access
> >> and can change size of area, which creates too much headache with
> >> (existing) BPF-progs creating unintentional breakage for the KV store,
> >> which would then need extensive checks to handle random corruptions
> >> (slowing down KV-store code).
> >
> > Yes, I'm definitely missing the bigger picture. If we want to have a global
> > metadata registry in the kernel, why can't it be built on top of the existing
> > area?
> 
> Because we have no way of preventing existing XDP programs from
> overwriting (corrupting) the area using the xdp_adjust_meta() API and
> data_meta field.

True, but this can be solved with some new BPF_F_XDP_HAS_FRAGS-like
flag (which can reject loading if there is some incompatibility)?
Even in the new KV-metadata world, 2+ programs still need to be
aware of the new method to work correctly. But I do see your point
that it's better to not apply any metadata than apply something
that's corrupt/overridden.

> But in a sense the *memory area* is shared between the two APIs, in the
> sense that they both use the headroom before the packet data, just from
> opposite ends. So if you store lots of data using the new KV API, that
> space will no longer be available for xdp_adjust_{head,meta}. But the
> kernel can enforce this so we don't get programs corrupting the KV
> format.

Ack, let's see how it shapes out. My main concern comes from the
growing api surface where for af_xdp it's one mechanism, for xdp
redirect it's another. And for Jakub's consumption from userspace
it's gonna be another special case probably (to read it out from the
headroom head)? Idk, maybe it's fine as long as each case is clearly
documented.

