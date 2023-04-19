Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699066E78E9
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjDSLrS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 07:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDSLrR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 07:47:17 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7B54C22;
        Wed, 19 Apr 2023 04:47:15 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id dd8so19810868qvb.13;
        Wed, 19 Apr 2023 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681904834; x=1684496834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyDadJE1NbgjC8wC5oHDlohplbMrXbFJOr8OYm4fr0g=;
        b=RzsTjKIWM6yKFuZODaI9MT7527b8MzXaBq+WUh30FXCvOUVRowFcFr90uQ+y0SB5Ha
         Nbs44J8KP09W+ZINagNZPy7o7Wp+Bybwo6jXkNE+8esZ6aq01Lt2/wNs1PNPptjooC0F
         6LNfgb+yv9sSw3vdkTTHRBVvhOt0+PRPRrPSA5C5Q5e4vGu432K3UgFP2PFFrfakG2pi
         d/tSEjGL/Bq33rdcWVK9vOo0wD7B8JCfXSdijc/6guL11ssJFTWUxMd648Ee3ejvixQS
         Xh2TzVTxSdZZQn78hRPTmuxx3GZEhU38U6bO0liS+d+BMX1hd/y2l4UwN8+cvtqS+lZY
         zD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681904834; x=1684496834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyDadJE1NbgjC8wC5oHDlohplbMrXbFJOr8OYm4fr0g=;
        b=Dpo/tFKDVCx2y2Aj2NTJhMs+QQm4Xf4gJEh0rNdz9UYErL0J/XuMIAepKhyDPcRVT3
         fbajH0uAFsLn2W6Vk/M2bGrayUNZS59nVvpwTzjUbHW31mI5/6SXXBvcQWJdO93KSjp5
         HqfPP5pSeG5vPotieWzFZuym9AXZ0PdMFWXsGiXCKrI5aSJk9AWlOGzuqM38h4Dlhwxn
         bL/biawgdpDIGPOgiYAoTH7IZjEXiaaLM2HDC8df1DsuTAQFrb2LoqJpaAjRqkIo+bcO
         hc5uCvYXymZd6CJT/P33J92m1f9jbtn6UW6bCKYoh87Y45mmLBYDkqc3hF7/ldWUpJXz
         D+vA==
X-Gm-Message-State: AAQBX9dO+JQ7j0FAn9LNbny1jwquAEWHDj1A+eLrjLppR2RqChC7NZqf
        Deaeiij7mcDEdk9GryhQy+UZYxGNWFv0hXM5q9o=
X-Google-Smtp-Source: AKy350alDLnATEjliOOTmkIQ3+3cIHSnEkNtmVKehwKlEUoOwVP1HXCWzUwHYwRbame9IrQOAbt6wQ543n2m2VHD8z0=
X-Received: by 2002:a05:6214:2348:b0:5f1:6892:7437 with SMTP id
 hu8-20020a056214234800b005f168927437mr4619986qvb.26.1681904834432; Wed, 19
 Apr 2023 04:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230417154737.12740-1-laoar.shao@gmail.com> <20230417154737.12740-6-laoar.shao@gmail.com>
 <20230417201457.c43xfcukjzm4u6vx@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbC4Bz_VX52zmv=sScBf0hzscMAC4+EwMCpnd1BcaSVJSw@mail.gmail.com> <CAADnVQJw9BCK2itE5bZWdQYz7D-8KdcH96E885zUakEDAOrC+Q@mail.gmail.com>
In-Reply-To: <CAADnVQJw9BCK2itE5bZWdQYz7D-8KdcH96E885zUakEDAOrC+Q@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 19 Apr 2023 19:46:38 +0800
Message-ID: <CALOAHbCtPR26it_Wdk7T_TETMTh2se6rgEbL_KC5XKtzvObjiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention mechanism
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Tue, Apr 18, 2023 at 11:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 17, 2023 at 6:49=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Tue, Apr 18, 2023 at 4:15=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Apr 17, 2023 at 03:47:36PM +0000, Yafang Shao wrote:
> > > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > > index f61d513..3df39a5 100644
> > > > --- a/kernel/bpf/trampoline.c
> > > > +++ b/kernel/bpf/trampoline.c
> > > > @@ -842,15 +842,21 @@ static __always_inline u64 notrace bpf_prog_s=
tart_time(void)
> > > >  static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, s=
truct bpf_tramp_run_ctx *run_ctx)
> > > >       __acquires(RCU)
> > > >  {
> > > > -     rcu_read_lock();
> > > > -     migrate_disable();
> > > > -
> > > > -     run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx)=
;
> > > > +     int bit;
> > > >
> > > > -     if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
> > > > +     rcu_read_lock();
> > > > +     bit =3D test_recursion_try_acquire(_THIS_IP_, _RET_IP_);
> > >
> > > and bpf will prevent ftrace to run and vice versa.
> > > Not a good idea.
> > >
> > > One bpf prog will prevent different bpf prog to run since they share =
current task.
> > > Not a good idea either.
> >
> > That shouldn't happen. test_recursion_try_acquire() uses a
> > per-task_struct value. One single task_struct can't run in parallel,
> > right?
> > Note that the bpf program running in softirq or irq context won't be
> > prevented by it.
> > IIUC, the bpf program should run in serial in one single task, right?
> > That said, one bpf program can only run after another bpf program
> > finished in the same task?
>
> bpf progs can nest in the same task.

Do you mean the tail_call ?

--=20
Regards
Yafang
