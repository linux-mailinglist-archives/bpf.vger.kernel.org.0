Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74231487E39
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 22:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiAGV0M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 16:26:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229844AbiAGV0M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 16:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641590771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEom6dCmLIcTsU79bQD3UsRLJb8cL4jWdvGpIPwDe3M=;
        b=LRw9fUfq0zvbbk5KBs8lpdb2USzazk0JvnwiBGzd5WPnpxeYGcr3j05Pd+JIKrZeuhWqPm
        eXNpSBAMTbdUIrRlOIkvFprSNUe7+hbQWxk4ZIRv+/cyFW6HfeBzsKj+Py5GnBIOW3jFs/
        cEra1rBlmwyJLv4yEFh6JKt7m9C4nPY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-_EtO5TZSNUec8yQJdnjNpg-1; Fri, 07 Jan 2022 16:26:10 -0500
X-MC-Unique: _EtO5TZSNUec8yQJdnjNpg-1
Received: by mail-ed1-f69.google.com with SMTP id z10-20020a05640235ca00b003f8efab3342so5699241edc.2
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 13:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hEom6dCmLIcTsU79bQD3UsRLJb8cL4jWdvGpIPwDe3M=;
        b=HBj0iwj0mZK+lG8EKHzuMQ8rASDveE4NcWPQk/VbgCcEJeyzG0a+FjdEL5hnxTPzxT
         D7x8RP9HMgTriCAv0RsYevwQX3b8t03yXNtG2IcnXMY+gFdSvD84rEa44MHuX++OLKtB
         U70mC8zGhCc/Z+b0ZpRYymQHOiQxva7lQEMsH9mmpB33QY7i18v3Se5gfmmSQB4vCjnS
         x6SalWIDY7/zdE/Jdh4kV49mB38psIB4s8F8ziKPGd1b2rhXsgIO814Wr9BbeCZHG4CI
         ZeigfpCkEC5gC9nJPskSBLlH2RpnmvknvIyEreBRV+wZqhzx2yMVB0Uwgh9fCG0T2bxw
         EhLA==
X-Gm-Message-State: AOAM531haCvdZeaEWvXIbEgncgVNTCVhx4FTfcWE17eJoQ23WPD00BYv
        t+qjq1Itekxw11u/fuLidMigY+4ibJa2vnbgA2bjfXdfdJ21fjkthPURRobzfaqg5CwjnCcxKF1
        dahFbsjJltD5i
X-Received: by 2002:a50:ee97:: with SMTP id f23mr6557126edr.137.1641590769126;
        Fri, 07 Jan 2022 13:26:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0h2ytEMpMDcvXCmoKKVI3wUfae3b0rVYr/A3NcbZiGxyiTG3dSPCzztTV335pGlIQXoGhlQ==
X-Received: by 2002:a50:ee97:: with SMTP id f23mr6557103edr.137.1641590768866;
        Fri, 07 Jan 2022 13:26:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id la21sm346406ejc.137.2022.01.07.13.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:26:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CB401181F2A; Fri,  7 Jan 2022 22:26:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        syzbot+983941aa85af6ded1fd9@syzkaller.appspotmail.com,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] xdp: check prog type before updating BPF link
In-Reply-To: <CAEf4BzbRxwbJQFZHvB-hBj1A+364Jua4KJgkL+D_9PKsj7jKSg@mail.gmail.com>
References: <20220107183049.311134-1-toke@redhat.com>
 <CAEf4BzbRxwbJQFZHvB-hBj1A+364Jua4KJgkL+D_9PKsj7jKSg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 07 Jan 2022 22:26:07 +0100
Message-ID: <87sftz8cgg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Jan 7, 2022 at 10:31 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> The bpf_xdp_link_update() function didn't check the program type before
>> updating the program, which made it possible to install any program type=
 as
>> an XDP program, which is obviously not good. Syzbot managed to trigger t=
his
>> by swapping in an LWT program on the XDP hook which would crash in a hel=
per
>> call.
>>
>> Fix this by adding a check and bailing out if the types don't match.
>>
>> Fixes: 026a4c28e1db ("bpf, xdp: Implement LINK_UPDATE for BPF XDP link")
>> Reported-by: syzbot+983941aa85af6ded1fd9@syzkaller.appspotmail.com
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> The fix looks good to me, thanks. I'd love it if this was done
> generically in link_update, but each link type has its own locking
> schema for link->prog, so I didn't figure out a way to do this in a
> centralized way.

Yeah, moving it to be a generic check was my first thought as well, but
I came to the same conclusion :)

> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks!

-Toke

