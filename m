Return-Path: <bpf+bounces-9677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D364C79AAB0
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 20:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900B1281253
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB55156E8;
	Mon, 11 Sep 2023 18:01:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67254156DF;
	Mon, 11 Sep 2023 18:01:45 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C9A103;
	Mon, 11 Sep 2023 11:01:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c136ee106so594030566b.1;
        Mon, 11 Sep 2023 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694455302; x=1695060102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wuqr/SJlcmFyZdXtrVtsbFVis4YJvJcZZ7ZjftUCRXA=;
        b=U4XusRWPM5v03KUhor84USo1pxV9zsPfLPmAW0hrwttpO8gKL+FWDFiz0XmeCYt8IF
         5Jz07dNG0lsPuTyYjaly8DFnF73DXv95FssTfBxPSNSBz6IY29NSBHpLBJLDWukKtDOU
         rv5VE/f2xkhTjMYOq7iRNo5QrF59a5B9n9NTxqvX05HylPW59Hk3uKADMa15AISBC2yr
         IkQWDtOvaOeSQOqnvx6rDWFrRfyS9OJSz1WuYUTsq4ppHXKxwJBrvImz2UqtYG0xGrMA
         FFVBaHmGBfBigtbUL757I5RV0D0KsJrC50pFxjAjwnfcN1AdVvigS6YfUum4o0O+ED+/
         v/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694455302; x=1695060102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wuqr/SJlcmFyZdXtrVtsbFVis4YJvJcZZ7ZjftUCRXA=;
        b=en2rMpMX2h2FyBCfM/37jtvjl9et5PYQn0TELJN9kWdJUWZppmMiPN4PN2dFtltRA7
         aO8D84f6cbVNgc5++hb05VPFTXFsUuuLOEwazFOjhMRxaWAWbLyojHXxHnAqH9O8KxpE
         YrXEWiDmoCEFOO1XUqWcxJG+83G85P+bx6of+dSfTObvo+GQZphUPwI90z93zlBxz6VG
         U2xD0o3HT5MXCoDblubOl+Md20BXsxOIzlKIz6WSGEsuzl+dNRAYMT66s5ChATGJwqfx
         Nx3LVPWGUw4/jkbWIA1ijr5I0GHQlKW70CDnBG8dLdEdBR78aPxL8ESwgb2LhXC50Fxa
         mQIg==
X-Gm-Message-State: AOJu0YyP9lbcL25YLUllltquwMeKKsPiuyY27k6vWIvdW+0irXx7cPrV
	ZtLxY+Z79z4t3pjuorlZGbiT1prf2U+UJ5dsCJY=
X-Google-Smtp-Source: AGHT+IGghJcloW80Nv5Dqafuj5HzFfwihzzeHCX+C3d5DH/bEXzhpxWZvYSVapoxVJaOYmfJoVaem72fCNNyAARLPlk=
X-Received: by 2002:a17:906:74c5:b0:9a1:eb67:c0ce with SMTP id
 z5-20020a17090674c500b009a1eb67c0cemr9421769ejl.50.1694455301555; Mon, 11 Sep
 2023 11:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYMAAhwscTWWTenvyr-PQ7E5tMg_iqXsPj_dyZEMVCrKg@mail.gmail.com>
 <64b4c5891096b_2b67208f@john.notmuch> <CAEf4Bzb2=p3nkaTctDcMAabzL41JjCkTso-aFrfv21z7Y0C48w@mail.gmail.com>
 <64ff278e16f06_2e8f2083a@john.notmuch>
In-Reply-To: <64ff278e16f06_2e8f2083a@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Sep 2023 11:01:29 -0700
Message-ID: <CAEf4Bzb1fMy5beHKxCjvoeCqaYmQFvnjnMi9bgWoML0v27n3SQ@mail.gmail.com>
Subject: Re: Sockmap's parser/verdict programs and epoll notifications
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	"davidhwei@meta.com" <davidhwei@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 11, 2023 at 7:43=E2=80=AFAM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Andrii Nakryiko wrote:
> > On Sun, Jul 16, 2023 at 9:37=E2=80=AFPM John Fastabend <john.fastabend@=
gmail.com> wrote:
> > >
> > > Andrii Nakryiko wrote:
> > > > Hey John,
> > >
> > > Sorry missed this while I was on PTO that week.
> >
> > yeah, vacations tend to cause missing things :)
> >
> > >
> > > >
> > > > We've been recently experimenting with using BPF_SK_SKB_STREAM_PARS=
ER
> > > > and BPF_SK_SKB_STREAM_VERDICT with sockmap/sockhash to perform
> > > > in-kernel parsing of RSocket frames. A very simple format ([0]) whe=
re
> > > > the first 3 bytes specify the size of the frame payload. The idea w=
as
> > > > to collect the entire frame in the kernel before notifying user-spa=
ce
> > > > that data is available. This is meant to minimize unnecessary wakeu=
ps
> > > > due to incomplete logical frames, saving CPU.
> > >
> > > Nice.
> > >
> > > >
> > > > You can find the BPF source code I've used at [1], it has lots of
> > > > extra logging and stuff, but the idea is to read the first 3 bytes =
of
> > > > each logical frame, and return the expected full frame size from th=
e
> > > > parser program. The verdict program always just returns SK_PASS.
> > > >
> > > > This seems to work exactly as expected in manual simulations of
> > > > various packet size distributions, and even for a bunch of
> > > > ping/pong-like benchmark (which are very sensitive to correct frame
> > > > length determination, so I'm reasonably confident we don't screw th=
at
> > > > up much). And yet, when benchmarking sending multiple logical RPC
> > > > streams over the same single socket (so many interleaving RSocket
> > > > frames on single socket, but in terms of logical frames nothing sho=
uld
> > > > change), we often see that while full frame hasn't been accumulated=
 in
> > > > socket receive buffer yet, epoll_wait() for that socket would retur=
n
> > > > with success notifying user space that there is data on socket.
> > > > Subsequent recvfrom() call would immediately return -EAGAIN and no
> > > > data, and our benchmark would go on this loop of useless
> > > > epoll_wait()+recvfrom() calls back to back, many times over.
> > >
> > > Aha yes this sounds bad.
> > >
> > > >
> > > > So I have a few questions:
> > > >   - is the above use case something that was meant to be handled by
> > > > sockmap+parser/verdict?
> > >
> > > We shouldn't wake up user space if there is nothing to read. So
> > > yes this seems like a valid use case to me.
> > >
> > > >   - is it correct to assume that epoll won't wake up until amount o=
f
> > > > bytes requested by parser program is accumulated (this seems to be =
the
> > > > case from manually experimenting with various "packet delays");
> > >
> > > Seems there is some bug that races and causes it to wake up
> > > user space. I'm aware of a couple bugs in the stream parser
> > > that I wanted to fix. Not sure I can get to them this week
> > > but should have time next week. We have a couple more fixes
> > > to resolve a few HTTPS server compliance tests as well.
> > >
> > > >   - is there some known bug or race in how sockmap and strparser
> > > > framework interacts with epoll subsystem that could cause this weir=
d
> > > > epoll_wait() behavior?
> > >
> > > Yes I know of some races in strparser. I'll elaborate later
> > > probably with patches as I don't recall them readily at the
> > > moment.
> >
> > So I missed a good chunk of BPF mailing list traffic while I was on my
> > PTO. Did you end up getting to these bugs in strparser logic? Should I
> > try running the latest bpf-next/net-next on our production workload to
> > see if this is still happening?
>
> You will likely still hit there error I haven't got it out of my queue
> yet. I just knocked off a couple things last week so could probably
> take a look at flushing my queue this week. Then it would make sense
> to retest to see if its something new or not.
>
> I'll at least send an RFC with the idea even if I don't get to testing
> it yet.

Sounds good, thanks a lot!

>
> Thanks,
> John

