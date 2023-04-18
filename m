Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437FB6E5728
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 03:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDRBvy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 21:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjDRBvx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 21:51:53 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2721C19A6;
        Mon, 17 Apr 2023 18:51:17 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id me15so7034411qvb.4;
        Mon, 17 Apr 2023 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681782591; x=1684374591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7a6S2fWZYFzPFmPdbHoXKoOqx5GTXT/tFpcCrdO71c=;
        b=ll+jtBq/Iq7g4EWx+raUAFK8CnDCweG1yJn1s23TOfhXF0F7waGOc7S4B2M72MJXHZ
         d4Vi+B9+bQ+Bq/Ym77R3HJUoOrab9QB7LCSPRyeEjg6EYgKkIyDVtRHrlEx2kJM10fWA
         YN2y/HwozYSGHbwNzX+Y2ipLKklupLNha1gJXCeZL0hHylzr1BjlnrXWjeZbbw58HUV1
         19zKVhDl0YZ9wn6Sn/oVoCkZUEtigAlX8Q9Ykqlug7gCaz53Ufsj3GwAF7ytssIeYLPN
         u53r7Uy2j7Wq4ukwjRKVWUhd0fix5bwM+k4tZxSctVegTFJVLzi+/cMBWBNbJhDZeQkN
         tW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782591; x=1684374591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7a6S2fWZYFzPFmPdbHoXKoOqx5GTXT/tFpcCrdO71c=;
        b=f3j9DMLHzLOPU2RGX1pitbciexAL+MJXDb3ZK5cpfTvIrzvT/JcWVm6S5IIZCJ6wJi
         jBtMpFpaACgqKhaPlSKRB06c0ebP4s23Ka9Uh0r0dslaT75/R/0w3HfktjPqAQnUWXHF
         Dhxi4yIRTikP5/CK8LBKzKiNYlg6PViWHOjPnq6Tlb2ODxm60MLD0P4r2nZfln0pHn2H
         YsviasrawlUBUgG+vGC0rMMxeuBGr5swcRy7tQG0w13oo1W60OGY5yt6t/Bm1Yx+ottA
         0yR/aOQ0F6YV0SainyGowz2YuaqYNA86Z5Tu3Ygo/ra8qBWtKWuH8+71T+E+uD/sVhrE
         E8LQ==
X-Gm-Message-State: AAQBX9du9IG42XTbgKvUI+bhSxT0hEQPf73Jn/P8w/JhwNmR5NbORyAR
        uKIh5HIEvA00BYq7WMkyGmy7JAcYcu3kas0/6SM=
X-Google-Smtp-Source: AKy350YVTzsQV/D+Yaag/9o3NagW64of/FBjDyYCTBzo4auEHG/0P3yksm2ypt7Uksn7q8kutZ8WCddAQs7eR5Gre+o=
X-Received: by 2002:ad4:5f06:0:b0:5ef:8b3a:5b9 with SMTP id
 fo6-20020ad45f06000000b005ef8b3a05b9mr4731293qvb.1.1681782590896; Mon, 17 Apr
 2023 18:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230417154737.12740-1-laoar.shao@gmail.com> <20230417154737.12740-6-laoar.shao@gmail.com>
 <20230417201457.c43xfcukjzm4u6vx@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230417201457.c43xfcukjzm4u6vx@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 18 Apr 2023 09:49:14 +0800
Message-ID: <CALOAHbC4Bz_VX52zmv=sScBf0hzscMAC4+EwMCpnd1BcaSVJSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention mechanism
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Apr 18, 2023 at 4:15=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 17, 2023 at 03:47:36PM +0000, Yafang Shao wrote:
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index f61d513..3df39a5 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -842,15 +842,21 @@ static __always_inline u64 notrace bpf_prog_start=
_time(void)
> >  static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struc=
t bpf_tramp_run_ctx *run_ctx)
> >       __acquires(RCU)
> >  {
> > -     rcu_read_lock();
> > -     migrate_disable();
> > -
> > -     run_ctx->saved_run_ctx =3D bpf_set_run_ctx(&run_ctx->run_ctx);
> > +     int bit;
> >
> > -     if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
> > +     rcu_read_lock();
> > +     bit =3D test_recursion_try_acquire(_THIS_IP_, _RET_IP_);
>
> and bpf will prevent ftrace to run and vice versa.
> Not a good idea.
>
> One bpf prog will prevent different bpf prog to run since they share curr=
ent task.
> Not a good idea either.

That shouldn't happen. test_recursion_try_acquire() uses a
per-task_struct value. One single task_struct can't run in parallel,
right?
Note that the bpf program running in softirq or irq context won't be
prevented by it.
IIUC, the bpf program should run in serial in one single task, right?
That said, one bpf program can only run after another bpf program
finished in the same task?

--=20
Regards
Yafang
