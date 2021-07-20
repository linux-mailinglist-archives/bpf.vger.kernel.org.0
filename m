Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52A43CF314
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 06:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbhGTDib (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 23:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245445AbhGTDgz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 23:36:55 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4276DC0613DF
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 21:16:34 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a7so18037154iln.6
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 21:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:mime-version:message-id:in-reply-to:references:date:from
         :to:cc:subject;
        bh=0tQss4tGfn4OQIzt1lN20MAOzzsntRq7ZNCJXJ/tuZM=;
        b=Z8cveZ6SpzniE8rU45nsU6Yr+p7sUDcnDdhdNQjF6f6JJPzZmP59lSsUD71/9qp5OM
         lOVvTY+k5XSk9WNrdWk9Nl1WqRE1U55gTJPykJRbrwsleq1+b9lnXhM4+gqixRsZYQtA
         lpRluc5gcmY8JL2xbRsyN8kgCjQbjLY5vyIKTFr6tHe824dshqd9tnKo7n1YDUuYrtp4
         zghYUm1llYfhMIRPGBxIcVdJ590i82de3fOU8oSxDh8Bci14q7qM9BBqgRXoBOKxZYRa
         6nZuj0+BL9kf2xPObmrku+DAoJ0WlBYvSDMSL2jxgO8EDfdcqcB9MSifoCkfMEav/rTg
         8XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:mime-version:message-id:in-reply-to
         :references:date:from:to:cc:subject;
        bh=0tQss4tGfn4OQIzt1lN20MAOzzsntRq7ZNCJXJ/tuZM=;
        b=XYEZH2IfAFZmkPBCnDMUhUhkhoPKLxbgUsn1aeJUB8EvxMGdHhmlFkA2nqu9ErpAnj
         lRAs2NMcTxzSYWOXJDTWRllpnjO3dD0945lCC9cAFZRuVVbR9YT//fnz6ljPMQtdmPIV
         4aaCpAK2eJ+zYfiGMi5ClJfw6GwcpC7rZe9yhEetl9msgc6H7AumxHbwbt+aonGUMvrr
         hZuG2zTRYzZhvKRN8HRCrthJ3ik6UlSCanuyKkzfBYcGIqGwGC6+ifCAbhdtWeNjzbvY
         Hgr6CgvoBzhuOS6Xq628rFsyCqNS40/+3JlwwFp+bpdJvD4heD8YlFHoiOrn8qA6B2lL
         wQHw==
X-Gm-Message-State: AOAM533doJjui4MgMjNh8YoKmBMK9w5W/XFHmS76KnXNjU4WxIsi6Vm/
        n31c4SG/T7AoMBmUdNIhKA==
X-Google-Smtp-Source: ABdhPJyc5ixekBI9ZX0KWnyy2nTb78YBclc5UNGVsQwxvbaegUzayMZue5p1IKNxXqMQjbm6zKgzMg==
X-Received: by 2002:a92:7303:: with SMTP id o3mr19641340ilc.36.1626754593717;
        Mon, 19 Jul 2021 21:16:33 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w21sm11343024iol.52.2021.07.19.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 21:16:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 47F9C27C0054;
        Tue, 20 Jul 2021 00:16:32 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
  by compute3.internal (MEProxy); Tue, 20 Jul 2021 00:16:32 -0400
X-ME-Sender: <xms:H072YF4cTNJT09LzvJiGYI4CtnGrK-A_eEz-bQUWUGU10Xs0Wy5_mw>
    <xme:H072YC6kgt4NfI0DhjHoKjRhb0GEema_ZkdNYmayCYAxk04P3XMY0SEL0mbK4uUt4
    GVAcoEAxqmMPxGzZYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedugdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftfgrfhgr
    vghlucffrghvihguucfvihhnohgtohdfuceorhgrfhgrvghlughtihhnohgtohesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepledtteelfeekjeelvdelieejfefhkeeu
    ffeitedutdelueefkefhvedtffeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrfhgrvghlughtihhnohgtohdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduvdehieehledtgedqvdehheekjeelfeeiqdhrrg
    hfrggvlhguthhinhhotghopeepghhmrghilhdrtghomhesuddvfehmrghilhdrohhrgh
X-ME-Proxy: <xmx:H072YMeT6VIl2_j1vDk031MNZyelhulX0DI2MHBa3wt0LxSg7E30sg>
    <xmx:H072YOIhkDpfoD-hHbDgTN5bq70IRHAUhU7SWT4mwlN2AAGMz55Qqw>
    <xmx:H072YJI9a-JPlUMyxMKs_nyQ0K_4El3xXVWP54HVVcTjiOxpfwxQRw>
    <xmx:IE72YMnuOY8cZPX8dMeEvtw401UtlIyN4usUT6iiWyn0v4_Um3kYgQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DCC064E00F5; Tue, 20 Jul 2021 00:16:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-533-gf73e617b8a-fm-20210712.002-gf73e617b
Mime-Version: 1.0
Message-Id: <0487b7af-bd8c-4a83-94ed-eb26cca90fb9@www.fastmail.com>
In-Reply-To: <CAEf4BzaVrMcLe-0FowM1upkRfBePnJiksmc3vfKvbAFFUFscoA@mail.gmail.com>
References: <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
 <20210625044459.1249282-1-rafaeldtinoco@gmail.com>
 <CAEf4BzYz4BJp8beyoKD03ao4PuvuDg+QpMszeJSGrqPC==JoGw@mail.gmail.com>
 <701c5dea-2db9-4df8-888b-9e10c854afc3@www.fastmail.com>
 <CAEf4BzaVrMcLe-0FowM1upkRfBePnJiksmc3vfKvbAFFUFscoA@mail.gmail.com>
Date:   Tue, 20 Jul 2021 01:16:11 -0300
From:   "Rafael David Tinoco" <rafaeldtinoco@gmail.com>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_bpf-next_v3]_libbpf:_introduce_legacy_kprobe_events?=
 =?UTF-8?Q?_support?=
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> >         plink = (struct bpf_link *const *) link;
> >         kplink = container_of(plink, struct bpf_link_kprobe, link);
> 
> Did you check if this works? Also how that could ever even work for
> non-kprobe but perf_event-based cases, like tracepoint? And why are we
> even discussing these "alternatives"? What's wrong with the way I
> proposed earlier? For container_of() to work you have to do it the way
> I described in my previous email with one struct being embedded in
> another one.

Nevermind. Sorry for the noise. I'll do the container encapsulation like
you said so. I was being lazy and trying to find a way to change just the
kprobes path instead of thinking in the overall project.

Sorry again, will come up with what you said in the first place. 
