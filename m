Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD14181B1A
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 15:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgCKOYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 10:24:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37888 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729531AbgCKOYa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 10:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583936668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ean4ZugNCPunVrYnyIKydjAnQQVLWxvr2G7WqxQbr5I=;
        b=hqbEQDsmP+k3EwxKjIVeZSoG7ne1QD/hf0RgBah9JjCIu0AqZiSK87ba0w9BN0lSWJ/FVA
        uHisNbBCpPRVu5PwLlNq01PPtCYDUqK2v4oRR+EeS1oPmQb0KxPbrB7yWrWeAEBaOUnwaB
        HiA4//SfkGiKKTvRGjSo23pvq70TI8Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-N1L5QXhsPLGw3K0npm6FBw-1; Wed, 11 Mar 2020 10:24:27 -0400
X-MC-Unique: N1L5QXhsPLGw3K0npm6FBw-1
Received: by mail-wm1-f70.google.com with SMTP id z14so717721wmc.7
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 07:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ean4ZugNCPunVrYnyIKydjAnQQVLWxvr2G7WqxQbr5I=;
        b=DkPe1q8JeLK4hsa7adDqMLdWGSk8K+mjy51GNhbAX/uqrBhkmTkMPv7Jk4duqjfTwz
         vaJwFFy1cAyxcreLWDFauuEaz1nqn/uhcwUecHJ79nhCujER0NAZnslfeXqcbIrzk9Tw
         tSoxUq/t1i1hPlaQnkHoB/ZRyrHTnEYjC3Um6c36uiD2GbOyoA4b/tjU1kIJtQ1s0Hwv
         Pnm33F8Fp7VVz/c9yjwg7+f21WTkp2H/z8m31Z/pZNCMQRTb4oUS8C1tRzAEddTYbibc
         kg6Sn5m4T2lvx8fJNd5KIeEYh2tZ459cq/BlhEWZK2Ej9aiVv4B0Q68ZMW2ET8brhEE0
         K39w==
X-Gm-Message-State: ANhLgQ0o+s8XVjXDs4q5Bg+7F9yK2j0sFnex7tsxNHedm+KZ82ThCf77
        TRyxUjBzPlFX7PHpnGY9NRqzmw2SxLJAiyWnJ/VtGXc6dFXdYEq7eJckgVsYDE1eL3oKZAuhqnL
        NYeYAUOa+KfeK
X-Received: by 2002:a05:6000:18f:: with SMTP id p15mr5106803wrx.149.1583936666052;
        Wed, 11 Mar 2020 07:24:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsqnlWI2MB/mNPVYjW3acH2VZvHJ8sKRtAAGmCMzFgCimcdpdVPbjfz2d0oU8wVMYCqhsGH7w==
X-Received: by 2002:a05:6000:18f:: with SMTP id p15mr5106791wrx.149.1583936665887;
        Wed, 11 Mar 2020 07:24:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a9sm24296239wrv.59.2020.03.11.07.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 07:24:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9932B18033D; Wed, 11 Mar 2020 15:24:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] bpftool: fix iprofiler build on systems without /usr/include/asm symlink
In-Reply-To: <20200311125336.3gatuo6tr7l5unog@distanz.ch>
References: <20200311123421.3634-1-tklauser@distanz.ch> <87tv2voy32.fsf@toke.dk> <20200311125336.3gatuo6tr7l5unog@distanz.ch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Mar 2020 15:24:23 +0100
Message-ID: <87ftefotpk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tobias Klauser <tklauser@distanz.ch> writes:

> On 2020-03-11 at 13:49:53 +0100, Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>> Tobias Klauser <tklauser@distanz.ch> writes:
>>=20
>> > When compiling bpftool on a system where the /usr/include/asm symlink
>> > doesn't exist (e.g. on an Ubuntu system without gcc-multilib installed=
),
>> > the build fails with:
>> >
>> >     CLANG    skeleton/profiler.bpf.o
>> >   In file included from skeleton/profiler.bpf.c:4:
>> >   In file included from /usr/include/linux/bpf.h:11:
>> >   /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not=
 found
>> >   #include <asm/types.h>
>> >            ^~~~~~~~~~~~~
>> >   1 error generated.
>> >   make: *** [Makefile:123: skeleton/profiler.bpf.o] Error 1
>> >
>> > To fix this, add /usr/include/$(uname -m)-linux-gnu to the clang search
>> > path so <asm/types.h> can be found.
>>=20
>> Isn't the right thing here to just install gcc-multilib?
>
> For a container build we would like to avoid installing gcc-multilib
> which pulls in additional dependencies which are otherwise not needed to
> build bpftool. This patch would allow that.

Ah, right. Well, stating that use case in the commit message would have
been nice :)

I'm personally a little skeptical about having to add this (how many
weird build systems should we support?), but I can also see where you're
coming from. Up to the maintainers, I suppose...

-Toke

