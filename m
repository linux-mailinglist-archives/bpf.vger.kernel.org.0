Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648EF35FADE
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 20:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhDNSjc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 14:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232246AbhDNSjc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 14:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618425550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nmXmKqpZIK/Dz2xScNKvLiMtnvQwVNsAcesPWcbTXn4=;
        b=CPyUPSWPmCbE2t6ac9lY0ketSlJUD563Flm+Eck4jWVqXAL08qb9Lks0dKYwDcwEmP14kF
        VlcPJaKqnlcIQdD8DTY8qkHUO58aLZzhmfWKzzsLdkmqKSFIBYetjJcRtayZxSid684GzS
        PlamHj9MftNkf57qZuWOAHx2gaRl1BQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-YyBGC9htNLqY4bAzQIqrhw-1; Wed, 14 Apr 2021 14:39:08 -0400
X-MC-Unique: YyBGC9htNLqY4bAzQIqrhw-1
Received: by mail-ej1-f71.google.com with SMTP id jl27-20020a17090775dbb029037ccdce96e6so103644ejc.21
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 11:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nmXmKqpZIK/Dz2xScNKvLiMtnvQwVNsAcesPWcbTXn4=;
        b=Bfty8EgV5/OMM1/mBx/DTjR1xRJaqT4vXzfEKc3eeSvRiGveOjmL1hxsrmcRkXpxnz
         XG+tPnyfa91Zyc0sEN/SsO24GgpHzjbDZ5OZUsH4A///9X6Tbl5Yn+qBDiC+ACP0WQaP
         /jV0GspjFnUcO3gjYSR3nnEGsyN+iX2mlMJ67mpRefpwnj20Oji56LW2YPnnxtxT9aqv
         VDob1Hq7MCKQmh2/icnXFKF73FCiFaYw1HXbANuD+nrW3AyTzE2U+RoVgr5yz9UPhI5r
         3V4hdpMFVhRRnUFIwxWcCTdFvzn3CSqN+/2nPQnvBDULo97/YCCiQAnVzOrX8CTjgPdT
         9/wg==
X-Gm-Message-State: AOAM531HPsownvOK6YeFkRv+r8RoUCqrLz6E1beHgdoamWoEx28qV1c5
        SO6J/rfybJGFHoSf5xXCAGo0qiLrv/CBQZ99xLezy3yUK9ZAS4gNHQ/O0vqTFBHL4YxFab21i1p
        elyqoOyX7uQZq
X-Received: by 2002:a50:82e5:: with SMTP id 92mr286900edg.141.1618425546896;
        Wed, 14 Apr 2021 11:39:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkxcWD2lGhH/8uN3uqD1pTlC6YDkWHnJ8j/QCiTy/6J4pOCknB0VkBulobgQxqDd/3oGVH6Q==
X-Received: by 2002:a50:82e5:: with SMTP id 92mr286874edg.141.1618425546428;
        Wed, 14 Apr 2021 11:39:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ju23sm205549ejc.17.2021.04.14.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:39:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 12DB51804E8; Wed, 14 Apr 2021 20:39:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     paulmck@kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Selftest failures related to kern_sync_rcu()
In-Reply-To: <20210414181934.GV4510@paulmck-ThinkPad-P17-Gen-1>
References: <87blaozi20.fsf@toke.dk>
 <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk>
 <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
 <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
 <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1>
 <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
 <20210414181934.GV4510@paulmck-ThinkPad-P17-Gen-1>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 14 Apr 2021 20:39:04 +0200
Message-ID: <87czuwlnhz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Wed, Apr 14, 2021 at 10:59:23AM -0700, Alexei Starovoitov wrote:
>> On Wed, Apr 14, 2021 at 10:52 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>> >
>> > > > > >                 if (num_online_cpus() > 1)
>> > > > > >                         synchronize_rcu();
>> >
>> > In CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_VOLUNTARY=y kernels, this
>> > synchronize_rcu() will be a no-op anyway due to there only being the
>> > one CPU.  Or are these failures all happening in CONFIG_PREEMPT=y kernels,
>> > and in tests where preemption could result in the observed failures?
>> >
>> > Could you please send your .config file, or at least the relevant portions
>> > of it?
>> 
>> That's my understanding as well. I assumed Toke has preempt=y.
>> Otherwise the whole thing needs to be root caused properly.
>
> Given that there is only a single CPU, I am still confused about what
> the tests are expecting the membarrier() system call to do for them.

It's basically a proxy for waiting until the objects are freed on the
kernel side, as far as I understand...

-Toke

