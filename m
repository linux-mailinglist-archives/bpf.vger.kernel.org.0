Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12826E319A
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 15:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjDONei (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 09:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDONei (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 09:34:38 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F00358A;
        Sat, 15 Apr 2023 06:34:35 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id me15so741655qvb.4;
        Sat, 15 Apr 2023 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681565675; x=1684157675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxfuwdn7nRD4Yp671f8K1ixGlG5tRaS+xD+c6bJ5pXY=;
        b=GSbRrfMwHBwxiNF1h2dA6tjH9K98xdB60twpRaZpXLBWejq92o13g7F8Wunh9bBEBD
         DP2n7791Tn7lqmSG8ZV9IYml2vY9eGv18On/U/h4nsDaOXtS9QGYDxFbYzy0josH7d99
         PLxwuZNp5BtZVdBGQ0c+07Ep5b0Ofgh7eZBBZ+j7FiJL06B4TAedtOUCqBPue/OShMbi
         UTqWMXKfSfUeJaT37sCNe9by3uwHWN8DpE6D99BbAQfqafiMPMZiC548AbJQk4OzMYoW
         mhRG0UZNws2kije0rtDnzPZGVgNQ+u4NV/aMqnoBYpwxqfmtZDfq3uDZY0TtZROdxp0L
         JI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681565675; x=1684157675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxfuwdn7nRD4Yp671f8K1ixGlG5tRaS+xD+c6bJ5pXY=;
        b=VaNp3ViYBZEQZb0ML6j9HggPewJTM4EJKYa9kZDAsFfOLaoYjzt5lwGNnevSkwcY4E
         uz5YozoQFjl1KyzPLQ+GX8oGPcWyheppYnWsOnJI+QTgkFiIo3+SiO+VGnIv6BLm9s4P
         zzbPssEXZFyI3KXuia+qLFSFwy+aeglpROfhQrxPm5rS0GkuX63KW+7b1uq24TYh8zwC
         DTTxt4npCKXfG3v4dCSrFdESeUqxFmMrDhvvbDxX1kbMWI/GjTw8zg1jWOu7XC4uboWv
         1dERRZlaGbmf2q+cY9tzNVibsSDAvOcPuq2KUk4E7fUnhXdwgLV6ZTK9v57/004QW4gr
         XVMA==
X-Gm-Message-State: AAQBX9ciZEhSqAUwYs4UJEvbeGISggggW79fvvuMwulV+V6XqkT0z6ej
        pfws6SUwcwidoW7P0ALt1DTeJDmi+54hol5hv84SCF8P23XCLw==
X-Google-Smtp-Source: AKy350ZThu66oYsDDcWiXIAgsIqDDmJh4n4pCV9kasNK2gLK3RpfezhpbHFLF7S55IORJWTmqEqNfhO4/sywnhjeyyY=
X-Received: by 2002:a05:6214:e6f:b0:5ef:4455:fd24 with SMTP id
 jz15-20020a0562140e6f00b005ef4455fd24mr8167017qvb.1.1681565674807; Sat, 15
 Apr 2023 06:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230414221702.554c44fe@rorschach.local.home>
In-Reply-To: <20230414221702.554c44fe@rorschach.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 15 Apr 2023 21:33:58 +0800
Message-ID: <CALOAHbDUkvyu0hWXfcveJBW_dxDkqUTVBmwXt5Y-ERBv9GksbQ@mail.gmail.com>
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

On Sat, Apr 15, 2023 at 10:17=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> The ftrace_test_recursion_trylock() also disables preemption. This is not
> required, but was a clean up as every place that called it also disabled
> preemption, and making the two tightly coupled appeared to make the code
> simpler.
>
> But the recursion protection can be used for other purposes that do not
> require disabling preemption. As the recursion bits are attached to the
> task_struct, it follows the task, so there's no need for preemption being
> disabled.
>
> Add test_recursion_try_acquire/release() functions to be used generically=
,
> and separate it from being associated with ftrace. It also removes the
> "lock" name, as there is no lock happening. Keeping the "lock" for the
> ftrace version is better, as it at least differentiates that preemption i=
s
> being disabled (hence, "locking the CPU").
>
> Link: https://lore.kernel.org/linux-trace-kernel/20230321020103.13494-1-l=
aoar.shao@gmail.com/
>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

+Alexei, bpf

Thanks Steven.
I almost finished replacing prog->active with
test_recursion_try_{acquire,release}[1], and yet I need to do more
tests.

In my verification, I find that something abnormal happens. When I ran
bpf self tests after the replacement, I found the fentry recursion
test failed[2]. The test result as follows,

main:PASS:skel_open_and_load 0 nsec
main:PASS:skel_attach 0 nsec
main:PASS:pass1 =3D=3D 0 0 nsec
main:PASS:pass1 =3D=3D 1 0 nsec
main:PASS:pass1 =3D=3D 2 0 nsec
main:PASS:pass2 =3D=3D 0 0 nsec
main:FAIL:pass2 =3D=3D 1 unexpected pass2 =3D=3D 1: actual 2 !=3D expected =
1 [0]
main:FAIL:pass2 =3D=3D 2 unexpected pass2 =3D=3D 2: actual 4 !=3D expected =
2
main:PASS:get_prog_info 0 nsec
main:PASS:recursion_misses 0 nsec

The reason is that the bpf_map_delete_elem() in this fentry SEC()[2]
will hit the first if-condition[3] but fail to hit the second
if-condition[4], so it won't be considered as recursion at the first
time. So the value 'pass2' will be 2[0]. Illustrated as follows,

SEC("fentry/htab_map_delete_elem")
    pass2++;   <<<< Turn out to be 1 after this operation.
    bpf_map_delete_elem(&hash2, &key);
         SEC("fentry/htab_map_delete_elem")    <<<< not recursion
            pass2++; <<<< Turn out to be 2 after this operation.
            bpf_map_delete_elem(&hash2, &key);
                SEC("fentry/htab_map_delete_elem")    <<<< RECURSION!!

That said, if a function can call itself, the first call won't be
considered as recursion. Is that expected ?

One thing I can be sure of is that prog->active can't handle the
interrupted case[5].  If the interrupt happens, it will be considered
as a recursion.
But it seems that bpf_map_delete_elem() in this fentry SEC() is still
in the process context.

[1]. https://lore.kernel.org/bpf/CALOAHbACzCwu-VeMczEJw8A4WFgkL-uQDS1NkcVR2=
pqEMZyAQQ@mail.gmail.com/
[2].  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree=
/tools/testing/selftests/bpf/progs/recursion.c#n38
[3]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/=
include/linux/trace_recursion.h#n166
[4]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/=
include/linux/trace_recursion.h#n176
[5]. https://lore.kernel.org/bpf/20230409220239.0fcf6738@rorschach.local.ho=
me/

> ---
>  include/linux/trace_recursion.h | 47 ++++++++++++++++++++++++---------
>  kernel/trace/ftrace.c           |  2 ++
>  2 files changed, 37 insertions(+), 12 deletions(-)
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
> +               return bit;
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
> index db8532a4d5c8..1b117ab057ed 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7299,6 +7299,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned l=
ong parent_ip,
>         if (bit < 0)
>                 return;
>
> +       preempt_disable();
>         do_for_each_ftrace_op(op, ftrace_ops_list) {
>                 /* Stub functions don't need to be called nor tested */
>                 if (op->flags & FTRACE_OPS_FL_STUB)
> @@ -7320,6 +7321,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned l=
ong parent_ip,
>                 }
>         } while_for_each_ftrace_op(op);
>  out:
> +       preempt_enable();
>         trace_clear_recursion(bit);
>  }
>
> --
> 2.39.2
>


--=20
Regards
Yafang
