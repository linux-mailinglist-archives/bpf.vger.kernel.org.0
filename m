Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983635F495C
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJDSoS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 14:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJDSoR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 14:44:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE51C659DE
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 11:44:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c24so13417084plo.3
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date;
        bh=tbMRAh1W2vC7AY7Uhw5dOfdFqtldEyxqCOnuYZYuxaA=;
        b=n+okaLo/xXrCYN/5Y11WAmJLVfwAizRk8kdn+5pzar0ZZJstpQkODRWDQz8Mu/a+wM
         IPwyUNtug0+jHuNn33fIl2id86He55ZhNbnBX4nYU/xySUAZP9+l8pFMdVjzC1Af7rrg
         rITqsqsgZNPMOTK43lzVlgQjn9i6cBTCo/G4B6NwN5sQA42FUxnxuc3/Ady8QanYWf+D
         vHxwyEOn7GV2kW9x9rAOxXX46HJNJUaiF9dunzBheqUU1job050DWR1Jni7StjLolzOA
         czFzU2njMfGq7xLNBktk5UqNAALhljwJDVSEY53yHWKoGO1UD0yoeJgWihhJmAm0JeLU
         SZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tbMRAh1W2vC7AY7Uhw5dOfdFqtldEyxqCOnuYZYuxaA=;
        b=pFqdQrYFNqcRawjcurTR0bz9cPzX1ydtLfBatmMbFOVVWv/DvDJNOe+AlOgtyy3AyD
         05x8GP4XHiKu7+GluY1qZgzTHh2iRs30lIPbGECAqMYT1ZHnrnpJ/da3aBA3uzJCM4tL
         DJTB4tXiMZ++edHBKnbUkuLx1hwZpOHpLROHTkURosjVusY7RUH3JKzqyfMnSKtEU9Sd
         Nz2JOV7cMfL5mwvmEDl1zO81whvgCGZoqSLBrJGtoUVY8a4QMaJXFkCfiG/JGXLh5hgh
         g3ps465qXhbrxsKwbkgJf1hxSRjQfCZMlFXswjy3Tf0acejT3En5Rko1MWAirhwBCqdg
         bGFg==
X-Gm-Message-State: ACrzQf0d6tb+SsmWUlFi97AE7RL9zQAkrs25dx5T0o11VQUn7R/6AKOZ
        BZwadBqNUvYR5oep2wAjAAI23galpDSWJOjeRgWkPiaafrc=
X-Google-Smtp-Source: AMsMyM7PesQX3wIbIi9lHtvSNnIGCnVc7UCleYf+DCtb4SAyX1/85nsMu8G2/czpFoq/HgnOc2cGvsfiFAWfDp45wnw=
X-Received: by 2002:a17:90b:17c4:b0:20a:7f07:d878 with SMTP id
 me4-20020a17090b17c400b0020a7f07d878mr1058913pjb.7.1664909055971; Tue, 04 Oct
 2022 11:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACG+mBWpDSrxUR4RehJPpcF_BdF8-7+HHqmdq+ULpWrpE8BGDA@mail.gmail.com>
In-Reply-To: <CACG+mBWpDSrxUR4RehJPpcF_BdF8-7+HHqmdq+ULpWrpE8BGDA@mail.gmail.com>
From:   Henrique Fingler <henrique.fingler@gmail.com>
Date:   Tue, 4 Oct 2022 13:44:05 -0500
Message-ID: <CACG+mBX5tiovf3tz-K_BZGAOi5L=BKAVUv564+HzMmR+E9j2bA@mail.gmail.com>
Subject: Re: Can't reproduce kfunc example in kfuncs documentation, kernel v6.0
To:     bpf@vger.kernel.org
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

> I'm trying to reproduce the example in `Documentation/bpf/kfuncs.rst`
> in kernel 6.0
> My end goal is to be able to call a kfunc from a kprobe, so the
> documentation seemed like a good start.
> I've created a file with almost the same content as the documentation
> (below) and put it in
> net/bpf and added it to the Makefile, with the added __diag directives
> that are in
> net/bpf/test_run.c around the kfuncs.
>
>  __diag_push();
>  __diag_ignore_all("-Wmissing-prototypes",
>       "Global functions as their definitions will be in vmlinux BTF");
>   u64 bpf_get_task_pid(void) {
>     return 1;
>   }
>    u64 bpf_put_pid(void) {
>     return 2;
>   }
>   __diag_pop();
>
>   BTF_SET8_START(bpf_task_set)
>   BTF_ID_FLAGS(func, bpf_get_task_pid)
>   BTF_ID_FLAGS(func, bpf_put_pid)
>   BTF_SET8_END(bpf_task_set)
>
>   static const struct btf_kfunc_id_set bpf_task_kfunc_set = {
>       .owner = THIS_MODULE,
>       .set   = &bpf_task_set,
>   };
>
>   static int bpftest_init_subsystem(void)
>   {
>     pr_warn(">>>>>>>>>>>>>>> bpftest_init_subsystem registered");
>     //I want BPF_PROG_TYPE_KPROBE, but I'm testing also with
> BPF_PROG_TYPE_TRACEPOINT
>     return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_task_kfunc_set);
>   }
>   late_initcall(bpftest_init_subsystem);
>
>
> I can see that this is being registered, but after that I see many
> (16, all the same) messages like the one below.
> These messages are gone if I don't compile the file I created above.
> Is this file breaking something in bpf?
>
> [    5.845543] failed to validate module [cryptd] BTF: -22
> [    5.861117] BPF: [129150] STRUCT
> [    5.862980] BPF: size=96 vlen=1
> [    5.864710] BPF:
> [    5.865941] BPF: Invalid name
> [    5.867221] BPF:
>
>
> Ignoring these errors, I've tried both KPROBE and TRACEPOINT prog
> types in `register_btf_kfunc_id_set`.
> I can't find what a program with "tracing" is, so I changed it to
> BPF_PROG_TYPE_TRACEPOINT and used
> an example from the kernel: samples/bpf/syscall_tp_kern.c
> As for testing with KPROBE, I'm using the kprobe.bpf.c do_unlinkat
> example in libbpf/libbpf-bootstrap.
> It seems like the kfunc is not being found in the set, or the set is
> not registered correctly,
> since running the bpf program with any of the two types prints out:
>
>   libbpf: prog 'trace_enter_open': BPF program load failed: Permission denied
>   ...
>   calling kernel function bpf_get_task_pid is not allowed
>
> Both the bpf programs are simple, their bodies have:
>     __u64 a = bpf_get_task_pid();
> The function is getting resolved since I see
> libbpf: extern (func ksym) 'bpf_get_task_pid': resolved to kernel
>
> How can I correctly register a set and make the kernel allow me to call a kfunc?
> Thank you.

Turns out KPROBE or TRACEPOINT don't have hooks, so the id is never found.
After creating one for each in kernel/bpf/btf.c it works.

I still don't know why the `failed to validate module [cryptd] BTF:
-22` error is happening,
but I'll ignore it for now.
