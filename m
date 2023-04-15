Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AF36E31D7
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDOOd4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDOOdz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 10:33:55 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8ED4C22;
        Sat, 15 Apr 2023 07:33:54 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id e13so4235223qvd.8;
        Sat, 15 Apr 2023 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681569233; x=1684161233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98SKOP1mE62mRsT+52Gei0vrElTVPhWne3/ZXxbTYoU=;
        b=py49dJB+Cay9O/v9dtk19QWIyQFgGqFyIf+SHU2+LWOVxgUwxLs2xSd2gQlxtTIO8Q
         BkE+syagJMObwEGNpoOxRDjjgxo7VmVkJAuhqF2toBOuINfn8IsRx1L+gzQur29gz3A/
         tagGr68XzgYiWp5LVvA8KX6w6EehbKK19fqg5e4addtg/t0byGGgdR5BfoOPrxSoW8id
         h3P+cwSt1wrYc3jNkUphgZEjKGbBjF/mVs8OeNfxTy6eMFjIIP5/mewTz92Awy223wGR
         oPNTHYwy7/tupkauOp7i12NSZwvMJ0A8pLN+mkyqSwrCsJf1H0vnqtprGf1qPl/CSKXc
         0ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681569233; x=1684161233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98SKOP1mE62mRsT+52Gei0vrElTVPhWne3/ZXxbTYoU=;
        b=hKVq+Bz9FQu6wS1aAJlHYQP4wmbRHKqRj6tYTbV8tWIfPRIouF97s6mFUdXOuzfdTh
         TlWLbd2zhMe9Ft8u2oY0eLQkhgNBclG5fJSu7tK71H0GlLoa7YSSMAqRqOecl4LqXkAV
         qfJeaifZSNgYGfr0wp06nsbLSwgXCF5fKuVD9B/Am5ZI+sdvmstk7FLDNJIaD4oI+LFV
         hXKMZjzt5qyzLEpfSKlPITKImG7n55ZF0BO7OmUWTDXLHrfhUAssA/4qYdoKX2ACVcuO
         xlAxvk2+ipTRn4khXWSOraRSJtE5VPZVl5i7VLG68dhWlpVpaCWl7IDKMIuHMRkmWSW7
         rCpg==
X-Gm-Message-State: AAQBX9fp61+rJPDRrSEVH4g1oX6dyVCbHwFGJjRabV7UUzYldxAvJCJZ
        kj+YE690jH7eeYlCTCFGbMYjpcuVDRBSbbml4G8=
X-Google-Smtp-Source: AKy350aLH7WMumFWeWJNjahF8DXGeLoNC3OOJcYmA2inkZi5Xew8E6efYGnJIuZq4T9+lbPByqioRPRUnB3zTQvp//4=
X-Received: by 2002:a05:6214:29c4:b0:5ee:e20b:5dc1 with SMTP id
 gh4-20020a05621429c400b005eee20b5dc1mr9463599qvb.10.1681569233294; Sat, 15
 Apr 2023 07:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230414221702.554c44fe@rorschach.local.home> <CALOAHbDUkvyu0hWXfcveJBW_dxDkqUTVBmwXt5Y-ERBv9GksbQ@mail.gmail.com>
In-Reply-To: <CALOAHbDUkvyu0hWXfcveJBW_dxDkqUTVBmwXt5Y-ERBv9GksbQ@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 15 Apr 2023 22:33:17 +0800
Message-ID: <CALOAHbB9VvOAuA5kG3YpS-XMqX9AFGxbuOQWerJTQYgsqU182A@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add generic test_recursion_try_acquire()
To:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
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

On Sat, Apr 15, 2023 at 9:33=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Sat, Apr 15, 2023 at 10:17=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> >
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > The ftrace_test_recursion_trylock() also disables preemption. This is n=
ot
> > required, but was a clean up as every place that called it also disable=
d
> > preemption, and making the two tightly coupled appeared to make the cod=
e
> > simpler.
> >
> > But the recursion protection can be used for other purposes that do not
> > require disabling preemption. As the recursion bits are attached to the
> > task_struct, it follows the task, so there's no need for preemption bei=
ng
> > disabled.
> >
> > Add test_recursion_try_acquire/release() functions to be used generical=
ly,
> > and separate it from being associated with ftrace. It also removes the
> > "lock" name, as there is no lock happening. Keeping the "lock" for the
> > ftrace version is better, as it at least differentiates that preemption=
 is
> > being disabled (hence, "locking the CPU").
> >
> > Link: https://lore.kernel.org/linux-trace-kernel/20230321020103.13494-1=
-laoar.shao@gmail.com/
> >
> > Cc: Yafang Shao <laoar.shao@gmail.com>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
>
> +Alexei, bpf
>
> Thanks Steven.
> I almost finished replacing prog->active with
> test_recursion_try_{acquire,release}[1], and yet I need to do more
> tests.
>
> In my verification, I find that something abnormal happens. When I ran
> bpf self tests after the replacement, I found the fentry recursion
> test failed[2]. The test result as follows,
>
> main:PASS:skel_open_and_load 0 nsec
> main:PASS:skel_attach 0 nsec
> main:PASS:pass1 =3D=3D 0 0 nsec
> main:PASS:pass1 =3D=3D 1 0 nsec
> main:PASS:pass1 =3D=3D 2 0 nsec
> main:PASS:pass2 =3D=3D 0 0 nsec
> main:FAIL:pass2 =3D=3D 1 unexpected pass2 =3D=3D 1: actual 2 !=3D expecte=
d 1 [0]
> main:FAIL:pass2 =3D=3D 2 unexpected pass2 =3D=3D 2: actual 4 !=3D expecte=
d 2
> main:PASS:get_prog_info 0 nsec
> main:PASS:recursion_misses 0 nsec
>

I don't have a clear idea why TRACE_CTX_TRANSITION must be needed, but
it seems we have to do below code for the fentry test case,

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursio=
n.h
index d48cd92d2364..f6b4601dd604 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -163,21 +163,8 @@ static __always_inline int
trace_test_and_set_recursion(unsigned long ip, unsign
  return -1;

  bit =3D trace_get_context_bit() + start;
- if (unlikely(val & (1 << bit))) {
- /*
- * If an interrupt occurs during a trace, and another trace
- * happens in that interrupt but before the preempt_count is
- * updated to reflect the new interrupt context, then this
- * will think a recursion occurred, and the event will be dropped.
- * Let a single instance happen via the TRANSITION_BIT to
- * not drop those events.
- */
- bit =3D TRACE_CTX_TRANSITION + start;
- if (val & (1 << bit)) {
- do_ftrace_record_recursion(ip, pip);
- return -1;
- }
- }
+ if (unlikely(val & (1 << bit)))
+ return -1;

  val |=3D 1 << bit;
  current->trace_recursion =3D val;


> The reason is that the bpf_map_delete_elem() in this fentry SEC()[2]
> will hit the first if-condition[3] but fail to hit the second
> if-condition[4], so it won't be considered as recursion at the first
> time. So the value 'pass2' will be 2[0]. Illustrated as follows,
>
> SEC("fentry/htab_map_delete_elem")
>     pass2++;   <<<< Turn out to be 1 after this operation.
>     bpf_map_delete_elem(&hash2, &key);
>          SEC("fentry/htab_map_delete_elem")    <<<< not recursion
>             pass2++; <<<< Turn out to be 2 after this operation.
>             bpf_map_delete_elem(&hash2, &key);
>                 SEC("fentry/htab_map_delete_elem")    <<<< RECURSION!!
>
> That said, if a function can call itself, the first call won't be
> considered as recursion. Is that expected ?
>
> One thing I can be sure of is that prog->active can't handle the
> interrupted case[5].  If the interrupt happens, it will be considered
> as a recursion.
> But it seems that bpf_map_delete_elem() in this fentry SEC() is still
> in the process context.
>
> [1]. https://lore.kernel.org/bpf/CALOAHbACzCwu-VeMczEJw8A4WFgkL-uQDS1NkcV=
R2pqEMZyAQQ@mail.gmail.com/
> [2].  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tr=
ee/tools/testing/selftests/bpf/progs/recursion.c#n38
> [3]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tre=
e/include/linux/trace_recursion.h#n166
> [4]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tre=
e/include/linux/trace_recursion.h#n176
> [5]. https://lore.kernel.org/bpf/20230409220239.0fcf6738@rorschach.local.=
home/
>
> > ---
> >  include/linux/trace_recursion.h | 47 ++++++++++++++++++++++++---------
> >  kernel/trace/ftrace.c           |  2 ++
> >  2 files changed, 37 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recu=
rsion.h
> > index d48cd92d2364..80de2ee7b4c3 100644
> > --- a/include/linux/trace_recursion.h
> > +++ b/include/linux/trace_recursion.h
> > @@ -150,9 +150,6 @@ extern void ftrace_record_recursion(unsigned long i=
p, unsigned long parent_ip);
> >  # define trace_warn_on_no_rcu(ip)      false
> >  #endif
> >
> > -/*
> > - * Preemption is promised to be disabled when return bit >=3D 0.
> > - */
> >  static __always_inline int trace_test_and_set_recursion(unsigned long =
ip, unsigned long pip,
> >                                                         int start)
> >  {
> > @@ -182,18 +179,11 @@ static __always_inline int trace_test_and_set_rec=
ursion(unsigned long ip, unsign
> >         val |=3D 1 << bit;
> >         current->trace_recursion =3D val;
> >         barrier();
> > -
> > -       preempt_disable_notrace();
> > -
> >         return bit;
> >  }
> >
> > -/*
> > - * Preemption will be enabled (if it was previously enabled).
> > - */
> >  static __always_inline void trace_clear_recursion(int bit)
> >  {
> > -       preempt_enable_notrace();
> >         barrier();
> >         trace_recursion_clear(bit);
> >  }
> > @@ -205,12 +195,18 @@ static __always_inline void trace_clear_recursion=
(int bit)
> >   * tracing recursed in the same context (normal vs interrupt),
> >   *
> >   * Returns: -1 if a recursion happened.
> > - *           >=3D 0 if no recursion.
> > + *           >=3D 0 if no recursion and preemption will be disabled.
> >   */
> >  static __always_inline int ftrace_test_recursion_trylock(unsigned long=
 ip,
> >                                                          unsigned long =
parent_ip)
> >  {
> > -       return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE=
_START);
> > +       int bit;
> > +
> > +       bit =3D trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRAC=
E_START);
> > +       if (unlikely(bit < 0))
> > +               return bit;
> > +       preempt_disable_notrace();
> > +       return bit;
> >  }
> >
> >  /**
> > @@ -220,6 +216,33 @@ static __always_inline int ftrace_test_recursion_t=
rylock(unsigned long ip,
> >   * This is used at the end of a ftrace callback.
> >   */
> >  static __always_inline void ftrace_test_recursion_unlock(int bit)
> > +{
> > +       preempt_enable_notrace();
> > +       trace_clear_recursion(bit);
> > +}
> > +
> > +/**
> > + * test_recursion_try_acquire - tests for recursion in same context
> > + *
> > + * This will detect recursion of a function.
> > + *
> > + * Returns: -1 if a recursion happened.
> > + *           >=3D 0 if no recursion
> > + */
> > +static __always_inline int test_recursion_try_acquire(unsigned long ip=
,
> > +                                                     unsigned long par=
ent_ip)
> > +{
> > +       return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE=
_START);
> > +}
> > +
> > +/**
> > + * test_recursion_release - called after a success of test_recursion_t=
ry_acquire()
> > + * @bit: The return of a successful test_recursion_try_acquire()
> > + *
> > + * This releases the recursion lock taken by a non-negative return cal=
l
> > + * by test_recursion_try_acquire().
> > + */
> > +static __always_inline void test_recursion_release(int bit)
> >  {
> >         trace_clear_recursion(bit);
> >  }
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index db8532a4d5c8..1b117ab057ed 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -7299,6 +7299,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned=
 long parent_ip,
> >         if (bit < 0)
> >                 return;
> >
> > +       preempt_disable();
> >         do_for_each_ftrace_op(op, ftrace_ops_list) {
> >                 /* Stub functions don't need to be called nor tested */
> >                 if (op->flags & FTRACE_OPS_FL_STUB)
> > @@ -7320,6 +7321,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned=
 long parent_ip,
> >                 }
> >         } while_for_each_ftrace_op(op);
> >  out:
> > +       preempt_enable();
> >         trace_clear_recursion(bit);
> >  }
> >
> > --
> > 2.39.2
> >
>
>
> --
> Regards
> Yafang



--=20
Regards
Yafang
