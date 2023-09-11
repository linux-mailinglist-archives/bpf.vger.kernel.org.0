Return-Path: <bpf+bounces-9643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82E79A8CE
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 16:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37631281250
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B19D11722;
	Mon, 11 Sep 2023 14:43:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C611705;
	Mon, 11 Sep 2023 14:43:29 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8B812A;
	Mon, 11 Sep 2023 07:43:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bdc19b782aso31397545ad.0;
        Mon, 11 Sep 2023 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694443408; x=1695048208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqXyW/gPoreQyo+NfRWBlaJ2aGgysVke39049lpotsw=;
        b=swQSn3nN9UW3J9rsZW+J11buO4V53xkHTZW4/k9ob1H2x6xy01z7YLTA7VX757wiGs
         P/vzryWDJC3bshDOL0W0uUGjP0/Ee/yGHiIlw1+ewTOf5mopRaZ2THHmiAeKA2dnLYbC
         +emE8sbkJYOk17ZM1LSjrtTosDJREpjic5PpJmKmiGtluStnQPF850U9EHKJ3BkjGA3/
         g5wDdpOgvhAWJCsZK2a1tfEbONDkXlf4nPdHZAYF8melF4umCJm0uMh60d7UtsQ6azE4
         DNJC0CxMLzxU4pmDPKZiSLiUqJoH4HlIqJFB7zw7o4OdYgoMpuTNNBqFvprCZVWodzEV
         Mdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694443408; x=1695048208;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RqXyW/gPoreQyo+NfRWBlaJ2aGgysVke39049lpotsw=;
        b=th/gjEqyNXkPPuOvV7PucIBoZJzg6TJjSUeXa/pr8I74X8DYAB6vfWTVgiKmNh14ke
         iz9jmcpdcAIdOG/bTGte3TF//can6+lI32Hnfxg7e0W/+kkE4a2mK936nnf6jtX2Cy6M
         Yu2gTzh200NSd657dT8sNq5blIz0JnS/6Rv1fTK4HtYv1qOdQrSdqtDWniVO0ppix3XN
         hrUparEl6jfKzLnJ4tq5yYZ7coWeoqgprxQJDUO5LYtEAGbzwBQ9gg9At/mOxIu4upWu
         G6ZMiJ5yEu8569Am3a9INZnZYM5dUAbG/O+/OcwK+yl9LAIGW+8z+k2+cHMdUr0VuZgq
         YuLg==
X-Gm-Message-State: AOJu0YwC9udFriGUggAmQjVAaBDn/sU7772MxPyvmpIu18qfPtQw4JF7
	LOn2J+TJPmuZB2NxR6ZoKSIEQVP4dSQ=
X-Google-Smtp-Source: AGHT+IEcOMJZkKhFlQiJSmp7LplEa5M510v7Ujc2fi8Ky4Q46RI+bU+iNxaB56kWGX7YSHOdAlKkpg==
X-Received: by 2002:a17:903:1248:b0:1c2:36a:52aa with SMTP id u8-20020a170903124800b001c2036a52aamr9345941plh.30.1694443408122;
        Mon, 11 Sep 2023 07:43:28 -0700 (PDT)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001bc676df6a9sm6541433ply.132.2023.09.11.07.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 07:43:27 -0700 (PDT)
Date: Mon, 11 Sep 2023 07:43:26 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
 Networking <netdev@vger.kernel.org>, 
 "davidhwei@meta.com" <davidhwei@meta.com>
Message-ID: <64ff278e16f06_2e8f2083a@john.notmuch>
In-Reply-To: <CAEf4Bzb2=p3nkaTctDcMAabzL41JjCkTso-aFrfv21z7Y0C48w@mail.gmail.com>
References: <CAEf4BzYMAAhwscTWWTenvyr-PQ7E5tMg_iqXsPj_dyZEMVCrKg@mail.gmail.com>
 <64b4c5891096b_2b67208f@john.notmuch>
 <CAEf4Bzb2=p3nkaTctDcMAabzL41JjCkTso-aFrfv21z7Y0C48w@mail.gmail.com>
Subject: Re: Sockmap's parser/verdict programs and epoll notifications
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko wrote:
> On Sun, Jul 16, 2023 at 9:37=E2=80=AFPM John Fastabend <john.fastabend@=
gmail.com> wrote:
> >
> > Andrii Nakryiko wrote:
> > > Hey John,
> >
> > Sorry missed this while I was on PTO that week.
> =

> yeah, vacations tend to cause missing things :)
> =

> >
> > >
> > > We've been recently experimenting with using BPF_SK_SKB_STREAM_PARS=
ER
> > > and BPF_SK_SKB_STREAM_VERDICT with sockmap/sockhash to perform
> > > in-kernel parsing of RSocket frames. A very simple format ([0]) whe=
re
> > > the first 3 bytes specify the size of the frame payload. The idea w=
as
> > > to collect the entire frame in the kernel before notifying user-spa=
ce
> > > that data is available. This is meant to minimize unnecessary wakeu=
ps
> > > due to incomplete logical frames, saving CPU.
> >
> > Nice.
> >
> > >
> > > You can find the BPF source code I've used at [1], it has lots of
> > > extra logging and stuff, but the idea is to read the first 3 bytes =
of
> > > each logical frame, and return the expected full frame size from th=
e
> > > parser program. The verdict program always just returns SK_PASS.
> > >
> > > This seems to work exactly as expected in manual simulations of
> > > various packet size distributions, and even for a bunch of
> > > ping/pong-like benchmark (which are very sensitive to correct frame=

> > > length determination, so I'm reasonably confident we don't screw th=
at
> > > up much). And yet, when benchmarking sending multiple logical RPC
> > > streams over the same single socket (so many interleaving RSocket
> > > frames on single socket, but in terms of logical frames nothing sho=
uld
> > > change), we often see that while full frame hasn't been accumulated=
 in
> > > socket receive buffer yet, epoll_wait() for that socket would retur=
n
> > > with success notifying user space that there is data on socket.
> > > Subsequent recvfrom() call would immediately return -EAGAIN and no
> > > data, and our benchmark would go on this loop of useless
> > > epoll_wait()+recvfrom() calls back to back, many times over.
> >
> > Aha yes this sounds bad.
> >
> > >
> > > So I have a few questions:
> > >   - is the above use case something that was meant to be handled by=

> > > sockmap+parser/verdict?
> >
> > We shouldn't wake up user space if there is nothing to read. So
> > yes this seems like a valid use case to me.
> >
> > >   - is it correct to assume that epoll won't wake up until amount o=
f
> > > bytes requested by parser program is accumulated (this seems to be =
the
> > > case from manually experimenting with various "packet delays");
> >
> > Seems there is some bug that races and causes it to wake up
> > user space. I'm aware of a couple bugs in the stream parser
> > that I wanted to fix. Not sure I can get to them this week
> > but should have time next week. We have a couple more fixes
> > to resolve a few HTTPS server compliance tests as well.
> >
> > >   - is there some known bug or race in how sockmap and strparser
> > > framework interacts with epoll subsystem that could cause this weir=
d
> > > epoll_wait() behavior?
> >
> > Yes I know of some races in strparser. I'll elaborate later
> > probably with patches as I don't recall them readily at the
> > moment.
> =

> So I missed a good chunk of BPF mailing list traffic while I was on my
> PTO. Did you end up getting to these bugs in strparser logic? Should I
> try running the latest bpf-next/net-next on our production workload to
> see if this is still happening?

You will likely still hit there error I haven't got it out of my queue
yet. I just knocked off a couple things last week so could probably
take a look at flushing my queue this week. Then it would make sense
to retest to see if its something new or not.

I'll at least send an RFC with the idea even if I don't get to testing
it yet.

Thanks,
John=

