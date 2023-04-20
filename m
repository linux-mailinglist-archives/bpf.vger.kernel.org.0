Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950376EA020
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 01:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjDTXqY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 19:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTXqX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 19:46:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9752111;
        Thu, 20 Apr 2023 16:46:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a34a14a54so152641666b.1;
        Thu, 20 Apr 2023 16:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682034380; x=1684626380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xqf59Ii4IYEZaM96rzFi8whEuwMh26KG4KwqKXwbu0=;
        b=oMWg8/uvHhUYtiPaukBZt5F4d6qhTI7j8FQfSZ7L4Y1Dso9/i7rzNl9GaZ5GPKqtHS
         q/HeDt2MW4I7mFN/RgpW2K0+PNqx69G3i+2/1dGwq4yHGyp0/nPF6xokKmhCmgvmDa8L
         qKwLu9Qb23vAJ6pg8zcebvJV6Ry68VCSOfNWx++ILVCjKckVmGeW0bS/LJe0X8cso75v
         Tlu4joB+B8S5YSmToHa+56kerQ0cotU76B2U3dnU0kKbJgJE/vUicgqNNwfBidalgeof
         xymYJQIcmMiO7tBUV3lwt7rGK7NPLT5PZoxwDe4kuVSwEyJBqzNTYjTnaAQou9xgvfhb
         9xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682034380; x=1684626380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xqf59Ii4IYEZaM96rzFi8whEuwMh26KG4KwqKXwbu0=;
        b=gMZ2btHEkFsbdaQ1jBEqhuMriRcH2zh1j+AUb/43gkf1aKCHlDgRezMwoDnQay0+4C
         xuRIIDQNagY6X9ArQaVcc1u2uZuK/IM+KVkvc2dnZhhpgg1y++OxfUnna4jLwy0FvGJv
         dVR6mJwmda1QBFN8BjFyQGfXtEUB1PnqgEFWbyBI5+8ewGPhePxRjxoQWkiAKTcxW2VP
         dAxqrp0ROfKuXqOdP49Pwy+OFr0eDSio8VgfqwMRs0a9e6sGhBEUl4BFL59P3KXrHvX3
         vv0GV5Oo4h3B0llamNzSFPbcDDN1nDJU5RNMELbiMeeEIfv1wPYX4gGao57Qe4D3Mwbh
         8UHA==
X-Gm-Message-State: AAQBX9ezMB/ZmlXEz9NhhN9VsuAObYJxcNP2SVAtIPTjIORcEneznT31
        a48iik8wilmps3FITWZjOXQ9doRy9X0PeBrbPTCxUTvu
X-Google-Smtp-Source: AKy350biykFxDyMb+QCuCH/YxI07CHZXuOblrr4du18kTIbLfYa9ETUZPtySBDyOBqCwG0yc1tkr/JieCfC4F+uA7s4=
X-Received: by 2002:a17:906:46d3:b0:94b:ffe9:37f6 with SMTP id
 k19-20020a17090646d300b0094bffe937f6mr289177ejs.3.1682034380110; Thu, 20 Apr
 2023 16:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
 <168198995084.1795549.16754963116067902376.stgit@mhiramat.roam.corp.google.com>
 <20230420184932.pgv5wiqqt4fzswdk@MacBook-Pro-6.local> <20230421084106.5a02844971e18cdd8ad163be@kernel.org>
In-Reply-To: <20230421084106.5a02844971e18cdd8ad163be@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Apr 2023 16:46:08 -0700
Message-ID: <CAADnVQ+R3ySQpFDnn-2EtUooDmkwTBCh_yRjqNBDhS5SvWrTYQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] tracing/probes: Add fprobe events for tracing
 function entry and exit.
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 20, 2023 at 4:41=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Thu, 20 Apr 2023 11:49:32 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Thu, Apr 20, 2023 at 08:25:50PM +0900, Masami Hiramatsu (Google) wro=
te:
> > > +static int fentry_perf_func(struct trace_fprobe *tf, unsigned long e=
ntry_ip,
> > > +                       struct pt_regs *regs)
> > > +{
> > > +   struct trace_event_call *call =3D trace_probe_event_call(&tf->tp)=
;
> > > +   struct fentry_trace_entry_head *entry;
> > > +   struct hlist_head *head;
> > > +   int size, __size, dsize;
> > > +   int rctx;
> > > +
> > > +   if (bpf_prog_array_valid(call)) {
> > > +           unsigned long orig_ip =3D instruction_pointer(regs);
> > > +           int ret;
> > > +
> > > +           ret =3D trace_call_bpf(call, regs);
> >
> > Please do not call bpf from fprobe.
> > There is no use case for it.
>
> OK.
>
> >
> > > +
> > > +           /*
> > > +            * We need to check and see if we modified the pc of the
> > > +            * pt_regs, and if so return 1 so that we don't do the
> > > +            * single stepping.
> > > +            */
> > > +           if (orig_ip !=3D instruction_pointer(regs))
> > > +                   return 1;
> > > +           if (!ret)
> > > +                   return 0;
> > > +   }
> > > +
> > > +   head =3D this_cpu_ptr(call->perf_events);
> > > +   if (hlist_empty(head))
> > > +           return 0;
> > > +
> > > +   dsize =3D __get_data_size(&tf->tp, regs);
> > > +   __size =3D sizeof(*entry) + tf->tp.size + dsize;
> > > +   size =3D ALIGN(__size + sizeof(u32), sizeof(u64));
> > > +   size -=3D sizeof(u32);
> > > +
> > > +   entry =3D perf_trace_buf_alloc(size, NULL, &rctx);
> > > +   if (!entry)
> > > +           return 0;
> > > +
> > > +   entry->ip =3D entry_ip;
> > > +   memset(&entry[1], 0, dsize);
> > > +   store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize)=
;
> > > +   perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, reg=
s,
> > > +                         head, NULL);
> > > +   return 0;
> > > +}
> > > +NOKPROBE_SYMBOL(fentry_perf_func);
> > > +
> > > +static void
> > > +fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > > +           unsigned long ret_ip, struct pt_regs *regs)
> > > +{
> > > +   struct trace_event_call *call =3D trace_probe_event_call(&tf->tp)=
;
> > > +   struct fexit_trace_entry_head *entry;
> > > +   struct hlist_head *head;
> > > +   int size, __size, dsize;
> > > +   int rctx;
> > > +
> > > +   if (bpf_prog_array_valid(call) && !trace_call_bpf(call, regs))
> > > +           return;
> >
> > Same here.
> > These two parts look like copy-paste from kprobes.
> > I suspect this code wasn't tested at all.
>
> OK, I missed to test that bpf part. I thought bpf could be appended to
> any "trace-event" (looks like trace-event), isn't it?

No. We're not applying bpf filtering to any random event
that gets introduced in a tracing subsystem.
fprobe falls into that category.
Every hook where bpf can be invoked has to be thought through.
That mental exercise didn't happen here.
