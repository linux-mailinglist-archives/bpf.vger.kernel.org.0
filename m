Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3225E262D83
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 12:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIIK7k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 06:59:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45276 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727087AbgIIK6f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 06:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599649113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlbYS18H011Iq6ivG1CppQuP+eHDYG6ZaZ6anysk7ww=;
        b=g+O1eVbQEFhKuBHYjyC9tTRDVZsnR4vvrbBkonuGgNweEJwn35ZQr8M7r43yiHw8ob+JKU
        LnmIadYuZ3pMKIzLhXr6ois518NmKGbee8CuyOXik2a7mLGvhN+5F5cLMBV3e0yUG0rgJe
        fEQpaD9yr7VHFMzFFAcTB/BTGEGk3Y0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-hv5f6PvgPYeZfsbKrBxE2A-1; Wed, 09 Sep 2020 06:58:31 -0400
X-MC-Unique: hv5f6PvgPYeZfsbKrBxE2A-1
Received: by mail-wm1-f71.google.com with SMTP id s24so703318wmh.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 03:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=UlbYS18H011Iq6ivG1CppQuP+eHDYG6ZaZ6anysk7ww=;
        b=IbVZKffYTm3EKwkTn7uPxhmr8/dV9GoNqK3xjyGSCyXq8+dcWsWx95nPpbPZpN1eeO
         JKYhU/IaQy+9/8zqsRfXJRLgLYa5LEUNOLzzUOL8UUzIdyKitykrgTUZG1ONcVQYXF5M
         Ho0gBsw9IsI5ntM5b9Fc5/e5kLw0ueXUWwB7inLmTIKUUquN8lWiC0jb6ERHdh9lRuAX
         8rt5HZH7TtG1p9RCigl9jCoKacyxQ1vi/d6MyffDoC/4RjCrjv0J5uNBRIkPuGamwLT/
         xJY7YSVJ0BHi9TytRjFWaOMT8FIXWVQKq7G3T+0maUifwBQluJRgPJCyyWTv6LLQUp4r
         uUKw==
X-Gm-Message-State: AOAM531Buqb8twH2cq3u2WCv4AoTf66gvi6v67Rqn8rd2Ev9EL4O4U20
        i88rv0WzKFBLAAwSOiJv/mofyCtPPgynXaDjZG7hYbcoP6mAF8AaMCnhkXeEz4MJ1N0B5+J7e2I
        +5uPTt/btCKE8
X-Received: by 2002:a1c:c256:: with SMTP id s83mr2997888wmf.93.1599649110646;
        Wed, 09 Sep 2020 03:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPISmCR4dgdVvk6g3iPoqMbDlKb6d0IuqTgppoeZFwa/r+l0GbHaZdcetlBRX8jYunT+93tQ==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr2997872wmf.93.1599649110401;
        Wed, 09 Sep 2020 03:58:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2sm3694235wrs.64.2020.09.09.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 03:58:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 307B51829D4; Wed,  9 Sep 2020 12:58:29 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        YiFei Zhu <zhuyifei@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Andrey Ignatov <rdna@fb.com>
Subject: Re: [PATCH bpf-next v3 3/8] libbpf: Add BPF_PROG_BIND_MAP syscall
 and use it on .metadata section
In-Reply-To: <CAEf4BzbywFBSW+KypeWkG7CF8rNSu5XxS8HZz7BFuUsC9kZ1ug@mail.gmail.com>
References: <20200828193603.335512-1-sdf@google.com>
 <20200828193603.335512-4-sdf@google.com>
 <CAEf4BzZtYTyBT=jURkF4RQLHXORooVwXrRRRkoSWDqCemyGQeA@mail.gmail.com>
 <20200904012909.c7cx5adhy5f23ovo@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzZp4ODLbjEiv=W7byoR9XzTqAQ052wZM_wD4=aTPmkjbw@mail.gmail.com>
 <87mu22ottv.fsf@toke.dk>
 <CAEf4BzbywFBSW+KypeWkG7CF8rNSu5XxS8HZz7BFuUsC9kZ1ug@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 09 Sep 2020 12:58:29 +0200
Message-ID: <87eenbnrmy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Sep 7, 2020 at 1:49 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> >> May be we should talk about problem statement and goals.
>> >> Do we actually need metadata per program or metadata per single .o
>> >> or metadata per final .o with multiple .o linked together?
>> >> What is this metadata?
>> >
>> > Yep, that's a very valid question. I've also CC'ed Andrey.
>>
>> For the libxdp use case, I need metadata per program. But I'm already
>> sticking that in a single section and disambiguating by struct name
>> (just prefixing the function name with a _ ), so I think it's fine to
>> have this kind of "concatenated metadata" per elf file and parse out the
>> per-program information from that. This is similar to the BTF-encoded
>> "metadata" we can do today.
>>
>> >> If it's just unreferenced by program read only data then no special n=
ames or
>> >> prefixes are needed. We can introduce BPF_PROG_BIND_MAP to bind any m=
ap to any
>> >> program and it would be up to tooling to decide the meaning of the da=
ta in the
>> >> map. For example, bpftool can choose to print all variables from all =
read only
>> >> maps that match "bpf_metadata_" prefix, but it will be bpftool conven=
tion only
>> >> and not hard coded in libbpf.
>> >
>> > Agree as well. It feels a bit odd for libbpf to handle ".metadata"
>> > specially, given libbpf itself doesn't care about its contents at all.
>> >
>> > So thanks for bringing this up, I think this is an important
>> > discussion to have.
>>
>> I'm fine with having this be part of .rodata. One drawback, though, is
>> that if any metadata is defined, it becomes a bit more complicated to
>> use bpf_map__set_initial_value() because that now also has to include
>> the metadata. Any way we can improve upon that?
>
> I know that skeleton is not an answer for you, so you'll have to find
> DATASEC and corresponding variable offset and size (libbpf provides
> APIs for all those operations, but you'll need to combine them
> together). Then mmap() map and then you can do partial updates. There
> is no other way to update only portions of an ARRAY map, except
> through memory-mapping.

Well, I wouldn't mind having to go digging through the section. But is
it really possible to pick out and modify parts of it my mmap() before
the object is loaded (and the map frozen)? How? I seem to recall we
added bpf_map__set_initial_value() because this was *not* possible with
the public API?

Also, for this, a bpf_map__get_initial_value() could be a simple way to
allow partial modifications. The caller could just get the whole map
value, modify it, and set it again afterwards with
__set_initial_value(). Any objections to adding that?

-Toke

