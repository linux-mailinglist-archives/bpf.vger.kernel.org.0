Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0AB6233A8
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 20:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiKITmK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 14:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiKITmJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 14:42:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111C92CC8E;
        Wed,  9 Nov 2022 11:42:08 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z18so28608139edb.9;
        Wed, 09 Nov 2022 11:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V3Kjcj7JTpcLCU6rHAPJZxuwJF+DY+lDKOc+QPCwXE=;
        b=jLKsnmEFuI9MmoWKfaxM26Ym1To/QX2oAQTBoabEXVwPb6hGDksncUMlzo9jlkZ9Ki
         uUOzzzC6FPwK1MMNPcFwAk94wF2UpPhAw0x9QtX+vYEzI9lKaw+bQnUigK6jBKS235p5
         kxeUuzmG8YUXH9p6exMITVdx6TA/qcdxS1JPGamC0WAybkOpfg9nCACvQFTZfroIfxH8
         XVMES2bdEGPizjR5mzRCo9+qpgLXaal8X+1c9cvHj44gzBQ4RZCWM+jkZju6h5zZkEri
         Z/gWiCX7ttW30QkyrMfZ+oHmr/xyka7Y8FDKgSDYBq35O3jaW7/2SbjdaPxZ9gdtYb45
         FdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+V3Kjcj7JTpcLCU6rHAPJZxuwJF+DY+lDKOc+QPCwXE=;
        b=JzyqAyBn+bOgUMnY38FKwvCV0QaAlMrTFSBre2hdjC5Fn74+BCJhHf42bMxIZzdPbZ
         TH/v5wiz18PnQE0mhEQu5AROL3MD7hXn31qJdbf4RrawJJr8sXdO3fG0xiG/AYhBhm4Z
         YB5Mz5UmmtSf9VvMKMbGNofeJWeWUreloKi4v3aO8GKhLgdobUX3NDXku7869Lq0dm92
         Y62dzSfNnM5JCGLK5Acqcqb9fkPAUELJ67QjOoAf9eBR/q3yJkjh8SWfzlGn7T3Q9PP0
         ZyQ/LuIm+YD5dkF7KM0FsOXVZV0PuFvyU1iaGD/dYoBmeN+nG/ExjxzhOf0Py1G8lS4Y
         r+0A==
X-Gm-Message-State: ACrzQf3CaHUjfdbwUsxeeTdyyIgV/upa3LzueWwQOvmuo9AvHtDEm5zi
        g4pP8RWiV0lHUxHnjl01e6YT6r0ckWbnK9Fa6v4=
X-Google-Smtp-Source: AMsMyM64mWT3G7x+9ydX8+Q9WXmkhL0GVNIuO4qi67W456lLG1ewgVykB74xjK4jmWetuROSZOkUBSTa8OVix/I7sP4=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr61521966edb.333.1668022926403; Wed, 09
 Nov 2022 11:42:06 -0800 (PST)
MIME-Version: 1.0
References: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
 <Y1pqWPRmP0M+hcXf@krava> <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
 <Y2J+n7SqmtfyA7ZM@krava> <Y2j6ivTwFmA0FtvY@krava> <CAADnVQKXcdVa-gDj2_QTrBuVea+KMuFUdabR--HCf7x6Vo6uXg@mail.gmail.com>
 <Y2uv/GjnSdr/ujOj@krava>
In-Reply-To: <Y2uv/GjnSdr/ujOj@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 9 Nov 2022 11:41:54 -0800
Message-ID: <CAADnVQJp0ZrodRu8ZtvvtXk6KAbjxmwqD-nXgFAxNpNxN6JM=g@mail.gmail.com>
Subject: Re: WARNING in bpf_bprintf_prepare
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
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

On Wed, Nov 9, 2022 at 5:49 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Nov 07, 2022 at 12:49:01PM -0800, Alexei Starovoitov wrote:
> > On Mon, Nov 7, 2022 at 4:31 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Wed, Nov 02, 2022 at 03:28:47PM +0100, Jiri Olsa wrote:
> > > > On Thu, Oct 27, 2022 at 07:45:16PM +0800, Hao Sun wrote:
> > > > > Jiri Olsa <olsajiri@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=882=
7=E6=97=A5=E5=91=A8=E5=9B=9B 19:24=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On Thu, Oct 27, 2022 at 10:27:28AM +0800, Hao Sun wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > The following warning can be triggered with the C reproducer =
in the link.
> > > > > > > Syzbot also reported this several days ago, Jiri posted a pat=
ch that
> > > > > > > uses bpf prog `active` field to fix this by 05b24ff9b2cfab (b=
pf:
> > > > > > > Prevent bpf program recursion...) according to syzbot dashboa=
rd
> > > > > > > (https://syzkaller.appspot.com/bug?id=3D179313fb375161d50a983=
11a28b8e2fc5f7350f9).
> > > > > > > But this warning can still be triggered on 247f34f7b803
> > > > > > > (Linux-v6.1-rc2) that already merged the patch, so it seems t=
hat this
> > > > > > > still is an issue.
> > > > > > >
> > > > > > > HEAD commit: 247f34f7b803 Linux 6.1-rc2
> > > > > > > git tree: upstream
> > > > > > > console output: https://pastebin.com/raw/kNw8JCu5
> > > > > > > kernel config: https://pastebin.com/raw/sE5QK5HL
> > > > > > > C reproducer: https://pastebin.com/raw/X96ASi27
> > > > > >
> > > > > > hi,
> > > > > > right, that fix addressed that issue for single bpf program,
> > > > > > and it won't prevent if there are multiple programs hook on
> > > > > > contention_begin tracepoint and calling bpf_trace_printk,
> > > > > >
> > > > > > I'm not sure we can do something there.. will check
> > > > > >
> > > > > > do you run just the reproducer, or you load the server somehow?
> > > > > > I cannot hit the issue so far
> > > > > >
> > > > >
> > > > > Hi,
> > > > >
> > > > > Last email has format issues, resend it here.
> > > > >
> > > > > I built the kernel with the config in the link, which contains
> > > > > =E2=80=9CCONFIG_CMDLINE=3D"earlyprintk=3Dserial net.ifnames=3D0
> > > > > sysctl.kernel.hung_task_all_cpu_backtrace=3D1 panic_on_warn=3D1 =
=E2=80=A6=E2=80=9D, and
> > > > > boot the kernel with normal qemu setup and then the warning can b=
e
> > > > > triggered by executing the reproducer.
> > > > >
> > > > > Also, I=E2=80=99m willing to test the proposed patch if any.
> > > >
> > > > fyi I reproduced that.. will check if we can do anything about that
> > >
> > > I reproduced this with set of 8 programs all hooked to contention_beg=
in
> > > tracepoint and here's what I think is happening:
> > >
> > > all programs (prog1 .. prog8) call just bpf_trace_printk helper and I=
'm
> > > running 'perf bench sched messaging' to load the machine
> > >
> > > at some point some contended lock triggers trace_contention_begin:
> > >
> > >   trace_contention_begin
> > >     __traceiter_contention_begin                                <-- i=
terates all functions attached to tracepoint
> > >       __bpf_trace_run(prog1)
> > >         prog1->active =3D 1
> > >         bpf_prog_run(prog1)
> > >           bpf_trace_printk
> > >             bpf_bprintf_prepare                                 <-- t=
akes buffer 1 out of 3
> > >             raw_spin_lock_irqsave(trace_printk_lock)
> > >
> > >               # we have global single trace_printk_lock, so we will t=
rigger
> > >               # its trace_contention_begin at some point
> > >
> > >               trace_contention_begin
> > >                 __traceiter_contention_begin
> > >                   __bpf_trace_run(prog1)
> > >                     prog1->active block                         <-- p=
rog1 is already 'running', skipping the execution
> > >                   __bpf_trace_run(prog2)
> > >                     prog2->active =3D 1
> > >                     bpf_prog_run(prog2)
> > >                       bpf_trace_printk
> > >                         bpf_bprintf_prepare                     <-- t=
akes buffer 2 out of 3
> > >                         raw_spin_lock_irqsave(trace_printk_lock)
> > >                           trace_contention_begin
> > >                             __traceiter_contention_begin
> > >                               __bpf_trace_run(prog1)
> > >                                 prog1->active block             <-- p=
rog1 is already 'running', skipping the execution
> > >                               __bpf_trace_run(prog2)
> > >                                 prog2->active block             <-- p=
rog2 is already 'running', skipping the execution
> > >                               __bpf_trace_run(prog3)
> > >                                  prog3->active =3D 1
> > >                                  bpf_prog_run(prog3)
> > >                                    bpf_trace_printk
> > >                                      bpf_bprintf_prepare        <-- t=
akes buffer 3 out of 3
> > >                                      raw_spin_lock_irqsave(trace_prin=
tk_lock)
> > >                                        trace_contention_begin
> > >                                          __traceiter_contention_begin
> > >                                            __bpf_trace_run(prog1)
> > >                                              prog1->active block     =
 <-- prog1 is already 'running', skipping the execution
> > >                                            __bpf_trace_run(prog2)
> > >                                              prog2->active block     =
 <-- prog2 is already 'running', skipping the execution
> > >                                            __bpf_trace_run(prog3)
> > >                                              prog3->active block     =
 <-- prog3 is already 'running', skipping the execution
> > >                                            __bpf_trace_run(prog4)
> > >                                              prog4->active =3D 1
> > >                                              bpf_prog_run(prog4)
> > >                                                bpf_trace_printk
> > >                                                  bpf_bprintf_prepare =
 <-- tries to take buffer 4 out of 3 -> WARNING
> > >
> > >
> > > the code path may vary based on the contention of the trace_printk_lo=
ck,
> > > so I saw different nesting within 8 programs, but all eventually ende=
d up
> > > at 4 levels of nesting and hit the warning
> > >
> > > I think we could perhaps move the 'active' flag protection from progr=
am
> > > to the tracepoint level (in the patch below), to prevent nesting exec=
ution
> > > of the same tracepoint, so it'd look like:
> > >
> > >   trace_contention_begin
> > >     __traceiter_contention_begin
> > >       __bpf_trace_run(prog1) {
> > >         contention_begin.active =3D 1
> > >         bpf_prog_run(prog1)
> > >           bpf_trace_printk
> > >             bpf_bprintf_prepare
> > >             raw_spin_lock_irqsave(trace_printk_lock)
> > >               trace_contention_begin
> > >                 __traceiter_contention_begin
> > >                   __bpf_trace_run(prog1)
> > >                     blocked because contention_begin.active =3D=3D 1
> > >                   __bpf_trace_run(prog2)
> > >                     blocked because contention_begin.active =3D=3D 1
> > >                   __bpf_trace_run(prog3)
> > >                   ...
> > >                   __bpf_trace_run(prog8)
> > >                     blocked because contention_begin.active =3D=3D 1
> > >
> > >             raw_spin_unlock_irqrestore
> > >             bpf_bprintf_cleanup
> > >
> > >         contention_begin.active =3D 0
> > >       }
> > >
> > >       __bpf_trace_run(prog2) {
> > >         contention_begin.active =3D 1
> > >         bpf_prog_run(prog2)
> > >           ...
> > >         contention_begin.active =3D 0
> > >       }
> > >
> > > do we need bpf program execution in nested tracepoints?
> > > we could actually allow 3 nesting levels for this case.. thoughts?
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > > index 6a13220d2d27..5a354ae096e5 100644
> > > --- a/include/trace/bpf_probe.h
> > > +++ b/include/trace/bpf_probe.h
> > > @@ -78,11 +78,15 @@
> > >  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__)=
)(__VA_ARGS__)
> > >
> > >  #define __BPF_DECLARE_TRACE(call, proto, args)                      =
   \
> > > +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);           =
   \
> > >  static notrace void                                                 =
   \
> > >  __bpf_trace_##call(void *__data, proto)                             =
           \
> > >  {                                                                   =
   \
> > >         struct bpf_prog *prog =3D __data;                            =
     \
> > > -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U6=
4(args));  \
> > > +                                                                    =
   \
> > > +       if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) =
=3D=3D 1))             \
> > > +               CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CA=
ST_TO_U64(args));  \
> > > +       this_cpu_dec(__bpf_trace_tp_active_##call);                  =
                   \
> > >  }
> >
> > This approach will hurt real use cases where
> > multiple and different raw_tp progs run on the same cpu.
>
> would the 2 levels of nesting help in here?
>
> I can imagine the change above would break use case where we want to
> trigger tracepoints in irq context that interrupted task that's already
> in the same tracepoint
>
> with 2 levels of nesting we would trigger that tracepoint from irq and
> would still be safe with bpf_bprintf_prepare buffer

How would these 2 levels work?
