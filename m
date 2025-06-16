Return-Path: <bpf+bounces-60733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E5ADB590
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3194C3A55F3
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E377F25A2A1;
	Mon, 16 Jun 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag+Aokia"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0157A25776;
	Mon, 16 Jun 2025 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088075; cv=none; b=PuOE9dGwdTXTxNb6h3wuPuXNWs571jmyWHtmXMA1fEh7J99qzlKruG4Qvk5kMpnnz51OpifCwbgb1nOmi/I0MyIHt1/7jhjGBud4EKc7ZmYKuwVIvlAKk8W+KouNzKld5CBPLJWAdk/JFca90aYT5eo5vloKQyFO/TKKk5D/Oc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088075; c=relaxed/simple;
	bh=Roc/+u+IkE7Q/xAYmeLJ1DDHWaYWNZjbcDtX7zEACb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkAGDzo12r5qW4tUw+aQHAdiyAC/If/iqaGFoXJpnCtvB6Nkxmh0xakDEPxU6bJWaJh4cQgblmN9u6V7kZzHPkZeJXtrhFnpkzIybIBn+RYuoPnkbVIN6/zQdFBvceOtknIMDmzj6P5c3dpoQgIzt3OY9CJ5iw5dIRsVlSrXXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag+Aokia; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748764d8540so4109038b3a.0;
        Mon, 16 Jun 2025 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750088073; x=1750692873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bz5d7/Yle9yXH47+VMoCg7GEioM1cjgmUC3KKjrwpRI=;
        b=ag+Aokia2qndk1BhzeyG/fES6S2cJIpH172JcUwIHJxAYDYFth9IblBz3D5AMb3Qq1
         ZUzs+iOW8qIxEXUtZnaKHnXOunNGIRy4f1sQz9p9xbmZqEuz3V7NR+Qy0yYutyV3XD2O
         Ql0b/gm5fMxeMXxiXJbJ7yAHhWWM8Zr8qYvav6OE7m/mUfA4yQSONTS+cY/PSDow1YYV
         frmvMvKYERIVAVgznjQ3NizFAUhwxGfnWHNK9XJZ2YYd3LylNDFQotmYa7lPCaGpj8/D
         qJkKGNIxmKe8RPNzJjbSlTErO7/HYwOin0+AZ7Mzg2qXNiT5QOEffzQhYeLOZvCzHmRE
         PGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750088073; x=1750692873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bz5d7/Yle9yXH47+VMoCg7GEioM1cjgmUC3KKjrwpRI=;
        b=nGR5H7ZiQ7ur9+AU25hdwJsXiVdPPL/2K7PDLoUsGJK79Ctbk56T0LNQyNyo5OV9oB
         AJobIxg2qTt2MVimrVPRlsWe9957XIEyL2LXcOL7pft8QYhW3w4bzYtVmsqrtZjMP528
         0fpabSuy3JFSbvJswZLQonsRnuGXvyBLxvzISyL/duFTLl0mejQbBLdxr6UbN80CeCZM
         weZNmRi9U6TM+Y3K7ItnUvkq29TfWUrjJEoVx1g5XCoZvzpx2xnYQfzWYLUZCNYGoail
         TkdYY0QIqjTpxJ33HtUnXrbyvLM5Zuhjd+H+50JYBvWW8D8gqlzS5jmnhvp8DTpsK5XO
         eeBg==
X-Forwarded-Encrypted: i=1; AJvYcCVtb2GsLrU5L3uSdskBtSZSn5O1YzU1w+k7geQUx6ql80sGHecpa/EICyBvZCiq/f9d6DifOj/4@vger.kernel.org, AJvYcCWuasuW0gsC2stVebPja75TQ9bhF+hN9ziGjCOlOCAlDYvssKgNmc3EAfPmO8SjwBsqdoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyuHM5VPLmTg8cPhQPMUJrszNoub1bGHU0/c7suVKCgSt/B3Q+
	60izF9TroqK3TlcfOivWtRhG6Yh6OvSF9Sz1Jbn44KtBMP064Qvq5Rc=
X-Gm-Gg: ASbGncvXsK2maYDXLtJDWn97171bDVIgLieZ3uc5HpF9++ERcu5yb8dE3RPWT7imfHX
	Y8pblOjqkcZkcDdwxEkwHK7f52OUT3H6w72coUZAEMdvvSHAeZqrKyTNwbA/Pd5OXWtfilD7/gp
	NUfjHXbUbY70mK5saUs4i8XjXtbgmaF8pIzpSPXg7ajnPT6QgGj/d7vyY9m72P6d+zmRjxImoyE
	d0gqjCWl6sQF+C59bFaY2yix60aYqK8MzDDotc1aW3Cn8fNYCt5aY9DnOhJqU6KygPSUZxGI3Jj
	bLLES3yQmeiDQ9x18nvnIgdlsmJ6KT1pEdNe7obxKsDSx2GRdV0cmQPdLD0n1YSNekmYLVziCfV
	dCf10PDcGSEgHhzNcl+8Xr9Y=
X-Google-Smtp-Source: AGHT+IGMO5uepQ24puu4UZZ2j812BtJ0mVcfchcgkjPbKFPitIlddh33ZbK07o05jYL03msc28+cZA==
X-Received: by 2002:a05:6a00:4fce:b0:746:31d1:f7d0 with SMTP id d2e1a72fcca58-7489cf7263bmr12013626b3a.9.1750088073092;
        Mon, 16 Jun 2025 08:34:33 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7488ffee527sm7198653b3a.19.2025.06.16.08.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:34:32 -0700 (PDT)
Date: Mon, 16 Jun 2025 08:34:31 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Daniel Borkmann <borkmann@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	arzeznik@cloudflare.com, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
Message-ID: <aFA5hxzOkxVMB_eZ@mini-arch>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk>
 <aEixEV-nZxb1yjyk@lore-rh-laptop>
 <aEj6nqH85uBe2IlW@mini-arch>
 <ca38f2ed-999f-4ce1-8035-8ee9247f27f2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca38f2ed-999f-4ce1-8035-8ee9247f27f2@kernel.org>

On 06/13, Jesper Dangaard Brouer wrote:
> 
> 
> 
> On 11/06/2025 05.40, Stanislav Fomichev wrote:
> > On 06/11, Lorenzo Bianconi wrote:
> > > > Daniel Borkmann <daniel@iogearbox.net> writes:
> > > > 
> > > [...]
> > > > > > 
> > > > > > Why not have a new flag for bpf_redirect that transparently stores all
> > > > > > available metadata? If you care only about the redirect -> skb case.
> > > > > > Might give us more wiggle room in the future to make it work with
> > > > > > traits.
> > > > > 
> > > > > Also q from my side: If I understand the proposal correctly, in order to fully
> > > > > populate an skb at some point, you have to call all the bpf_xdp_metadata_* kfuncs
> > > > > to collect the data from the driver descriptors (indirect call), and then yet
> > > > > again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the data in struct
> > > > > xdp_rx_meta again. This seems rather costly and once you add more kfuncs with
> > > > > meta data aren't you better off switching to tc(x) directly so the driver can
> > > > > do all this natively? :/
> > > > 
> > > > I agree that the "one kfunc per metadata item" scales poorly. IIRC, the
> > > > hope was (back when we added the initial HW metadata support) that we
> > > > would be able to inline them to avoid the function call overhead.
> > > > 
> > > > That being said, even with half a dozen function calls, that's still a
> > > > lot less overhead from going all the way to TC(x). The goal of the use
> > > > case here is to do as little work as possible on the CPU that initially
> > > > receives the packet, instead moving the network stack processing (and
> > > > skb allocation) to a different CPU with cpumap.
> > > > 
> > > > So even if the *total* amount of work being done is a bit higher because
> > > > of the kfunc overhead, that can still be beneficial because it's split
> > > > between two (or more) CPUs.
> > > > 
> > > > I'm sure Jesper has some concrete benchmarks for this lying around
> > > > somewhere, hopefully he can share those :)
> > > 
> > > Another possible approach would be to have some utility functions (not kfuncs)
> > > used to 'store' the hw metadata in the xdp_frame that are executed in each
> > > driver codebase before performing XDP_REDIRECT. The downside of this approach
> > > is we need to parse the hw metadata twice if the eBPF program that is bounded
> > > to the NIC is consuming these info. What do you think?
> > 
> > That's the option I was asking about. I'm assuming we should be able
> > to reuse existing xmo metadata callbacks for this. We should be able
> > to hide it from the drivers also hopefully.
> 
> I'm not against this idea of transparently stores all available metadata
> into the xdp_frame (via some flag/config), but it does not fit our
> production use-case.  I also think that this can be added later.
> 
> We need the ability to overwrite the RX-hash value, before redirecting
> packet to CPUMAP (remember as cover-letter describe RX-hash needed
> *before* the GRO engine processes the packet in CPUMAP. This is before
> TC/BPF).

Make sense. Can we make GRO not flush a bucket for same_flow=0 instead?
This will also make it work better for other regular tunneled traffic.
Setting hash in BPF to make GRO go fast seems too implementation specific :-(

