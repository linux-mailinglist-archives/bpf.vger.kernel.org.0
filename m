Return-Path: <bpf+bounces-12539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EBB7CD978
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 12:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC455281BB6
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204E18C20;
	Wed, 18 Oct 2023 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Za7iYfeo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF0F171AE
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 10:42:57 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E711A10A
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 03:42:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c2a0725825so545841566b.2
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 03:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697625774; x=1698230574; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=DD//RB5HzgwDO2+uqGPcSev8BgcvzwqxQz19yWVzT1k=;
        b=Za7iYfeoRqae2rVUr8lRIIFrK6Os+q1YS4j4EQkhVFKt7f0KnyZbONNOPegJFTbzqZ
         rPDsgvgk5maheMnmLjTt+/YE8MOO+mfAob2dyIkh+reVx0Pt5+AscBsYZS/KiteK/bTH
         pCe1Z9cMQNVnEAwt7CsqbatkSyB5fFeOG3ulr7ceqFAnmNF9JpRKNJrZ6d7kKJcMgDG4
         qA8lQkb9AeivvU54BKNv7w6raKg32xQeqwTBQZpE7jjatCUH0e0zsDV84HBt3LNOdpoI
         qmdrgOvV140bAxv/SPXYSe24LLHNcL2+VYbCX0cXK0rPLGoY5k+CFeiGa1PfESjUD2GW
         lfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625774; x=1698230574;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD//RB5HzgwDO2+uqGPcSev8BgcvzwqxQz19yWVzT1k=;
        b=hI98JyxFDvOXdUyCCmx5c+MH6jAy1QZCcoGLg3GaNcMc7G1DYMVzTzIeAwoZXtwr3t
         9myuL9wsviZfRR16Yy4BFVZVtdzSeoTrtlD6MwyhaN70Q1XqR+QEpJhKaSlz90ig5wYj
         0vSD4v0v02uKWeoR3DE3gjIzrCodevLVbhEThqt3eD+9YPDIINKvrrkWZTC+0aO/jgUy
         wPBhY92wePLHnkidVkQmBf0GPokxUMmY3QBYFMGI2fNGGLcOcJMUxA7JbHBwDs3r9HbS
         XPtmPkcvNOEmIVq4qaWCyJsaXJIpgQbRwVcxoT3BlfK086Gq1krOWCRK9iCGSUMMRLNi
         lXTQ==
X-Gm-Message-State: AOJu0YyyJvBq4OjZTxdeXjphG4nJdxflnTMcUonq6P5IQChGDQZTUfOF
	SUhv/55u5YmhvO+74uVAzOdQeNz1ilIhzKrbsfCB7w==
X-Google-Smtp-Source: AGHT+IH3iPW/F4s0jNFITgCxHRYm+qgBwrME2EwsZMDMePhXqaRzLWflPOUeY3EWWifOn3S3GltGzQ==
X-Received: by 2002:a17:907:1b04:b0:9bf:792:d696 with SMTP id mp4-20020a1709071b0400b009bf0792d696mr4029562ejc.46.1697625774317;
        Wed, 18 Oct 2023 03:42:54 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1ae])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906075700b009b947f81c4asm1410048ejb.155.2023.10.18.03.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:42:53 -0700 (PDT)
References: <20231016190819.81307-1-john.fastabend@gmail.com>
 <20231016190819.81307-2-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangyingliang@huawei.com,
 martin.lau@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: sockmap, af_unix sockets need to hold ref
 for pair sock
Date: Wed, 18 Oct 2023 12:40:42 +0200
In-reply-to: <20231016190819.81307-2-john.fastabend@gmail.com>
Message-ID: <87fs289poz.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 12:08 PM -07, John Fastabend wrote:
> AF_UNIX sockets are a paired socket. So sending on one of the pairs
> will lookup the paired socket as part of the send operation. It is
> possible however to put just one of the pairs in a BPF map. This
> currently increments the refcnt on the sock in the sockmap to
> ensure it is not free'd by the stack before sockmap cleans up its
> state and stops any skbs being sent/recv'd to that socket.
>
> But we missed a case. If the peer socket is closed it will be
> free'd by the stack. However, the paired socket can still be
> referenced from BPF sockmap side because we hold a reference
> there. Then if we are sending traffic through BPF sockmap to
> that socket it will try to dereference the free'd pair in its
> send logic creating a use after free.  And following splat,
>
>    [59.900375] BUG: KASAN: slab-use-after-free in sk_wake_async+0x31/0x1b0
>    [59.901211] Read of size 8 at addr ffff88811acbf060 by task kworker/1:2/954
>    [...]
>    [59.905468] Call Trace:
>    [59.905787]  <TASK>
>    [59.906066]  dump_stack_lvl+0x130/0x1d0
>    [59.908877]  print_report+0x16f/0x740
>    [59.910629]  kasan_report+0x118/0x160
>    [59.912576]  sk_wake_async+0x31/0x1b0
>    [59.913554]  sock_def_readable+0x156/0x2a0
>    [59.914060]  unix_stream_sendmsg+0x3f9/0x12a0
>    [59.916398]  sock_sendmsg+0x20e/0x250
>    [59.916854]  skb_send_sock+0x236/0xac0
>    [59.920527]  sk_psock_backlog+0x287/0xaa0

Isn't the problem here that unix_stream_sendmsg doesn't grab a ref to
peer sock? Unlike unix_dgram_sendmsg which uses the unix_peer_get
helper.

>
> To fix let BPF sockmap hold a refcnt on both the socket in the
> sockmap and its paired socket.  It wasn't obvious how to contain
> the fix to bpf_unix logic. The primarily problem with keeping this
> logic in bpf_unix was: In the sock close() we could handle the
> deref by having a close handler. But, when we are destroying the
> psock through a map delete operation we wouldn't have gotten any
> signal thorugh the proto struct other than it being replaced.
> If we do the deref from the proto replace its too early because
> we need to deref the skpair after the backlog worker has been
> stopped.
>
> Given all this it seems best to just cache it at the end of the
> psock and eat 8B for the af_unix and vsock users.
>
> Fixes: 94531cfcbe79 ("af_unix: Add unix_stream_proto for sockmap")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

[...]

