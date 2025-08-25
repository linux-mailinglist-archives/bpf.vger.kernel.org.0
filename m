Return-Path: <bpf+bounces-66473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B695B34F2F
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079DA3A3AD2
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EFC2571CD;
	Mon, 25 Aug 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBAAEyMr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A409E5661;
	Mon, 25 Aug 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161965; cv=none; b=qvQTC+UWs+MS/Wa1ZzND62BubM18JB55KSTxDeixyg28hsk2X54kAZVNf0IgCp08o2vE84SQYzqY/ftRVi4/yjWdQfVtjOi1n6RMyM1S4vzU//L63H5sKFbmH1/a6S2yJbug0LFwMzLLiAujT4mrWegvnaJ1lZfoCbN4MbPCWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161965; c=relaxed/simple;
	bh=9qgcvI3cptV5xNQailkoaAm9UlhdZQw59OEpaRFd3+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAGi69y9v/w8dr7FffDxd9HKCWtBjaTPwNz+SqICWOf6sbCgDRtSrh8fLjAIPWegfjJUwCCjx9kQxkZToIzA4UX/jpC81NHDC8dy/AukUqZZhhZJLGPSiLnJtozsy/w+MgAbH12ZDXBXWoMXuhRB01qjrh3nFimOdc1xdNr+U/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBAAEyMr; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c1aee9ecbso921822a12.1;
        Mon, 25 Aug 2025 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756161963; x=1756766763; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PqOcyzlr3gzKyICEaylRvtsSjPJeqs9e+/ElxRDOmjE=;
        b=NBAAEyMr7QyKKyylebJSfgx7pEJ7KADWi/DLMQq+/D0uAVhvrRPhPb62cHWjscDOJ9
         vzBUxNenUPbgSdt77Zq8OHdV0J1aaoOlWayKyeeFQ7xLfKUWPvPxUbp8HVRrfxT2NGTE
         IYEWXcanVquUSJWUeCNs7LY9JwRcp1h4sV73IBHnAP6xPhK7nO5qIOZAeZeXqfsKXrmG
         were5sPWqSj3OFiw/35qfUW78DkzSsHmDr7HgIHi0ag+Y18m/I59afqW71L4NYAe45PY
         Ao/1LELhr0E6kDukONWKptQKOtEU0yM1uV5GKKADXnDmoAl8FJlHi7O13uCTK8qOTuvO
         4zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756161963; x=1756766763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqOcyzlr3gzKyICEaylRvtsSjPJeqs9e+/ElxRDOmjE=;
        b=BugwVnpJDpJa6koaiijZJ1Z1RFfDmJiyhMjjKlWDMFn71Bs7JRcF1XNs5MrlTwGsnM
         /2NPiiNn0sxqj/HDut2+Cj4LU0p7/4wvpdy/2DqUwX++uHvgUZKkOAgsDTPtlqXU2Yyd
         OXXjSCM0BPAXY39j2/2S7YLniuBy7ieRq/GKJK7cs8Do0hstQWHQY0nIc7b6PH6Ketbr
         6mAdQV6Ge65TBPP1gnl2I0125I3CgRp+n5HK6d//+KQJ/x0t44Wr4PB3L62LE1V06wMX
         ddex2+F6y1bqNDE/DskHnI7IGrSMItqUp6gspz0oiZMNwhM1UnaLYNzcYRZ80CVNgisM
         8vlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM4Yo+2+1Hh5nut3S6QbF806cP9KPVzz0Z1IEdj7ULaBehtMhSNcMUdbMAV28BOa4JctrPdJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRnp7DDQm3N+KswCC8uJfm8Jkgfxtv9WOQXGmX4BNmEeKE+rWr
	+B1EGuA0EIMTUhRkyxmr7gpcqVIi2XWBpLoZTu/UrmxTBt2n5RF1/4k=
X-Gm-Gg: ASbGncumxE2Kl/mSwh24TuYIoXTXzfGMcyOSUdnuUYLOskWk3KV2SeUjaSr+h316+b8
	lrIfRGpnsAdoT5QlhcxVwVA0y+K6FoKV2JtF99CK82jOTTkjWA2SVFSw47CcnRTingpWT5kg7Y5
	fQicbkja8Is56j+kO4z7ajLibq/6KCj9Zv9ZrL0gfsi/qZ9l2Qqmuaqj0/YTb+MGTIi9eplxThf
	8w/AOu1tvT0QvtOGbeeDZJ2AzyBP3h8xW2tti3H8grpaV7QeMuE9zB1ChUoSldwcSMk1RuqO0UO
	4mG3hMJ29eED8a0aziwTD/Yk0iHGFAXnYrGFqEH1BG3SjAS3XXCM5XMQQsyPksO6UUYZmt7wB0Y
	P1oHNbCKck6PNr7pv8DPt1FkLsH+WfX0DdVLkSr/zIfFrlJqpo/OF4gVENfj20XzqJfPW6ib4jl
	oV2mn1lxF6bvya3nMW9nk5VPLULQVXpX+qyQzUhTEQ9u+ANrvJ4z8LGYRB8WNAxAEOPFZjnmy3y
	aWI
X-Google-Smtp-Source: AGHT+IH/qCuKkphZadBbo7ICsIHEWlDzU6dNJRlkjCv+sECuYp7sjX31QhkYFXn5cBvtoGnb6zkniA==
X-Received: by 2002:a17:903:1b05:b0:215:6c5f:d142 with SMTP id d9443c01a7336-2483df7916dmr9720165ad.20.1756161962803;
        Mon, 25 Aug 2025 15:46:02 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466889e06bsm77808755ad.154.2025.08.25.15.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:46:02 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:46:02 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, kuba@kernel.org, martin.lau@kernel.org,
	mohsin.bashr@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
Message-ID: <aKznqjd1aowjxJfK@mini-arch>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <20250825193918.3445531-4-ameryhung@gmail.com>
 <aKzVsZ0D53rhOhQe@mini-arch>
 <CAMB2axOkPx=5vseNXbwQtHQTFhdur6OSZ-HbNPUciwBmubQa1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axOkPx=5vseNXbwQtHQTFhdur6OSZ-HbNPUciwBmubQa1w@mail.gmail.com>

On 08/25, Amery Hung wrote:
> On Mon, Aug 25, 2025 at 2:29 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 08/25, Amery Hung wrote:
> > > Add kfunc, bpf_xdp_pull_data(), to support pulling data from xdp
> > > fragments. Similar to bpf_skb_pull_data(), bpf_xdp_pull_data() makes
> > > the first len bytes of data directly readable and writable in bpf
> > > programs. If the "len" argument is larger than the linear data size,
> > > data in fragments will be copied to the linear region when there
> > > is enough room between xdp->data_end and xdp_data_hard_end(xdp),
> > > which is subject to driver implementation.
> > >
> > > A use case of the kfunc is to decapsulate headers residing in xdp
> > > fragments. It is possible for a NIC driver to place headers in xdp
> > > fragments. To keep using direct packet access for parsing and
> > > decapsulating headers, users can pull headers into the linear data
> > > area by calling bpf_xdp_pull_data() and then pop the header with
> > > bpf_xdp_adjust_head().
> > >
> > > An unused argument, flags is reserved for future extension (e.g.,
> > > tossing the data instead of copying it to the linear data area).
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  net/core/filter.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 52 insertions(+)
> > >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index f0ee5aec7977..82d953e077ac 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -12211,6 +12211,57 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
> > >       return 0;
> > >  }
> > >
> > > +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len, u64 flags)
> > > +{
> > > +     struct xdp_buff *xdp = (struct xdp_buff *)x;
> > > +     struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> > > +     void *data_end, *data_hard_end = xdp_data_hard_end(xdp);
> > > +     int i, delta, buff_len, n_frags_free = 0, len_free = 0;
> > > +
> > > +     buff_len = xdp_get_buff_len(xdp);
> > > +
> > > +     if (unlikely(len > buff_len))
> > > +             return -EINVAL;
> > > +
> > > +     if (!len)
> > > +             len = xdp_get_buff_len(xdp);
> >
> > Why not return -EINVAL here for len=0?
> >
> 
> I try to mirror the behavior of bpf_skb_pull_data() to reduce confusion here.

Ah, makes sense!

> > > +
> > > +     data_end = xdp->data + len;
> > > +     delta = data_end - xdp->data_end;
> > > +
> > > +     if (delta <= 0)
> > > +             return 0;
> > > +
> > > +     if (unlikely(data_end > data_hard_end))
> > > +             return -EINVAL;
> > > +
> > > +     for (i = 0; i < sinfo->nr_frags && delta; i++) {
> > > +             skb_frag_t *frag = &sinfo->frags[i];
> > > +             u32 shrink = min_t(u32, delta, skb_frag_size(frag));
> > > +
> > > +             memcpy(xdp->data_end + len_free, skb_frag_address(frag), shrink);
> >
> > skb_frag_address can return NULL for unreadable frags.
> 
> Is it safe to assume that drivers will ensure frags to be readable? It
> seems at least mlx5 does.
> 
> I did a quick check and found other xdp kfuncs using
> skb_frag_address() without checking the return.

The unreadable frags will always be unredabale to the host. This is TCP
device memory, the memory on the accelerators that is not mapped onto
the CPU. Any attempts to read that memory should gracefully error out.

Can you also pls fix that other one? (not as part of the series should
be ok)

