Return-Path: <bpf+bounces-9563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 925AC799261
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 00:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CB5281C36
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55B76FA8;
	Fri,  8 Sep 2023 22:47:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F0B1C16;
	Fri,  8 Sep 2023 22:47:03 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31751FEA;
	Fri,  8 Sep 2023 15:47:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso3331531a12.3;
        Fri, 08 Sep 2023 15:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694213220; x=1694818020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6K2rJP//kcnmnnyrCr1AR1/fYTmbA+UgN7K0TAwTbo=;
        b=MR/3j7m/vJ8aHVBj92IpXVQFVdPrnoECwXZc7a1Dv0jvXNfwjHXwxFSoerd9Gngd3/
         LPjyvVmsEPR42Y7hvgSUWsmkIj5iQdd30kqjChFl6YBdaKfNBdifmCjbP9ohIiBvcyUA
         djl17zgTZnDThU3l7TYmzlZ+VK/MCD4MkF65cssyoE4nGI68+xmWlcrnT8ulW9GX+UjA
         5azoCzjk5NrS/C2PYUfMMbXQkyRbiaQ921Z8pTgAOAW739LEMgACyNWjNm3ebDl49ii+
         +EEnEKSOCls6Gd/BKVdXVpiIQWCN2t3jC9opgbUC96qgUpnzYqVYVX03SKrdqAAq59eL
         c5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694213220; x=1694818020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6K2rJP//kcnmnnyrCr1AR1/fYTmbA+UgN7K0TAwTbo=;
        b=ER/OcoYT0lrdWI4AsUE+j5R2NRzuZwreou+bLMm2t+yigToqJl4nseFR6gNoNH/qsx
         upVgMz7VXunzCazKah67M9wdJUIpkDyL865jq9zPbTdYTNV84qWZk/CIA9NheUk/T8zQ
         I0uLdazuZCS2i1YsK1HsIv5Gv1l+QZx9RpOaQnVL7rlW+PW8CF+vuoDbdrkaIordZXo1
         xkb2fGqOgbBbKhL6qgckz08L31ZqWmtdOFrFtpFN+fU97kRh/rtiJAS2AHumADjE57n6
         YKzyKIOJ83isWaZRDIhsFgF5Oft4wOLwzUwyTJpJABI1VJGWJ4YrHExjD27yGMgbWMVz
         525w==
X-Gm-Message-State: AOJu0YybhX94H81E1Ff8MD7B9a2t/at2aZ+gvpRck3gfvxOPSOH12w57
	kdB//CgP3PJfzGgRl4hKzlYKudDZ+B58PN2RKW4=
X-Google-Smtp-Source: AGHT+IHqEecVp6hLJrqRZvxJExq6jVx1Pmb89B9U7CmxDdJHY2g1AA3ODPBmEc69vC+/abGYE3Um1zsqrIKM+ympEx0=
X-Received: by 2002:a05:6402:493:b0:523:100b:462b with SMTP id
 k19-20020a056402049300b00523100b462bmr3127005edv.5.1694213219801; Fri, 08 Sep
 2023 15:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYMAAhwscTWWTenvyr-PQ7E5tMg_iqXsPj_dyZEMVCrKg@mail.gmail.com>
 <64b4c5891096b_2b67208f@john.notmuch>
In-Reply-To: <64b4c5891096b_2b67208f@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Sep 2023 15:46:48 -0700
Message-ID: <CAEf4Bzb2=p3nkaTctDcMAabzL41JjCkTso-aFrfv21z7Y0C48w@mail.gmail.com>
Subject: Re: Sockmap's parser/verdict programs and epoll notifications
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	"davidhwei@meta.com" <davidhwei@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 16, 2023 at 9:37=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Andrii Nakryiko wrote:
> > Hey John,
>
> Sorry missed this while I was on PTO that week.

yeah, vacations tend to cause missing things :)

>
> >
> > We've been recently experimenting with using BPF_SK_SKB_STREAM_PARSER
> > and BPF_SK_SKB_STREAM_VERDICT with sockmap/sockhash to perform
> > in-kernel parsing of RSocket frames. A very simple format ([0]) where
> > the first 3 bytes specify the size of the frame payload. The idea was
> > to collect the entire frame in the kernel before notifying user-space
> > that data is available. This is meant to minimize unnecessary wakeups
> > due to incomplete logical frames, saving CPU.
>
> Nice.
>
> >
> > You can find the BPF source code I've used at [1], it has lots of
> > extra logging and stuff, but the idea is to read the first 3 bytes of
> > each logical frame, and return the expected full frame size from the
> > parser program. The verdict program always just returns SK_PASS.
> >
> > This seems to work exactly as expected in manual simulations of
> > various packet size distributions, and even for a bunch of
> > ping/pong-like benchmark (which are very sensitive to correct frame
> > length determination, so I'm reasonably confident we don't screw that
> > up much). And yet, when benchmarking sending multiple logical RPC
> > streams over the same single socket (so many interleaving RSocket
> > frames on single socket, but in terms of logical frames nothing should
> > change), we often see that while full frame hasn't been accumulated in
> > socket receive buffer yet, epoll_wait() for that socket would return
> > with success notifying user space that there is data on socket.
> > Subsequent recvfrom() call would immediately return -EAGAIN and no
> > data, and our benchmark would go on this loop of useless
> > epoll_wait()+recvfrom() calls back to back, many times over.
>
> Aha yes this sounds bad.
>
> >
> > So I have a few questions:
> >   - is the above use case something that was meant to be handled by
> > sockmap+parser/verdict?
>
> We shouldn't wake up user space if there is nothing to read. So
> yes this seems like a valid use case to me.
>
> >   - is it correct to assume that epoll won't wake up until amount of
> > bytes requested by parser program is accumulated (this seems to be the
> > case from manually experimenting with various "packet delays");
>
> Seems there is some bug that races and causes it to wake up
> user space. I'm aware of a couple bugs in the stream parser
> that I wanted to fix. Not sure I can get to them this week
> but should have time next week. We have a couple more fixes
> to resolve a few HTTPS server compliance tests as well.
>
> >   - is there some known bug or race in how sockmap and strparser
> > framework interacts with epoll subsystem that could cause this weird
> > epoll_wait() behavior?
>
> Yes I know of some races in strparser. I'll elaborate later
> probably with patches as I don't recall them readily at the
> moment.

So I missed a good chunk of BPF mailing list traffic while I was on my
PTO. Did you end up getting to these bugs in strparser logic? Should I
try running the latest bpf-next/net-next on our production workload to
see if this is still happening?

>
> >
> > It does seem like some sort of timing issue, but I couldn't pin down
> > exactly what are the conditions that this happens in. But it's quite
> > reproducible with a pretty high frequency using our internal benchmark
> > when multiple logical streams are involved.
> >
> > Any thoughts or suggestions?
>
> Seems like a bug we should fix it. I'm aware of a couple
> issues with the stream parser that we plan to fix so could
> be one of those or a new one I'm not aware of. I'll take
> a look more closely next week.
>
> >   [0] https://rsocket.io/about/protocol/#framing-format
> >   [1] https://github.com/anakryiko/libbpf-bootstrap/blob/thrift-coalesc=
e-rcvlowat/examples/c/bootstrap.bpf.c
> >
> > -- Andrii

