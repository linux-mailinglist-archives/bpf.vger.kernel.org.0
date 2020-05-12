Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808481CEF36
	for <lists+bpf@lfdr.de>; Tue, 12 May 2020 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgELIfF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 May 2020 04:35:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58324 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725776AbgELIfF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 May 2020 04:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589272503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jcu7UayeiRoB+oPtxu5ro8xy76Yt5bLrrV9cfwYT0u4=;
        b=iJrsU4RpBOeI2JZmrs4gjEXDAw70a2sALlrFj6ODkZcIZf4xJsw1gbMamfgircUFcWQSPa
        5gBQUVEJHltE4NeJzJLMxXjg8SWozTG3kY5BUHaOZ2Qqy7M8FKzmvqpUT0R9K/fLkcg2RC
        wH8xk004Ln9Y4Wyqnz/dODXZfNMzOFg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-gg2d5kkjPOqJ0HCcMc0pWw-1; Tue, 12 May 2020 04:35:01 -0400
X-MC-Unique: gg2d5kkjPOqJ0HCcMc0pWw-1
Received: by mail-lj1-f197.google.com with SMTP id m15so1677943ljp.3
        for <bpf@vger.kernel.org>; Tue, 12 May 2020 01:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Jcu7UayeiRoB+oPtxu5ro8xy76Yt5bLrrV9cfwYT0u4=;
        b=V2U/1sBXLIQzZ/PxhGIw1G+7Jsz31xghBemQ4if5CQ5uaCDqrBTehv+509RRyEj4Xh
         3+gmcx52VM/HoevVP75DQdiL6uwb+pz1Ky4iJ1fejmiv/bkMLTgZ8CHtMNxzIIlVzNVA
         5XZ2Xs0ekG5KU7CXNOkOcs4sK9Vz/d6Ru3wdQwlEJtXlkc9fYiArkldOUEHmab2ACCR6
         8U7g68f5ixKsmc4Fb9eqhkqVL3C7hJXeTc9Aw4jc9vFKv7ayhpKuBcrmH+KBGMj8Btd/
         MeZNpGdmxE92rmB85Kfjy/AOxzp3deVHNXn8o61EO2rSDVWXjPdfVHaGnhk2K9ZscwLb
         XBzg==
X-Gm-Message-State: AOAM531Q9phGcjyKE5AoB/MwMHTCP5X5+HDzPfG7/tnce+Id/HDhnfrY
        ZEigU3jJJiUv7lCW/ZefiU9s3mBi1g6mIQIw3lRMOrzmzig9Rm+7F7lDjIt5H5ZMCi6TEAkKbPG
        2WFmTTzpreM6Z
X-Received: by 2002:a2e:986:: with SMTP id 128mr9515207ljj.202.1589272500502;
        Tue, 12 May 2020 01:35:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFmvdz9SAXFfdnegZZctpbgnZj5hHOIAXiFoVO8Ry9W+nleEprJxW5rdu/858LPlqtM/tnwQ==
X-Received: by 2002:a2e:986:: with SMTP id 128mr9515196ljj.202.1589272500266;
        Tue, 12 May 2020 01:35:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y9sm12081878ljy.31.2020.05.12.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 01:34:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BF311181509; Tue, 12 May 2020 10:34:58 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: bpf: ability to attach freplace to multiple parents
In-Reply-To: <20200402215452.dkkbbymnhzlcux7m@ast-mbp>
References: <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com> <87tv2e10ly.fsf@toke.dk> <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com> <87369wrcyv.fsf@toke.dk> <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com> <CACAyw9-FrwgBGjGT1CYrKJuyRJtwn0XUsifF_uR6LpRbcucN+A@mail.gmail.com> <20200326195340.dznktutm6yq763af@ast-mbp> <87o8sim4rw.fsf@toke.dk> <20200402202156.hq7wpz5vdoajpqp5@ast-mbp> <87o8s9eg5b.fsf@toke.dk> <20200402215452.dkkbbymnhzlcux7m@ast-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 12 May 2020 10:34:58 +0200
Message-ID: <87h7wlwnyl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

>> > Currently fentry/fexit/freplace progs have single prog->aux->linked_prog pointer.
>> > It just needs to become a linked list.
>> > The api extension could be like this:
>> > bpf_raw_tp_open(prog_fd, attach_prog_fd, attach_btf_id);
>> > (currently it's just bpf_raw_tp_open(prog_fd))
>> > The same pair of (attach_prog_fd, attach_btf_id) is already passed into prog_load
>> > to hold the linked_prog and its corresponding btf_id.
>> > I'm proposing to extend raw_tp_open with this pair as well to
>> > attach existing fentry/fexit/freplace prog to another target.
>> > Internally the kernel verify that btf of current linked_prog
>> > exactly matches to btf of another requested linked_prog and
>> > if they match it will attach the same prog to two target programs (in case of freplace)
>> > or two kernel functions (in case of fentry/fexit).
>> 
>> API-wise this was exactly what I had in mind as well.
>
> perfect!

Hi Alexei

I don't suppose you've had a chance to whip up a patch for this, have
you? :)

-Toke

