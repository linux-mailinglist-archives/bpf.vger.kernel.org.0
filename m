Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052FD646180
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 20:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLGTI7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 14:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLGTI6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 14:08:58 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B25FC8
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 11:08:53 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id x11so7419340ilo.13
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 11:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VvSE48P9uKcEU/ORGe/SfSN7NhFuBjz0ZHMDLzxG63M=;
        b=IdFEg7ixw7Y+QJHqi1u8pXbNwO6s+xb3YfzaVI8HYtKcaZP/3wGIUE7DQnOS4JglxH
         FiDRsbl3rtu7pdIJVRSXU00OVFc02vYNoQF0+wvz58Tx93jsASG0fCtPTvjAr0X4MnG3
         AxXlXYo1crvlkQRy9iWSpaAOO2dIr7QWpzjWyntHAviQibC1kmCO2NpP6U/vqpNz9/mv
         WFnsroZE+XDmJMxHX1U/fkyepqmlNFozQYi/0Q2WELOIDLMpVXzzDWR1JkFwKxnsLR5x
         +5vXALz0idCV4c1fDTWcJiyDElnEpa/gfp3hnSW6GjcX+eyeBWWjoOyO0xSNnNa3jgQ1
         Dr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvSE48P9uKcEU/ORGe/SfSN7NhFuBjz0ZHMDLzxG63M=;
        b=JDMEHbMbIkRFgtHhmhDEvz1rzXDrp/N0Ot4Rm+BPeox9DxrqaJhBSLxPhlE8nhbYhz
         6bLCCt7/WDbekDTKc7j/bFBI4p0Mmrkg0W+013jnSRdQC316LWDv/QvWzLGQRoylYxpA
         Ob7yvgYLUGIk2QXDV1CA6b+1rWP3pRWHtevpFZfS8FGIzgWaVttougjjcigTZsonZTTw
         q3eUl4X2rDKAvgko7mCh6TDbRorHw0LYVfgI/d/E5Uu7b7za1VZ3b0X8AUj7CgW1MyFj
         yIw5TMnMjpW8mPJAJZFsakm8eqDQVQf1cjM6CMMBBEtZkyifRj1VsXWjYvRZkw+JSDKn
         /Hsw==
X-Gm-Message-State: ANoB5pk17wsUtrgAVQXTpnN7pNuQgAxNtGf7e1/VEflSAtRmRRgzbUy4
        Axe2ESVCKG1Id+oBbwExxekjyFbPclE3KIPhACs=
X-Google-Smtp-Source: AA0mqf7O4WCJX1zrUq5cGBpFV5kPSkqcIxPmSipVrazExmHN49lNOwVI3SJWYM3Na+SpUBF3/i6podSBx3IOK2DfdkM=
X-Received: by 2002:a92:c542:0:b0:300:e879:8094 with SMTP id
 a2-20020a92c542000000b00300e8798094mr34124585ilj.153.1670440132233; Wed, 07
 Dec 2022 11:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20221121213123.1373229-1-jolsa@kernel.org> <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava> <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava> <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y4uOSrXBxVwnxZkX@google.com> <Y43j3IGvLKgshuhR@krava> <CAADnVQLo1JBTg6iquCFj44AEuAhxj-V7a0T1gwejy1oDBDXcbA@mail.gmail.com>
 <Y4/27g8EHQ9F3bDr@google.com> <Y5BMRvsVMQtKvuhu@krava>
In-Reply-To: <Y5BMRvsVMQtKvuhu@krava>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 7 Dec 2022 11:08:40 -0800
Message-ID: <CAM9d7cgrgXPdUdL4WJ_MtBrrdJtSVsXF6REPJ9rSNVLms5k6LQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some tracepoints
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 7, 2022 at 12:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Dec 06, 2022 at 06:14:06PM -0800, Namhyung Kim wrote:
>
> SNIP
>
> > -static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> > +static void *bpf_trace_norecurse_funcs[12] = {
> > +     (void *)bpf_trace_run_norecurse1,
> > +     (void *)bpf_trace_run_norecurse2,
> > +     (void *)bpf_trace_run_norecurse3,
> > +     (void *)bpf_trace_run_norecurse4,
> > +     (void *)bpf_trace_run_norecurse5,
> > +     (void *)bpf_trace_run_norecurse6,
> > +     (void *)bpf_trace_run_norecurse7,
> > +     (void *)bpf_trace_run_norecurse8,
> > +     (void *)bpf_trace_run_norecurse9,
> > +     (void *)bpf_trace_run_norecurse10,
> > +     (void *)bpf_trace_run_norecurse11,
> > +     (void *)bpf_trace_run_norecurse12,
> > +};
> > +
> > +static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
> > +                             void *func, void *data)
> >  {
> >       struct tracepoint *tp = btp->tp;
> >
> > @@ -2325,13 +2354,12 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
> >       if (prog->aux->max_tp_access > btp->writable_size)
> >               return -EINVAL;
> >
> > -     return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func,
> > -                                                prog);
> > +     return tracepoint_probe_register_may_exist(tp, func, data);
> >  }
> >
> >  int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> >  {
> > -     return __bpf_probe_register(btp, prog);
> > +     return __bpf_probe_register(btp, prog, btp->bpf_func, prog);
> >  }
> >
> >  int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> > @@ -2339,6 +2367,33 @@ int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> >       return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, prog);
> >  }
> >
> > +int bpf_probe_register_norecurse(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
> > +                              struct bpf_raw_event_data *data)
> > +{
> > +     void *bpf_func;
> > +
> > +     data->active = alloc_percpu_gfp(int, GFP_KERNEL);
> > +     if (!data->active)
> > +             return -ENOMEM;
> > +
> > +     data->prog = prog;
> > +     bpf_func = bpf_trace_norecurse_funcs[btp->num_args];
> > +     return __bpf_probe_register(btp, prog, bpf_func, data);
>
> I don't think we can do that, because it won't do the arg -> u64 conversion
> that __bpf_trace_##call functions are doing:
>
>         __bpf_trace_##call(void *__data, proto)                                 \
>         {                                                                       \
>                 struct bpf_prog *prog = __data;                                 \
>                 CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
>         }
>
> like for 'old_pid' arg in sched_process_exec tracepoint:
>
>         ffffffff811959e0 <__bpf_trace_sched_process_exec>:
>         ffffffff811959e0:       89 d2                   mov    %edx,%edx
>         ffffffff811959e2:       e9 a9 07 14 00          jmp    ffffffff812d6190 <bpf_trace_run3>
>         ffffffff811959e7:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
>         ffffffff811959ee:       00 00
>
> bpf program could see some trash in args < u64
>
> we'd need to add 'recursion' variant for all __bpf_trace_##call functions

Ah, ok.  So 'contention_begin' tracepoint has unsigned int flags.
perf lock contention BPF program properly uses the lower 4 bytes of flags,
but others might access the whole 8 bytes then they will see the garbage.
Is that your concern?

Hmm.. I think we can use BTF to get the size of each argument then do
the conversion.  Let me see..

Thanks,
Namhyung
