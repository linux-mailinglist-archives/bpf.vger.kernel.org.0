Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8206BD41F
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 16:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjCPPly (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 11:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjCPPlb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 11:41:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1AFB5B5F
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 08:40:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso6016561pjf.0
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678981249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Zf0r0knvTm6O9k3Qn4deNTJAAnbUGf5R4f4+nuqAU8=;
        b=gvgc47K2qexz4MgyVGc2O+3FJA2HxE+P3lAU+RBkhhZaN+JtLoWDnu7Z6gs//b2WkC
         pPvLNcQeOJ/EyppavO8O4kLis64c/BoTGskrqil5AqYtb7/NInqvEFig75XyWiTufX9x
         K6Kx4jX/WQlOGv8pIR014W/DjoljQxsZ37FeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678981249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Zf0r0knvTm6O9k3Qn4deNTJAAnbUGf5R4f4+nuqAU8=;
        b=5d2XR19a8o0RrzY3zrAHBzT2C//S7WTjCnQNX812l/TyQFXMM28/OoT1leULEi8E3i
         hY4jKFf6e8+r183TCuUJKxGl1DA5oSmgI+gR0vC7EGGOGUQaxvnZu6PPQfQbS348xkAy
         C5ALKdXj3r/B5DlQqF4jykIUiINxvBZ8lDQECdVjaoE91fbYwRBucVxqdvcOjzvbnu0E
         YTOSE7kOU3yJ/ixUZJaHdbszyIfxrxXRDV60bWz3yIl6j+H+c0I626Hq3Nmt2y2YJhZB
         IKNI6MTKKWZY/lMhrHyymVk44e2klpyog+ePJ/16KPUEC5kdEt1zNVCPdGZxWAydW7Gl
         YY2A==
X-Gm-Message-State: AO0yUKVzrszB91+afWVnbuEvBQYNI1UAaovDIuSqElhlq2jRcM8+GNvK
        evF6+jdf8ceLSd8oXdKfz87BoHWl6bRq5XCA/CPuHA==
X-Google-Smtp-Source: AK7set+E6PVY0yTT+L43TR+gkYSZLjlEd+NOxAzTnBh0cU8Z4puLD6c6/eRUYhSh9kwQLFeTcy+C3i9PHyM/7XomNVo=
X-Received: by 2002:a17:903:3291:b0:1a0:52f1:8ea7 with SMTP id
 jh17-20020a170903329100b001a052f18ea7mr1565197plb.12.1678981249495; Thu, 16
 Mar 2023 08:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230207182135.2671106-1-revest@chromium.org> <20230207182135.2671106-2-revest@chromium.org>
 <20230315193355.30c48764@gandalf.local.home>
In-Reply-To: <20230315193355.30c48764@gandalf.local.home>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 16 Mar 2023 16:40:38 +0100
Message-ID: <CABRcYmKeYM9cG2=ZLTmVL3PA+zqzBd_NUP059tochsus0-9Rnw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 16, 2023 at 12:33=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue,  7 Feb 2023 19:21:26 +0100
> Florent Revest <revest@chromium.org> wrote:
>
> > The _multi API requires that users keep their own ops but can enforce
> > that an op is only associated to one direct call.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Tested-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  kernel/trace/trace_selftest.c         | 11 +++++++----
> >  samples/ftrace/ftrace-direct-modify.c | 12 ++++++++----
> >  samples/ftrace/ftrace-direct-too.c    | 12 +++++++-----
> >  samples/ftrace/ftrace-direct.c        | 12 +++++++-----
> >  4 files changed, 29 insertions(+), 18 deletions(-)
> >
> > diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftes=
t.c
> > index ff0536cea968..57221f69a33b 100644
> > --- a/kernel/trace/trace_selftest.c
> > +++ b/kernel/trace/trace_selftest.c
> > @@ -806,6 +806,9 @@ trace_selftest_startup_function_graph(struct tracer=
 *trace,
> >       int ret;
> >       unsigned long count;
> >       char *func_name __maybe_unused;
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > +     struct ftrace_ops direct =3D {};
>
> Make this static to the file and move it above to where there's already a=
n
> #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS block.
>
> Less #ifdef is better, and also, I don't like having as an example an
> ftrace_ops structure allocated on the stack. It can become increasingly
> larger as time goes by. I don't want to encourage placing it on stacks.

Agreed.

> > +#endif
> >
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> >       if (ftrace_filter_param) {
> > @@ -870,8 +873,8 @@ trace_selftest_startup_function_graph(struct tracer=
 *trace,
> >        * Register direct function together with graph tracer
> >        * and make sure we get graph trace.
> >        */
> > -     ret =3D register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NA=
ME,
> > -                                  (unsigned long) trace_direct_tramp);
> > +     ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME=
, 0, 0);
> > +     ret =3D register_ftrace_direct_multi(&direct, (unsigned long)trac=
e_direct_tramp);
> >       if (ret)
> >               goto out;
>
> I had to rebase this code on top of the latest tree because of updates.
> Which is good, because this patch requires those same. When using
> ftrace_set_filter_ip() one needs to call
>
>    ftrace_free_filter(&direct);
>
> Because the ftrace_set_filter_ip() allocates hashs on the ftrace_ops and
> those need to be freed.

Ah yes, good catch.

>
> >
> > @@ -891,8 +894,8 @@ trace_selftest_startup_function_graph(struct tracer=
 *trace,
> >
> >       unregister_ftrace_graph(&fgraph_ops);
> >
> > -     ret =3D unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_=
NAME,
> > -                                    (unsigned long) trace_direct_tramp=
);
> > +     ret =3D unregister_ftrace_direct_multi(&direct,
> > +                                          (unsigned long) trace_direct=
_tramp);
> >       if (ret)
> >               goto out;
> >
> > diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftr=
ace-direct-modify.c
> > index de5a0f67f320..ecd76f75cb80 100644
> > --- a/samples/ftrace/ftrace-direct-modify.c
> > +++ b/samples/ftrace/ftrace-direct-modify.c
> > @@ -96,6 +96,8 @@ asm (
> >
> >  #endif /* CONFIG_S390 */
> >
> > +static struct ftrace_ops direct;
> > +
> >  static unsigned long my_tramp =3D (unsigned long)my_tramp1;
> >  static unsigned long tramps[2] =3D {
> >       (unsigned long)my_tramp1,
> > @@ -114,7 +116,7 @@ static int simple_thread(void *arg)
> >               if (ret)
> >                       continue;
> >               t ^=3D 1;
> > -             ret =3D modify_ftrace_direct(my_ip, my_tramp, tramps[t]);
> > +             ret =3D modify_ftrace_direct_multi(&direct, tramps[t]);
> >               if (!ret)
> >                       my_tramp =3D tramps[t];
> >               WARN_ON_ONCE(ret);
> > @@ -129,7 +131,9 @@ static int __init ftrace_direct_init(void)
> >  {
> >       int ret;
> >
> > -     ret =3D register_ftrace_direct(my_ip, my_tramp);
> > +     ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
> > +     ret =3D register_ftrace_direct_multi(&direct, my_tramp);
> > +
> >       if (!ret)
> >               simple_tsk =3D kthread_run(simple_thread, NULL, "event-sa=
mple-fn");
> >       return ret;
> > @@ -138,12 +142,12 @@ static int __init ftrace_direct_init(void)
> >  static void __exit ftrace_direct_exit(void)
> >  {
> >       kthread_stop(simple_tsk);
> > -     unregister_ftrace_direct(my_ip, my_tramp);
> > +     unregister_ftrace_direct_multi(&direct, my_tramp);
>
> Same here.
>
> >  }
> >
> >  module_init(ftrace_direct_init);
> >  module_exit(ftrace_direct_exit);
> >
> >  MODULE_AUTHOR("Steven Rostedt");
> > -MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()")=
;
> > +MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_mul=
ti()");
> >  MODULE_LICENSE("GPL");
> > diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace=
-direct-too.c
> > index e13fb59a2b47..0e907092e2c0 100644
> > --- a/samples/ftrace/ftrace-direct-too.c
> > +++ b/samples/ftrace/ftrace-direct-too.c
> > @@ -70,21 +70,23 @@ asm (
> >
> >  #endif /* CONFIG_S390 */
> >
> > +static struct ftrace_ops direct;
> > +
> >  static int __init ftrace_direct_init(void)
> >  {
> > -     return register_ftrace_direct((unsigned long)handle_mm_fault,
> > -                                  (unsigned long)my_tramp);
> > +     ftrace_set_filter_ip(&direct, (unsigned long) handle_mm_fault, 0,=
 0);
> > +
> > +     return register_ftrace_direct_multi(&direct, (unsigned long) my_t=
ramp);
> >  }
> >
> >  static void __exit ftrace_direct_exit(void)
> >  {
> > -     unregister_ftrace_direct((unsigned long)handle_mm_fault,
> > -                              (unsigned long)my_tramp);
> > +     unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
>
> And here.
>
> >  }
> >
> >  module_init(ftrace_direct_init);
> >  module_exit(ftrace_direct_exit);
> >
> >  MODULE_AUTHOR("Steven Rostedt");
> > -MODULE_DESCRIPTION("Another example use case of using register_ftrace_=
direct()");
> > +MODULE_DESCRIPTION("Another example use case of using register_ftrace_=
direct_multi()");
> >  MODULE_LICENSE("GPL");
> > diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-dir=
ect.c
> > index 1f769d0db20f..e446c38f6b58 100644
> > --- a/samples/ftrace/ftrace-direct.c
> > +++ b/samples/ftrace/ftrace-direct.c
> > @@ -63,21 +63,23 @@ asm (
> >
> >  #endif /* CONFIG_S390 */
> >
> > +static struct ftrace_ops direct;
> > +
> >  static int __init ftrace_direct_init(void)
> >  {
> > -     return register_ftrace_direct((unsigned long)wake_up_process,
> > -                                  (unsigned long)my_tramp);
> > +     ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0,=
 0);
> > +
> > +     return register_ftrace_direct_multi(&direct, (unsigned long) my_t=
ramp);
> >  }
> >
> >  static void __exit ftrace_direct_exit(void)
> >  {
> > -     unregister_ftrace_direct((unsigned long)wake_up_process,
> > -                              (unsigned long)my_tramp);
> > +     unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
>
> And here.
>
> Maybe we could add a parameter to unregister_ftrace_direct_multi():
>
>   bool free_filters
>
> when set, it will call the ftrace_free_filter(), as it looks like there's=
 a
> common code path here:
>
>         ftrace_set_filter_ip();
>         register_ftrace_direct_multi();
>         [..]
>         unregister_ftrace_direct_multi();
>         ftrace_free_filter();
>
> Add the option will save people from having to do that last step, and als=
o
> remind people that the filters need to be freed.

I agree, it's otherwise quite easy to miss the ftrace_free_filter. :)
I'll add a patch introducing this "free_filters" arg in the new subset
series that I'll send you directly.
