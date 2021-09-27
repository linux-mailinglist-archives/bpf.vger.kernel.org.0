Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4DA41986A
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhI0QDP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 12:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235345AbhI0QDN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Sep 2021 12:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632758494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zExPlJIZ2FYbGOJNvq3oGtYGHJadUybqtiVq6T7E0P8=;
        b=MbbocOQGtt9PgERDRGFNVyz/IxnwldaCCk6tRdr9AX+3+Lvr5ov4cCnysH8wAiVQMmSawt
        WbJV6R/TMkn+9ctIpvQUvpyxxM2XnjBuKPbxNMb5vOxdNZuC0coHye/Kz/whTfTRpKwm7z
        SNiD7OcvO/CmXI1PVa5LkHVSKUlBbSw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-bwiIMnN2MGalFVKP5C2Znw-1; Mon, 27 Sep 2021 12:01:33 -0400
X-MC-Unique: bwiIMnN2MGalFVKP5C2Znw-1
Received: by mail-ed1-f71.google.com with SMTP id h15-20020aa7de0f000000b003d02f9592d6so18254871edv.17
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 09:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zExPlJIZ2FYbGOJNvq3oGtYGHJadUybqtiVq6T7E0P8=;
        b=TaFT/KUeRt4ByFT/JKGLZymQtPj7IA5kjyFHh4d/SOF3/IHeS0CJE34bzQV7KybBvb
         0R4egOPKAZ9tQKCOuNwvJfdHAml3ie777f94qN0jb5oXq/+CQPWqSO/mvMALNSqc1b6Q
         Y1vU7HdymTlZvMx3ul2av4XYhbgS3tD4qwGtxRhpe4RuMbrW+TVWKS4aT2wLb9sYZsWi
         UjdUI4QOWktfErd2lm9BePLvbld4rG4mIkAH5a21X5FEmFTMSI7ONsPptS2bV4ncxfRD
         jZuXYt1G4STpsoOcyDHcSWA2mxe12LY9CjXPqj5xWuZUqxqQAiScsNwb/BzXQdJW0KiU
         nngw==
X-Gm-Message-State: AOAM5314pQri5Fl79Cxsm2mfZDcyrqljE/Ui7NaSDtR/va5UVlIOwjqY
        S3d5DtYvTFznqiNHWv9fj2ff8YDjSvwVI8qcMw2CtQ5D234FcC6rFFHPBsRUTxStPbm9OmDYSWH
        kLtno9oj1PhFU
X-Received: by 2002:a17:906:c1c9:: with SMTP id bw9mr881564ejb.3.1632758491002;
        Mon, 27 Sep 2021 09:01:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjdne5kVFhj0nIsgvqXim6GEbYAXqHlg9Gknp5laAa4W3YM7h/IP0AhDMa56VtHm3rhsOpxg==
X-Received: by 2002:a17:906:c1c9:: with SMTP id bw9mr881450ejb.3.1632758489978;
        Mon, 27 Sep 2021 09:01:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w11sm11133076edl.12.2021.09.27.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:01:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7CF8618034A; Mon, 27 Sep 2021 18:01:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] samples: bpf: avoid name collision with kernel
 enum values
In-Reply-To: <20210927134629.4cnzf25dfbprxwbc@apollo.localdomain>
References: <20210926125605.1101605-1-memxor@gmail.com>
 <87sfxqjit1.fsf@toke.dk>
 <20210927134629.4cnzf25dfbprxwbc@apollo.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 27 Sep 2021 18:01:27 +0200
Message-ID: <87mtnyj9d4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Mon, Sep 27, 2021 at 06:07:30PM IST, Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
>> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>>
>> > In xdp_redirect_map_multi.bpf.c, on newer kernels samples compilation
>> > fails when vmlinux.h is generated from a kernel supporting broadcast f=
or
>> > devmap. Hence, avoid naming collisions to prevent build failure.
>>
>> Hmm, shouldn't the sample just be getting the value from the kernel in
>> the first place instead of re-defining it?
>>
>
> True, but in general my assumption was that it could be built with a older
> kernel's vmlinux.h, but be ran on a newer one. If that's not strictly nee=
ded, I
> can just drop it.

But the code is still making assumptions about the contents of
vmlinux.h, isn't it? Like the size (and existence) of struct
bpf_devmap_val.

> This can also be the case if you haven't built the kernel in the tree
> (just did a make headers_install), it then falls back to generating
> the vmlinux.h from the running kernel.

This seems a bit brittle. Given that the samples are distributed with
the kernel sources, I would expect them to always correspond to the
kernel version in the source tree they're in and not randomly break if
the running kernel is different...

-Toke

