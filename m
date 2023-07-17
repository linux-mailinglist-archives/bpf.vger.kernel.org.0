Return-Path: <bpf+bounces-5077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D2755AA8
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 06:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961A328140A
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 04:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6905384;
	Mon, 17 Jul 2023 04:37:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40C1380;
	Mon, 17 Jul 2023 04:37:35 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B669E48;
	Sun, 16 Jul 2023 21:37:32 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9d562f776so264815a34.2;
        Sun, 16 Jul 2023 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689568652; x=1692160652;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2chrSz8FPLD5T84OtSz+zScqalUZiR8JbB8TgFbdpQ=;
        b=IrtS8sCasTQPHwhYZdq4xAmG4XIPWGYwGPd7ZRzwo9PhdKEl4YmQFi0khCj/YTwWgt
         nqHXPrY7DzUd1yoGOu6mZ2xJirygjqPXiyn3giQaSpkBJaLh0lu7c1wi3zsX+PA2mTsb
         yasKrVRRdNvqxFADzV+KbH/xV7aXTkrod2ZRV++XaGjhHkE77m9UhVRpWPjJjXrGEe5y
         3gnJhDTnJh8FqJ2i6WDWMzDJ/stOH9Ik07IEjhhWprnmmkKCOQZFDChRgNIUc5b6nyQm
         pLPAQFsQmJYip6X2r88LnUHmfVnPsCAQnkZPFzWFBa5nb9qc+RwnzLGRn2d64RH+5N4p
         b3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689568652; x=1692160652;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2chrSz8FPLD5T84OtSz+zScqalUZiR8JbB8TgFbdpQ=;
        b=CepzVJxOASH79BME/uRvbGTnod/wkPepvJ+aLeg+NyHF12S2w8cL7BbVlkx7cDEAO8
         mJRkwax+u75RkdES/0JgS+DCMdMvfVXwqsknfXiFysJDEEomMf/T4pO11gedEk1OlU5B
         TXyOriFsN6iiT4ZUScX9BzCO/gM2hW/Igdr2lz7gzxYKbCGKC+wlD98BGyOXFqNI/Db3
         Z7H2uf0L+7Co7pEHxtyWOu/bHFlBCLMIpQUGaIKm+asPiFmc1AM7Q1BhCjfHMOG9VRsL
         qV9scXacdq957+pOgm8K+wqybS4WdA14rdpqpRSx5ybq8NLap4fwxBlAAnDVEBEsRGm4
         YWaw==
X-Gm-Message-State: ABy/qLYc30UFIdmJo7PGvTP+4ktziKrgbaxvyIsIdgjZ9b7273py9hmF
	VyTspxcVkNhcylhGzHmcWlY=
X-Google-Smtp-Source: APBJJlGhfbvJdSH9mK+U+1WGuHNqvKMRICwzSWRvyRJU9doa5qcE5OCJJYVW5rmqoR1HQPyrd7ekRQ==
X-Received: by 2002:a05:6358:4196:b0:135:ae78:56c9 with SMTP id w22-20020a056358419600b00135ae7856c9mr177588rwc.6.1689568651523;
        Sun, 16 Jul 2023 21:37:31 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:74ce:be18:a39c:74])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b0067eb174cb9asm10938761pfo.136.2023.07.16.21.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 21:37:30 -0700 (PDT)
Date: Sun, 16 Jul 2023 21:37:29 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 john fastabend <john.fastabend@gmail.com>, 
 bpf <bpf@vger.kernel.org>, 
 Networking <netdev@vger.kernel.org>
Cc: "davidhwei@meta.com" <davidhwei@meta.com>
Message-ID: <64b4c5891096b_2b67208f@john.notmuch>
In-Reply-To: <CAEf4BzYMAAhwscTWWTenvyr-PQ7E5tMg_iqXsPj_dyZEMVCrKg@mail.gmail.com>
References: <CAEf4BzYMAAhwscTWWTenvyr-PQ7E5tMg_iqXsPj_dyZEMVCrKg@mail.gmail.com>
Subject: RE: Sockmap's parser/verdict programs and epoll notifications
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko wrote:
> Hey John,

Sorry missed this while I was on PTO that week.

> 
> We've been recently experimenting with using BPF_SK_SKB_STREAM_PARSER
> and BPF_SK_SKB_STREAM_VERDICT with sockmap/sockhash to perform
> in-kernel parsing of RSocket frames. A very simple format ([0]) where
> the first 3 bytes specify the size of the frame payload. The idea was
> to collect the entire frame in the kernel before notifying user-space
> that data is available. This is meant to minimize unnecessary wakeups
> due to incomplete logical frames, saving CPU.

Nice.

> 
> You can find the BPF source code I've used at [1], it has lots of
> extra logging and stuff, but the idea is to read the first 3 bytes of
> each logical frame, and return the expected full frame size from the
> parser program. The verdict program always just returns SK_PASS.
> 
> This seems to work exactly as expected in manual simulations of
> various packet size distributions, and even for a bunch of
> ping/pong-like benchmark (which are very sensitive to correct frame
> length determination, so I'm reasonably confident we don't screw that
> up much). And yet, when benchmarking sending multiple logical RPC
> streams over the same single socket (so many interleaving RSocket
> frames on single socket, but in terms of logical frames nothing should
> change), we often see that while full frame hasn't been accumulated in
> socket receive buffer yet, epoll_wait() for that socket would return
> with success notifying user space that there is data on socket.
> Subsequent recvfrom() call would immediately return -EAGAIN and no
> data, and our benchmark would go on this loop of useless
> epoll_wait()+recvfrom() calls back to back, many times over.

Aha yes this sounds bad.

> 
> So I have a few questions:
>   - is the above use case something that was meant to be handled by
> sockmap+parser/verdict?

We shouldn't wake up user space if there is nothing to read. So
yes this seems like a valid use case to me.

>   - is it correct to assume that epoll won't wake up until amount of
> bytes requested by parser program is accumulated (this seems to be the
> case from manually experimenting with various "packet delays");

Seems there is some bug that races and causes it to wake up
user space. I'm aware of a couple bugs in the stream parser
that I wanted to fix. Not sure I can get to them this week
but should have time next week. We have a couple more fixes
to resolve a few HTTPS server compliance tests as well.

>   - is there some known bug or race in how sockmap and strparser
> framework interacts with epoll subsystem that could cause this weird
> epoll_wait() behavior?

Yes I know of some races in strparser. I'll elaborate later
probably with patches as I don't recall them readily at the
moment.

> 
> It does seem like some sort of timing issue, but I couldn't pin down
> exactly what are the conditions that this happens in. But it's quite
> reproducible with a pretty high frequency using our internal benchmark
> when multiple logical streams are involved.
> 
> Any thoughts or suggestions?

Seems like a bug we should fix it. I'm aware of a couple
issues with the stream parser that we plan to fix so could
be one of those or a new one I'm not aware of. I'll take
a look more closely next week.

>   [0] https://rsocket.io/about/protocol/#framing-format
>   [1] https://github.com/anakryiko/libbpf-bootstrap/blob/thrift-coalesce-rcvlowat/examples/c/bootstrap.bpf.c
> 
> -- Andrii

