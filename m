Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AC6393FB0
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 11:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhE1JSZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 05:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234703AbhE1JSY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 May 2021 05:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622193410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UqGUmWxUI1aVI5m8Eebociw05Yq3S7eC/phq5U0Gnwg=;
        b=Knomo7GU8ff6nKxUb5RY7ohiUaYcwC4kw7OX1wGlEsmGEWul7z2cCQ2Z91FMp+63agZcjM
        qvvT7fD3yvbuenKZhXz/pLj9X2GJI8Uw4gLl5q+HjWne1SnwaWXJSXMbn/t2AcXAwNPtNI
        RhvcxM58WXhNzTCIcVyLA5yu2+Nju+E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-thsCj7aGPX-o02BdM-llhA-1; Fri, 28 May 2021 05:16:48 -0400
X-MC-Unique: thsCj7aGPX-o02BdM-llhA-1
Received: by mail-ed1-f72.google.com with SMTP id cn20-20020a0564020cb4b029038d0b0e183fso1801288edb.22
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 02:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UqGUmWxUI1aVI5m8Eebociw05Yq3S7eC/phq5U0Gnwg=;
        b=OBvbBDntGcUEe9QBzgkKKOwfzD1aptN4nOoAIThj4wS9OftWMJH44gamUm9949tVwV
         qUnueQY5rB9R5xRrU+s50Nwl3L+m9cHJ8MUz6WKqAI7N8NO9+0qhIbsdsa5IZTM3Ez1T
         RfDu5Vlf+sIRFJUvvv8eNbUJHvSxtqK4MMhq9axW3/cWon67tb+Ep780OZH/CY+ev8no
         kkAPYbLcrqCgORXzKse6pdgQzl1O42wrwEdolVw3edgexeoEij7phtUfbnvqCDnGrtig
         UqP45zfN2k0FrwVj+YxhNswRYIxsz2LA/z7mxnMrv1PFff5vYj7UBiz4CdtxYU8ZkndS
         mA+Q==
X-Gm-Message-State: AOAM533QK75+cfMdHOd6XQQXLMcbcXUR5nvKlFQiQ0mAhr5mUZHz4oQ/
        C9gDt3FZqkPgWvD5aP0Ffo7NsjvgOp4gIvpDzOYtWb1T3sAXdAXXSiKhVlWCesBh+ucJI7azkTG
        gQCjYAYzY/RDt
X-Received: by 2002:a05:6402:30a2:: with SMTP id df2mr8645696edb.176.1622193407286;
        Fri, 28 May 2021 02:16:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGlmB+oEv2RNwrXsHFQ9SdYfIMnO6kYtfXRBZGswyCoGcJyrcrmHh3eFfkFWx6o+d7W/M20w==
X-Received: by 2002:a05:6402:30a2:: with SMTP id df2mr8645678edb.176.1622193407129;
        Fri, 28 May 2021 02:16:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j4sm2381592edq.13.2021.05.28.02.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:16:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B44AD18071B; Fri, 28 May 2021 11:16:44 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        William Tu <u9012063@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        xdp-hints@xdp-project.net
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
In-Reply-To: <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
References: <20210526125848.1c7adbb0@carbon>
 <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
 <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
 <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
 <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
 <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 28 May 2021 11:16:44 +0200
Message-ID: <87fsy7gqv7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

>> > > union and independent set of BTFs are two different things, I'll let
>> > > you guys figure out which one you need, but I replied how it could
>> > > look like in CO-RE world
>> >
>> > I think a union is sufficient and more aligned with how the
>> > hardware would actually work.
>> 
>> Sure. And I think those are two orthogonal concerns. You can start
>> with a single struct mynic_metadata with union inside it, and later
>> add the ability to swap mynic_metadata with another
>> mynic_metadata___v2 that will have a similar union but with a
>> different layout.
>
> Right and then you just have normal upgrade/downgrade problems with
> any struct.
>
> Seems like a workable path to me. But, need to circle back to the
> what we want to do with it part that Jesper replied to.

So while this seems to be a viable path for getting libbpf to do all the
relocations (and thanks for hashing that out, I did not have a good grip
of the details), doing it all in userspace means that there is no way
for the XDP program to react to changes once it has been loaded. So this
leaves us with a selection of non-very-attractive options, IMO. I.e.,
we would have to:

- have to block any modifications to the hardware config that would
  change the metadata format; this will probably result in irate users

- require XDP programs to deal with all possible metadata permutations
  supported by that driver (by exporting them all via a BTF union or
  similar); this means a potential for combinatorial explosion of config
  options and as NICs become programmable themselves I'm not even sure
  if it's possible for the driver to know ahead of time

- throw up our hands and just let the user deal with it (i.e., to
  nothing and so require XDP programs to be reloaded if the NIC config
  changes); this is not very friendly and is likely to lead to subtle
  bugs if an XDP program parses the metadata assuming it is in a
  different format than it is

Given that hardware config changes are not just done by ethtool, but
also by things like running `tcpdump -j`, I really think we have to
assume that they can be quite dynamic; which IMO means we have to solve
this as part of the initial design. And I have a hard time seeing how
this is possible without involving the kernel somehow.

Unless I'm missing something? WDYT?

-Toke

