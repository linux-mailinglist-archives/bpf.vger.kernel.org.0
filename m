Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6D26F0742
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbjD0OXm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 10:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243764AbjD0OXZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 10:23:25 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A124EFE;
        Thu, 27 Apr 2023 07:22:59 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-74dfa88c65aso732109085a.3;
        Thu, 27 Apr 2023 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682605378; x=1685197378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihii9EjlXiAdx0f82DQddbpxiD6F+hujfxzkjDoYupw=;
        b=iam8C2iaAP/nvY5obUIGDwucNtlXUMapen7RQk6Z8yC/DSoLZX8WOqaIdZ4TazF1CT
         ukjcsikbQkOmptMQNd7ezTGku69ABKA01nlOOn5LZMnxR1oidIRTZlv+NPnnBF6Qf0B4
         lqhFD+HPQ2e3IdE/v0NKSY3cGVz6LllwSWUsEZeBq8jFAkThpeDLW+ekekD8cYJ/L0ik
         uWC9YvmuudvtwdbslkFQ4agjAti5LH7vRlwy7kNPj0EX1Y5qRKnPD9tjDb0pniN4hZi4
         Fhdf6mGXgZScubch6BhgXLkgPplKk7gRKuVt4V8mfmJb16NRRJ51BHzpj41yNIAjBUYu
         8zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682605378; x=1685197378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihii9EjlXiAdx0f82DQddbpxiD6F+hujfxzkjDoYupw=;
        b=jhR3mjeD5X4zg/jxqUI8Olw4WSYAsDPW1nEopCXKIvTDQLX6FZIYVswxbxM/dJiZEv
         eVYCMpXwTAcRylE807/M4CQo2uImIoxN5/ZPKulLIaB0PPQ6yj3RR8VriM1UZAAdDEHI
         I/hOIH4WV3Ht4g6bDsGB/uZKvDuXppRLGpjnjdEbmwOO0d+yilsZCPLLXiucUwRhhnTC
         5mrTu92gBfDQdbMlFmnLpAjoY45l5vXGajj9x8qK3TXvEoaKQLqAK5lvtj46fTNmuWHw
         hpmx/bDXfwUwHvR2UGLXjIErRtcy8J+TzAjGkhdXEK6nDTj3gLKvvaX6bDRsccfe79Em
         vZZA==
X-Gm-Message-State: AC+VfDxFuhtfeuHs7S7PsRmLmooW9ZWx/cHXYAneSkDue9TNx+CtdeSF
        a8lFtQMb2MNJoSuoTpWzhNabhnvG+Zgy3n/mK9VEXVaaqWPkTQ==
X-Google-Smtp-Source: ACHHUZ6ZE8lQRjSnUKI0P72E0fIK02tEQnqR5cJJdB9neS/jgZIcacpO4/4gzyf+g4w51NIAvTh1WNLJhyqyirfznv4=
X-Received: by 2002:a05:6214:1c4e:b0:5f0:23be:a301 with SMTP id
 if14-20020a0562141c4e00b005f023bea301mr2631139qvb.5.1682605378480; Thu, 27
 Apr 2023 07:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230417154737.12740-1-laoar.shao@gmail.com> <20230417154737.12740-6-laoar.shao@gmail.com>
 <20230427092628.21fd23e4@gandalf.local.home>
In-Reply-To: <20230427092628.21fd23e4@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 27 Apr 2023 22:22:22 +0800
Message-ID: <CALOAHbBX1C-eg93Hf3xPLsdsaBzoGn1pHh9jb3Z_-T-7HD60wA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention mechanism
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Apr 27, 2023 at 9:26=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 17 Apr 2023 15:47:36 +0000
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index f61d513..3df39a5 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -842,15 +842,21 @@ static __always_inline u64 notrace bpf_prog_start=
_time(void)
> >  static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struc=
t bpf_tramp_run_ctx *run_ctx)
> >       __acquires(RCU)
>
> Because __bpf_prog_enter_recur() and __bpf_prog_exit_recur() can
> legitimately nest (as you pointed out later in the thread), I think my
> original plan is the way to go.
>
>
>
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
> > +     run_ctx->recursion_bit =3D bit;
> > +     if (bit < 0) {
> > +             preempt_disable_notrace();
> >               bpf_prog_inc_misses_counter(prog);
> > +             preempt_enable_notrace();
> >               return 0;
> >       }
> > +
> > +     migrate_disable();
>
> Just encompass the migrate_disable/enable() with the recursion protection=
.
>
> That is, here add:
>
>         test_recursion_release(recursion_bit);
>
> No need to save it in the run_ctx, as you can use a local variable.
>
> As I mentioned, if it passes when checking migrate_disable() it will also
> pass when checking around migrate_enable() so the two will still be paire=
d
> properly, even if only the migrate_enable() starts recursing.
>
>
>   bit =3D test_recursion_try_acquire() // OK
>   if (bit < 0)
>         return;
>   migrate_disable();
>   test_recursion_release(bit);
>
>   [..]
>
>   bit =3D test_recursion_try_acquire() // OK
>   migrate_enable() // traced and recurses...
>
>     bit =3D test_recursion_try_acquire() // fails
>     if (bit < 0)
>           return; // returns here
>     migrate_disable() // does not get called.
>
> The recursion around migrate_disable/enable() is needed because it's done
> before other checks. You can't attach the test_recursion logic to the
> __bpf_prog_enter/exit() routines, because those can legitimately recurse.
>

IIUC, the acquire/release pair works as follows,

   test_recursion_try_acquire
     [ protection area ]
   test_recursion_release

After release, there will be no protection, and thus it will fail the
tools/testing/selftests/bpf/progs/recursion.c[1] test case, because
the recursion occurs in the bpf_prog_run() itself,

  __bpf_prog_enter
     test_recursion_try_acquire
     [...]
     test_recursion_release
  // no protection after the release
  bpf_prog_run()
    bpf_prog_run() // the recursion can't be prevented.
        __bpf_prog_enter
            test_recursion_try_acquire
            [...]
            test_recursion_release
       bpf_prog_run()
           bpf_prog_run()
               __bpf_prog_enter
                  test_recursion_try_acquire
                  [...]
                  test_recursion_release
              bpf_prog_run()
              [ And so on ... ]

[1]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/=
tools/testing/selftests/bpf/progs/recursion.c#n38

--=20
Regards
Yafang
