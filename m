Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34505F52E2
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 12:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJEKuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 06:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJEKuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 06:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF85C2BB3B
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664967017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFerFBpu3zyWi8AgGq9KLXwjFZX5iV1UxIObpSC5yY4=;
        b=K25oab6rf1tgCC1SEZy0O69ISgYSNhsudEyiN+GdFg1vzrpTJs+OaeN/6HSI5f7Xe5n2fS
        EvL5hxh20jhEeMfdfK0qqC1piW0EMd5ju8Y2wrhUEqoN7/+VC51mc/7QSfLoblpP3HEHwk
        ok+vSVKf2vxVc9EKty8yP1Et6eZvO40=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-Q1NriQm3Ox6Prd_kNRkHvw-1; Wed, 05 Oct 2022 06:50:16 -0400
X-MC-Unique: Q1NriQm3Ox6Prd_kNRkHvw-1
Received: by mail-ej1-f71.google.com with SMTP id 7-20020a170906328700b007838b96bf70so6255861ejw.7
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 03:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=oFerFBpu3zyWi8AgGq9KLXwjFZX5iV1UxIObpSC5yY4=;
        b=1gjR0TvkIZBJwS5J6awXu+GTQjvDF8c33y22uPxlrVAtgR2eV8sjQYBlCZJo36qEUr
         ohlyOYxXRbXDVaZhHLmyc9c+9I7aqunQGJ+y2s9TVThOtsLt/MRGH5JPJ5LIX4TBr7Co
         EicZEBjIJTqzEDSgkpIQj3PG82Upnxd0JcJjyVLR6sbKcqmdac4SOVo8qhch/NJMg6fg
         rRB2hIYMktekDqYuxfaeT7Wmuf/FGqH9poWVBBOwo6bUya3t5NaaeW/AE6X/qZEbTjiN
         VHrHyOpbM0guczB8ikQaxq1WoXVZxf8X/h7mWyT5wUWtkDwAD54rykqEtNOKFODmQe5y
         /ZJw==
X-Gm-Message-State: ACrzQf3gYytCn0O5IbAsqVTh3TauEeaegP2NKVyJQP3y+Hl9jTaE9hBK
        Q2f7NUlWGY6WgjEN1ssUXEGnCE+24pOS9Wc77HWg2ESMqKJ0cl7+VP2X+bOrVdG5VNrNW+CYVVe
        NyvynWAhlLNkl
X-Received: by 2002:a05:6402:42d0:b0:457:d16e:283d with SMTP id i16-20020a05640242d000b00457d16e283dmr27795533edc.395.1664967015364;
        Wed, 05 Oct 2022 03:50:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5upJ27hR9QUed4F3KdHMtkYbEQG19fYKKcP/aFBy5d7N4mlSHVnW+ff5VYCPSPsG6tI6oGJw==
X-Received: by 2002:a05:6402:42d0:b0:457:d16e:283d with SMTP id i16-20020a05640242d000b00457d16e283dmr27795505edc.395.1664967014970;
        Wed, 05 Oct 2022 03:50:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a17-20020a056402169100b00457607603f9sm3476418edv.67.2022.10.05.03.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 03:50:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AA86364EB83; Wed,  5 Oct 2022 12:50:13 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     sdf@google.com, Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, razor@blackwall.org, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, john.fastabend@gmail.com,
        joannelkoong@gmail.com, memxor@gmail.com, joe@cilium.io,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 01/10] bpf: Add initial fd-based API to attach
 tc BPF programs
In-Reply-To: <YzzWDqAmN5DRTupQ@google.com>
References: <20221004231143.19190-1-daniel@iogearbox.net>
 <20221004231143.19190-2-daniel@iogearbox.net>
 <YzzWDqAmN5DRTupQ@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 05 Oct 2022 12:50:13 +0200
Message-ID: <878rluily2.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sdf@google.com writes:

>>   	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
>> -		__u32		target_fd;	/* container object to attach to */
>> +		union {
>> +			__u32	target_fd;	/* container object to attach to */
>> +			__u32	target_ifindex; /* target ifindex */
>> +		};
>>   		__u32		attach_bpf_fd;	/* eBPF program to attach */
>>   		__u32		attach_type;
>>   		__u32		attach_flags;
>> -		__u32		replace_bpf_fd;	/* previously attached eBPF
>
> [..]
>
>> +		union {
>> +			__u32	attach_priority;
>> +			__u32	replace_bpf_fd;	/* previously attached eBPF
>>   						 * program to replace if
>>   						 * BPF_F_REPLACE is used
>>   						 */
>> +		};
>
> The series looks exciting, haven't had a chance to look deeply, will try
> to find some time this week.
>
> We've chatted briefly about priority during the talk, let's maybe discuss
> it here more?
>
> I, as a user, still really have no clue about what priority to use.
> We have this problem at tc, and we'll seemingly have the same problem
> here? I guess it's even more relevant in k8s because internally at G we
> can control the users.
>
> Is it worth at least trying to provide some default bands / guidance?
>
> For example, having SEC('tc/ingress') receive attach_priority=124 by
> default? Maybe we can even have something like 'tc/ingress_first' get
> attach_priority=1 and 'tc/ingress_last' with attach_priority=254?
> (the names are arbitrary, we can do something better)
>
> ingress_first/ingress_last can be used by some monitoring jobs. The rest
> can use default 124. If somebody really needs a custom priority, then they
> can manually use something around 124/2 if they need to trigger before the
> 'default' priority or 124+124/2 if they want to trigger after?
>
> Thoughts? Is it worth it? Do we care?

I think we should care :)

Having "better" defaults are probably a good idea (so not everything
just ends up at priority 1 by default). However, I think ultimately the
only robust solution is to make the priority override-able. Users are
going to want to combine BPF programs in ways that their authors didn't
anticipate, so the actual priority the programs run at should not be the
sole choice of the program author.

To use the example that Daniel presented at LPC: Running datadog and
cilium at the same time broke cilium because datadog took over the
prio-1 hook point. With the bpf_link API what would change is that (a)
it would be obvious that something breaks (that is good), and (b) it
would be datadog that breaks instead of cilium (because it can no longer
just take over the hook, it'll get an error instead). However, (b) means
that the user still hasn't gotten what they wanted: the ability to run
datadog and cilium at the same time. To do this, they will need to be
able to change the priorities of one or both applications.

I know cilium at least has a configuration option to change this
somewhere, but I don't think relying on every BPF-using application to
expose this (each in their own way) is a good solution. I think of
priorities more like daemon startup at boot: this is system policy,
decided by the equivalent of the init system (and in this analogy we are
currently at the 'rc.d' stage of init system design, with the hook
priorities).

One way to resolve this is to have a central daemon that implements the
policy and does all the program loading on behalf of the users. I think
multiple such daemons exist already in more or less public and/or
complete states. However, getting everyone to agree on one is also hard,
so maybe the kernel needs to expose a mechanism for doing the actual
overriding, and then whatever daemon people run can hook into that?

Not sure what that mechanism would be? A(nother) BPF hook for overriding
priority on load? An LSM hook that rewrites the system call? (can it
already do that?) Something else?

Oh, and also, in the case of TC there's also the additional issue that
execution only chains to the next program if the current one returns
TC_ACT_UNSPEC; this should probably also be overridable somehow, for the
same reasons...

-Toke

