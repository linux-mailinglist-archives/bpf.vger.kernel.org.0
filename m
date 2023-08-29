Return-Path: <bpf+bounces-8888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3617E78BFE3
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304F51C20446
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DCD6FBB;
	Tue, 29 Aug 2023 08:08:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D536FAE
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 08:08:14 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EF7DE
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 01:08:11 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4036bd4fff1so217081cf.0
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693296490; x=1693901290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP6mlrN9y/6rTYN1qRkwBxymC+PSvzPXFyt+wAfKj8w=;
        b=aX4Gav6iftUvb8C02Czjd0psp7yQfGOGgM/clNB0RpL5PRSWgzQ8vaMWPsIYO1jjja
         T0SjSy0CmHXSnYIpxwANbNjgqpAVj1w3FXouhaR8OjruLKNnUoNopGPfYQkKO5QDl5W0
         A2xYOfI7Gp1EBQhT6rfcuZGonaPXRH5KRduFQJxIw2RTgVWaAa4+RUX7QNzjIQ/l6AZ/
         KkNPupYMaru1MUatDRA9OXLTHtTOsS7emuyS1tW/e7sv0m+RW/Dk4FClGgc3au+zN+uU
         5YpF3Q0eQsOc30aR5p+az3n554nCfg9rmXuJMQ5144FIUHeBumF6v0b9kt93Kpfldo0h
         C2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296490; x=1693901290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP6mlrN9y/6rTYN1qRkwBxymC+PSvzPXFyt+wAfKj8w=;
        b=IfXQoNXpbW3v95/H9rFKcfEleESmsQoHthPl2eZ1D8TOD4+BCqtMaHoJV5JXRPJC7X
         JgtJA85C2x9avv8pE4S62J2PdZqCWi/Q0/QzU3rxjkq0aG51zZ/kZkd35vVFTZpdZFPX
         OHd4flSw5BSXlqZnlEoiDyt2pPnyLUBNKWvfcAhPgz/exZOyF57GS036qWCnedpbiMBo
         xoP7Vu5oscb5CQh7Oc3beNK7y51YM1mMyEqOEbIFjQMXcLdZB8jTuMuWcdIY1ML/pJ/c
         OwBzozwF80JS8s29oajzFIxFxzdj2UAAI8N4VDR2giWiTjIFxe6aoOBJPdMghm0Ctw2G
         zoRA==
X-Gm-Message-State: AOJu0YxFlDJICJN5a1BwKrEhUccQBLvA5B+6JvC40GrgTLyDpSIqq6WS
	d+63Q/UUdJphXo8EAwYMKjZx3L08cNsvzcZvy3mGCA==
X-Google-Smtp-Source: AGHT+IE0THKdYMtTQgHqn0R9jaTA4fsl3ueWMJa5qIeaY9FE0gez7qFPFqKV2+BW5SyKjnqGCkYb3zCZRkkHwlaklbQ=
X-Received: by 2002:a05:622a:1788:b0:3f8:8c06:c53b with SMTP id
 s8-20020a05622a178800b003f88c06c53bmr213454qtk.0.1693296490403; Tue, 29 Aug
 2023 01:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828233210.36532-1-mkhalfella@purestorage.com>
 <64ed7188a2745_9cf208e1@penguin.notmuch> <20230829065010.GO4091703@medusa>
In-Reply-To: <20230829065010.GO4091703@medusa>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Aug 2023 10:07:59 +0200
Message-ID: <CANn89iLbNF_kGG9S3R9Y8gpoEM71Wesoi1mTA3-at4Furc+0Fg@mail.gmail.com>
Subject: Re: [PATCH] skbuff: skb_segment, Update nfrags after calling zero
 copy functions
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: willemjdebruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Alexander Duyck <alexanderduyck@fb.com>, 
	David Howells <dhowells@redhat.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Kees Cook <keescook@chromium.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 8:50=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On 2023-08-28 21:18:16 -0700, willemjdebruijn wrote:
> > Small point: nfrags is not the only state that needs to be refreshed
> > after a fags realloc, also frag.
>
> I am new to this code. Can you help me understand why frag needs to be
> updated too? My reading of this code is that frag points to frags array
> in shared info. As long as shared info pointer remain the same frag
> pointer should remain valid.
>

skb_copy_ubufs() could actually call skb_unclone() and thus skb->head
could be re-allocated.

I guess that if you run your patch (and a repro of the bug ?) with
KASAN enabled kernel, you should see a possible use-after-free ?

To force the skb_unclone() path, having a tcpdump catching all packets
would be enough I think.

> Am I missing something?
> >
> > Thanks for the report. I'm traveling likely without internet until the
> > weekend. Apologies if it takes a while for me to follow up.
> No problem. Thanks for the quick response!

