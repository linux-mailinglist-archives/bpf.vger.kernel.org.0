Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1686DC777
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDJN4y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDJN4y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 09:56:54 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2326318D;
        Mon, 10 Apr 2023 06:56:53 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id ly9so6606837qvb.5;
        Mon, 10 Apr 2023 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681135012; x=1683727012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uO7Ze7d6ITncQ0S0kaxWh3rYwOyWMowxVHkmW2rD6yw=;
        b=lZnzcXoYP8Ysgsv2RkdKM+eEy/e+vihRKfHa246f8Bcah/IGFSSYkrOALR/3UC2fn+
         lQtezkPmVyhrMr1bBkUY7w+raxZrZzGhi/phNsV/jc7XlLlmwXj6ysY9/+XN0Cr9I6JS
         nc88CTrLVsxGVam0i0k7+DXJvXa0aeimfdopnM2CXMKgPgWbKCerWKBbB8kLrzBa1FZL
         w39aZ143bI25svJlV4Q5+mMqoLH7qoKybkHms6zhowfuGFTfL1xha0oRcxUB2skd+QSQ
         SMvfKNgWbOThBhWDcUNG6+qRDy8lX2WAuenpRsR1jDeT64vSumvc3b5IO06Rk5WwiaUb
         oUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681135012; x=1683727012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO7Ze7d6ITncQ0S0kaxWh3rYwOyWMowxVHkmW2rD6yw=;
        b=x2AW73pXB2yMnC3VUjqNFIEMl4vnfeII785a+sJXB+blYozAbtYlV1MonHrjeO/F2p
         W2G0fv5lJlbOxJn+yo9FyKTPoaR3sqMo47KurfqrzSn4DiYThjVoJVsyQg+NYQH0l68P
         yKJ4FF206zp+TwyuUhhCH0PKJEwu2oMqqyYYKUVJwy9TywB1y0L39isCO2N7h6FlFBem
         EXfqfTDS3tWDwiPDcf9WimMtRG6/vash2i13z/iUAO34WFU4smy4OYVOA+I6eJpK7P+W
         U502EtgAnq6GVF1WTgy3sv23KUsh5FZjBpntjPPBCn9SIO2Ja1F2tx1BoEJbPuupY36I
         Hzxg==
X-Gm-Message-State: AAQBX9eR6jSfLScNEzvc0UMMUz4vT37xshAJdWhMMHIcwL+ZvI6u1nkb
        qXRZCXbHIs56zOSDn/7N6ooxh9QHrjDIBJn1r06uDx5b0PG4vw==
X-Google-Smtp-Source: AKy350YLxUh8ocoojih3vRmu1NPvcQITr0NrWy6MQZruTKRNLpVZb6ByNvVBYHkXsDXipObSfZdH5+Bv+5PYF7cvYOY=
X-Received: by 2002:a05:6214:4a47:b0:5e9:6b31:7140 with SMTP id
 ph7-20020a0562144a4700b005e96b317140mr1433578qvb.3.1681135012142; Mon, 10 Apr
 2023 06:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230321020103.13494-1-laoar.shao@gmail.com> <20230321101711.625d0ccb@gandalf.local.home>
 <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
 <20230323083914.31f76c2b@gandalf.local.home> <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
 <20230323230105.57c40232@rorschach.local.home> <CALOAHbCZSY2XJpzJ+AxSrRLbMqyoJjcaXeof-xMLN8y+uB7PJg@mail.gmail.com>
 <20230409075515.2504db78@rorschach.local.home> <CALOAHbBALsJrkO-tPKoEtrdm42fLnRoYs-46tz0J7yDwrxC0Tg@mail.gmail.com>
 <20230409225414.2b66610f4145ade7b09339bb@kernel.org> <CALOAHbBQFSm=rXvzJJnOqrK04f9j1opbgRoYKwSUAd5g64r-jA@mail.gmail.com>
 <20230409220239.0fcf6738@rorschach.local.home> <CALOAHbC5UvoU2EUM+YzNSaJyNNq_OOXYZYcqXu6nUfB0AyX0bA@mail.gmail.com>
 <20230410063046.391dd2bd@rorschach.local.home>
In-Reply-To: <20230410063046.391dd2bd@rorschach.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 10 Apr 2023 21:56:16 +0800
Message-ID: <CALOAHbCXgksmdYRRxrjVrW1-AWiTr1u24yJAdh2+0ou15vvKiA@mail.gmail.com>
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 10, 2023 at 6:30=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 10 Apr 2023 13:36:32 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > Many thanks for the detailed explanation.
> > I think ftrace_test_recursion_trylock() can't apply to migreate_enable(=
).
> > If we change as follows to prevent migrate_enable() from recursing,
> >
> >          bit =3D ftrace_test_recursion_trylock();
> >          if (bit < 0)
> >                  return;
> >          migrate_enable();
> >          ftrace_test_recursion_unlock(bit);
> >
> > We have called migrate_disable() before, so if we don't call
> > migrate_enable() it will cause other issues.
>
> Right. Because you called migrate_disable() before (and protected it
> with the ftrace_test_recursion_trylock(), the second call is guaranteed
> to succeed!
>
> [1]     bit =3D ftrace_test_recursion_trylock();
>         if (bit < 0)
>                 return;
>         migrate_disable();
>         ftrace_test_recursion_trylock(bit);
>
>         [..]
>
> [2]     ftrace_test_recursion_trylock();
>         migrate_enable();
>         ftrace_test_recursion_trylock(bit);
>
> You don't even need to read the bit again, because it will be the same
> as the first call [1]. That's because it returns the recursion level
> you are in. A function will have the same recursion level through out
> the function (as long as it always calls ftrace_test_recursion_unlock()
> between them).
>
>         bpf_func()
>             bit =3D ftrace_test_recursion_trylock(); <-- OK
>             migrate_disable();
>             ftrace_test_recursion_unlock(bit);
>
>             [..]
>
>             ftrace_test_recursion_trylock(); <<-- guaranteed to be OK
>             migrate_enable() <<<-- gets traced
>
>                 bpf_func()
>                     bit =3D ftrace_test_recursion_trylock() <-- FAILED
>                     if (bit < 0)
>                         return;
>
>             ftrace_test_recursion_unlock(bit);
>
>
> See, still works!
>
> The migrate_enable() will never be called without the migrate_disable()
> as the migrate_disable() only gets called when not being recursed.
>

Thanks for your explanation again.
BPF trampoline is a little special. It includes three parts, as follows,

    ret =3D __bpf_prog_enter();
    if (ret)
        prog->bpf_func();
     __bpf_prog_exit();

migrate_disable() is called in __bpf_prog_enter() and migrate_enable()
in __bpf_prog_exit():

    ret =3D __bpf_prog_enter();
                migrate_disable();
    if (ret)
        prog->bpf_func();
     __bpf_prog_exit();
          migrate_enable();

That said, if we haven't executed migrate_disable() in
__bpf_prog_enter(), we shouldn't execute migrate_enable() in
__bpf_prog_exit().
Can ftrace_test_recursion_trylock() be applied to this pattern ?

> Note, the ftrace_test_recursion_*() code needs to be updated because it
> currently does disable preemption, which it doesn't have to. And that
> can cause migrate_disable() to do something different. It only disabled
> preemption, as there was a time that it needed to, but now it doesn't.
> But the users of it will need to be audited to make sure that they
> don't need the side effect of it disabling preemption.
>

disabling preemption is not expected by bpf prog, so I think we should
change it.

--=20
Regards
Yafang
