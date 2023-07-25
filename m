Return-Path: <bpf+bounces-5854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 939B4762121
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 20:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A681D1C20F2E
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D403F263A7;
	Tue, 25 Jul 2023 18:16:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E123BF5
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 18:16:10 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38371BF8;
	Tue, 25 Jul 2023 11:16:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b734aea34aso85316141fa.0;
        Tue, 25 Jul 2023 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690308965; x=1690913765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaqRX3//yycdBRgF192yYxUc3zXSOhtqD/ETouzUIao=;
        b=UprsR88vr0GLaBEm8nrwJ1OiSXzsQassFUvc+KgsrGzJlEj+854tG5CVxNN+qHThKV
         1XwqZq1COTTyAsvreFr4cRX8MiP2RsvB7BEipMumNR74sGJj3Y+SiGMBaThAasLUDOCb
         F6WbwSYN3z9P21xMrmlTHciaftTz9xlE2n/7V5P1TzANKbz2TLkcaMABIJq8IGkeK18E
         +wLa/BnNOs3phVXQ2EtjqMAyAM1DX18xJFdTtWsO+c7is3R/rAr8ze2D2vcqtQtO406K
         Q29WH+XGb80WkL4x94K298uyANFlWApzsENgWSUdi4mR1qzgTz3XU50b2poc/Ip+5m/Z
         oeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308965; x=1690913765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaqRX3//yycdBRgF192yYxUc3zXSOhtqD/ETouzUIao=;
        b=Jqh0/bbB+kK0X0OTmIuE5Kk4xTFO4kkNFUNPVFpqX1n85jiZW72B/io5JzonrDSsEb
         FjUkkeTie0w44j6Zel0k2RoLQzpQBIZkGJ4WvZtRvFQ8rOVlRC0bRBYmWe0Tb6/cCP63
         EFjpZkHn2wELht/5aQqpQ+AOFTWSQyKFTgpuK9OsDSNFT2ME6lolcDIlE6xvE3NmxyHn
         Y/6RA4RvXo6+pQ51x1eWn2TuJzGR3ez/MBMiAhTQhNYuTkFhbfIMFr0qd1SpbRSlEdDu
         B9XJIxBVjafw0RsEaWUAavHfrqnqer/EOhPl+UKo4utyT+GhPK7qNyqZD5TzaEsG5DGb
         z/nQ==
X-Gm-Message-State: ABy/qLY9i9MeRjXsqAojHQ6tQi6W9MP3ZyjKsW3Vp/gXfahiRL4HperH
	6cCzZqD15VTHMFLGVyuJirx7FtmWymCRKTBo1JM=
X-Google-Smtp-Source: APBJJlHmnRezME3OEClXVRckbCJu4yj0xp2e8fzoqRIJIwyIidA5xA3aMSREZ1FZPSckRZatCXpej4hUifCyh9pCDvQ=
X-Received: by 2002:a2e:9ad2:0:b0:2b5:9d78:213e with SMTP id
 p18-20020a2e9ad2000000b002b59d78213emr10958148ljj.22.1690308964744; Tue, 25
 Jul 2023 11:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230722074753.568696-1-arnd@kernel.org> <CALOAHbCV2v3X7g1TD42yve0juhRD2vhq=DMtDz9P6+mX8Dae_w@mail.gmail.com>
 <CAADnVQKGe8DN+Zs387UVwpij3ROGqNEnc5r940h5ueqQYHTYCA@mail.gmail.com>
 <fa5e9098-d6f9-48a2-bb77-2620b6bb6556@app.fastmail.com> <CAADnVQ+p4wpd=tKJAiwB34O1y5vv4mibtkt9D-F7sG=rQapcew@mail.gmail.com>
 <679d8d63-ce92-4294-8620-e98c82365b2c@app.fastmail.com> <39444a4e-70da-4d17-a40a-b51e05236d23@app.fastmail.com>
 <CAADnVQ+zdV9+UNV9NeEzY2rWd8qvW3cvHxS9mYwfhnqZOV+9=A@mail.gmail.com> <3e202277-fe74-4105-93ec-b646efaaa956@app.fastmail.com>
In-Reply-To: <3e202277-fe74-4105-93ec-b646efaaa956@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jul 2023 11:15:53 -0700
Message-ID: <CAADnVQJWfQVGWsruzTHB9v=kztkDeRbJJDANafVScEE4EJ1jbg@mail.gmail.com>
Subject: Re: [PATCH] bpf: force inc_active()/dec_active() to be inline functions
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 1:41=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Jul 24, 2023, at 21:15, Alexei Starovoitov wrote:
> > On Mon, Jul 24, 2023 at 11:30=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
> >> On Mon, Jul 24, 2023, at 20:13, Arnd Bergmann wrote:
> >>
> >> I have a minimized test case at https://godbolt.org/z/hK4ev17fv
> >> that shows the problem happening with all versions of gcc
> >> (4.1 through 14.0) if I force the dec_active() function to be
> >> inline and force inc_active() to be non-inline.
> >
> > That's a bit of cheating, but I see your point now.
> > How about we do:
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index 51d6389e5152..3fa0944cb975 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -183,11 +183,11 @@ static void inc_active(struct bpf_mem_cache *c,
> > unsigned long *flags)
> >         WARN_ON_ONCE(local_inc_return(&c->active) !=3D 1);
> >  }
> >
> > -static void dec_active(struct bpf_mem_cache *c, unsigned long flags)
> > +static void dec_active(struct bpf_mem_cache *c, unsigned long *flags)
> >  {
> >         local_dec(&c->active);
> >         if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > -               local_irq_restore(flags);
> > +               local_irq_restore(*flags);
> >  }
>
>
> Sure, that's fine. Between this and the two suggestions I had
> (__always_inline or passing the flags from  inc_active as a
> return code), I don't have a strong preference, so pick whichever
> you like.

I think:
static void dec_active(struct bpf_mem_cache *c, unsigned long *flags)
is cleaner.
Could you send a patch?

