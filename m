Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ACE262CFB
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIIKYi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 06:24:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37849 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgIIKYd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 06:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599647072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNKWem7GjKtrHP8IhKGbw32vahSAflEHXdLdyH6FBX4=;
        b=LQ4NMNH+A8frUn3ZfB9SQdKOp1K2Z4n6B+72hdVC16ZA8SnwKO7COtOoNGawC3RIFOOSwa
        iM41Sz8VYRck4u8+De934Zuoz+T0AdwAutwtibNnAuLLytCW9ZRYKAWbV1XVKsPyzOH7Cq
        6/H4W4IpsrMn/4xS7ot+qSZYwdQYaWI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-qFINpBhhOJe7vgro_FivDA-1; Wed, 09 Sep 2020 06:24:29 -0400
X-MC-Unique: qFINpBhhOJe7vgro_FivDA-1
Received: by mail-wm1-f70.google.com with SMTP id m125so615719wmm.7
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 03:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dNKWem7GjKtrHP8IhKGbw32vahSAflEHXdLdyH6FBX4=;
        b=Wnaqc9K5LMQduFNRZqcr2HDCOQ3iO+7ZG2Dk13y7b0kGBu8F5aFyMvM3TKqvG55+dY
         k6GX83v/s7UVGarFcS96tiDexJnnr0ng2w5BI+y7ASBDy0lioxFQ5zTdJE61oiSHo8Nr
         HeRG7Eq90cIPJqtTAAFZux+fAfO9MImtAcC4K9mtVsKQE0Q0tUWMmvvpR9FIDqqZVN+H
         FJYPrbq0MHVnc20WjQ0CJtT+xz/uT/VyJofRJUJBUOCm0abRTx1LJvqreE18MthhcBe/
         C8n6zw2BmjpmX8lPm+axW9AWL1hbpBcFlOgEjSvPqkWXv1mrc3IRqFlYIPux9sY19uzT
         Vzug==
X-Gm-Message-State: AOAM5306R3gwE01/lppRm0uQXAU8wTII01OYszCsqRSt90/haUXqcj5/
        494H3xpgeyExl/27Z6o805tEI2fC6gCsdfVqcC8UNBbvZNBwxbssOe8x7hbv2E/nKsORPoICQBP
        FR+3+DN1+GAkz
X-Received: by 2002:a05:600c:c5:: with SMTP id u5mr2798479wmm.14.1599647068329;
        Wed, 09 Sep 2020 03:24:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWoAPhkSxyAXOckzjucktn6OGhXKAMSPs3GAqooBaESfe0pDMZ20rLpDT7OsjFFRnezdVYmA==
X-Received: by 2002:a05:600c:c5:: with SMTP id u5mr2798458wmm.14.1599647068091;
        Wed, 09 Sep 2020 03:24:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a10sm3153988wmj.38.2020.09.09.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 03:24:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A57E11829D4; Wed,  9 Sep 2020 12:24:25 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Borna Cafuk <borna.cafuk@sartura.hr>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        KP Singh <kpsingh@google.com>
Subject: Re: HASH_OF_MAPS inner map allocation from BPF
In-Reply-To: <CAGeTCaWDk_ok38Xm8H8-8HQYP-bbPqMuwWDpEYM=i1=e0e88bw@mail.gmail.com>
References: <CAGeTCaU1fEGVVWnXKR_zv4ZSoCrBGSN65-RpFuKg9Gf-_z6TOw@mail.gmail.com>
 <CAADnVQKsbbd9dbPYQqa5=QsRfLo07hEjr1rSC=5DfVpzUK7Ajw@mail.gmail.com>
 <CAGeTCaWSSBJye72NCQW4N=XtsFx-rv-EEgTowTT3VEtus=pFtA@mail.gmail.com>
 <878sdlpv92.fsf@toke.dk>
 <CAGeTCaWDk_ok38Xm8H8-8HQYP-bbPqMuwWDpEYM=i1=e0e88bw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 09 Sep 2020 12:24:25 +0200
Message-ID: <87mu1znt7q.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Borna Cafuk <borna.cafuk@sartura.hr> writes:

> On Mon, Sep 7, 2020 at 3:33 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Borna Cafuk <borna.cafuk@sartura.hr> writes:
>>
>> > On Sat, Sep 5, 2020 at 12:47 AM Alexei Starovoitov
>> > <alexei.starovoitov@gmail.com> wrote:
>> >>
>> >> On Fri, Sep 4, 2020 at 7:57 AM Borna Cafuk <borna.cafuk@sartura.hr> w=
rote:
>> >> >
>> >> > Hello everyone,
>> >> >
>> >> > Judging by [0], the inner maps in BPF_MAP_TYPE_HASH_OF_MAPS can onl=
y be created
>> >> > from the userspace. This seems quite limiting in regard to what can=
 be done
>> >> > with them.
>> >> >
>> >> > Are there any plans to allow for creating the inner maps from BPF p=
rograms?
>> >> >
>> >> > [0] https://stackoverflow.com/a/63391528
>> >>
>> >> Did you ask that question or your use case is different?
>> >> Creating a new map for map_in_map from bpf prog can be implemented.
>> >> bpf_map_update_elem() is doing memory allocation for map elements.
>> >> In such a case calling this helper on map_in_map can, in theory, crea=
te a new
>> >> inner map and insert it into the outer map.
>> >
>> > No, it wasn't me who asked that question, but it seemed close enough to
>> > my issue. My use case calls for modifying the syscount example from BC=
C[1].
>> >
>> > The idea is to have an outer map where the keys are PIDs, and inner ma=
ps where
>> > the keys are system call numbers. This would enable tracking the numbe=
r of
>> > syscalls made by each process and the makeup of those calls for all pr=
ocesses
>> > simultaneously.
>> >
>> > [1] https://github.com/iovisor/bcc/blob/master/libbpf-tools/syscount.b=
pf.c
>>
>> Well, if you just want to count, map-in-map seems a bit overkill? You
>> could just do:
>>
>> struct {
>>   u32 pid;
>>   u32 syscall;
>> } map_key;
>>
>> and use that?
>>
>> -Toke
>>
>
> I have considered that, but maps in maps seem better for when I need to g=
et the
> data about a single process's syscalls: It requires reading only one of t=
he
> inner maps in its entirety. If I have a composite key like that, I don't =
see
> any way, other than:
>  * either iterating through all the possible keys for a process
>    (i.e. over all syscalls) and looking them up in the map, or
>  * iterating over all entries in the map and filtering them.
>
> Looking at it again, the first option does not seem _that_ bad,

You could even use BPF_MAP_LOOKUP_BATCH to do this in one operation, I
suppose...

> but just iterating over one (inner) map would be easier to fit into
> our use-case.

...but yeah, I see what you mean. Well, maybe BPF local storage per
process would also be a nice fit here?

-Toke

