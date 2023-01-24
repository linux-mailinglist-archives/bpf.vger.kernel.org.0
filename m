Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE5679DEA
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 16:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjAXPrt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 10:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjAXPrs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 10:47:48 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF483A90
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 07:47:47 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b24-20020a17090a551800b0022beefa7a23so2208543pji.5
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 07:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmuHInc8rwzIiiJxSoEmZe37AJMXTAiS1Y8IP2usuaY=;
        b=iV8b9UB1vydqO3vF7UGIGTIvDLBzhkQcNQMbhce5Dh/Khgfg/e8bG/ZjAI8H5LLX+t
         ptXyDL9METMUvG5QjWE2Fs9DryfTjxeOU/0CzP3Ez66+EuvpVQXhEwrlyu3jnCYgNH3+
         0GU+B3TsKJU7uc1kRtpRLhX+TMMjk4kbOAtk7LBo62B/gYEL89Hmj6/t8SyxkL+FWu74
         0cc+/88+3syzb9u3cbET6okdI4Do/lJMgk49O72Ya88AAXsIwqlD2WQH944IyBIajPfe
         cPZPzZ+HmM0hk6wg9NQczVqJroQSXC8o66WXERzyQLnp65rNBSHIVV0YmB6S4KO/zP/G
         Fxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmuHInc8rwzIiiJxSoEmZe37AJMXTAiS1Y8IP2usuaY=;
        b=sgVz41LYoZvE/saZZCaHStaBgiTVcnAKyRYEy01vGmYqV5jNHaEOH9xxVvkFw5vIaP
         BanI5JvLRDcXIrrmx3oWdLQxets2Qn2sVBI7r7iazfQw5sRRPXlv4t3eszF3ZXKIc3rV
         hEZ2YfdUYlnlARCofXVvSarDhPk1w9QAEe6xxSEpSopiBPv5z3pVgVolVn+cOf3Urmd2
         R6KY/HLGhbOWKoCm7TPX1bAjZq3qiiR3DsSK5Jt58uMq0NDTXlccYGg5hMmoh8QmiMNW
         t7o78IIOWAr6XI6P2odeAgs3126fVSXgaOh+Hmt2W+qOJOx5tL0POaDOaZRkf3+T0fR1
         U8OA==
X-Gm-Message-State: AO0yUKXKmnnFBrpoGka8veej5SJU7F1bsdCNyPKy0x2YwxBdqk9yRQ77
        ar/Cr0kJ5xgOfgXJTyFDghH7wSfNb2iezArmisxSUjNjk+s=
X-Google-Smtp-Source: AK7set9BlsAMgGHmEa+jNctnO+YENq/Z+Mn+EPmHGG9BPaYoNmXHzDB3pwLnR2OGT/HIEySJ0kPiZetLcIpkwvhAvnw=
X-Received: by 2002:a17:90a:8a14:b0:22b:e322:5432 with SMTP id
 w20-20020a17090a8a1400b0022be3225432mr689981pjn.199.1674575266450; Tue, 24
 Jan 2023 07:47:46 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com> <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com> <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
 <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev> <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
 <87k01dvt83.fsf@cloudflare.com> <CAMy7=ZXyqCzhosiwpLa9rsFqW2jX4V59-Ef4k-5dQtqKOakTFQ@mail.gmail.com>
 <CAADnVQJaCTQtmvOdQoeaZbt0wwPp4iYjbvaPvRZw4DBEOSrJYg@mail.gmail.com>
In-Reply-To: <CAADnVQJaCTQtmvOdQoeaZbt0wwPp4iYjbvaPvRZw4DBEOSrJYg@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Tue, 24 Jan 2023 17:47:35 +0200
Message-ID: <CAMy7=ZVpGMOK_kHk1qB4ywxV88Vvtt=rGw4Q-Fi1F7bGU+6prQ@mail.gmail.com>
Subject: Re: Are BPF programs preemptible?
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=D7=
=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-14:30 =D7=9E=D7=90=D7=AA=
 =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
<=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Mon, Jan 23, 2023 at 2:03 PM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-23:25 =D7=9E=D7=90=D7=
=AA =E2=80=AAJakub Sitnicki=E2=80=AC=E2=80=8F
> > <=E2=80=AAjakub@cloudflare.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >
> > > On Mon, Jan 23, 2023 at 11:01 PM +02, Yaniv Agman wrote:
> > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-22:06 =D7=9E=D7=
=90=D7=AA =E2=80=AAMartin KaFai Lau=E2=80=AC=E2=80=8F
> > > > <=E2=80=AAmartin.lau@linux.dev=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > >>
> > > >> On 1/23/23 9:32 AM, Yaniv Agman wrote:
> > > >> >>> interrupted the first one. But even then, I will need to find =
a way to
> > > >> >>> know if my program currently interrupts the run of another pro=
gram -
> > > >> >>> is there a way to do that?
> > > >> May be a percpu atomic counter to see if the bpf prog has been re-=
entered on the
> > > >> same cpu.
> > > >
> > > > Not sure I understand how this will help. If I want to save local
> > > > program data on a percpu map and I see that the counter is bigger t=
hen
> > > > zero, should I ignore the event?
> > >
> > > map_update w/ BPF_F_LOCK disables preemption, if you're after updatin=
g
> > > an entry atomically. But it can't be used with PERCPU maps today.
> > > Perhaps that's needed now too.
> >
> > Yep. I think what is needed here is the ability to disable preemption
> > from the bpf program - maybe even adding a helper for that?
>
> I'm not sure what the issue is here.
> Old preempt_disable() doesn't mean that one bpf program won't ever
> be interrupted by another bpf prog.
> Like networking bpf prog in old preempt_disable can call into something
> where there is a kprobe and another tracing bpf prog will be called.
> The same can happen after we switched to migrate_disable.

One difference here is that in what you describe the programmer can
know in advance which functions might call others and avoid that or
use other percpu maps, but if preemption can happen between functions
which are not related to one another (don't have a relation of caller
and callee), then the programmer can't have control over it
