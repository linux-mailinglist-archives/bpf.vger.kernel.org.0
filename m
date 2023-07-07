Return-Path: <bpf+bounces-4474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3574B64E
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 20:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4522818C3
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F84171C5;
	Fri,  7 Jul 2023 18:30:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB1174D7;
	Fri,  7 Jul 2023 18:30:45 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CB61FEF;
	Fri,  7 Jul 2023 11:30:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so2484162f8f.2;
        Fri, 07 Jul 2023 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688754642; x=1691346642;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SlBWN7OWhVhMUExcQDaNyIzjddy3YXTYXrq90Ko+2bQ=;
        b=N3FN7yhlv8Gf0kscvoYkADwR3f9G3QscUkPMVUfCbhsDyPzs/Hp5KLLXo5Uk58EvzW
         1VRl5hN3PrCX0BMSqswFhMz46NY+8P4w1UBR+GxyGEZecYaBPEu3HTOpPIn7gT50vUNS
         r9MxTgmqFX9V6mhdo9ud1YuoKuMatRNOIoiMjyRbguf52lmqUKL+kQgzmXxIoHAWD9Tz
         9z+nL6BmdUux+N2dROm/Tw706I/BkYQPvK/p37YnQ0Fw9/k7Fho0ttueoADoW0vGryac
         obCOUr31FD411wUarAP0VUU9lDRXsWCideOfalcoq5CdFbROq7TOH1eudfipz977SS5f
         OTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688754642; x=1691346642;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SlBWN7OWhVhMUExcQDaNyIzjddy3YXTYXrq90Ko+2bQ=;
        b=JAi891keKzT4jgn22h9G+jA3YXtTAybACpNMKP0pYXOQt6uu1Iu3l/l4MgEyhwfxjv
         za7BbtOFPUUMcIH4m3z+Iw2nPFadop03AhHt7SAS3J37UdoT0jSFyEx/VymxCHUaMfnd
         xh6GSc2wE+1HpCPfjm61yQG5FBccZUAhtr7FkjG8rTZXYOtzYcTr1yQdliPLW13u/Wv7
         jRkBFQoNRLegX9mMBoHa3R8s6zAnOkG9OpwlClwxoOjjwG6hi5TJWHv8BbtOaeKEQr+M
         Pqo+bs38gP5jq8mOz3LLF2hji/og3Czfxy8DPn2gAVcuz7QEDBzIRCf6xIWrWpwciSeG
         he1Q==
X-Gm-Message-State: ABy/qLan3QLlswSQS/8nELKmt5lF7uO8oynmefFp4WX/8iL3PeFAMEsz
	RHSlWESMGxNQjVM8eoBAjQcU5MBtcQIuGA+EH54OTESnd2Z4eg==
X-Google-Smtp-Source: APBJJlEHG0upgfWb1orepVX1HxskKJh2rtr2cGcEnpEabwRyA/6clKJk3DtW95xdhJ2WKQyHAEW/XD8Jcc4HmUYOFQY=
X-Received: by 2002:adf:fec7:0:b0:313:f7de:6356 with SMTP id
 q7-20020adffec7000000b00313f7de6356mr6401559wrs.15.1688754641841; Fri, 07 Jul
 2023 11:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 7 Jul 2023 11:30:30 -0700
Message-ID: <CAEf4BzYMAAhwscTWWTenvyr-PQ7E5tMg_iqXsPj_dyZEMVCrKg@mail.gmail.com>
Subject: Sockmap's parser/verdict programs and epoll notifications
To: john fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>
Cc: "davidhwei@meta.com" <davidhwei@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hey John,

We've been recently experimenting with using BPF_SK_SKB_STREAM_PARSER
and BPF_SK_SKB_STREAM_VERDICT with sockmap/sockhash to perform
in-kernel parsing of RSocket frames. A very simple format ([0]) where
the first 3 bytes specify the size of the frame payload. The idea was
to collect the entire frame in the kernel before notifying user-space
that data is available. This is meant to minimize unnecessary wakeups
due to incomplete logical frames, saving CPU.

You can find the BPF source code I've used at [1], it has lots of
extra logging and stuff, but the idea is to read the first 3 bytes of
each logical frame, and return the expected full frame size from the
parser program. The verdict program always just returns SK_PASS.

This seems to work exactly as expected in manual simulations of
various packet size distributions, and even for a bunch of
ping/pong-like benchmark (which are very sensitive to correct frame
length determination, so I'm reasonably confident we don't screw that
up much). And yet, when benchmarking sending multiple logical RPC
streams over the same single socket (so many interleaving RSocket
frames on single socket, but in terms of logical frames nothing should
change), we often see that while full frame hasn't been accumulated in
socket receive buffer yet, epoll_wait() for that socket would return
with success notifying user space that there is data on socket.
Subsequent recvfrom() call would immediately return -EAGAIN and no
data, and our benchmark would go on this loop of useless
epoll_wait()+recvfrom() calls back to back, many times over.

So I have a few questions:
  - is the above use case something that was meant to be handled by
sockmap+parser/verdict?
  - is it correct to assume that epoll won't wake up until amount of
bytes requested by parser program is accumulated (this seems to be the
case from manually experimenting with various "packet delays");
  - is there some known bug or race in how sockmap and strparser
framework interacts with epoll subsystem that could cause this weird
epoll_wait() behavior?

It does seem like some sort of timing issue, but I couldn't pin down
exactly what are the conditions that this happens in. But it's quite
reproducible with a pretty high frequency using our internal benchmark
when multiple logical streams are involved.

Any thoughts or suggestions?

  [0] https://rsocket.io/about/protocol/#framing-format
  [1] https://github.com/anakryiko/libbpf-bootstrap/blob/thrift-coalesce-rcvlowat/examples/c/bootstrap.bpf.c

-- Andrii

