Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2545C646F3B
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 13:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiLHME4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 07:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiLHMEx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 07:04:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9290887C93
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 04:04:51 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n20so3408976ejh.0
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 04:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpIrTw4BCFr2z6bPPXKbdPA+I5qboDkOeMgVRRrspVc=;
        b=jyTasroAUVnJ37Nuybc4DhX+gSqr/J8mKrDGCFYOnfxZ8qJ0TDvAgXdpE23s/5MGrq
         QGxQxAWYa2EPKHO/CUZfHEs6LLd4TqnpGtM1S+rkoS+ysgov4fPShrgx2EWUGWIfbTeF
         tSKBZRb76EfyQaFHwbNdBByfxbe0IrUrN1IY/ogofJs8u7yZXWIfQrAII4L2DBI3/p9L
         q8u8vgUC2gpvbqeUkX4wKLZWcfnol16FDgwiG7NRwczVO/y/OSRI/Art4/02H/+VsZ8t
         rH3WHRftJ+itI6oyN+xFPjqNLPhHIbQzoGFYufqc60HhI2kqBtrhSDrYsUvrml5Wh8sH
         GnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpIrTw4BCFr2z6bPPXKbdPA+I5qboDkOeMgVRRrspVc=;
        b=NvVgOqe+XBphHVeWM3Ih567W92IGD69WY8fwM6bK78vWj86sTIIhnj3fRYxD+qX2Kh
         //ZYY7VtsjUCsqK7ZUdtPcJOe8Pph9gaGWSeqsPqGYMimmy3Sju6H0AL5j5tk0Xeb3rk
         89D0BmkoAYbwWIU5zpA9nWq8z0C0TBcIPWattHgJ3u0qgEeq+KdYu/Y4ZvSfp5ZR0cMC
         fuCL5E/ezXOEX9su0wONSj71DP6HVTjyJ4xP/MBSeHGzRi6NVMRfjPzslfR8J0MO4eQM
         k5sLiBB64ilNEI3SZ94k+m5Q6Jt1MVpltnfWnqHXcG/7DUEB1uhX7P9HJU8ns2RLgQ37
         48Ug==
X-Gm-Message-State: ANoB5plKL5eC/ijnphCJYDXPM/ylrhMtZV9CKLePqKkeFEkOJM23ypiQ
        WuJOSVA7NQBRHR0it49NTnA=
X-Google-Smtp-Source: AA0mqf7c2I3KrRzcpZf06VRGoFuXsMqZz+huQsoQPqSbzL1TRCoGq70F18eTpN/BpCmAB3sZo/HSZA==
X-Received: by 2002:a17:906:3008:b0:7b5:73aa:9984 with SMTP id 8-20020a170906300800b007b573aa9984mr1782894ejz.14.1670501089641;
        Thu, 08 Dec 2022 04:04:49 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id lb26-20020a170907785a00b00781e7d364ebsm9768917ejc.144.2022.12.08.04.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 04:04:48 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 8 Dec 2022 13:04:46 +0100
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some
 tracepoints
Message-ID: <Y5HS3nmjARpe+Mef@krava>
References: <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava>
 <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y4uOSrXBxVwnxZkX@google.com>
 <Y43j3IGvLKgshuhR@krava>
 <CAADnVQLo1JBTg6iquCFj44AEuAhxj-V7a0T1gwejy1oDBDXcbA@mail.gmail.com>
 <Y4/27g8EHQ9F3bDr@google.com>
 <Y5BMRvsVMQtKvuhu@krava>
 <CAM9d7cgrgXPdUdL4WJ_MtBrrdJtSVsXF6REPJ9rSNVLms5k6LQ@mail.gmail.com>
 <Y5GA8LjlB1BDQ/TO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5GA8LjlB1BDQ/TO@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 10:15:12PM -0800, Namhyung Kim wrote:
> On Wed, Dec 07, 2022 at 11:08:40AM -0800, Namhyung Kim wrote:
> > On Wed, Dec 7, 2022 at 12:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Tue, Dec 06, 2022 at 06:14:06PM -0800, Namhyung Kim wrote:
> > >
> > > SNIP
> > >
> > > > -static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> > > > +static void *bpf_trace_norecurse_funcs[12] = {
> > > > +     (void *)bpf_trace_run_norecurse1,
> > > > +     (void *)bpf_trace_run_norecurse2,
> > > > +     (void *)bpf_trace_run_norecurse3,
> > > > +     (void *)bpf_trace_run_norecurse4,
> > > > +     (void *)bpf_trace_run_norecurse5,
> > > > +     (void *)bpf_trace_run_norecurse6,
> > > > +     (void *)bpf_trace_run_norecurse7,
> > > > +     (void *)bpf_trace_run_norecurse8,
> > > > +     (void *)bpf_trace_run_norecurse9,
> > > > +     (void *)bpf_trace_run_norecurse10,
> > > > +     (void *)bpf_trace_run_norecurse11,
> > > > +     (void *)bpf_trace_run_norecurse12,
> > > > +};
> > > > +
> > > > +static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
> > > > +                             void *func, void *data)
> > > >  {
> > > >       struct tracepoint *tp = btp->tp;
> > > >
> > > > @@ -2325,13 +2354,12 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
> > > >       if (prog->aux->max_tp_access > btp->writable_size)
> > > >               return -EINVAL;
> > > >
> > > > -     return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func,
> > > > -                                                prog);
> > > > +     return tracepoint_probe_register_may_exist(tp, func, data);
> > > >  }
> > > >
> > > >  int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> > > >  {
> > > > -     return __bpf_probe_register(btp, prog);
> > > > +     return __bpf_probe_register(btp, prog, btp->bpf_func, prog);
> > > >  }
> > > >
> > > >  int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> > > > @@ -2339,6 +2367,33 @@ int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> > > >       return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, prog);
> > > >  }
> > > >
> > > > +int bpf_probe_register_norecurse(struct bpf_raw_event_map *btp, struct bpf_prog *prog,
> > > > +                              struct bpf_raw_event_data *data)
> > > > +{
> > > > +     void *bpf_func;
> > > > +
> > > > +     data->active = alloc_percpu_gfp(int, GFP_KERNEL);
> > > > +     if (!data->active)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     data->prog = prog;
> > > > +     bpf_func = bpf_trace_norecurse_funcs[btp->num_args];
> > > > +     return __bpf_probe_register(btp, prog, bpf_func, data);
> > >
> > > I don't think we can do that, because it won't do the arg -> u64 conversion
> > > that __bpf_trace_##call functions are doing:
> > >
> > >         __bpf_trace_##call(void *__data, proto)                                 \
> > >         {                                                                       \
> > >                 struct bpf_prog *prog = __data;                                 \
> > >                 CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> > >         }
> > >
> > > like for 'old_pid' arg in sched_process_exec tracepoint:
> > >
> > >         ffffffff811959e0 <__bpf_trace_sched_process_exec>:
> > >         ffffffff811959e0:       89 d2                   mov    %edx,%edx
> > >         ffffffff811959e2:       e9 a9 07 14 00          jmp    ffffffff812d6190 <bpf_trace_run3>
> > >         ffffffff811959e7:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
> > >         ffffffff811959ee:       00 00
> > >
> > > bpf program could see some trash in args < u64
> > >
> > > we'd need to add 'recursion' variant for all __bpf_trace_##call functions
> > 
> > Ah, ok.  So 'contention_begin' tracepoint has unsigned int flags.
> > perf lock contention BPF program properly uses the lower 4 bytes of flags,
> > but others might access the whole 8 bytes then they will see the garbage.
> > Is that your concern?
> > 
> > Hmm.. I think we can use BTF to get the size of each argument then do
> > the conversion.  Let me see..
> 
> Maybe something like this?  But I'm not sure if I did cast_to_u64() right.

I guess that would work, but now I like the idea of fixing the original
issue by removing the spinlock from printk helpers completely

we might need to come back to something like this in future if we hit
similar issue and won't have better way to fix it

jirka
