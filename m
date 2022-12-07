Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A0664645C
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 23:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLGW6Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 17:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLGW6N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 17:58:13 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44031DF1
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 14:58:12 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q190so7631464iod.10
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 14:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X4+754kGNwSrSafECbM/mTFd+0I8iUsm8N7iniDmY8s=;
        b=CT/NZRwd6Nr9pxFaQGbeiXT01qgHmPLioH1YX0lWaMd6OYwEj+Xf13uoi/dgxiWrSD
         MabMyWisLUFAc4E3yFq3VVdQ+hX+TmTzlqgqyYQS6hqIpxTNAMgi4dy2r79qkS8YudaR
         R9g9guwAPjhuM+cC7fTn5UENKIftf8VwP5HN8BXjNTzijDufm8ko1+IkVDlV3iOGELSH
         EsJA+zPlxd+ymQIycMq/GvDWJgNhbDMEbFsqSUpG3rM1fp495/jFExoPSl9AqMvd3pCI
         Psy2+au2W1dUUyoJA1Ov9tmiHOPfon+EmFPS0yeup/VzJNSFgfUNttySOoaefxorCRvP
         ZddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4+754kGNwSrSafECbM/mTFd+0I8iUsm8N7iniDmY8s=;
        b=4cV8OIN2a8gJnkcl0XFk2jtl1V5HPH7Vn4sPJZ4gTCrp2GzTHfhqYTggsjgEN1+0K1
         8X3524qh0DgbIqIadVAIVo2Mf1/pZ1HKP+LEGVHqkegTtdZNJuzcZWl6JyCAeyDMgWZl
         KQuZTPWZj/gM9heyzfZgkTaIycbgWD+fr2g6YvNd6k8JLfH2NPmHx6pkqa0gLiqXhmIG
         bIbRHhqK5HkX1D5jNpvSqmu7PBt9/7TImt43f7DdgrpxPvNf6IIZahS5YTIbDmRXrlJi
         r73ahAA94WEGj6ddSaWjPgvwkK8BxZJjdzcRMm54czMFPB/E6lAG9wxRTqhsch/dDnph
         v8Vw==
X-Gm-Message-State: ANoB5pmbsYZgWY2Pe//JcRkEfQFaBDtjz3VgQJmGma8Mix6vv1IkE3WH
        Ws1q1JT6vHgxy8Y+dgJhiIrblCUOBGs4aIeb23I=
X-Google-Smtp-Source: AA0mqf7o6+MIeNQkdKFCdPrLCMPmgJn8bIJliWfHpBaDpLuRDQSfeV5YAzIBfXKmai9EmkW/AeO/8hyk4vWUexhz2j4=
X-Received: by 2002:a6b:8b06:0:b0:6e0:28f8:83a4 with SMTP id
 n6-20020a6b8b06000000b006e028f883a4mr3941712iod.28.1670453891586; Wed, 07 Dec
 2022 14:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20221121213123.1373229-1-jolsa@kernel.org> <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava> <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava> <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y4uOSrXBxVwnxZkX@google.com> <Y43j3IGvLKgshuhR@krava> <CAADnVQLo1JBTg6iquCFj44AEuAhxj-V7a0T1gwejy1oDBDXcbA@mail.gmail.com>
 <Y4/27g8EHQ9F3bDr@google.com> <46AA3BAD-6E6C-4FFF-BA86-7B02F4D91452@gmail.com>
In-Reply-To: <46AA3BAD-6E6C-4FFF-BA86-7B02F4D91452@gmail.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 7 Dec 2022 14:58:00 -0800
Message-ID: <CAM9d7cjs1i3eH-+X9Chr+fd-yXjA3Dj+XJ_jpLvRU4UE=0pCBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some tracepoints
To:     Hao Sun <sunhao.th@gmail.com>
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

On Tue, Dec 6, 2022 at 9:23 PM Hao Sun <sunhao.th@gmail.com> wrote:
>
>
>
> > On 7 Dec 2022, at 10:14 AM, Namhyung Kim <namhyung@gmail.com> wrote:
> >
> > On Tue, Dec 06, 2022 at 12:09:51PM -0800, Alexei Starovoitov wrote:
> >> On Mon, Dec 5, 2022 at 4:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >>> index 3bbd3f0c810c..d27b7dc77894 100644
> >>> --- a/kernel/trace/bpf_trace.c
> >>> +++ b/kernel/trace/bpf_trace.c
> >>> @@ -2252,9 +2252,8 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
> >>> }
> >>>
> >>> static __always_inline
> >>> -void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
> >>> +void __bpf_trace_prog_run(struct bpf_prog *prog, u64 *args)
> >>> {
> >>> -       cant_sleep();
> >>>        if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
> >>>                bpf_prog_inc_misses_counter(prog);
> >>>                goto out;
> >>> @@ -2266,6 +2265,22 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
> >>>        this_cpu_dec(*(prog->active));
> >>> }
> >>>
> >>> +static __always_inline
> >>> +void __bpf_trace_run(struct bpf_raw_event_data *data, u64 *args)
> >>> +{
> >>> +       struct bpf_prog *prog = data->prog;
> >>> +
> >>> +       cant_sleep();
> >>> +       if (unlikely(!data->recursion))
> >>> +               return __bpf_trace_prog_run(prog, args);
> >>> +
> >>> +       if (unlikely(this_cpu_inc_return(*(data->recursion))))
> >>> +               goto out;
> >>> +       __bpf_trace_prog_run(prog, args);
> >>> +out:
> >>> +       this_cpu_dec(*(data->recursion));
> >>> +}
> >>
> >> This is way too much run-time and memory overhead to address
> >> this corner case. Pls come up with some other approach.
> >> Sorry I don't have decent suggestions at the moment.
> >> For now we can simply disallow attaching to contention_begin.
> >>
> >
> > How about this?  It seems to work for me.
>
> How about progs that are attached with kprobe?
> See this one:
> https://lore.kernel.org/bpf/CACkBjsb3GRw5aiTT=RCUs3H5aum_QN+B0ZqZA=MvjspUP6NFMg@mail.gmail.com/T/#u

Oh sorry, I'm just talking about the lock contention tracepoints.
For kprobe + printk, I don't have a good solution and I think it needs
some rework to use trylock as Andrii mentioned.

Thanks,
Namhyung
