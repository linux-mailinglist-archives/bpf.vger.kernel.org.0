Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63A432B31E
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352555AbhCCDvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbhCCBrW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 20:47:22 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C216C061788
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 17:46:34 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b15so3174824pjb.0
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 17:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=s3c8ka2NxmqUACAecVla9DLrhMUmoHZHgqpBk3nSwE4=;
        b=ey6P3q0LbP8aXSAgr0U4Q4rU9RpbW5A6RQswB3UUyw0iAk3a3WCLPnOu8ZV5MrM85X
         6Aj9ILxW0xe3pKs86YYWAVkiUE830LaKaCfRY8L2VU698rF397jifaJzmqNssqfNEzEw
         HC/cMeh1HqWwJ1xwnJzsElT3O6o7IOFq3e4Wd2vC41CdQOtCcOmKsunjPngKlPldfeH5
         PHrpby8xcJe91t7e1s1nhNpLOON2LXZYrplFGVyE6WEIwjyrOzsP5tag5BrAxSYtoOob
         cXL6xngPB3D8tyk/1H1yy/L/gxq0uTMyY19QlL9oWjYdq8H2iayOnVfGdjaAY4D96sVM
         ishQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=s3c8ka2NxmqUACAecVla9DLrhMUmoHZHgqpBk3nSwE4=;
        b=kQsEGOr1Dpu05Axt1jOGd/Kul686ZsSRsG5aaZFY41XKNw5/IZCYdQO54TaGtUj7P4
         Tom2pBWymOs941pqSoZH1KXynAwqVmFZneN3+7PTtjGnEYjZOepWO7R6jAjIkpJ44aB2
         lx8rhj0BG81QCO6Of5W9KUmcmLCAqdi3rBD7g/PzqDe7Ih/juy7XV+IEyJslPeOcbLm/
         Qya+nboavtC/OEiTr0fUs2z+ybI2xV7C1decTiFmCKcayChvxKjFB6loexeVBQY6mC8U
         Z90ZwFw1EDGcbNhzVgH5Hs4WdX671eZrB7xgDmgZaUxItGeLZ+OBIdN786MpS7AhhfA3
         I/KA==
X-Gm-Message-State: AOAM530ijXM0MO3YZ4TcupYnajebzI+Bgh51QqREx/vJRzk0TnHuio+i
        B1z3i5bEOyq22YBwuhGOhqi3ig==
X-Google-Smtp-Source: ABdhPJxm8vrcllcsZ42e4OgPXlUzbfB3kZOBxO/kCNMZK6f8AVdyZdbb/750Ej6UVqiyHnQPOokChQ==
X-Received: by 2002:a17:90a:cb0a:: with SMTP id z10mr2962028pjt.170.1614735993594;
        Tue, 02 Mar 2021 17:46:33 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:55b7:4147:bab7:e0dc? ([2601:646:c200:1ef2:55b7:4147:bab7:e0dc])
        by smtp.gmail.com with ESMTPSA id j11sm4871155pjb.11.2021.03.02.17.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 17:46:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Why do kprobes and uprobes singlestep?
Date:   Tue, 2 Mar 2021 17:46:32 -0800
Message-Id: <968E85AE-75B8-42D7-844A-0D61B32063B3@amacapital.net>
References: <CAADnVQJtpvB8wDFv46O0GEaHkwmT1Ea70BJfgS36kDX0u4uZ-g@mail.gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <CAADnVQJtpvB8wDFv46O0GEaHkwmT1Ea70BJfgS36kDX0u4uZ-g@mail.gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Mar 2, 2021, at 5:22 PM, Alexei Starovoitov <alexei.starovoitov@gmail.c=
om> wrote:
>=20
> =EF=BB=BFOn Tue, Mar 2, 2021 at 1:02 PM Andy Lutomirski <luto@amacapital.n=
et> wrote:
>>=20
>>=20
>>>> On Mar 2, 2021, at 12:24 PM, Alexei Starovoitov <alexei.starovoitov@gma=
il.com> wrote:
>>>=20
>>> =EF=BB=BFOn Tue, Mar 2, 2021 at 10:38 AM Andy Lutomirski <luto@kernel.or=
g> wrote:
>>>>=20
>>>> Is there something like a uprobe test suite?  How maintained /
>>>> actively used is uprobe?
>>>=20
>>> uprobe+bpf is heavily used in production.
>>> selftests/bpf has only one test for it though.
>>>=20
>>> Why are you asking?
>>=20
>> Because the integration with the x86 entry code is a mess, and I want to k=
now whether to mark it BROKEN or how to make sure the any cleanups actually w=
ork.
>=20
> Any test case to repro the issue you found?
> Is it a bug or just messy code?

Just messy code.

> Nowadays a good chunk of popular applications (python, mysql, etc) has
> USDTs in them.
> Issues reported with bcc:
> https://github.com/iovisor/bcc/issues?q=3Dis%3Aissue+USDT
> Similar thing with bpftrace.
> Both standard USDT and semaphore based are used in the wild.
> uprobe for containers has been a long standing feature request.
> If you can improve uprobe performance that would be awesome.
> That's another thing that people report often. We optimized it a bit.
> More can be done.


Wait... USDT is much easier to implement well.  Are we talking just USDT or a=
re we talking about general uprobes in which almost any instruction can get p=
robed?  If the only users that care about uprobes are doing USDT, we could v=
astly simplify the implementation and probably make it faster, too.=
