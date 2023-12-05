Return-Path: <bpf+bounces-16674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5639804371
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8155C281441
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D821A5A;
	Tue,  5 Dec 2023 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6gRTDcF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9D3A0;
	Mon,  4 Dec 2023 16:32:16 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-58de42d0ff7so3061522eaf.0;
        Mon, 04 Dec 2023 16:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701736335; x=1702341135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k/iT9QbQcdIktzGlKhKu0mCy3RV8A6MzEQO1Re6Aos=;
        b=D6gRTDcFlxaJsEnSPX7LvnU3wSZUITOrFwU+OiYOv3E4P05mdUHWHn8G8DIYebAQ4W
         SoFO9sfaJcX9iGFgtp4XHssntW58Y6JfC8+wbzRQBgS1Z60G8JscVmKI7JTKcckn1Qok
         sYz9XVpnsgg2wMUTw1eDooGHKwjhLaIhU4KKedBH9DJbow97V+EbCuNb5ATVBBA/+efI
         fNqBJTA1KsbT+J+RHu/IYhe7qI8i4yVGStqwEDbggLevd61q/qcm/xjG1rXyuoEfs9wY
         A+LrLGuz5NAibjpzCDNkAxFo2v2YYscLQFueDTuAt4CELDGIuWfO+jMwDxb7skrTmzG7
         2NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701736335; x=1702341135;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2k/iT9QbQcdIktzGlKhKu0mCy3RV8A6MzEQO1Re6Aos=;
        b=PdW7I5LRvXw24g0hUCaEOFRY0IHyCSuP3zpuxNohulbCW709BlWlnbCicgWk/YYL44
         LwC+7VSK+e06dEG2NGLSoxtJ6qjd+W8WC1iH9Pwoz4oP1uvsgmAqilwG35EUJpdBej8Y
         BwUJht71QGSQia05v4ACH6zH41XdpRZ2KNFYYaaL2gzHP5pKt6Owp0sNLwekUo0w0RXz
         DlwGiAIiUwbAX+wvanr+QGN+twBjUZDPcB6d+4EsAxWjCkNCxFCrDectVDnZS4EL8Jqw
         sn0uq7q+5FgMbKt9Z0urV88io9GBcf+AMKxVZfg02FtdsxWgeMUNWP99EZFvY2PSB0qH
         aEuA==
X-Gm-Message-State: AOJu0YxDxVo7m6Ur2jzIbbNUP2QWOZMtzUFrs2nRJe+2kscwvPndM/TJ
	4HwzT1A57xLxK56rja1JmDs=
X-Google-Smtp-Source: AGHT+IGHyqjPg9Xmi9szOTvwXFcQoP7ScDtIi/z5jJVB9jf+Qb7SXW6wy4yfwZBl8ttWf7d8nH8/Pg==
X-Received: by 2002:a05:6358:7e0e:b0:170:7af:add0 with SMTP id o14-20020a0563587e0e00b0017007afadd0mr3292597rwm.22.1701736335322;
        Mon, 04 Dec 2023 16:32:15 -0800 (PST)
Received: from localhost ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id iy14-20020a17090b16ce00b00285db538b17sm8245474pjb.41.2023.12.04.16.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:32:14 -0800 (PST)
Date: Mon, 04 Dec 2023 16:32:13 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, 
 anjali.singhai@intel.com, 
 namrata.limaye@intel.com, 
 mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, 
 tomasz.osinski@intel.com, 
 jiri@resnulli.us, 
 xiyou.wangcong@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 vladbu@nvidia.com, 
 horms@kernel.org, 
 khalidm@nvidia.com, 
 toke@redhat.com, 
 daniel@iogearbox.net, 
 bpf@vger.kernel.org
Message-ID: <656e6f8d7c99f_207cb2087c@john.notmuch>
In-Reply-To: <20231201182904.532825-16-jhs@mojatatu.com>
References: <20231201182904.532825-1-jhs@mojatatu.com>
 <20231201182904.532825-16-jhs@mojatatu.com>
Subject: RE: [PATCH net-next v9 15/15] p4tc: add P4 classifier
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jamal Hadi Salim wrote:
> Introduce P4 tc classifier. A tc filter instantiated on this classifier
> is used to bind a P4 pipeline to one or more netdev ports. To use P4
> classifier you must specify a pipeline name that will be associated to
> this filter, a s/w parser and datapath ebpf program. The pipeline must have
> already been created via a template.
> For example, if we were to add a filter to ingress of network interface
> device $P0 and associate it to P4 pipeline simple_l3 we'd issue the
> following command:

In addition to my comments from last iteration.

> 
> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>     action bpf obj $PARSER.o section prog/tc-parser \
>     action bpf obj $PROGNAME.o section prog/tc-ingress

Having multiple object files is a mistake IMO and will cost
performance. Have a single object file avoid stitching together
metadata and run to completion. And then run entirely from XDP
this is how we have been getting good performance numbers.

> 
> $PROGNAME.o and $PARSER.o is a compilation of the eBPF programs generated
> by the P4 compiler and will be the representation of the P4 program.
> Note that filter understands that $PARSER.o is a parser to be loaded
> at the tc level. The datapath program is merely an eBPF action.
> 
> Note we do support a distinct way of loading the parser as opposed to
> making it be an action, the above example would be:
> 
> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>     prog type tc obj $PARSER.o ... \
>     action bpf obj $PROGNAME.o section prog/tc-ingress
> 
> We support two types of loadings of these initial programs in the pipeline
> and differentiate between what gets loaded at tc vs xdp by using syntax of
> 
> either "prog type tc obj" or "prog type xdp obj"
> 
> For XDP:
> 
> tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_l3 \
>     prog type xdp obj $PARSER.o section parser/xdp \
>     pinned_link /sys/fs/bpf/mylink \
>     action bpf obj $PROGNAME.o section prog/tc-ingress

I don't think tc should be loading xdp programs. XDP is not 'tc'.

> 
> The theory of operations is as follows:
> 
> ================================1. PARSING================================
> 
> The packet first encounters the parser.
> The parser is implemented in ebpf residing either at the TC or XDP
> level. The parsed header values are stored in a shared eBPF map.
> When the parser runs at XDP level, we load it into XDP using tc filter
> command and pin it to a file.
> 
> =============================2. ACTIONS=============================
> 
> In the above example, the P4 program (minus the parser) is encoded in an
> action($PROGNAME.o). It should be noted that classical tc actions
> continue to work:
> IOW, someone could decide to add a mirred action to mirror all packets
> after or before the ebpf action.
> 
> tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
>     prog type tc obj $PARSER.o section parser/tc-ingress \
>     action bpf obj $PROGNAME.o section prog/tc-ingress \
>     action mirred egress mirror index 1 dev $P1 \
>     action bpf obj $ANOTHERPROG.o section mysect/section-1
> 
> It should also be noted that it is feasible to split some of the ingress
> datapath into XDP first and more into TC later (as was shown above for
> example where the parser runs at XDP level). YMMV.

Is there any performance value in partial XDP and partial TC? The main
wins we see in XDP are when we can drop, redirect, etc the packet
entirely in XDP and avoid skb altogether.

> 
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

