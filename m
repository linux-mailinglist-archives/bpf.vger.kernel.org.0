Return-Path: <bpf+bounces-5311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B827597BB
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F431C2107A
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAE414015;
	Wed, 19 Jul 2023 14:08:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF61400C
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 14:08:48 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13610E53
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 07:08:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98e39784a85so183215366b.1
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689775721; x=1692367721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5pE2KxaEtZ8emm0G7nPTgtofnqAWb0qXB8UfemFzYj4=;
        b=Z8CWztAscaiRt0Wp822n3irIbpTeSxSZvlJ36VkswXIy13G4fj+6O2+fbtgFG5P/nK
         eryI0kvAceisOzXK+PwjJmKrJgoFk2jCml1BfEud47cEFmmTQ9HzIEooW2J+O139hSU9
         au8hmA5wgyBzcnoT5HY8i8E/QIyEfMqwbSjruK3by3vZED6f81sFSvb1STwqfuSyh564
         tiAEhU/aQWqCGsqhs9fl5tHF4Q5wb5+SdwwLD21PihrChKH6x+SIc5pn8Fs2pz9INZEZ
         xdF2UXpDWsT1xmZFQaFVmOhMmDlM2y3e2a5rhb8xNu8NB3PQO/qJeHby6NGGhWjAqHL0
         SRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689775721; x=1692367721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pE2KxaEtZ8emm0G7nPTgtofnqAWb0qXB8UfemFzYj4=;
        b=DBcsikvN08AC6uh++TBj92jNQ8uT8qh3AQ387Yhn2JHQmaPC1TCaJyTzWQa9t5/cB2
         5wNE5cXm68ov0yog60Dd8vI+ln1eFIRJkCBtTVbGUSH765z40K+ybsWx9R6EHaCjO+YS
         IfOeEqZ+xIsCU5LMIRdQSly/Bq7QceYjyrbZz5pZGn5G025MyIaUd2IeT9m1H/DNHD93
         +IeGprvoPz4vhb5iPL3lZm7eK+5l1vIQkwJt4+10fW6cd3Jftk7/K07nLHYjmCPtCY+Y
         FjXMQAO3C47VionP/6/7H9klsbQDrvpOIqZy5fdioCejL+JkdxJ9AIu8LrcGSErNYHBT
         oS/g==
X-Gm-Message-State: ABy/qLaFu29E8AIxwRVzZz6QjTo8xqgFlWCiQFEdtetda9eA4X0jG0dq
	FjD6CbNwzgYohsTTyiopzpE=
X-Google-Smtp-Source: APBJJlFsfLRLgc5fADDLZ8eZyr2NooFVz9CGykFa9EAYuwMOlEo69hnyAsTqs1CprIRtta+hbd8hQA==
X-Received: by 2002:a17:907:d24:b0:98e:3dac:6260 with SMTP id gn36-20020a1709070d2400b0098e3dac6260mr3164978ejc.13.1689775721213;
        Wed, 19 Jul 2023 07:08:41 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id f27-20020a1709062c5b00b00992ca779f42sm2414306ejh.97.2023.07.19.07.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:08:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 19 Jul 2023 16:08:38 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 1/2] bpf: Disable preemption in bpf_perf_event_output
Message-ID: <ZLfuZuBiexGqRSfl@krava>
References: <20230717111742.183926-1-jolsa@kernel.org>
 <20230717111742.183926-2-jolsa@kernel.org>
 <CAADnVQJ=h3yg0u6qEOBV+XmAWOVg7W7rsW05dK_WuYBUnZZ7zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ=h3yg0u6qEOBV+XmAWOVg7W7rsW05dK_WuYBUnZZ7zg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 05:59:53PM -0700, Alexei Starovoitov wrote:
> On Mon, Jul 17, 2023 at 4:17 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > The nesting protection in bpf_perf_event_output relies on disabled
> > preemption, which is guaranteed for kprobes and tracepoints.
> 
> I don't understand why you came up with such a conclusion.
> bpf_perf_event_output needs migration disabled and doesn't mind
> being preempted.
> That's what the nested counter is for.
> 
> Stack trace also doesn't look like it's related to that.
> More like stack corruption in perf_output_sample.

hum I think that with the preemption being enabled following scenario
is possible where at the end 2 tasks on same cpu can endup sharing same
pointer to struct perf_sample_data:


        task-1
        --------------------------------------------------------
        uprobe hit

        uprobe_dispatcher
        {
          __uprobe_perf_func
            bpf_prog_run_array_sleepable
            {
              might_fault
              rcu_read_lock_trace
              migrate_disable
              rcu_read_lock

              bpf_prog
                ...
                bpf_perf_event_output
                {
                  nest_level = bpf_trace_nest_level = 1
                  sd = &sds->sds[0];

        -> preempted by task-2


                                                                        task-2
                                                                        --------------------------------------------------------
                                                                        uprobe hit

                                                                        uprobe_dispatcher
                                                                          __uprobe_perf_func
                                                                            bpf_prog_run_array_sleepable

                                                                              might_fault
                                                                              rcu_read_lock_trace
                                                                              migrate_disable
                                                                              rcu_read_lock

                                                                              bpf_prog
                                                                                ...
                                                                                bpf_perf_event_output
                                                                                {
                                                                                  nest_level = bpf_trace_nest_level = 2
                                                                                  sd = &sds->sds[1];

                                                                        -> preempted by task-1



                  __bpf_perf_event_output(regs, map, flags, sd);
                    perf_output_sample(data)

                  bpf_trace_nest_level = 1

                } /* bpf_perf_event_output */

              rcu_read_unlock
              migrate_enable
              rcu_read_unlock_trace

            } /* bpf_prog_run_array_sleepable */
        } /* uprobe_dispatcher */

        uprobe hit

        uprobe_dispatcher
        {
          __uprobe_perf_func
            bpf_prog_run_array_sleepable
            {
              might_fault
              rcu_read_lock_trace
              migrate_disable
              rcu_read_lock

              bpf_prog
                ...
                bpf_perf_event_output {
                  nest_level = bpf_trace_nest_level = 2
                  sd = &sds->sds[1];


now task-1 and task-2 share same bpf_trace_nest_level value and same
'struct perf_sample_data' buffer on top of &sds->sds[1]

I did not figure out yet the actual exact scenario/cause of the crash yet,
I suspect one of the tasks copies data over some boundary, but all the
ideas I had so far did not match the instructions from the crash

anyway I thought that having 2 tasks sharing the same perf_sample_data
is bad enough to send the patch

> 
> Do you have
> commit eb81a2ed4f52 ("perf/core: Fix perf_output_begin parameter is
> incorrectly invoked in perf_event_bpf_output")
> in your kernel?

yes, I just retested and see that on latest bpf-next/master

jirka

> 
> > However bpf_perf_event_output can be also called from uprobes context
> > through bpf_prog_run_array_sleepable function which disables migration,
> > but keeps preemption enabled.
> >
> > This can cause task to be preempted by another one inside the nesting
> > protection and lead eventually to two tasks using same perf_sample_data
> > buffer and cause crashes like:
> >
> >   kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> >   BUG: unable to handle page fault for address: ffffffff82be3eea
> >   ...
> >   Call Trace:
> >    ? __die+0x1f/0x70
> >    ? page_fault_oops+0x176/0x4d0
> >    ? exc_page_fault+0x132/0x230
> >    ? asm_exc_page_fault+0x22/0x30
> >    ? perf_output_sample+0x12b/0x910
> >    ? perf_event_output+0xd0/0x1d0
> >    ? bpf_perf_event_output+0x162/0x1d0
> >    ? bpf_prog_c6271286d9a4c938_krava1+0x76/0x87
> >    ? __uprobe_perf_func+0x12b/0x540
> >    ? uprobe_dispatcher+0x2c4/0x430
> >    ? uprobe_notify_resume+0x2da/0xce0
> >    ? atomic_notifier_call_chain+0x7b/0x110
> >    ? exit_to_user_mode_prepare+0x13e/0x290
> >    ? irqentry_exit_to_user_mode+0x5/0x30
> >    ? asm_exc_int3+0x35/0x40
> >
> > Fixing this by disabling preemption in bpf_perf_event_output.
> >
> > Fixes: 9594dc3c7e71 ("bpf: fix nested bpf tracepoints with per-cpu data")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index c92eb8c6ff08..2a6ba05d8aee 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -661,8 +661,7 @@ static DEFINE_PER_CPU(int, bpf_trace_nest_level);
> >  BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
> >            u64, flags, void *, data, u64, size)
> >  {
> > -       struct bpf_trace_sample_data *sds = this_cpu_ptr(&bpf_trace_sds);
> > -       int nest_level = this_cpu_inc_return(bpf_trace_nest_level);
> > +       struct bpf_trace_sample_data *sds;
> >         struct perf_raw_record raw = {
> >                 .frag = {
> >                         .size = size,
> > @@ -670,7 +669,12 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
> >                 },
> >         };
> >         struct perf_sample_data *sd;
> > -       int err;
> > +       int nest_level, err;
> > +
> > +       preempt_disable();
> > +
> > +       sds = this_cpu_ptr(&bpf_trace_sds);
> > +       nest_level = this_cpu_inc_return(bpf_trace_nest_level);
> >
> >         if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
> >                 err = -EBUSY;
> > @@ -691,6 +695,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
> >
> >  out:
> >         this_cpu_dec(bpf_trace_nest_level);
> > +       preempt_enable();
> >         return err;
> >  }
> >
> > --
> > 2.41.0
> >

