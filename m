Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E6940A5B1
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 07:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhINFEV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 01:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhINFEU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 01:04:20 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9634AC061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:03:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b200so15298672iof.13
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OHBG9aaqB1Cp80gpRTnwo68EcGKzmCMJxaknPlnM29s=;
        b=bkTrv5OvDridddv6oG9XWzsCYE+sgGPZXADsd90J3Bm57yv/l/49RaIQLTMQVUDqPX
         nWi8neU4toIJIZ0GAuN1I2g6n72lKudTDlIishX+uOjR0vZG/F/xVOFvh71Yka0tcije
         uMnHAdg5Dmi+2qSxRD14ycYqV2uo49jcc2Ha9PmdsvDXsgEYr5IoQg5wTbdorR33eC+k
         +rFZHmx53poE1NXeXeDHLNODL5CRW0+EBlXMHC21SBrsc+xj9P8BvPkPp9Aj3mXejHh7
         UB31pWRzznK9yUULynKs83uF6yv+GtPZNFmQIe5QwNasKXLWhWhv81LdzqQw4j7A+0Ia
         47OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OHBG9aaqB1Cp80gpRTnwo68EcGKzmCMJxaknPlnM29s=;
        b=uS6VhwgGI0FhItVmfaiPIoSEw6PLA7RiTg4tBHDhDNsfc20M7A7H2af9wlFkYyxW1s
         Duc9DrYPuUTbYlyh0gi612a+VfAMbVcnSTbF8hzwo4MWrCo02KMNrUJO5/R0ddJVO6Er
         QCxz3cPJS/2iNbj657yIwv+FGwdlNHcrXhc4bY2gP/kxv2r77kWdSQcuOlgQKS8UijZm
         bMikI9mZIZQwBj0wvmG5zFAnBmEEcwUepqx5pKyNICyThceiMru8NuMET2yKLSG21IT6
         nvO+/E4XxVCQ6IjYcLHmI5RFeaNsJ0x0rCJknJbZRpdXSbGWVqo/shD5yE6lfdAtqNnt
         tOxw==
X-Gm-Message-State: AOAM532wHBMV7R0QP3T6an8wb/6cqp5sEt/tvI5S8fkK6Pi9XrHIEhyg
        mahGcyVTJtumZdgmooeeSDlwPIqQ2ouw
X-Google-Smtp-Source: ABdhPJxq9mhMl/HQMMbtI2mZ0ZoROpa5AkaicVA25VGRzXcWxT6vgPsHVkOPp8hqW0amQofIhwu7mw==
X-Received: by 2002:a6b:e616:: with SMTP id g22mr12165722ioh.67.1631595782844;
        Mon, 13 Sep 2021 22:03:02 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x2sm5987614ilh.46.2021.09.13.22.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 22:03:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id B959027C0054;
        Tue, 14 Sep 2021 01:03:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 14 Sep 2021 01:03:01 -0400
X-ME-Sender: <xms:BS1AYV0ToFWQiP2u3NoUDpxX17RgYSv-zuZDByIlgOqQOYtzyyq4sw>
    <xme:BS1AYcHoPw6iMy0jUKuCeZQWd6PNftgNxCmWp1Cjv0JpJCyTL2KDm9hDZkco6r27N
    paqEqXKdm3ilCODsgI>
X-ME-Received: <xmr:BS1AYV7Yn2O791Q-XBJn-t6PF2yYI1D5kqgBM8Cc2KfkpvwcdgeEorqKy-5Gh8QyMSR77BY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegkedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthhqmhdthhdtvdenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegkefgledtkeekgeehheefueegvdektdel
    vdeufeefvddufeekffeuleejudelveenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghfrggvlhguthhinhhotghoodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduudeltdekieeffeeiqddvheehkeejleefiedqrhgrfh
    grvghlughtihhnohgtoheppehgmhgrihhlrdgtohhmseduvdefmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:BS1AYS0A_0bcKawdaFVvsyRC8PQaHTNJLkvQP0L5kdFslDU4EdyYHw>
    <xmx:BS1AYYFFe8DW6mi07Zbo4e82Zcfd_kjwb8XaPHl1THVWoxSCawvLXw>
    <xmx:BS1AYT8awSZ3vX-63zXOlLg2WY-CBp2BtzmXDrgEJ3PyivuxaHeY5A>
    <xmx:BS1AYTNj4O5KfJ6NJl9OZHf1F2FZPk_zicxQ8-oHkX3uVhsg7GIgGA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 01:03:00 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH bpf-next v5] libbpf: introduce legacy kprobe events
 support
From:   Rafael David Tinoco <rafaeldtinoco@gmail.com>
In-Reply-To: <CAEf4BzYpyuw4Bw5+Avx_qmNyrRqgXKRH+MJQ91CPLv9ftBhLhg@mail.gmail.com>
Date:   Tue, 14 Sep 2021 02:02:59 -0300
Cc:     bpf <bpf@vger.kernel.org>
X-Mao-Original-Outgoing-Id: 653288579.048074-d5c4fd0807f05be92a85783d39395797
Content-Transfer-Encoding: quoted-printable
Message-Id: <1EEF48CB-0164-40B3-8D56-06EDDAFC5B1E@gmail.com>
References: <CAEf4BzYPNsgMMU9Xi-Ya53-264MYrQNWWQNAyDJqNEgawk+V-g@mail.gmail.com>
 <20210912064844.3181742-1-rafaeldtinoco@gmail.com>
 <CAEf4BzYpyuw4Bw5+Avx_qmNyrRqgXKRH+MJQ91CPLv9ftBhLhg@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> Allow kprobe tracepoint events creation through legacy interface, as =
the
>> kprobe dynamic PMUs support, used by default, was only created in =
v4.17.
>>=20
>> After commit "bpf: implement minimal BPF perf link", it was allowed =
that
>> some extra - to the link - information is accessed through =
container_of
>> struct bpf_link. This allows the tracing perf event legacy name, and
>> information whether it is a retprobe, to be saved outside bpf_link
>> structure, which would not be optimal.
>>=20
>> This enables CO-RE support for older kernels.
>>=20
>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>
>> ---
>=20
> I've adjusted the commit message a bit (this has nothing to do with
> CO-RE per se, so I dropped that, for example). Also see my comments
> below, I've applied all that to your patch while applying, please
> check them out.

Thanks. I'm assuming you don't need a v6 based on your adjustment =
comments, let me know if you do please.

...

>>=20
>> -       if (ioctl(perf_link->perf_event_fd, PERF_EVENT_IOC_DISABLE, =
0) < 0)
>> -               err =3D -errno;
>> +       ioctl(perf_link->perf_event_fd, PERF_EVENT_IOC_DISABLE, 0);
>=20
> what's the reason for dropping the error check? I kept it, but please
> let me know if there is any reason to drop it

From: _perf_ioctl() -> case PERF_EVENT_IOC_DISABLE: func =3D =
_perf_event_disable;

_perf_ioctl() will always return 0 and func is void (*func)(struct =
perf_event *).

