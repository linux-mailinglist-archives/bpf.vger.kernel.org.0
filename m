Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57B761FFC4
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 21:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiKGUtX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 15:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiKGUtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 15:49:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808F1E3D5;
        Mon,  7 Nov 2022 12:49:14 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f7so19506289edc.6;
        Mon, 07 Nov 2022 12:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJMr8R8EGsmirHMIXYmrOnj4ubtrOhjjOpW0S5unVpE=;
        b=q70O1VXpXS7GFUt6uHXlQsr/HgKxg0AWaOltxKhKpt+7DPwvKNGRVjLRKvtddqzTSN
         aKXfmAojCZMGedIauBqr/4Y5XP5vZABYUujh3bVsKrrfh82LFOVBJRswZvxnjI0tq8uI
         6hdTYkw/kPN8AUkgDFTpriXkxzMBIKkucXwvu4YM7JLKOjTv8/FUA8Iosa+h2niIm98f
         6Nd4MXcVr61Aj9Vpzy4/AolNPz+7oOuTBkhMxxc7hJV3BOmM+Gigu/X/Xk7pXd4mwHSj
         1q0aP+6gwC4fnaaYICsnCCfVqxCbxDF6Ic8rUfB4APPFZ5yuYfV5OJRFWLn2N8LXq2tp
         aqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJMr8R8EGsmirHMIXYmrOnj4ubtrOhjjOpW0S5unVpE=;
        b=W9hfFIQ9RL6Bi+sIliXaeIRUD21iio85pxGCJdkSpkujdj4D3EdqhLs1g1d67StJzz
         0gPTYKd0MqnAhJklB/0Tdw/qia74/OG6SjaxBw29MfUy06akbnuziDjuXAncqCEtzYnu
         wCOTUraIlcZFFKBhJdZJD9dDv4ONTUs03dU2KJ2Y/yVUqqzudwjZ4/BcTQ3IqssKu8wB
         7SW+Bgd7lx7+7wjKzre+hMUfegRGDRcIDKmGlIOW1ikIZh+bDTuFEdjHWi3Emg8n/L7o
         /Re+IWyfC4AXrs36d7+WoP1I5oFoBQIj8jR0ONz7pKnQScdGd1PFhqjROI2W/ugBefht
         8r2w==
X-Gm-Message-State: ACrzQf1feOC8aSiFf+Zl6dE14QLGxnC0zEeT34nZ6zNipPqQf4E/wrf9
        RuJFxjwKWY6PWToq2MvKdus/SeeeHRBpGpJedtg=
X-Google-Smtp-Source: AMsMyM7Ddmu9WFTjX5YUcDAWhcskT9viP4TI4ZSTfU9nMGnS/19EigceTwnklWJTInUyf0w2b1aCVM3y4/DXfZojTQc=
X-Received: by 2002:a05:6402:428d:b0:460:b26c:82a5 with SMTP id
 g13-20020a056402428d00b00460b26c82a5mr53613270edc.66.1667854152643; Mon, 07
 Nov 2022 12:49:12 -0800 (PST)
MIME-Version: 1.0
References: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
 <Y1pqWPRmP0M+hcXf@krava> <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
 <Y2J+n7SqmtfyA7ZM@krava> <Y2j6ivTwFmA0FtvY@krava>
In-Reply-To: <Y2j6ivTwFmA0FtvY@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Nov 2022 12:49:01 -0800
Message-ID: <CAADnVQKXcdVa-gDj2_QTrBuVea+KMuFUdabR--HCf7x6Vo6uXg@mail.gmail.com>
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

On Mon, Nov 7, 2022 at 4:31 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Nov 02, 2022 at 03:28:47PM +0100, Jiri Olsa wrote:
> > On Thu, Oct 27, 2022 at 07:45:16PM +0800, Hao Sun wrote:
> > > Jiri Olsa <olsajiri@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=9B=9B 19:24=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Thu, Oct 27, 2022 at 10:27:28AM +0800, Hao Sun wrote:
> > > > > Hi,
> > > > >
> > > > > The following warning can be triggered with the C reproducer in t=
he link.
> > > > > Syzbot also reported this several days ago, Jiri posted a patch t=
hat
> > > > > uses bpf prog `active` field to fix this by 05b24ff9b2cfab (bpf:
> > > > > Prevent bpf program recursion...) according to syzbot dashboard
> > > > > (https://syzkaller.appspot.com/bug?id=3D179313fb375161d50a98311a2=
8b8e2fc5f7350f9).
> > > > > But this warning can still be triggered on 247f34f7b803
> > > > > (Linux-v6.1-rc2) that already merged the patch, so it seems that =
this
> > > > > still is an issue.
> > > > >
> > > > > HEAD commit: 247f34f7b803 Linux 6.1-rc2
> > > > > git tree: upstream
> > > > > console output: https://pastebin.com/raw/kNw8JCu5
> > > > > kernel config: https://pastebin.com/raw/sE5QK5HL
> > > > > C reproducer: https://pastebin.com/raw/X96ASi27
> > > >
> > > > hi,
> > > > right, that fix addressed that issue for single bpf program,
> > > > and it won't prevent if there are multiple programs hook on
> > > > contention_begin tracepoint and calling bpf_trace_printk,
> > > >
> > > > I'm not sure we can do something there.. will check
> > > >
> > > > do you run just the reproducer, or you load the server somehow?
> > > > I cannot hit the issue so far
> > > >
> > >
> > > Hi,
> > >
> > > Last email has format issues, resend it here.
> > >
> > > I built the kernel with the config in the link, which contains
> > > =E2=80=9CCONFIG_CMDLINE=3D"earlyprintk=3Dserial net.ifnames=3D0
> > > sysctl.kernel.hung_task_all_cpu_backtrace=3D1 panic_on_warn=3D1 =E2=
=80=A6=E2=80=9D, and
> > > boot the kernel with normal qemu setup and then the warning can be
> > > triggered by executing the reproducer.
> > >
> > > Also, I=E2=80=99m willing to test the proposed patch if any.
> >
> > fyi I reproduced that.. will check if we can do anything about that
>
> I reproduced this with set of 8 programs all hooked to contention_begin
> tracepoint and here's what I think is happening:
>
> all programs (prog1 .. prog8) call just bpf_trace_printk helper and I'm
> running 'perf bench sched messaging' to load the machine
>
> at some point some contended lock triggers trace_contention_begin:
>
>   trace_contention_begin
>     __traceiter_contention_begin                                <-- itera=
tes all functions attached to tracepoint
>       __bpf_trace_run(prog1)
>         prog1->active =3D 1
>         bpf_prog_run(prog1)
>           bpf_trace_printk
>             bpf_bprintf_prepare                                 <-- takes=
 buffer 1 out of 3
>             raw_spin_lock_irqsave(trace_printk_lock)
>
>               # we have global single trace_printk_lock, so we will trigg=
er
>               # its trace_contention_begin at some point
>
>               trace_contention_begin
>                 __traceiter_contention_begin
>                   __bpf_trace_run(prog1)
>                     prog1->active block                         <-- prog1=
 is already 'running', skipping the execution
>                   __bpf_trace_run(prog2)
>                     prog2->active =3D 1
>                     bpf_prog_run(prog2)
>                       bpf_trace_printk
>                         bpf_bprintf_prepare                     <-- takes=
 buffer 2 out of 3
>                         raw_spin_lock_irqsave(trace_printk_lock)
>                           trace_contention_begin
>                             __traceiter_contention_begin
>                               __bpf_trace_run(prog1)
>                                 prog1->active block             <-- prog1=
 is already 'running', skipping the execution
>                               __bpf_trace_run(prog2)
>                                 prog2->active block             <-- prog2=
 is already 'running', skipping the execution
>                               __bpf_trace_run(prog3)
>                                  prog3->active =3D 1
>                                  bpf_prog_run(prog3)
>                                    bpf_trace_printk
>                                      bpf_bprintf_prepare        <-- takes=
 buffer 3 out of 3
>                                      raw_spin_lock_irqsave(trace_printk_l=
ock)
>                                        trace_contention_begin
>                                          __traceiter_contention_begin
>                                            __bpf_trace_run(prog1)
>                                              prog1->active block      <--=
 prog1 is already 'running', skipping the execution
>                                            __bpf_trace_run(prog2)
>                                              prog2->active block      <--=
 prog2 is already 'running', skipping the execution
>                                            __bpf_trace_run(prog3)
>                                              prog3->active block      <--=
 prog3 is already 'running', skipping the execution
>                                            __bpf_trace_run(prog4)
>                                              prog4->active =3D 1
>                                              bpf_prog_run(prog4)
>                                                bpf_trace_printk
>                                                  bpf_bprintf_prepare  <--=
 tries to take buffer 4 out of 3 -> WARNING
>
>
> the code path may vary based on the contention of the trace_printk_lock,
> so I saw different nesting within 8 programs, but all eventually ended up
> at 4 levels of nesting and hit the warning
>
> I think we could perhaps move the 'active' flag protection from program
> to the tracepoint level (in the patch below), to prevent nesting executio=
n
> of the same tracepoint, so it'd look like:
>
>   trace_contention_begin
>     __traceiter_contention_begin
>       __bpf_trace_run(prog1) {
>         contention_begin.active =3D 1
>         bpf_prog_run(prog1)
>           bpf_trace_printk
>             bpf_bprintf_prepare
>             raw_spin_lock_irqsave(trace_printk_lock)
>               trace_contention_begin
>                 __traceiter_contention_begin
>                   __bpf_trace_run(prog1)
>                     blocked because contention_begin.active =3D=3D 1
>                   __bpf_trace_run(prog2)
>                     blocked because contention_begin.active =3D=3D 1
>                   __bpf_trace_run(prog3)
>                   ...
>                   __bpf_trace_run(prog8)
>                     blocked because contention_begin.active =3D=3D 1
>
>             raw_spin_unlock_irqrestore
>             bpf_bprintf_cleanup
>
>         contention_begin.active =3D 0
>       }
>
>       __bpf_trace_run(prog2) {
>         contention_begin.active =3D 1
>         bpf_prog_run(prog2)
>           ...
>         contention_begin.active =3D 0
>       }
>
> do we need bpf program execution in nested tracepoints?
> we could actually allow 3 nesting levels for this case.. thoughts?
>
> thanks,
> jirka
>
>
> ---
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 6a13220d2d27..5a354ae096e5 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -78,11 +78,15 @@
>  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__=
VA_ARGS__)
>
>  #define __BPF_DECLARE_TRACE(call, proto, args)                         \
> +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);              \
>  static notrace void                                                    \
>  __bpf_trace_##call(void *__data, proto)                                 =
       \
>  {                                                                      \
>         struct bpf_prog *prog =3D __data;                                =
 \
> -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(ar=
gs));  \
> +                                                                       \
> +       if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) =3D=
=3D 1))             \
> +               CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_T=
O_U64(args));  \
> +       this_cpu_dec(__bpf_trace_tp_active_##call);                      =
               \
>  }

This approach will hurt real use cases where
multiple and different raw_tp progs run on the same cpu.
Instead let's disallow attaching to trace_contention and
potentially any other hook with similar recursion properties.
Another option is to add a recursion check to trace_contention itself.
