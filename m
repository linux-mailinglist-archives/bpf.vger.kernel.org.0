Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0337041B109
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbhI1Np1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 09:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240882AbhI1Np1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 09:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632836627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIaHtjJUQ0OWUUOcuWIbXHHTBHws9CxcXwIFGltQ2EA=;
        b=bU2xQZjZAIZ178jcJQuQafhD0pDjjf7CtYS8isOS0mAka1pLwomddfsekRn3pZGTVa3YrI
        V91AfUb4226INUMQj9IPNuBQeCK5n7bNSqbLtr+xztklYu+yjcT4EKdHut4GUO9hfEYXsz
        1hs0yAK3S8zYzpKeTnAjCVDwb/sr7GQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-LgU6Ta_EMMynfqdzXJXoLA-1; Tue, 28 Sep 2021 09:43:46 -0400
X-MC-Unique: LgU6Ta_EMMynfqdzXJXoLA-1
Received: by mail-ed1-f72.google.com with SMTP id z62-20020a509e44000000b003da839b9821so3517817ede.15
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 06:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=nIaHtjJUQ0OWUUOcuWIbXHHTBHws9CxcXwIFGltQ2EA=;
        b=jeZzvGwjqWSPa2KLnGrr3+HlxPOq/FuP21+wnnwoliKb61wINyHsVDYEcSPG0MWqS7
         go0o02jGBen+4n0qGUEDmk1kobIG+Jv1Z8rEkkzENY/ZXsEM3tgcMWM0DElmdwt3MEun
         dYdDYjxXTIZ3Go6KGbtQMEZjffadegczA2HwRcwzQoEdijMXqOEHWic0cAHFt3M3Ex5y
         C3Xprs1ImimUwCTUCwfjfdtrngpv5MWkZVogg9oh4s1tucxqXsT5hbGtk6bDoqVAsNvz
         jKqum9QAOVZJ6Q9dkn/MpgqnWRRh5YsVp7V1a7q6zK9/NOCWc3MQgRpb9sH/u/BjI+2e
         b7CA==
X-Gm-Message-State: AOAM532A3J8aMwKxyUyagWYZzXXh4E4x4G+36zAxuvnXL96u3UjBzhjQ
        6DIC9JZdS3Gg/vFAeafWQhscXxMRzZ2JKKVvGHMro5AZurt4d5Nd1qv2lHfHyey9dBelCUA0uOi
        5mO3hJJ1KUPUh
X-Received: by 2002:a05:6402:28ad:: with SMTP id eg45mr6809885edb.118.1632836622965;
        Tue, 28 Sep 2021 06:43:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymlbZv9ntmOZROxkwQpKtQqwOk95Kb8JST52wJL+u0DK8S6ytu4Vjnt+9FJ/8f0JSEj2ruWA==
X-Received: by 2002:a05:6402:28ad:: with SMTP id eg45mr6809613edb.118.1632836620336;
        Tue, 28 Sep 2021 06:43:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z24sm6494922edr.56.2021.09.28.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:43:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9076218034A; Tue, 28 Sep 2021 15:43:38 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Lorenzo Bianconi <lbianconi@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: Redux: Backwards compatibility for XDP multi-buff
In-Reply-To: <CACAyw9_grv4_c4gDntK7jT3hfBM+O0qSJZ7xFpaknd58e1PeQQ@mail.gmail.com>
References: <87o88l3oc4.fsf@toke.dk>
 <CACAyw99+KvsJGeqNE09VWHrZk9wKbQTg3h1h2LRmJADD5En2nQ@mail.gmail.com>
 <87tuibzbv2.fsf@toke.dk>
 <CACAyw9_N2Jh651hXL=P=cFM7O-n7Z0NXWy_D9j0ztVpEm+OgNA@mail.gmail.com>
 <87tui9ydb6.fsf@toke.dk>
 <CACAyw9_grv4_c4gDntK7jT3hfBM+O0qSJZ7xFpaknd58e1PeQQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 28 Sep 2021 15:43:38 +0200
Message-ID: <877df0ke7p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenz Bauer <lmb@cloudflare.com> writes:

> On Fri, 24 Sept 2021 at 20:38, Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>> >
>> > Porting is only easy if we are guaranteed that the first PAGE_SIZE
>> > bytes (or whatever the current limit is) are available via ->data
>> > without trickery. Otherwise we have to convert all direct packet
>> > access to the new API, whatever that ends up being. It seemed to me
>> > like you were saying there is no such guarantee, and it could be
>> > driver dependent, which is the worst possible outcome imo. This is the
>> > status quo for TC classifiers, which is a great source of hard to
>> > diagnose bugs.
>>
>> Well, for the changes we're proposing now it will certainly be the case
>> that the first PAGE_SIZE will always be present. But once we have the
>> capability, I would expect people would want to do more with it, so we
>> can't really guarantee this in the future. We could require that any
>> other use be opt-in at the driver level, I suppose, but not sure if that
>> would be enough?
>
> I'm not sure what you mean by "opt-in at driver level"? Make smaller
> initial fragments a feature on the driver? We shouldn't let drivers
> dictate the semantics of a program type, it defeats the purpose of the
> context abstraction. We're using XDP precisely because we don't want
> to deal with vendor specific network stack bypass, etc. I would prefer
> not specifying the first fragment size over the driver knob,

I didn't mean that every driver should get to just define their own
semantics; rather the opposite: If we do end up adding support for
anything other than "first page of data is in the first fragment", we
should define separate semantics for this and make it an explicit knob
to turn on such a mode.

> unfortunately it invalidates your assumption that porting is going to
> be trivial.

Well, I did say "for some programs" ;)

But OK, point taken. It would be great if you could chime in on the
helper discussion[0]. I.e., which helper API would make porting simplest
for you?

-Toke

[0] https://lore.kernel.org/r/20210920110216.4c54c9a3@kicinski-fedora-pc1c0=
hjn.dhcp.thefacebook.com

