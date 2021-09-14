Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2F340BA73
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 23:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbhINVka (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 17:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhINVka (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 17:40:30 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C11EC061764
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 14:39:12 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b10so655347ioq.9
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 14:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wakIEjmT5WpgG+Cp5BM4AYYeXG5525IjD3zw9z7Kj0E=;
        b=CXu/FipXcfgrDPqtIY4/wwYXAG3SxQJTKlrLjhiBO6TddlqvFYzzoOSlIQDHLJ24YH
         f43M97gkUHIDLeMgyXw8l81laTaWNFGU4Idvl7+duru2wdKeZiDh23isYALy9TNeXL2v
         ZxdVW46PUjdXODIX2s3XOycssXuOKdRPvU6s94OFenXEWs2778et1LrqBFIo1yj6VUuI
         wzrmTh4j3c9wSHnyV93WoIRLN3JDt5gUJFdrSIRDOShmmrCLbmYywgZkKuJ9DLPbXp4v
         LYI7J0XLzbnOg2pjpYQtqRlfJM9tb9EBG69+E/TwAmb6MEax/lYPdbN/wIfJdbeN5+Ll
         Fosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wakIEjmT5WpgG+Cp5BM4AYYeXG5525IjD3zw9z7Kj0E=;
        b=KAgDJdADw01snt5iRKcwCTnoFTVu8KK1GYnqi48eoQ5/3vJBNwt5ReOGRb6EbsKl6Q
         OGrQpJFsVsGu1wOyQNw9MXlb5+pxCRN6V8KoP0ZZC51VVz7vxO8IGDXa7QRifCEMRuRG
         Uwk/U38EK0YBjPKjA3xFrcp0O8FMapWrpPldqVe7tbRQYqa/FIHQoj30xiu2Tft56UkK
         SPA1BFCQFb9ho72Qhu6F0E8IionHtBFjP6/WsQ2lbflh2uq57g0BR3qyK5u68bYqeaLM
         Ki6g1gBkdTXr2DRPz6CdHawnJMHfHahTuhtNmIie9EvfKXlIqIMViWl1ddSIdYjJW/ES
         B3Gw==
X-Gm-Message-State: AOAM530zQB1DT+EtBPzNX7H1+f65pxjE6mPj6jVqfkd8ErzIjdIZqbgu
        Q0dGjj7+LUVlo4iDytXfcw==
X-Google-Smtp-Source: ABdhPJwgMum7JkQqg2grQEkOgfhwbHvkjBLiAqmHiTZPHqjyKBt8iqwSj+WsxewShH+kVYIDthe0cQ==
X-Received: by 2002:a05:6638:4103:: with SMTP id ay3mr1220205jab.76.1631655551674;
        Tue, 14 Sep 2021 14:39:11 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l1sm7710834ilc.65.2021.09.14.14.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 14:39:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9CA3E27C005B;
        Tue, 14 Sep 2021 17:39:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 Sep 2021 17:39:10 -0400
X-ME-Sender: <xms:fhZBYfbt5n0iIlz3IIT1FX7Gz6tZlt7c4UkTBnXP6dEfETtyFm36KA>
    <xme:fhZBYeZx3A9PO1h0ynoAsaoHWBw3qiAKDPSQeKzt-iQ64p3DZKh0wMPuJ2npdXmRn
    sHwrzzFOS6HcQ-LPt4>
X-ME-Received: <xmr:fhZBYR97mTog01Qz9wWkRZztT_AWJZNOtg_cp3LxbIpsCvNXDVu6ffLPLtsE8DMzURVC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehtdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogetfe
    dtuddqtdduucdludehmdenucfjughrpegtggfuhfgjfffgkfhfvffosehtqhhmtdhhtdej
    necuhfhrohhmpeftrghfrggvlhcuffgrvhhiugcuvfhinhhotghouceorhgrfhgrvghlug
    htihhnohgtohesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepfeehkeffieeg
    vdehtdetfeehffegffeuudegfeevgefhtdeivdeklefhvdevuddtnecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrrghfrggvlhguthhinhhotghoodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdduudeltdekieeffeeiqddvheehkeejleefiedqrhgrfhgrvghlught
    ihhnohgtoheppehgmhgrihhlrdgtohhmseduvdefmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:fhZBYVqybn9cMfF0XEfo5sgk3d7_65JaF9o476rkzwugURKHtPxCuw>
    <xmx:fhZBYaqQmmmrSrRC5lb9HvjAUpf_OPSvev4b0NCNo0LKVsjoWMUaCw>
    <xmx:fhZBYbTwZh4QipFss87Kx4KN5bNX6NL9jPrx4Neubb-Z55yomxKAaQ>
    <xmx:fhZBYdU4cVawkB2VJwQJuOMiHu0cKpFrohkHAONPl0l4Z55wrR1AXw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 17:39:09 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH bpf-next v2] libbpf: fix build error introduced by legacy
 kprobe feature
From:   Rafael David Tinoco <rafaeldtinoco@gmail.com>
In-Reply-To: <20210914213554.2338381-1-rafaeldtinoco@gmail.com>
Date:   Tue, 14 Sep 2021 18:39:07 -0300
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
        sunyucong@gmail.com, alexei.starovoitov@gmail.com
X-Mao-Original-Outgoing-Id: 653348347.612789-301df29bc48746c4c0720e452fb8125f
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B1531CC-63FE-4D22-8645-9EDB666F2707@gmail.com>
References: <7500F71C-79CF-449C-819E-7734B6B62EA5@gmail.com>
 <20210914213554.2338381-1-rafaeldtinoco@gmail.com>
To:     Rafael David Tinoco <rafaeldtinoco@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> -	char cmd[192], probename[128], probefunc[128];
> +	char cmd[288] =3D "\0", probename[128] =3D "\0", probefunc[128] =
=3D "\0";
> 	const char *file =3D "/sys/kernel/debug/tracing/kprobe_events";

I had gcc-10 with:

libbpf.c: In function =E2=80=98poke_kprobe_events=E2=80=99:
libbpf.c:9012:37: error: =E2=80=98%s=E2=80=99 directive output may be =
truncated writing up to 127 bytes into a region of size between 62 and =
189 [-Werror=3Dformat-truncation=3D]
 9012 |   snprintf(cmd, sizeof(cmd), "%c:%s %s",
      |                                     ^~
In file included from /usr/include/stdio.h:866,
                 from libbpf.c:17:
/usr/include/x86_64-linux-gnu/bits/stdio2.h:71:10: note: =
=E2=80=98__builtin___snprintf_chk=E2=80=99 output between 4 and 258 =
bytes into a destination of size 192
   71 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL =
- 1,
      |          =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   72 |        __glibc_objsize (__s), __fmt,
      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   73 |        __va_arg_pack ());
      |        ~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

locally AND it fixed the issue for me but Alexei reported:

https://github.com/kernel-patches/bpf/runs/3603448190

with a truncation of max 258 bytes. I raised cmd size to 288.=20

Let's see if that fixes the issue.

