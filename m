Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA68A679819
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 13:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjAXMaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 07:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjAXMaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 07:30:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5114017CF7
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 04:30:14 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z11so18143074ede.1
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 04:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGzOlES+UfstrZ/C/xYI6+FfAqoiYQF+jacaUk3bXLc=;
        b=arEb0Ig50FhFu7iWAD0gnGEOBUw8vCE2SDtcu527gIbOOEl947DVvBcmu3QnJIn/qN
         jkA4/aBlconHgkU6qNLiA4mPns5o7rbs6Fljc07ui9hCcp3ZAlywTlnv7ROBFtx5VU89
         RgdxAOA50k06yx4VAbMDYbW39OV6TcfDyf1TGcCOlp43pZrcV/Oc4jV3Em/Rec/7Ho2A
         mwUYK1ee1R/8LGyD/126ijkLVrKc9/+XOWbDpU8fO2cF6ev62p83akZqjXsJ9BAV5h8A
         trLD+4bPF5dLTvD7Y+AiF7b/WU6aR8vfa8l3erECGCdFKKcghsvwDJ+N44tFayDayToG
         Kxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGzOlES+UfstrZ/C/xYI6+FfAqoiYQF+jacaUk3bXLc=;
        b=u+RcKclbKzcbOrMf10QTR8FJveqhVLLRMhUDQ/iusA5yQ+9/y4MgoFvMP3n2oyv+sG
         QzLiSXMDYD0X5gr6PEGdlOS3U0C53WJniv/lRAlx+eO5rP5rxjuxgLCbELbpP6ip7nb+
         Uo8FAzfOVV3fdlWrUajRsFmTRp5SUiDqfk9lM8kvVrhvAKx0vXU8RGdMB6cGcLAoXf+b
         9vSyItTRnUFKR+DF7NwK/2RTP3OaemkQcAziuaHSNgIDRlNojSbSaDS6iAipqo2LoB9/
         KRgqun9aLAOut50GAXpvWK6n5kRdsGraMUxh3mmSF3YCISstB2CnLk+Y2A5Rw5r6+tNn
         dHng==
X-Gm-Message-State: AFqh2koIikUrZK9bnk7EElHjTZwdyxx4JiYrSha/vT8QcORQaCxLGknP
        6ReGwzhvoeM2FTUuLbe/cLcfFW38rnVBFgn2uTyDan3A
X-Google-Smtp-Source: AMrXdXtAz+kvmeg9J8bTpRo1rxs6g8wOLwD7k7y9OF4S65LEoKtCxX9oDcD/9lUH+LjBSlitDqgAxvASX0yXe415Bvk=
X-Received: by 2002:aa7:dd5a:0:b0:49c:eba3:5bf8 with SMTP id
 o26-20020aa7dd5a000000b0049ceba35bf8mr3458555edw.117.1674563412769; Tue, 24
 Jan 2023 04:30:12 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com> <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com> <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
 <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev> <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
 <87k01dvt83.fsf@cloudflare.com> <CAMy7=ZXyqCzhosiwpLa9rsFqW2jX4V59-Ef4k-5dQtqKOakTFQ@mail.gmail.com>
In-Reply-To: <CAMy7=ZXyqCzhosiwpLa9rsFqW2jX4V59-Ef4k-5dQtqKOakTFQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 24 Jan 2023 04:30:01 -0800
Message-ID: <CAADnVQJaCTQtmvOdQoeaZbt0wwPp4iYjbvaPvRZw4DBEOSrJYg@mail.gmail.com>
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

On Mon, Jan 23, 2023 at 2:03 PM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-23:25 =D7=9E=D7=90=D7=
=AA =E2=80=AAJakub Sitnicki=E2=80=AC=E2=80=8F
> <=E2=80=AAjakub@cloudflare.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On Mon, Jan 23, 2023 at 11:01 PM +02, Yaniv Agman wrote:
> > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-22:06 =D7=9E=D7=90=
=D7=AA =E2=80=AAMartin KaFai Lau=E2=80=AC=E2=80=8F
> > > <=E2=80=AAmartin.lau@linux.dev=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >>
> > >> On 1/23/23 9:32 AM, Yaniv Agman wrote:
> > >> >>> interrupted the first one. But even then, I will need to find a =
way to
> > >> >>> know if my program currently interrupts the run of another progr=
am -
> > >> >>> is there a way to do that?
> > >> May be a percpu atomic counter to see if the bpf prog has been re-en=
tered on the
> > >> same cpu.
> > >
> > > Not sure I understand how this will help. If I want to save local
> > > program data on a percpu map and I see that the counter is bigger the=
n
> > > zero, should I ignore the event?
> >
> > map_update w/ BPF_F_LOCK disables preemption, if you're after updating
> > an entry atomically. But it can't be used with PERCPU maps today.
> > Perhaps that's needed now too.
>
> Yep. I think what is needed here is the ability to disable preemption
> from the bpf program - maybe even adding a helper for that?

I'm not sure what the issue is here.
Old preempt_disable() doesn't mean that one bpf program won't ever
be interrupted by another bpf prog.
Like networking bpf prog in old preempt_disable can call into something
where there is a kprobe and another tracing bpf prog will be called.
The same can happen after we switched to migrate_disable.
