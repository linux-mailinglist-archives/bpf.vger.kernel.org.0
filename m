Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A049B3B0D
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbfIPNLB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 09:11:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22399 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728004AbfIPNLB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Sep 2019 09:11:01 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 09:11:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568639460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RSw1RmqStnEs4NKEJbqyLxUZJ7YeiMipjbqsuTXn9wM=;
        b=CN+4fU0mXTeA6Dx4zS5UUEvgfSIQxKHvj5XpWx9HADuQf91MFhJ0zef2S72vjXtSO72CEj
        XT6ULMGs1RIcyMT2ux6ICMYhFYn76bZzV6TDPx3BEy2kTkvIPs/XGFtcQnvte/ddTq9eRW
        ZNR+J966QxqytLh9gzV+kxy44OXxE0Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-XU7DYWjEMA2LArvso0LdDg-1; Mon, 16 Sep 2019 09:04:49 -0400
Received: by mail-ed1-f71.google.com with SMTP id s3so4719943edr.15
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 06:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7BXsXBG+6P/W6YvDXGL9hFFSGVue8AMsULcof54DDZA=;
        b=aXCTzU3Il6TQEZtbTjTHENGKKEQbudPUwbisZRWf+l9cQfAIBHWgywKA3+RcGrDAhQ
         yMHy6SslsPFD7vt2O4OY/eJaX9dcuuNJSQRcyz6G+TRYI99HQGZWS7uH5bMfkxOjdFfp
         VHupW+ivVExiWR7r3DDyEleiRtRDxxBaWUj0ueOfTWqTYRpeq+AcWCmQAHNRyd4rifvL
         S4f6LZassgrJk/ak/a4PNmKAZ9ECKeabqwck4/QqIdwgPryq7MLDP/aVmQuVs1VCcmXe
         D01WveoOJGJUsWFMrlCQ/GDZ5OCvfv9xFPvbUmEETbHccEE2PZjQ6D5VKk9UygX73i7a
         Zzfg==
X-Gm-Message-State: APjAAAUXf1/FxwbQcw0lSlGBMHLl2GM302fNK8uz/EabK95IJyIWccAV
        dYGXENGpznBfyAURuRVpVsn48O77VjU+4Sk50FNM4231CzqvgGuqk+SA9jrYmE8IPPPvqtMx5WZ
        w8rgD9c0Ueymu
X-Received: by 2002:a05:6402:71a:: with SMTP id w26mr11316414edx.191.1568639088905;
        Mon, 16 Sep 2019 06:04:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxLCUIYpw/4WgUPfvxxQ4lAI1n/tlu9J1b92BxpvsV0zILJ9Vb1V8CeU6Nep6Gj0zOSldE0Og==
X-Received: by 2002:a05:6402:71a:: with SMTP id w26mr11316390edx.191.1568639088753;
        Mon, 16 Sep 2019 06:04:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id p20sm2168541edr.83.2019.09.16.06.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:04:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0400418063D; Mon, 16 Sep 2019 14:31:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "maximmi\@mellanox.com" <maximmi@mellanox.com>
Subject: Re: [PATCH] libbpf: Don't error out if getsockopt() fails for XDP_OPTIONS
In-Reply-To: <9271a44f-1bbf-1305-bff9-8cbb8bae9098@iogearbox.net>
References: <20190909174619.1735-1-toke@redhat.com> <8e909219-a225-b242-aaa5-bee1180aed48@fb.com> <87lfuxul2b.fsf@toke.dk> <60651b4b-c185-1e17-1664-88957537e3f1@fb.com> <9271a44f-1bbf-1305-bff9-8cbb8bae9098@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 16 Sep 2019 14:31:18 +0200
Message-ID: <87v9tsl8x5.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: XU7DYWjEMA2LArvso0LdDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 9/13/19 8:53 PM, Yonghong Song wrote:
>> On 9/10/19 12:06 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> Yonghong Song <yhs@fb.com> writes:
>>>> On 9/9/19 10:46 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>> The xsk_socket__create() function fails and returns an error if it ca=
nnot
>>>>> get the XDP_OPTIONS through getsockopt(). However, support for XDP_OP=
TIONS
>>>>> was not added until kernel 5.3, so this means that creating XSK socke=
ts
>>>>> always fails on older kernels.
>>>>>
>>>>> Since the option is just used to set the zero-copy flag in the xsk st=
ruct,
>>>>> there really is no need to error out if the getsockopt() call fails.
>>>>>
>>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>>> ---
>>>>>     tools/lib/bpf/xsk.c | 8 ++------
>>>>>     1 file changed, 2 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
>>>>> index 680e63066cf3..598e487d9ce8 100644
>>>>> --- a/tools/lib/bpf/xsk.c
>>>>> +++ b/tools/lib/bpf/xsk.c
>>>>> @@ -603,12 +603,8 @@ int xsk_socket__create(struct xsk_socket **xsk_p=
tr, const char *ifname,
>>>>>    =20
>>>>>     =09optlen =3D sizeof(opts);
>>>>>     =09err =3D getsockopt(xsk->fd, SOL_XDP, XDP_OPTIONS, &opts, &optl=
en);
>>>>> -=09if (err) {
>>>>> -=09=09err =3D -errno;
>>>>> -=09=09goto out_mmap_tx;
>>>>> -=09}
>>>>> -
>>>>> -=09xsk->zc =3D opts.flags & XDP_OPTIONS_ZEROCOPY;
>>>>> +=09if (!err)
>>>>> +=09=09xsk->zc =3D opts.flags & XDP_OPTIONS_ZEROCOPY;
>>>>>    =20
>>>>>     =09if (!(xsk->config.libbpf_flags & XSK_LIBBPF_FLAGS__INHIBIT_PRO=
G_LOAD)) {
>>>>>     =09=09err =3D xsk_setup_xdp_prog(xsk);
>>>>
>>>> Since 'zc' is not used by anybody, maybe all codes 'zc' related can be
>>>> removed? It can be added back back once there is an interface to use
>>>> 'zc'?
>>>
>>> Fine with me; up to the maintainers what they prefer, I guess? :)
>
> Given this is not exposed to applications at this point and we don't do a=
nything
> useful with it, lets just remove the zc cruft until there is a proper int=
erface
> added to libbpf. Toke, please respin with the suggested removal, thanks!

Sure, can do :)

-Toke

