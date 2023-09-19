Return-Path: <bpf+bounces-10363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 093777A5D5B
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 11:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD1728155B
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242763D3AB;
	Tue, 19 Sep 2023 09:04:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C1479CD
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 09:04:57 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4605912A
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 02:04:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-415155b2796so246001cf.1
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695114294; x=1695719094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/oi4X3L5BnW+K69jB8Ov4ZNb09lPvvTlldUKOwOkGU=;
        b=qgBDb41YlX7gYTIa2/cCXpfPdeFrEAK5C5hCflV6DC4KATJtZzqbCHiv+puVcxgRG/
         vmSite9CfaS8sDRVmY/pODPnNFmJ/1HMBjBYHcn3x1GDe9ZfR4TjTujqyt+FyrGnB4we
         PFpLmfreZsvHz+12IGCh1J2sUp/u7EnuGROW2snYoT5yor3oZe3awscm3KWR1Q9XVuQN
         6s5lK5uEjJkXE8H5/JGUb8GM44BktBuz7WT54Lw3K0Y+YqHHmdwKz6whwQj4VCkY+8ZT
         zrMNKMDRmMmIQIYLag1R83YLoFeN2TuxFILrr8KOn1z1q1ou+B7ppMbxOOSnluXDLQmw
         ievA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695114294; x=1695719094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/oi4X3L5BnW+K69jB8Ov4ZNb09lPvvTlldUKOwOkGU=;
        b=OcqntzXjTv3Ej5VYPacaDCUFrBCTX8ce97SvGutQVwG9zfXlwCAHnsztjXX6SUZTnK
         PD9H4ChuFMFkBGJ8OrfG64xV934Lh5GA+dD1AgFc78gye+2ycBS14WjrkWE/oN21C3N1
         vzQg54hxyTCWnhjDg2Bjvoji/KOulGCfMljBw40D2IcI2iwQN4h9aw977SXycwmCUGLu
         IJcbjiPZsGib9xJa2wlceIijGCEbQwn1woV8w8WXb5o1tf9kRBv5IeEK0mSlIIiApFXb
         leqdJNlJ0Y1Du6sAsRdDaYp7Fz9Fq6j/gdFiDeZXyXqrpGPkV8kbGmtHJlUaCu2p9HDe
         gtxg==
X-Gm-Message-State: AOJu0YxEJCTUO9XMkUuVlkWXzH3BPIrveAoMjlp5I+O0Nu1QSSiFJ6Vl
	p73buwnguW98AKBHGT1LFfS0rkD0sC9R8+vxySxQbQ==
X-Google-Smtp-Source: AGHT+IEF/GNkZ5xnMa3iueZI1Q6OKylsLCUnyxGRIeKe1FBhTSCtbhnhch5SgaARlyTbVwPzdupZ5KECFNAMxBs/ls0=
X-Received: by 2002:a05:622a:251:b0:40f:d3db:f328 with SMTP id
 c17-20020a05622a025100b0040fd3dbf328mr179702qtx.2.1695114294212; Tue, 19 Sep
 2023 02:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3793723.1694795079@warthog.procyon.org.uk> <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com>
 <0000000000001c12b30605378ce8@google.com> <3905046.1695031382@warthog.procyon.org.uk>
 <65085768c17da_898cd294ae@willemb.c.googlers.com.notmuch> <CANn89iJ39Hguu6bRm2am6J_u0pSnm++ORa_UVpC0+8-mxORFfw@mail.gmail.com>
 <ZQlbYVCjCyuPotdX@katalix.com>
In-Reply-To: <ZQlbYVCjCyuPotdX@katalix.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Sep 2023 11:04:41 +0200
Message-ID: <CANn89i+fPjwonpWAXOCzrCG+hYH4kwMgJidwZf0CQaoCPOffXA@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in __ip6_append_data
To: Tom Parkin <tparkin@katalix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Howells <dhowells@redhat.com>, 
	syzbot <syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com>, bpf@vger.kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 10:27=E2=80=AFAM Tom Parkin <tparkin@katalix.com> w=
rote:
>
> On  Mon, Sep 18, 2023 at 16:04:49 +0200, Eric Dumazet wrote:
> > On Mon, Sep 18, 2023 at 3:58=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > David Howells wrote:
> > > > David Howells <dhowells@redhat.com> wrote:
> > > >
> > > > > I think the attached is probably an equivalent cleaned up reprodu=
cer.  Note
> > > > > that if the length given to sendfile() is less than 65536, it fai=
ls with
> > > > > EINVAL before it gets into __ip6_append_data().
> > > >
> > > > Actually, it only fails with EINVAL if the size is not a multiple o=
f the block
> > > > size of the source file because it's open O_DIRECT so, say, 65536-5=
12 is fine
> > > > (and works).
> > > >
> > > > But thinking more on this further, is this even a bug in my code, I=
 wonder?
> > > > The length passed is 65536 - but a UDP packet can't carry that, so =
it
> > > > shouldn't it have errored out before getting that far?  (which is w=
hat it
> > > > seems to do when I try it).
> > > >
> > > > I don't see how we get past the length check in ip6_append_data() w=
ith the
> > > > reproducer we're given unless the MTU is somewhat bigger than 65536=
 (is that
> > > > even possible?)
> > >
> > > An ipv6 packet can carry 64KB of payload, so maxnonfragsize of 65535 =
+ 40
> > > sounds correct. But payload length passed of 65536 is not (ignoring i=
pv6
> > > jumbograms). So that should probably trigger an EINVAL -- if that is =
indeed
> > > what the repro does.
> >
> > l2tp_ip6_sendmsg() claims ip6_append_data() can make better checks,
> > but what about simply replacing INT_MAX by 65535 ?
>
> Slightly OT but I think the l2tp_ip6.c approach was probably cribbed
> from net/ipv6/udp.c's udpv6_sendmsg originally:
>
>
>     /* Rough check on arithmetic overflow,
>        better check is made in ip6_append_data().
>        */
>     if (len > INT_MAX - sizeof(struct udphdr))
>         return -EMSGSIZE;
>
>
> Should the udp code be modified similarly?
>

Unfortunately both l2tp and udp support CORK (MSG_MORE),
so a modified check like that will not be enough to prevent syzbot reports.

Better than nothing, of course.

I also note that ipv4 size of l2tp does not have any check,
an overflow seems possible with carefully chosen size.

