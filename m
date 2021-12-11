Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A4D471546
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 19:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhLKSIE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Dec 2021 13:08:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230024AbhLKSH7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 11 Dec 2021 13:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639246078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxsp9HMeNtoKt/pFNzallH86Zw4trkvvgTKYXFAZ8jg=;
        b=cMdvAblGHpVB+xSYQBiKJo2wWN0jRp1HANltCeNS9Hh4WmqcN48RvF/AXYXHSNpdU6NDHT
        mJqnBpERj5b3m/mSJL+IOkczNhg6j3pqv64HcMnPJsgpcQ7naWD0L6PeiQgykXlgXLSSM+
        uPWHQM4JVr6bP0hJQZ5KFfaW/zxKOrU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-l_yK9qXvNBqLINK1D4_3TA-1; Sat, 11 Dec 2021 13:07:57 -0500
X-MC-Unique: l_yK9qXvNBqLINK1D4_3TA-1
Received: by mail-ed1-f71.google.com with SMTP id w5-20020a05640234c500b003f1b9ab06d2so10791877edc.13
        for <bpf@vger.kernel.org>; Sat, 11 Dec 2021 10:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fxsp9HMeNtoKt/pFNzallH86Zw4trkvvgTKYXFAZ8jg=;
        b=iW9FYg99UnujVWchkYwODiqsEZmRFNsQXhGdWycc8PAD44z1C8euAdKcMHj8Dyp4vi
         AcLV+TN1az47XBvd6DvI5VJgJ2c2bfWz7HM+NFKxv+SQ7G4T4XHS1vDs4agKUwmhLTHp
         rSQaPcuVjp3M/VsgqR/HSPBBlPDe7rbcMnRvddlL7WCjwqkmpLRg67qW96O/xe2KVjAN
         +SdsIcL7MeICwxB/g/SsZrqQJ4dW8IZrSGRndoCJMjWYUge23vFqqepox0GqofPH39rN
         mmx2isuqOr/8weZNNqxJKa7ADgotG6cL/YXHClYN8rc9iLIpxe5x68vISx2BTKLnh2Ay
         Mgmg==
X-Gm-Message-State: AOAM532TazhGHANmogXp40ldYsDjvay9r6lJ51xM9lhvtN1oTu5xkvbQ
        Ts5nmKUusXBAXRhvVdy1oULs85Qtd60iVqqoYONpEY8gib7KyBFTA0JoKssBuRMHYm5/h9lfDaV
        uv7NVksWi+yyz
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr48825316edc.373.1639246074180;
        Sat, 11 Dec 2021 10:07:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmtuRu9IIGsJRm7VLPbqM73bHk2TxaMBH4XL764mJtXwub90GMZUqJA6TwherwcvopC10EVA==
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr48825147edc.373.1639246072480;
        Sat, 11 Dec 2021 10:07:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id go10sm3302346ejc.115.2021.12.11.10.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 10:07:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 266C3180471; Sat, 11 Dec 2021 19:07:48 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yihao Han <hanyihao@vivo.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH v2] samples/bpf: xdpsock: fix swap.cocci warning
In-Reply-To: <CAEf4Bza3a88pdhFEQdR-FnT_gBPqBh+KL-OP-1P3bVfXv=Gbaw@mail.gmail.com>
References: <20211209092250.56430-1-hanyihao@vivo.com>
 <877dccwn6x.fsf@toke.dk>
 <CAEf4Bza3a88pdhFEQdR-FnT_gBPqBh+KL-OP-1P3bVfXv=Gbaw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 11 Dec 2021 19:07:48 +0100
Message-ID: <87sfuzuia3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Dec 10, 2021 at 6:26 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Yihao Han <hanyihao@vivo.com> writes:
>>
>> > Fix following swap.cocci warning:
>> > ./samples/bpf/xdpsock_user.c:528:22-23:
>> > WARNING opportunity for swap()
>> >
>> > Signed-off-by: Yihao Han <hanyihao@vivo.com>
>>
>> Erm, did this get applied without anyone actually trying to compile
>> samples? I'm getting build errors as:
>
> Good news: I actually do build samples/bpf nowadays after fixing a
> bunch of compilation issues recently.

Awesome!

> Bad news: seems like I didn't pay too much attention after building
> samples/bpf for this particular patch, sorry about that. I've dropped
> this patch, samples/bpf builds for me. We should be good now.

Yup, looks good, thanks!

>>   CC  /home/build/linux/samples/bpf/xsk_fwd.o
>> /home/build/linux/samples/bpf/xsk_fwd.c: In function =E2=80=98swap_mac_a=
ddresses=E2=80=99:
>> /home/build/linux/samples/bpf/xsk_fwd.c:658:9: warning: implicit declara=
tion of function =E2=80=98swap=E2=80=99; did you mean =E2=80=98swab=E2=80=
=99? [-Wimplicit-function-declaration]
>>   658 |         swap(*src_addr, *dst_addr);
>>       |         ^~~~
>>       |         swab
>>
>> /usr/bin/ld: /home/build/linux/samples/bpf/xsk_fwd.o: in function `threa=
d_func':
>> xsk_fwd.c:(.text+0x440): undefined reference to `swap'
>> collect2: error: ld returned 1 exit status
>>
>>
>> Could we maybe get samples/bpf added to the BPF CI builds? :)
>
> Maybe we could, if someone dedicated their effort towards making this
> happen.

Is it documented anywhere what that would entail? Is it just a matter of
submitting a change to https://github.com/kernel-patches/vmtest ?

-Toke

