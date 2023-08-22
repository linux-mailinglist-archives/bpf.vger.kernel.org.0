Return-Path: <bpf+bounces-8294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F003D784ADA
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A818228115A
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010B20197;
	Tue, 22 Aug 2023 19:50:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37F20180;
	Tue, 22 Aug 2023 19:50:43 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F56CD0;
	Tue, 22 Aug 2023 12:50:42 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so34584621fa.0;
        Tue, 22 Aug 2023 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733841; x=1693338641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPUn8ijFL4ffACYb95xD4mkXYZWaOkbHS7F5iWlewWU=;
        b=nEiMfxR3Y0C8ND2xRN1ZJt5md7vqRSgJDLwfYJguubsnh77dtUt3ULM1ooox0MlrgK
         /9sB09LAOKqdalKgrtFVpkFl0IQMh1+nZeilEy9xdDEXd9Zj/DKC7b6FxmSMeHh+ziLC
         7hkIBlJRe1QsV1VOk//PurOjV+f9DmtX9WNzKD9N1qjI4os054KveKCOmxVphKsQpT3t
         avgcGBWSyzFkFfAlTsWHROBV9IA0zVTDuMuXHliZ+sW/2c43Ms3bmhBHIQKgBpGA4dA4
         yPjb95zLggl/dm1FrfkD90oFMsBCKOxoAiiX7zvy5g3OfTibGjTCEbsfvDmAS3hvtB2r
         qQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733841; x=1693338641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPUn8ijFL4ffACYb95xD4mkXYZWaOkbHS7F5iWlewWU=;
        b=fwCs3O5YZBpwJoNHZpcPZSKg+mVX49SnQslkAnW1Ddaer0l6MmiicevDuVNsGax2UP
         Ir40FLHmHDdR8QSV4q4VxO7jTCXeufwb1wwV9s0IANlFz39coGCuVkkbR5Y6PNFif6O8
         SVwGCyUn1ufepowkKmk98bA6wyocjAo2blf8IY6oAqmxMbETQC5MGIDXnlmBWsyx1i5x
         2DBU15gk1hrtPGL0qXbRy5ZjHfZ535mNdK09IhzD0uRyrp5S1eX4WFJJd/coC1CTrq+G
         bvWe4lxwN0ZKXM1DnQMJsNvnw1UB+zrfsXq4a/p9y21lTzV4PzjCMveuWBrz+aWI47tU
         /7/w==
X-Gm-Message-State: AOJu0YyN97116GhJYQBmQlVRJtEPRUBncUnsYUuAq2UC66+u20++Myph
	7KskSQ+oxEx+qQy3ewUF3sGuLku/NHQtwp4UZbs=
X-Google-Smtp-Source: AGHT+IEJ9LuVf70FGV3AFmIOHwM9aObR3G/YtHhPhJVkI+zEwaF27USVSDtA+MMxFLMdkDCFUYkDFJTtj6/VVqkGTAg=
X-Received: by 2002:a2e:8553:0:b0:2b6:c8ba:90dc with SMTP id
 u19-20020a2e8553000000b002b6c8ba90dcmr7587812ljj.36.1692733840758; Tue, 22
 Aug 2023 12:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811161509.19722-1-larysa.zaremba@intel.com>
 <20230811161509.19722-14-larysa.zaremba@intel.com> <20230817215826.sx7t6mipx7pajuzo@macbook-pro-8.dhcp.thefacebook.com>
 <ZOR6uoYKRPEKGKED@lincoln>
In-Reply-To: <ZOR6uoYKRPEKGKED@lincoln>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Aug 2023 12:50:29 -0700
Message-ID: <CAADnVQLNeO81zc4f_z_UDCi+tJ2LS4dj2E1+au5TbXM+CPSyXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 13/21] ice: Implement checksum hint
To: Larysa Zaremba <larysa.zaremba@intel.com>, Saeed Mahameed <saeed@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, Network Development <netdev@vger.kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 2:13=E2=80=AFAM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Thu, Aug 17, 2023 at 02:58:26PM -0700, Alexei Starovoitov wrote:
> > On Fri, Aug 11, 2023 at 06:15:01PM +0200, Larysa Zaremba wrote:
> > > Implement .xmo_rx_csum callback to allow XDP code to determine,
> > > whether HW has validated any checksums.
> > >
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++=
++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/=
net/ethernet/intel/ice/ice_txrx_lib.c
> > > index 6ae57a98a4d8..f11a245705bc 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > @@ -660,8 +660,34 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_=
md *ctx, u16 *vlan_tci,
> > >     return 0;
> > >  }
> > >
> > > +/**
> > > + * ice_xdp_rx_csum - RX checksum XDP hint handler
> > > + * @ctx: XDP buff pointer
> > > + * @csum_status: status destination address
> > > + * @csum: not used
> > > + */
> > > +static int ice_xdp_rx_csum(const struct xdp_md *ctx,
> > > +                      enum xdp_csum_status *csum_status, __wsum *csu=
m)
> > > +{
> > > +   const struct ice_xdp_buff *xdp_ext =3D (void *)ctx;
> > > +   const union ice_32b_rx_flex_desc *eop_desc;
> > > +   enum ice_rx_csum_status status;
> > > +   u16 ptype;
> > > +
> > > +   eop_desc =3D xdp_ext->pkt_ctx.eop_desc;
> > > +   ptype =3D ice_get_ptype(eop_desc);
> > > +
> > > +   status =3D ice_get_rx_csum_status(eop_desc, ptype);
> > > +   if (status & ICE_RX_CSUM_FAIL)
> > > +           return -ENODATA;
> > > +
> > > +   *csum_status =3D XDP_CHECKSUM_VERIFIED;
> > > +   return 0;
> > > +}
> > > +
> > >  const struct xdp_metadata_ops ice_xdp_md_ops =3D {
> > >     .xmo_rx_timestamp               =3D ice_xdp_rx_hw_ts,
> > >     .xmo_rx_hash                    =3D ice_xdp_rx_hash,
> > >     .xmo_rx_vlan_tag                =3D ice_xdp_rx_vlan_tag,
> > > +   .xmo_rx_csum                    =3D ice_xdp_rx_csum,
> >
> > timestamp hint is implemented by igc, mlx4, mlx5, stmmac
> > hash hint is implemneted by igc, mlx4, mlx5.
> > With above csum and vlan hints will be in ice only.
> > I'd like to see at least one more driver to implement them as well to m=
ake sure
> > the proposed API works for other vendors.
>
> I have no other vendors on my current setup :/
>
> I could send an RFC of v5 + a compile-tested implementation for some othe=
r
> vendor, so you can see, how it might look.

compiled tested is a good step.
nvidia folks would need to test it and ack it, of course.

