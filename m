Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3530B5782A4
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 14:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiGRMpP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 08:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiGRMpN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 08:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA62213C
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658148312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzBFvIqCCdilfJimYjUHdD6X5HYCec9zvNjPQKPt+Ck=;
        b=I+sm4Ew+YuQscCGCN0lETo5KSfLGzP1ORbX4onW70TbW8gUTkEnCVCgYusTwv647HRtWhD
        k0a5ES3MBGLFoZdxoDfrNbhLpjBPL2bbeQsmjhfS9l7eXUTVySd/EBTPNcPaMPOI+Z1oUT
        XWJhB4hZ8aeWgox/t53sy3K9XwlGnW0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-aVbfhfwLMByZApZzqNJW2g-1; Mon, 18 Jul 2022 08:45:10 -0400
X-MC-Unique: aVbfhfwLMByZApZzqNJW2g-1
Received: by mail-ej1-f71.google.com with SMTP id ne36-20020a1709077ba400b0072b64ce28aaso2236858ejc.3
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 05:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dzBFvIqCCdilfJimYjUHdD6X5HYCec9zvNjPQKPt+Ck=;
        b=ngxi17oJveZZynuCftGQzgRg6EkK1j8wQ4zix+/pPHKuEiN9HVnb4EtbQ0uAXB35tY
         +QCRGqSZcTs4D2lgKuJbcCARxkmPTZFrZngiJfigJTBpA5e6tQNnJarOuxHlBhSKI4qN
         0iYuUQRIzj1bYFY7rELyKs3tYQVA7OcvZ4NmETAHyxdjY7nKX3KzpZGfl+8zpBoSwqzZ
         stoFmjLfDIvPg02IGMEn768H5RTr7zFGiR31C6Gkt2WNMsTiA5JeDJbogsAx+i6qkTSG
         t+9QjDG0avk5Uw3cfHXrcM3Or5X+bfeqTZpWOX479fu31UJH9C1nEZVnqsSpVhGpcN+1
         9b2g==
X-Gm-Message-State: AJIora9H2bIjcr2F7G09trxvvmV0Uyaabbcf+bnlrSqp+H6GkddTC0Sb
        f3YEuXwqx8eiGY+8YKJ+wCMPtXSpVByXojpZb3MQ223lWGLcL1Zja2tOy49prsO0BEpage+RAV2
        IQX8DRXjSDMQQ
X-Received: by 2002:a05:6402:695:b0:435:65f3:38c2 with SMTP id f21-20020a056402069500b0043565f338c2mr37175603edy.347.1658148309027;
        Mon, 18 Jul 2022 05:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vndpJsAbHLc+ne2xOLUf44WFkBRVsviotgyLXLV/B73jiz64uCphx22pPyV9ygFzRLrdAa0A==
X-Received: by 2002:a05:6402:695:b0:435:65f3:38c2 with SMTP id f21-20020a056402069500b0043565f338c2mr37175521edy.347.1658148308222;
        Mon, 18 Jul 2022 05:45:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906314e00b00711d546f8a8sm5356221eje.139.2022.07.18.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 05:45:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 473384D9EFF; Mon, 18 Jul 2022 14:45:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Freysteinn Alfredsson <freysteinn.alfredsson@kau.se>
Subject: Re: [RFC PATCH 00/17] xdp: Add packet queueing and scheduling
 capabilities
In-Reply-To: <YtRLC5ILXZOre8D7@pop-os.localdomain>
References: <20220713111430.134810-1-toke@redhat.com>
 <YtRLC5ILXZOre8D7@pop-os.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 18 Jul 2022 14:45:05 +0200
Message-ID: <87sfmylhda.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cong Wang <xiyou.wangcong@gmail.com> writes:

> On Wed, Jul 13, 2022 at 01:14:08PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Packet forwarding is an important use case for XDP, which offers
>> significant performance improvements compared to forwarding using the
>> regular networking stack. However, XDP currently offers no mechanism to
>> delay, queue or schedule packets, which limits the practical uses for
>> XDP-based forwarding to those where the capacity of input and output lin=
ks
>> always match each other (i.e., no rate transitions or many-to-one
>> forwarding). It also prevents an XDP-based router from doing any kind of
>> traffic shaping or reordering to enforce policy.
>>=20
>
> Sorry for forgetting to respond to your email to my patchset.
>
> The most important question from you is actually why I give up on PIFO.
> Actually its limitation is already in its name, its name Push In First
> Out already says clearly that it only allows to dequeue the first one.
> Still confusing?
>
> You can take a look at your pifo_map_pop_elem(), which is the
> implementation for bpf_map_pop_elem(), which is:
>
>        long bpf_map_pop_elem(struct bpf_map *map, void *value)
>
> Clearly, there is no even 'key' in its parameter list. If you just
> compare it to mine:
>
> 	BPF_CALL_2(bpf_skb_map_pop, struct bpf_map *, map, u64, key)
>
> Is their difference now 100% clear? :)
>
> The next question is why this is important (actually it is the most
> important)? Because we (I mean for eBPF Qdisc users, not sure about you)
> want the programmability, which I have been emphasizing since V1...

Right, I realise that in a strictly abstract sense, only being able to
dequeue at the head is a limitation. However, what I'm missing is what
concrete thing that limitation prevents you from implementing (see my
reply to your other email about LSTF)? I'm really not trying to be
disingenuous, I have no interest in ending up with a map primitive that
turns out to be limiting down the road...

> BTW, what is _your_ use case for skb map and user-space PIFO map? I am
> sure you have uses case for XDP, it is unclear what you have for other
> cases. Please don't piggy back use cases you don't have, we all have
> to justify all use cases. :)

You keep talking about the SKB and XDP paths as though they're
completely separate things. They're not: we're adding a general
capability to the kernel to implement programmable packet queueing using
BPF. One is for packets forwarded from the XDP hook, the other is for
packets coming from the stack. In an ideal world we'd only need one hook
that could handle both paths, but as the discussion I linked to in my
cover letter shows that is probably not going to be feasible.

So we'll most likely end up with two hooks, but as far as use cases are
concerned they are the same: I want to make sure that the primitives we
add are expressive enough to implement every conceivable queueing and
scheduling algorithm. I don't view the two efforts to be in competition
with each other either; we're really trying to achieve the same thing
here, so let's work together to make sure we end up with something that
works for both the XDP and qdisc layers? :)

The reason I mention the SKB path in particular in this series is that I
want to make sure we make the two as compatible as we can, so as not to
unnecessarily fragment the ecosystem. Sharing primitives is the obvious
way to do that.

-Toke

