Return-Path: <bpf+bounces-14477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3BA7E551B
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 12:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093AF281647
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044B16411;
	Wed,  8 Nov 2023 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+LDNwoM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD65015EB7
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 11:21:50 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F0A1BD5
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 03:21:50 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67131800219so45989226d6.3
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 03:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699442509; x=1700047309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WbK1qQZMhL0UyUEskip3O7w49fLhRM2vZKP3ZSvFYk=;
        b=H+LDNwoMcxULQSifPL1N9H+HbdxJKCnvtZ9KvOaHOuU4WMisVx0wWTiYuih//dVrI4
         KXHHgQ2KNlZv2eEdVkTeDEF3Ykdq+QJsz/Exnn9QNPL0yiwRKQftxxqYBgv8XDwUZl+l
         eXCIYbH9hNP31ayNOl08cPlusiDzgMLuX7NUVgI52IJ7O+bv8g3PpkFP4rpZll9PvBO3
         2pILoXmhu7DzX2WQOEiMZ+0yFhahFgDtNyRMbAWXltRM72m0oLuYVrzvSyHj5mWDJ4PR
         B6n7BFFCg1gE779lW9BGNztKZavSGn6vP4auZsQs10iJd54vlcxlTG5SjE1Qv4APwdmc
         OBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699442509; x=1700047309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WbK1qQZMhL0UyUEskip3O7w49fLhRM2vZKP3ZSvFYk=;
        b=bRTH+DtjEgDGATdUAoIN8sfpw+n2UlTvfMaQHjj2ZrJhfP2LOksxgZGe7FXeD8afZ1
         IjfHVFGCjd/zeTz3DMEONAgpsFvh+Zw7mUIeAwMOhASfAgpEtF5Rpw8Bz93ew/pTs4p7
         xnQiZqC211TrXH8dwzmm4BD3vgaPKHm6weyFUzjW+zO2YRhz13J6sJk79x7vnlplbqio
         N7cEdeTPbUlVJ0EdQDh+IHAkEBnMJSI6M45tgsYOBVb90aGf1cLqL6wv/sZ+kfCLL4lB
         WxBpkAk7y5uXC2YtUKHR5w+emszcW34Z51aS9cTWMUoIdb7T3qfg4hT1pY3a1/A8R4un
         VsNw==
X-Gm-Message-State: AOJu0YxYwgPSGcVsaGAnpPC714NkaD1nTBL6Ynj9DFWkAGb/uuDQi98N
	HtMSMSOw0lpG2E4W+hT/LCkDfIGkPBTL16wpQVY+oelvyjSJgWtqGsgifw==
X-Google-Smtp-Source: AGHT+IHkM7Zz9YGVd5cg0w5zMDhUonnSmd8ty3Bmuen4IPcSzWl3Y7Bi/ii33xTS0GXdtkoqowbiW20l1cdep/WcKvs=
X-Received: by 2002:ad4:5967:0:b0:66d:949d:717e with SMTP id
 eq7-20020ad45967000000b0066d949d717emr1544322qvb.42.1699442509189; Wed, 08
 Nov 2023 03:21:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103112237.1756288-1-anders.roxell@linaro.org> <CAEf4BzahAuskkD9YqxQpZDaUcu_jTuNAfbkkwP4dzJH=cTaVKA@mail.gmail.com>
In-Reply-To: <CAEf4BzahAuskkD9YqxQpZDaUcu_jTuNAfbkkwP4dzJH=cTaVKA@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 8 Nov 2023 12:21:38 +0100
Message-ID: <CADYN=9+koLV3eg85hVBkRtiAuygyngWxWChpnh=iUPVH4JeTjg@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: xskxceiver: ksft_print_msg: fix format
 type error
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Nov 2023 at 17:26, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Fri, Nov 3, 2023 at 4:23=E2=80=AFAM Anders Roxell <anders.roxell@linar=
o.org> wrote:
> >
> > Crossbuilding selftests/bpf for architecture arm64, format specifies
> > type error show up like.
> >
> > xskxceiver.c:912:34: error: format specifies type 'int' but the argumen=
t
> > has type '__u64' (aka 'unsigned long long') [-Werror,-Wformat]
> >  ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
> >                                                                 ~~
> >                                                                 %llu
> >                 __func__, pkt->pkt_nb, meta->count);
> >                                        ^~~~~~~~~~~
> > xskxceiver.c:929:55: error: format specifies type 'unsigned long long' =
but
> >  the argument has type 'u64' (aka 'unsigned long') [-Werror,-Wformat]
> >  ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
> >                                     ~~~~             ^~~~
> >
>
> With u64s it might be %llx or %lx, depending on architecture, so best
> is to force cast to (long long) or (unsigned long long) and then use
> %llx.

Thank you Andrii,
v2 posted https://lore.kernel.org/bpf/20231108110048.1988128-1-anders.roxel=
l@linaro.org/T/#u

Cheers,
Anders

>
> > Fixing the issues by using the proposed format specifiers by the
> > compilor.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/s=
elftests/bpf/xskxceiver.c
> > index 591ca9637b23..dc03692f34d8 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -908,7 +908,7 @@ static bool is_metadata_correct(struct pkt *pkt, vo=
id *buffer, u64 addr)
> >         struct xdp_info *meta =3D data - sizeof(struct xdp_info);
> >
> >         if (meta->count !=3D pkt->pkt_nb) {
> > -               ksft_print_msg("[%s] expected meta_count [%d], got meta=
_count [%d]\n",
> > +               ksft_print_msg("[%s] expected meta_count [%d], got meta=
_count [%llu]\n",
> >                                __func__, pkt->pkt_nb, meta->count);
> >                 return false;
> >         }
> > @@ -926,11 +926,11 @@ static bool is_frag_valid(struct xsk_umem_info *u=
mem, u64 addr, u32 len, u32 exp
> >
> >         if (addr >=3D umem->num_frames * umem->frame_size ||
> >             addr + len > umem->num_frames * umem->frame_size) {
> > -               ksft_print_msg("Frag invalid addr: %llx len: %u\n", add=
r, len);
> > +               ksft_print_msg("Frag invalid addr: %lx len: %u\n", addr=
, len);
> >                 return false;
> >         }
> >         if (!umem->unaligned_mode && addr % umem->frame_size + len > um=
em->frame_size) {
> > -               ksft_print_msg("Frag crosses frame boundary addr: %llx =
len: %u\n", addr, len);
> > +               ksft_print_msg("Frag crosses frame boundary addr: %lx l=
en: %u\n", addr, len);
> >                 return false;
> >         }
> >
> > @@ -1029,7 +1029,7 @@ static int complete_pkts(struct xsk_socket_info *=
xsk, int batch_size)
> >                         u64 addr =3D *xsk_ring_cons__comp_addr(&xsk->um=
em->cq, idx + rcvd - 1);
> >
> >                         ksft_print_msg("[%s] Too many packets completed=
\n", __func__);
> > -                       ksft_print_msg("Last completion address: %llx\n=
", addr);
> > +                       ksft_print_msg("Last completion address: %lx\n"=
, addr);
> >                         return TEST_FAILURE;
> >                 }
> >
> > @@ -1513,7 +1513,7 @@ static int validate_tx_invalid_descs(struct ifobj=
ect *ifobject)
> >         }
> >
> >         if (stats.tx_invalid_descs !=3D ifobject->xsk->pkt_stream->nb_p=
kts / 2) {
> > -               ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%=
u] expected [%u]\n",
> > +               ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%=
llu] expected [%u]\n",
> >                                __func__, stats.tx_invalid_descs,
> >                                ifobject->xsk->pkt_stream->nb_pkts);
> >                 return TEST_FAILURE;
> > --
> > 2.42.0
> >
> >

