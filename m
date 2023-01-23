Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162C2678A06
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 22:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjAWV5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 16:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAWV47 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 16:56:59 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6708C30B13
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 13:56:58 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so221536pjq.1
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 13:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JENCWblp09jvLhunYqAYGCEDm9dUN2wsHTF49prlV+U=;
        b=D67Lq+BtGvXJvlqFyWA+iI6e2ub8h9Mad+0rSzE7QyyalQiB5fklSJjgReyDwKFO1c
         Hw2VAWoHVS1k5UQfP5cTkCeEC1e1YfIENQbO4Qh9y1aNQPf0atgAq2GUlhP0NQRlh99d
         PrFRQ9g5CaV9wO0s7ihyYKrMXjF250IH0Vxftphza+IL3Mwjt+Y1726oXoSUnAAQx6vE
         hOhum68s/ZnhTYEcjYaFBj/DqWQGEIlQzxk/UHZAZuc+wgf4qCdoa9QFho6mUWBG0Vdx
         Ji99yClUaXq1t39Wzetg3BnHjYd+6KX8aSLqfmHZzPsf7rrJmXTRnSPuvKJ7msjtfyg4
         0MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JENCWblp09jvLhunYqAYGCEDm9dUN2wsHTF49prlV+U=;
        b=n0NsjPavVYR4z48Nih7L4PDN6wSVaWqeLA3LyY1t/W34RIRsHwAbJoGNk8ukm63JfX
         6GaXzLnwAlxHj92ibHJbZCFSXJ4OCvOdCx0pwjrq+PvWY1cP7U5tzIkH23iuI83nROnc
         eaT1C9aUyrTPO9V8+TBggewBlNAaAEKU2OQxNcwxg/CLIvA5l8ZKUGLO0chEeKh095aA
         ygE9YK2Dg3PKBMUfu9zumZDjAaWNXAsv7ThbJ2UoqMBqFGbdK1jhtekYWXAofpKBWhR5
         Js2YvzmggX9KYa+XdiGaY3KhPEPZlnFIQHLVy3kGz32o+LtZKh8TtazvkZRKIoJ4dOoj
         sSNw==
X-Gm-Message-State: AO0yUKWWr3nJ/1Ys87OWhbT3+WLCcIR848l69O5t/RYXh2NdAalRCnlT
        TPFItrFgXrps25BOck9JgRmyPrQMCOSaaIAngn4=
X-Google-Smtp-Source: AK7set/UGPz/R0jWRF3YXWuL1ZUoGBBYw17y6RqlmVwNiK4LetZ2IwNLx9RxXV4I70tX7Y39u/3cWv77Mu+XxeMdCNc=
X-Received: by 2002:a17:90a:8a14:b0:22b:e322:5432 with SMTP id
 w20-20020a17090a8a1400b0022be3225432mr261212pjn.199.1674511017764; Mon, 23
 Jan 2023 13:56:57 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com> <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com> <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
 <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev> <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
 <87k01dvt83.fsf@cloudflare.com>
In-Reply-To: <87k01dvt83.fsf@cloudflare.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Mon, 23 Jan 2023 23:56:46 +0200
Message-ID: <CAMy7=ZXyqCzhosiwpLa9rsFqW2jX4V59-Ef4k-5dQtqKOakTFQ@mail.gmail.com>
Subject: Re: Are BPF programs preemptible?
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-23:25 =D7=9E=D7=90=D7=AA=
 =E2=80=AAJakub Sitnicki=E2=80=AC=E2=80=8F
<=E2=80=AAjakub@cloudflare.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Mon, Jan 23, 2023 at 11:01 PM +02, Yaniv Agman wrote:
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-22:06 =D7=9E=D7=90=D7=
=AA =E2=80=AAMartin KaFai Lau=E2=80=AC=E2=80=8F
> > <=E2=80=AAmartin.lau@linux.dev=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>
> >> On 1/23/23 9:32 AM, Yaniv Agman wrote:
> >> >>> interrupted the first one. But even then, I will need to find a wa=
y to
> >> >>> know if my program currently interrupts the run of another program=
 -
> >> >>> is there a way to do that?
> >> May be a percpu atomic counter to see if the bpf prog has been re-ente=
red on the
> >> same cpu.
> >
> > Not sure I understand how this will help. If I want to save local
> > program data on a percpu map and I see that the counter is bigger then
> > zero, should I ignore the event?
>
> map_update w/ BPF_F_LOCK disables preemption, if you're after updating
> an entry atomically. But it can't be used with PERCPU maps today.
> Perhaps that's needed now too.

Yep. I think what is needed here is the ability to disable preemption
from the bpf program - maybe even adding a helper for that?
