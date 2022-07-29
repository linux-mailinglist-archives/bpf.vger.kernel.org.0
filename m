Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551455856CE
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 00:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiG2WTI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 18:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiG2WTH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 18:19:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D63A747AE
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 15:19:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id z23so10742417eju.8
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zaDfU2JcvL+bmSoYN6TP/dVgee7Wqc7tPCMi92wJERo=;
        b=qJLH5Eb75MMF7SFKLDH61VHbIhp6FVLCmUwO7vWAog/eowSBOhyqILmenUpo52XrEQ
         //ABXfR2U5Kp6WAwL7OESiAp6DHeEkbyEv47kPcWAtM9FBDCk3QnJKVwbOucP0e2TnKB
         Y+Ezu29FESyDA27mqm6joJItlzSq2L0hRhiO/NLl41/MwFIDsk6Hq2gwrVW+3vQTbqbW
         AiuCGbIU2dNHTPtb/xiBswRofO8SjTvAeavIjDE/JZSykimV/aa+HGVZtPqC5riFfATx
         sC66mXn2asfgZ2qSpnkOOU0FkRfT88xrKIhYQJF0oJgedmcraO97+OOqQ9FkaX84FMnt
         G8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zaDfU2JcvL+bmSoYN6TP/dVgee7Wqc7tPCMi92wJERo=;
        b=oky15LIF9ieu7uMOSBG31A8nqmojyw7YlDIe7nVyD7F5UAGjfPvQqeu9EKPTt+lHDB
         n7t7xXZOy1fhE7a7i1D23owmYqh/pIYGwk3uboPIT5kkJsw8IJGOdoVuLmIDSBHQNdiE
         qyzIZeXeIMfMRKDj5EyspkqiXwCcy+sBLzzJ7JzYZSJ3dl0XAYTqIyfRRJq6QY7gDEzV
         8J89zgxNy2j0iGBPj0cDc5kmP3eBQ5/QNjR0M11O5KiyUu6vfsG7v+h4J3RTU4RnZVuK
         QMHTrB4xF9VvhgUj+Vdus0x5Ht1OUNOZ2nq7jtCej963Kt8SWf8qFrbXSr+cXxjepmqh
         BRJQ==
X-Gm-Message-State: AJIora9UDBKrCaWro8TmTTlgbLeK33WD7ZYj62Frnk+r1Jckvns5cqF0
        0lplJ3ISG4/s6mDY/Zw0UR34yui0rcwXuoHxCQI=
X-Google-Smtp-Source: AGRyM1sOsJlTLCIolw6yIV6gPuoZA9q+g/wHzSd2R2vFwKy9I1G2XSQe62AwAtJ+jPJ+rv/XBWZrVnkMv89ggcOmpkk=
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id
 jz15-20020a17090775ef00b0072b02fd1a92mr4382054ejc.745.1659133145518; Fri, 29
 Jul 2022 15:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220724212146.383680-1-jolsa@kernel.org>
In-Reply-To: <20220724212146.383680-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 29 Jul 2022 15:18:54 -0700
Message-ID: <CAEf4Bzbrqrg-wuNNWNJ1GSQQzLOF7azzM8B17ti1TBz_D7irKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Fixes for CONFIG_X86_KERNEL_IBT
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>
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

On Sun, Jul 24, 2022 at 2:21 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> Martynas reported bpf_get_func_ip returning +4 address when
> CONFIG_X86_KERNEL_IBT option is enabled and I found there are
> some failing bpf tests when this option is enabled.
>
> The CONFIG_X86_KERNEL_IBT option adds endbr instruction at the
> function entry, so the idea is to 'fix' entry ip for kprobe_multi
> and trampoline probes, because they are placed on the function
> entry.
>
> For kprobes I only fixed the bpf test program to adjust ip based
> on CONFIG_X86_KERNEL_IBT option. I'm not sure what the right fix
> should be in here, because I think user should be aware where the

user can't be aware of this when using multi-kprobe attach by symbolic
name of the function. So I think bpf_get_func_ip() at least in that
case should be compensating for KERNEL_IBT.

BTW, given in general kprobe can be placed in them middle of the
function, should bpf_get_func_ip() return zero or something for such
cases instead of wrong value somewhere in the middle of kprobe? If
user cares about current IP, they can get it with PT_REGS_IP(ctx),
right?

> kprobe is placed, on the other hand we move the kprobe address if
> its placed on top of endbr instruction.
>
> v1 changes:
>   - read previous instruction in kprobe_multi link handler
>     and adjust entry_ip for CONFIG_X86_KERNEL_IBT option
>   - split first patch into 2 separate changes
>   - update changelogs
>
> thanks,
> jirka
>
>
> ---
> Jiri Olsa (5):
>       ftrace: Keep the resolved addr in kallsyms_callback
>       bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
>       bpf: Use given function address for trampoline ip arg
>       selftests/bpf: Disable kprobe attach test with offset for CONFIG_X86_KERNEL_IBT
>       selftests/bpf: Fix kprobe get_func_ip tests for CONFIG_X86_KERNEL_IBT
>
>  arch/x86/net/bpf_jit_comp.c                               |  9 ++++-----
>  kernel/trace/bpf_trace.c                                  |  4 ++++
>  kernel/trace/ftrace.c                                     |  3 +--
>  tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 25 ++++++++++++++++++++-----
>  tools/testing/selftests/bpf/progs/get_func_ip_test.c      |  7 +++++--
>  tools/testing/selftests/bpf/progs/kprobe_multi.c          |  2 +-
>  6 files changed, 35 insertions(+), 15 deletions(-)
