Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE574394520
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 17:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhE1Per (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 11:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235316AbhE1Peq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 May 2021 11:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622215991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wf8GYvzF/y2zAgAsqAPYzyetAWdd3I1acwWIFartyWg=;
        b=bPCkM7/FIZ06K49giZm+wqVXXft12kysL10fWYhHC/e5L7ji+on6zPEiV+BDDCC9Yz6zh9
        KBw9k2gqj0pmQ4cr3u8bd3ie+MhzxdApeQwxhhbU7avy9wOwq0XjPMZerWk++gnvVfHFDt
        AXy6kn97u6OJbbOsrP4zuTOyQ3BjH28=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-I9ZrAagaOtOzGmHPqSuGIg-1; Fri, 28 May 2021 11:33:10 -0400
X-MC-Unique: I9ZrAagaOtOzGmHPqSuGIg-1
Received: by mail-ed1-f72.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so2329144edd.2
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 08:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wf8GYvzF/y2zAgAsqAPYzyetAWdd3I1acwWIFartyWg=;
        b=VnZdjsyXZhoy+4BcKFws7l6omlryqqYvK10RgWJdSFKVelQUv3uWFzQ0Dl0TILCRO0
         p8uNQRrsVxfCLosNXmnp1SMInCqX9FLBZNZW8nQL9/zIHRGhVUNHMGr+eUJmEIbcZ4R0
         91UWwOYYZmc9+Wy6B3oEhYNLxCImF2gHtvPWcn4ACTf+K4R3Adg9UQ95DI709Ae5dyWO
         Tn0q+rmH29aZLtfpdcdpDRdAnSUIMOSYTnQwSo4JJvdKF4aWK4HfxHnXGnF6CjDhncNg
         D5InzuO2ayJ3Dp33Bq3ekbN5GCc6nWvMPS6CAkzY8RcRzcmHdyOOMTDFCkwyM7CaVTCm
         QSyQ==
X-Gm-Message-State: AOAM533i8DR/Gkk9Cz5++17PRKveAVaHDSnoKOH/42zPy6YipkGqNFv8
        6yZTKxz5SQ/acFSgf31DuunTjT4RsDy8N7v7jmgjmOh5CejjS8qBICGlqOR7h3ueT+/w78cHIw2
        osQO+ceiUzyVN
X-Received: by 2002:aa7:c0c4:: with SMTP id j4mr10434624edp.168.1622215988524;
        Fri, 28 May 2021 08:33:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4dQjvpDrn5nR3EMb+ZD1h4G6MnSzksoEjOi5G9oMD3STu/Sp8ix73ofJUcllxd6lbCi3JEw==
X-Received: by 2002:aa7:c0c4:: with SMTP id j4mr10434567edp.168.1622215988036;
        Fri, 28 May 2021 08:33:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p11sm2854758edt.22.2021.05.28.08.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 08:33:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5BDFB180720; Fri, 28 May 2021 17:33:06 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
In-Reply-To: <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
References: <20210526125848.1c7adbb0@carbon>
 <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
 <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
 <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
 <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
 <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk>
 <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 28 May 2021 17:33:06 +0200
Message-ID: <87o8cug9fx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> John Fastabend <john.fastabend@gmail.com> writes:
>>=20
>> >> > > union and independent set of BTFs are two different things, I'll =
let
>> >> > > you guys figure out which one you need, but I replied how it could
>> >> > > look like in CO-RE world
>> >> >
>> >> > I think a union is sufficient and more aligned with how the
>> >> > hardware would actually work.
>> >>=20
>> >> Sure. And I think those are two orthogonal concerns. You can start
>> >> with a single struct mynic_metadata with union inside it, and later
>> >> add the ability to swap mynic_metadata with another
>> >> mynic_metadata___v2 that will have a similar union but with a
>> >> different layout.
>> >
>> > Right and then you just have normal upgrade/downgrade problems with
>> > any struct.
>> >
>> > Seems like a workable path to me. But, need to circle back to the
>> > what we want to do with it part that Jesper replied to.
>>=20
>> So while this seems to be a viable path for getting libbpf to do all the
>> relocations (and thanks for hashing that out, I did not have a good grip
>> of the details), doing it all in userspace means that there is no way
>> for the XDP program to react to changes once it has been loaded. So this
>> leaves us with a selection of non-very-attractive options, IMO. I.e.,
>> we would have to:
>
> I don't really understand what this means 'having XDP program to
> react to changes once it has been loaded.' What would a program look
> like thats dynamic? You can always version your metadata and
> write programs like this,
>
>   if (meta->version =3D=3D VERSION1) {do_foo}
>   else {do_bar}
>
> And then have a headeer,
>
>    struct meta {
>      int version;
>      union ...    // union of versions
>    }
>
> I fail to see how a program could 'react' dynamically. An agent could
> load new programs dynamically into tail call maps of fentry with
> the need handlers, which would work as well and avoid unions.

By "react" I meant "not break", as in the program should still be able
to parse the metadata even if config changes. See below:

>>=20
>> - have to block any modifications to the hardware config that would
>>   change the metadata format; this will probably result in irate users
>
> I'll need a concrete example if I swap out my parser block, I should
> also swap out my BPF for my shiny new protocol. I don't see how a
> user might write programs for things they've not configured hardware
> for yet. Leaving aside knobs like VLAN on/off, VXLAN on/off, and
> such which brings the next point.
>
>>=20
>> - require XDP programs to deal with all possible metadata permutations
>>   supported by that driver (by exporting them all via a BTF union or
>>   similar); this means a potential for combinatorial explosion of config
>>   options and as NICs become programmable themselves I'm not even sure
>>   if it's possible for the driver to know ahead of time
>
> I don't see the problem sorry. For current things that exist I can't
> think up too many fields vlan, timestamp, checksum(?), pkt_type,
> hash maybe.

Even with five fields (assuming they can be individually toggled),
that's 32 different metadata formats. Add two more and we're at 128.
That's what I meant with "combinatorial explosion" (although I suppose
it's only exponential, not combinatorial if we fix the order of the
fields). I suppose it may be that you're right and that in practice the
number of fields is small enough that it's manageable, but right off the
bat it seems like a pretty limiting design to me.

> For programmable pipelines (P4) then I don't see a problem with
> reloading your program or swapping out a program. I don't see the
> value of adding a new protocol for example dynamically. Surely the
> hardware is going to get hit with a big reset anyways.

Hmm, okay, I do buy that completely reprogramming the NIC is probably
not something that is done as dynamically as toggling existing feature
bits, so maybe that is not such a huge concern...

>> - throw up our hands and just let the user deal with it (i.e., to
>>   nothing and so require XDP programs to be reloaded if the NIC config
>>   changes); this is not very friendly and is likely to lead to subtle
>>   bugs if an XDP program parses the metadata assuming it is in a
>>   different format than it is
>
> I'm not opposed to user error causing logic bugs.  If I give
> users power to reprogram their NICs they should be capabable
> of managing a few BPF programs. And if not then its a space
> where a distro/vendor should help them with tooling.
>
>>=20
>> Given that hardware config changes are not just done by ethtool, but
>> also by things like running `tcpdump -j`, I really think we have to
>> assume that they can be quite dynamic; which IMO means we have to solve
>> this as part of the initial design. And I have a hard time seeing how
>> this is possible without involving the kernel somehow.
>
> I guess here your talking about building an skb? Wouldn't it
> use whatever logic it uses today to include the timestamp.
> This is a bit of an aside from metadata in the BPF program.

Building skbs is a separate concern, yeah, but that was not actually
what I meant here. Say I install an XDP program that reads metadata
like (after CO-RE rewriting):

struct meta {
  u32 rxhash;
  u8 vlan;
};

and that is merrily running and doing its thing, but then someone runs
`tcpdump -j`, causing the NIC to turn on hardware timestamping, thus
changing the effective metadata layout to:

struct meta {
  u32 rxhash;
  u32 timestamp;
  u8 vlan;
};

suddenly my XDP program will be reading garbage without knowing it, even
though it's not interested in the timestamp at all.

>> Unless I'm missing something? WDYT?
>
> Distilling above down. I think we disagree on how useful
> dynamic programs are because of two reasons. First I don't
> see a large list of common attributes that would make the
> union approach as painful as you fear.

See above; but I wouldn't actually mind being proven wrong here, I'm
just worried that we end up setting something in stone ABI-wise so we
can't change it later should there end up being a need for it.

> And two, I believe users who are touching core hardware firmware need
> to also be smart enough (or have smart tools) to swap out their BPF
> programs in the correct order so as to not create subtle races. I
> didn't do it here but if we agree walking through that program swap
> flow with firmware update would be useful.

Sure, I do think this would be useful; I only have a very fuzzy idea how
this is likely to work. But I think we may also differ in the assumption
of who controls the XDP programs: I very much view it as in scope for a
system to be able to run different XDP programs from different
applications without any other point of coordination than what the
kernel and libbpf/libxdp APIs offer. So if application A needs to
reprogram the hardware, how does application B's XDP program get
re-loaded so it can get its CO-RE relocations re-applied with the new
BTF format?

-Toke

