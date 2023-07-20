Return-Path: <bpf+bounces-5558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7A975BA92
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 00:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C0A282087
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2421DDF4;
	Thu, 20 Jul 2023 22:24:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A61DDDE;
	Thu, 20 Jul 2023 22:24:33 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997CE110;
	Thu, 20 Jul 2023 15:24:32 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7672073e7b9so113909085a.0;
        Thu, 20 Jul 2023 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689891871; x=1690496671;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbN75j8y8eFg2bbOR60vga2vIDgL+4CQKTZqLo7f94w=;
        b=pNYm1IKRTPdaXOKZv7W0MUTVZqwuqU1gkOYDfGeKR+aoLqjNBC1slosDkX9HvZHSYu
         HWluSic8xeCopahNgt+r3m7CLUXE5LtHQYtreUhDlqVmgk8Zjw06Bui+RkESmhrqGc2A
         c+16xYbBjfuFXag8ayOYKQYXALu4icVK1d5FlmpV8B3Pu4aopDuC2tYVBpqFKnVUmjj3
         qi+A2D1ytVxejQom+i2cIrTUoNcsURdcjQNZdIt1TwtdTXeCdQ1fsm/GxkXIVOdttsMr
         KGX6dH7YSe2GSCsqDYD5O8kAfzSUwWtwtvyZV4qvmxu5hAqvrbg8NWiuShRAstvJh9h7
         w/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689891871; x=1690496671;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mbN75j8y8eFg2bbOR60vga2vIDgL+4CQKTZqLo7f94w=;
        b=HOHU9TxPtJLC5KP6UGZr5HMpbrGOhafEnYBa/KjNgEIniRF3TRouxIAvadiRvI6MOv
         L5YIvVPCy/NPrWVX9/Wo6dUAFexXIzq1hio36Tzicoq+dLecQN1gNXbFgwTvjz/mVTkQ
         HcTeOxPi3EyA6pum3LUmEfN+WrJDzSY6F5GseZgpQGsHqK8WkSiB6rPoP7KQ3BXd9YRt
         3sKhSdXhes7hzU39S0ghb+stqCkx7Y+aPMjlMeixEkxw+ieRgcJJuggpE0sL6uHrx+cY
         JAMMJDvg14cM9v8jzkzl9KO+DkMm1mPhjrI+N3Hucw3pkjlX/kfGiIOsdYkDFj0NSNQ7
         AlCA==
X-Gm-Message-State: ABy/qLavhOIGPx39AMRoHuAP5diixTry0PMpH20/WpQnjLfTwvJuEkgs
	u8Knv7OLE5ids8P7JT02SUQ=
X-Google-Smtp-Source: APBJJlEoHWHnn4n3QMGReuVNwzEGNfUOe4J1EvjlU6RyB78kDh/eXyd/85vwmkh1GTYOIKioBbAOHA==
X-Received: by 2002:a0c:aa18:0:b0:637:49c7:28e4 with SMTP id d24-20020a0caa18000000b0063749c728e4mr326501qvb.5.1689891871613;
        Thu, 20 Jul 2023 15:24:31 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id a26-20020a0cb35a000000b006166d870243sm791277qvf.43.2023.07.20.15.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:24:31 -0700 (PDT)
Date: Thu, 20 Jul 2023 18:24:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <sdf@google.com>, 
 larysa.zaremba@intel.com
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "ast@kernel.org" <ast@kernel.org>, 
 "daniel@iogearbox.net" <daniel@iogearbox.net>, 
 "andrii@kernel.org" <andrii@kernel.org>, 
 "martin.lau@linux.dev" <martin.lau@linux.dev>, 
 "song@kernel.org" <song@kernel.org>, 
 "yhs@fb.com" <yhs@fb.com>, 
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
 "kpsingh@kernel.org" <kpsingh@kernel.org>, 
 "haoluo@google.com" <haoluo@google.com>, 
 "jolsa@kernel.org" <jolsa@kernel.org>, 
 David Ahern <dsahern@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 brouer@redhat.com, 
 anatoly.burakov@intel.com, 
 aleksander.lobakin@intel.com, 
 Magnus Karlsson <magnus.karlsson@gmail.com>, 
 mtahhan@redhat.com, 
 "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <64b9b41eea18b_2c3d5029438@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZLmstKiYO7LH9mXt@google.com>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-14-larysa.zaremba@intel.com>
 <20230719185930.6adapqctxfdsfmye@macbook-pro-8.dhcp.thefacebook.com>
 <64b85ad52d012_2849c1294df@willemb.c.googlers.com.notmuch>
 <ZLkBrfex1ENbVDwF@lincoln>
 <CAADnVQKF3j-_qLM4MWkJKK=ZyPuWrLnmGfgf9BC4zm-4=1qSfw@mail.gmail.com>
 <ZLlUyJdj50UqFM0m@lincoln>
 <ZLmstKiYO7LH9mXt@google.com>
Subject: Re: [PATCH bpf-next v3 13/21] ice: Implement checksum hint
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Stanislav Fomichev wrote:
> On 07/20, Zaremba, Larysa wrote:
> > On Thu, Jul 20, 2023 at 08:14:52AM -0700, Alexei Starovoitov wrote:
> > > On Thu, Jul 20, 2023 at 2:47=E2=80=AFAM Zaremba, Larysa
> > > <larysa.zaremba@intel.com> wrote:
> > > >
> > > > On Wed, Jul 19, 2023 at 05:51:17PM -0400, Willem de Bruijn wrote:=

> > > > > Alexei Starovoitov wrote:
> > > > > > On Wed, Jul 19, 2023 at 08:37:26PM +0200, Larysa Zaremba wrot=
e:
> > > > > > > Implement .xmo_rx_csum callback to allow XDP code to determ=
ine,
> > > > > > > whether HW has validated any checksums.
> > > > > > >
> > > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > > ---
> > > > > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 29 +++++++=
++++++++++++
> > > > > > >  1 file changed, 29 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c =
b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > > > index 54685d0747aa..6647a7e55ac8 100644
> > > > > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > > > > > @@ -660,8 +660,37 @@ static int ice_xdp_rx_vlan_tag(const s=
truct xdp_md *ctx, u16 *vlan_tci,
> > > > > > >   return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +/**
> > > > > > > + * ice_xdp_rx_csum_lvl - Get level, at which HW has checke=
d the checksum
> > > > > > > + * @ctx: XDP buff pointer
> > > > > > > + * @csum_status: destination address
> > > > > > > + * @csum_info: destination address
> > > > > > > + *
> > > > > > > + * Copy HW checksum level (if was checked) to the destinat=
ion address.
> > > > > > > + */
> > > > > > > +static int ice_xdp_rx_csum(const struct xdp_md *ctx,
> > > > > > > +                    enum xdp_csum_status *csum_status,
> > > > > > > +                    union xdp_csum_info *csum_info)
> > > > > > > +{
> > > > > > > + const struct ice_xdp_buff *xdp_ext =3D (void *)ctx;
> > > > > > > + const union ice_32b_rx_flex_desc *eop_desc;
> > > > > > > + enum ice_rx_csum_status status;
> > > > > > > + u16 ptype;
> > > > > > > +
> > > > > > > + eop_desc =3D xdp_ext->pkt_ctx.eop_desc;
> > > > > > > + ptype =3D ice_get_ptype(eop_desc);
> > > > > > > +
> > > > > > > + status =3D ice_get_rx_csum_status(eop_desc, ptype);
> > > > > > > + if (status & ICE_RX_CSUM_NONE)
> > > > > > > +         return -ENODATA;
> > > > > > > +
> > > > > > > + *csum_status =3D ice_rx_csum_lvl(status) + 1;
> > =

> > I'll duplicate an improved version of this line from another thread i=
n case it =

> > could help with the comprehension during review:
> > =

> > *csum_status =3D XDP_CHECKSUM_VALID_LVL0 + ice_rx_csum_lvl(status);
> > =

> > > > > > > + return 0;
> > > > > > > +}
> > > > > >
> > > > > > and xdp_csum_info from previous patch left uninitialized?
> > > > > > What was the point adding it then?
> > > > >
> > > > > I suppose this driver only returns CHECKSUM_NONE or
> > > > > CHECKSUM_UNNECESSARY? Also based on a grep of the driver dir.
> > > > >
> > > >
> > > > Yes, correct, current ice HW cannot produce complete checksum,
> > > > so only CHECKSUM_UNNECESSARY for known protocols, CHECKSUM_NONE o=
therwise,
> > > > nothing to initialize csum_info with in either case.
> > > >
> > > > xdp_csum_info is initialized in veth implementation though, but o=
nly
> > > > csum_start/offset, so complete XDP checksum has no users in this =
patchset.
> > > > Is this a problem?
> > > >
> > > > In previous version I had CHECKSUM_UNNECESSARY-only kfunc, but I =
think everyone
> > > > has agreed, csum hint kfunc should give more comprehensive output=
.
> > > =

> > > csum kfunc supposed to be generic.
> > > If for ICE it fills in one argument and for veth another then the w=
hole
> > > idea of generic api is not working.
> > =

> > Both ice and veth fill in the csum_status, the need to fill in the cs=
um_info is =

> > determined by the status. I don not see a problem with that.
> > =

> > Maybe you have an issue with putting a valid checksum number into a s=
tatus =

> > instead of info? Please clarify.
> =

> +1, that seems to match skb interface
> =

> Regarding 'generic api not working' in general: I think we've discussed=

> that with this 'flexible' kfunc format we can allow non-generic kfuncs =
for
> specific devices if we think that it makes sense to
> differentiate/experiment/etc. Do you think it makes sense to go
> non-generic route here?

I think we should expose the standard CHECKSUM_* behavior.

The current encoding captures all four types. Which type is returned
is not necessarily defined only by the device. Some devices can
return CHECKSUM_NONE for some packets, CHECKSUM_PARTIAL for others
and CHECKSUM_UNNECESSARY for a third set (e.g., mlx4). Specializing
the return type to the device would not simplify the struct.

