Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F5575391
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 18:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiGNQ7w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 12:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiGNQ7v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 12:59:51 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1012AB9
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 09:59:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id o18so2091174pgu.9
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cR24ypFp0uSLqcF9EfjdVs8YMh3d094ckE1Lm5jv4pk=;
        b=CXXhOee3NJgmS2CcpF08wqDW7YIUCuezZ/Ot21DUSjfnE5l3R/rqZ6J11zWf4C8FHw
         X0RJqVbjR+MFU515FTTfvNmpjfLjDYmxn6OLj+QzUozxqJrzqs0z2EvlPpi5YCBXF22j
         rkx7P67hZ5RBgdearnF92BMVFtuIFJBJOPK12VOWlPZSP/MXAtJhXrMiFpra6OSetoW+
         dRiJNiNb7hP3o7eHKSPtRlToB5JZyQppVgrZnF1rx0YMAqWhi6xxqHBZ9npQQ/LItRBs
         7iebMwI/ncBGRzRSMaQwsiAEn38YWjcq6MeJnbq49u3d2kW/QTxZFNlRo2VNltrxaZCo
         xbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cR24ypFp0uSLqcF9EfjdVs8YMh3d094ckE1Lm5jv4pk=;
        b=ZgxkBZOdJHk7dJgOmnZXZGsS/ziWyt3Z8NU8XpQPxbXUA6gbuA7UpyAl7lVXgN00eL
         7MfB2paAQS9pco1mlEABU3LDkUzEBhu/dC8dVo0mTcHsfi3t4eOOoTXgew/OJXf3aL7d
         Yr44cw3pKQ2QgPfXu3ZrH7fMldX7Arr+1Fxa+A4VS/FF0F2DCWdvllPqk1DIvvajbWk7
         Pd+rD287PC0RuOeDDVAOsCRe9GsAzF9awHDmgCpk/VD2hmzLSmBladqz9VOgfd63EJJU
         z/mPYyh6Djy6ct3RHhZqX+qlWNIevOF8FtrPAZ79LMnyy8gJXGkMOOeCcBHQwMTsqI/U
         PpYQ==
X-Gm-Message-State: AJIora/rc24F1RpP/1wFdEmlt3t8QAL8pQFKr8pmOpgefI2c+fqRKEEm
        Ws/HKTuqpQjJ45Jq7FGWV04mKp4uamu6HAb3tkYcRw==
X-Google-Smtp-Source: AGRyM1sGF/+ZF7izADyyQeSA03fKjnbdv6UKwxHDWotoWK/fI0LHGv1B7Qdt4yt6peavip+NVyx3aDdo2/4J+lOxquc=
X-Received: by 2002:a63:6:0:b0:419:7b89:69ff with SMTP id 6-20020a630006000000b004197b8969ffmr8368526pga.442.1657817990089;
 Thu, 14 Jul 2022 09:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220714082316.479181-1-jolsa@kernel.org>
In-Reply-To: <20220714082316.479181-1-jolsa@kernel.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 14 Jul 2022 09:59:38 -0700
Message-ID: <CAKH8qBu+sNi8_004Hfz7rff14UfS0Js20ogLPGUfnxs7WfqMXw@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Do not attach kprobe_multi bench to bpf_dispatcher_xdp_func
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 1:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Alexei reported crash by running test_progs -j on system
> with 32 cpus.
>
> It turned out the kprobe_multi bench test that attaches all
> ftrace-able functions will race with bpf_dispatcher_update,
> that calls bpf_arch_text_poke on bpf_dispatcher_xdp_func,
> which is ftrace-able function.
>
> Ftrace is not aware of this update so this will cause
> ftrace_bug with:
>
>   WARNING: CPU: 6 PID: 1985 at
>   arch/x86/kernel/ftrace.c:94 ftrace_verify_code+0x27/0x50
>   ...
>   ftrace_replace_code+0xa3/0x170
>   ftrace_modify_all_code+0xbd/0x150
>   ftrace_startup_enable+0x3f/0x50
>   ftrace_startup+0x98/0xf0
>   register_ftrace_function+0x20/0x60
>   register_fprobe_ips+0xbb/0xd0
>   bpf_kprobe_multi_link_attach+0x179/0x430
>   __sys_bpf+0x18a1/0x2440
>   ...
>   ------------[ ftrace bug ]------------
>   ftrace failed to modify
>   [<ffffffff818d9380>] bpf_dispatcher_xdp_func+0x0/0x10
>    actual:   ffffffe9:7b:ffffff9c:77:1e
>   Setting ftrace call site to call ftrace function
>
> It looks like we need some way to way to hide some functions
> from ftrace, but meanwhile we workaround this by skipping
> bpf_dispatcher_xdp_func from kprobe_multi bench test.

Tangential: I've seen the same happen on our internal kernel, I
thought it's just due to our older ftrace subtree, but now looking at
the bpf-next tree I'm not sure. Maybe you can clarify for me?

I think what happens is: we attach a bpf program that uses text_poke
and enable ftrace graph and ftrace fails with the same
ftrace_verify_code.
I see that on the bpf side, we try to play nicely and use text_poke or
modify_ftrace_direct if the location is ftrace-managed, but I don't
see something similar on the ftrace side?
How is it supposed to work? Do we have some way to signal to ftrace
that we've text_poke'd the location and ftrace shouldn't try to touch
it?



> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 5b93d5d0bd93..8c442051f312 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -364,6 +364,8 @@ static int get_syms(char ***symsp, size_t *cntp)
>                         continue;
>                 if (!strncmp(name, "rcu_", 4))
>                         continue;
> +               if (!strncmp(name, "bpf_dispatcher_xdp_func", 23))
> +                       continue;
>                 if (!strncmp(name, "__ftrace_invalid_address__",
>                              sizeof("__ftrace_invalid_address__") - 1))
>                         continue;
> --
> 2.35.3
>
