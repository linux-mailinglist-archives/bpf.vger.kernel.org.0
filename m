Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C69538F319
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhEXSkN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 14:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232442AbhEXSkN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 May 2021 14:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621881524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6kfBQcOOypFceqH2usmIITmz3BJPUgfGQcjFZT1RnX0=;
        b=FKTCfnCAPvUElIzSrBNBxi7h+abrMUyBSK44QaJJAGiGxfNh78fRTAnnTLp0ij1+5KXo8P
        jArsT71NpY0KYj9a1giLCPBJqcik6JMC3OV36lWLBbAgXgsrbEMgSxUk36KLeG/vQafA39
        Fh5L4j4QrxN5wSva5ZQg7Ahb8t7TKWc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-Qc-TYHG2OLabUfk1uo7FhQ-1; Mon, 24 May 2021 14:38:42 -0400
X-MC-Unique: Qc-TYHG2OLabUfk1uo7FhQ-1
Received: by mail-ej1-f70.google.com with SMTP id eb10-20020a170907280ab02903d65bd14481so7611922ejc.21
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 11:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6kfBQcOOypFceqH2usmIITmz3BJPUgfGQcjFZT1RnX0=;
        b=ItQ0jxnLjWIKdd01lDiXVJ/2THjZfpMi/akn5nvteX6WAam8YDATONEScq1oNgYL9W
         n91afoh7pcZRsKjF5UvyrUkXKYKG9/RiqGuNAbVdgHEr3Y/refyMa+k6Ktt8jikM+xbD
         LDCIt3cja1PNKjIyZta3ZzbOs8SA72/h/ZXnpwLCC5UvOEE2ZT70HhP59r+JsJL5FuJn
         9abwDbNj5fp66dQVgNNpQS5zwbwhPIYkmo4/uadnPkBuXoPR4pRABXxazAFkJbE330QL
         ukgqsYSKOE8QPUNfWY3dDfOA+kt4GtpiSEds/EaGPv3r6ODkjNbeHTWrJBWfidVZa4nm
         QMzQ==
X-Gm-Message-State: AOAM533fo1QRZ9OfNyYvTnmoYfLm85pBtkJne33ZDHRLyrWMMZYzPI+/
        aJEflrq1fjRz22qeXcmR7fdpgQp3K24CEeX5OTVR7kIEgiMAjlPzgVf7nONLBRe0WmnraRDofej
        eDOEZZhmKOdC0
X-Received: by 2002:a17:906:33d6:: with SMTP id w22mr24199448eja.222.1621881521408;
        Mon, 24 May 2021 11:38:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxs4NXcIQ/KGjvlP/nceh9M43tmZGNTdGambMuToDFEj03VFJY0GCKq8HwE7LKfr56CunAjeg==
X-Received: by 2002:a17:906:33d6:: with SMTP id w22mr24199421eja.222.1621881520872;
        Mon, 24 May 2021 11:38:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i22sm8313352ejz.20.2021.05.24.11.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:38:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 69B41180275; Mon, 24 May 2021 20:38:38 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Introduce bpf_timer
In-Reply-To: <CAADnVQL9xKcdCyR+-8irH07Ws7iKHjrE4XNb4OA7BkpBrkkEuA@mail.gmail.com>
References: <20210520185550.13688-1-alexei.starovoitov@gmail.com>
 <87o8d1zn59.fsf@toke.dk>
 <CAADnVQL9xKcdCyR+-8irH07Ws7iKHjrE4XNb4OA7BkpBrkkEuA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 24 May 2021 20:38:38 +0200
Message-ID: <87fsycyo29.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sun, May 23, 2021 at 4:48 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Still wrapping my head around this, but one thing immediately sprang to
>> mind:
>>
>> > + * long bpf_timer_mod(struct bpf_timer *timer, u64 msecs)
>> > + *   Description
>> > + *           Set the timer expiration N msecs from the current time.
>> > + *   Return
>> > + *           zero
>>
>> Could we make this use nanoseconds (and wire it up to hrtimers) instead?
>> I would like to eventually be able to use this for pacing out network
>> packets, and msec precision is way too coarse for that...
>
> msecs are used to avoid exposing jiffies to bpf prog, since msec_to_jiffi=
es
> isn't trivial to do in the bpf prog unlike the kernel.
> hrtimer would be great to support as well.
> It could be implemented via flags (which are currently zero only)
> but probably not as a full replacement for jiffies based timers.
> Like array vs hash. bpf_timer can support both.

Okay, so this is really:

long bpf_timer_mod(struct bpf_timer *timer, u64 interval)

where 'interval' will be expressed in either milliseconds or nanoseconds
depending on which flags are passed to bpf_timer_init()? That's fine by
me, then; I just wanted to make sure that that 'msecs' was not an
indication that this was the only granularity these timers would
support... :)

-Toke

