Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC136E6867
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 17:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjDRPjE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 11:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRPjD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 11:39:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC91384D;
        Tue, 18 Apr 2023 08:38:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f0dd117dcso202099866b.3;
        Tue, 18 Apr 2023 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681832336; x=1684424336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRhoPtoWvk9JTnFy49QmkeA3jHwK2uTwQ5tD3o618bk=;
        b=q93AsTVnuVuSJXdEtyd+uD0Tau1ePOodDrmgL6PqFKV7eknMxjMyIUHg1n/camoF4J
         a8N0rRjm64Kw2984e4v/ieQP552ueI/fqH65vnEwa/FMDy7vXwx0cwBtnuLaaIHvwnlD
         kL8zd2fAhiv2KCGHnMp8A4cSxi6siuaCr4K/aOy2nhwOcU8XE+gcb15snZCBqo1eZK5Y
         89pfuPqIgewArS7NGCwATb2UofhJCa00vSqSPQ3QhMZusBduxvu45FmeEApE61HJwAb2
         uRVO4yRLNZagGLXAldBjQKvLZpvidVs3h7yq677Rp7TyBE1egogpq/KFLUgbmM9WkJzb
         pdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832336; x=1684424336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRhoPtoWvk9JTnFy49QmkeA3jHwK2uTwQ5tD3o618bk=;
        b=KBclxZgE9bS2ImYOM3OhVqp3j6B2FJiz5Srp6PUQ18LUGu/aMm0h8HtZqNDegetIiG
         hexSCVA0iSILqOgNJtZF3bUV/HKJSg4bvcLUXvS+Tob1jJo97mX9kI7y31+hBYR3L8W/
         OYV7iIKzeBqQ2EJqnL38MpofWE/cLkCjmUee9EVtnOzve3T9lahFRiOF5rbLjMVWBq0/
         P+YTpD7Ht1K+D/xT1DjaUuc4PfSAHBXTFq4tdGB0UnedFsOICmC3ghpbzZL0G9gpPJB4
         A6fmpTdguvGHlCTgDwGLObFXaUfKqkmpBTwHZROovbW/sHEsd/8LgAS7bnZ9OgRR/15W
         C7Ew==
X-Gm-Message-State: AAQBX9cfF9K1Vc8UCezae3fLKrTnTEtxtBwdP/ch3HkMB0f5WXoAJKyA
        TWrKv434+lW14Sy/gehKuXqSi3ZprURsmW8Sokk=
X-Google-Smtp-Source: AKy350YjYYKN64Ltm6I9TaT/Oe8KxeMlHKbfYR55/dIdgsNWH7uNEiBi2JkswaP62CDU57Y9tnFgMkMrYjhv05ezGWk=
X-Received: by 2002:a50:d716:0:b0:506:34d8:c710 with SMTP id
 t22-20020a50d716000000b0050634d8c710mr1396132edi.3.1681832335506; Tue, 18 Apr
 2023 08:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230417154737.12740-1-laoar.shao@gmail.com> <20230417154737.12740-6-laoar.shao@gmail.com>
 <20230417201457.c43xfcukjzm4u6vx@dhcp-172-26-102-232.dhcp.thefacebook.com> <CALOAHbC4Bz_VX52zmv=sScBf0hzscMAC4+EwMCpnd1BcaSVJSw@mail.gmail.com>
In-Reply-To: <CALOAHbC4Bz_VX52zmv=sScBf0hzscMAC4+EwMCpnd1BcaSVJSw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Apr 2023 08:38:44 -0700
Message-ID: <CAADnVQJw9BCK2itE5bZWdQYz7D-8KdcH96E885zUakEDAOrC+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention mechanism
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 17, 2023 at 6:49=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Tue, Apr 18, 2023 at 4:15=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 17, 2023 at 03:47:36PM +0000, Yafang Shao wrote:
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index f61d513..3df39a5 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -842,15 +842,21 @@ static __always_inline u64 notrace bpf_prog_sta=
rt_time(void)
> > >  static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, str=
uct bpf_tramp_run_ctx *run_ctx)
> > >       __acquires(RCU)
> > >  {
> > > -     rcu_read_lock();
> > > -     migrate_disable();
> > > -
> > > -     run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx);
> > > +     int bit;
> > >
> > > -     if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
> > > +     rcu_read_lock();
> > > +     bit =3D test_recursion_try_acquire(_THIS_IP_, _RET_IP_);
> >
> > and bpf will prevent ftrace to run and vice versa.
> > Not a good idea.
> >
> > One bpf prog will prevent different bpf prog to run since they share cu=
rrent task.
> > Not a good idea either.
>
> That shouldn't happen. test_recursion_try_acquire() uses a
> per-task_struct value. One single task_struct can't run in parallel,
> right?
> Note that the bpf program running in softirq or irq context won't be
> prevented by it.
> IIUC, the bpf program should run in serial in one single task, right?
> That said, one bpf program can only run after another bpf program
> finished in the same task?

bpf progs can nest in the same task.
