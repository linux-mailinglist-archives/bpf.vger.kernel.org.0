Return-Path: <bpf+bounces-5236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E193A758B4E
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 04:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DB11C203A0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864017FF;
	Wed, 19 Jul 2023 02:29:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F217D0
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:29:20 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8A1BC3
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 19:29:19 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-635e6f8bf77so38050756d6.0
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 19:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689733758; x=1690338558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n7L92i9lfugFKqUzDJI87bQOq2aocgBszOMPaScS4A=;
        b=H3M1w9XvJjiOqU6+MywFXorHP/iu60U4Dj8V6nCDdG0zb6r0+YESOYGW0uAwyLAYZY
         rV0mBKbeN+3kaAzPdsEv/yySbUPHnRFyh/HiucvrR9wdcKCcmJ2ygXpUoE9R+zVHe2rg
         Ss/1TWZpOdSz9Av1c5ewvl+/MLjaa9i49snpoOfoaNwmlPUsExuP5F2a9vd3lplC5eym
         otSZdKct3qjYexDSW3Gl3fS2jSBsqJpILoCC2ZyT5IZqEKzGDrTwTlCoHF6yDhFjpnFm
         scgdDzC424j2xUX/QJaRSO9agnrQAe65PQQEXBYa9cu7w1SAWP/B0RRNphjuDSaV8MWg
         lSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689733758; x=1690338558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n7L92i9lfugFKqUzDJI87bQOq2aocgBszOMPaScS4A=;
        b=aXY+UmqkT3qqjauyVB2hLWDFGOmeGQppT/wENYR3EkEYg0Z/pQsKRBqsRVBtlzKD4p
         h7g5KLnkUmPVefN7yL/wXD5F6vdVdwVEVHX/gs8GP4jwjQDZGNOvUOvLQXMt7rkTpNQp
         8W9MoEjsc5bwa+TbCFg1X5Qb2tFpn5yZyC1N+sImexyRpqNvb4ZT4exb9jPzswOSxZ8+
         7DIypIfzFtvQtlm/9FgWGpRoJhNDWxbM//vGcMBCVwPSfg24Ax65O2peqciXhNTAFD5X
         yVnC+h2BRGu8CLHAuyz+jTY8rssBcZdE6wyhkc5DH+JwkNBDFnvhMYo/J6xNpXnYvsEi
         Q8vw==
X-Gm-Message-State: ABy/qLayMHtUqU4LKYW+h71muwmZOyag0zQaU11mYTOGk1gMUlU+dK0F
	wRwyWfec2rOACFOrU6com/iL9t8SvFCxZrHH5nY=
X-Google-Smtp-Source: APBJJlHIWsv3STweno2v+xj6RQ6jEc1g9DIEHeThw5cgQiky0ngHyHPnz41SPEm1wpgk9KhRgzYmxapJaiy4LploQhY=
X-Received: by 2002:a0c:f2d3:0:b0:632:25c5:6fb8 with SMTP id
 c19-20020a0cf2d3000000b0063225c56fb8mr15309358qvm.31.1689733758207; Tue, 18
 Jul 2023 19:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZJx8sBW/QPOBswNF@google.com> <CAADnVQJ4_wg9BqO2+VK_GfynjF7HEeer96=NRGsz5XyhbJDfsQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ4_wg9BqO2+VK_GfynjF7HEeer96=NRGsz5XyhbJDfsQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 19 Jul 2023 10:28:41 +0800
Message-ID: <CALOAHbC-MgeaO8k+QUvYZr-+nqxK1iXa2jAg1ePOnNnLR1CZ7g@mail.gmail.com>
Subject: Re: [ANN] bpf development stats for 6.5
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, Menglong Dong <menglong8.dong@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 8:18=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 28, 2023 at 11:32=E2=80=AFAM Stanislav Fomichev <sdf@google.c=
om> wrote:
> >
> > Same as last time, running Jakub's scripts against bpf tree, see netdev
> > posting for more info on the methodology:
> > https://lore.kernel.org/netdev/20230627163832.75f3a340@kernel.org/T/#u
> >
> > He also shared with me bpf stats for the previous cycle (a lot of
> > work went into the scripts in these past two months, so my data
> > was completely irrelevant), so we can have some comparisons!
> >
> > As last time, I'm presenting raw stats without any evaluation. I'm
> > also trying to present the same data as we have in netdev email
> > so you can follow Jakub's comments about script changes/etc. One thing
> > to note maybe is that we have a lot of cross-pollination with netdev li=
st,
> > so our stats change quite a bit depending on netdev activity :-)
> >
> > Previous cycle:
> > 21 Feb to 26 Apr: 5362 mailing list messages, 64 days, 86 messages per =
day
> > 438 repo commits (7 commits/day)
> >
> > Current cycle:
> > 27 Apr to 28 Jun: 4234 mailing list messages, 62 days, 68 messages per =
day
> > 664 repo commits (11 commits/day)
> >
> > 6.4 stats: https://lore.kernel.org/bpf/ZFAOojsT93ZxwNu3@google.com/
> >
> > Rankings
> > --------
> >
> > Top reviewers (thr):                 Top reviewers (msg):
> >    1 (+13) [7] Yonghong Song            1 ( +1) [16] Andrii Nakryiko
> >    2 ( -1) [7] Alexei Starovoitov       2 ( -1) [15] Alexei Starovoitov
> >    3 ( -1) [6] Andrii Nakryiko          3 (+17) [13] Yonghong Song
> >    4 ( +1) [4] Daniel Borkmann          4 (***) [ 5] David Hildenbrand
> >    5 ( +3) [3] Jiri Olsa                5 (+11) [ 5] Jiri Olsa
> >    6 (+14) [3] Simon Horman             6 ( +3) [ 5] Daniel Borkmann
> >    7 ( -4) [2] Stanislav Fomichev       7 ( -4) [ 5] Stanislav Fomichev
> >    8 ( -4) [2] Martin KaFai Lau         8 (***) [ 5] Song Liu
> >    9 ( -3) [2] Jakub Kicinski           9 (+21) [ 4] Steven Rostedt
> >   10 (+32) [2] Steven Rostedt          10 ( -6) [ 4] Martin KaFai Lau
> >   11 ( +5) [2] Toke H=C3=B8iland-J=C3=B8rgensen   11 (+15) [ 4] Simon H=
orman
> >   12 ( -3) [2] Quentin Monnet          12 ( -2) [ 4] Toke H=C3=B8iland-=
J=C3=B8rgensen
> >
> > Top authors (thr):                   Top authors (msg):
> >    1 (   ) [2] Andrii Nakryiko          1 (   ) [14] Andrii Nakryiko
> >    2 (+11) [2] Yafang Shao              2 ( +4) [11] Yafang Shao
> >    3 (+36) [1] Aditi Ghag               3 (***) [10] Maciej Fijalkowski
> >    4 (+14) [1] Jiri Olsa                4 (+27) [ 9] Masami Hiramatsu (=
Google)
> >    5 (+40) [1] Stanislav Fomichev       5 ( +2) [ 6] John Fastabend
> >    6 ( +3) [1] Eduard Zingerman         6 ( +5) [ 6] Jiri Olsa
> >    7 (***) [1] Masami Hiramatsu (Google)    7 (+40) [ 6] Stanislav Fomi=
chev
> >    8 (***) [1] Menglong Dong            8 (***) [ 5] Ian Rogers
> >    9 ( +1) [1] Daniel Borkmann          9 ( -1) [ 5] Alexei Starovoitov
> >   10 ( +6) [1] Yonghong Song           10 ( -5) [ 4] Eduard Zingerman
> >
> > Company rankings
> > ----------------
> >
> > Top reviewers (thr):                 Top reviewers (msg):
> >    1 (   ) [17] Meta                    1 (   ) [50] Meta
> >    2 (   ) [ 7] Isovalent               2 ( +3) [19] RedHat
> >    3 ( +1) [ 5] Google                  3 (   ) [13] Isovalent
> >    4 ( +1) [ 5] RedHat                  4 ( -2) [11] Google
> >    5 ( -2) [ 3] Intel                   5 ( -1) [ 6] Intel
> >    6 ( +5) [ 3] Corigine                6 ( +8) [ 4] Corigine
> >    7 ( +6) [ 1] Microsoft               7 ( +2) [ 4] nVidia
> >
> > Top authors (thr):                   Top authors (msg):
> >    1 (   ) [7] Meta                     1 (   ) [28] Meta
> >    2 (   ) [6] Isovalent                2 ( +3) [24] Google
> >    3 ( +2) [5] Google                   3 ( -1) [23] Isovalent
> >    4 ( -1) [2] RedHat                   4 ( +3) [18] Intel
> >    5 ( +1) [2] Huawei                   5 ( +3) [11] Yafang Shao
> >    6 ( -2) [2] Intel                    6 ( +3) [ 6] Huawei
> >    7 ( +6) [2] Yafang Shao              7 ( -3) [ 6] Alibaba
> >    8 (***) [1] nVidia                   8 ( -5) [ 4] RedHat
> >    9 ( +2) [1] Eduard Zingerman         9 ( -3) [ 4] Eduard Zingerman
> >
> > Yafang/Eduard, if you'd like to share you company with me, feel free
> > to drop a private email.
> >
> > New formula rankings
> > --------------------
> >
> > Top scores (positive):               Top scores (negative):
> >    1 (   ) [156] Meta                   1 ( +2) [38] Yafang Shao
> >    2 ( +3) [ 68] RedHat                 2 (***) [25] Intel
> >    3 ( +5) [ 35] Corigine               3 (***) [25] Google
> >    4 (+11) [ 15] IBM                    4 ( -3) [20] Alibaba
> >    5 (+34) [ 13] Microsoft              5 (***) [14] Menglong Dong
> >    6 ( +1) [ 10] nVidia                 6 (***) [11] Oracle
> >    7 (***) [  9] Linux Foundation       7 (***) [10] Mike Rapoport
> >    8 (***) [  8] Kent Overstreet        8 ( -4) [10] Bytedance
> >    9 ( +8) [  8] Amazon                 9 ( +5) [ 8] Lorenzo Stoakes
> >   10 (+11) [  7] Christoph Hellwig     10 ( +3) [ 7] Gilad Sever
> >   11 ( +2) [  7] SUSE                  11 (***) [ 7] Tessares
> >   12 (+10) [  7] CloudFlare            12 (***) [ 7] Eduard Zingerman
> >
> > How top authors rank in scores:
> >   1   p0 [155]  Meta
> >   2  p97 [-25]  Google
> >   3   p8 [  6]  Isovalent
> >   4  p98 [-26]  Intel
> >   5  p99 [-39]  Yafang Shao <laoar.shao@gmail.com>
> >   6  p89 [ -7]  Huawei
> >   7  p96 [-21]  Alibaba
> >   8   p0 [ 68]  RedHat
> >   9  p90 [ -7]  Eduard Zingerman <eddyz87@gmail.com>
> >  10  p96 [-15]  Menglong Dong <menglong8.dong@gmail.com>
> >  11  p95 [-11]  Oracle
> >  12  p94 [-11]  Mike Rapoport <rppt@kernel.org>
> >  13  p93 [-10]  Bytedance
> >  14   p3 [ 10]  nVidia
> >  15  p91 [ -7]  Tessares
>
>
> Thank you Stanislav for running the stats. Much appreciate it.
>
> The folks with negative scores please work on improving them.
> Negative score =3D=3D takers, not givers.
> The community is healthy when people give and take.
> For every patch sent please take time to review somebody else's patch.
>
> https://nesslabs.com/taker-giver-matcher

I thought it is the reviewer's responsibility to review :)
Now I understand it, I will take time to help review.
Thanks for your reminder.

--=20
Regards
Yafang

