Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B548240B355
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 17:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhINPnm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 11:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhINPnl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 11:43:41 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274F7C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 08:42:24 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b10so17670158ioq.9
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7PGgA6rNKVMvN4CZBXssmkU+Fy1XHZSQqwZCGLqixxY=;
        b=if360Kq6KpsAn9khW3rpsO6qtJnfvENdE/OJr5N2zJRVM6oTi1J1Jpb1/gd/Etud/V
         G4vwa+dYYeE6VI5iUdDN9rDg6V1ocnfKIaCBJByTG7qxUcGhNoHPHdAYc5WKxHB2Yev6
         b/xZ5SKTdD3Qk/jpZ6g4gKYEK5jC6QZrEfx2dB3LGkXuuZ2KlxwhGuL47A+S8dKD1M2S
         VFpzotM4paxlHQN7jcTfZOplgdJKsqnjGRvoYRwMjrTGZA4fsDR0DFxAFDKpHhyYIvRW
         Zl17yH43yBhv0z5c3ajOTLYzXHQaafL15dX/mPPxN+B2z9LFf4Nj53+WAXipeOISDgib
         bDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7PGgA6rNKVMvN4CZBXssmkU+Fy1XHZSQqwZCGLqixxY=;
        b=YJK/0jxv4MVYLgXlp+482JPCqoHCm/5hChQS/HRBDxmP8lGBN2/a8lNht33GtnY6y4
         sMW7/W/UFeHCptGsM7AhNl/LdRtwRS62Mwg77EQeCHQ4wxi9dsEVJK+vhnv5wjaZvkMa
         VyjaROrZ669SXnr8pVa9v661VMx9aW2obxiBsDaey/cHGm+Kj3YxjgnNYQN2H7qA57uA
         8K7UK68cPWagx3PoysZsWiSrNCMI4pQooZKKWpP4aMM5O/SF5mgcvLRYDpvc8fZzSxtS
         BVemLiLg3nmXi9+QgM2oVc+2yArOeaIBCy0FnLkb0U5/ciR9PFCd8bDylSzBJ9ogdYZD
         pfyA==
X-Gm-Message-State: AOAM5305zqP9x6Oda5SA4T1+IumTT3f3tAoZXQRTQMWLQ+8vqKEvvL0F
        QsFUXKTcB2IkYrbfihFBIjP1tZaMoVg8
X-Google-Smtp-Source: ABdhPJyf6UdL3vuKvGbNmt0bFN9VvbvR8BR3LknKQow5oxpujG1bd3D+yyls0G4SRg34Xr9WAne3Ow==
X-Received: by 2002:a05:6638:50f:: with SMTP id i15mr15213560jar.79.1631634143576;
        Tue, 14 Sep 2021 08:42:23 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v8sm1031562ilg.25.2021.09.14.08.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:42:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 127CF27C0054;
        Tue, 14 Sep 2021 11:42:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 14 Sep 2021 11:42:22 -0400
X-ME-Sender: <xms:3cJAYQQWAXYNH4yjtnCxZRW0XwX8ZZcRDQ3G0qv9OcVmjHRjjBZ7KQ>
    <xme:3cJAYdwT5EM_D6phLsAWWF6LTmzs3jzhpsTG7gj5G4E4X0kFpkuxXhAi268uJLJ4V
    XYXU8qAcrfpwex3e0c>
X-ME-Received: <xmr:3cJAYd10JOCdQkqT17_4LYOLaBhLHKEoCCzqSqihLs9jiizeWJAaHbNKWRaldxEudedm-go>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeekueffheekieehkeefjeeiieeukeelieej
    feetfffgfeffvdfhtdeuhfelheeuhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghfrggvlhguthhinhhotghoodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduudeltdekieeffeeiqddvheehkeejleefiedqrhgrfh
    grvghlughtihhnohgtoheppehgmhgrihhlrdgtohhmseduvdefmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:3cJAYUC8I9dvW7At8gq_A68QJJ7-EXWXuvRMWxcIEes1-6Q6jRB6HA>
    <xmx:3cJAYZhrnPyNA2rbDIxeYxOwQE60GA-1jc7YH0d3ljlNStib7DjUVg>
    <xmx:3cJAYQr8SpjFVJaLc3SOspl2hd0nIfGy1YFNOeB0xn8v1_1BNBDeNA>
    <xmx:3sJAYZYPHv5cEAeagADDngIrwrbNQzcChgZYuxZjeAtGl2Jt8Dmg4w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 11:42:21 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH bpf-next v5] libbpf: introduce legacy kprobe events
 support
From:   Rafael David Tinoco <rafaeldtinoco@gmail.com>
In-Reply-To: <CAJygYd3DZKv+2ee3_Bd=Pqa4j_C1UQ34Ga_0vNE7YmkfWz6X6g@mail.gmail.com>
Date:   Tue, 14 Sep 2021 12:42:20 -0300
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
X-Mao-Original-Outgoing-Id: 653326939.998656-403853ac99b89575ca16038c4967a7c4
Content-Transfer-Encoding: quoted-printable
Message-Id: <7500F71C-79CF-449C-819E-7734B6B62EA5@gmail.com>
References: <CAEf4BzYPNsgMMU9Xi-Ya53-264MYrQNWWQNAyDJqNEgawk+V-g@mail.gmail.com>
 <20210912064844.3181742-1-rafaeldtinoco@gmail.com>
 <CAEf4BzYpyuw4Bw5+Avx_qmNyrRqgXKRH+MJQ91CPLv9ftBhLhg@mail.gmail.com>
 <1EEF48CB-0164-40B3-8D56-06EDDAFC5B1E@gmail.com>
 <CAEf4BzZYEi_FS_UT9Ypp5iNL60t07KT_8DyQaSzSCNN_nfC1NA@mail.gmail.com>
 <CAJygYd3DZKv+2ee3_Bd=Pqa4j_C1UQ34Ga_0vNE7YmkfWz6X6g@mail.gmail.com>
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 14 Sep 2021, at 11:27 AM, sunyucong@gmail.com wrote:
>=20
>> +static int poke_kprobe_events(bool add, const char *name, bool =
retprobe, uint64_t offset)
>> +{
>> +       int fd, ret =3D 0;
>=20
> This patch introduced a warning/error in CI
>=20
> libbpf.c: In function =E2=80=98poke_kprobe_events=E2=80=99:
> 648 libbpf.c:9063:37: error: =E2=80=98%s=E2=80=99 directive output may =
be truncated
> writing up to 127 bytes into a region of size between 62 and 189
> [-Werror=3Dformat-truncation=3D]
> 649 9063 | snprintf(cmd, sizeof(cmd), "%c:%s %s",
> 650 | ^~
> 651 In file included from /usr/include/stdio.h:867,
> 652 from libbpf.c:17:
> 653 /usr/include/x86_64-linux-gnu/bits/stdio2.h:67:10: note:
> =E2=80=98__builtin___snprintf_chk=E2=80=99 output between 4 and 258 =
bytes into a
> destination of size 192
> 654 67 | return __builtin___snprintf_chk (__s, __n, =
__USE_FORTIFY_LEVEL - 1,
> 655 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 656 68 | __bos (__s), __fmt, __va_arg_pack ());
> 657 | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

That happened because:

+	char cmd[192] =3D {}, probename[128] =3D {}, probefunc[128] =3D =
{};

was changed from original patch without initializing those to '\0' =
instead.

