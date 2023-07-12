Return-Path: <bpf+bounces-4872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3757A751174
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 21:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AE3281A28
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 19:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730F82417D;
	Wed, 12 Jul 2023 19:43:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8F20F8B;
	Wed, 12 Jul 2023 19:43:02 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60F72137;
	Wed, 12 Jul 2023 12:42:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so11611665e87.2;
        Wed, 12 Jul 2023 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689190967; x=1691782967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHdrflWK2ViXkxBQZTcWjz3hRepn7lalY6kLivWlhf0=;
        b=ragut39qw6oOSPIEbhyKis3llf3ddQSZ84MOmn0h54RlvEbZY0OMgXKqSHnxVYDVca
         aF10TIJ3yfLWdFJ7mz8+MJmUzJ/a49/9Xrc26sVRc6VNcswCQZirmX3XmovP7NWHnSa5
         zsSv7siAFYjMhP7yb5mLPPgAWtjbJQriNG3IWsxJkvM9oR1MGHaaj8a+d4faPLV30RiA
         RcKdsoa+uKtvFOtwt+xQ+xdbqw2PGgO4SCxTrF08aINzAPlcJ5FXc4sQCrWOdyGO5YEg
         jV67Newb2M9UQL+F1Pyztrbei1KYqDCEfjYT/WL1YBNvRuntWUnE2paIaiDg2Qukl0YW
         wLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190967; x=1691782967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHdrflWK2ViXkxBQZTcWjz3hRepn7lalY6kLivWlhf0=;
        b=fbLMaMDYd9heeHMCY+nq+IOAUsaPQ5QH8BVXDrv2PRQ31TltGmIpj7oIesyuo11H3l
         ZjCJZT4BX7B12hD7cYfwRoMFcoKNLNLoXN3vnMXnd3FrOSCLQh9x8TnjSBruXWzzN+wS
         snMgLaZ7r+kbVrW2a3f4euC7NwOafsC05DyhU+tg5xxvBMVi82yS7J1f7GtRfA2lnY0y
         58hI50ZlOrqCh1D6WYpt+vYoRfdzqZyZJdHOn/u6fPQokQ8uKiQzx1aWYZeHPRabKL5o
         IBIfC5pc9bKBgtI0WkJw/+8BJgDtduC8tOm6eeNUKcyoHhTQbbY0H4KU7/WpLUj94xfq
         d6Rw==
X-Gm-Message-State: ABy/qLauYgu7NbommSyzZXggfU5ZzxYhdrC4CyCg9L6Y+7ni5YSrQq2H
	XDknjLs9cmzLkutQV+lWL+0pTYmEvarQ/3LK6nk=
X-Google-Smtp-Source: APBJJlHBsdL88UhEBrzhUY2LRdZ/z9Sp80L6LqZ/eNhoDr584c+w5B+uhdq4EcYu6pH1C4jAH+jNWE7yiS/UtZThFIw=
X-Received: by 2002:a2e:7d0d:0:b0:2b6:ea3b:f082 with SMTP id
 y13-20020a2e7d0d000000b002b6ea3bf082mr16118660ljc.38.1689190966586; Wed, 12
 Jul 2023 12:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707193006.1309662-10-sdf@google.com> <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local>
 <CAKH8qBtawUTjFQ=hhTzXa2zTBwOpxurjhduxZV+eUg8rnJUJVw@mail.gmail.com>
 <CAADnVQKnWCYjOQA-=61pDP4TQ-LKC7S-tOSX9Lm6tB3vJcf4dw@mail.gmail.com>
 <CAKH8qBvnMd2JgobQf1bvc=x7uEn1RPVHcuu3F7gB6vS627g-Xg@mail.gmail.com>
 <CAADnVQLCRrPtQMPBuYiKv44SLDiYwz69KZ=0e0HxJdPQz4x2HQ@mail.gmail.com>
 <ZK4eFox0DwbpyIJv@google.com> <CAADnVQJnf=KJ17MJWujkj+oSxp7kNNK1k08PvH+Wx617yAtZ8Q@mail.gmail.com>
 <CAKH8qBvGbJhAeNQ0zZxFFf_V_Oq=85xwx7KgsL1xA7GK+qcFnw@mail.gmail.com>
 <CAF=yD-LO=LDWhKM--r9F119-J_9v-Znm4saxFrhhxhMV6nnmJQ@mail.gmail.com>
 <20230712190342.dlgwh6uka5bcjfkl@macbook-pro-8.dhcp.thefacebook.com> <CAF=yD-Kf6wSc1JkgpNHEBVbyRiJ1pHqbw7SkkuHGAHatyS+eVg@mail.gmail.com>
In-Reply-To: <CAF=yD-Kf6wSc1JkgpNHEBVbyRiJ1pHqbw7SkkuHGAHatyS+eVg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jul 2023 12:42:35 -0700
Message-ID: <CAADnVQ+QGgjmqiV_uRzcrPOrH=GeDTtkAVs6t2n15WA9x3o3sw@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 12:12=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Basically, add to AF_XDP what we already have for its predecessor
> AF_PACKET: setsockopt PACKET_VNET_HDR?
>
> Possibly with a separate new struct, rather than virtio_net_hdr. As
> that has dependencies on other drivers, notably virtio and its
> specification process.

yeah. Forgot about this one.
That's a perfect fit. I would reuse virtio_net_hdr as-is.
Why reinvent the wheel?
It would force uapi, but some might argue it's a good thing.

