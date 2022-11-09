Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A7622CC6
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 14:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKINuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 08:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKINuB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 08:50:01 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6A82EF1A;
        Wed,  9 Nov 2022 05:49:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n12so46687465eja.11;
        Wed, 09 Nov 2022 05:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AmPZYi/lB8j4EsJgXY36Y0WzhFXoSyAX25kaPUy3x9g=;
        b=MxROsK1D13OTV974SDYVpErrvihTplU5nf7SKoyX4P7/3sLFZpPC2wIJIwXE7WRXjg
         EKqb7ZO5LFe54Ucqrh7g3JpmLzrULHJjA9fFw4tb1jKkVI4gM9cTwchwbviDtr056u2s
         blFcA+j91sFYAFlZ8uEZi61SwxOKkhbBNknXzTcJiDyu1HXCHNlvGNNo4f1kl3WHDUI9
         VwhwZxffKaDcQpX6aiNanS80hyyWDV0QkWoYdRbWEBxPFk8qIoG9ks65CsypeCrBphjz
         Zxp3fGtN+amu1tn2Ahx8K+weulN/jwH3KflmVa5Ew7DWFpzMVdrMEXdFNVn34PJ9tzi7
         /IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmPZYi/lB8j4EsJgXY36Y0WzhFXoSyAX25kaPUy3x9g=;
        b=04a0nb8W+gaDff13B7YXowy+CYabCo07xboXwF7hiCa5k4UEyzDRxaODvJ6PjzrAgg
         3ujQzIRtFcjbVkQoDBBwV5DopKTauAf2kP/PWOd9H0gUWYto2vzU4dsFuqF2+x7Au9wY
         lAuJWjILIKS+E9obxMc4cEOCXcLRa8C5PSFIAnzjET0eN92O8tLWMT103EHoLmoN2Av8
         PEUjM1zwC+bearVK7mJq9ZYHLl1xv2LfT4W0Ka85f3J7/AUkAsITS5QN9LHQj3K+pDV4
         P8qVt8tHvBpxRPrHMZM54qU8mBhMNsD1tkMs7L/mWLyiFzWuEk2fg5Wu48QSZumEUy64
         ECCA==
X-Gm-Message-State: ACrzQf3BO1n/8MevGjRA3rzM4Zc8GkeTzz99LDC+KsgPm15ynuE0Cjyz
        cbghNvTexBwIeSDxY2B/0sc=
X-Google-Smtp-Source: AMsMyM759lTCYva2SRCMVpaxJkDBMnNk01vwq+a4ZRoMYs1eMs/Dzqw/L8Q2veNZoKpL092bf4ZJ7A==
X-Received: by 2002:a17:907:a067:b0:7a7:dc5e:eb2d with SMTP id ia7-20020a170907a06700b007a7dc5eeb2dmr58751784ejc.121.1668001791455;
        Wed, 09 Nov 2022 05:49:51 -0800 (PST)
Received: from krava ([83.240.62.198])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0073d84a321c8sm5900164eja.166.2022.11.09.05.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 05:49:50 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 9 Nov 2022 14:49:48 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Hao Sun <sunhao.th@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: WARNING in bpf_bprintf_prepare
Message-ID: <Y2uv/GjnSdr/ujOj@krava>
References: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
 <Y1pqWPRmP0M+hcXf@krava>
 <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
 <Y2J+n7SqmtfyA7ZM@krava>
 <Y2j6ivTwFmA0FtvY@krava>
 <CAADnVQKXcdVa-gDj2_QTrBuVea+KMuFUdabR--HCf7x6Vo6uXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKXcdVa-gDj2_QTrBuVea+KMuFUdabR--HCf7x6Vo6uXg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 07, 2022 at 12:49:01PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 7, 2022 at 4:31 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Nov 02, 2022 at 03:28:47PM +0100, Jiri Olsa wrote:
> > > On Thu, Oct 27, 2022 at 07:45:16PM +0800, Hao Sun wrote:
> > > > Jiri Olsa <olsajiri@gmail.com> 于2022年10月27日周四 19:24写道：
> > > > >
> > > > > On Thu, Oct 27, 2022 at 10:27:28AM +0800, Hao Sun wrote:
> > > > > > Hi,
> > > > > >
> > > > > > The following warning can be triggered with the C reproducer in the link.
> > > > > > Syzbot also reported this several days ago, Jiri posted a patch that
> > > > > > uses bpf prog `active` field to fix this by 05b24ff9b2cfab (bpf:
> > > > > > Prevent bpf program recursion...) according to syzbot dashboard
> > > > > > (https://syzkaller.appspot.com/bug?id=179313fb375161d50a98311a28b8e2fc5f7350f9).
> > > > > > But this warning can still be triggered on 247f34f7b803
> > > > > > (Linux-v6.1-rc2) that already merged the patch, so it seems that this
> > > > > > still is an issue.
> > > > > >
> > > > > > HEAD commit: 247f34f7b803 Linux 6.1-rc2
> > > > > > git tree: upstream
> > > > > > console output: https://pastebin.com/raw/kNw8JCu5
> > > > > > kernel config: https://pastebin.com/raw/sE5QK5HL
> > > > > > C reproducer: https://pastebin.com/raw/X96ASi27
> > > > >
> > > > > hi,
> > > > > right, that fix addressed that issue for single bpf program,
> > > > > and it won't prevent if there are multiple programs hook on
> > > > > contention_begin tracepoint and calling bpf_trace_printk,
> > > > >
> > > > > I'm not sure we can do something there.. will check
> > > > >
> > > > > do you run just the reproducer, or you load the server somehow?
> > > > > I cannot hit the issue so far
> > > > >
> > > >
> > > > Hi,
> > > >
> > > > Last email has format issues, resend it here.
> > > >
> > > > I built the kernel with the config in the link, which contains
> > > > “CONFIG_CMDLINE="earlyprintk=serial net.ifnames=0
> > > > sysctl.kernel.hung_task_all_cpu_backtrace=1 panic_on_warn=1 …”, and
> > > > boot the kernel with normal qemu setup and then the warning can be
> > > > triggered by executing the reproducer.
> > > >
> > > > Also, I’m willing to test the proposed patch if any.
> > >
> > > fyi I reproduced that.. will check if we can do anything about that
> >
> > I reproduced this with set of 8 programs all hooked to contention_begin
> > tracepoint and here's what I think is happening:
> >
> > all programs (prog1 .. prog8) call just bpf_trace_printk helper and I'm
> > running 'perf bench sched messaging' to load the machine
> >
> > at some point some contended lock triggers trace_contention_begin:
> >
> >   trace_contention_begin
> >     __traceiter_contention_begin                                <-- iterates all functions attached to tracepoint
> >       __bpf_trace_run(prog1)
> >         prog1->active = 1
> >         bpf_prog_run(prog1)
> >           bpf_trace_printk
> >             bpf_bprintf_prepare                                 <-- takes buffer 1 out of 3
> >             raw_spin_lock_irqsave(trace_printk_lock)
> >
> >               # we have global single trace_printk_lock, so we will trigger
> >               # its trace_contention_begin at some point
> >
> >               trace_contention_begin
> >                 __traceiter_contention_begin
> >                   __bpf_trace_run(prog1)
> >                     prog1->active block                         <-- prog1 is already 'running', skipping the execution
> >                   __bpf_trace_run(prog2)
> >                     prog2->active = 1
> >                     bpf_prog_run(prog2)
> >                       bpf_trace_printk
> >                         bpf_bprintf_prepare                     <-- takes buffer 2 out of 3
> >                         raw_spin_lock_irqsave(trace_printk_lock)
> >                           trace_contention_begin
> >                             __traceiter_contention_begin
> >                               __bpf_trace_run(prog1)
> >                                 prog1->active block             <-- prog1 is already 'running', skipping the execution
> >                               __bpf_trace_run(prog2)
> >                                 prog2->active block             <-- prog2 is already 'running', skipping the execution
> >                               __bpf_trace_run(prog3)
> >                                  prog3->active = 1
> >                                  bpf_prog_run(prog3)
> >                                    bpf_trace_printk
> >                                      bpf_bprintf_prepare        <-- takes buffer 3 out of 3
> >                                      raw_spin_lock_irqsave(trace_printk_lock)
> >                                        trace_contention_begin
> >                                          __traceiter_contention_begin
> >                                            __bpf_trace_run(prog1)
> >                                              prog1->active block      <-- prog1 is already 'running', skipping the execution
> >                                            __bpf_trace_run(prog2)
> >                                              prog2->active block      <-- prog2 is already 'running', skipping the execution
> >                                            __bpf_trace_run(prog3)
> >                                              prog3->active block      <-- prog3 is already 'running', skipping the execution
> >                                            __bpf_trace_run(prog4)
> >                                              prog4->active = 1
> >                                              bpf_prog_run(prog4)
> >                                                bpf_trace_printk
> >                                                  bpf_bprintf_prepare  <-- tries to take buffer 4 out of 3 -> WARNING
> >
> >
> > the code path may vary based on the contention of the trace_printk_lock,
> > so I saw different nesting within 8 programs, but all eventually ended up
> > at 4 levels of nesting and hit the warning
> >
> > I think we could perhaps move the 'active' flag protection from program
> > to the tracepoint level (in the patch below), to prevent nesting execution
> > of the same tracepoint, so it'd look like:
> >
> >   trace_contention_begin
> >     __traceiter_contention_begin
> >       __bpf_trace_run(prog1) {
> >         contention_begin.active = 1
> >         bpf_prog_run(prog1)
> >           bpf_trace_printk
> >             bpf_bprintf_prepare
> >             raw_spin_lock_irqsave(trace_printk_lock)
> >               trace_contention_begin
> >                 __traceiter_contention_begin
> >                   __bpf_trace_run(prog1)
> >                     blocked because contention_begin.active == 1
> >                   __bpf_trace_run(prog2)
> >                     blocked because contention_begin.active == 1
> >                   __bpf_trace_run(prog3)
> >                   ...
> >                   __bpf_trace_run(prog8)
> >                     blocked because contention_begin.active == 1
> >
> >             raw_spin_unlock_irqrestore
> >             bpf_bprintf_cleanup
> >
> >         contention_begin.active = 0
> >       }
> >
> >       __bpf_trace_run(prog2) {
> >         contention_begin.active = 1
> >         bpf_prog_run(prog2)
> >           ...
> >         contention_begin.active = 0
> >       }
> >
> > do we need bpf program execution in nested tracepoints?
> > we could actually allow 3 nesting levels for this case.. thoughts?
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > index 6a13220d2d27..5a354ae096e5 100644
> > --- a/include/trace/bpf_probe.h
> > +++ b/include/trace/bpf_probe.h
> > @@ -78,11 +78,15 @@
> >  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
> >
> >  #define __BPF_DECLARE_TRACE(call, proto, args)                         \
> > +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);              \
> >  static notrace void                                                    \
> >  __bpf_trace_##call(void *__data, proto)                                        \
> >  {                                                                      \
> >         struct bpf_prog *prog = __data;                                 \
> > -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > +                                                                       \
> > +       if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) == 1))             \
> > +               CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > +       this_cpu_dec(__bpf_trace_tp_active_##call);                                     \
> >  }
> 
> This approach will hurt real use cases where
> multiple and different raw_tp progs run on the same cpu.

would the 2 levels of nesting help in here?

I can imagine the change above would break use case where we want to
trigger tracepoints in irq context that interrupted task that's already
in the same tracepoint

with 2 levels of nesting we would trigger that tracepoint from irq and
would still be safe with bpf_bprintf_prepare buffer

what other use case do I miss?

thanks,
jirka

> Instead let's disallow attaching to trace_contention and
> potentially any other hook with similar recursion properties.
> Another option is to add a recursion check to trace_contention itself.

