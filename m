Return-Path: <bpf+bounces-11244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495AD7B6031
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 07:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 00EF71C209BE
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 05:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F317F1;
	Tue,  3 Oct 2023 05:04:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9BF1375;
	Tue,  3 Oct 2023 05:04:54 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C3AD;
	Mon,  2 Oct 2023 22:04:52 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57b8cebf57dso282770eaf.0;
        Mon, 02 Oct 2023 22:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696309492; x=1696914292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MJCSuo9K7O9eYPrXHwrEyWWfpTMv/syCaTyoqekkao=;
        b=Q8Mg92Ue0Tw7zT8Y7Fkg+J5OJe4AhWuhJkuqASCou1/9re44vLTq4FoEPCMTHD15OJ
         rdSZ7uC0DWZ9XqDiP1eMKmXMZYNkR+LViic2lLAerODD0iVo9GzV08tWjS59s1fUC1zU
         pCx510lnKZRwM/spyss+M/8vEfz4PILg84fgH/ka3zhD9odXBYJDwNiJi+iKD9tMQZit
         EiQvqOtL6hVKioTuE2wGt3W4H0XyiDMpbzLj0UEIWgYEayL6id6TIccUTFlJMX74+eLm
         8IWz67/9xVdpP/XewzEl3xYNI4B0ZI1UcGaWQCu+9OWnypPGEjzrkvtcso0t8ubTHfX0
         og3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696309492; x=1696914292;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MJCSuo9K7O9eYPrXHwrEyWWfpTMv/syCaTyoqekkao=;
        b=UxzkMA4gL3yLpOvHp4GDacPXnwLQ5uU6ODTr203RF1xAISNtRwJfvPjAqKyilxDBsB
         57oG00pgij090QDtflRVJtbmdlo6Z5V/9x/iqJLWO0v3nUgxXi+0UiwSBgsOSgt4+V6r
         S19945dCEAwJNXJ1qNl8Z2/TAlFKfW1FeH1kf8haTSCHyfH50p0a7X6fjob17wp+GfMy
         6p5HIrwkvBFpj2P0m6ezDkBpYLtUzcOq6M3MqxzDDz9a/XWa26fvcK3eDTqqsWNlb4B0
         9saO67FohcjL7e8la4WbflU5AKR1lHTT1mkRcptNDFEUxdlZkxhHm+4keANjn8m6mio6
         f+Qg==
X-Gm-Message-State: AOJu0YxX8yHANFR+WHrz6duEsUZ4iAREkD/DtGicnNIsZHFoI23SNt+2
	eWwMFr8FBYPnQ/9qFOrnQV7y5theNoU=
X-Google-Smtp-Source: AGHT+IEfLJt62oCpGHpzGCTHZyfaI+E+sUV9TEsshA5o4PMbXj+dOeHapbeQErJ24VErUaDw6LX2HQ==
X-Received: by 2002:a05:6358:4297:b0:13a:a85b:a4ce with SMTP id s23-20020a056358429700b0013aa85ba4cemr14245639rwc.16.1696309491298;
        Mon, 02 Oct 2023 22:04:51 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:2a00:5720:bdb8:2705])
        by smtp.gmail.com with ESMTPSA id v18-20020a63ac12000000b00588e8421fa8sm412762pge.84.2023.10.02.22.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 22:04:50 -0700 (PDT)
Date: Mon, 02 Oct 2023 22:04:49 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
 Networking <netdev@vger.kernel.org>, 
 "davidhwei@meta.com" <davidhwei@meta.com>
Message-ID: <651ba0f13cb51_4fa3f20824@john.notmuch>
In-Reply-To: <CAEf4Bzb1fMy5beHKxCjvoeCqaYmQFvnjnMi9bgWoML0v27n3SQ@mail.gmail.com>
References: <CAEf4BzYMAAhwscTWWTenvyr-PQ7E5tMg_iqXsPj_dyZEMVCrKg@mail.gmail.com>
 <64b4c5891096b_2b67208f@john.notmuch>
 <CAEf4Bzb2=p3nkaTctDcMAabzL41JjCkTso-aFrfv21z7Y0C48w@mail.gmail.com>
 <64ff278e16f06_2e8f2083a@john.notmuch>
 <CAEf4Bzb1fMy5beHKxCjvoeCqaYmQFvnjnMi9bgWoML0v27n3SQ@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko wrote:
> On Mon, Sep 11, 2023 at 7:43=E2=80=AFAM John Fastabend <john.fastabend@=
gmail.com> wrote:
> >
> > Andrii Nakryiko wrote:
> > > On Sun, Jul 16, 2023 at 9:37=E2=80=AFPM John Fastabend <john.fastab=
end@gmail.com> wrote:
> > > >
> > > > Andrii Nakryiko wrote:
> > > > > Hey John,
> > > >
> > > > Sorry missed this while I was on PTO that week.
> > >
> > > yeah, vacations tend to cause missing things :)
> > >
> > > >
> > > > >
> > > > > We've been recently experimenting with using BPF_SK_SKB_STREAM_=
PARSER
> > > > > and BPF_SK_SKB_STREAM_VERDICT with sockmap/sockhash to perform
> > > > > in-kernel parsing of RSocket frames. A very simple format ([0])=
 where
> > > > > the first 3 bytes specify the size of the frame payload. The id=
ea was
> > > > > to collect the entire frame in the kernel before notifying user=
-space
> > > > > that data is available. This is meant to minimize unnecessary w=
akeups
> > > > > due to incomplete logical frames, saving CPU.
> > > >
> > > > Nice.
> > > >
> > > > >
> > > > > You can find the BPF source code I've used at [1], it has lots =
of
> > > > > extra logging and stuff, but the idea is to read the first 3 by=
tes of
> > > > > each logical frame, and return the expected full frame size fro=
m the
> > > > > parser program. The verdict program always just returns SK_PASS=
.
> > > > >
> > > > > This seems to work exactly as expected in manual simulations of=

> > > > > various packet size distributions, and even for a bunch of
> > > > > ping/pong-like benchmark (which are very sensitive to correct f=
rame
> > > > > length determination, so I'm reasonably confident we don't scre=
w that
> > > > > up much). And yet, when benchmarking sending multiple logical R=
PC
> > > > > streams over the same single socket (so many interleaving RSock=
et
> > > > > frames on single socket, but in terms of logical frames nothing=
 should
> > > > > change), we often see that while full frame hasn't been accumul=
ated in
> > > > > socket receive buffer yet, epoll_wait() for that socket would r=
eturn
> > > > > with success notifying user space that there is data on socket.=

> > > > > Subsequent recvfrom() call would immediately return -EAGAIN and=
 no
> > > > > data, and our benchmark would go on this loop of useless
> > > > > epoll_wait()+recvfrom() calls back to back, many times over.
> > > >
> > > > Aha yes this sounds bad.
> > > >
> > > > >
> > > > > So I have a few questions:
> > > > >   - is the above use case something that was meant to be handle=
d by
> > > > > sockmap+parser/verdict?
> > > >
> > > > We shouldn't wake up user space if there is nothing to read. So
> > > > yes this seems like a valid use case to me.
> > > >
> > > > >   - is it correct to assume that epoll won't wake up until amou=
nt of
> > > > > bytes requested by parser program is accumulated (this seems to=
 be the
> > > > > case from manually experimenting with various "packet delays");=

> > > >
> > > > Seems there is some bug that races and causes it to wake up
> > > > user space. I'm aware of a couple bugs in the stream parser
> > > > that I wanted to fix. Not sure I can get to them this week
> > > > but should have time next week. We have a couple more fixes
> > > > to resolve a few HTTPS server compliance tests as well.
> > > >
> > > > >   - is there some known bug or race in how sockmap and strparse=
r
> > > > > framework interacts with epoll subsystem that could cause this =
weird
> > > > > epoll_wait() behavior?
> > > >
> > > > Yes I know of some races in strparser. I'll elaborate later
> > > > probably with patches as I don't recall them readily at the
> > > > moment.
> > >
> > > So I missed a good chunk of BPF mailing list traffic while I was on=
 my
> > > PTO. Did you end up getting to these bugs in strparser logic? Shoul=
d I
> > > try running the latest bpf-next/net-next on our production workload=
 to
> > > see if this is still happening?
> >
> > You will likely still hit there error I haven't got it out of my queu=
e
> > yet. I just knocked off a couple things last week so could probably
> > take a look at flushing my queue this week. Then it would make sense
> > to retest to see if its something new or not.
> >
> > I'll at least send an RFC with the idea even if I don't get to testin=
g
> > it yet.
> =

> Sounds good, thanks a lot!
> =

> >
> > Thanks,
> > John

Hi Andrii,

Finally got around to thinking about this. And also I belive we have
the verdict programs mostly fixed up to handle polling correctly now.
The problem was incorrectly handling the tcp_sock copied_seq var
which is used by tcp_epollin_ready() to wakeup the application. Its
also used to calculate responses to some ioctl we found servers using
to decide when to actually do a recv, e.g. they wait on the ioctl until
enough bytes are received.

The trick is to ensure we only update copied_seq when the bytes are
in fact actually ready to read from socket queue. The sockmap verdict
program code was incrementing this before running the verdict prog
so we raced with userspace. It kind of works in many cases because
we are holding the sock lock in many cases so we block the user space
recvmsg.

Now to your problem as I understand it. You are trying to use the
parser program to hold some N bytes where N is the message block.
At which point it will get pushed to a verdict prog and finally
queued in the msg recieve queue so a syscall to recv*() can
actually read it. The parser program, unlike if you just have
a verdict prog, causes the skb to run through the stream parser to
collect bytes and then run the verdict program. The stream parser
is using tcp_read_sock() which increments the seq_copied immediately
even before the  verdict prog is run so I expect the odd behavior
you see is when that race completes. It likely  mostly works because
we have the sock lock for lots of the code making the race behavior
smaller than it might otherwise appear. I didn't do a full anlaysis
but it might just be when we hit an ENOMEM condition and need to
backoff. Which might explain why you only see the issue when you
run with larger envs.

It feels a bit suboptimal in your case to run two BPF programs and
parser logic compared to a single verdict program. Could we just
add a bpf helper we can run from the verdict program to only wake
up the user space after N bytes. To mirror the sk_msg programs we
migth call it bpf_skb_cork_bytes(skb, bytes, flags). We could use
flags to decide if we need to call the prog again with the new
full sized skb or if we can just process it directly without the
extra BPF call.

This with the other piece we want from our side to allow running
verdict and sk_msg programs on sockets without having them in a
sockmap/sockhash it would seem like a better system to me. The
idea to drop the sockmap/sockhash is because we never remove progs
once they are added and we add them from sockops side. The filter
to socketes is almost always the port + metadata related to the
process or environment. This simplifies having to manage the
sockmap/sockhash and guess what size it should be. Sometimes we
overrun these maps and have to kill connections until we can
get more space.

For you case I would expect it to be (a) simpler just a single
program to manage instead of two and a map and (b) more efficient
to call one prog in datapath vs two.

WDYT?

Thanks,
John=

