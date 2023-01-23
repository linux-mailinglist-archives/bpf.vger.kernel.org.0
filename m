Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC46678982
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 22:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjAWVZh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 16:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjAWVZg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 16:25:36 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D082CC46
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 13:25:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id rl14so30715178ejb.2
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 13:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNRJ1uE0cNSUFat22s6U9L5MnmQJKE82NO8/0b5FCHc=;
        b=QJRS/swUJb15tJ1MgPBumt61/wrP0/kr6a2nhoLHSCRo8YY139KNR0ntfMLyO4iwRm
         unFtCWdv4r/rAKB48x+Kbqqg8/KMJ1WJUDYpV1CvUwwNjIPMVFgESCVq0sBHgFznb6gH
         kTwGu3hZBGRL2s11vZsN6PDD1pM6359bhFBqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZNRJ1uE0cNSUFat22s6U9L5MnmQJKE82NO8/0b5FCHc=;
        b=6Kr4zRlB/vqEwJaP5smaRuPcjVSwWvkoQnztQFOUQEkIb3Q8QtPEaaTWWZyS4fmQ60
         37bhPP2xmjFnF6RwYQldwfV4Ou+pfFtNQFlz5wlYfEXFf8WWiQSZHcueVaXhjLQfYcZe
         kiNRrgQYcbGwUsC3cw9a4ERpyfLcUaqtQQBhi9XAuZ8iJZ+A0V4dEQFFMY/hQjSciW1a
         1pxuBnEbsRcOzUaPweETVKxIwGwxAZPobJ1+8wmwoRHLAi1Y04mDfopduKxX2br//eAo
         yDNvgp+XKm+iO2bn4WczsWjYpNaaRlTyMsONpVJg1oQ+KjXYfatkQzIh7xnlH7WacVKr
         y6Gg==
X-Gm-Message-State: AFqh2kr9+XmGFuIBtVrxGCa8Ra6sB2cQqN45vf5mqnQ0QBq+UnzXhU3Y
        7gJ7LyZlR5VNSVG8u9hhId0fJg==
X-Google-Smtp-Source: AMrXdXvK/bqZB7bnt3+qQxuL0mGywC58XVWmKhu4hCgM+oaBv9+zcxNFkQVbNIZNnjWxw1G6NjspCg==
X-Received: by 2002:a17:906:7c3:b0:870:95b6:94a4 with SMTP id m3-20020a17090607c300b0087095b694a4mr26001816ejc.48.1674509134009;
        Mon, 23 Jan 2023 13:25:34 -0800 (PST)
Received: from cloudflare.com (79.191.179.97.ipv4.supernova.orange.pl. [79.191.179.97])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090632c600b008779eb0fd83sm5525148ejk.23.2023.01.23.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:25:33 -0800 (PST)
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com>
 <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com>
 <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
 <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev>
 <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@meta.com>
Subject: Re: Are BPF programs preemptible?
Date:   Mon, 23 Jan 2023 22:22:27 +0100
In-reply-to: <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
Message-ID: <87k01dvt83.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 11:01 PM +02, Yaniv Agman wrote:
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-22:06 =D7=9E=D7=90=D7=
=AA =E2=80=AAMartin KaFai Lau=E2=80=AC=E2=80=8F
> <=E2=80=AAmartin.lau@linux.dev=E2=80=AC=E2=80=8F>:=E2=80=AC
>>
>> On 1/23/23 9:32 AM, Yaniv Agman wrote:
>> >>> interrupted the first one. But even then, I will need to find a way =
to
>> >>> know if my program currently interrupts the run of another program -
>> >>> is there a way to do that?
>> May be a percpu atomic counter to see if the bpf prog has been re-entere=
d on the
>> same cpu.
>
> Not sure I understand how this will help. If I want to save local
> program data on a percpu map and I see that the counter is bigger then
> zero, should I ignore the event?

map_update w/ BPF_F_LOCK disables preemption, if you're after updating
an entry atomically. But it can't be used with PERCPU maps today.
Perhaps that's needed now too.
