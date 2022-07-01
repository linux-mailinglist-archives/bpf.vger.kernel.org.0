Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB31563358
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 14:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiGAMPp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 08:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiGAMPo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 08:15:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 432DE2AE06
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656677742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kXVJiRtFfJn6rh84gZrCOWxnfgdtYxOFdD9FLOoWGEw=;
        b=Lp/324NoUC+naJgzygR0tNX0oQFEHedYeWZNj3Ico0Ngnbdzs/dcSGz+0v67TlHNoaRgs4
        epA7Arb6TBSRMsKv/N7ycYwz/crr2v6HWmmuQLENFXc8ZGRwBBOP1Pd1QbAbMgLt/CRcda
        Sox6vcUzA4mImdW03ask2BguvfSA6/k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-v99B726tMUyduQL_Al-cIw-1; Fri, 01 Jul 2022 08:15:41 -0400
X-MC-Unique: v99B726tMUyduQL_Al-cIw-1
Received: by mail-ej1-f69.google.com with SMTP id sa13-20020a1709076d0d00b0072a8791298aso705746ejc.7
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 05:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kXVJiRtFfJn6rh84gZrCOWxnfgdtYxOFdD9FLOoWGEw=;
        b=EaFqmSRfCg9OezU1xS7jDycvBoX+dzu7BQ80IlpH8AJ4uIQOVtdW4IrdRj+hSu5ksO
         YowB2YsVcqM9k/n7OftISNqvTpOslr6Mt7umTP8xP8qpcCnWDAKs1hO2Zx4uV7LxJm+X
         pjEihRX1rCtS4cAXuycBZYTNj6u3sfTikPEu4EXmP62Y0hHHMBI3sHwZclJ2MIS8myHS
         5cGz0MDLc1Wpnbq4nXsVbbZuYkeQOeswNaFtlEP2vCTMFfzPggdX3HYf9D2DWTGUynIH
         KGLSMgzxnkn8WJ4Ot0AyJqUeW3KmMK8OyyBNy7+na3Rb7GF56uYkvtrVCXfP89nW0p6r
         yzlQ==
X-Gm-Message-State: AJIora9Yghs0u0RW9x5+K4KRAXqZeM68LmeZoTrpuJ1i/+QmZsxwsIVJ
        qxFkoLD+5/wnLXzzMmh/bBHP0Pxz3nq1p1Ey+2FnSlkQGIQADMPnLTPMiafqDbSqorolqV9kkly
        2TYG2w4S06sTo
X-Received: by 2002:a17:907:72d5:b0:722:def3:9160 with SMTP id du21-20020a17090772d500b00722def39160mr14329352ejc.164.1656677739620;
        Fri, 01 Jul 2022 05:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t1xn2nDy0YXkC88rGzuj1nPm04QabZVmJUkVsww5nrBeY1p+QzyqU4ddheR83zbCFd7l5C6g==
X-Received: by 2002:a17:907:72d5:b0:722:def3:9160 with SMTP id du21-20020a17090772d500b00722def39160mr14329317ejc.164.1656677739301;
        Fri, 01 Jul 2022 05:15:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006f3ef214dc7sm10301583ejb.45.2022.07.01.05.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:15:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D8DB547749E; Fri,  1 Jul 2022 14:15:37 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?utf-8?B?QmrDtnJuIFQ=?= =?utf-8?B?w7ZwZWw=?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        bpf <bpf@vger.kernel.org>, Xdp <xdp-newbies@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests, bpf: remove AF_XDP samples
In-Reply-To: <CAJ8uoz2KmpVf7nkJXUsHhmOtS2Td+rMOX8-PRqzz9QxJB-tZ3g@mail.gmail.com>
References: <20220630093717.8664-1-magnus.karlsson@gmail.com>
 <fa929729-6122-195f-aa4b-e5d3fedb1887@redhat.com>
 <CAJ8uoz2KmpVf7nkJXUsHhmOtS2Td+rMOX8-PRqzz9QxJB-tZ3g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 01 Jul 2022 14:15:37 +0200
Message-ID: <87v8sh81w6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Thu, Jun 30, 2022 at 3:44 PM Jesper Dangaard Brouer
> <jbrouer@redhat.com> wrote:
>>
>>
>> On 30/06/2022 11.37, Magnus Karlsson wrote:
>> > From: Magnus Karlsson <magnus.karlsson@intel.com>
>> >
>> > Remove the AF_XDP samples from samples/bpf as they are dependent on
>> > the AF_XDP support in libbpf. This support has now been removed in the
>> > 1.0 release, so these samples cannot be compiled anymore. Please start
>> > to use libxdp instead. It is backwards compatible with the AF_XDP
>> > support that was offered in libbpf. New samples can be found in the
>> > various xdp-project repositories connected to libxdp and by googling.
>> >
>> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
>>
>> Will you (or Maciej) be submitting these samples to XDP-tools[1] which
>> is the current home for libxdp or maybe BPF-examples[2] ?
>>
>>   [1] https://github.com/xdp-project/xdp-tools
>>   [2] https://github.com/xdp-project/bpf-examples
>>
>> I know Toke is ready to take over maintaining these, but we will
>> appreciate someone to open a PR with this code...
>>
>> > ---
>> >   MAINTAINERS                     |    2 -
>> >   samples/bpf/Makefile            |    9 -
>> >   samples/bpf/xdpsock.h           |   19 -
>> >   samples/bpf/xdpsock_ctrl_proc.c |  190 ---
>> >   samples/bpf/xdpsock_kern.c      |   24 -
>> >   samples/bpf/xdpsock_user.c      | 2019 -------------------------------
>> >   samples/bpf/xsk_fwd.c           | 1085 -----------------
>>
>> The code in samples/bpf/xsk_fwd.c is interesting, because it contains a
>> buffer memory manager, something I've seen people struggle with getting
>> right and performant (at the same time).
>
> I can push xsk_fwd to BPF-examples. Though I do think that xdpsock has
> become way too big to serve as a sample. It slowly turned into a catch
> all demonstrating every single feature of AF_XDP. We need a minimal
> example and then likely other samples for other features that should
> be demoed. So I suggest that xdpsock dies here and we start over with
> something minimal and use xsk_fwd for the forwarding and mempool
> example.
>
> Toke, I think you told me at Recipes in Paris that someone from RedHat
> was working on an example. Did I remember correctly?

I think I was probably referring to
https://github.com/xdp-project/xdp-tools/pull/158 ? Which has sadly
stalled :(

-Toke

