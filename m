Return-Path: <bpf+bounces-60734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE7CADB5C3
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 17:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F727A556A
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 15:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A44826529A;
	Mon, 16 Jun 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb8mXZ8j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45D1E22E9;
	Mon, 16 Jun 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088715; cv=none; b=P1tonLirgmyEDAy1/C60/3ID0I8+ghyCc9+TYQoo7mh8XOUkQIdWY/tKe2aaIvK8Wn5Z1TifqwrsD3EdIpLpidJAhXVsM9NMowBRYmdMbGks7n9lA9ZpL00hmKnrrjob89mCcE5M/vEuwz0YfRmEIUJp9uYpoqkkhVsxhImgpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088715; c=relaxed/simple;
	bh=RYKX0EHK3ctj5KC6n8rBqSiI8yWLi7O1mk5ek2Cj6sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZuVwfMKwpCdskBttUDSlr3MrE4JN7NbSst7cKwh+mbcpeMjivTDH+B8Ma3n5XGFo4k2tUpduAEBu991/vWP18ZCXbIt58IYldLwYgA48uAS5yrKV43pVbWYgyGdXEtF+jWc/68kFNt/O8FmWhI4hMj2rLuFm9H8Me+qnDqLHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb8mXZ8j; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73972a54919so4006574b3a.3;
        Mon, 16 Jun 2025 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750088713; x=1750693513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3lGc7Y6P1+7/KUaNX9Nry2m7XMfZVK2Rgy3QuujY5A=;
        b=hb8mXZ8jkNFUgOhpRfd3cTUzEzw1SQLKkWEXN0rxUMUVE9qVQGqu1IigmlMJaLLKwV
         TFbjgVohBnkFYmi2zJs3tJ6ZSnt7xtZWlhoQDSJ9vsR+OM9UCpebuCwc/DQyQAQRhkeI
         d2U8LNJeoUtmWBTZV6mSeCLXQhkyfREhkoP4caefqqEpW3wwqewEU9OXKYa6oHQkgwtR
         KiOn5XPWeK0a4d3gMOpXdIZyI1EBsQrouHnVH4YOP+0MjqRrjkuxmPGesAxSaG+92+/b
         Zof3G+LCAPcubDo/89lZYkCpOgGBX7EnpdsGVGQ2NBTBiqulS18KHtLspmIXqanNxk16
         szcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750088713; x=1750693513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3lGc7Y6P1+7/KUaNX9Nry2m7XMfZVK2Rgy3QuujY5A=;
        b=A94yN2T0CIs4K4/6GCEGN47u+yIeYsvj7x3K2u/0A5ggoSeyw8Nmifjtn4lbhzZZLp
         F5gxLokLVSziwkQwVafHkfSIHSUPQi4+Uire4KRKS6scYYomVmmprWWuI+GDNHHhwfdW
         AtyjEdWKYCEHFcSrT5aS3JBaAvuLeszms/2fZHcrIfAAAHRKejKsWJm4+qcBPmmnoaYt
         a7TI5NORe0TYa9ldo2rfr4T+pm2ueQpP2ntvRUGZcq2VLWOde7AGFGsrU/Z+khrgqPQ3
         4SP+p+TvovaSSisccawkHkONJrfl6LVQr2h6GFha2KaAoeSGmSC/IM/Ei5vBY+rjXf3c
         i7xw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9h4DbKi5Y+b1t68pA3hmplOzz5+HWnIZ0OTqRxJcNoJGfwK5ka4ok+dd+vkrBsCsvK0=@vger.kernel.org, AJvYcCWxYu+kUjCfqFmqp+GHlbH7W/ms670r1w/RY8JkNlVEoj0HXfEiImZj5qsvIn05DchqROjBrWR7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GnOY7PdnziLZo7KL+HKzWdMR1kAWOUgdmSp/Xrab3T+syB71
	6PlzKDqZzarbY72/4C1Hm/3jNtcffREV3ztYWLGqGz09bm9UADLgW9g=
X-Gm-Gg: ASbGncvt7wlabTTf/DLCEeyiMwOupJcKu5na6hpcolU65dtifg6J1baKft5nbRRMMuW
	PIExRmApkVvKEDFM81Uf+1S2NX/fkIwFVvaZyoGAvjZiefzUdKlJGrFXVS32Xz711OrFZC+tk/D
	twZcTFLneD43aTSyKeLasyFzMFybekRy7A0i8gLU5nmfUTzdfuXq7mD/3LgHQdVmeiEik/yM5IH
	56POzkfd6YwhpO8Pw+gBhaFf6Gl0uLky265LXAanSkLeEsokep9hQOHmVRnbkg+7GxrTY49Nq/u
	kaK5/Z8NjxSkcbgvCKRzjIbR7JspL8PQqBoj/n4Lhvl3U19/ZqIBAvKiq9wGmXaDQC4QjvoiK4q
	WzYctSC97XfqY3QVe1cw4AF8=
X-Google-Smtp-Source: AGHT+IHIvEUcDUUW12YJXhSaws5rH37AgefY3AIAPAf7k4PnHvb3Ctapzd9cZVcc1KoJZP0JM726VQ==
X-Received: by 2002:a05:6a00:1781:b0:742:a77b:8c4 with SMTP id d2e1a72fcca58-7489cf6a9ebmr13243119b3a.3.1750088712929;
        Mon, 16 Jun 2025 08:45:12 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74890083056sm6921029b3a.77.2025.06.16.08.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:45:12 -0700 (PDT)
Date: Mon, 16 Jun 2025 08:45:11 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
Message-ID: <aFA8BzkbzHDQgDVD@mini-arch>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk>
 <aEixEV-nZxb1yjyk@lore-rh-laptop>
 <aEj6nqH85uBe2IlW@mini-arch>
 <aFAQJKQ5wM-htTWN@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFAQJKQ5wM-htTWN@lore-desk>

On 06/16, Lorenzo Bianconi wrote:
> On Jun 10, Stanislav Fomichev wrote:
> > On 06/11, Lorenzo Bianconi wrote:
> > > > Daniel Borkmann <daniel@iogearbox.net> writes:
> > > > 
> > > [...]
> > > > >> 
> > > > >> Why not have a new flag for bpf_redirect that transparently stores all
> > > > >> available metadata? If you care only about the redirect -> skb case.
> > > > >> Might give us more wiggle room in the future to make it work with
> > > > >> traits.
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
> If we move the hw metadata 'store' operations to the driver codebase (running
> xmo metadata callbacks before performing XDP_REDIRECT), we will parse the hw
> metadata twice if we attach to the NIC an AF_XDP program consuming the hw
> metadata, right? One parsing is done by the AF_XDP hw metadata kfunc, and the
> second one would be performed by the native driver codebase.

The native driver codebase will parse the hw metadata only if the
bpf_redirect set some flag, so unless I'm missing something, there
should not be double parsing. (but it's all user controlled, so doesn't
sound like a problem?)

> Moreover, this approach seems less flexible. What do you think?

Agreed on the flexibility. Just trying to understand whether we really
need that flexibility. My worry is that we might expose too much of
the stack's internals with this and introduce some unexpected
dependencies. The things like Jesper mentioned in another thread:
set skb->hash before redirect to make GRO go fast... We either have
to make the stack more robust (my preference), or document these
cases clearly and have test coverage to avoid breakage in the future.

