Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E646EAF22
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjDUQb2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjDUQb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F1014F60;
        Fri, 21 Apr 2023 09:31:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5068e99960fso3153620a12.1;
        Fri, 21 Apr 2023 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094684; x=1684686684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJY90qvHEzq9C9/YygQLXvms0ufzbWjv2+WrMSO0/Ao=;
        b=jAXPhZrFB14fIBSk1i7Fu3rBFlmnsZmQ9ekoAhgFH0SQlgzzzJPesRQxAUKF2PIQR1
         6q27KZ870styKrsF54xNcfjdY9aedJrDo68IGkMCZKW32y+vuS/GuHnGbx4j2V8tzzBF
         wXdlWPzQaNclPGRN//8zPfBoDkYWsHKbKMIGp3sV5IPPoJcHqIDO+76MkkgEj3oidf85
         CNTTcMtmfGBVuLL2RB6NLMDErBwWpHeBDlJIx74+Nh5Os1tlHHN5OPhQs1DHW41XxrY+
         kOLDED+npJjJNdL6tFtAsqNlodj8OmkBKHMrak+dGIy8G86uXKeoGvrgtbT7EtjXLsvt
         lwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094684; x=1684686684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJY90qvHEzq9C9/YygQLXvms0ufzbWjv2+WrMSO0/Ao=;
        b=crD40Knx5CasFgbNF4WNRiCqLtNmGF7Td01JbWVN8+P7nv36M5QkTwvNq8Bw12ZYhp
         03P8AxjZCrwGlfnGPlJElpTtG1gE1LeSE4So3R1h3EmQg08h+KY9YxTvHXtNFFJFgspL
         0OFQwn0tSombJA8jxjOkqPSiRyKWb33gnzbEd8JvKy9g2C5UgpyCyoaHpL/3b19SWcR4
         +M8e4OU4bMLMMrq2g6VHyJYDyn9Cibrs2grseAU3yV1MraznWGLZ4V19PiZSHyyruNX0
         RVSLtP1DWBXO7t5Y74wrFyKpHymTu+Q5wuNNg1gaiwfMYlX7euePp6bRX4MUt1OMzREH
         2nRg==
X-Gm-Message-State: AAQBX9eVzbHpE9khmzcwtPfy8xD40yImA9GmeMAJF7ly8VGCZbgJlolA
        lkqh9xQPQfN59Mx91fEezb0sljTHLsr5H0klz5E=
X-Google-Smtp-Source: AKy350aeMjsMTQhUKimQ4WO2+F6txEMQZJ1kNBd/wS2q8hyhv+AuKWoRsKXGTXyYLAh/kktaJMxgxg4bSFfPdZ5oNmw=
X-Received: by 2002:a05:6402:5169:b0:506:6bd3:a53a with SMTP id
 d9-20020a056402516900b005066bd3a53amr4991872ede.0.1682094683735; Fri, 21 Apr
 2023 09:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
 <168198995084.1795549.16754963116067902376.stgit@mhiramat.roam.corp.google.com>
 <20230420184932.pgv5wiqqt4fzswdk@MacBook-Pro-6.local> <20230421084106.5a02844971e18cdd8ad163be@kernel.org>
 <CAADnVQ+R3ySQpFDnn-2EtUooDmkwTBCh_yRjqNBDhS5SvWrTYQ@mail.gmail.com> <20230421143828.bb274512144e133eb5fead1a@kernel.org>
In-Reply-To: <20230421143828.bb274512144e133eb5fead1a@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Apr 2023 09:31:12 -0700
Message-ID: <CAADnVQKAqZybpvzWRFCXmfbUSpaM2YYx9shRSSLnYWp=tQMyHg@mail.gmail.com>
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

On Thu, Apr 20, 2023 at 10:38=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Thu, 20 Apr 2023 16:46:08 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Thu, Apr 20, 2023 at 4:41=E2=80=AFPM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Thu, 20 Apr 2023 11:49:32 -0700
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > > On Thu, Apr 20, 2023 at 08:25:50PM +0900, Masami Hiramatsu (Google)=
 wrote:
> > > > > +static int fentry_perf_func(struct trace_fprobe *tf, unsigned lo=
ng entry_ip,
> > > > > +                       struct pt_regs *regs)
> > > > > +{
> > > > > +   struct trace_event_call *call =3D trace_probe_event_call(&tf-=
>tp);
> > > > > +   struct fentry_trace_entry_head *entry;
> > > > > +   struct hlist_head *head;
> > > > > +   int size, __size, dsize;
> > > > > +   int rctx;
> > > > > +
> > > > > +   if (bpf_prog_array_valid(call)) {
> > > > > +           unsigned long orig_ip =3D instruction_pointer(regs);
> > > > > +           int ret;
> > > > > +
> > > > > +           ret =3D trace_call_bpf(call, regs);
> > > >
> > > > Please do not call bpf from fprobe.
> > > > There is no use case for it.
> > >
> > > OK.
> > >
> > > >
> > > > > +
> > > > > +           /*
> > > > > +            * We need to check and see if we modified the pc of =
the
> > > > > +            * pt_regs, and if so return 1 so that we don't do th=
e
> > > > > +            * single stepping.
> > > > > +            */
> > > > > +           if (orig_ip !=3D instruction_pointer(regs))
> > > > > +                   return 1;
> > > > > +           if (!ret)
> > > > > +                   return 0;
> > > > > +   }
> > > > > +
> > > > > +   head =3D this_cpu_ptr(call->perf_events);
> > > > > +   if (hlist_empty(head))
> > > > > +           return 0;
> > > > > +
> > > > > +   dsize =3D __get_data_size(&tf->tp, regs);
> > > > > +   __size =3D sizeof(*entry) + tf->tp.size + dsize;
> > > > > +   size =3D ALIGN(__size + sizeof(u32), sizeof(u64));
> > > > > +   size -=3D sizeof(u32);
> > > > > +
> > > > > +   entry =3D perf_trace_buf_alloc(size, NULL, &rctx);
> > > > > +   if (!entry)
> > > > > +           return 0;
> > > > > +
> > > > > +   entry->ip =3D entry_ip;
> > > > > +   memset(&entry[1], 0, dsize);
> > > > > +   store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), ds=
ize);
> > > > > +   perf_trace_buf_submit(entry, size, rctx, call->event.type, 1,=
 regs,
> > > > > +                         head, NULL);
> > > > > +   return 0;
> > > > > +}
> > > > > +NOKPROBE_SYMBOL(fentry_perf_func);
> > > > > +
> > > > > +static void
> > > > > +fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > > > > +           unsigned long ret_ip, struct pt_regs *regs)
> > > > > +{
> > > > > +   struct trace_event_call *call =3D trace_probe_event_call(&tf-=
>tp);
> > > > > +   struct fexit_trace_entry_head *entry;
> > > > > +   struct hlist_head *head;
> > > > > +   int size, __size, dsize;
> > > > > +   int rctx;
> > > > > +
> > > > > +   if (bpf_prog_array_valid(call) && !trace_call_bpf(call, regs)=
)
> > > > > +           return;
> > > >
> > > > Same here.
> > > > These two parts look like copy-paste from kprobes.
> > > > I suspect this code wasn't tested at all.
> > >
> > > OK, I missed to test that bpf part. I thought bpf could be appended t=
o
> > > any "trace-event" (looks like trace-event), isn't it?
> >
> > No. We're not applying bpf filtering to any random event
> > that gets introduced in a tracing subsystem.
> > fprobe falls into that category.
> > Every hook where bpf can be invoked has to be thought through.
> > That mental exercise didn't happen here.
>
> OK. Just out of curiousity, where is the "tracepoint" filter applied?
> In the kernel (verifier?) or the userspace?

Sorry. I don't understand the question.
Are you talking about BPF_PROG_TYPE_TRACEPOINT or BPF_PROG_TYPE_RAW_TRACEPO=
INT ?
