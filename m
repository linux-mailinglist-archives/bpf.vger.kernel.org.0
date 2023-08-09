Return-Path: <bpf+bounces-7287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95D77753E0
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 09:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B09281AF3
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 07:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D23612D;
	Wed,  9 Aug 2023 07:14:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB9525F
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 07:14:02 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1342110
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 00:14:00 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso99891341fa.2
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 00:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691565239; x=1692170039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJc4D+pWFIMKl1qw8oGjynYOM6/qtbfYWHBOBDcE408=;
        b=F6l1lQMO2CuYyzSt7qfaHFoNCWlWGk+xh4H8Z0whKt8T+fBaENkv+d/rgaMfAWfDo0
         U1YdBws1rKhASov+2t65UG0XCkCtMWkjlkmmzS67JEHFpS1g7JeczPKzd400jgnQN1sq
         otvVjxp/93WT5lV9GwBZYDjz2zFpVuDapEJRaUX7gHs8v93Mr2r9aiqJ+pgQyvp2fPEC
         RpjCQTU0rbQLZjE3lBAa5duiUFGlZXYysa3nrS9DTIl0q41gH09EdurJjlC50WnfnPYz
         Wv/yoMEI1lY4CDAG0UI/L5RXmzw87GCjgjmWPKPKZd2s1ch9vaVpYqSvP6/0YypQ8nfw
         DZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691565239; x=1692170039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJc4D+pWFIMKl1qw8oGjynYOM6/qtbfYWHBOBDcE408=;
        b=Nd5JITLjk1+XgoX5cLX47d2cZrIjRA8y0W+/uB15nyCf77lgKjw/kLEmbhzt8fCCtT
         io1zRc1sLWHbNA/rUq1ZbFXsvmVWyeSk8U94NK1nIcLoXG79RMERVtekZwAlJeNCnBqe
         BYqXdzpZoPOiMclu7aNHjyk0tGv/k7Lru3nBzYXBZASvFsN26OJIwRLJEuRvb2LEyfwp
         8pxqjlMIeFtBKgR42ZIfpejWcPd0xKFa1vHepyZsfg194dErKvX/bzoO/eKvyHx6aLAD
         TT/av9spcWcGVRStdd5BEKhkeiPsqlDyOshpXa2MlSJUbo3nmYu9QKWIhfWBwSLCqsNt
         +5Mw==
X-Gm-Message-State: AOJu0YzrJYDhirBucvgk/XDnxfHYdUlUIg6IRNATWLdaNBjUv1SmFQN7
	osu4edZS5exHMXdYB7EZS4j5iPTX1cNzxDinqlvneQ==
X-Google-Smtp-Source: AGHT+IFgkLvwE4GsGCl1KzMvK4DkC6XWt66M+02fwT/7gz6iD9x0GSKTwJEpSerIySpR0e/pAVc4azWFRj4AGFoac2U=
X-Received: by 2002:a2e:83c8:0:b0:2b9:cdbf:5c15 with SMTP id
 s8-20020a2e83c8000000b002b9cdbf5c15mr1104297ljh.51.1691565238877; Wed, 09 Aug
 2023 00:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230808031913.46965-1-huangjie.albert@bytedance.com> <87v8dpbv5r.fsf@toke.dk>
In-Reply-To: <87v8dpbv5r.fsf@toke.dk>
From: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date: Wed, 9 Aug 2023 15:13:47 +0800
Message-ID: <CABKxMyNrwSOrzpq6mhqtU_kEk5B9nKPODtmfjJO5_NmGpw_Oag@mail.gmail.com>
Subject: Re: Re: [RFC v3 Optimizing veth xsk performance 0/9]
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Kees Cook <keescook@chromium.org>, Richard Gobert <richardbgobert@gmail.com>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> =E4=BA=8E2023=E5=B9=B48=
=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C 20:01=E5=86=99=E9=81=93=EF=BC=9A
>
> Albert Huang <huangjie.albert@bytedance.com> writes:
>
> > AF_XDP is a kernel bypass technology that can greatly improve performan=
ce.
> > However,for virtual devices like veth,even with the use of AF_XDP socke=
ts,
> > there are still many additional software paths that consume CPU resourc=
es.
> > This patch series focuses on optimizing the performance of AF_XDP socke=
ts
> > for veth virtual devices. Patches 1 to 4 mainly involve preparatory wor=
k.
> > Patch 5 introduces tx queue and tx napi for packet transmission, while
> > patch 8 primarily implements batch sending for IPv4 UDP packets, and pa=
tch 9
> > add support for AF_XDP tx need_wakup feature. These optimizations signi=
ficantly
> > reduce the software path and support checksum offload.
> >
> > I tested those feature with
> > A typical topology is shown below:
> > client(send):                                        server:(recv)
> > veth<-->veth-peer                                    veth1-peer<--->vet=
h1
> >   1       |                                                  |   7
> >           |2                                                6|
> >           |                                                  |
> >         bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
> >                   3                    4                 5
> >              (machine1)                              (machine2)
>
> I definitely applaud the effort to improve the performance of af_xdp
> over veth, this is something we have flagged as in need of improvement
> as well.
>
> However, looking through your patch series, I am less sure that the
> approach you're taking here is the right one.
>
> AFAIU (speaking about the TX side here), the main difference between
> AF_XDP ZC and the regular transmit mode is that in the regular TX mode
> the stack will allocate an skb to hold the frame and push that down the
> stack. Whereas in ZC mode, there's a driver NDO that gets called
> directly, bypassing the skb allocation entirely.
>
> In this series, you're implementing the ZC mode for veth, but the driver
> code ends up allocating an skb anyway. Which seems to be a bit of a
> weird midpoint between the two modes, and adds a lot of complexity to
> the driver that (at least conceptually) is mostly just a
> reimplementation of what the stack does in non-ZC mode (allocate an skb
> and push it through the stack).
>
> So my question is, why not optimise the non-zc path in the stack instead
> of implementing the zc logic for veth? It seems to me that it would be
> quite feasible to apply the same optimisations (bulking, and even GRO)
> to that path and achieve the same benefits, without having to add all
> this complexity to the veth driver?
>
> -Toke
>
thanks!
This idea is really good indeed. You've reminded me, and that's
something I overlooked. I will now consider implementing the solution
you've proposed and test the performance enhancement.

Albert.

