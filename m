Return-Path: <bpf+bounces-4973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E8B752DB6
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 01:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644BD281EF0
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 23:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC25E63D5;
	Thu, 13 Jul 2023 23:03:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE41611E;
	Thu, 13 Jul 2023 23:03:40 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67173C13;
	Thu, 13 Jul 2023 16:03:09 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6ff1a637bso19051531fa.3;
        Thu, 13 Jul 2023 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689289374; x=1691881374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhahLLvwqBT9IjolZe6KCsgXVepfcXylqXrzt4Kdao8=;
        b=mN3EPPpiyPlcyGojsaNb69NadGDD4EjNi6R7aX1FNuuu3CepjZnkQl0R4nTlRgSYXz
         4hAPRAHZGNF+eefkLVHgtcXBNNu/lSBT8o5+nKohDcJMX/pGi4NouVjKOek5GNcaVDlJ
         OMLO354BMLlPZcOBB2YQgp75KfeRXDT5sluffXP6T4049TDIyC0RpN/Ln/m3xvljSRbW
         Ee5g3YLuujbPyoRNuVxTtC+69fP6ROPMXkRalhplhXK+x2lbLy2AESfq/YBG6OiBUrLN
         cWfPeDSv0doiADWmSyt+01NyMzKInaOZQ8VnKNv39bj2wldAGvGolI/WTVcBvM8QfO5w
         pv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689289374; x=1691881374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhahLLvwqBT9IjolZe6KCsgXVepfcXylqXrzt4Kdao8=;
        b=BiV3s/Tdd9CKU1wV1xeotenbrhWf3cAjYUZokqIRIEeXFvvCvecjyTHLQnRVhEus2B
         5Tn1lPHOPftU1ZOA7mtfT+U4aBf7SyZSpTRJmKgRH1OyfQKatSufUJU1EAH2gzE/6Rz7
         86zwJuoYd1BausXrq57rmoShI24KqQd6xkW4ORGBRqlkZY0AuDezsQ2vUnr8Te7LuC8B
         E+ViWehUJ/B4dtbJEtztObX+BCDxb/9RSI1xJrajMn30evhyrr4SX2ulYVae0C6kWDP9
         x8nVF7j4g/ZsZZwUgm52f9UYRMEDxV37u20QtWDaWiYAywuhs0IlH7UPAnx7qp72k8+G
         l2GQ==
X-Gm-Message-State: ABy/qLaAxdWOoBsJj1sVLhWzKt3dryhhNZB2pQHwuCmYQSiurBd0YiHi
	vCJh+sYomTy8dc4reNBcayQbxkAIW3tGktkUFJk=
X-Google-Smtp-Source: APBJJlFDLOd+YoCKzzlzuPGa3KoTubQBJP0k05IrxabgAvot6BfBKWpLqdwa+VbPbG52b0fUnc7LXicJsYUyzC9wP/k=
X-Received: by 2002:a05:651c:229:b0:2b4:45bc:7bd with SMTP id
 z9-20020a05651c022900b002b445bc07bdmr2985703ljn.4.1689289374309; Thu, 13 Jul
 2023 16:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
 <20230706204650.469087-11-maciej.fijalkowski@intel.com> <CAADnVQLKDratBrgvwHzXZBW9chH9SBXPhnXpExYwu0BbRVFPjQ@mail.gmail.com>
 <ZLBJbWqT4Ej8bHfx@boxer>
In-Reply-To: <ZLBJbWqT4Ej8bHfx@boxer>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Jul 2023 16:02:42 -0700
Message-ID: <CAADnVQJUvE4Go4AyqCrUnHd=vkfEYBXEn9Sji7s2TdbXKL38bQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 10/24] xsk: add new netlink attribute
 dedicated for ZC max frags
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, Simon Horman <simon.horman@corigine.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 11:59=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Jul 10, 2023 at 06:09:28PM -0700, Alexei Starovoitov wrote:
> > On Thu, Jul 6, 2023 at 1:47=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > Introduce new netlink attribute NETDEV_A_DEV_XDP_ZC_MAX_SEGS that wil=
l
> > > carry maximum fragments that underlying ZC driver is able to handle o=
n
> > > TX side. It is going to be included in netlink response only when dri=
ver
> > > supports ZC. Any value higher than 1 implies multi-buffer ZC support =
on
> > > underlying device.
> > >
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >
> > I suspect something in this patch makes XDP bonding test fail.
> > See BPF CI.
> >
> > I can reproduce the failure locally as well.
> > test_progs -t bond
> > works without the series and fails with them.
>
> Hi Alexei,
>
> this fails on second bpf_xdp_query() call due to non-zero (?) contents at=
 the
> end of bpf_xdp_query_opts struct - currently it looks as following:
>
> $ pahole -C bpf_xdp_query_opts libbpf.so
> struct bpf_xdp_query_opts {
>         size_t                     sz;                   /*     0     8 *=
/
>         __u32                      prog_id;              /*     8     4 *=
/
>         __u32                      drv_prog_id;          /*    12     4 *=
/
>         __u32                      hw_prog_id;           /*    16     4 *=
/
>         __u32                      skb_prog_id;          /*    20     4 *=
/
>         __u8                       attach_mode;          /*    24     1 *=
/
>
>         /* XXX 7 bytes hole, try to pack */
>
>         __u64                      feature_flags;        /*    32     8 *=
/
>         __u32                      xdp_zc_max_segs;      /*    40     4 *=
/
>
>         /* size: 48, cachelines: 1, members: 8 */
>         /* sum members: 37, holes: 1, sum holes: 7 */
>         /* padding: 4 */
>         /* last cacheline: 48 bytes */
> };
>
> Fix is either to move xdp_zc_max_segs up to existing hole or to zero out
> struct before bpf_xdp_query() calls, like:
>
>         memset(&query_opts, 0, sizeof(struct bpf_xdp_query_opts));
>         query_opts.sz =3D sizeof(struct bpf_xdp_query_opts);

Right. That would be good to have to clear the hole,
but probably unrelated.

> I am kinda confused as this is happening due to two things. First off
> bonding driver sets its xdp_features to NETDEV_XDP_ACT_MASK and in turn
> this implies ZC feature enabled which makes xdp_zc_max_segs being include=
d
> in the response (it's value is 1 as it's the default).
>
> Then, offsetofend(struct type, type##__last_field) that is used as one of
> libbpf_validate_opts() args gives me 40 but bpf_xdp_query_opts::sz has
> stored 48, so in the end we go through the last 8 bytes in
> libbpf_is_mem_zeroed() and we hit the '1' from xdp_zc_max_segs.

Because this patch didn't update
bpf_xdp_query_opts__last_field

It added a new field, but didn't update the macro.

> So, (silly) questions:
> - why bonding driver defaults to all features enabled?

doesn't really matter in this context.

> - why __last_field does not recognize xdp_zc_max_segs at the end?

because the patch didn't update it :)

> Besides, I think i'll move xdp_zc_max_segs above to the hole. This fixes
> the bonding test for me.

No. Keep it at the end.

