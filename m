Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7DC6DC7C6
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 16:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjDJOVN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 10:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDJOVM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 10:21:12 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02582689;
        Mon, 10 Apr 2023 07:21:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a23so2408081qtj.8;
        Mon, 10 Apr 2023 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681136468; x=1683728468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/Fq/yKIs0iQAr8ZRwfV3iDlhYubImU1PFv9x+tMmVU=;
        b=QfcxCkqI96cHCtJKL0ZqxMSFCGHymGJpuhYI4SR/5oIhk7E1Z8HdBqmbnYWySGWBoA
         slUJHTawTuKmaGZKPQvefnuAFPcRKnBCKgX0c4dXZGxUaJE+wA9I5r+LRQU4R/VuSyC8
         jXzqkp6zivMbrMsNSNS/Dmbq9q0+ryFjOt9VR2jWz1ljlYgpB22D4WgP0jxHAbpVrJdq
         VNORNVQCw87F0LcILH4cw0yVM7THErlUe73JmbjI2TM7pzKYTJA8fmFni1qlpPNc0Pbe
         p1awasAYryCX9fALMxxxcgkuhALUlAFGcsM2WWZ4sy0ZKGOPIWzf9pnvRQflKc4e9NAA
         8kRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681136468; x=1683728468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/Fq/yKIs0iQAr8ZRwfV3iDlhYubImU1PFv9x+tMmVU=;
        b=Hn400ssVaLs6v4np4jjimPRfWgCb6HpZA1wyWNbdYNs7AitkjOWAwZyQbK2K0vCdNP
         C7b/ZfGoAhRpXc8pzHv0hWdNQ4uGczhDPAse9YdXwu/HGigr6OwgOJhudbqWJ9f+92UW
         hu54t0Qvu51OYh4v5vrcLTk3/8sLlhmCwCaHKa1LJwnqYYlL+wEpGPWrVxwpY0UjcLet
         N9Hx3ZC6V8i6YLzpbxWtKROdrTLgdjEmgGvHBknAZNb98YSSol+LUM3pGPJFQOmtib0I
         SYbf3FYQ3l035kIHh2v4keBqX1oeB81+j8Pk9jS7HLYQYfzqRepUFzZHk2q+wPWn2+HL
         Qcwg==
X-Gm-Message-State: AAQBX9dkKpNttfirWAGyiVMRZyehcIhDWuUJALoPIx6H9DFHymwNHsSi
        Z/MRd2xLYS/7vVP4zEJtwn35pKabqSy4jokZDzo=
X-Google-Smtp-Source: AKy350ZPALEOMPQtKFPhFCRRZX0LiMDYqBd8b/cekgqqWTmFOH9rpLaKHfoQI8ZpFBcWBg0cL8ncayDx+s+AlcazCV4=
X-Received: by 2002:a05:622a:1994:b0:3db:c138:ae87 with SMTP id
 u20-20020a05622a199400b003dbc138ae87mr4107811qtc.6.1681136467922; Mon, 10 Apr
 2023 07:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230321020103.13494-1-laoar.shao@gmail.com> <20230321101711.625d0ccb@gandalf.local.home>
 <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
 <20230323083914.31f76c2b@gandalf.local.home> <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
 <20230323230105.57c40232@rorschach.local.home> <CALOAHbCZSY2XJpzJ+AxSrRLbMqyoJjcaXeof-xMLN8y+uB7PJg@mail.gmail.com>
 <20230409075515.2504db78@rorschach.local.home> <CALOAHbBALsJrkO-tPKoEtrdm42fLnRoYs-46tz0J7yDwrxC0Tg@mail.gmail.com>
 <20230409225414.2b66610f4145ade7b09339bb@kernel.org> <CALOAHbBQFSm=rXvzJJnOqrK04f9j1opbgRoYKwSUAd5g64r-jA@mail.gmail.com>
 <20230409220239.0fcf6738@rorschach.local.home> <CALOAHbC5UvoU2EUM+YzNSaJyNNq_OOXYZYcqXu6nUfB0AyX0bA@mail.gmail.com>
 <20230410063046.391dd2bd@rorschach.local.home> <CALOAHbCXgksmdYRRxrjVrW1-AWiTr1u24yJAdh2+0ou15vvKiA@mail.gmail.com>
 <20230410101224.7e3b238c@gandalf.local.home>
In-Reply-To: <20230410101224.7e3b238c@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 10 Apr 2023 22:20:31 +0800
Message-ID: <CALOAHbBQgPqhBhOVukWG9FNL23m3EOFm1QN6+pi5SN8cP2ztBw@mail.gmail.com>
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

On Mon, Apr 10, 2023 at 10:12=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Mon, 10 Apr 2023 21:56:16 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > Thanks for your explanation again.
> > BPF trampoline is a little special. It includes three parts, as follows=
,
> >
> >     ret =3D __bpf_prog_enter();
> >     if (ret)
> >         prog->bpf_func();
> >      __bpf_prog_exit();
> >
> > migrate_disable() is called in __bpf_prog_enter() and migrate_enable()
> > in __bpf_prog_exit():
> >
> >     ret =3D __bpf_prog_enter();
> >                 migrate_disable();
> >     if (ret)
> >         prog->bpf_func();
> >      __bpf_prog_exit();
> >           migrate_enable();
> >
> > That said, if we haven't executed migrate_disable() in
> > __bpf_prog_enter(), we shouldn't execute migrate_enable() in
> > __bpf_prog_exit().
> > Can ftrace_test_recursion_trylock() be applied to this pattern ?
>
> Yes, it can! And in this you would need to not call migrate_enable()
> because if the trace_recursion_trylock() failed, it would prevent
> migrate_disable() from being called (and should not let the bpf_func() fr=
om
> being called either. And then the migrate_enable in __bpf_prog_exit() wou=
ld
> need to know not to call migrate_enable() which checking the return value
> of ftrace_test_recursion_trylock() would give the same value as what the
> one before migrate_disable() had.
>

That needs some changes in invoke_bpf_prog() in files
arch/${ARCH}/net/bpf_jit_comp.c.
But I will have a try. We can then remove the bpf_prog->active, that
will be a good cleanup as well.

>
> >
> > > Note, the ftrace_test_recursion_*() code needs to be updated because =
it
> > > currently does disable preemption, which it doesn't have to. And that
> > > can cause migrate_disable() to do something different. It only disabl=
ed
> > > preemption, as there was a time that it needed to, but now it doesn't=
.
> > > But the users of it will need to be audited to make sure that they
> > > don't need the side effect of it disabling preemption.
> > >
> >
> > disabling preemption is not expected by bpf prog, so I think we should
> > change it.
>
> The disabling of preemption was just done because every place that used i=
t
> happened to also disable preemption. So it was just a clean up, not a
> requirement. Although the documentation said it did disable preemption :-=
/
>
>  See ce5e48036c9e7 ("ftrace: disable preemption when recursion locked")
>
> I think I can add a ftrace_test_recursion_try_aquire() and release() that
> is does the same thing without preemption. That way, we don't need to
> revert that patch, and use that instead.
>
> -- Steve



--=20
Regards
Yafang
