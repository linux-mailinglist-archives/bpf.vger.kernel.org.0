Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9698E1EC46F
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 23:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFBVkz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 17:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbgFBVky (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 17:40:54 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0C3C08C5C1
        for <bpf@vger.kernel.org>; Tue,  2 Jun 2020 14:40:54 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o5so12416665iow.8
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2020 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kj7keYGQqsPFUGJ4IspW1DSv529RrBzaS7eq80XqkFk=;
        b=h8j6mCBLTU5MHednR5EKAgNz08DLxcNHiXfB0YEodroWDk5V8e6wtxcligwq1prLOs
         Rbr27EZbtguEZZkoQG/O69ZgIldribxkxf5T2vbf5W5dxGWOmaUW0QDEPMpsA0RE/FEb
         bNswzEH1EDtVgC8R8nG9bltliP3UcEptvp5JfUG/hlKN4XFGGGi00s2nyk+W6doaOkwM
         VviVdbH6A7ZFscoqTjsMKBwaVyLL0c/HEgv6qnLsPcZSziKXzQNHVyUJj9c+cOZVKgIZ
         dDeZH6eh/UpuGCgb4eVEBQqrq+2/TFokpNINbukuVAbOObtf+HiYpk05xh84VRQ4qFqt
         sWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kj7keYGQqsPFUGJ4IspW1DSv529RrBzaS7eq80XqkFk=;
        b=E1CE7pOEB8QlrGCqktj+0L1zDZ6kSlxfKYZrvFXlTtOWMMdNOL/OA2GNfHZ92G5Rfo
         E9oTw9mH1epy8I7OVaFODCxxZAa0K5w3aLP4oc1b4SgA0kIal9vJ6IaDEOeMudfCOyfT
         NkwCO2fNSveH8GFwuvtMrTA545kWlVH4kiv6TMjomby0iWbC8GPsll79W5rFdTbufHks
         wKsjaElqEG6UMK5ZRJAsD865OVjxEk4ZgiU2cEOcrxaTbnJtQMiFIp6NDSs4pjyfoh5z
         c3U4Ir/k+qCtuRTg0mGxLddy6jDkqpunIjPFiAP7Mh+VbyLzWFg1iVLAD4pUny9Kq1YG
         B0xg==
X-Gm-Message-State: AOAM531+y0HZqAdIg8mHRkWcvCFdjSsQQEGVIlPeSU2kZozakIyIJcCP
        0oxxS/kNt15UGB0fQvZ2784pcA84rme9HHhlWp3DYQ==
X-Google-Smtp-Source: ABdhPJwSqBfeUvIcM8EleUCetNVoR0X++jtArl7ahnXeI6abvXDuoIEXlEE3kaD2V3MqLff3EuTgPpUxx9HGhN89h88=
X-Received: by 2002:a5d:9a13:: with SMTP id s19mr1193955iol.20.1591134053693;
 Tue, 02 Jun 2020 14:40:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:150:0:0:0:0 with HTTP; Tue, 2 Jun 2020 14:40:52
 -0700 (PDT)
X-Originating-IP: [73.70.188.119]
In-Reply-To: <20200602191703.xbhgy75l7cb537xe@ast-mbp.dhcp.thefacebook.com>
References: <20200303003233.3496043-1-andriin@fb.com> <20200303003233.3496043-2-andriin@fb.com>
 <fb80ddac-d104-d0b7-8bed-694d20b62d61@iogearbox.net> <CAEf4BzZWXRX_TrFSPb=ORcfun8B+GdGOAF6C29B-3xB=NaJO7A@mail.gmail.com>
 <87blpc4g14.fsf@toke.dk> <945cf1c4-78bb-8d3c-10e3-273d100ce41c@iogearbox.net>
 <CAGw6cBuCwmbULDq2v76SWqVYL2o8i+pBg7JnDi=F+6Wcq3SDTA@mail.gmail.com> <20200602191703.xbhgy75l7cb537xe@ast-mbp.dhcp.thefacebook.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Tue, 2 Jun 2020 14:40:52 -0700
Message-ID: <CAGw6cBstsD40MMoHg2dGUe7YvR5KdHD8BqQ5xeXoYKLCUFAudg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: switch BPF UAPI #define constants
 used from BPF program side to enums
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-06-02, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> It's possible, but I'm not sure what it will fix.
> Your example is a bit misleading, since it's talking about B
> which doesn't have type specifier, whereas enums in bpf.h have ULL
> suffix where necessary.
> And the one you pointed out BPF_F_CTXLEN_MASK has sizeof == 8 in all cases.

Apologies if I wasn't clear, I was just trying to explain why this C
extension can have confusing semantics where the type of an enum
constant depends on where it is used. You're right that it doesn't
happen in this particular case.

The breakage appears with my C compiler, which as I mentioned, only
implements the extension when the enum constants fit into unsigned int
to avoid these problems.

$ cproc -x c -c - -o /dev/null <<EOF
> #include <linux/bpf.h>
> EOF
<stdin>:420:41: error: enumerator 'BPF_F_CTXLEN_MASK' value cannot be
represented as 'int' or 'unsigned int'
cproc: compile: process 3772 exited with status 1
cproc: preprocess: process signaled: Terminated
cproc: assemble: process signaled: Terminated
$

Since the Linux UAPI headers may be used with a variety of compilers,
I think it's important to stick to the standard as much as possible.
BPF_F_CTXLEN_MASK is the only enum constant I've encountered in the
Linux UAPI that has a value outside the range of unsigned int.

> Also when B is properly annotated like 0x80000000ULL it will have size 8
> as well.

Even with a suffixed integer literal, it still may be the case that an
annotated constant has a different type inside and outside the enum.

For example, in

	enum {
		A = 0x80000000ULL,
		S1 = sizeof(A),
	};
	enum {
		S2 = sizeof(A),
	};

we have S1 == 8 and S2 == 4.

>> Also, I'm not sure if it was considered, but using enums also changes
>> the signedness of these constants. Many of the previous macro
>> expressions had type unsigned long long, and now they have type int
>> (the type of the expression specifying the constant value does not
>> matter). I could see this causing problems if these constants are used
>> in expressions involving shifts or implicit conversions.
>
> It would have been if the enums were not annotated. But that's not the case.

The type of the expression has no relation to the type of the constant
outside the enum. Take this example from bpf.h:

	enum {
		BPF_DEVCG_DEV_BLOCK     = (1ULL << 0),
	 	BPF_DEVCG_DEV_CHAR      = (1ULL << 1),
	};

Previously, with the defines, they had type unsigned long long. Now,
they have type int. sizeof(BPF_DEVCG_DEV_BLOCK) == 4 and
-BPF_DEVCG_DEV_BLOCK < 0 == 1.

-Michael
