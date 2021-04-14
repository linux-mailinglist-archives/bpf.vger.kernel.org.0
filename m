Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7529C35FACB
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 20:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhDNS2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 14:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232769AbhDNS2B (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 14:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618424859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0+mpzPnadp3YFpo4WNN9eJhKKlIukTfGGbUpb45yZU=;
        b=gS2MR9ESt1Cu4K89qifVkGwpfD7pndJLyXnn1q9Xp9V57NMtpHCxg/HXgR7OZTmLZ/ATUC
        ZwcUFM07XllasFMKlT1m2Mj4Q66jycecNp4hM4J0ecd04BT6ILhpgMfdAS8TyTRyGTtdk3
        w5uvrny9EHX5Bs6Ye9Xa3/BfWhNSGlQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-QeiN7P-RMP-LiVgTuvivmQ-1; Wed, 14 Apr 2021 14:27:37 -0400
X-MC-Unique: QeiN7P-RMP-LiVgTuvivmQ-1
Received: by mail-ej1-f69.google.com with SMTP id o25-20020a1709061d59b029037c94676df5so93893ejh.7
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 11:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=G0+mpzPnadp3YFpo4WNN9eJhKKlIukTfGGbUpb45yZU=;
        b=ELVoa0tq2QLPUtWpVNTHfmsnXc1z1ru8k4CG4+v++w8h8ply22OaFEY4YgxZaOYgHI
         OX8EPuWX9GoBEGwscgtCIt5YB5wD1OkcsOjR2i2EYysy5TYBBIgwFVt5c73xaaKRNean
         LENYfPWlgGRhCMj/aF4ardWG9M1fxJwMGJW6p5LDJPi3uqDzhzz7WOGbBHe7hy8HQ9ln
         +ca7BBOdsz//c0yA7K8l9b9hh9ZJCKIzBEHmX8uReqxwRUGd98vyJz1Xb9GZjhUDHcBP
         9v47TlrvdLydIZfwJYq9/QbpYzH0QNwkmc0Cj63VvOIPhK/pu/+fE8WViO5oYcgYsN+Q
         duRA==
X-Gm-Message-State: AOAM5304GoTFvnLpIfzW36E4Z1iskifXjr3AldW7iQOrcpynCQ7oNguV
        /uw15IB5wf0a1VxW+OM2o0bk/QxHW+dOji9LFHS/4+y6LGTl53dSJ7J+FQ7h1Fz8qysL5a/kXC/
        FMOnf8a4SlKnn
X-Received: by 2002:a17:906:c09:: with SMTP id s9mr197331ejf.145.1618424856147;
        Wed, 14 Apr 2021 11:27:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJximSK2EUfERhx2502Mxya0CdHERdsde5DvSKSTChVgKPNYA0RINEsr0STROK0tAJlYnH9DCA==
X-Received: by 2002:a17:906:c09:: with SMTP id s9mr197306ejf.145.1618424855791;
        Wed, 14 Apr 2021 11:27:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v8sm301003edc.30.2021.04.14.11.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:27:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 917201804E8; Wed, 14 Apr 2021 20:27:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Selftest failures related to kern_sync_rcu()
In-Reply-To: <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
References: <87blaozi20.fsf@toke.dk>
 <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk>
 <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
 <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
 <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1>
 <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 14 Apr 2021 20:27:34 +0200
Message-ID: <87fszslo15.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Apr 14, 2021 at 10:52 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>>
>> > > > >                 if (num_online_cpus() > 1)
>> > > > >                         synchronize_rcu();
>>
>> In CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_VOLUNTARY=y kernels, this
>> synchronize_rcu() will be a no-op anyway due to there only being the
>> one CPU.  Or are these failures all happening in CONFIG_PREEMPT=y kernels,
>> and in tests where preemption could result in the observed failures?
>>
>> Could you please send your .config file, or at least the relevant portions
>> of it?
>
> That's my understanding as well. I assumed Toke has preempt=y.
> Otherwise the whole thing needs to be root caused properly.

Running with a single CPU fails, with multiple CPUs succeeds.
Happens without PREEMPT as well:

$ egrep 'HZ|PREEMPT|RCU' .config
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# RCU Subsystem
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_PREEMPT_NOTIFIERS=y
# CONFIG_MACHZ_WDT is not set
# RCU Debugging
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_RCU_STRICT_GRACE_PERIOD is not set
# end of RCU Debugging
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

Anything else you need from .config?

-Toke

