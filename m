Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6B645365
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 06:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLGFXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 00:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLGFXW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 00:23:22 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C482AC52
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 21:23:21 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 124so16611407pfy.0
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 21:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDKPLnwu1lppCfZlzw6oTagpFvtpsRnqNgiW5bcKPgg=;
        b=aB73DdERYVmnlBpsfHhN4+J5o0DV0pfX1BjYUD6BKb+pUopNVeKZXAnz/rzS0GeIvg
         b+euITAaJt0VC7U0qefnYtAQGCNK0/Z9RUiR7asiLjVDQ5t8BMsPI5+ZOXp1yUjRb4Fz
         04h6NVKgDtDBfBRJcayT9+m+LtQ5azkDtlva7ppwsAslgjnZ6UNj6EcqstOdr9X/2vXy
         SgohxAplg7ScH3118EONS4saXYo0/Hlt0qJ6tq4bX5+yiFAVX6lIAz4aeYBPsyR04tJm
         YYUi45eIpXfvEUjxztp+DwE266NWQoqQOOjnuHe6m8ag1lcTdbUbzqk7I2wZrK70J43T
         h5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDKPLnwu1lppCfZlzw6oTagpFvtpsRnqNgiW5bcKPgg=;
        b=qMpD8wgn3tSF9iYT2S8fJ2sflSkFp+2RbomTq63AI/zEjsGu5FKLMarHDV9E7zkE0B
         qWwprlyxVv0NIxZ1e7/aXg8Ez6csFvwZrt0XiKT1NhFrldT9wmL8zOx8MFHH26N7idG0
         lOX4oNnVi/Svr20IWy2U7PdxqwqR+0twcRme7a/iYJUxC9U7eFHC5Ju3nXURWPVcfxuu
         dqe7h+F9L1/0oOiF9V4RRdGeETng5S+nSUDsigf9K9ElfYzFzuu+LG0zADtablWQ4gjM
         nx/GhiN57ttkzwd1Q2v5oVhe7WmIim23Xaqet+c1oJEFqytPIX/8wBZ4HEaol3pjPiMA
         VNVg==
X-Gm-Message-State: ANoB5pmMViTIcPdVi57sS1QbPpQq8Ny+7gpCA0ZgHdXOiokN8/HUD2Vv
        Qli4zd9o51WFYuf0yQeJnA==
X-Google-Smtp-Source: AA0mqf6XWPD13s/7fTapVFE858YMM+8bckVoP8HZa0ruDuSsWb1i9Kr0nHL1ta4ia2WEzIDsvHjR2w==
X-Received: by 2002:aa7:820e:0:b0:573:ab15:1d6f with SMTP id k14-20020aa7820e000000b00573ab151d6fmr79079504pfi.9.1670390601205;
        Tue, 06 Dec 2022 21:23:21 -0800 (PST)
Received: from smtpclient.apple ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id k129-20020a632487000000b00478b930f970sm4276050pgk.66.2022.12.06.21.23.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 21:23:20 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some
 tracepoints
From:   Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <Y4/27g8EHQ9F3bDr@google.com>
Date:   Wed, 7 Dec 2022 13:23:06 +0800
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <46AA3BAD-6E6C-4FFF-BA86-7B02F4D91452@gmail.com>
References: <20221121213123.1373229-1-jolsa@kernel.org>
 <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net> <Y388m6wOktvZo1d4@krava>
 <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava>
 <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y4uOSrXBxVwnxZkX@google.com> <Y43j3IGvLKgshuhR@krava>
 <CAADnVQLo1JBTg6iquCFj44AEuAhxj-V7a0T1gwejy1oDBDXcbA@mail.gmail.com>
 <Y4/27g8EHQ9F3bDr@google.com>
To:     Namhyung Kim <namhyung@gmail.com>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 7 Dec 2022, at 10:14 AM, Namhyung Kim <namhyung@gmail.com> wrote:
>=20
> On Tue, Dec 06, 2022 at 12:09:51PM -0800, Alexei Starovoitov wrote:
>> On Mon, Dec 5, 2022 at 4:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>> index 3bbd3f0c810c..d27b7dc77894 100644
>>> --- a/kernel/trace/bpf_trace.c
>>> +++ b/kernel/trace/bpf_trace.c
>>> @@ -2252,9 +2252,8 @@ void bpf_put_raw_tracepoint(struct =
bpf_raw_event_map *btp)
>>> }
>>>=20
>>> static __always_inline
>>> -void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
>>> +void __bpf_trace_prog_run(struct bpf_prog *prog, u64 *args)
>>> {
>>> -       cant_sleep();
>>>        if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
>>>                bpf_prog_inc_misses_counter(prog);
>>>                goto out;
>>> @@ -2266,6 +2265,22 @@ void __bpf_trace_run(struct bpf_prog *prog, =
u64 *args)
>>>        this_cpu_dec(*(prog->active));
>>> }
>>>=20
>>> +static __always_inline
>>> +void __bpf_trace_run(struct bpf_raw_event_data *data, u64 *args)
>>> +{
>>> +       struct bpf_prog *prog =3D data->prog;
>>> +
>>> +       cant_sleep();
>>> +       if (unlikely(!data->recursion))
>>> +               return __bpf_trace_prog_run(prog, args);
>>> +
>>> +       if (unlikely(this_cpu_inc_return(*(data->recursion))))
>>> +               goto out;
>>> +       __bpf_trace_prog_run(prog, args);
>>> +out:
>>> +       this_cpu_dec(*(data->recursion));
>>> +}
>>=20
>> This is way too much run-time and memory overhead to address
>> this corner case. Pls come up with some other approach.
>> Sorry I don't have decent suggestions at the moment.
>> For now we can simply disallow attaching to contention_begin.
>>=20
>=20
> How about this?  It seems to work for me.

How about progs that are attached with kprobe?
See this one:
=
https://lore.kernel.org/bpf/CACkBjsb3GRw5aiTT=3DRCUs3H5aum_QN+B0ZqZA=3DMvj=
spUP6NFMg@mail.gmail.com/T/#u

>=20
> Thanks,
> Namhyung
>=20
> ---
> include/linux/trace_events.h    | 14 +++++++
> include/linux/tracepoint-defs.h |  5 +++
> kernel/bpf/syscall.c            | 18 ++++++++-
> kernel/trace/bpf_trace.c        | 65 ++++++++++++++++++++++++++++++---
> 4 files changed, 95 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/linux/trace_events.h =
b/include/linux/trace_events.h
> index 20749bd9db71..461468210a77 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -742,6 +742,10 @@ void perf_event_detach_bpf_prog(struct perf_event =
*event);
> int perf_event_query_prog_array(struct perf_event *event, void __user =
*info);
> int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog =
*prog);
> int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct =
bpf_prog *prog);
> +int bpf_probe_register_norecurse(struct bpf_raw_event_map *btp, =
struct bpf_prog *prog,
> +  struct bpf_raw_event_data *data);
> +int bpf_probe_unregister_norecurse(struct bpf_raw_event_map *btp,
> +    struct bpf_raw_event_data *data);
> struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
> void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
> int bpf_get_perf_event_info(const struct perf_event *event, u32 =
*prog_id,
> @@ -775,6 +779,16 @@ static inline int bpf_probe_unregister(struct =
bpf_raw_event_map *btp, struct bpf
> {
> return -EOPNOTSUPP;
> }
> +static inline int bpf_probe_register_norecurse(struct =
bpf_raw_event_map *btp, struct bpf_prog *p,
> +        struct bpf_raw_event_data *data)
> +{
> + return -EOPNOTSUPP;
> +}
> +static inline int bpf_probe_unregister_norecurse(struct =
bpf_raw_event_map *btp,
> +  struct bpf_raw_event_data *data)
> +{
> + return -EOPNOTSUPP;
> +}
> static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const =
char *name)
> {
> return NULL;
> diff --git a/include/linux/tracepoint-defs.h =
b/include/linux/tracepoint-defs.h
> index e7c2276be33e..e5adfe606888 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -53,6 +53,11 @@ struct bpf_raw_event_map {
> u32 writable_size;
> } __aligned(32);
>=20
> +struct bpf_raw_event_data {
> + struct bpf_prog *prog;
> + int __percpu *active;
> +};
> +
> /*
>  * If a tracepoint needs to be called from a header file, it is not
>  * recommended to call it directly, as tracepoints in header files
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 35972afb6850..a8be9c443306 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3144,14 +3144,24 @@ static int bpf_tracing_prog_attach(struct =
bpf_prog *prog,
> struct bpf_raw_tp_link {
> struct bpf_link link;
> struct bpf_raw_event_map *btp;
> + struct bpf_raw_event_data data;
> };
>=20
> +static bool needs_recursion_check(struct bpf_raw_event_map *btp)
> +{
> + return !strcmp(btp->tp->name, "contention_begin");
> +}
> +
> static void bpf_raw_tp_link_release(struct bpf_link *link)
> {
> struct bpf_raw_tp_link *raw_tp =3D
> container_of(link, struct bpf_raw_tp_link, link);
>=20
> - bpf_probe_unregister(raw_tp->btp, raw_tp->link.prog);
> + if (needs_recursion_check(raw_tp->btp))
> + bpf_probe_unregister_norecurse(raw_tp->btp, &raw_tp->data);
> + else
> + bpf_probe_unregister(raw_tp->btp, raw_tp->link.prog);
> +
> bpf_put_raw_tracepoint(raw_tp->btp);
> }
>=20
> @@ -3348,7 +3358,11 @@ static int bpf_raw_tp_link_attach(struct =
bpf_prog *prog,
> goto out_put_btp;
> }
>=20
> - err =3D bpf_probe_register(link->btp, prog);
> + if (needs_recursion_check(link->btp))
> + err =3D bpf_probe_register_norecurse(link->btp, prog, &link->data);
> + else
> + err =3D bpf_probe_register(link->btp, prog);
> +
> if (err) {
> bpf_link_cleanup(&link_primer);
> goto out_put_btp;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c810c..edbfeff029aa 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2297,7 +2297,20 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 =
*args)
> REPEAT(x, COPY, __DL_SEM, __SEQ_0_11); \
> __bpf_trace_run(prog, args); \
> } \
> - EXPORT_SYMBOL_GPL(bpf_trace_run##x)
> + EXPORT_SYMBOL_GPL(bpf_trace_run##x); \
> + \
> + static void bpf_trace_run_norecurse##x(struct bpf_raw_event_data =
*data, \
> +       REPEAT(x, SARG, __DL_COM, __SEQ_0_11)) \
> + { \
> + u64 args[x]; \
> + if (unlikely(this_cpu_inc_return(*(data->active)) !=3D 1)) \
> + goto out; \
> + REPEAT(x, COPY, __DL_SEM, __SEQ_0_11); \
> + __bpf_trace_run(data->prog, args); \
> + out: \
> + this_cpu_dec(*(data->active)); \
> + }
> +
> BPF_TRACE_DEFN_x(1);
> BPF_TRACE_DEFN_x(2);
> BPF_TRACE_DEFN_x(3);
> @@ -2311,7 +2324,23 @@ BPF_TRACE_DEFN_x(10);
> BPF_TRACE_DEFN_x(11);
> BPF_TRACE_DEFN_x(12);
>=20
> -static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct =
bpf_prog *prog)
> +static void *bpf_trace_norecurse_funcs[12] =3D {
> + (void *)bpf_trace_run_norecurse1,
> + (void *)bpf_trace_run_norecurse2,
> + (void *)bpf_trace_run_norecurse3,
> + (void *)bpf_trace_run_norecurse4,
> + (void *)bpf_trace_run_norecurse5,
> + (void *)bpf_trace_run_norecurse6,
> + (void *)bpf_trace_run_norecurse7,
> + (void *)bpf_trace_run_norecurse8,
> + (void *)bpf_trace_run_norecurse9,
> + (void *)bpf_trace_run_norecurse10,
> + (void *)bpf_trace_run_norecurse11,
> + (void *)bpf_trace_run_norecurse12,
> +};
> +
> +static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct =
bpf_prog *prog,
> + void *func, void *data)
> {
> struct tracepoint *tp =3D btp->tp;
>=20
> @@ -2325,13 +2354,12 @@ static int __bpf_probe_register(struct =
bpf_raw_event_map *btp, struct bpf_prog *
> if (prog->aux->max_tp_access > btp->writable_size)
> return -EINVAL;
>=20
> - return tracepoint_probe_register_may_exist(tp, (void =
*)btp->bpf_func,
> -    prog);
> + return tracepoint_probe_register_may_exist(tp, func, data);
> }
>=20
> int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog =
*prog)
> {
> - return __bpf_probe_register(btp, prog);
> + return __bpf_probe_register(btp, prog, btp->bpf_func, prog);
> }
>=20
> int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct =
bpf_prog *prog)
> @@ -2339,6 +2367,33 @@ int bpf_probe_unregister(struct =
bpf_raw_event_map *btp, struct bpf_prog *prog)
> return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, =
prog);
> }
>=20
> +int bpf_probe_register_norecurse(struct bpf_raw_event_map *btp, =
struct bpf_prog *prog,
> +  struct bpf_raw_event_data *data)
> +{
> + void *bpf_func;
> +
> + data->active =3D alloc_percpu_gfp(int, GFP_KERNEL);
> + if (!data->active)
> + return -ENOMEM;
> +
> + data->prog =3D prog;
> + bpf_func =3D bpf_trace_norecurse_funcs[btp->num_args];
> + return __bpf_probe_register(btp, prog, bpf_func, data);
> +}
> +
> +int bpf_probe_unregister_norecurse(struct bpf_raw_event_map *btp,
> +    struct bpf_raw_event_data *data)
> +{
> + int err;
> + void *bpf_func;
> +
> + bpf_func =3D bpf_trace_norecurse_funcs[btp->num_args];
> + err =3D tracepoint_probe_unregister(btp->tp, bpf_func, data);
> + free_percpu(data->active);
> +
> + return err;
> +}
> +
> int bpf_get_perf_event_info(const struct perf_event *event, u32 =
*prog_id,
>     u32 *fd_type, const char **buf,
>     u64 *probe_offset, u64 *probe_addr)
> --=20
> 2.39.0.rc0.267.gcb52ba06e7-goog


