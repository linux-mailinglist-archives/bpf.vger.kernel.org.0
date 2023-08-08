Return-Path: <bpf+bounces-7237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F91773D50
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12627280A73
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E34814296;
	Tue,  8 Aug 2023 16:04:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766F33C37
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 16:04:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5324A625
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691510586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcoJJyPlaY9qGuPjkOscHYRCk2xomxp+tZRbf9NDd6M=;
	b=BceOlnqX7wBHmIcfgsnGcYAGCyFTxd4PDWE+Hk9r/WDrZmqlL1+Oz+6P5bsyxc/ZpyIg+K
	JUVwbYCdmqJ16iJ7en37W96oJXz5tNKQqgexM2Q5BLkOn1gAlS6HAv/yC+HA7eqaR9WiyE
	CFpIHazYtpIlyRe2OmCMeQ31WQ8p9xE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-7T0iVOeCPOCff4kTyyL5oQ-1; Tue, 08 Aug 2023 08:01:08 -0400
X-MC-Unique: 7T0iVOeCPOCff4kTyyL5oQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99c0fb2d4b0so418894866b.0
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 05:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691496067; x=1692100867;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcoJJyPlaY9qGuPjkOscHYRCk2xomxp+tZRbf9NDd6M=;
        b=DByZK1fU38onHBh+r01xqwscHlsPFfzum44xtMzF/jAh8CYa0tL13md0x838XRggTC
         ggSHr6ry/CXeEEHg24HXl5nOm4k0+bJY8SklamkG+xmUdrUFIVSthtargcI+vy7X+OAR
         g39/YkccVNyv1SvAE6vT1aTZCWqVnQPw7JWSqXnf6J3ZhBECzBnzXdNVyNzZjL+Tv8tl
         r3AUmScCGRhxoKCjwxCiOwkSLXEp6RPT9xjpsNY+25JYqfFCkQ7z4H/dvvTcd17yIVvE
         xmLyk+Xxx8fdoGxQn1wyXKhcw2+U6CFbnXsVx9lcn3JFaWn7ZpNIdQ3XdY0Rh15N/v7V
         VAlA==
X-Gm-Message-State: AOJu0Yze2YRXFYHsjxsxdArDFNTjXFscnXRucpnfq3cRpe4OvMNSPVxM
	BU7rNoqDPUqN4s/fLmEgLh1AwsScuHBWdXWxv87l/O4B8mnV6Nsihtx80EnQ5Mw0ZQFLqcgFOEi
	1MvVaXH6M0J6i
X-Received: by 2002:a17:906:10cb:b0:99b:574f:d201 with SMTP id v11-20020a17090610cb00b0099b574fd201mr12542745ejv.40.1691496067596;
        Tue, 08 Aug 2023 05:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExprTRWssJI7svYIKpAk9QD7eZgNMMaCHszU1opQzSkcMk4JdoidE7FYhHnoUzGicOwYlHMA==
X-Received: by 2002:a17:906:10cb:b0:99b:574f:d201 with SMTP id v11-20020a17090610cb00b0099b574fd201mr12542716ejv.40.1691496067077;
        Tue, 08 Aug 2023 05:01:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm6538145ejb.97.2023.08.08.05.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 05:01:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C9617D255EA; Tue,  8 Aug 2023 14:01:04 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Albert Huang <huangjie.albert@bytedance.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: Albert Huang <huangjie.albert@bytedance.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Kees Cook <keescook@chromium.org>,
 Richard Gobert <richardbgobert@gmail.com>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC v3 Optimizing veth xsk performance 0/9]
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 08 Aug 2023 14:01:04 +0200
Message-ID: <87v8dpbv5r.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Albert Huang <huangjie.albert@bytedance.com> writes:

> AF_XDP is a kernel bypass technology that can greatly improve performance.
> However,for virtual devices like veth,even with the use of AF_XDP sockets,
> there are still many additional software paths that consume CPU resources. 
> This patch series focuses on optimizing the performance of AF_XDP sockets 
> for veth virtual devices. Patches 1 to 4 mainly involve preparatory work. 
> Patch 5 introduces tx queue and tx napi for packet transmission, while 
> patch 8 primarily implements batch sending for IPv4 UDP packets, and patch 9
> add support for AF_XDP tx need_wakup feature. These optimizations significantly
> reduce the software path and support checksum offload.
>
> I tested those feature with
> A typical topology is shown below:
> client(send):                                        server:(recv)
> veth<-->veth-peer                                    veth1-peer<--->veth1
>   1       |                                                  |   7
>           |2                                                6|
>           |                                                  |
>         bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
>                   3                    4                 5    
>              (machine1)                              (machine2)    

I definitely applaud the effort to improve the performance of af_xdp
over veth, this is something we have flagged as in need of improvement
as well.

However, looking through your patch series, I am less sure that the
approach you're taking here is the right one.

AFAIU (speaking about the TX side here), the main difference between
AF_XDP ZC and the regular transmit mode is that in the regular TX mode
the stack will allocate an skb to hold the frame and push that down the
stack. Whereas in ZC mode, there's a driver NDO that gets called
directly, bypassing the skb allocation entirely.

In this series, you're implementing the ZC mode for veth, but the driver
code ends up allocating an skb anyway. Which seems to be a bit of a
weird midpoint between the two modes, and adds a lot of complexity to
the driver that (at least conceptually) is mostly just a
reimplementation of what the stack does in non-ZC mode (allocate an skb
and push it through the stack).

So my question is, why not optimise the non-zc path in the stack instead
of implementing the zc logic for veth? It seems to me that it would be
quite feasible to apply the same optimisations (bulking, and even GRO)
to that path and achieve the same benefits, without having to add all
this complexity to the veth driver?

-Toke


