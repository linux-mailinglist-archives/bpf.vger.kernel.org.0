Return-Path: <bpf+bounces-50774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F105A2C650
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12CDC7A4C93
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A61238D3E;
	Fri,  7 Feb 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6MwczPh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B76238D30
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940149; cv=none; b=WsdIpDmuw5RZW+eBnJZqUcpjufj0qe8/HnpYhuFOMNj/E9vltPOi+7xoeapePDNVzqfZAGV65i+68v/xerBTZtRZW8RMr4IcTJg2lQs9mvyrQRsgq7dWOOmbbEV8VV5jgFljGM74T2KEGXWEHzLt04BHYhyXGu17x3BPxqPjWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940149; c=relaxed/simple;
	bh=ps1zzEkNImieF8mbHoTKbxIx4PanamP60WsGwxnYYWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYNx4VvmsAy3su7kVh7TnEq/jLJEd/VYzOYxZZgFdrOlD+V7e+nBO9taYLYSJpArTyXLI8FilrUv/UWrglZMgIrvO8BRWdNih3E6Q0VDy0mQ2DBkySiID+RGC4bhzz2BwoL0uqPQIoObWW9MwO5XgKUIp6LSnF2Lme08F1FTbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6MwczPh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeec07b705so375807266b.2
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738940146; x=1739544946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daaNvLMzn/C14SPQHtJPlMGQZX0eBHgUr4X9JmhBDFI=;
        b=d6MwczPh3qixMTJSmmI0xYIrQmuj40CPRK6Vt0AldkX3jOVeKyTsIhtr1/ExoYIJ0A
         bdTQ8dPGSFBnCRlQXwu4haim6RrmJd15N7J022/SxY9ydueWMhNUwDx9W/mJiysFRGJ1
         ai42TlxMf+6+sGAO/nwaKSq32AH1x/XbHxGUfng3PkoO8dNpNn94e9RJjPnLFqHyngSs
         n/F08LFP28hEllBLIhlG/e9B5UVPjHafM8XthggoRifl3CbyloVvB7r2SsUmZYgaVyyO
         Wt9pBj2+z4K/SFEQ8EyYhp54oF7tijFIkF6nT5JzXGB1R/Wu8qnpQft7c1k/55PchrDJ
         UmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738940146; x=1739544946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daaNvLMzn/C14SPQHtJPlMGQZX0eBHgUr4X9JmhBDFI=;
        b=WcUZOB9WeAf83eAaMqCPmbpAMwNTy2m6S8glysNXLLqQpZRtUINQbvwXW9wlgthPdy
         PjaQQ2JF+N/l5mz+yCMrpa8p1Z/aUHSvUVPUwiZISa/HUEatOLiqRvy3bsNIoDxel4S2
         EYtFYPb0IQWZY2Z8euFgFOwrsalb12FQA0ItzZlM6aAgc8+2Nr9DhAST2EzYvGzKmjvI
         /5EW6gPjKzs/BTNCK/V2XqJX6XUvbNcx6esCGqDLrV0yrhTpXlHg+QjNCU4xIS5DR6e4
         +c9TmGm0t1iKtOe71wAneRebWO6CCzlZHiQ3pXLRrU99ZdiReAbKBu0s1gTWJcnM8q1+
         x2Dw==
X-Forwarded-Encrypted: i=1; AJvYcCViYbBpvIVtXA+/hdtb7/xjKd+EexWQkgWVfq9yoCxKoOiD1UO/xjVR/hm9330AXcvQT8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK9XE6MgOuNDi74F1yRSJaL6iw0NUapqCB8w2rheqG+KbupwfG
	mUpypWGHSVC/+FNikkU1B+nQq+ToArITB+YXw/Jr5FLqrFvTxqxASGB7ixFOn2XTgMctRG+vZ4b
	gqKJpW1Wgk/krQR4CDV1MssU+mWzKinf9k9B/2o7w4sKm5NBefQ==
X-Gm-Gg: ASbGncv8k+FJdomw+Ddpm+aWGX36GTkU7PRh0IJKCP6JVMdOvg3ameRt/qQLEyyTfyO
	Ra6PwYp9ZbMBtv/dldHebvmbdsiNKa/RJVwuMH6E1+ctzpGb1NvvQ5pzA7Zkj8luMWoa42rS7
X-Google-Smtp-Source: AGHT+IFSsEet/4yJ/161O0Uvv6q3fbuknhI7ZPo2TFQ2ugoTZ1KvI6aQQGUzVl4jTas+kZyyjbO3zYDo95CL+8LTaLA=
X-Received: by 2002:a17:906:7954:b0:ab7:ad9:7baf with SMTP id
 a640c23a62f3a-ab789a65709mr445745066b.4.1738940146034; Fri, 07 Feb 2025
 06:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
 <20250205163609.3208829-2-aleksander.lobakin@intel.com> <CANn89iJjCOThDqwsK4v2O8LfcwAB55YohNZ8T2sR40uM2ZoX5w@mail.gmail.com>
 <fe1b0def-89d1-4db3-bf98-7d6c61ff5361@intel.com> <CANn89iJr1R4BGK2Qd+OEgsE7kEPi7X8tgyxjHnYoU7VOU_wgfA@mail.gmail.com>
 <3decafb9-34fe-4fb7-9203-259b813f810c@intel.com>
In-Reply-To: <3decafb9-34fe-4fb7-9203-259b813f810c@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 15:55:35 +0100
X-Gm-Features: AWEUYZnJnHzdvKxve0MJIVdVjA-1GeUXFloJeOiMB6oD9CE892YP9IKOO_loV8U
Message-ID: <CANn89iJNq2VC55c-DcA6YC-2EHYZoyov7EUXTHKF2fYy8-wW+w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/8] net: gro: decouple GRO from the NAPI layer
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 1:00=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Thu, 6 Feb 2025 19:35:50 +0100
>
> > On Thu, Feb 6, 2025 at 1:15=E2=80=AFPM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Eric Dumazet <edumazet@google.com>
> >> Date: Wed, 5 Feb 2025 18:48:50 +0100
> >>
> >>> On Wed, Feb 5, 2025 at 5:46=E2=80=AFPM Alexander Lobakin
> >>> <aleksander.lobakin@intel.com> wrote:
> >>>>
> >>>> In fact, these two are not tied closely to each other. The only
> >>>> requirements to GRO are to use it in the BH context and have some
> >>>> sane limits on the packet batches, e.g. NAPI has a limit of its
> >>>> budget (64/8/etc.).
> >>>> Move purely GRO fields into a new tagged group, &gro_node. Embed it
> >>>> into &napi_struct and adjust all the references. napi_id doesn't
> >>>> really belong to GRO, but:
> >>>>
> >>>> 1. struct gro_node has a 4-byte padding at the end anyway. If you
> >>>>    leave napi_id outside, struct napi_struct takes additional 8 byte=
s
> >>>>    (u32 napi_id + another 4-byte padding).
> >>>> 2. gro_receive_skb() uses it to mark skbs. We don't want to split it
> >>>>    into two functions or add an `if`, as this would be less efficien=
t,
> >>>>    but we need it to be NAPI-independent. The current approach doesn=
't
> >>>>    change anything for NAPI-backed GROs; for standalone ones (which
> >>>>    are less important currently), the embedded napi_id will be just
> >>>>    zero =3D> no-op.
> >>>>
> >>>> Three Ethernet drivers use napi_gro_flush() not really meant to be
> >>>> exported, so move it to <net/gro.h> and add that include there.
> >>>> napi_gro_receive() is used in more than 100 drivers, keep it
> >>>> in <linux/netdevice.h>.
> >>>> This does not make GRO ready to use outside of the NAPI context
> >>>> yet.
> >>>>
> >>>> Tested-by: Daniel Xu <dxu@dxuuu.xyz>
> >>>> Acked-by: Jakub Kicinski <kuba@kernel.org>
> >>>> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>>> ---
> >>>>  include/linux/netdevice.h                  | 26 +++++---
> >>>>  include/net/busy_poll.h                    | 11 +++-
> >>>>  include/net/gro.h                          | 35 +++++++----
> >>>>  drivers/net/ethernet/brocade/bna/bnad.c    |  1 +
> >>>>  drivers/net/ethernet/cortina/gemini.c      |  1 +
> >>>>  drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |  1 +
> >>>>  net/core/dev.c                             | 60 ++++++++-----------
> >>>>  net/core/gro.c                             | 69 +++++++++++--------=
---
> >>>>  8 files changed, 112 insertions(+), 92 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >>>> index 2a59034a5fa2..d29b6ebde73f 100644
> >>>> --- a/include/linux/netdevice.h
> >>>> +++ b/include/linux/netdevice.h
> >>>> @@ -340,8 +340,8 @@ struct gro_list {
> >>>>  };
> >>>>
> >>>>  /*
> >>>> - * size of gro hash buckets, must less than bit number of
> >>>> - * napi_struct::gro_bitmask
> >>>> + * size of gro hash buckets, must be <=3D the number of bits in
> >>>> + * gro_node::bitmask
> >>>>   */
> >>>>  #define GRO_HASH_BUCKETS       8
> >>>>
> >>>> @@ -370,7 +370,6 @@ struct napi_struct {
> >>>>         unsigned long           state;
> >>>>         int                     weight;
> >>>>         u32                     defer_hard_irqs_count;
> >>>> -       unsigned long           gro_bitmask;
> >>>>         int                     (*poll)(struct napi_struct *, int);
> >>>>  #ifdef CONFIG_NETPOLL
> >>>>         /* CPU actively polling if netpoll is configured */
> >>>> @@ -379,11 +378,14 @@ struct napi_struct {
> >>>>         /* CPU on which NAPI has been scheduled for processing */
> >>>>         int                     list_owner;
> >>>>         struct net_device       *dev;
> >>>> -       struct gro_list         gro_hash[GRO_HASH_BUCKETS];
> >>>>         struct sk_buff          *skb;
> >>>> -       struct list_head        rx_list; /* Pending GRO_NORMAL skbs =
*/
> >>>> -       int                     rx_count; /* length of rx_list */
> >>>> -       unsigned int            napi_id; /* protected by netdev_lock=
 */
> >>>> +       struct_group_tagged(gro_node, gro,
> >>>> +               unsigned long           bitmask;
> >>>> +               struct gro_list         hash[GRO_HASH_BUCKETS];
> >>>> +               struct list_head        rx_list; /* Pending GRO_NORM=
AL skbs */
> >>>> +               int                     rx_count; /* length of rx_li=
st */
> >>>> +               u32                     napi_id; /* protected by net=
dev_lock */
> >>>> +
> >>>
> >>> I am old school, I would prefer a proper/standalone old C construct.
> >>>
> >>> struct gro_node  {
> >>>                 unsigned long           bitmask;
> >>>                struct gro_list         hash[GRO_HASH_BUCKETS];
> >>>                struct list_head        rx_list; /* Pending GRO_NORMAL=
 skbs */
> >>>                int                     rx_count; /* length of rx_list=
 */
> >>>                u32                     napi_id; /* protected by netde=
v_lock */
> >>> };
> >>>
> >>> Really, what struct_group_tagged() can possibly bring here, other tha=
n
> >>> obfuscation ?
> >>
> >> You'd need to adjust every ->napi_id access, which is a lot.
> >> Plus, as I wrote previously, napi_id doesn't really belong here, but
> >> embedding it here eases life.
> >>
> >> I'm often an old school, too, but sometimes this helps a lot.
> >> Unless you have very strong preference on this.
> >>
> >
> > Is struct_group_tagged even supported by ctags ?
> >
> > In terms of maintenance, I am sorry to say this looks bad to me.
> >
> > Even without ctags, I find git grep -n "struct xxxx {" quite good.
>
> compile_commands.json (already supported natively by Kbuild) + clangd is
> not enough?
>
> Elixir correctly tags struct_group()s.
>
> napi->napi_id is used in a lot of core files and drivers, adjusting all
> the references is not what I wanted to do in the series which does
> completely different things.

Leave napi_id in struct napi, it has nothing to do with gro.

>
> Page Pool uses tagged struct groups, as well a ton of other different
> files. Do you want to revert all this and adjust a couple thousand
> references only due to ctags and grep?
>
> (instead of just clicking on the references generated by clangd)

I obviously can not catch all netdev traffic.

