Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE7C67D508
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 20:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjAZTED (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 14:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjAZTED (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 14:04:03 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7205591
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 11:03:58 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qx13so7626276ejb.13
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 11:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2SMtICM3MYf5efuZavkG7+VhEOkjk3zJlaqkGQRwmg=;
        b=UHdCrIeaboiaQgDN75wlOYCiAlnRIE6tbrhEE5d4HcX+oAgf92+9xWUyLAvd1vF88Z
         XmsYYdz4DDODbHkRaZoTkR2/025OWhjJJG93TZs7AjhRcTaB+QHM5PHqp3t0MZwKUlGx
         solERW9bJiWqaXepvwQL5MQr/OSLwiy5QgKiSDRq1PsrqcabVT5nW/CxbFZQq1unEYMs
         HpeM4WqAIs0imz050BCvM3geXMytT5ZMBTTFgNYFJXcv3V7VMiFTtUPlrY1thq48acev
         P4FGyS14EMRNOZDj0O5FtEp+krMmi88b52OTHP82g88aCjsuQA1WIe28ftaUhDelXsLQ
         7s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2SMtICM3MYf5efuZavkG7+VhEOkjk3zJlaqkGQRwmg=;
        b=eg8vWxsPTNgN/68QmryUxM97Q04H18ZJQ5t6thHLGW1OQaaJqWFSbzBAwzbSCNA1kL
         GYCvCOaexNOyqMVfEdNoQUljdIYSfpEPrcY2Qcapv12ESHekrqahgXH9XlPj1+AfGTj2
         1WeVAg3YzFeNcTMsuSjZJjzNaa0CJr1ANi5NjLRKzGZ4U49Q6DkfoZdy2T9Kt/f1NMU8
         RpWwdxoC/d7OLXO3D2SG3xlLiM+wjGZbzuazVogWIULNdjVs16bRASmXArLWC3cAHo2G
         TTNtj/YVFSBkwKUtpKdurLu9oULMAkHjqnPbPpbYwapHgyiFIrr2bjwgSQXEKP5R6H9A
         5n2g==
X-Gm-Message-State: AO0yUKVvzCGMasMSm4Bv0Vyru9TLiTYFBZ4EiPM3i82OTvzSXXoGqnqW
        DEGnGu/R87JtSderBvfIMSRzhkObt4CH4IQ5nec=
X-Google-Smtp-Source: AK7set+mun7ZpQ5cVVIc10Yu9SF52xwpEvnAfI4v2aAcpz5QkF0u0RvQIw6QT24cG1iOxZ+Q4irJdg0UYnoGi41K+DY=
X-Received: by 2002:a17:906:ad3:b0:878:6f08:39ec with SMTP id
 z19-20020a1709060ad300b008786f0839ecmr704977ejf.233.1674759836676; Thu, 26
 Jan 2023 11:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20230125213817.1424447-1-iii@linux.ibm.com> <20230125213817.1424447-18-iii@linux.ibm.com>
 <CAEf4BzamdUMpNeryWa2gGP6KB8uTs5sZTNnU3kMkvJFdchNRiw@mail.gmail.com> <cd145e29fc2cf9c4772fd61eb2921b2784d983fd.camel@linux.ibm.com>
In-Reply-To: <cd145e29fc2cf9c4772fd61eb2921b2784d983fd.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 26 Jan 2023 11:03:44 -0800
Message-ID: <CAEf4BzYcGSnmXVr52KcqtJrid6moyFqSL0R86S6LTiuvnQK9_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 17/24] libbpf: Read usdt arg spec with bpf_probe_read_kernel()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
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

On Thu, Jan 26, 2023 at 3:41 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2023-01-25 at 16:26 -0800, Andrii Nakryiko wrote:
> > On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > Loading programs that use bpf_usdt_arg() on s390x fails with:
> > >
> > >     ; switch (arg_spec->arg_type) {
> > >     139: (61) r1 = *(u32 *)(r2 +8)
> > >     R2 unbounded memory access, make sure to bounds check any such
> > > access
> >
> > can you show a bit longer log? we shouldn't just  use
> > bpf_probe_read_kernel for this. I suspect strategically placed
> > barrier_var() calls will solve this. This is usually an issue with
> > compiler reordering operations and doing actual check after it
> > already
> > speculatively adjusted pointer (which is technically safe and ok if
> > we
> > never deref that pointer, but verifier doesn't recognize such
> > pattern)
>
> The full log is here:
>
> https://gist.github.com/iii-i/b6149ee99b37078ec920ab1d3bb45134
>
> The relevant part seems to be:
>
> ; if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec->arg_cnt)
> 128: (79) r1 = *(u64 *)(r10 -24)      ; frame1:
> R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
> 129: (25) if r1 > 0xb goto pc+83      ; frame1:
> R1_w=scalar(umax=11,var_off=(0x0; 0xf))
> ; if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec->arg_cnt)
> 130: (69) r1 = *(u16 *)(r8 +200)      ; frame1:
> R1_w=scalar(umax=65535,var_off=(0x0; 0xffff))
> R8_w=map_value(off=0,ks=4,vs=208,imm=0)
> 131: (67) r1 <<= 48                   ; frame1:
> R1_w=scalar(smax=9223090561878065152,umax=18446462598732840960,var_off=
> (0x0; 0xffff000000000000),s32_min=0,s32_max=0,u32_max=0)
> 132: (c7) r1 s>>= 48                  ; frame1: R1_w=scalar(smin=-
> 32768,smax=32767)
> ; if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec->arg_cnt)
> 133: (79) r2 = *(u64 *)(r10 -24)      ; frame1:
> R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
> 134: (bd) if r1 <= r2 goto pc+78      ; frame1: R1=scalar(smin=-
> 32768,smax=32767) R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> ; arg_spec = &spec->args[arg_num];
> 135: (79) r1 = *(u64 *)(r10 -24)      ; frame1:
> R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
> 136: (67) r1 <<= 4                    ; frame1:
> R1_w=scalar(umax=68719476720,var_off=(0x0;
> 0xffffffff0),s32_max=2147483632,u32_max=-16)
> 137: (bf) r2 = r8                     ; frame1:
> R2_w=map_value(off=0,ks=4,vs=208,imm=0)
> R8=map_value(off=0,ks=4,vs=208,imm=0)
> 138: (0f) r2 += r1                    ; frame1:
> R1_w=scalar(umax=68719476720,var_off=(0x0;
> 0xffffffff0),s32_max=2147483632,u32_max=-16)
> R2_w=map_value(off=0,ks=4,vs=208,umax=68719476720,var_off=(0x0;
> 0xffffffff0),s32_max=2147483632,u32_max=-16)
> ; switch (arg_spec->arg_type) {
> 139: (61) r1 = *(u32 *)(r2 +8)
>
> #128-#129 make sure that *(u64 *)(r10 -24) <= 11, but when #133
> loads it again, this constraint is not there. I guess we need to
> force flushing r1 to stack? The following helps:
>
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -130,7 +130,10 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64
> arg_num, long *res)
>         if (!spec)
>                 return -ESRCH;
>
> -       if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec-
> >arg_cnt)
> +       if (arg_num >= BPF_USDT_MAX_ARG_CNT)
> +               return -ENOENT;
> +       barrier_var(arg_num);
> +       if (arg_num >= spec->arg_cnt)
>                 return -ENOENT;
>
>         arg_spec = &spec->args[arg_num];
>
> I can use this in v2 if it looks good.

arg_num -> spec->arg_cnt is "real" check, arg_num >=
BPF_USDT_MAX_ARG_CNT is more to satisfy verifier (we know that
spec->arg_cnt won't be >= BPF_USDT_MAX_ARG_CNT). Let's swap two checks
in order and keep BPF_USDT_MAX_ARG_CNT close to spec->args[arg_num]
use? And if barrier_var() is necessary, then so be it.

>
>
>
> Btw, I looked at the barrier_var() definition:
>
> #define barrier_var(var) asm volatile("" : "=r"(var) : "0"(var))
>
> and I'm curious why it's not defined like this:
>
> #define barrier_var(var) asm volatile("" : "+r"(var))
>
> which is a bit simpler?
> >

no reason, just unfamiliarity with embedded asm back then, we can
update it we they are equivalent
