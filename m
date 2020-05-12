Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA6C1CF52C
	for <lists+bpf@lfdr.de>; Tue, 12 May 2020 15:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgELNCy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 May 2020 09:02:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60279 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725923AbgELNCx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 May 2020 09:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589288571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHy5uGJufwajym7rdjrv9kV8JNPYEhlwWl3JM7PucCY=;
        b=J/hp0fpS/3peFIOtEVXxg6DZqt2et6LZViqDGrUxW8B8tt164YxtCPI/YD6C4LXMreGO4I
        ucE73db3mwVvRvYJRKFns3pbF9tGwWiadONyUPenAdKddEU7evbXLdiChHM9jYcOit/Hg3
        w751mHee67rtxQNxPi+1kXTnuG/2R/U=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-YXCoDabvNkSuuFOzF15ECg-1; Tue, 12 May 2020 09:02:50 -0400
X-MC-Unique: YXCoDabvNkSuuFOzF15ECg-1
Received: by mail-lj1-f200.google.com with SMTP id k15so1876229ljj.5
        for <bpf@vger.kernel.org>; Tue, 12 May 2020 06:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FHy5uGJufwajym7rdjrv9kV8JNPYEhlwWl3JM7PucCY=;
        b=pQ+EB2zE1kcrO2exJ/93pAEJBkDWDQqoNyouR7w67FnAYbxDifNKNMpxXuH61V4SNi
         uFgueS5S/kgvLJUJDzrZmN2FVYd4qlsXtkLcXPvXxtaMhJd9Re8ixqUswT4BHLB/EGpV
         rFnJ6606bnlvQEfzvvJCGSelQ399E7SbdfyJlixxAtRGNzWpdU1cS5Ulcj7QKHbBXopb
         e58k2lIcZRX0ZVjKcwgx3E9OH2tQIz+Vy3X2G35kGfx3DvrnpVegYNHySMvHzKcKzn2t
         lgv+Qu6m7XTyEt06v59ktEh1tSuwQZwvDSyDaDNFb62XBs7u55f7LMz9js5qG5FBgQWB
         T9Iw==
X-Gm-Message-State: AOAM531ylSZPa2ZYnNBix9s6aPgXn9f3mCvz5LxC/urVcyFlwzfGMS0s
        +X5YUHQRZ/839c2bzBgYs0mavdUuBW9ewGuuUASDegDlKE0PE106XxrK/o3RN5edWZm0sLwb1Wn
        YHdXTeyP9suX1
X-Received: by 2002:a2e:7d12:: with SMTP id y18mr14072014ljc.211.1589288565979;
        Tue, 12 May 2020 06:02:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw//hj7tAEVjb/rIsYU5rJTYqMEdazOE6/ECf5hTxekXy1ChR/FmjGiMg3QXRzt8dMPWQkstg==
X-Received: by 2002:a2e:7d12:: with SMTP id y18mr14071998ljc.211.1589288565675;
        Tue, 12 May 2020 06:02:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y9sm12667048ljy.31.2020.05.12.06.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:02:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0E1D9181509; Tue, 12 May 2020 15:02:43 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: bpf: ability to attach freplace to multiple parents
In-Reply-To: <alpine.LRH.2.21.2005121009220.22093@localhost>
References: <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com> <87tv2e10ly.fsf@toke.dk> <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com> <87369wrcyv.fsf@toke.dk> <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com> <CACAyw9-FrwgBGjGT1CYrKJuyRJtwn0XUsifF_uR6LpRbcucN+A@mail.gmail.com> <20200326195340.dznktutm6yq763af@ast-mbp> <87o8sim4rw.fsf@toke.dk> <20200402202156.hq7wpz5vdoajpqp5@ast-mbp> <87o8s9eg5b.fsf@toke.dk> <20200402215452.dkkbbymnhzlcux7m@ast-mbp> <87h7wlwnyl.fsf@toke.dk> <alpine.LRH.2.21.2005121009220.22093@localhost>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 12 May 2020 15:02:42 +0200
Message-ID: <87r1vpuwzx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alan Maguire <alan.maguire@oracle.com> writes:

> On Tue, 12 May 2020, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>=20
>> >> > Currently fentry/fexit/freplace progs have single prog->aux->linked=
_prog pointer.
>> >> > It just needs to become a linked list.
>> >> > The api extension could be like this:
>> >> > bpf_raw_tp_open(prog_fd, attach_prog_fd, attach_btf_id);
>> >> > (currently it's just bpf_raw_tp_open(prog_fd))
>> >> > The same pair of (attach_prog_fd, attach_btf_id) is already passed =
into prog_load
>> >> > to hold the linked_prog and its corresponding btf_id.
>> >> > I'm proposing to extend raw_tp_open with this pair as well to
>> >> > attach existing fentry/fexit/freplace prog to another target.
>> >> > Internally the kernel verify that btf of current linked_prog
>> >> > exactly matches to btf of another requested linked_prog and
>> >> > if they match it will attach the same prog to two target programs (=
in case of freplace)
>> >> > or two kernel functions (in case of fentry/fexit).
>> >>=20
>> >> API-wise this was exactly what I had in mind as well.
>> >
>> > perfect!
>>
>
> Apologies in advance if I've missed a way to do this, but
> for fentry/fexit, if we could attach the same program to
> multiple kernel functions, it would be great it we could
> programmatically access the BTF func proto id for the
> attached function (prog->aux->attach_btf_id I think?).

Yes! I pushed for adding this to the GET_LINK_INFO operation, but it
wasn't included the first time around; I still think it ought to be added.

Actually in general, getting the btf_id of the currently running
function for any type of BPF program would be good; e.g., for xdpdump we
want to attach to a running XDP program, but we need the btf_id of the
main function. And because the name can be truncated to BPF_OBJ_NAME_LEN
when returned from the kernel, we have to walk the BTF info for the
program, and basically guess...

-Toke

