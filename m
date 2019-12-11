Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A264011ABD6
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 14:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfLKNRX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Dec 2019 08:17:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729131AbfLKNRX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Dec 2019 08:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576070241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=euN1BL4YywoP7RbUg1LVqDst2OmJiHQIB5+Y09DMWek=;
        b=dZLpqdopOsO1tHI+fTEXJdLREgsc94HkU/5avqWACwVqaXHjNE9h/WDmPYh+HRoGNunOQR
        Kdx6Ib6uJJHJAI817c1K735llD6KYQwqDmdcleJuIIoiHlxvA1P+fXHRvJqZa92ipSA2So
        que3Uhqg5CjWH+u4Skxr5vEB0UOCjVw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-V1fBYxL3NoeS5zxO8uWRbA-1; Wed, 11 Dec 2019 08:17:20 -0500
Received: by mail-lf1-f70.google.com with SMTP id d7so3753640lfk.9
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2019 05:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WA9dD6PXu0G7afNTJEKi8tc4wSzduavlA73aFj9hvJg=;
        b=b8m4meW70yzD7ZUOwg4oI8n8tCKWPPcAk9X13DGaweECdepw+KW8yzzT3wJe81ancI
         Cy7+UDpJvjl13thZF9VoqSIMnCRXQfcL2BmROz2W+XAmNfeNexGd9dlreJr+kzl+ux4W
         xh/hupbiD8jGCzqkJlYnUowuQBaVDvDYRZ7hL5OijgBqX6N4Nl0N09JNLkCRZlVEi1rQ
         RuazAZSbLIzHjvTBlwdn49FcCrxoP7OKGq3l2djFLNHYu6xFY/XrzvihXdstbco3jI8a
         O+S5b8IUok1llOloj8gPJdaV2EncXGzz+qqZ3/HfSHwGu875CrkH+a2Igy82SalUMoBC
         bhPQ==
X-Gm-Message-State: APjAAAUnLKlKaH9FDJpJXJ74JsI5Q5hcfdKZaD2fMn3rivr1k873Vq9Z
        jnBYMDS230sh/47c5E0E4lwqvm30qFUmsfUZU6AT37+/rj1tbismN92h/exuFDVospgl/86XW22
        9+yHxiC/L+Xbm
X-Received: by 2002:a19:6a06:: with SMTP id u6mr2208224lfu.187.1576070239194;
        Wed, 11 Dec 2019 05:17:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCWgPBIbmMy5trTf3w8CUkWk2zOkeDBJfB57rNVw5wVMlb19yY3qW7y54+PwtcC6QAtTxEHA==
X-Received: by 2002:a19:6a06:: with SMTP id u6mr2208200lfu.187.1576070238958;
        Wed, 11 Dec 2019 05:17:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x12sm1154992ljd.92.2019.12.11.05.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 05:17:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1EB6718033F; Wed, 11 Dec 2019 14:17:17 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Karlsson\, Magnus" <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Edward Cree <ecree@solarflare.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rg?= =?utf-8?Q?ensen?= 
        <thoiland@redhat.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] Introduce the BPF dispatcher
In-Reply-To: <CAJ+HfNiH4KUO-MXm3L8pka3dECC1S6rHUJ9NoMfyrhPD+9s9nw@mail.gmail.com>
References: <20191209135522.16576-1-bjorn.topel@gmail.com> <87h829ilwr.fsf@toke.dk> <CAJ+HfNjZnxrgYtTzbqj2VOP+5A81UW-7OKoReT0dMVBT0fQ1pg@mail.gmail.com> <CAJ+HfNiH4KUO-MXm3L8pka3dECC1S6rHUJ9NoMfyrhPD+9s9nw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Dec 2019 14:17:17 +0100
Message-ID: <8736drgfxe.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: V1fBYxL3NoeS5zxO8uWRbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> On Mon, 9 Dec 2019 at 18:42, Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com=
> wrote:
>>
> [...]
>> > You mentioned in the earlier version that this would impact the time i=
t
>> > takes to attach an XDP program. Got any numbers for this?
>> >
>>
>> Ah, no, I forgot to measure that. I'll get back with that. So, when a
>> new program is entered or removed from dispatcher, it needs to be
>> re-jited, but more importantly -- a text poke is needed. I don't know
>> if this is a concern or not, but let's measure it.
>>
>
> Toke, I tried to measure the impact, but didn't really get anything
> useful out. :-(
>
> My concern was mainly that text-poking is a point of contention, and
> it messes with the icache. As for contention, we're already
> synchronized around the rtnl-lock. As for the icache-flush effects...
> well... I'm open to suggestions how to measure the impact in a useful
> way.

Hmm, how about:

Test 1:

- Run a test with a simple drop program (like you have been) on a
  physical interface (A), sampling the PPS with interval I.
- Load a new XDP program on interface B (which could just be a veth I
  guess?)
- Record the PPS delta in the sampling interval on which the program was
  loaded on interval B.

You could also record for how many intervals the throughput drops, but I
would guess you'd need a fairly short sampling interval to see anything
for this.

Test 2:

- Run an XDP_TX program that just reflects the packets.
- Have the traffic generator measure per-packet latency (from it's
  transmitted until the same packet comes back).
- As above, load a program on a different interface and look for a blip
  in the recorded latency.


Both of these tests could also be done with the program being replaced
being the one that processes packets on the physical interface (instead
of on another interface). That way you could also see if there's any
difference for that before/after patch...

-Toke

