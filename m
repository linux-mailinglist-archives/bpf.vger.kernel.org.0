Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57B4427A76
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 15:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhJINMn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Oct 2021 09:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233022AbhJINMm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 9 Oct 2021 09:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633785045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cjzc4c+tx8ygVFq8OjdVylaeamvE4hyTP0I/P6aSTbc=;
        b=NqzytyPs2URAh20SBO8Qd5kHyYz1HGtiZtGUeSl4Ro5YTr/eH51j+rVwC8HxC1AJ1Iua73
        +JVVBzsRAIWOehGdk/PVBdrED7exItu5lZtT7EldeA+mhF0tgiP/CGp1xfcq/qpGflZdhr
        G7Z7HAKebyOtZJmYILqA6y7DJB00Sd4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-HL4nNz71OluP_UoTSsMHLg-1; Sat, 09 Oct 2021 09:10:43 -0400
X-MC-Unique: HL4nNz71OluP_UoTSsMHLg-1
Received: by mail-ed1-f72.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso11658420edn.4
        for <bpf@vger.kernel.org>; Sat, 09 Oct 2021 06:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Cjzc4c+tx8ygVFq8OjdVylaeamvE4hyTP0I/P6aSTbc=;
        b=cmIAXKTYYDflB5thQIwITbsSfcEB9EoTq0OUXPHPqu5vps7lHoK9VG6HKcoGoslHV/
         dMO2250J4/m1+XS+2j5+Bfl0WS9e0iV9rCShJwx8ojeeaWsLYcLAkUfSv89OR6WgpqfR
         LmYTwQxYsJh/XSNsCsKUYl7HlGICYB9jyPwag2OAX2qT7xhcx/Vs/I0KdlbBGUnaTIgP
         W0hTfcvxJfSYGy1X6wjjSndRcfgaOaBpPMms7v7Ngvwj/+Iy6yXoUW0UcT/bbbp4Bx5c
         7RiRCdaCAv2X8gtCnVX3a8RbGP7O2LSVTuuTPZjIyIO/SEP/vs3w3/KkHu/cpvPqbeP7
         s+LA==
X-Gm-Message-State: AOAM531YHq7ijGTmjmu7lH9BwRTGZ6AVVkeDQynEXuzcjZgmyujFU2GE
        IJlbzh9dfPP3kOeANbNZwzyd+oyjb9dUP5CCfdoWt/gZkpKR67lmaRjUJQMpVU/XpUfPXVHcpj4
        N/odli05NoPEB
X-Received: by 2002:a17:906:ce2c:: with SMTP id sd12mr11661825ejb.488.1633785042606;
        Sat, 09 Oct 2021 06:10:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfU9h0CHE0932QAnLTRuxJ+QET81S/ow2Jqienkp+99PlA01EyeMGvOF/hNnfYQpWEQxFt5g==
X-Received: by 2002:a17:906:ce2c:: with SMTP id sd12mr11661788ejb.488.1633785042235;
        Sat, 09 Oct 2021 06:10:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s26sm1186318edt.78.2021.10.09.06.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 06:10:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CAA12180151; Sat,  9 Oct 2021 15:10:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter
 capabilities
In-Reply-To: <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-2-joannekoong@fb.com> <87k0ioncgz.fsf@toke.dk>
 <4536decc-5366-dc07-4923-32f2db948d85@fb.com> <87o87zji2a.fsf@toke.dk>
 <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 09 Oct 2021 15:10:40 +0200
Message-ID: <87czoejqcv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Oct 8, 2021 at 2:58 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Joanne Koong <joannekoong@fb.com> writes:
>>
>> > On 10/7/21 7:20 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >
>> >> Joanne Koong <joannekoong@fb.com> writes:
>> >>
>> >>> This patch adds the kernel-side changes for the implementation of
>> >>> a bitset map with bloom filter capabilities.
>> >>>
>> >>> The bitset map does not have keys, only values since it is a
>> >>> non-associative data type. When the bitset map is created, it must
>> >>> be created with a key_size of 0, and the max_entries value should be=
 the
>> >>> desired size of the bitset, in number of bits.
>> >>>
>> >>> The bitset map supports peek (determining whether a bit is set in the
>> >>> map), push (setting a bit in the map), and pop (clearing a bit in the
>> >>> map) operations. These operations are exposed to userspace applicati=
ons
>> >>> through the already existing syscalls in the following way:
>> >>>
>> >>> BPF_MAP_UPDATE_ELEM -> bpf_map_push_elem
>> >>> BPF_MAP_LOOKUP_ELEM -> bpf_map_peek_elem
>> >>> BPF_MAP_LOOKUP_AND_DELETE_ELEM -> bpf_map_pop_elem
>> >>>
>> >>> For updates, the user will pass in a NULL key and the index of the
>> >>> bit to set in the bitmap as the value. For lookups, the user will pa=
ss
>> >>> in the index of the bit to check as the value. If the bit is set, 0
>> >>> will be returned, else -ENOENT. For clearing the bit, the user will =
pass
>> >>> in the index of the bit to clear as the value.
>> >> This is interesting, and I can see other uses of such a data structur=
e.
>> >> However, a couple of questions (talking mostly about the 'raw' bitmap
>> >> without the bloom filter enabled):
>> >>
>> >> - How are you envisioning synchronisation to work? The code is using =
the
>> >>    atomic set_bit() operation, but there's no test_and_{set,clear}_bi=
t().
>> >>    Any thoughts on how users would do this?
>> > I was thinking for users who are doing concurrent lookups + updates,
>> > they are responsible for synchronizing the operations through mutexes.
>> > Do you think this makes sense / is reasonable?
>>
>> Right, that is an option, of course, but it's a bit heavyweight. Atomic
>> bitops are a nice light-weight synchronisation primitive.
>>
>> Hmm, looking at your code again, you're already using
>> test_and_clear_bit() in pop_elem(). So why not just mirror that to
>> test_and_set_bit() in push_elem(), and change the returns to EEXIST and
>> ENOENT if trying to set or clear a bit that is already set or cleared
>> (respectively)?
>>
>> >> - It would be useful to expose the "find first set (ffs)" operation of
>> >>    the bitmap as well. This can be added later, but thinking about the
>> >>    API from the start would be good to avoid having to add a whole
>> >>    separate helper for this. My immediate thought is to reserve peek(=
-1)
>> >>    for this use - WDYT?
>> > I think using peek(-1) for "find first set" sounds like a great idea!
>>
>> Awesome!
>
> What's the intended use case for such an operation?

The 'find first set' operation is a single instruction on common
architectures, so it's an efficient way of finding the first non-empty
bucket if you index them in a bitmap; sch_qfq uses this, for instance.

> But also searching just a first set bit is non completely generic, I'd
> imagine that in practice (at least judging from bit operations done on
> u64s I've seen in the wild) you'd most likely need "first set bit
> after bit N", so peek(-N)?..

You're right as far as generality goes, but for my use case "after bit
N" is not so important (you enqueue into different buckets and always
need to find the lowest one. But there could be other use cases for
"find first set after N", of course. If using -N the parameter would
have to change to explicitly signed, of course, but that's fine by me :)

> I think it's an overkill to provide something like this, but even if
> we do, wouldn't BPF_MAP_GET_NEXT_KEY (except we now say it's a
> "value", not a "key", but that's nitpicking) be a sort of natural
> extension to provide this? Though it might be only available to
> user-space right?

Yeah, thought about get_next_key() but as you say that doesn't work from
BPF. It would make sense to *also* expose this to userspace through
get_next_key(), though.

> Oh, and it won't work in Bloom filter "mode", right?

I expect not? But we could just return -EINVAL in that case?

-Toke

