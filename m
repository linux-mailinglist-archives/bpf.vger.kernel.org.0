Return-Path: <bpf+bounces-60298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB06EAD497D
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 05:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B388B3A607E
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82C31F7904;
	Wed, 11 Jun 2025 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZESwgR2e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC481749;
	Wed, 11 Jun 2025 03:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613218; cv=none; b=ZYFaSi0CSdfoszg/meuFj7NtB31w54BQzy4utcavC+qeryozt/vgWDJlTVkpNz92vWbdHgBIHu9hvjMm7+huipNWyVwPqFzYHn0fdchRHx/XChW3M5bv8VukIJBoyGZup9Y+vXrRJQ3KhY2sH+o3iT+yR7q4gWFFTqzjecBFGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613218; c=relaxed/simple;
	bh=rPVriNA7cxls0TdVbUs4Xq8KhWGVGAU8k13T96+qt+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUG4GHYG6zwex4FB99knROU0Us9RVziJKtZy/dbqRhGj/gU5Fd/h36BLFbXmG54PxCJhhg0uy7RRdDwM37r04IHhezlEXRGyMj8xw8+ru5BWZgIlioVmBV2uFF1yibC7mU4vhq8F1yj2t/pWLjfQ15GvnZGMTVqZOW0qQWlwA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZESwgR2e; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-312028c644bso4706237a91.0;
        Tue, 10 Jun 2025 20:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749613216; x=1750218016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHZXq9/HSysGqtsKjHNbmYLUzfUw6ExCfU0Zi8dr+gw=;
        b=ZESwgR2eV9qBwoxBdb+R3O/sqRzKQN0fS5mxaVulebOETj6rkkPGqYBiFWTREmwcC3
         WXXibFMRHctCUjp+lL6E82Og+vr/l2K7xanlOj5IwQ5pE4PyQexZNx2SyI8OaF8WEwDZ
         drasFVtqTiNq3yR9pzWDlbnJBcUMWId23djAvrgKt5bepv6JTSFaKP6NVFYEp3rWTTcy
         wW1FEtbnuQY1UkxCOsqT6MnWcft6zihvmeziMwrNYO+JZ4cxGEs5Tpk0DY+1+/sNXN0I
         XNh4wsFi1kSHYkGE4AkX7Lbo5g8ZUu/9+kV8/pCa5RQXOPjY6lw677v2nrvX3vN7euCn
         bJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613216; x=1750218016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHZXq9/HSysGqtsKjHNbmYLUzfUw6ExCfU0Zi8dr+gw=;
        b=JQbbCZidXsJY1G7ovVyKszsB40bXweybL7sUUsEu9PFmbGF1Ew8/f/HEXwBT0aujOd
         Kohn3qjKRKtUnqSVoTe0UuHpOlqyTZ/S5XD7YMG1HhT1csbbB7ZMO1XUyl3f+Hrf+Mk3
         GbUjEDAFn2c5oQQ35dUAM9+0GQjTwyJi15ddTs+bwpotIUVYhEoyl0tHTLvT8YCDZphH
         +0JCyaD8DnTlI8jqfSBe5WgTEq8CllKVoWoHgqN66LuxmKCYQ2EWyr75WHqW1FZD0Y0w
         xWweVKE5qYhwr61/UpViwagMm+cdm7Uoka87WRdyr5DKB1VwmCN+Rth7r7rtDmbgj2lj
         Q0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU/r9DUx4SR9Ss0wMMd44dDQ2LLmm4OTQMrLkBGgAfkn2JUXEWQZGuGD8sUNLCMGvb40wrx0fm@vger.kernel.org, AJvYcCXP0uia2tSPf6wKjlYmscruEvROISr6MEIHd4oA1orfhwUHBf4whtU2urN/XA45n7TIUZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZsXkkl1hESu4+2xX08F87XDkdt0BtHzf8xGlhvLNy8SFpQ+t
	DtulveK4GepEXBmtdYkJiN+jKd8607oXbsbbPNCc3c7O0Kd2q+Xr8Ns=
X-Gm-Gg: ASbGncvnYw7ptOAI5MEgBL/kFLrGnwbaD3K/VzblKWPb+lHChPS7iy0fay7EDceVg4V
	9RLzNEocaTfCymQLCXmmH8WTmi86jXNff8XGMsjNDvmj2qiv4L3qpZy3n+Ov9QzanBBPAAb+g5N
	0+ZXJ3+UYYqoWrL+oIRT+ivz0sZEq/Tt+XpIW4Z2mb8kjPVM/ZVWc/ai/ppuWYHQDs1KX+v261y
	6VdpA1hCJlrJakwQsVfnzAhATQ8sKdjwZtb/50taDRaGjA6s0caoF5afh8xdayvyBaIKIOshUul
	Po41aG2NXcBYwO3Vk2IR607jpRMtYreQBz7YE3ZAiVGmhX9udCbAV2LLDFkYi5HS23OwYfeuy+P
	Bqp2D6P2qwJnd6/CLxevj79o=
X-Google-Smtp-Source: AGHT+IHvl4h1exi8ywoBtqahTT6cB9WdxUmxRjR4cIi8C/TCYDUq70I/2vURRUdE43RufRpKbowwuw==
X-Received: by 2002:a17:90b:5107:b0:312:1c83:58e7 with SMTP id 98e67ed59e1d1-313af11f53dmr2459071a91.1.1749613216026;
        Tue, 10 Jun 2025 20:40:16 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23603504eefsm78038785ad.218.2025.06.10.20.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 20:40:15 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:40:14 -0700
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
Message-ID: <aEj6nqH85uBe2IlW@mini-arch>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk>
 <aEixEV-nZxb1yjyk@lore-rh-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEixEV-nZxb1yjyk@lore-rh-laptop>

On 06/11, Lorenzo Bianconi wrote:
> > Daniel Borkmann <daniel@iogearbox.net> writes:
> > 
> [...]
> > >> 
> > >> Why not have a new flag for bpf_redirect that transparently stores all
> > >> available metadata? If you care only about the redirect -> skb case.
> > >> Might give us more wiggle room in the future to make it work with
> > >> traits.
> > >
> > > Also q from my side: If I understand the proposal correctly, in order to fully
> > > populate an skb at some point, you have to call all the bpf_xdp_metadata_* kfuncs
> > > to collect the data from the driver descriptors (indirect call), and then yet
> > > again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the data in struct
> > > xdp_rx_meta again. This seems rather costly and once you add more kfuncs with
> > > meta data aren't you better off switching to tc(x) directly so the driver can
> > > do all this natively? :/
> > 
> > I agree that the "one kfunc per metadata item" scales poorly. IIRC, the
> > hope was (back when we added the initial HW metadata support) that we
> > would be able to inline them to avoid the function call overhead.
> > 
> > That being said, even with half a dozen function calls, that's still a
> > lot less overhead from going all the way to TC(x). The goal of the use
> > case here is to do as little work as possible on the CPU that initially
> > receives the packet, instead moving the network stack processing (and
> > skb allocation) to a different CPU with cpumap.
> > 
> > So even if the *total* amount of work being done is a bit higher because
> > of the kfunc overhead, that can still be beneficial because it's split
> > between two (or more) CPUs.
> > 
> > I'm sure Jesper has some concrete benchmarks for this lying around
> > somewhere, hopefully he can share those :)
> 
> Another possible approach would be to have some utility functions (not kfuncs)
> used to 'store' the hw metadata in the xdp_frame that are executed in each
> driver codebase before performing XDP_REDIRECT. The downside of this approach
> is we need to parse the hw metadata twice if the eBPF program that is bounded
> to the NIC is consuming these info. What do you think?

That's the option I was asking about. I'm assuming we should be able
to reuse existing xmo metadata callbacks for this. We should be able
to hide it from the drivers also hopefully.

