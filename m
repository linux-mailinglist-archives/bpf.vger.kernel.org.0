Return-Path: <bpf+bounces-6328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2947680E2
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 20:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF91282165
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1865E174D1;
	Sat, 29 Jul 2023 18:04:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A015BD;
	Sat, 29 Jul 2023 18:04:30 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193DE7A;
	Sat, 29 Jul 2023 11:04:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b974031aeaso47416631fa.0;
        Sat, 29 Jul 2023 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690653867; x=1691258667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5zTJ2m7y4gUPHPHwEYR3KU4kKwzaZIM/2cgPL3RDIA=;
        b=M2lZREb6f3m5/J3yggEV0YpjtZOqHpuL7AvHoDm3iAu9g6ry+ZnHop+roInlkEfEGv
         5xUUFHWV141rwPCccFt4EdcNLGXm8zvkOVlps29wRkGZIEV6PASVfJqz76ZPoz5tMifX
         9hk9gs7IgpUEMlMayt1yZ0Uu0DPxA1LYojqoyVKr3v1x0GE8qmwg4KodObhvoiIfBVkL
         agwv+QeG7RkYvxinIwSMEyWExnwRK8LFbEvV7eD8lWi+ZT+lQ/rRd+2618Bhw9bZxn94
         1nTkghnOZQ6qyM3WLhUAOn3DYxVNaO2TtShV1Rrndmelkj1ftAZCEIuIcoserIy1WpM1
         BPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690653867; x=1691258667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5zTJ2m7y4gUPHPHwEYR3KU4kKwzaZIM/2cgPL3RDIA=;
        b=LIWkyfjTJWUvsxLCVTIN90D/CVTbpEjzf38O77ns5h3TMRvNM8AXHNrqr7I/7kK+v8
         tPGEbXTzYuyqvj75V6tXgq1xJywHDsPVfK7R8qa9VIhg5WqmhSjGBiVAxU883dgBvBSI
         fDyG/8lOqUX3s6WsgS+8UYUAIY/QRCSje3fF+EVCXK3sx0VtcRHfC6QIHsOe8gMa1jnT
         +o+ZkKEEoYu8+nW0PazcSwbmZaYirQoaacdTTPhulDxXUdPS4D+qCZ0IL4wVunVK5DK6
         dYhuBXBy4hPdTJU9t0ook/ceVJylajSJ6ZRV08dZzq4rZst1ZkPPp0OGVGDM6DiJVQYs
         FZ2w==
X-Gm-Message-State: ABy/qLbS2rTodlkrIjC4U69Jl1G8muogT8Uj/F/Ts+6sfj017cePQ5TV
	zwgVqI7SxL+eGIUr/aTmNqI+7WwjsPvA2QCvEMc=
X-Google-Smtp-Source: APBJJlEm83JwHBYnqV6b7FBIR3SRFxDWJ6rYq6OTRiXSBhRaERzeQ19BCZN38MMYIu5hnlC5x9ZdNpHfci2S1K/69kk=
X-Received: by 2002:a2e:978f:0:b0:2b9:b066:66a4 with SMTP id
 y15-20020a2e978f000000b002b9b06666a4mr3871153lji.4.1690653867374; Sat, 29 Jul
 2023 11:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
 <20230728173923.1318596-13-larysa.zaremba@intel.com> <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
 <64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch>
In-Reply-To: <64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 29 Jul 2023 11:04:16 -0700
Message-ID: <CAADnVQ+vn0=1UT5_c628ovq+LzfrNFf0MxmZn++NqeUFJ-ykQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, Network Development <netdev@vger.kernel.org>, 
	Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 9:15=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Alexei Starovoitov wrote:
> > On Fri, Jul 28, 2023 at 07:39:14PM +0200, Larysa Zaremba wrote:
> > >
> > > +union xdp_csum_info {
> > > +   /* Checksum referred to by ``csum_start + csum_offset`` is consid=
ered
> > > +    * valid, but was never calculated, TX device has to do this,
> > > +    * starting from csum_start packet byte.
> > > +    * Any preceding checksums are also considered valid.
> > > +    * Available, if ``status =3D=3D XDP_CHECKSUM_PARTIAL``.
> > > +    */
> > > +   struct {
> > > +           u16 csum_start;
> > > +           u16 csum_offset;
> > > +   };
> > > +
> >
> > CHECKSUM_PARTIAL makes sense on TX, but this RX. I don't see in the abo=
ve.
>
> It can be observed on RX when packets are looped.
>
> This may be observed even in XDP on veth.

veth and XDP is a broken combination. GSO packets coming out of containers
cannot be parsed properly by XDP.
It was added mainly for testing. Just like "generic XDP".
bpf progs at skb layer is much better fit for veth.

> > > +   /* Checksum, calculated over the whole packet.
> > > +    * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > > +    */
> > > +   u32 checksum;
> >
> > imo XDP RX should only support XDP_CHECKSUM_COMPLETE with u32 checksum
> > or XDP_CHECKSUM_UNNECESSARY.
> >
> > > +};
> > > +
> > > +enum xdp_csum_status {
> > > +   /* HW had parsed several transport headers and validated their
> > > +    * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
> > > +    * 3 least significant bytes contain number of consecutive checks=
ums,
> > > +    * starting with the outermost, reported by hardware as valid.
> > > +    * ``sk_buff`` checksum level (``csum_level``) notation is provid=
ed
> > > +    * for driver developers.
> > > +    */
> > > +   XDP_CHECKSUM_VALID_LVL0         =3D 1,    /* 1 outermost checksum=
 */
> > > +   XDP_CHECKSUM_VALID_LVL1         =3D 2,    /* 2 outermost checksum=
s */
> > > +   XDP_CHECKSUM_VALID_LVL2         =3D 3,    /* 3 outermost checksum=
s */
> > > +   XDP_CHECKSUM_VALID_LVL3         =3D 4,    /* 4 outermost checksum=
s */
> > > +   XDP_CHECKSUM_VALID_NUM_MASK     =3D GENMASK(2, 0),
> > > +   XDP_CHECKSUM_VALID              =3D XDP_CHECKSUM_VALID_NUM_MASK,
> >
> > I don't see what bpf prog suppose to do with these levels.
> > The driver should pick between 3:
> > XDP_CHECKSUM_UNNECESSARY, XDP_CHECKSUM_COMPLETE, XDP_CHECKSUM_NONE.
> >
> > No levels and no anything partial. please.
>
> This levels business is an unfortunate side effect of
> CHECKSUM_UNNECESSARY. For a packet with multiple checksum fields, what
> does the boolean actually mean? With these levels, at least that is
> well defined: the first N checksum fields.

If I understand this correctly this is intel specific feature that
other NICs don't have. skb layer also doesn't have such concept.
The driver should say CHECKSUM_UNNECESSARY when it's sure
or don't pretend that it checks the checksum and just say NONE.

