Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5B86237BB
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 00:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiKIXxY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 18:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiKIXxX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 18:53:23 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95A7642B;
        Wed,  9 Nov 2022 15:53:20 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id y14so936739ejd.9;
        Wed, 09 Nov 2022 15:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U5tKGqsesxNKEVPBejH+Kl9QFnk5O1iT9AjBkFsrSI8=;
        b=lQgHFw0DkhUROstVnmSoX1ifIssqls/Qtaq/LwUT4tAXNb/2fuWwE0vXP8Q0RRevW4
         wFgsKV6Ip/rpuNQLbSg480LydswTqXarkq+U8xL5/o+A4XHqIoUQiMAWSM1KU+/wHvtW
         +QhTd6s7lGvwdjh3b0Nq4v64tXnGmk0mC2HqlSJQbF1hTuVGF83tyFZCb6rswNvczMOR
         gh3KP4uC6I67Jwq/TeUOdePSPG1hMd6X+quDjp/D9dIcMj6kg4UolqAq35tn2TtDZsez
         M4JVmFZxxfYmlgBRYLlwj/nKNr3HYxnXc5Ur3l8fMwID2xS01olvq+hcsYK0ZDzWEA8S
         4kqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5tKGqsesxNKEVPBejH+Kl9QFnk5O1iT9AjBkFsrSI8=;
        b=46oiPjSgR4MBc74w1aAMEgCh8ww4RkyUXMk5mGsXePSVVA5t1JcSKbdb99KUCN/0dj
         MvdeU2n3JfClu70lVUUn6z1ymcjnwHG89EXKLxfOvvgJesLnG0N4s2sxj6yvqoX9W9BN
         JnEX2FdJ4coKOWAfCvLS3IiN/408K/gPZtUeyr6rbX7mnK122NgNZ9DTRMzinFLJuW8D
         s8hZPpMGUB3B3Hm6YPAZKa3rudFwUhV4eUTLLqnYqfaE62YD5b+qtq1eSXiMo0/AJXxZ
         LtIHm3eID9Z/PJu7hWHj2tVqUMoRp94IcVymvp0t7dAo9pT7UMvLvq1P6bL30M1tvZK+
         MkYw==
X-Gm-Message-State: ACrzQf1FCTNKJ/k/zxPR3JD4XY1vqivaiS43HpgkHerluBSnTggQlm+X
        loQeL5yohQd4irsYdsLKDdi+zpH8pO9A9w==
X-Google-Smtp-Source: AMsMyM67FdYv7Zv8Ro3BCuumnAkoVIuIRxgdlN7vymZ7C9zXcPmchG6jcyhFa1Nsd909ZM+6Q0lcHQ==
X-Received: by 2002:a17:906:cc0f:b0:7ad:2da5:4711 with SMTP id ml15-20020a170906cc0f00b007ad2da54711mr57675577ejb.628.1668037999157;
        Wed, 09 Nov 2022 15:53:19 -0800 (PST)
Received: from krava ([83.240.62.198])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709066b8a00b0077d37a5d401sm6456822ejr.33.2022.11.09.15.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:53:18 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 10 Nov 2022 00:53:16 +0100
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
Message-ID: <Y2w9bNhVlAs/PcNV@krava>
References: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
 <Y1pqWPRmP0M+hcXf@krava>
 <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
 <Y2J+n7SqmtfyA7ZM@krava>
 <Y2j6ivTwFmA0FtvY@krava>
 <CAADnVQKXcdVa-gDj2_QTrBuVea+KMuFUdabR--HCf7x6Vo6uXg@mail.gmail.com>
 <Y2uv/GjnSdr/ujOj@krava>
 <CAADnVQJp0ZrodRu8ZtvvtXk6KAbjxmwqD-nXgFAxNpNxN6JM=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJp0ZrodRu8ZtvvtXk6KAbjxmwqD-nXgFAxNpNxN6JM=g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 11:41:54AM -0800, Alexei Starovoitov wrote:
> On Wed, Nov 9, 2022 at 5:49 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Nov 07, 2022 at 12:49:01PM -0800, Alexei Starovoitov wrote:
> > > On Mon, Nov 7, 2022 at 4:31 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Wed, Nov 02, 2022 at 03:28:47PM +0100, Jiri Olsa wrote:
> > > > > On Thu, Oct 27, 2022 at 07:45:16PM +0800, Hao Sun wrote:
> > > > > > Jiri Olsa <olsajiri@gmail.com> 于2022年10月27日周四 19:24写道：
> > > > > > >
> > > > > > > On Thu, Oct 27, 2022 at 10:27:28AM +0800, Hao Sun wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > The following warning can be triggered with the C reproducer in the link.
> > > > > > > > Syzbot also reported this several days ago, Jiri posted a patch that
> > > > > > > > uses bpf prog `active` field to fix this by 05b24ff9b2cfab (bpf:
> > > > > > > > Prevent bpf program recursion...) according to syzbot dashboard
> > > > > > > > (https://syzkaller.appspot.com/bug?id=179313fb375161d50a98311a28b8e2fc5f7350f9).
> > > > > > > > But this warning can still be triggered on 247f34f7b803
> > > > > > > > (Linux-v6.1-rc2) that already merged the patch, so it seems that this
> > > > > > > > still is an issue.
> > > > > > > >
> > > > > > > > HEAD commit: 247f34f7b803 Linux 6.1-rc2
> > > > > > > > git tree: upstream
> > > > > > > > console output: https://pastebin.com/raw/kNw8JCu5
> > > > > > > > kernel config: https://pastebin.com/raw/sE5QK5HL
> > > > > > > > C reproducer: https://pastebin.com/raw/X96ASi27
> > > > > > >
> > > > > > > hi,
> > > > > > > right, that fix addressed that issue for single bpf program,
> > > > > > > and it won't prevent if there are multiple programs hook on
> > > > > > > contention_begin tracepoint and calling bpf_trace_printk,
> > > > > > >
> > > > > > > I'm not sure we can do something there.. will check
> > > > > > >
> > > > > > > do you run just the reproducer, or you load the server somehow?
> > > > > > > I cannot hit the issue so far
> > > > > > >
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Last email has format issues, resend it here.
> > > > > >
> > > > > > I built the kernel with the config in the link, which contains
> > > > > > “CONFIG_CMDLINE="earlyprintk=serial net.ifnames=0
> > > > > > sysctl.kernel.hung_task_all_cpu_backtrace=1 panic_on_warn=1 …”, and
> > > > > > boot the kernel with normal qemu setup and then the warning can be
> > > > > > triggered by executing the reproducer.
> > > > > >
> > > > > > Also, I’m willing to test the proposed patch if any.
> > > > >
> > > > > fyi I reproduced that.. will check if we can do anything about that
> > > >
> > > > I reproduced this with set of 8 programs all hooked to contention_begin
> > > > tracepoint and here's what I think is happening:
> > > >
> > > > all programs (prog1 .. prog8) call just bpf_trace_printk helper and I'm
> > > > running 'perf bench sched messaging' to load the machine
> > > >
> > > > at some point some contended lock triggers trace_contention_begin:
> > > >
> > > >   trace_contention_begin
> > > >     __traceiter_contention_begin                                <-- iterates all functions attached to tracepoint
> > > >       __bpf_trace_run(prog1)
> > > >         prog1->active = 1
> > > >         bpf_prog_run(prog1)
> > > >           bpf_trace_printk
> > > >             bpf_bprintf_prepare                                 <-- takes buffer 1 out of 3
> > > >             raw_spin_lock_irqsave(trace_printk_lock)
> > > >
> > > >               # we have global single trace_printk_lock, so we will trigger
> > > >               # its trace_contention_begin at some point
> > > >
> > > >               trace_contention_begin
> > > >                 __traceiter_contention_begin
> > > >                   __bpf_trace_run(prog1)
> > > >                     prog1->active block                         <-- prog1 is already 'running', skipping the execution
> > > >                   __bpf_trace_run(prog2)
> > > >                     prog2->active = 1
> > > >                     bpf_prog_run(prog2)
> > > >                       bpf_trace_printk
> > > >                         bpf_bprintf_prepare                     <-- takes buffer 2 out of 3
> > > >                         raw_spin_lock_irqsave(trace_printk_lock)
> > > >                           trace_contention_begin
> > > >                             __traceiter_contention_begin
> > > >                               __bpf_trace_run(prog1)
> > > >                                 prog1->active block             <-- prog1 is already 'running', skipping the execution
> > > >                               __bpf_trace_run(prog2)
> > > >                                 prog2->active block             <-- prog2 is already 'running', skipping the execution
> > > >                               __bpf_trace_run(prog3)
> > > >                                  prog3->active = 1
> > > >                                  bpf_prog_run(prog3)
> > > >                                    bpf_trace_printk
> > > >                                      bpf_bprintf_prepare        <-- takes buffer 3 out of 3
> > > >                                      raw_spin_lock_irqsave(trace_printk_lock)
> > > >                                        trace_contention_begin
> > > >                                          __traceiter_contention_begin
> > > >                                            __bpf_trace_run(prog1)
> > > >                                              prog1->active block      <-- prog1 is already 'running', skipping the execution
> > > >                                            __bpf_trace_run(prog2)
> > > >                                              prog2->active block      <-- prog2 is already 'running', skipping the execution
> > > >                                            __bpf_trace_run(prog3)
> > > >                                              prog3->active block      <-- prog3 is already 'running', skipping the execution
> > > >                                            __bpf_trace_run(prog4)
> > > >                                              prog4->active = 1
> > > >                                              bpf_prog_run(prog4)
> > > >                                                bpf_trace_printk
> > > >                                                  bpf_bprintf_prepare  <-- tries to take buffer 4 out of 3 -> WARNING
> > > >
> > > >
> > > > the code path may vary based on the contention of the trace_printk_lock,
> > > > so I saw different nesting within 8 programs, but all eventually ended up
> > > > at 4 levels of nesting and hit the warning
> > > >
> > > > I think we could perhaps move the 'active' flag protection from program
> > > > to the tracepoint level (in the patch below), to prevent nesting execution
> > > > of the same tracepoint, so it'd look like:
> > > >
> > > >   trace_contention_begin
> > > >     __traceiter_contention_begin
> > > >       __bpf_trace_run(prog1) {
> > > >         contention_begin.active = 1
> > > >         bpf_prog_run(prog1)
> > > >           bpf_trace_printk
> > > >             bpf_bprintf_prepare
> > > >             raw_spin_lock_irqsave(trace_printk_lock)
> > > >               trace_contention_begin
> > > >                 __traceiter_contention_begin
> > > >                   __bpf_trace_run(prog1)
> > > >                     blocked because contention_begin.active == 1
> > > >                   __bpf_trace_run(prog2)
> > > >                     blocked because contention_begin.active == 1
> > > >                   __bpf_trace_run(prog3)
> > > >                   ...
> > > >                   __bpf_trace_run(prog8)
> > > >                     blocked because contention_begin.active == 1
> > > >
> > > >             raw_spin_unlock_irqrestore
> > > >             bpf_bprintf_cleanup
> > > >
> > > >         contention_begin.active = 0
> > > >       }
> > > >
> > > >       __bpf_trace_run(prog2) {
> > > >         contention_begin.active = 1
> > > >         bpf_prog_run(prog2)
> > > >           ...
> > > >         contention_begin.active = 0
> > > >       }
> > > >
> > > > do we need bpf program execution in nested tracepoints?
> > > > we could actually allow 3 nesting levels for this case.. thoughts?
> > > >
> > > > thanks,
> > > > jirka
> > > >
> > > >
> > > > ---
> > > > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > > > index 6a13220d2d27..5a354ae096e5 100644
> > > > --- a/include/trace/bpf_probe.h
> > > > +++ b/include/trace/bpf_probe.h
> > > > @@ -78,11 +78,15 @@
> > > >  #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
> > > >
> > > >  #define __BPF_DECLARE_TRACE(call, proto, args)                         \
> > > > +static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);              \
> > > >  static notrace void                                                    \
> > > >  __bpf_trace_##call(void *__data, proto)                                        \
> > > >  {                                                                      \
> > > >         struct bpf_prog *prog = __data;                                 \
> > > > -       CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > > > +                                                                       \
> > > > +       if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) == 1))             \
> > > > +               CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > > > +       this_cpu_dec(__bpf_trace_tp_active_##call);                                     \
> > > >  }
> > >
> > > This approach will hurt real use cases where
> > > multiple and different raw_tp progs run on the same cpu.
> >
> > would the 2 levels of nesting help in here?
> >
> > I can imagine the change above would break use case where we want to
> > trigger tracepoints in irq context that interrupted task that's already
> > in the same tracepoint
> >
> > with 2 levels of nesting we would trigger that tracepoint from irq and
> > would still be safe with bpf_bprintf_prepare buffer
> 
> How would these 2 levels work?

just using the active counter like below, but I haven't tested it yet

jirka


---
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 6a13220d2d27..ca5dd34478b7 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -78,11 +78,15 @@
 #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
 
 #define __BPF_DECLARE_TRACE(call, proto, args)				\
+static DEFINE_PER_CPU(int, __bpf_trace_tp_active_##call);		\
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
 	struct bpf_prog *prog = __data;					\
-	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
+									\
+	if (likely(this_cpu_inc_return(__bpf_trace_tp_active_##call) < 3))		\
+		CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
+	this_cpu_dec(__bpf_trace_tp_active_##call);					\
 }
 
 #undef DECLARE_EVENT_CLASS
