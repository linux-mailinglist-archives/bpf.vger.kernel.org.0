Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506E76DF881
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 16:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDLOa5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 10:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjDLOaz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 10:30:55 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22A37AB0;
        Wed, 12 Apr 2023 07:30:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id cg4so3099615qtb.11;
        Wed, 12 Apr 2023 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681309853; x=1683901853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8ERyuF5lUh/9oOBnakaR53ts/dJmfYVpaB52vPFC/k=;
        b=IdnzgpwrfIBo4Mhuys3oEz+066VkpG/E4Yi2Oo5vsQ2Crcfovsz7Yppi4iZJI3uBXU
         TMJznNaxMZ7EMU73pVi1Yhw2kW2mGhr2JvHR4sbGML0w4hmkWh69vEKr1ArqZy/oF04v
         BE5jnDc84OFoNft+jdklFVod/bj+UoKH0w64HQvUjYM6N3yUBmoAJSrJ3CAZ8TNLh0uN
         1SK66dCv3QfXo+C7KZNQzKjH+c3ZBiuMtwHVkZdM5VWX2VcnUzDOu9CVIuHDhXMpAQMv
         3cl+5NtsMwyK0vV5AIUnB01MgsXgF20NHHLfVqIWSKRK9TbYxnpYdHxXhWcCkXmYrBZF
         XhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681309853; x=1683901853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8ERyuF5lUh/9oOBnakaR53ts/dJmfYVpaB52vPFC/k=;
        b=geFwN6rj47XxvSNiZO3pFLXDjy6k8syegVjlx8in4pn4tT8Yl5efrK60HN/nmON8FS
         UE3GkjkzDN1vfNZ+lGS2j6dwqXkd7Gr1LwNwPMIO7us9BHjQ7oSW9sgMHjY9hJgPBstl
         /O/RtO+0IBZXT45sF4UeAWHllHvg+SFJx6hCyv1YUVjvA2/qfV0MDPduw3K9fJQGYkLs
         wIkEEO9hllv6LcadBTFDmnpzUIrJJh8rchdHgzI4ue/zc+yrexLIZzmuIY+d5z80l+/D
         LmZFw6jEV/q/xWMh/xQU2rBWsTcJhUensjQmO8gFIvOINXxRXXPpW9yu+7aEgzXjAQju
         xLuQ==
X-Gm-Message-State: AAQBX9e1r+IrSxHQ3NiaifRaN2LBF8/1Jr1ntsyhiDLYYgMPZ7FKUxfP
        0JCSEwWiDF05X4Pl1nk+nWm2tWelgTH9OHOQ4zWnfBlL6tg=
X-Google-Smtp-Source: AKy350a/v2QgdmWhkLlpTmPcQPYPrqrwogMMXl88Rr192vwDmBw5D8JWSgU+r5YbrUXA11lieObN7hM4TOG5Cageuc8=
X-Received: by 2002:ac8:7f02:0:b0:3d8:2cb6:d21d with SMTP id
 f2-20020ac87f02000000b003d82cb6d21dmr2187800qtk.6.1681309852832; Wed, 12 Apr
 2023 07:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230321020103.13494-1-laoar.shao@gmail.com> <20230321101711.625d0ccb@gandalf.local.home>
 <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
 <20230323083914.31f76c2b@gandalf.local.home> <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
 <20230323230105.57c40232@rorschach.local.home> <CALOAHbCZSY2XJpzJ+AxSrRLbMqyoJjcaXeof-xMLN8y+uB7PJg@mail.gmail.com>
 <20230409075515.2504db78@rorschach.local.home> <CALOAHbBALsJrkO-tPKoEtrdm42fLnRoYs-46tz0J7yDwrxC0Tg@mail.gmail.com>
 <20230409225414.2b66610f4145ade7b09339bb@kernel.org> <CALOAHbBQFSm=rXvzJJnOqrK04f9j1opbgRoYKwSUAd5g64r-jA@mail.gmail.com>
 <20230409220239.0fcf6738@rorschach.local.home> <CALOAHbC5UvoU2EUM+YzNSaJyNNq_OOXYZYcqXu6nUfB0AyX0bA@mail.gmail.com>
 <20230410063046.391dd2bd@rorschach.local.home> <CALOAHbCXgksmdYRRxrjVrW1-AWiTr1u24yJAdh2+0ou15vvKiA@mail.gmail.com>
 <20230410101224.7e3b238c@gandalf.local.home> <20230410103152.29c84333@gandalf.local.home>
In-Reply-To: <20230410103152.29c84333@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 12 Apr 2023 22:30:16 +0800
Message-ID: <CALOAHbAYAYkj9ZrTvRCRZXJ4UBWHY5DyiTWfvUFgw+78VVkHEQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Mon, Apr 10, 2023 at 10:31=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Mon, 10 Apr 2023 10:12:24 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > The disabling of preemption was just done because every place that used=
 it
> > happened to also disable preemption. So it was just a clean up, not a
> > requirement. Although the documentation said it did disable preemption =
:-/
> >
> >  See ce5e48036c9e7 ("ftrace: disable preemption when recursion locked")
> >
> > I think I can add a ftrace_test_recursion_try_aquire() and release() th=
at
> > is does the same thing without preemption. That way, we don't need to
> > revert that patch, and use that instead.
>
> This patch adds a:
>
>    test_recursion_try_acquire() and test_recursion_release()
>
> I called it "acquire" and "release" so that "lock" can imply preemption b=
eing
> disabled, and this only protects against recursion (and I removed "ftrace=
"
> in the name, as it is meant for non-ftrace uses, which I may give it a
> different set of recursion bits).
>
> Note, the reason to pass in ip, and parent_ip (_THIS_IP_ and _RET_IP_) is
> for debugging purposes. They *should* be optimized out, as everything is
> __always_inline or macros, and those are only used if
> CONFIG_FTRACE_RECORD_RECURSION is enabled.
>
> -- Steve
>

Thanks for the explanation.

>
> diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recurs=
ion.h
> index d48cd92d2364..80de2ee7b4c3 100644
> --- a/include/linux/trace_recursion.h
> +++ b/include/linux/trace_recursion.h
> @@ -150,9 +150,6 @@ extern void ftrace_record_recursion(unsigned long ip,=
 unsigned long parent_ip);
>  # define trace_warn_on_no_rcu(ip)      false
>  #endif
>
> -/*
> - * Preemption is promised to be disabled when return bit >=3D 0.
> - */
>  static __always_inline int trace_test_and_set_recursion(unsigned long ip=
, unsigned long pip,
>                                                         int start)
>  {
> @@ -182,18 +179,11 @@ static __always_inline int trace_test_and_set_recur=
sion(unsigned long ip, unsign
>         val |=3D 1 << bit;
>         current->trace_recursion =3D val;
>         barrier();
> -
> -       preempt_disable_notrace();
> -
>         return bit;
>  }
>
> -/*
> - * Preemption will be enabled (if it was previously enabled).
> - */
>  static __always_inline void trace_clear_recursion(int bit)
>  {
> -       preempt_enable_notrace();
>         barrier();
>         trace_recursion_clear(bit);
>  }
> @@ -205,12 +195,18 @@ static __always_inline void trace_clear_recursion(i=
nt bit)
>   * tracing recursed in the same context (normal vs interrupt),
>   *
>   * Returns: -1 if a recursion happened.
> - *           >=3D 0 if no recursion.
> + *           >=3D 0 if no recursion and preemption will be disabled.
>   */
>  static __always_inline int ftrace_test_recursion_trylock(unsigned long i=
p,
>                                                          unsigned long pa=
rent_ip)
>  {
> -       return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_S=
TART);
> +       int bit;
> +
> +       bit =3D trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_=
START);
> +       if (unlikely(bit < 0))
> +               return -1;
> +       preempt_disable_notrace();
> +       return bit;
>  }
>
>  /**
> @@ -220,6 +216,33 @@ static __always_inline int ftrace_test_recursion_try=
lock(unsigned long ip,
>   * This is used at the end of a ftrace callback.
>   */
>  static __always_inline void ftrace_test_recursion_unlock(int bit)
> +{
> +       preempt_enable_notrace();
> +       trace_clear_recursion(bit);
> +}
> +
> +/**
> + * test_recursion_try_acquire - tests for recursion in same context
> + *
> + * This will detect recursion of a function.
> + *
> + * Returns: -1 if a recursion happened.
> + *           >=3D 0 if no recursion
> + */
> +static __always_inline int test_recursion_try_acquire(unsigned long ip,
> +                                                     unsigned long paren=
t_ip)
> +{
> +       return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_S=
TART);
> +}
> +
> +/**
> + * test_recursion_release - called after a success of test_recursion_try=
_acquire()
> + * @bit: The return of a successful test_recursion_try_acquire()
> + *
> + * This releases the recursion lock taken by a non-negative return call
> + * by test_recursion_try_acquire().
> + */
> +static __always_inline void test_recursion_release(int bit)
>  {
>         trace_clear_recursion(bit);
>  }
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 0feea145bb29..ff8172ba48b0 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7644,6 +7644,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned l=
ong parent_ip,
>         if (bit < 0)
>                 return;
>
> +       preempt_disable();
>         do_for_each_ftrace_op(op, ftrace_ops_list) {
>                 /* Stub functions don't need to be called nor tested */
>                 if (op->flags & FTRACE_OPS_FL_STUB)
> @@ -7665,6 +7666,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned l=
ong parent_ip,
>                 }
>         } while_for_each_ftrace_op(op);
>  out:
> +       preempt_enable();
>         trace_clear_recursion(bit);
>  }
>

Great!

--=20
Regards
Yafang
