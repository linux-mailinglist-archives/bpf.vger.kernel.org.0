Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA805348561
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 00:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhCXXit (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Mar 2021 19:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234684AbhCXXiR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Mar 2021 19:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616629096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWsKgQX5RpEXJF2XwJsRHZ+bqYW+lEMQdkiI+AqWIgk=;
        b=CGESaNp+RD+qxbPlJajDsyM8n07hzwu6fJGzLA/y81yRmMyYgPvk+gndmhg8K9ma1azh3C
        2VvNdFBjI8G7tOegSl9DCObuH9h3iaJL16bFbC9jUYBY7i4CEnqBrxMWH9FRKZOFGV55Gq
        A+c1NHsCj27FL6yeytlpTltxHHWd9gc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-dO5d42HKNhyqkTeaGusI6g-1; Wed, 24 Mar 2021 19:38:11 -0400
X-MC-Unique: dO5d42HKNhyqkTeaGusI6g-1
Received: by mail-ed1-f69.google.com with SMTP id h5so1780927edf.17
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 16:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bWsKgQX5RpEXJF2XwJsRHZ+bqYW+lEMQdkiI+AqWIgk=;
        b=UpNrD/fzw++59e0qo7/OwPYvZngIbjWU04gy1wu9HdPa1WCIobzdieAavh6vCC7GRW
         Xlljrcy4c8kMF+RkM2y/xT7skrU2mWnqvATqOI6rXdSZryGERQxS9RhHTbcNL57ZJhPE
         rCvwiCi/Wwqe6V8ZHeKuumJeHOdnNatIGrho8Nen451hpzWGQVbds+3OQhX/rwg4rKRs
         /Koa4ugO1mVJkwb9TEIwDukSLC0VS6SL2B9LDPsDgSQ9UHa0nZXCSRRfTZg3Tip2nk1V
         woR2w7TbsTCg4UUIeW2z6VDxQIH8/wgOTcGj3IkVbQLlcfdd8K2NSHBahlZPtMsHoNU7
         Y8Kw==
X-Gm-Message-State: AOAM530ihqNM0JXkfQ+Y14QfpIv9aKXOXJ2TKsnf/3ydTKKdaQXUjgOL
        t7Q6mepphCasSWtaWF0c3qOvOIq1R0de5M4F3z+OT60ZHMeQ5q+t0+jnh/+ZUyNEGwtk5Jst7wE
        R+hL8j3caRLUn
X-Received: by 2002:a17:906:3b48:: with SMTP id h8mr6259202ejf.261.1616629090186;
        Wed, 24 Mar 2021 16:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx28324KlNDmlRF3zjuIjq/8k55ugSp4N17Mr3QyQ8ePbq2WK6hLHFgrzuk6zcL/arOOxIU8A==
X-Received: by 2002:a17:906:3b48:: with SMTP id h8mr6259183ejf.261.1616629089974;
        Wed, 24 Mar 2021 16:38:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w24sm1844647edt.44.2021.03.24.16.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:38:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9C99A1801A3; Thu, 25 Mar 2021 00:38:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        ast@kernel.org, bjorn.topel@intel.com, magnus.karlsson@intel.com,
        ciara.loftus@intel.com, john.fastabend@gmail.com
Subject: Re: [PATCH v3 bpf-next 06/17] libbpf: xsk: use bpf_link
In-Reply-To: <20210324130918.GA6932@ranger.igk.intel.com>
References: <20210322205816.65159-1-maciej.fijalkowski@intel.com>
 <20210322205816.65159-7-maciej.fijalkowski@intel.com>
 <87wnty7teq.fsf@toke.dk> <20210324130918.GA6932@ranger.igk.intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 25 Mar 2021 00:38:07 +0100
Message-ID: <87a6qsf7hc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Mon, Mar 22, 2021 at 10:47:09PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>>=20
>> > Currently, if there are multiple xdpsock instances running on a single
>> > interface and in case one of the instances is terminated, the rest of
>> > them are left in an inoperable state due to the fact of unloaded XDP
>> > prog from interface.
>> >
>> > Consider the scenario below:
>> >
>> > // load xdp prog and xskmap and add entry to xskmap at idx 10
>> > $ sudo ./xdpsock -i ens801f0 -t -q 10
>> >
>> > // add entry to xskmap at idx 11
>> > $ sudo ./xdpsock -i ens801f0 -t -q 11
>> >
>> > terminate one of the processes and another one is unable to work due to
>> > the fact that the XDP prog was unloaded from interface.
>> >
>> > To address that, step away from setting bpf prog in favour of bpf_link.
>> > This means that refcounting of BPF resources will be done automatically
>> > by bpf_link itself.
>> >
>> > Provide backward compatibility by checking if underlying system is
>> > bpf_link capable. Do this by looking up/creating bpf_link on loopback
>> > device. If it failed in any way, stick with netlink-based XDP prog.
>> > Otherwise, use bpf_link-based logic.
>>=20
>> So how is the caller supposed to know which of the cases happened?
>> Presumably they need to do their own cleanup in that case? AFAICT you're
>> changing the code to always clobber the existing XDP program on detach
>> in the fallback case, which seems like a bit of an aggressive change? :)
>
> Sorry Toke, I was offline yesterday.
> Yeah once again I went too far and we shouldn't do:
>
> bpf_set_link_xdp_fd(xsk->ctx->ifindex, -1, 0);
>
> if xsk_lookup_bpf_maps(xsk) returned non-zero value which implies that the
> underlying prog is not AF_XDP related.
>
> closing prog_fd (and link_fd under the condition that system is bpf_link
> capable) is enough for that case.

I think the same thing goes for further down? With your patch, if the
code takes the else branch (after checking prog_id), and then ends up
going to err_set_bpf_maps, it'll now also do an unconditional
bpf_set_link_xdp_fd(), where before it was checking prog_id again and
only unloading if it previously loaded the program...

> If we agree on that and there's nothing else that I missed, I'll send
> a v4.

Apart from the above, sure!

-Toke

