Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C544E25F59B
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 10:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgIGItJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 04:49:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26979 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728229AbgIGItG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 04:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599468545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RyuK4QheFNs+ZzxmRLfvINj0ku6nCHpjGbKxWgmmADk=;
        b=MY9613CHX18uT3MnaUbK7FK/EHrkjSqVE/C9pCYMy5NzckAmftRDyZfjyMgzDkfVjLeDFA
        n/9ZctSYeJyzJjdYg+2Vbi/q9l7C9wqm5vqAABkYCuApdjYyP8h+eLCJ9idNdEmDFfcZ0f
        HOD7ZIkWd6/lm8OxwKl9B3SDKFfg29U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-pd6vk9zxP_OJv4hHaWtRoA-1; Mon, 07 Sep 2020 04:49:03 -0400
X-MC-Unique: pd6vk9zxP_OJv4hHaWtRoA-1
Received: by mail-wm1-f70.google.com with SMTP id s24so2620656wmh.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 01:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RyuK4QheFNs+ZzxmRLfvINj0ku6nCHpjGbKxWgmmADk=;
        b=FD8iKKo286P8Km6qo/312USBiWIFbhbUqpcmIOS8TAtxOvYER3EfYyA7zfKFBE7F95
         eTwRqzEJJLkiqapG2cRXXhYRe9rMCgO85eNJKELpvys9+Xnu1WGSPK1nEijKa6mGkaTs
         s0xXMilFrZ51hFWCGg0iCZlrBVeEWSyDsaQuvGYng5sdebX2RWfxU00zvg+VdZZn7C/t
         B2v051gU0Nt25SohhF4fBiQqmRIxTKDeEpynhoPjO8YEYAW/06EvwNkQo8GZkNRNhk2/
         iccElkL+A3Fn/e/0h8p8rEy8aYs2k71lCp0ye/Byzq7+zIZFRDqVc/edbwONrT2bqZ67
         Vrew==
X-Gm-Message-State: AOAM530f8CVaHlqYHOmjzRJ6kbEIIdq+JYuyzGUQZ61x7hRsOymPVLWz
        oLQCnYLfQU0/I8d6ymZ5aPX3LAboI4en9G4KpsL7uHR6IIVG6kl7xFrPdQ3mL3dMX547TC1X0nD
        OMVhR8sj782S8
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr21255463wrj.92.1599468542283;
        Mon, 07 Sep 2020 01:49:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqcqexWNGCJc6p20AynkOEQeme23ZbVnd40KRuFY0Z6fGMqlUuXaSqHbyECjS5GsllJaaJ4g==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr21255446wrj.92.1599468542093;
        Mon, 07 Sep 2020 01:49:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h186sm26638375wmf.24.2020.09.07.01.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 01:49:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ECF78180497; Mon,  7 Sep 2020 10:49:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        YiFei Zhu <zhuyifei@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Andrey Ignatov <rdna@fb.com>
Subject: Re: [PATCH bpf-next v3 3/8] libbpf: Add BPF_PROG_BIND_MAP syscall
 and use it on .metadata section
In-Reply-To: <CAEf4BzZp4ODLbjEiv=W7byoR9XzTqAQ052wZM_wD4=aTPmkjbw@mail.gmail.com>
References: <20200828193603.335512-1-sdf@google.com>
 <20200828193603.335512-4-sdf@google.com>
 <CAEf4BzZtYTyBT=jURkF4RQLHXORooVwXrRRRkoSWDqCemyGQeA@mail.gmail.com>
 <20200904012909.c7cx5adhy5f23ovo@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzZp4ODLbjEiv=W7byoR9XzTqAQ052wZM_wD4=aTPmkjbw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 07 Sep 2020 10:49:00 +0200
Message-ID: <87mu22ottv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

>> May be we should talk about problem statement and goals.
>> Do we actually need metadata per program or metadata per single .o
>> or metadata per final .o with multiple .o linked together?
>> What is this metadata?
>
> Yep, that's a very valid question. I've also CC'ed Andrey.

For the libxdp use case, I need metadata per program. But I'm already
sticking that in a single section and disambiguating by struct name
(just prefixing the function name with a _ ), so I think it's fine to
have this kind of "concatenated metadata" per elf file and parse out the
per-program information from that. This is similar to the BTF-encoded
"metadata" we can do today.

>> If it's just unreferenced by program read only data then no special names or
>> prefixes are needed. We can introduce BPF_PROG_BIND_MAP to bind any map to any
>> program and it would be up to tooling to decide the meaning of the data in the
>> map. For example, bpftool can choose to print all variables from all read only
>> maps that match "bpf_metadata_" prefix, but it will be bpftool convention only
>> and not hard coded in libbpf.
>
> Agree as well. It feels a bit odd for libbpf to handle ".metadata"
> specially, given libbpf itself doesn't care about its contents at all.
>
> So thanks for bringing this up, I think this is an important
> discussion to have.

I'm fine with having this be part of .rodata. One drawback, though, is
that if any metadata is defined, it becomes a bit more complicated to
use bpf_map__set_initial_value() because that now also has to include
the metadata. Any way we can improve upon that?

-Toke

