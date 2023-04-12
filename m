Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E216E021F
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 00:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDLWuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDLWuH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 18:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3966A4D
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 15:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681339759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wfPThJ6uD5L19aBEF9JBG7PLb1538J2zAREBtpus8g=;
        b=Z08gyQZ4zhKKUaazBLhTSd2k5ffgB+3Ih9u2By8aJmrpDTWU3ePwvu3KTvvJAUqil4KKLc
        oYw2VqMt5UbkYThk+2sCAcP6Ws5zUCHNdVgqfMR1hU57O5Stoffvw34RbgPShkvPWjvafa
        Ux3hQRaA5XCmuN3pvhBcyfrL0FjI40w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-sYRIjKkdOpqgtLutzDTU7Q-1; Wed, 12 Apr 2023 18:49:18 -0400
X-MC-Unique: sYRIjKkdOpqgtLutzDTU7Q-1
Received: by mail-ed1-f69.google.com with SMTP id i19-20020a508713000000b004bc2358ac04so7360434edb.21
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 15:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681339757;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wfPThJ6uD5L19aBEF9JBG7PLb1538J2zAREBtpus8g=;
        b=HhO8jE0pqAFsYrxiPAjYiT1hnG5mInxiZ/HPZJnvGnjBEezRugbfhUEMePH9IO4nwR
         lEcAlnHDTUEEQPDdWQzwOASN4VvAu/F3oC5m2K6BsENITDEV04/Vm5727HBHVi/ezag2
         emSnzmVXhnxy8NVxDm0Qvd7/uJ8iAJDV/FvhlWQTTzUn4XKfFdFGKzqH4RZ76MC/+DBO
         YLJz968YIDwNRKL7/Fkxivri1yrKHXFAHz4A+on9p6HYHTz7njgJoOtL7KvQElEZ1JXa
         iROevoxIZkMO0B/gHeyj2CNx2wc5QeGPGUFXEtO2yzi8wiFLJEbc3wmGlq0pfAsubogC
         nwHQ==
X-Gm-Message-State: AAQBX9e9CiBv/Xindz28afOVrx4UtJGr4IGP4s1a6uFlsGjgVGzSBAqB
        5QSCCWV+l/sm65LqtytZQNQy7PLQEXI829oxluunGgZX8i9vt0HxA0aMndG2hIiZvZ0S921IgD9
        48Mp8vo97yST/
X-Received: by 2002:a17:906:e07:b0:93d:e6c8:ed5e with SMTP id l7-20020a1709060e0700b0093de6c8ed5emr4232656eji.20.1681339756777;
        Wed, 12 Apr 2023 15:49:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350YHZC+OPPN1Ok/V44r6BzHazE/PVcSQNdhDZYC0v2k36DLDasA1DxoEYQ2wZPQkSLcb/RSq4A==
X-Received: by 2002:a17:906:e07:b0:93d:e6c8:ed5e with SMTP id l7-20020a1709060e0700b0093de6c8ed5emr4232632eji.20.1681339756397;
        Wed, 12 Apr 2023 15:49:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709064a1200b0094e92b50076sm15810eju.133.2023.04.12.15.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:49:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4631BAA7980; Thu, 13 Apr 2023 00:49:15 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     Kal Cutter Conley <kal.conley@dectris.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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
In-Reply-To: <CAJ8uoz0arggpZdf9KPe5+pJbq_nVJUmvVryPHuwAsqswGs1LZw@mail.gmail.com>
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com> <87sfdckgaa.fsf@toke.dk>
 <ZDBEng1KEEG5lOA6@boxer>
 <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
 <875ya12phx.fsf@toke.dk>
 <CAJ8uoz0arggpZdf9KPe5+pJbq_nVJUmvVryPHuwAsqswGs1LZw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 13 Apr 2023 00:49:15 +0200
Message-ID: <87ttxk1ztg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Wed, 12 Apr 2023 at 15:40, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>>
>> Kal Cutter Conley <kal.conley@dectris.com> writes:
>>
>> >> > > Add core AF_XDP support for chunk sizes larger than PAGE_SIZE. Th=
is
>> >> > > enables sending/receiving jumbo ethernet frames up to the theoret=
ical
>> >> > > maxiumum of 64 KiB. For chunk sizes > PAGE_SIZE, the UMEM is requ=
ired
>> >> > > to consist of HugeTLB VMAs (and be hugepage aligned). Initially, =
only
>> >> > > SKB mode is usable pending future driver work.
>> >> >
>> >> > Hmm, interesting. So how does this interact with XDP multibuf?
>> >>
>> >> To me it currently does not interact with mbuf in any way as it is en=
abled
>> >> only for skb mode which linearizes the skb from what i see.
>> >>
>> >> I'd like to hear more about Kal's use case - Kal do you use AF_XDP in=
 SKB
>> >> mode on your side?
>> >
>> > Our use-case is to receive jumbo Ethernet frames up to 9000 bytes with
>> > AF_XDP in zero-copy mode. This patchset is a step in this direction.
>> > At the very least, it lets you test out the feature in SKB mode
>> > pending future driver support. Currently, XDP multi-buffer does not
>> > support AF_XDP at all. It could support it in theory, but I think it
>> > would need some UAPI design work and a bit of implementation work.
>> >
>> > Also, I think that the approach taken in this patchset has some
>> > advantages over XDP multi-buffer:
>> >     (1) It should be possible to achieve higher performance
>> >         (a) because the packet data is kept together
>> >         (b) because you need to acquire and validate less descriptors
>> > and touch the queue pointers less often.
>> >     (2) It is a nicer user-space API.
>> >         (a) Since the packet data is all available in one linear
>> > buffer. This may even be a requirement to avoid an extra copy if the
>> > data must be handed off contiguously to other code.
>> >
>> > The disadvantage of this patchset is requiring the user to allocate
>> > HugeTLB pages which is an extra complication.
>> >
>> > I am not sure if this patchset would need to interact with XDP
>> > multi-buffer at all directly. Does anyone have anything to add here?
>>
>> Well, I'm mostly concerned with having two different operation and
>> configuration modes for the same thing. We'll probably need to support
>> multibuf for AF_XDP anyway for the non-ZC path, which means we'll need
>> to create a UAPI for that in any case. And having two APIs is just going
>> to be more complexity to handle at both the documentation and
>> maintenance level.
>
> One does not replace the other. We need them both, unfortunately.
> Multi-buff is great for e.g., stitching together different headers
> with the same data. Point to different buffers for the header in each
> packet but the same piece of data in all of them. This will never be
> solved with Kal's approach. We just need multi-buffer support for
> this. BTW, we are close to posting multi-buff support for AF_XDP. Just
> hang in there a little while longer while the last glitches are fixed.
> We have to stage it in two patch sets as it will be too long
> otherwise. First one will only contain improvements to the xsk
> selftests framework so that multi-buffer tests can be supported. The
> second one will be the core code and the actual multi-buffer tests.

Alright, sounds good!

> As for what Kal's patches are good for, please see below.
>
>> It *might* be worth it to do this if the performance benefit is really
>> compelling, but, well, you'd need to implement both and compare directly
>> to know that for sure :)
>
> The performance benefit is compelling. As I wrote in a mail to a post
> by Kal, there are users out there that state that this feature (for
> zero-copy mode nota bene) is a must for them to be able to use AF_XDP
> instead of DPDK style user-mode drivers. They have really tough
> latency requirements.

Hmm, okay, looking forward to seeing the benchmark results, then! :)

-Toke

