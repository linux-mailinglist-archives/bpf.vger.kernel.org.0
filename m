Return-Path: <bpf+bounces-5550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4B875B9EC
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 23:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310611C21567
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 21:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527B1DDCA;
	Thu, 20 Jul 2023 21:58:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34BF1DDC1
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 21:58:38 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4518FB3
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 14:58:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5734d919156so12044277b3.3
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689890316; x=1690495116;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVqsKiDGGyRuOmTeLPncQrsFy4D8GwAEfz5C9fRML5g=;
        b=53MZ45pv9s/lbOh54pc3nyaV2Fk3D490BFdzIDBeWLEJ+qsdUbG4czC40DQCJwZmeO
         412GR8rQc/mMklzTVvXMd023lmISGCJzObcgDpw47jyVnRiJQWXGVOzafHt0E6z+jI7I
         N1WHul0IUXzxtFV4WwKoNW/fEk5HNdOcuWfdsTl9r6iS/S3lf+EVd+mBzXQ+ZaXGc57s
         Q1ghnAZujLXwDqGbjzl7332cQtVAVgiQN7lFpdUZIau9HrB9j5UtVGiz0PpCSFZuidTw
         dGLQS87AYkWrwOnuh43puqDy60aT0rq2aBW10RyyK8IIdyQBSrsdurMW+DpWBNAEFFT1
         dN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689890316; x=1690495116;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tVqsKiDGGyRuOmTeLPncQrsFy4D8GwAEfz5C9fRML5g=;
        b=TC/J5OPa2RsNcbsqL+qLPGsBZfLNAEN+qdqVAOmf9J6nXl5M4nrmC1XWJ8Od+amZ+O
         7y96UjIz8JtTuE+B8XkG0L3G9KetfprNLBCaOYS4W4awp1/JJDifrFoqASDBVkH/YYGs
         16MI1wyM5qOdaegzMvhHrBT4rDbvLO19znLRhYINjqpcX0qW2qVHXBlZ4qtZsriD9JmD
         UDuVnJPT7VlbluFz8i9KaAplva+11YPD2TmZh3XB5wcQuwbimixeTSUI6Xrfmf7sS7I7
         liJdJtqrZEXVytfCraVq+dqBYnQi7J0NT4hwXolDusVAY62djr7ffrwpRY4F0ruhnPLF
         vWgw==
X-Gm-Message-State: ABy/qLYxxKtI8yqzYws6NPwyeorN4MZJ7G3b2i7Swjh7auubuvSqUoV0
	1JaPc+CRi/Dmy3XPV7y3n1/TuoE=
X-Google-Smtp-Source: APBJJlFnPjif4P2ACv5CDhVcYza8zWcXqFfCqEwNexz05Y34bSM0nw25yn4DKKm0a7ShLcYdlhXcDYE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:72c:b0:56c:e2da:f440 with SMTP id
 bt12-20020a05690c072c00b0056ce2daf440mr3839ywb.0.1689890316520; Thu, 20 Jul
 2023 14:58:36 -0700 (PDT)
Date: Thu, 20 Jul 2023 14:58:35 -0700
In-Reply-To: <ZLlUyJdj50UqFM0m@lincoln>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-14-larysa.zaremba@intel.com> <20230719185930.6adapqctxfdsfmye@macbook-pro-8.dhcp.thefacebook.com>
 <64b85ad52d012_2849c1294df@willemb.c.googlers.com.notmuch>
 <ZLkBrfex1ENbVDwF@lincoln> <CAADnVQKF3j-_qLM4MWkJKK=ZyPuWrLnmGfgf9BC4zm-4=1qSfw@mail.gmail.com>
 <ZLlUyJdj50UqFM0m@lincoln>
Message-ID: <ZLmstKiYO7LH9mXt@google.com>
Subject: Re: [PATCH bpf-next v3 13/21] ice: Implement checksum hint
From: Stanislav Fomichev <sdf@google.com>
To: larysa.zaremba@intel.com
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, brouer@redhat.com, 
	anatoly.burakov@intel.com, aleksander.lobakin@intel.com, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, mtahhan@redhat.com, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/20, Zaremba, Larysa wrote:
> On Thu, Jul 20, 2023 at 08:14:52AM -0700, Alexei Starovoitov wrote:
> > On Thu, Jul 20, 2023 at 2:47=E2=80=AFAM Zaremba, Larysa
> > <larysa.zaremba@intel.com> wrote:
> > >
> > > On Wed, Jul 19, 2023 at 05:51:17PM -0400, Willem de Bruijn wrote:
> > > > Alexei Starovoitov wrote:
> > > > > On Wed, Jul 19, 2023 at 08:37:26PM +0200, Larysa Zaremba wrote:
> > > > > > Implement .xmo_rx_csum callback to allow XDP code to determine,
> > > > > > whether HW has validated any checksums.
> > > > > >
> > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > ---
> > > > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 29 +++++++++++=
++++++++
> > > > > >  1 file changed, 29 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/dr=
ivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > > index 54685d0747aa..6647a7e55ac8 100644
> > > > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > > @@ -660,8 +660,37 @@ static int ice_xdp_rx_vlan_tag(const struc=
t xdp_md *ctx, u16 *vlan_tci,
> > > > > >   return 0;
> > > > > >  }
> > > > > >
> > > > > > +/**
> > > > > > + * ice_xdp_rx_csum_lvl - Get level, at which HW has checked th=
e checksum
> > > > > > + * @ctx: XDP buff pointer
> > > > > > + * @csum_status: destination address
> > > > > > + * @csum_info: destination address
> > > > > > + *
> > > > > > + * Copy HW checksum level (if was checked) to the destination =
address.
> > > > > > + */
> > > > > > +static int ice_xdp_rx_csum(const struct xdp_md *ctx,
> > > > > > +                    enum xdp_csum_status *csum_status,
> > > > > > +                    union xdp_csum_info *csum_info)
> > > > > > +{
> > > > > > + const struct ice_xdp_buff *xdp_ext =3D (void *)ctx;
> > > > > > + const union ice_32b_rx_flex_desc *eop_desc;
> > > > > > + enum ice_rx_csum_status status;
> > > > > > + u16 ptype;
> > > > > > +
> > > > > > + eop_desc =3D xdp_ext->pkt_ctx.eop_desc;
> > > > > > + ptype =3D ice_get_ptype(eop_desc);
> > > > > > +
> > > > > > + status =3D ice_get_rx_csum_status(eop_desc, ptype);
> > > > > > + if (status & ICE_RX_CSUM_NONE)
> > > > > > +         return -ENODATA;
> > > > > > +
> > > > > > + *csum_status =3D ice_rx_csum_lvl(status) + 1;
>=20
> I'll duplicate an improved version of this line from another thread in ca=
se it=20
> could help with the comprehension during review:
>=20
> *csum_status =3D XDP_CHECKSUM_VALID_LVL0 + ice_rx_csum_lvl(status);
>=20
> > > > > > + return 0;
> > > > > > +}
> > > > >
> > > > > and xdp_csum_info from previous patch left uninitialized?
> > > > > What was the point adding it then?
> > > >
> > > > I suppose this driver only returns CHECKSUM_NONE or
> > > > CHECKSUM_UNNECESSARY? Also based on a grep of the driver dir.
> > > >
> > >
> > > Yes, correct, current ice HW cannot produce complete checksum,
> > > so only CHECKSUM_UNNECESSARY for known protocols, CHECKSUM_NONE other=
wise,
> > > nothing to initialize csum_info with in either case.
> > >
> > > xdp_csum_info is initialized in veth implementation though, but only
> > > csum_start/offset, so complete XDP checksum has no users in this patc=
hset.
> > > Is this a problem?
> > >
> > > In previous version I had CHECKSUM_UNNECESSARY-only kfunc, but I thin=
k everyone
> > > has agreed, csum hint kfunc should give more comprehensive output.
> >=20
> > csum kfunc supposed to be generic.
> > If for ICE it fills in one argument and for veth another then the whole
> > idea of generic api is not working.
>=20
> Both ice and veth fill in the csum_status, the need to fill in the csum_i=
nfo is=20
> determined by the status. I don not see a problem with that.
>=20
> Maybe you have an issue with putting a valid checksum number into a statu=
s=20
> instead of info? Please clarify.

+1, that seems to match skb interface

Regarding 'generic api not working' in general: I think we've discussed
that with this 'flexible' kfunc format we can allow non-generic kfuncs for
specific devices if we think that it makes sense to
differentiate/experiment/etc. Do you think it makes sense to go
non-generic route here?

