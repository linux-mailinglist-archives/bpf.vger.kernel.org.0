Return-Path: <bpf+bounces-63246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7F3B04829
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4B87A802E
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 19:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC2926A0DD;
	Mon, 14 Jul 2025 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvsJ6Q/T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266C2475E3
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523110; cv=none; b=TXKa0Zk5gmbK81wn94ITH8SRC00D5uAL65vyxYBMCvFzjpfhmVX5ouSdPRzeYd/7YsadvZYEhEAZRpdq/4c5wsZ83fdOllXAe4iuYRiGhnP1DrxFeAeMX3cWgdH6glLHCc79dXnZr3Ey6ApbkB5INr6bnWzcbmQBnDspbvR5k88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523110; c=relaxed/simple;
	bh=+pqyeAoD5157xnmPHhmqS7gq9lKU2DrmIZAQW9Mfn58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9yPcFvXRytXoWCwe30jqazwJrU2FjSObYCaEq+V2BqM8/qFhA7GrzWLL6/3a73o8rVa7Z+wSa+1qeqGTNEe2C0ZUH5cysfi/KSvQMDSxXMJeffkNaMjf0MjLe55Qaw0iUhT+/zdI8Nn7srDWq6O53/naepYEWNpc7QqC72ajj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvsJ6Q/T; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-237f18108d2so45905ad.0
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752523108; x=1753127908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDa5D0A4lwaiBKd2JNzdgebIMAD7+wg9x+lwbfz747o=;
        b=TvsJ6Q/TBr/xSzZ19yFXmoqEptr5c1imFBCqpPwSpUWlqJT6i+aKgrEXw62mYctkUR
         qrzflpNLMiqQjMEYHHJGRcTuN93QiAQkExL4kVrTrpVQB8gCy8BuFy7qNHPQDkRhBk/c
         j5e7PVO3d0zyrAouvz/L6ZNspf3+c0412LTkkvIHIBBTJQM3Ow4P3Bq9zxBpmjPNcWAx
         eRIrK9ADLtPiMGSB3wcGUpUXr8F5Xmr17MnYTkvmGiMNUVvBRfSf33RelrJD1vAMWdtr
         CqIlTOORaHKrt5c0RwLgkYeQ9rSjqm+lOFusQLH4zoRrcUO8R3SGQuCT6yXNIopoBk2E
         E81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752523108; x=1753127908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDa5D0A4lwaiBKd2JNzdgebIMAD7+wg9x+lwbfz747o=;
        b=p+h6FleAE5lqR6vy7awgjPGPsPsI+cL+8Iw6y4XcOfnZx2ClEukRj5Tyq1hqByJvxy
         9YpVJeAIQWH7GAgSwfh5OJsfumksMXMmtL04RT36e2cQvD5uNOAMm/ISGacqd+VdTutD
         +CoE2H5UxdmPjokxIVBIUiJF/vq0pR/4QPsCP4wsee2DJ/To1G6CIBdMifG6LY0oWI/g
         MkyRammzjxoiKyZJGvdRKzzDvWkwamUjruRCV+QrqofBnc0SLAmsjDNnmDrMj9myHsa9
         XjdyDlBLa7D21RUZoecFo1/SK3AYCaDy4g+u9u+23/45clXb4jTREcP5/7a6IIOR3X0X
         5O4A==
X-Forwarded-Encrypted: i=1; AJvYcCWdjJWbrUZjObj89LPXhtvIoo71EiQ5BqBEUzaWIrFVr09gGhCwNTQXBsW5NksjaNH1oVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdSBvUVg8c/gr3R1T3FTkliZRFVeDW/hkZmUfiIuHB3Kz0oQAg
	/LKyL7qgVk0DiauEl8teH4PJuDvzlXQWsXoWKpG+IN5YTTEBP82MQUrywGhHLEFr89CRmgZuVh0
	eN2OmL1NqqD/nDV0hlUj2vQKTcu5r/2cHz0cSI7g4
X-Gm-Gg: ASbGncutVo3weCg0di8N/HETcXF0V2sQRXm7hirWS6lldysQROgg3h06OfIy0BL+VNg
	BF7NgHeWH7SVyuGq0Ejf46BObsl+/zl117ZPokSxA55YJKuzdenhhnH2PlAhdXMF8xU0+HNWzmV
	kLAnumkLPt816lLe/i0TiDRNKmRcgVhjVJGDvAkOaQzQ/10hWBng6+5ACspE6OTkCDcpAFnGMbf
	MVoiqajVUeaM21P+APLy3igu2Nw3VK0DJPC0Al+cVYvUXZ9
X-Google-Smtp-Source: AGHT+IFWnfMDtJC2CezIF3KnAbgH/pbj3O5jwVGjDMwdXbeGoiYAzNm9r+9HSREvdPvfvdh1fRM05JSSpaSXXTed5k8=
X-Received: by 2002:a17:902:c40d:b0:235:e1fa:1fbc with SMTP id
 d9443c01a7336-23e1aa6bd1bmr603895ad.0.1752523107669; Mon, 14 Jul 2025
 12:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714120047.35901-1-byungchul@sk.com> <20250714120047.35901-3-byungchul@sk.com>
 <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
In-Reply-To: <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 14 Jul 2025 12:58:15 -0700
X-Gm-Features: Ac12FXz5nYW9H_RK0Nw_oICAspVAx9135uss8L0AQRp8qp4a_9a4RkfhL6o4a4I
Message-ID: <CAHS8izNh7aCJOb1WKTx7CXNDPv_UBqFyq2XEHHhqHH=5JPmJCQ@mail.gmail.com>
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

On Mon, Jul 14, 2025 at 12:37=E2=80=AFPM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> On Mon, Jul 14, 2025 at 5:01=E2=80=AFAM Byungchul Park <byungchul@sk.com>=
 wrote:
> >
> > To eliminate the use of the page pool fields in struct page, the page
> > pool code should use netmem descriptor and APIs instead.
> >
> > However, __netmem_get_pp() still accesses ->pp via struct page.  So
> > change it to use struct netmem_desc instead, since ->pp no longer will
> > be available in struct page.
> >
> > While at it, add a helper, pp_page_to_nmdesc(), that can be used to
> > extract netmem_desc from page only if it's pp page.  For now that
> > netmem_desc overlays on page, it can be achieved by just casting.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/net/netmem.h | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 535cf17b9134..2b8a7b51ac99 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -267,6 +267,17 @@ static inline struct net_iov *__netmem_clear_lsb(n=
etmem_ref netmem)
> >         return (struct net_iov *)((__force unsigned long)netmem & ~NET_=
IOV);
> >  }
> >
> > +static inline struct netmem_desc *pp_page_to_nmdesc(struct page *page)
> > +{
> > +       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
> > +
> > +       /* XXX: How to extract netmem_desc from page must be changed,
> > +        * once netmem_desc no longer overlays on page and will be
> > +        * allocated through slab.
> > +        */
> > +       return (struct netmem_desc *)page;
> > +}
> > +
>
> Same thing. Do not create a generic looking pp_page_to_nmdesc helper
> which does not check that the page is the correct type. The
> DEBUG_NET... is not good enough.
>
> You don't need to add a generic helper here. There is only one call
> site. Open code this in the callsite. The one callsite is marked as
> unsafe, only called by code that knows that the netmem is specifically
> a pp page. Open code this in the unsafe callsite, instead of creating
> a generic looking unsafe helper and not even documenting it's unsafe.
>

On second read through the series, I actually now think this is a
great idea :-) Adding this helper has simplified the series greatly. I
did not realize you were converting entire drivers to netmem just to
get rid of page->pp accesses. Adding a pp_page_to_nmdesc helper makes
the entire series simpler.

You're also calling it only from code paths like drivers that already
assumed that the page is a pp page and did page->pp deference without
a check, so this should be safe.

Only thing I would change is add a comment explaining that the calling
code needs to check the page is pp page or know it's a pp page (like a
driver that supports pp).


> >  /**
> >   * __netmem_get_pp - unsafely get pointer to the &page_pool backing @n=
etmem
> >   * @netmem: netmem reference to get the pointer from
> > @@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clear_lsb(ne=
tmem_ref netmem)
> >   */
> >  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> >  {
> > -       return __netmem_to_page(netmem)->pp;
> > +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
> >  }
>
> This makes me very sad. Casting from netmem -> page -> nmdesc...
>
> Instead, we should be able to go from netmem directly to nmdesc. I
> would suggest rename __netmem_clear_lsb to netmem_to_nmdesc and have
> it return netmem_desc instead of net_iov. Then use it here.
>
> We could have an unsafe version of netmem_to_nmdesc which converts the
> netmem to netmem_desc without clearing the lsb and mark it unsafe.
>

This, I think, we should address to keep some sanity in the code and
reduce the casts and make it a bit more maintainable.

--=20
Thanks,
Mina

