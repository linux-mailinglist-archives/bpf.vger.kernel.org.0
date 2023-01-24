Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E332C67A019
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 18:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjAXRYh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 12:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjAXRYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 12:24:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7674DE0D
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 09:24:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cm4so1020361edb.9
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 09:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xEcvIY8/p/7nqlZJ5s3XfRHmSnbrODBDhAnqoCCCA0=;
        b=hdUvAFONK43rP78vlWSoyscMPaG/wl0IfqtkNjtmx+kTmikRt6Nn+Vo6Kk2gflg5pP
         sPvd/QOvYT2AkC+eQLsJgAojHRsepSpKZfmUM6jSI7ODc/QAj58f3DU/5H7pySlWrJBM
         ayVL2AmUDYThZo1EWwQY+3hvBj/efIplnUhBpd20QdlRBKt9Ty8gQL4lTxHgWktxfNbs
         QJAKbAxVNWveCvtqF1nUZcG0Rf3rphGkpybghXV6Tzj2FsvdpbRkXV8HOZEcohwya9Ku
         QAfgGaPdW75OePpLUmJmt8n1ZsYonyDtZZTXbgq9ZeIvPs165SkrG1KuPIuJOhYprKF/
         qSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xEcvIY8/p/7nqlZJ5s3XfRHmSnbrODBDhAnqoCCCA0=;
        b=xlRI89jR9jd/JNnE798q0+3oEKbANoDnp7nFnkghri6ww2Fmhjec1pYwywvZhryjAt
         UXd66nqNF2jWMEa63v9LiAF+XeLm7soXW/KM/UN+hDERWCzzPMI5zZ7TTQ8ETqLDrb7I
         xeJeLOXSwWf/3JrQzLRPfTuH/l0vjbyZipwotreyaXdR6lLex/vHmZGqR+tO5vrsOgrI
         CR1OI2bVJzYzoXD71JFiLThOhZ094NPEwNJ9fbxb4qybGXo7ys9ulK1kLBskeEtSMKLN
         E/7AxCBHyEMUlC9JCO8YQ1TaL8wa7gDq2tKZcJaC/W5SqvampQrBaFeB9qxAZbVTbTBg
         C+zQ==
X-Gm-Message-State: AFqh2koYnzkj/hGMSQ83g7eSXDn6yrgHjEWBWNiTx2WA6k0iEYEdZUkc
        4KUKfPIYUUZj0ta3maHOJ2GE5vdKIhRJiioYA+A=
X-Google-Smtp-Source: AMrXdXupu/1FI93ab82lKxOAQOukaWgfQt0mbhiYdnR1alr0jr7Py31loAYCsJHQFCxUER/lwPA6F1GNJ7IGujyerxk=
X-Received: by 2002:a05:6402:202:b0:48e:bf8a:23c6 with SMTP id
 t2-20020a056402020200b0048ebf8a23c6mr3650315edv.133.1674581068881; Tue, 24
 Jan 2023 09:24:28 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com> <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com> <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
 <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev> <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
 <87k01dvt83.fsf@cloudflare.com> <CAMy7=ZXyqCzhosiwpLa9rsFqW2jX4V59-Ef4k-5dQtqKOakTFQ@mail.gmail.com>
 <CAADnVQJaCTQtmvOdQoeaZbt0wwPp4iYjbvaPvRZw4DBEOSrJYg@mail.gmail.com> <CAMy7=ZVpGMOK_kHk1qB4ywxV88Vvtt=rGw4Q-Fi1F7bGU+6prQ@mail.gmail.com>
In-Reply-To: <CAMy7=ZVpGMOK_kHk1qB4ywxV88Vvtt=rGw4Q-Fi1F7bGU+6prQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 24 Jan 2023 09:24:17 -0800
Message-ID: <CAADnVQLaKyRJwXnU4wZrih4pRduw_eWarA2uNuc=HssKQUAn_Q@mail.gmail.com>
Subject: Re: Are BPF programs preemptible?
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@meta.com>
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

On Tue, Jan 24, 2023 at 7:47 AM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=
=D7=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-14:30 =D7=9E=D7=90=D7=
=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On Mon, Jan 23, 2023 at 2:03 PM Yaniv Agman <yanivagman@gmail.com> wrot=
e:
> > >
> > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-23:25 =D7=9E=D7=90=
=D7=AA =E2=80=AAJakub Sitnicki=E2=80=AC=E2=80=8F
> > > <=E2=80=AAjakub@cloudflare.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > >
> > > > On Mon, Jan 23, 2023 at 11:01 PM +02, Yaniv Agman wrote:
> > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-22:06 =D7=9E=D7=
=90=D7=AA =E2=80=AAMartin KaFai Lau=E2=80=AC=E2=80=8F
> > > > > <=E2=80=AAmartin.lau@linux.dev=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > >>
> > > > >> On 1/23/23 9:32 AM, Yaniv Agman wrote:
> > > > >> >>> interrupted the first one. But even then, I will need to fin=
d a way to
> > > > >> >>> know if my program currently interrupts the run of another p=
rogram -
> > > > >> >>> is there a way to do that?
> > > > >> May be a percpu atomic counter to see if the bpf prog has been r=
e-entered on the
> > > > >> same cpu.
> > > > >
> > > > > Not sure I understand how this will help. If I want to save local
> > > > > program data on a percpu map and I see that the counter is bigger=
 then
> > > > > zero, should I ignore the event?
> > > >
> > > > map_update w/ BPF_F_LOCK disables preemption, if you're after updat=
ing
> > > > an entry atomically. But it can't be used with PERCPU maps today.
> > > > Perhaps that's needed now too.
> > >
> > > Yep. I think what is needed here is the ability to disable preemption
> > > from the bpf program - maybe even adding a helper for that?
> >
> > I'm not sure what the issue is here.
> > Old preempt_disable() doesn't mean that one bpf program won't ever
> > be interrupted by another bpf prog.
> > Like networking bpf prog in old preempt_disable can call into something
> > where there is a kprobe and another tracing bpf prog will be called.
> > The same can happen after we switched to migrate_disable.
>
> One difference here is that in what you describe the programmer can
> know in advance which functions might call others and avoid that or
> use other percpu maps, but if preemption can happen between functions
> which are not related to one another (don't have a relation of caller
> and callee), then the programmer can't have control over it

Could you give a specific example?
