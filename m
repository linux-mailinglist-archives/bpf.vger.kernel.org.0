Return-Path: <bpf+bounces-139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FD76F894B
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B411C2198F
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 19:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F554C8EE;
	Fri,  5 May 2023 19:08:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7A42F33
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 19:08:37 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46B1359C
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 12:08:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so29969532a12.1
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683313714; x=1685905714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruONDHU1AIGKfToy3Uub+3vOSqbtzFOsFy5r9jWRseE=;
        b=OGZVGwr1Dg5J6VYX4Ayvftqd13hdEbu6akL/jLD7PReCEnCrRP6pM/OLWmP5BStpbJ
         CMrDUIKc15LSH3dT5f7s/xaB3GA8R3dhhjHdVc6mNuoFJAmc5JHUaRSkcZBokYMO+Lw4
         fMv1SpOhd2Y2U+E9uYUGho7FL4hTCNUy787HLO0+o1qhPhKS8dC51HA7Zt1egJnx0VaM
         js0Pw0lFwif8gvDqd5rvfJN7R1rKsWT7/upcwOe3HOq6a8hD5nu9g4mLNlx2d1mrzXAj
         mv6nHO42iIawAPlXztFg0ml+Mspl5ieOxXXTz7D5zTH57Moieobx6+doCA4IqAX6AeEd
         yvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683313714; x=1685905714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruONDHU1AIGKfToy3Uub+3vOSqbtzFOsFy5r9jWRseE=;
        b=CwNHqjzJD7kATPg0Psi5LB20CqEB0FWsR4FN5bUl611UIBsQj8ByBlklXaDC/i4cEk
         Ir6oJt/jdWbJise+GTYZSL7lTCwcd8DcQzMuoZAoWLaJczXCfg4oc2al6iBz84Rv6dLI
         J8saUL2brINcacr8NRzpr7wqqkQnBw/QbyCJcZQABG1Vo7Xj94cA0jvl74/J4p87SUuA
         /r82O1Xt42YvzDv7cisLzapixKldDsaYi++fUg7pdv/udlQq8njWM7u71m99cV/3OQE9
         NCQfCEvteRw9X+6viY9pBswLIKnKCulIPcpYqC3en7PF6dxwsMh+OKX6500O0Z8Funm+
         +sBw==
X-Gm-Message-State: AC+VfDwVg4Y2zYqu1cJxoDDkgBFZgJWBWPn4dXlhlgeWg+Kg5wpeqo1a
	QeasOsuBl9Y4pWNE584Yc0RelV/9l9JG/N31V6G0X9OI9uA=
X-Google-Smtp-Source: ACHHUZ60nvDpTr8N/x93lNSeZdg/GL2M86/yhD8DSALytXJyV3QQlI632Ybvyvp0yfIikgYh9Xo2uX/8HqTXYyL5CJI=
X-Received: by 2002:a17:906:fe4a:b0:94a:643e:9e26 with SMTP id
 wz10-20020a170906fe4a00b0094a643e9e26mr2063964ejb.14.1683313714145; Fri, 05
 May 2023 12:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-11-andrii@kernel.org>
 <20230504222033.gw64tn73fverqccf@dhcp-172-26-102-232.dhcp.thefacebook.com> <CAEf4BzbuUvJ6zLvJJpMRc6jkx0GqbWdPFKi2GJ7G1WsjXpeUog@mail.gmail.com>
In-Reply-To: <CAEf4BzbuUvJ6zLvJJpMRc6jkx0GqbWdPFKi2GJ7G1WsjXpeUog@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 May 2023 12:08:21 -0700
Message-ID: <CAEf4BzYa0A3d8rp7KqCsuhOFicW7McNcv2Oz3J3ceZ0g2LROyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/10] bpf: consistenly use program's recorded
 capabilities in BPF verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 3:51=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 4, 2023 at 3:20=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, May 02, 2023 at 04:06:19PM -0700, Andrii Nakryiko wrote:
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 4d057d39c286..c0d60da7e0e0 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -661,7 +661,7 @@ static bool bpf_prog_kallsyms_candidate(const str=
uct bpf_prog *fp)
> > >  void bpf_prog_kallsyms_add(struct bpf_prog *fp)
> > >  {
> > >       if (!bpf_prog_kallsyms_candidate(fp) ||
> > > -         !bpf_capable())
> > > +         !fp->aux->bpf_capable)
> > >               return;
> >
> > Looking at this bit made me worry about classic bpf.
> > bpf_prog_alloc_no_stats() zeros all fields include aux->bpf_capable.
> > And loading of classic progs doesn't go through bpf_check().
> > So fp->aux->bpf_capable will stay 'false' even when root loads cBPF.
> > It doesn't matter here, since bpf_prog_kallsyms_candidate() will return=
 false
> > for cBPF.
> >
> > Maybe we should init aux->bpf_capable in bpf_prog_alloc_no_stats()
> > to stay consistent between cBPF and eBPF ?

I'd like to avoid doing this deep inside bpf_prog_alloc_no_stats() or
bpf_prog_alloc() because this decision about privileges will be later
based on some other factors besides CAP_BPF. So hard-coding
bpf_capable() here defeats the purpose.

I did look at classic BPF, there are three places in net/core/filter.c
where we allocated struct bpf_prog from  struct sock_fprog/struct
sock_fprog_kern: bpf_prog_create, bpf_prog_create_from_user,
__get_filter.

Would it be ok if I just hard-coded `prog->aux->bpf_capable =3D
bpf_capable();` (and same for perfmon) in those three functions? Or
leave them always false? Because taking a step back a bit, do we want
to allow privileged classic BPF programs at all? Maybe it's actually
good that we force those cBPF programs to be unprivileged?

Right now it doesn't even matter, I think, because these privileges
are only checked during verification. But assuming that in the future
we might want to check that at runtime from helpers/kfuncs, probably
best to have a strategy here.

Tl;dr, I don't know what's the best approach to take, but just calling
into bpf_capable() deeply inside bpf_prog_alloc/bpf_prog_alloc_stats
makes subsequent work to implement trusted unpriv harder. Thoughts?

> > It probably has no effect, but anyone looking at crash dumps with drgn
> > will have a consistent view of aux->bpf_capable field.
>
> classic BPF predates my involvement with BPF, so I didn't even think
> about that. I'll check and make sure we do initialize aux->bpf_capable
> for that

