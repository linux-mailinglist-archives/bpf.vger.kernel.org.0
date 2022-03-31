Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EAD4ED360
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 07:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiCaFqX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 01:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiCaFqX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 01:46:23 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634D41005
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 22:44:36 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id 14so11339372ily.11
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 22:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6gn1A7s5SMbhWaFNVx6lzz3XX9OhD9SRwLHDjWWq18=;
        b=mxdxHFRW1qB+HUyXTEWhvXKnaeiaX8FYwPXTOwu3knLqKw7N2pnqN1Q+agI1fN3frD
         SmnZbbhWefAJS2WuSWRaZouA8DA0BRTAnNVbc6zvp6uGWSJZ4E0bwQBu7GDjIbnM2ynU
         oOdfApLTWVMMRHw2jo1WaNGcxM+Sk5xcxf3HZ9h+6vFjgFi57necyZA6vCkGOjKugM6T
         cxuJlIu6OhGmIH1tC9rFli6l0iyQyv67GuGPW27u8NiJJwtGzDNvrbhuraGNNvgLetDi
         8O8oGgojzRL5TDZhHh7xLJHWbvFZoeWY+mBKrFVz0dBZwX7TDnhIBglreh971Iauhiex
         /MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6gn1A7s5SMbhWaFNVx6lzz3XX9OhD9SRwLHDjWWq18=;
        b=GYNAUQTAv3BmP9xlwGMRDUz8n75Au2roVXtxmMOWKdy6IJJx40tEn/3aqgTftpfnpS
         80sYShjkKgJjm6POee3wmSHpClobWz5e2wS9EtAsTBNIab0eRgwZ/a49OkJfw4qiyLdx
         JE3vinXDd8TUGmim19uHde85LDpo36j6sIjDLlJBfdHZPawmoBCHIbMMSTy/dz2mj1kR
         zbOchr8hy+43KJps1TyvcW59KpaRNrlEswnw3wBxZCLwr/G/f+ihn9hh1KP5F9ila+Pn
         YgkXOmlNt1wKW4oQI24vWmCyg5iAdK9nLo+P4DNvvR/n+GS3+Ij9CODIDdSH8NV92Ors
         nDjw==
X-Gm-Message-State: AOAM53194CxFfUwM+lsmhw8M6mRC5gaf9nvjPFWvPAxIVNgYAs3LcMFD
        PUPD2qs+74GCfCTQov3D/2tQL4u9SmQtRk0JrhY=
X-Google-Smtp-Source: ABdhPJxZxNEhE+fUEE8Rb2vKfoRTRQs4tuYWq75jnhyAUdo3IPHl5kvpi/hzl9uKPzOZRbhYc7SMwTW4ZTGYlSI6zzE=
X-Received: by 2002:a05:6e02:1562:b0:2c9:cb97:9a4 with SMTP id
 k2-20020a056e02156200b002c9cb9709a4mr7426767ilu.71.1648705475742; Wed, 30 Mar
 2022 22:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-2-andrii@kernel.org>
 <176471e1-1221-8eb3-300e-986e3a6eaef8@gmail.com> <b11ef0fa-da27-cf96-cb5c-e61c04b5f735@gmail.com>
In-Reply-To: <b11ef0fa-da27-cf96-cb5c-e61c04b5f735@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Mar 2022 22:44:24 -0700
Message-ID: <CAEf4BzbSYpEXimyeGqhFU_F4z+yzYUCV3s3Yzwx4zWbxs55JjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] libbpf: add BPF-side of USDT support
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 30, 2022 at 8:22 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 2022/3/30 11:10 AM, Hengqi Chen wrote:
> > On 2022/3/25 1:29 PM, Andrii Nakryiko wrote:
> >> Add BPF-side implementation of libbpf-provided USDT support. This
> >> consists of single header library, usdt.bpf.h, which is meant to be used
> >> from user's BPF-side source code. This header is added to the list of
> >> installed libbpf header, along bpf_helpers.h and others.
> >>
> >> BPF-side implementation consists of two BPF maps:
> >>   - spec map, which contains "a USDT spec" which encodes information
>
> ...
>
> >> +}
> >> +
> >> +/* Fetch USDT argument *arg* (zero-indexed) and put its value into *res.
> >> + * Returns 0 on success; negative error, otherwise.
> >> + * On error *res is guaranteed to be set to zero.
> >> + */
> >> +__hidden __weak
> >> +int bpf_usdt_arg(struct pt_regs *ctx, int arg, long *res)
> >> +{
> >> +    struct __bpf_usdt_spec *spec;
> >> +    struct __bpf_usdt_arg_spec *arg_spec;
> >> +    unsigned long val;
> >> +    int err, spec_id;
> >> +
> >> +    *res = 0;
> >> +
> >> +    spec_id = __bpf_usdt_spec_id(ctx);
> >> +    if (spec_id < 0)
> >> +            return -ESRCH;
> >> +
> >> +    spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> >> +    if (!spec)
> >> +            return -ESRCH;
> >> +
> >> +    if (arg >= spec->arg_cnt)
> >> +            return -ENOENT;
> >> +
> >> +    arg_spec = &spec->args[arg];
> >> +    switch (arg_spec->arg_type) {
> >> +    case BPF_USDT_ARG_CONST:
> >> +            val = arg_spec->val_off;
> >> +            break;
> >> +    case BPF_USDT_ARG_REG:
> >> +            err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> >> +            if (err)
> >> +                    return err;
> >> +            break;
> >> +    case BPF_USDT_ARG_REG_DEREF:
> >> +            err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> >> +            if (err)
> >> +                    return err;
> >> +            err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
> >> +            if (err)
> >> +                    return err;
>
> Can you elaborate more on these two probe read call ?
>

I can add some comments here for each BPF_USDT_xxx case.

> I replace bpf_probe_read_kernel with bpf_probe_read_user, it also works.
>

You must be running some pretty old kernel on which there is no
bpf_probe_read_{user,kernel} and libbpf "downgrades" them to
bpf_probe_read() which works for both. It needs to be kernel read
because we are reading a field from struct pt_regs, which is in kernel
address space.

> Thanks.
>
> >> +            break;
> >> +    default:
> >> +            return -EINVAL;
> >> +    }
> >> +
> >> +    val <<= arg_spec->arg_bitshift;
> >> +    if (arg_spec->arg_signed)
> >> +            val = ((long)val) >> arg_spec->arg_bitshift;
>
> >> + * BPF_USDT serves the same purpose for USDT handlers as BPF_PROG for
> >> + * tp_btf/fentry/fexit BPF programs and BPF_KPROBE for kprobes.
> >> + * Original struct pt_regs * context is preserved as 'ctx' argument.
> >> + */
> >> +#define BPF_USDT(name, args...)                                                 \
> >> +name(struct pt_regs *ctx);                                              \
> >> +static __attribute__((always_inline)) typeof(name(0))                           \
> >> +____##name(struct pt_regs *ctx, ##args);                                \
> >> +typeof(name(0)) name(struct pt_regs *ctx)                               \
> >> +{                                                                       \
> >> +        _Pragma("GCC diagnostic push")                                          \
> >> +        _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")                  \
> >> +        return ____##name(___bpf_usdt_args(args));                      \
> >> +        _Pragma("GCC diagnostic pop")                                           \
> >> +}                                                                       \
> >> +static __attribute__((always_inline)) typeof(name(0))                           \
> >> +____##name(struct pt_regs *ctx, ##args)
> >> +
> >> +#endif /* __USDT_BPF_H__ */
