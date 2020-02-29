Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4A117463B
	for <lists+bpf@lfdr.de>; Sat, 29 Feb 2020 11:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgB2Khk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 Feb 2020 05:37:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55183 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726809AbgB2Khj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Feb 2020 05:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582972657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8u7jXv2qhhtEzwiGsMt8eapSSfx6lCwcuLjHW90uxZQ=;
        b=TRo4YOT1GzaMNo0JheAigz2WwcC5yD50neu/d/IyrHjEH62cZ/G9TTdwMb/F4EjyxlRpvk
        +SINj3fJfGpi2b+drxYZhW9rv0DfyjO9gTm2AiDkiYgXWn16uTi5cFK1uk1kaIaqeQaBJa
        2vaVNpHE000GyHQMbqoZHqPzMpsrSmg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-4L-U2ovmNjWQ5AB_Fbey_Q-1; Sat, 29 Feb 2020 05:37:30 -0500
X-MC-Unique: 4L-U2ovmNjWQ5AB_Fbey_Q-1
Received: by mail-wm1-f69.google.com with SMTP id r19so1832911wmh.1
        for <bpf@vger.kernel.org>; Sat, 29 Feb 2020 02:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8u7jXv2qhhtEzwiGsMt8eapSSfx6lCwcuLjHW90uxZQ=;
        b=JwwjYXhB+LMPnY4wjc5bajMAncMdX83Ks6VQmKxXl+P69yCQg+mSD22e7r0+7L4YFQ
         D8aEN9Js051TAx3HUA/GGgf7J8g/Cds/96D0x5U5RtT2W+AfG3bW33tExSAUouBlra7c
         ggMkSWJ2KS2n9cMlpU/hwd1mlAWNGpR4I/u1ExHkPDIEVuRaHviszoGVT5j3Td0Nzw31
         aJSGPKCOBD8m0PaAHNf6R+EJmyuH0xIXDSxSG6Kss2RRuyINnswi/SNLhfHXMA6KjR9i
         6+wMLQp9cC9ZHqe1DOkYtRipUuArA1G67h8boNovNvnjInhfW32lxAMDnk02uUl/4l9j
         J9sg==
X-Gm-Message-State: APjAAAVfGYl5MlhknmE4WMOk4mwNPwdCdM8NTMBzvIP4qx2+CXfEZJ0U
        55hJaSTFp629huRGGSyNhlhh5CCEky6+2xDhWW6wKnpOJiFcgyz3Jq8wktzqTjUbL7OO+TFuhwo
        c5cS+hVwttKUQ
X-Received: by 2002:adf:ffcb:: with SMTP id x11mr9966972wrs.367.1582972649603;
        Sat, 29 Feb 2020 02:37:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpjfoeXTVsCs7yYwr8FL5KPh0cz0jRGDeDcYxGWVBFbLy+WCuHWckSdUPCJukOzdjhHLRMFg==
X-Received: by 2002:adf:ffcb:: with SMTP id x11mr9966949wrs.367.1582972649363;
        Sat, 29 Feb 2020 02:37:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c9sm5869600wmc.47.2020.02.29.02.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 02:37:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 482F6180362; Sat, 29 Feb 2020 11:37:28 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC] Userspace library for handling multiple XDP programs on an interface
In-Reply-To: <CAEf4Bzaqr2uZca2iZvRpz54C-ohLsNK1sdN8daBr1qkRQ+NhWg@mail.gmail.com>
References: <158289973977.337029.3637846294079508848.stgit@toke.dk> <CAEf4Bzaqr2uZca2iZvRpz54C-ohLsNK1sdN8daBr1qkRQ+NhWg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 29 Feb 2020 11:37:28 +0100
Message-ID: <87sgitu1av.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Feb 28, 2020 at 6:22 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Hi everyone
>>
>> As most of you are no doubt aware, we've had various discussions on how
>> to handle multiple XDP programs on a single interface. With the freplace
>> functionality, the kernel infrastructure is now there to handle this
>> (almost, see "missing pieces" below).
>>
>> While the freplace mechanism offers userspace a lot of flexibility in
>> how to handle dispatching of multiple XDP programs, userspace also has
>> to do quite a bit of work to implement this (compared to just issuing
>> load+attach). The goal of this email is to get some feedback on a
>> library to implement this, in the hope that we can converge on something
>> that will be widely applicable, ensuring that both (a) everyone doesn't
>> have to reinvent the wheel, and (b) we don't end up with a proliferation
>> of subtly incompatible dispatcher models that makes it hard or
>> impossible to mix and match XDP programs from multiple sources.
>>
>
> [...]
>
>>
>> **** Missing pieces
>> While the libxdp code can assemble a basic dispatcher and load it into t=
he
>> kernel, there are a couple of missing pieces on the kernel side; I will =
propose
>> patches to fix these, but figured there was no reason to hold back posti=
ng of
>> the library for comments because of this. These missing pieces are:
>>
>> - There is currently no way to persist the freplace after the program ex=
its; the
>>   file descriptor returned by bpf_raw_tracepoint_open() will release the=
 program
>>   when it is closed, and it cannot be pinned.
>
> This is completely addressed by patch set [0] I just posted. It will
> allow you to pin freplace BPF link in BPF FS. Feel free to review and
> comment there, if anything is missing.
>
>   [0]
>   https://patchwork.ozlabs.org/project/netdev/list/?series=3D161582&state=
=3D*

Ah, excellent! I'll take a look, thanks for the pointer :)

-Toke

