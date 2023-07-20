Return-Path: <bpf+bounces-5477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF1375B22C
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC045281F42
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AABF18B18;
	Thu, 20 Jul 2023 15:15:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F10B18B07;
	Thu, 20 Jul 2023 15:15:08 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A618A26BB;
	Thu, 20 Jul 2023 08:15:05 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b74310566cso13949591fa.2;
        Thu, 20 Jul 2023 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689866104; x=1690470904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1l5TEs8O2Bmwb7N0EKATA/T4FRIfe+wkS7cFTHp0KM=;
        b=oRS5aKZcfXVjCO7ZDsB5uEJ8T9TgkgPinbYgMwGtd6jcRjrRzBnA+oJgYuOsWxk1Js
         8hqrBFM9EcNaGhzZgFziWlqCOc7inL61Qvinauw2G54bFJSSmlmPY9oPS9K7lOi1rMgV
         wiceWcw5gJI4MVuvjC2v45ZljaYc2XzHmTe3LGxUVN0DqR21kIQJqmCLlBXEzROSkGzJ
         asfxqboqmfxdKbYyhV+KElm4VxB6LwZfjTk0Ogjrk66A5VGoLvT25oVDJ6MDu6zgGuvH
         1kN+/e4NchMZc6QGOZIs031TSN53JgZJhxM5Cc8xmp0+FsRgT6fE3+wxTA8aNNJr4srY
         nOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866104; x=1690470904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1l5TEs8O2Bmwb7N0EKATA/T4FRIfe+wkS7cFTHp0KM=;
        b=BZjSbV2qMVYIiCkaqI9uBg9X8lyRIv1E2ThEdkzvsE//tF8mAITH+EeHPcKxqa1oXx
         twC3/OGyG7BTZ02wvHUPMp3Fz5wlw+zsjSUPkM+Exwn/viUcEnKfrxehoYAI2CXMrc0S
         yp2EoBWWy2i5HFeEn/13YoRPjeMkUF+DZ09pC5H7Cyr1FGQt8HzkIj18NkCupfwyb5xb
         OyQU7i7EbFoGo3YjFMqUHa9mqcPspdLSuCPga5Xy6lGvmtt6OrNPvg/Ig6+EX8IQYWjw
         Iu6eILzRXwRcUv6O1eKbKF73mXMzH9nDYA3nXnoyC+0T5JaXa7cLxYDDARa8x5M9wAff
         UmWw==
X-Gm-Message-State: ABy/qLZ+Pt08gR9P2JUAMa3o8/6nbgVP1iE8edKzWlGrvNh6jSH7Unwb
	/FtuWsq0e5Z6ZqlxfN/TewNmPa7LQ52lRh1qyvE=
X-Google-Smtp-Source: APBJJlGjV4ErpFCLAKQauNQbw4vr8ehpjn3LJbPIuBAZy8S/+6jqmNPLQ4fok1WXhYuSL3eRuUCe585RyimQLDsDmDA=
X-Received: by 2002:a2e:8e85:0:b0:2b6:e13f:cfd7 with SMTP id
 z5-20020a2e8e85000000b002b6e13fcfd7mr2781587ljk.4.1689866103479; Thu, 20 Jul
 2023 08:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-14-larysa.zaremba@intel.com> <20230719185930.6adapqctxfdsfmye@macbook-pro-8.dhcp.thefacebook.com>
 <64b85ad52d012_2849c1294df@willemb.c.googlers.com.notmuch> <ZLkBrfex1ENbVDwF@lincoln>
In-Reply-To: <ZLkBrfex1ENbVDwF@lincoln>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 20 Jul 2023 08:14:52 -0700
Message-ID: <CAADnVQKF3j-_qLM4MWkJKK=ZyPuWrLnmGfgf9BC4zm-4=1qSfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 13/21] ice: Implement checksum hint
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@google.com" <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, "Brouer, Jesper" <brouer@redhat.com>, 
	"Burakov, Anatoly" <anatoly.burakov@intel.com>, 
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>, 
	"Tahhan, Maryam" <mtahhan@redhat.com>, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 2:47=E2=80=AFAM Zaremba, Larysa
<larysa.zaremba@intel.com> wrote:
>
> On Wed, Jul 19, 2023 at 05:51:17PM -0400, Willem de Bruijn wrote:
> > Alexei Starovoitov wrote:
> > > On Wed, Jul 19, 2023 at 08:37:26PM +0200, Larysa Zaremba wrote:
> > > > Implement .xmo_rx_csum callback to allow XDP code to determine,
> > > > whether HW has validated any checksums.
> > > >
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 29 +++++++++++++++=
++++
> > > >  1 file changed, 29 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/driver=
s/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > index 54685d0747aa..6647a7e55ac8 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > @@ -660,8 +660,37 @@ static int ice_xdp_rx_vlan_tag(const struct xd=
p_md *ctx, u16 *vlan_tci,
> > > >   return 0;
> > > >  }
> > > >
> > > > +/**
> > > > + * ice_xdp_rx_csum_lvl - Get level, at which HW has checked the ch=
ecksum
> > > > + * @ctx: XDP buff pointer
> > > > + * @csum_status: destination address
> > > > + * @csum_info: destination address
> > > > + *
> > > > + * Copy HW checksum level (if was checked) to the destination addr=
ess.
> > > > + */
> > > > +static int ice_xdp_rx_csum(const struct xdp_md *ctx,
> > > > +                    enum xdp_csum_status *csum_status,
> > > > +                    union xdp_csum_info *csum_info)
> > > > +{
> > > > + const struct ice_xdp_buff *xdp_ext =3D (void *)ctx;
> > > > + const union ice_32b_rx_flex_desc *eop_desc;
> > > > + enum ice_rx_csum_status status;
> > > > + u16 ptype;
> > > > +
> > > > + eop_desc =3D xdp_ext->pkt_ctx.eop_desc;
> > > > + ptype =3D ice_get_ptype(eop_desc);
> > > > +
> > > > + status =3D ice_get_rx_csum_status(eop_desc, ptype);
> > > > + if (status & ICE_RX_CSUM_NONE)
> > > > +         return -ENODATA;
> > > > +
> > > > + *csum_status =3D ice_rx_csum_lvl(status) + 1;
> > > > + return 0;
> > > > +}
> > >
> > > and xdp_csum_info from previous patch left uninitialized?
> > > What was the point adding it then?
> >
> > I suppose this driver only returns CHECKSUM_NONE or
> > CHECKSUM_UNNECESSARY? Also based on a grep of the driver dir.
> >
>
> Yes, correct, current ice HW cannot produce complete checksum,
> so only CHECKSUM_UNNECESSARY for known protocols, CHECKSUM_NONE otherwise=
,
> nothing to initialize csum_info with in either case.
>
> xdp_csum_info is initialized in veth implementation though, but only
> csum_start/offset, so complete XDP checksum has no users in this patchset=
.
> Is this a problem?
>
> In previous version I had CHECKSUM_UNNECESSARY-only kfunc, but I think ev=
eryone
> has agreed, csum hint kfunc should give more comprehensive output.

csum kfunc supposed to be generic.
If for ICE it fills in one argument and for veth another then the whole
idea of generic api is not working.

