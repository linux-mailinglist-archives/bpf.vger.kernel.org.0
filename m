Return-Path: <bpf+bounces-63362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E8B06689
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 21:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF88C5040B2
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5942BEFE0;
	Tue, 15 Jul 2025 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNV7CFaB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A72BE7C2
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606590; cv=none; b=udwZtvwJWasPWenI3jh7j8nQqEo7QZRRiMMH5BF91XcgNFpqWso22ionecYntSDQRP5u5HHIIiXcOnsZBvmF82mrRQ6por28dZXa9r4swqlivoZ4F7Zk1c2PK+qHPX4F64sAegGgdL2tsmOv8k04pcmhQSpK7fT2XWmkZ6ooQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606590; c=relaxed/simple;
	bh=JCtOsb4/1xLFL0OaeWa5hxSLQvuTC3ONZEmrZqYPr94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcjYapA4DIGJ7Wy1TDh7ZYhlej7qqtIJCmI3K8m91b/OxXdjohGwgD12ooewnFSsNvFX+X8SegMQ57ZMyYyxTk3+2VqAGMtFRK7L3e0W/lL17motMGbFjMzBIBVatNBTUOKqsb/ZZh1/JJooHO5aXN2oEpCt+59/KRJRgxTmtcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNV7CFaB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23dd9ae5aacso37035ad.1
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752606587; x=1753211387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLN2gDZ9onoCs+NlWLd/HaKyjjBalP3C26bllNaupd8=;
        b=RNV7CFaBERPlMMGK7D4EcepG7ajj+LB20EqbT+aTRO/aStqJQ9qymjk9wIViVtm+su
         oRn3LF13xoEsxfRSYPv8gil20/uvbdAIikPC2Ygd0X4xwh/PHFRGmxNJa3hN6yf83KVL
         DPtYLcHhkKgktkx8RO/3Bp+uxxKcJ/lIfjn2c3TD94Ymh2zPzgzbZV6kbx6HNxluKYiH
         BMmyFVr3n5aBXd6vR3+uD6jbtLdy1JMGv8fiGXCQ6fsFdD3CU04SxBoQIuBvARo/ely+
         9tj3qEFfN3ZWsVvW8dreqTAEHeKtdyXtfVHDDNHV75MzJ7MLrkIrPzQUHdNA4y1W2RL2
         J/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752606587; x=1753211387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLN2gDZ9onoCs+NlWLd/HaKyjjBalP3C26bllNaupd8=;
        b=DDDkAfAukwUVM2ZNRvaZzDUT/7dgw8vKdI6Ks1bZPGX7x8SuNd1TDeK3pMAoncmPyc
         ypgonLRKOQrEYP40GA74xqAYuNIAX0WawL7KTv/wEMp3i9OcmGuCksAoEaKcvSkof7fr
         8mClcdPMOWQOOe+x663G+jQ29QSxm9yq8DJPk8pXyeG+9PSgfHfdasves2HhgoFoU4tv
         z8UsfX0vhpn6veM2sMUS9XRfA76csdLRXVoZDDhFnOm5YO180xZq7xr5wOPWo3w+KEvU
         DHIwNJRXaZn1A9UQt3Czm27qMTSp1/NgJej2pAfd5GxEKHlrc4pBnW0Y21f3OeELfLgJ
         KNaA==
X-Forwarded-Encrypted: i=1; AJvYcCWzf7nmEIWvil4xHRj/ydUhntrpNLW0tyltASL+Ux7PhF8Tv6iAl0HMZXZMwEIWbWxFlNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhdcmIMIa+yA740ViYWTl5k8sPm6Z6AGthVLNBFTP5BqZiBD3
	Pl/cnj04lGmOfZtsuSB5Cpd+teiuGoIHL4mo1nCy8FPpHiGyE1KtS/217pOr06h7cRLVXZ9PBdZ
	5YtG63Nilrw8VAlw96q3dkMxfG1goI7Zy/XlePf+O
X-Gm-Gg: ASbGncvOSdYmx7RI3VSwsJ+WfRUmnCppDIIPL71mJysn5TrAebwrUltL9FwWaZ5DYi5
	bSD0PcaHbzBOwtMBRdWJ355TjJGEX0+0kU1sal3jPmOSunbMTQD+XNTlFqnPMmoI35afxtqaZUV
	+dEBnHTz3BkLO3HzxLEnkt+P0hN9LQVsRXSCqn6QMgkKKruURFgsTR6G55rHh3vVum7c8RFKst3
	sZ0CoGSzb/HpLFf2EVs8INhIGzfgQ9fc3YqjQ==
X-Google-Smtp-Source: AGHT+IHowErSnvUulW5JXQBN4+fmG2zXgFSZ6eFQ/lioc5t7yVKoRiNFwd450XUTKcqJXTXwlIEmOQ0Irhzeefb0YRs=
X-Received: by 2002:a17:903:4b50:b0:234:48b2:fd63 with SMTP id
 d9443c01a7336-23e24d874edmr256525ad.21.1752606586807; Tue, 15 Jul 2025
 12:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714120047.35901-1-byungchul@sk.com> <20250714120047.35901-3-byungchul@sk.com>
 <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
 <CAHS8izNh7aCJOb1WKTx7CXNDPv_UBqFyq2XEHHhqHH=5JPmJCQ@mail.gmail.com> <20250715013626.GA49874@system.software.com>
In-Reply-To: <20250715013626.GA49874@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 15 Jul 2025 12:09:34 -0700
X-Gm-Features: Ac12FXzmAscmFtXN7b2_Y3o9_BpXC5L5KXyNze-SOzs8SCUx-lkKZEIKcXC8OLg
Message-ID: <CAHS8izNgfrN-MimH1uv349AqNudvQJoeOsyHpoBT_QokF3Zv=w@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of
 page to access ->pp in __netmem_get_pp()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, ilias.apalodimas@linaro.org, 
	harry.yoo@oracle.com, akpm@linux-foundation.org, andrew+netdev@lunn.ch, 
	asml.silence@gmail.com, toke@redhat.com, david@redhat.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	jackmanb@google.com, wei.fang@nxp.com, shenwei.wang@nxp.com, 
	xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com, 
	tariqt@nvidia.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, 
	mbloch@nvidia.com, danishanwar@ti.com, rogerq@kernel.org, nbd@nbd.name, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, aleksander.lobakin@intel.com, 
	horms@kernel.org, m-malladi@ti.com, krzysztof.kozlowski@linaro.org, 
	matthias.schiffer@ew.tq-group.com, robh@kernel.org, imx@lists.linux.dev, 
	intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 6:36=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Mon, Jul 14, 2025 at 12:58:15PM -0700, Mina Almasry wrote:
> > On Mon, Jul 14, 2025 at 12:37=E2=80=AFPM Mina Almasry <almasrymina@goog=
le.com> wrote:
> > >
> > > On Mon, Jul 14, 2025 at 5:01=E2=80=AFAM Byungchul Park <byungchul@sk.=
com> wrote:
> > > >
> > > > To eliminate the use of the page pool fields in struct page, the pa=
ge
> > > > pool code should use netmem descriptor and APIs instead.
> > > >
> > > > However, __netmem_get_pp() still accesses ->pp via struct page.  So
> > > > change it to use struct netmem_desc instead, since ->pp no longer w=
ill
> > > > be available in struct page.
> > > >
> > > > While at it, add a helper, pp_page_to_nmdesc(), that can be used to
> > > > extract netmem_desc from page only if it's pp page.  For now that
> > > > netmem_desc overlays on page, it can be achieved by just casting.
> > > >
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > ---
> > > >  include/net/netmem.h | 13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > index 535cf17b9134..2b8a7b51ac99 100644
> > > > --- a/include/net/netmem.h
> > > > +++ b/include/net/netmem.h
> > > > @@ -267,6 +267,17 @@ static inline struct net_iov *__netmem_clear_l=
sb(netmem_ref netmem)
> > > >         return (struct net_iov *)((__force unsigned long)netmem & ~=
NET_IOV);
> > > >  }
> > > >
> > > > +static inline struct netmem_desc *pp_page_to_nmdesc(struct page *p=
age)
> > > > +{
> > > > +       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
> > > > +
> > > > +       /* XXX: How to extract netmem_desc from page must be change=
d,
> > > > +        * once netmem_desc no longer overlays on page and will be
> > > > +        * allocated through slab.
> > > > +        */
> > > > +       return (struct netmem_desc *)page;
> > > > +}
> > > > +
> > >
> > > Same thing. Do not create a generic looking pp_page_to_nmdesc helper
> > > which does not check that the page is the correct type. The
> > > DEBUG_NET... is not good enough.
> > >
> > > You don't need to add a generic helper here. There is only one call
> > > site. Open code this in the callsite. The one callsite is marked as
> > > unsafe, only called by code that knows that the netmem is specificall=
y
> > > a pp page. Open code this in the unsafe callsite, instead of creating
> > > a generic looking unsafe helper and not even documenting it's unsafe.
> > >
> >
> > On second read through the series, I actually now think this is a
> > great idea :-) Adding this helper has simplified the series greatly. I
> > did not realize you were converting entire drivers to netmem just to
> > get rid of page->pp accesses. Adding a pp_page_to_nmdesc helper makes
> > the entire series simpler.
> >
> > You're also calling it only from code paths like drivers that already
> > assumed that the page is a pp page and did page->pp deference without
> > a check, so this should be safe.
> >
> > Only thing I would change is add a comment explaining that the calling
> > code needs to check the page is pp page or know it's a pp page (like a
> > driver that supports pp).
> >
> >
> > > >  /**
> > > >   * __netmem_get_pp - unsafely get pointer to the &page_pool backin=
g @netmem
> > > >   * @netmem: netmem reference to get the pointer from
> > > > @@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clear_ls=
b(netmem_ref netmem)
> > > >   */
> > > >  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> > > >  {
> > > > -       return __netmem_to_page(netmem)->pp;
> > > > +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
> > > >  }
> > >
> > > This makes me very sad. Casting from netmem -> page -> nmdesc...
> > >
> > > Instead, we should be able to go from netmem directly to nmdesc. I
> > > would suggest rename __netmem_clear_lsb to netmem_to_nmdesc and have
> > > it return netmem_desc instead of net_iov. Then use it here.
> > >
> > > We could have an unsafe version of netmem_to_nmdesc which converts th=
e
> > > netmem to netmem_desc without clearing the lsb and mark it unsafe.
> > >
> >
> > This, I think, we should address to keep some sanity in the code and
> > reduce the casts and make it a bit more maintainable.
>
> I will reflect your suggestions.  To summarize:
>
>    1) The current implementation of pp_page_to_nmdesc() is good enough
>       to keep, but add a comment on it like "Check if the page is a pp
>       page before calling this function or know it's a pp page.".
>

Yes please.

>    2) Introduce the unsafe version, __netmem_to_nmdesc(), and use it in
>       __netmem_get_pp().
>

No need following Pavel's feedback. We can just delete
__netmem_get_pp. If we do find a need in the future to extract the
netmem_desc from a netmem_ref, I would rather we do a straight cast
from netmem_ref to netmem_desc rather than netmem_ref -> pages/net_iov
-> netmem_desc.

But that seems unnecessary for this series.


>    3) Rename __netmem_clear_lsb() to netmem_to_nmdesc(), and return
>       netmem_desc, and use it in all users of __netmem_clear_lsb().
>

Following Pavel's comment, this I think also is not necessary for this
series. Cleaning up the return value of __netmem_clear_lsb is good
work I think, but we're already on v10 of this and I think it would
unnecessary to ask for added cleanups. We can do the cleanup on top.

> Anything else?

Thank you very much :-)

--=20
Thanks,
Mina

