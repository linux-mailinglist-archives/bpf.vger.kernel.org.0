Return-Path: <bpf+bounces-63243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B3EB047D0
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA70E4A6788
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31C8277C9D;
	Mon, 14 Jul 2025 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsB9ZzHt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150CF1A073F
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520646; cv=none; b=a+OnB6OmxiLMVUGGARHKYQRx4xyzLPbhZ0k7VzJjpDzOiDI3KtdBonvZzOPa4rTerVu/TuOR5uqW0rd7U8yqwLSKJkJ4vKLmrn4EXWlbHpke4SCvN6XMX0iJs1fVQySk5pkbDI2gU5YTR5AsREV613uXpEh6/XIIm7rycO2JjaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520646; c=relaxed/simple;
	bh=gwMNxvBzTcMSL30t3Yjcc8ttxM/E+KNljqRjadswHzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCHUoObq4+QwjLcMWvwblZXvj8srvRXJKG52IlQ4koILnKw9cVzGSfvGtaPIeUT2U6mA23FQI5gbultTSeb8JnPwUsYd9SMTAyxxJFvUcUIOhkbFOwx7NHWCPLEbdyyZbPiMghNYbocrEHvnIyzttSNrUy+cQVzb7sESoFx3ZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsB9ZzHt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237f18108d2so36615ad.0
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752520644; x=1753125444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8rHMT7ITONSO1z0A2MfzHrcUji03YMrVNYceOsy4bQ=;
        b=JsB9ZzHt51TBiGB7NP/r73M45pl3WHlKqQ/QhIIY7un9y3Dh8JeUMFHv31fMUUvHgf
         xnQ6ttZWn3h0xxLsvF5+cwvofRSe3oywny5igseg1ciCPWQHR1cyrnb6Kk5pTt4L2GCy
         UOnTC3zqY1r+ue984oMA3yN3PNlmRBiw2OWPziJjT5bF+7cqLWWLnv8nYlQIL7aFA4yI
         qft91HmZmcjfu/DmYe5AoS4tJD7/a8acGdM1uJX+9sQ7Gk9koZtAc/5GA6LMNK8xtTTZ
         Q178uTZtEkWl9f05VjtfMFStI07/kTc/fmSsNUp63AF/7X+knMEzqQlsOpaR1w7NiT/i
         hQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752520644; x=1753125444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8rHMT7ITONSO1z0A2MfzHrcUji03YMrVNYceOsy4bQ=;
        b=ZChDPBOduxejCccckDdYn89CjXqw6mu4ef4cf65kjZXvAvrBe2XWTazkWxAYKr5iba
         hen7sBm31jInAXRghv5KIkF9kaxDfv4hyQrdpI/1UCbq497+dCq9hGYId4vPGnRsWXeE
         m9JfKz547SCVNC/mxNZ9a1FEubuLMTb1wvCl3rvfJsap3iyH3vEE9HcEPyBoHKWdnNk0
         +QoFEjiv+lJnGUOD1iVqMTvXAhbe0EePIpZ+Wc/Dr3NBNa/qXO6rYLDt4uJVmEjhRRpo
         22nZRLIIvOWO5pBsgk2KordVU5LeXpSsANcRXPbT/vHVi3Qrp7ZAG0HBR11jQjawijkQ
         C6ag==
X-Forwarded-Encrypted: i=1; AJvYcCXxEwZagD+4O0Gc+1c2wksFJe3tBQOf2BiYqQ514owD4cK+U/c16ZoI6FcxUiv0iVp6kF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhgkVnYLFX0CcY2n8X5Zpi2ela2LniaqMM1bW3tY+1zmEhVwc
	sP4JczP3i1dlxJPMwJunYGk9F/P3qJBR7AofbsR0iefjVrA34JhF7FwdqXRmghQFg5GGfUaIt/5
	85MwS3oCow7wJWlFa00D1eSJ+x+8CNro3JgPOZeCJ
X-Gm-Gg: ASbGncspAO1H7pbl1DYCyVAkuR6g6H64YjiZWIXCmkGTDsz24BcBB/jv5Eguhi3S0gB
	I0olI5hZf+XDKpzvJEkkhsoqe/1jVU4y/NNgEVeAzR7wM3TiC/vrole30UrshZEOpiW3kMRDeie
	y4DFr9kTbsxV44TXkllfZ7DfVdFFe2KT+X3D+rQRUINq65RUKrXHLUbhyMFZ68A8do07dvAKaCq
	IzcQwiw1i0NL5vFDSziOmmW3ujBLLmcy8MmKA==
X-Google-Smtp-Source: AGHT+IH/Gna2NtIa44sZYV9HnUa6pvYCTWwA/GHTVwYfaVkwpUl5vAxC2jq/1WjBSegjhWXoPJOV2N4HVHgWOrSseEI=
X-Received: by 2002:a17:902:ea03:b0:215:42a3:e844 with SMTP id
 d9443c01a7336-23e1ac3081emr278035ad.17.1752520643945; Mon, 14 Jul 2025
 12:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-2-byungchul@sk.com>
 <b1f80514-3bd8-4feb-b227-43163b70d5c4@gmail.com> <20250714042346.GA68818@system.software.com>
 <a7bd1e6f-b854-4172-a29a-3f0662c6fd6e@gmail.com>
In-Reply-To: <a7bd1e6f-b854-4172-a29a-3f0662c6fd6e@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 14 Jul 2025 12:17:11 -0700
X-Gm-Features: Ac12FXxlqQfiRH8MaVWFX_TBycL1_lY5aP4_zvVP0i2GJVXuipu9otkVlqIM2Fc
Message-ID: <CAHS8izMGGCG2kNkj2vqcUO3-M77P_7whY1BeRH58b6ix+R-kRw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/8] netmem: introduce struct netmem_desc
 mirroring struct page
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 4:28=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 7/14/25 05:23, Byungchul Park wrote:
> > On Sat, Jul 12, 2025 at 03:39:59PM +0100, Pavel Begunkov wrote:
> >> On 7/10/25 09:28, Byungchul Park wrote:
> >>> To simplify struct page, the page pool members of struct page should =
be
> >>> moved to other, allowing these members to be removed from struct page=
.
> >>>
> >>> Introduce a network memory descriptor to store the members, struct
> >>> netmem_desc, and make it union'ed with the existing fields in struct
> >>> net_iov, allowing to organize the fields of struct net_iov.
> >>
> >> FWIW, regardless of memdesc business, I think it'd be great to have
> >> this patch, as it'll help with some of the netmem casting ugliness and
> >> shed some cycles as well. For example, we have a bunch of
> >> niov -> netmem -> niov casts in various places.
> >
> > If Jakub agrees with this, I will re-post this as a separate patch so
> > that works that require this base can go ahead.
>
> I think it'd be a good idea. It's needed to clean up netmem handling,
> and I'll convert io_uring and get rid of the union in niov.
>
> The diff below should give a rough idea of what I want to use it for.
> It kills __netmem_clear_lsb() to avoid casting struct page * to niov.
> And saves some masking for zcrx, see page_pool_get_dma_addr_nmdesc(),
> and there are more places like that.
>
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 535cf17b9134..41f3a3fd6b6c 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -247,6 +247,8 @@ static inline unsigned long netmem_pfn_trace(netmem_r=
ef netmem)
>         return page_to_pfn(netmem_to_page(netmem));
>   }
>
> +#define pp_page_to_nmdesc(page)        ((struct netmem_desc *)(page))
> +
>   /* __netmem_clear_lsb - convert netmem_ref to struct net_iov * for acce=
ss to
>    * common fields.
>    * @netmem: netmem reference to extract as net_iov.
> @@ -262,11 +264,18 @@ static inline unsigned long netmem_pfn_trace(netmem=
_ref netmem)
>    *
>    * Return: the netmem_ref cast to net_iov* regardless of its underlying=
 type.
>    */
> -static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> +static inline struct net_iov *__netmem_to_niov(netmem_ref netmem)
>   {
>         return (struct net_iov *)((__force unsigned long)netmem & ~NET_IO=
V);
>   }
>
> +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
> +{
> +       if (netmem_is_net_iov(netmem))
> +               return &__netmem_to_niov(netmem)->desc;
> +       return pp_page_to_nmdesc(__netmem_to_page(netmem));
> +}
> +

I think instead of netmem_to_nmdesc, you want __netmem_clear_lsb to
return a netmem_desc instead of net_iov.

__netmem_clear_lsb returning a net_iov was always a bit of a hack. The
return value of __netmem_clear_lsb is clearly not a net_iov, but we
needed to access the pp fields, and net_iov encapsulates the pp
fields.

--=20
Thanks,
Mina

