Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267713B035C
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 13:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhFVLz5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 07:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231129AbhFVLzy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Jun 2021 07:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624362817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AwNmIDO2lDvXkcW47TEjA1vpXxY2VTlALdB6cHAVAoU=;
        b=bUo32c8R7ow6SWFc2Pcqe5Ql7iR71BIhKbF0lMrpA3DVVfZcz8ZbQb2rK8Q+Bf41Gd6iFw
        gJ/3//HyBTvQQwTeeuI8mlbNpJfL8Q2Kq6PiT/jsMDki9unGLGsLdPG4VUIQvMYKeXjWY1
        A8nk/jPrETZBuMVuZAAsXkCBYdu/UHs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-pYvXc4yPNHuticXC19TSBA-1; Tue, 22 Jun 2021 07:53:36 -0400
X-MC-Unique: pYvXc4yPNHuticXC19TSBA-1
Received: by mail-ej1-f72.google.com with SMTP id j26-20020a170906411ab02904774cb499f8so5124380ejk.6
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 04:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AwNmIDO2lDvXkcW47TEjA1vpXxY2VTlALdB6cHAVAoU=;
        b=b38K858LJcqlbcx9pcvgyb3kYEb/9G0PNQcgLOdJhhOC5IQGJt+hB58vMxBHBU7xVO
         z+2TvleB/G6wcH3MjvV3h1oji7e0i9Kvfz9l9yhOvwI+288rlLFS8tYeg5xgT8QmeDm2
         ZhZ6nL0k9B1VwhUqkrVgzxcnl3lm1jeZoiHJHBL0HFPtQv4dC/aNA19ioSGQVx4TeQnA
         Bd0O1MulyR/OznwTKqaS2S+CZVY/4Q8xFtHwO4a7tmXPOYbOo1Qy+9qRxfrKE8UmEOvw
         Tiwy07No6OsYWn83BL03qDVArnekcaatRm0zW7ASXh5OLRC7YDgXWvrHCvDf1mNR1IIX
         OshA==
X-Gm-Message-State: AOAM530fK7l6feGEUWlxgwt3jlABDtdWhobNy6XR2O9Eh8N7lRjsaMOB
        co3+zBotSe+dx0Acl9PS2ylOXN6Niy+1U+/HT1wHDi/XgqS/ejm435/57DbwTQexUilU2Eu0UNS
        2W4Q5TIuQ/cwQ
X-Received: by 2002:a17:906:b55:: with SMTP id v21mr3642722ejg.88.1624362815265;
        Tue, 22 Jun 2021 04:53:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymogDnqjRa9Y5HNm1y39PaViPuKTVEyoKJZA+Sq0vPW2EzEWBRkQhF03iZxz3MPdQCmsVsUg==
X-Received: by 2002:a17:906:b55:: with SMTP id v21mr3642683ejg.88.1624362814870;
        Tue, 22 Jun 2021 04:53:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h7sm6016869ejp.24.2021.06.22.04.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 04:53:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4EF3518071E; Tue, 22 Jun 2021 13:53:33 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
In-Reply-To: <YNGU4GhL8fZ0ErzS@localhost.localdomain>
References: <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
 <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
 <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk>
 <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon>
 <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk>
 <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Jun 2021 13:53:33 +0200
Message-ID: <874kdqqfnm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:

> On Wed, Jun 02, 2021 at 09:18:37AM -0700, Jakub Kicinski wrote:
>> On Tue, 01 Jun 2021 17:22:51 -0700 John Fastabend wrote:
>> > > If we do this, the BPF program obviously needs to know which fields are
>> > > valid and which are not. AFAICT you're proposing that this should be
>> > > done out-of-band (i.e., by the system administrator manually ensuring
>> > > BPF program config fits system config)? I think there are a couple of
>> > > problems with this:
>> > > 
>> > > - It requires the system admin to coordinate device config with all of
>> > >   their installed XDP applications. This is error-prone, especially as
>> > >   the number of applications grows (say if different containers have
>> > >   different XDP programs installed on their virtual devices).  
>> > 
>> > A complete "system" will need to be choerent. If I forward into a veth
>> > device the orchestration component needs to ensure program sending
>> > bits there is using the same format the program installed there expects.
>> > 
>> > If I tailcall/fentry into another program that program the callee and
>> > caller need to agree on the metadata protocol.
>> > 
>> > I don't see any way around this. Someone has to manage the network.
>> 
>> FWIW I'd like to +1 Toke's concerns.
>> 
>> In large deployments there won't be a single arbiter. Saying there 
>> is seems to contradict BPF maintainers' previous stand which lead 
>> to addition of bpf_links for XDP.
>> 
>> In practical terms person rolling out an NTP config change may not 
>> be aware that in some part of the network some BPF program expects
>> descriptor not to contain time stamps. Besides features may depend 
>> or conflict so the effects of feature changes may not be obvious 
>> across multiple drivers in a heterogeneous environment.
>> 
>> IMO guarding from obvious mis-configuration provides obvious value.
>
> Hi,
>
> Thanks for a lot of usefull information about CO-RE. I have read
> recommended articles, but still don't understand everything, so sorry if
> my questions are silly.
>
> As introduction, I wrote small XDP example using CO-RE (autogenerated
> vmlinux.h and getting rid of skeleton etc.) based on runqslower
> implementation. Offset reallocation of hints works great, I built CO-RE
> application, added new field to hints struct, changed struct layout and
> without rebuilding application everything still works fine. Is it worth
> to add XDP sample using CO-RE in kernel or this isn't good place for
> this kind of sample?
>
> First question not stricte related to hints. How to get rid of #define
> and macro when I am using generated vmlinux.h? For example I wanted to
> use htons macro and ethtype definition. They are located in headers that
> also contains few struct definition. Because of that I have redefinition
> error when I am trying to include them (redefinition in vmlinux.h and
> this included file). What can I do with this besides coping definitions
> to bpf code?

One way is to only include the structs you actually need from vmlinux.h.
You can even prune struct members, since CO-RE works just fine with
partial struct definitions as long as the member names match.

Jesper has an example on how to handle this here:
https://github.com/netoptimizer/bpf-examples/blob/ktrace01-CO-RE.public/headers/vmlinux_local.h

> I defined hints struct in driver code, is it right place for that? All
> vendors will define their own hints struct or the idea is to have one
> big hints struct with flags informing about availability of each fields?
>
> For me defining it in driver code was easier because I can have used
> module btf to generate vmlinux.h with hints struct inside. However this
> break portability if other vendors will have different struct name etc,
> am I right?

I would expect the easiest is for drivers to just define their own
structs and maybe have some infrastructure in the core to let userspace
discover the right BTF IDs to use for a particular netdev. However, as
you say it's not going to work if every driver just invents their own
field names, so we'll need to coordinate somehow. We could do this by
convention, though, it'll need manual intervention to make sure the
semantics of identically-named fields match anyway.

Cf the earlier discussion with how many BTF IDs each driver might
define, I think we *also* need a way to have flags that specify which
fields of a given BTF ID are currently used; and having some common
infrastructure for that would be good...

-Toke

