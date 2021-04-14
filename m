Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643F635FB73
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 21:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhDNTSf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 15:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230040AbhDNTSf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 15:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618427893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9jduqdM8v5VPul5wVy4AgQvCgpr7qTLfUEH4/7xZeE=;
        b=f4/gbUKYcFO08oPboWiHuaIEaEZmSjPVU/hK7otp+ctIIlYhOkI0316lZ1gVmBDkhP+7jv
        mClBI0HWqrkJUkusuSL03sQpDOdko6f8djvuo/WDz4o/u6YYec/nt2YnRYNzHSeppwkNJd
        /yAFDlLv8pWPVisU8AC0h5EDBCwUUS8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-44osk9uxMjWZ5qC4DfSh3g-1; Wed, 14 Apr 2021 15:18:11 -0400
X-MC-Unique: 44osk9uxMjWZ5qC4DfSh3g-1
Received: by mail-ej1-f69.google.com with SMTP id r14-20020a1709062cceb0290373a80b4002so145421ejr.20
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 12:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=I9jduqdM8v5VPul5wVy4AgQvCgpr7qTLfUEH4/7xZeE=;
        b=UsSqG+CLbdDOEtgsjeehODjOnNcnuQO0hitRNFItHW7SGZSRMDG5F4EBmpTIQ65FHC
         jMyWxkVr3IndzBI+n1Jp0rDmVt6NkXnRP4Np6qeDJRIeuZn3nu5YIWsbBd4v72MeApuZ
         jXMfCT7cVa6q+cahlo7vD1sQpXHDm9OlB2mb/K76aQN83CMrVJ77XAxSD+5ROaB8LnT/
         319UzKCHTZAESn1PoWmnM9zUjniSS/kIBNnqQpLB70JGdewbiOyJoduXhyzDptW6hBls
         c4+ySxDHglDq3GiVWADCMt0+TxfX4mjiky134jNtu2OvFoQHDYMpGvw1NAbdGRwn7CkG
         7Qng==
X-Gm-Message-State: AOAM533thJIGQwQVftxC5Ww0V1HZociTiM2K1as8UWb6+ebkN/vvgkcd
        DYz437I7bsb8XFqarKvo3BFiiWBiCNwaJyQQPLWTCSlM2GtZtuKhoekzJmJWSGsRGjT2CFbGn1L
        zoAXsOuxYe1VY
X-Received: by 2002:a17:906:86c2:: with SMTP id j2mr381329ejy.257.1618427890606;
        Wed, 14 Apr 2021 12:18:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWP89fmXdi4sP7xmm8uId9jMn0L8zk2L/KbMjB/S9E3rfjr8nFUgLXTc1VzixyP0U+ZvoVNg==
X-Received: by 2002:a17:906:86c2:: with SMTP id j2mr381314ejy.257.1618427890447;
        Wed, 14 Apr 2021 12:18:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n3sm236779ejj.113.2021.04.14.12.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 12:18:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1C0931804E8; Wed, 14 Apr 2021 21:18:09 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     paulmck@kernel.org
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Selftest failures related to kern_sync_rcu()
In-Reply-To: <20210414184133.GW4510@paulmck-ThinkPad-P17-Gen-1>
References: <87blaozi20.fsf@toke.dk>
 <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk>
 <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
 <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
 <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1>
 <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
 <20210414181934.GV4510@paulmck-ThinkPad-P17-Gen-1>
 <87czuwlnhz.fsf@toke.dk>
 <20210414184133.GW4510@paulmck-ThinkPad-P17-Gen-1>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 14 Apr 2021 21:18:09 +0200
Message-ID: <87a6q0llou.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Wed, Apr 14, 2021 at 08:39:04PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> "Paul E. McKenney" <paulmck@kernel.org> writes:
>>=20
>> > On Wed, Apr 14, 2021 at 10:59:23AM -0700, Alexei Starovoitov wrote:
>> >> On Wed, Apr 14, 2021 at 10:52 AM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>> >> >
>> >> > > > > >                 if (num_online_cpus() > 1)
>> >> > > > > >                         synchronize_rcu();
>> >> >
>> >> > In CONFIG_PREEMPT_NONE=3Dy and CONFIG_PREEMPT_VOLUNTARY=3Dy kernels=
, this
>> >> > synchronize_rcu() will be a no-op anyway due to there only being the
>> >> > one CPU.  Or are these failures all happening in CONFIG_PREEMPT=3Dy=
 kernels,
>> >> > and in tests where preemption could result in the observed failures?
>> >> >
>> >> > Could you please send your .config file, or at least the relevant p=
ortions
>> >> > of it?
>> >>=20
>> >> That's my understanding as well. I assumed Toke has preempt=3Dy.
>> >> Otherwise the whole thing needs to be root caused properly.
>> >
>> > Given that there is only a single CPU, I am still confused about what
>> > the tests are expecting the membarrier() system call to do for them.
>>=20
>> It's basically a proxy for waiting until the objects are freed on the
>> kernel side, as far as I understand...
>
> There are in-kernel objects that are freed via call_rcu(), and the idea
> is to wait until these objects really are freed?  Or am I still missing
> out on what is going on?

Something like that? Although I'm not actually sure these are using
call_rcu()? One of them needs __put_task_struct() to run, and the other
waits for map freeing, with this comment:


	/* we need to either wait for or force synchronize_rcu(), before
	 * checking for "still exists" condition, otherwise map could still be
	 * resolvable by ID, causing false positives.
	 *
	 * Older kernels (5.8 and earlier) freed map only after two
	 * synchronize_rcu()s, so trigger two, to be entirely sure.
	 */
	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");


-Toke

