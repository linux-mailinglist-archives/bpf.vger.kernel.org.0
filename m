Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BF06EA7A2
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 11:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjDUJzz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 05:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDUJzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 05:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E569EC9
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682070898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PU5EzJ54+PKjP4fyHsqL6OGsZoIpT5Q384KSWXkirPU=;
        b=Ksj1zWBvF6Ifswco+6/7neiGTxphJhX1jzIbuZ9B7eP2vvZchoA1HvYLseI56cxxkIX8cR
        suucog8orXa6AXOdTUiJ5hM/+/kG9Ol8GNfxwFYTZKqgwHwKFDrDlWLMh7kZWChJEj2RFZ
        4qR91ZndtwNtX+XjiO08HajM42M5IRs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-kzwTB5fiN-GvnRtvYkzRQw-1; Fri, 21 Apr 2023 05:54:55 -0400
X-MC-Unique: kzwTB5fiN-GvnRtvYkzRQw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50470d68f1eso1394948a12.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 02:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070895; x=1684662895;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PU5EzJ54+PKjP4fyHsqL6OGsZoIpT5Q384KSWXkirPU=;
        b=dqxpSQkAtwKD07U0kQZM4Wzs9696Bm9PNOWHn3f6YPQUgPoz+rLD+IAAqJfy7hj7bS
         WGWRUIpmr3dCm1vUKQNrAIn3pxHU+M5lTiDK4hLcQq7WZYzbd1zVpn9W5Hct9dHdtweN
         34fVj54FfRPLuBJymT/IX0ue4wkblhi5UQaWy9jYWEtpdsVokYqy6HuFzvOiMXZ/9fyW
         cbQRmlMRTym4YNSbgzfpk+0Q7ymaciLB0FlL/cNKgOdu5rqOvd+2cngGv+VADReWqdah
         cems8TxVvYV5yr5cD+ErrQIp0hRarB90oOHEtJPTYdQrFTkKfUjMcvxvlMgvAXvWyDLh
         BjJw==
X-Gm-Message-State: AAQBX9fa1XKnacDi9179JlW7TA8aLLqtLZpDrLobxmr5mAD4N82T3Xt4
        H67TERI6PJqU4UCXF9WIcdw7+XSBx6hIxWcAb+kpVyVa8+5k+giV15l+TEv1MpmvPyKP5AB9WoY
        YKFLwSgQZJySn
X-Received: by 2002:a17:906:70cb:b0:947:df9e:4082 with SMTP id g11-20020a17090670cb00b00947df9e4082mr1592743ejk.35.1682070894657;
        Fri, 21 Apr 2023 02:54:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350YcSK1ugfdii2y4sj9PtoHsSwjf3tWw/0Cyxo4TxC3m/vg1fQhtemTqWj26RF9Sy4plUsX0qw==
X-Received: by 2002:a17:906:70cb:b0:947:df9e:4082 with SMTP id g11-20020a17090670cb00b00947df9e4082mr1592719ejk.35.1682070894153;
        Fri, 21 Apr 2023 02:54:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709066d4d00b0094a9b9c4979sm1843430ejt.88.2023.04.21.02.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:54:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8DC8DAA903F; Fri, 21 Apr 2023 11:54:52 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Kal Cutter Conley <kal.conley@dectris.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
In-Reply-To: <ZEJZYa8WT6A9VpOJ@boxer>
References: <20230406130205.49996-2-kal.conley@dectris.com>
 <87sfdckgaa.fsf@toke.dk> <ZDBEng1KEEG5lOA6@boxer>
 <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
 <875ya12phx.fsf@toke.dk>
 <CAHApi-=rMHt7uR8Sw1Vw+MHDrtkyt=jSvTvwz8XKV7SEb01CmQ@mail.gmail.com>
 <87ile011kz.fsf@toke.dk>
 <CAHApi-=ODe-WtJ=m6bycQhKoQxb+kk2Yk9Fx5SgBsWUuWT_u-A@mail.gmail.com>
 <874jpdwl45.fsf@toke.dk>
 <CAHApi-kcaMRPj4mEPs87_4Z6iO5qEpzOOcbVza7vxURqCtpz=Q@mail.gmail.com>
 <ZEJZYa8WT6A9VpOJ@boxer>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 21 Apr 2023 11:54:52 +0200
Message-ID: <87r0sdsgpf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Tue, Apr 18, 2023 at 01:12:00PM +0200, Kal Cutter Conley wrote:
>
> Hi there,
>
>> > >> In addition, presumably when using this mode, the other XDP actions
>> > >> (XDP_PASS, XDP_REDIRECT to other targets) would stop working unless we
>> > >> add special handling for that in the kernel? We'll definitely need to
>> > >> handle that somehow...
>> > >
>> > > I am not familiar with all the details here. Do you know a reason why
>> > > these cases would stop working / why special handling would be needed?
>> > > For example, if I have a UMEM that uses hugepages and XDP_PASS is
>> > > returned, then the data is just copied into an SKB right? SKBs can
>> > > also be created directly from hugepages AFAIK. So I don't understand
>> > > what the issue would be. Can someone explain this concern?
>> >
>> > Well, I was asking :) It may well be that the SKB path just works; did
>> > you test this? Pretty sure XDP_REDIRECT to another device won't, though?
>
> for XDP_PASS we have to allocate a new buffer and copy the contents from
> current xdp_buff that was backed by xsk_buff_pool and give the current one
> back to pool. I am not sure if __napi_alloc_skb() is always capable of
> handling len > PAGE_SIZE - i believe there might a particular combination
> of settings that allows it, but if not we should have a fallback path that
> would iterate over data and copy this to a certain (linear + frags) parts.
> This implies non-zero effort that is needed for jumbo frames ZC support.
>
> I can certainly test this out and play with it - maybe this just works, I
> didn't check yet. Even if it does, then we need some kind of temporary
> mechanism that will forbid loading ZC jumbo frames due to what Toke
> brought up.

Yeah, this was exactly the kind of thing I was worried about (same for
XDP_REDIRECT). Thanks for fleshing it out a bit :)

>> >
>> 
>> I was also asking :-)
>> 
>> I tested that the SKB path is usable today with this patch.
>> Specifically, sending and receiving large jumbo packets with AF_XDP
>> and that a non-multi-buffer XDP program could access the whole packet.
>> I have not specifically tested XDP_REDIRECT to another device or
>> anything with ZC since that is not possible without driver support.
>> 
>> My feeling is, there wouldn't be non-trivial issues here since this
>> patchset changes nothing except allowing the maximum chunk size to be
>> larger. The driver either supports larger MTUs with XDP enabled or it
>> doesn't. If it doesn't, the frames are dropped anyway. Also, chunk
>> size mismatches between two XSKs (e.g. with XDP_REDIRECT) would be
>> something supported or not supported irrespective of this patchset.
>
> Here is the comparison between multi-buffer and jumbo frames that I did
> for ZC ice driver. Configured MTU was 8192 as this is the frame size for
> aligned mode when working with huge pages. I am presenting plain numbers
> over here from xdpsock.
>
> Mbuf, packet size = 8192 - XDP_PACKET_HEADROOM
> 885,705pps - rxdrop frame_size=4096
> 806,307pps - l2fwd frame_size=4096
> 877,989pps - rxdrop frame_size=2048
> 773,331pps - l2fwd frame_size=2048
>
> Jumbo, packet size = 8192 - XDP_PACKET_HEADROOM
> 893,530pps - rxdrop frame_size=8192
> 841,860pps - l2fwd frame_size=8192
>
> Kal might say that multi-buffer numbers are imaginary as these patches
> were never shown to the public ;) but now that we have extensive test
> suite I am fixing some last issues that stand out, so we are asking for
> some more patience over here... overall i was expecting that they will be
> much worse when compared to jumbo frames, but then again i believe this
> implementation is not ideal and can be improved. Nevertheless, jumbo
> frames support has its value.

Thank you for doing these! Okay, so that's between 1-4% improvement (vs
the 4k frags). I dunno, I wouldn't consider that a slam dunk; would
depend on the additional complexity if it is worth it to do both, IMO...

-Toke

