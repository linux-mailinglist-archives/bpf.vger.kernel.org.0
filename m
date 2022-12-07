Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA5646181
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 20:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLGTLJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 14:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLGTLI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 14:11:08 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0546054351
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 11:11:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qk9so16312117ejc.3
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 11:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xhWBfJ3UROlAyzetr7niJMuklejkFqO8zZ/u0OkHzXc=;
        b=bpLdFtXIMJTiZ8fV9Kvgw0Oa8UT5NzlfbhaYGpm9kcn1418gL6hc8WOsl1luz9ZMwF
         jcgPCInYZdvqDJsRHjnrjSMR9z9Jn7k8h25r2iwKfL/IhZMIVOzp9Xf36nd23ljlYws1
         1jvRNuaxt+fDz5fDrMejstDYnqZSWPR0riIR0RMesI+AI3i3TgNiM2CWer1Y9SX2eqto
         vIF8rseo3RcO79J3hmxJm2Q1ScT8wtpklSUvCjqyu8c2wucH8rztrGHnRtyRnQrkU5fh
         2KugKLJ4wtu24zvF2hgOHVXyFvQkd9D/dhmDpy5hN2qgDGOinAteSnlJNa3ckI85saP0
         UB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhWBfJ3UROlAyzetr7niJMuklejkFqO8zZ/u0OkHzXc=;
        b=VAFiW8DETMsLuHEg3bFOlXBz9+zKczEvJJZ+MZiLBmJBo1kurfcxQZ4CIvQnauSHg3
         a9lVVfCAOtlPRbDHvYu4qpW8SusR9GkjFNScRsrSY0R/rd8MWsaJO3Vm0PZUO8Y52CmJ
         ech1PsXwnEowm3xoKxfBx2tSpXw21K2SOBj3de2hhLJ6wdlnvui0rmacfa4Ip1sgKH3m
         fe2xiDQfVQEcb/RM8euJyi2IjQupbI5ZB3Ihu6sRdtwBuAsf2EYABjX+qG1fdNl7sk9R
         Q/Irgkohy3COGvPaF6Yquy5EEY8gqKKL6GlRpEFD99j+8ypqoD0NAfGBMjC9Vs7NwmOw
         BW/w==
X-Gm-Message-State: ANoB5pnvjaxAgUX3sv13Nqmki6kGbLfrXgnp8vSNv2+nBS3eYuGNfMHx
        2n+HrvPFpX71IObBN/nl8qRulOkhuic0xl7n0GY=
X-Google-Smtp-Source: AA0mqf7Bi42umHQQug+vxd4cwJUhQX58+W1HrKi92QxsK7FbaGwcN7yXF2r0fBtZoTvkv5sOA8PEBds0BM+slG9coeU=
X-Received: by 2002:a17:906:2ac3:b0:7ad:f2f9:2b49 with SMTP id
 m3-20020a1709062ac300b007adf2f92b49mr63452039eje.94.1670440265544; Wed, 07
 Dec 2022 11:11:05 -0800 (PST)
MIME-Version: 1.0
References: <20221121213123.1373229-1-jolsa@kernel.org> <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava> <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava> <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y40U1D2bV+hlS/oi@krava> <Y5CXm+gL0lvdsd9e@krava>
In-Reply-To: <Y5CXm+gL0lvdsd9e@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 7 Dec 2022 11:10:54 -0800
Message-ID: <CAADnVQL+2kC5CMM8HsfPK28dpdsuWSZ8cLp_433ow2+h-H1kJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some tracepoints
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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

On Wed, Dec 7, 2022 at 5:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> looks like we can remove the spinlock completely by using the
> nested level buffer approach same way as in bpf_bprintf_prepare

imo that is a much better path forward.

> it gets rid of the contention_begin tracepoint, so I'm not being
> able to trigger the issue in my test
>
> jirka
>
>
> ---
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c810c..d6afde7311f8 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -369,33 +369,60 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
>         return &bpf_probe_write_user_proto;
>  }
>
> -static DEFINE_RAW_SPINLOCK(trace_printk_lock);
> -
>  #define MAX_TRACE_PRINTK_VARARGS       3
>  #define BPF_TRACE_PRINTK_SIZE          1024
> +#define BPF_TRACE_PRINTK_NEST          3
> +
> +struct trace_printk_buf {
> +       char data[BPF_TRACE_PRINTK_NEST][BPF_TRACE_PRINTK_SIZE];
> +       int nest;
> +};
> +static DEFINE_PER_CPU(struct trace_printk_buf, printk_buf);
> +
> +static void put_printk_buf(struct trace_printk_buf __percpu *buf)
> +{
> +       this_cpu_dec(buf->nest);
> +       preempt_enable();
> +}
> +
> +static bool get_printk_buf(struct trace_printk_buf __percpu *buf, char **data)
> +{
> +       int nest;
> +
> +       preempt_disable();
> +       nest = this_cpu_inc_return(buf->nest);
> +       if (nest > BPF_TRACE_PRINTK_NEST) {
> +               put_printk_buf(buf);
> +               return false;
> +       }
> +       *data = (char *) this_cpu_ptr(&buf->data[nest - 1]);
> +       return true;
> +}
>
>  BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
>            u64, arg2, u64, arg3)
>  {
>         u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
>         u32 *bin_args;
> -       static char buf[BPF_TRACE_PRINTK_SIZE];
> -       unsigned long flags;
> +       char *buf;
>         int ret;
>
> +       if (!get_printk_buf(&printk_buf, &buf))
> +               return -EBUSY;
> +
>         ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
>                                   MAX_TRACE_PRINTK_VARARGS);
>         if (ret < 0)
> -               return ret;
> +               goto out;
>
> -       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> -       ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
> +       ret = bstr_printf(buf, BPF_TRACE_PRINTK_SIZE, fmt, bin_args);
>
>         trace_bpf_trace_printk(buf);
> -       raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
>
>         bpf_bprintf_cleanup();
>
> +out:
> +       put_printk_buf(&printk_buf);
>         return ret;
>  }
>
> @@ -427,31 +454,35 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
>         return &bpf_trace_printk_proto;
>  }
>
> +static DEFINE_PER_CPU(struct trace_printk_buf, vprintk_buf);
> +
>  BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, data,
>            u32, data_len)
>  {
> -       static char buf[BPF_TRACE_PRINTK_SIZE];
> -       unsigned long flags;
>         int ret, num_args;
>         u32 *bin_args;
> +       char *buf;
>
>         if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
>             (data_len && !data))
>                 return -EINVAL;
>         num_args = data_len / 8;
>
> +       if (!get_printk_buf(&vprintk_buf, &buf))
> +               return -EBUSY;
> +
>         ret = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
>         if (ret < 0)
> -               return ret;
> +               goto out;
>
> -       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> -       ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
> +       ret = bstr_printf(buf, BPF_TRACE_PRINTK_SIZE, fmt, bin_args);
>
>         trace_bpf_trace_printk(buf);
> -       raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
>
>         bpf_bprintf_cleanup();
>
> +out:
> +       put_printk_buf(&vprintk_buf);
>         return ret;
>  }
>
