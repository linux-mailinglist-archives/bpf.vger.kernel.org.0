Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFED114AE07
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2020 03:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgA1CPs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 21:15:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34557 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgA1CPs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 21:15:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id q13so4483975pls.1
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 18:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:cc:from:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=qmbQ0SD8DHdPpZVGfV+v1K3FzTS4vgL8G+UXqGsRlEM=;
        b=oJYkHQY0Qg9dTZkcxG6jkQGXiG0GH5ZtKl+UrH4KB1GB4Mw3rWF5wj5MLx9pa78QxD
         DMYj3w0MOwW3VuO2O9u5lraOKIO6RbPE3a8ClNKWLDgde+w7IJ0zvx2q+y0f+DYwhv0Q
         +meFECUlEmD+V1igh3dP1bMGVpRH6xKEqP4FRn9giySfJKsQ5CmgrVaOGc3Mtw2ZoMM4
         eGmnxzo917BFntj3SkDta9Dyh7xBaM3qKVL/s2IbZmUX3hXsW8OVtQdb/gi/QMWHbyb8
         ZwtVULSmtrgXyhmYNTeGemhXraoOjOJay1yszOmIo2Dc+vkEld06UMMdIQYktXRgq5bW
         +/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=qmbQ0SD8DHdPpZVGfV+v1K3FzTS4vgL8G+UXqGsRlEM=;
        b=HMVvg8mU//9R89At20rxxLRj/3y/9tcTro6tgHQTgBK/8sR4v+LymC2Ha1OwmKEDdy
         /EXvJMnOqoLvazkVwxYPQ08ZN9XzLEWWa6CGcGtLi9Rz6iq6rmgi91KBCKhfjdcGUArf
         vIJ2pHbRDgmtvaL/W02Jj3THuZPcpjyI91FKNCBYUY+H5OA5NwBZIpUxpZcRJYYlT1He
         B/nKZ5PRoqfZSIRW5FBKZQX0UilJcUjvm0N3zCBREaeyGHa9uzkBfrnhNnhCVj59guIf
         93x3LnIvsCXnYy3OGAoOBwiyR47CLwgrk920dQaIykqMPIaJ9LRfnfY0QhAwxKuNNDQm
         hUEw==
X-Gm-Message-State: APjAAAVWk9EDHMZdmpZYuXP/993hC36d1fduO7yiUPo5jxgCRY1hRdw/
        mpKjMBWCynof7fe6nt6ORWlUag==
X-Google-Smtp-Source: APXvYqxyw1+9nDeY2fJ0PoezS+gA2HUhBTNGtpwFtRWhhrLUPF/Qn0/RVu3ns6X61ABPQl7i3FNfZQ==
X-Received: by 2002:a17:902:b484:: with SMTP id y4mr20197741plr.126.1580177747166;
        Mon, 27 Jan 2020 18:15:47 -0800 (PST)
Received: from localhost ([216.9.110.1])
        by smtp.gmail.com with ESMTPSA id u18sm17430131pgi.44.2020.01.27.18.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 18:15:46 -0800 (PST)
Date:   Mon, 27 Jan 2020 18:15:46 -0800 (PST)
X-Google-Original-Date: Mon, 27 Jan 2020 18:15:44 PST (-0800)
Subject:     Re: [PATCH bpf-next v2 7/9] riscv, bpf: optimize calls
CC:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Bjorn Topel <bjorn.topel@gmail.com>
In-Reply-To: <CAJ+HfNhvTdsBq_tmKNcxVdS=nro=jwL5yLxnyDXO02Vai+5YNg@mail.gmail.com>
References: <CAJ+HfNhvTdsBq_tmKNcxVdS=nro=jwL5yLxnyDXO02Vai+5YNg@mail.gmail.com>
  <20191216091343.23260-1-bjorn.topel@gmail.com> <20191216091343.23260-8-bjorn.topel@gmail.com>
  <mhng-041b1051-f9ac-4cd8-95bf-731bb1bfbdb8@palmerdabbelt-glaptop>
Message-ID: <mhng-a006210f-8a00-42c3-b93d-135144220411@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 07 Jan 2020 02:14:17 PST (-0800), Bjorn Topel wrote:
> On Mon, 23 Dec 2019 at 19:58, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>
>> On Mon, 16 Dec 2019 01:13:41 PST (-0800), Bjorn Topel wrote:
>> > Instead of using emit_imm() and emit_jalr() which can expand to six
>> > instructions, start using jal or auipc+jalr.
>> >
>> > Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>
>> > ---
>> >  arch/riscv/net/bpf_jit_comp.c | 101 +++++++++++++++++++++-------------
>> >  1 file changed, 64 insertions(+), 37 deletions(-)
>> >
>> > diff --git a/arch/riscv/net/bpf_jit_comp.c b/arch/riscv/net/bpf_jit_comp.c
>> > index 46cff093f526..8d7e3343a08c 100644
>> > --- a/arch/riscv/net/bpf_jit_comp.c
>> > +++ b/arch/riscv/net/bpf_jit_comp.c
>> > @@ -811,11 +811,12 @@ static void emit_sext_32_rd(u8 *rd, struct rv_jit_context *ctx)
>> >       *rd = RV_REG_T2;
>> >  }
>> >
>> > -static void emit_jump_and_link(u8 rd, int rvoff, struct rv_jit_context *ctx)
>> > +static void emit_jump_and_link(u8 rd, s64 rvoff, bool force_jalr,
>> > +                            struct rv_jit_context *ctx)
>> >  {
>> >       s64 upper, lower;
>> >
>> > -     if (is_21b_int(rvoff)) {
>> > +     if (rvoff && is_21b_int(rvoff) && !force_jalr) {
>> >               emit(rv_jal(rd, rvoff >> 1), ctx);
>> >               return;
>> >       }
>> > @@ -832,6 +833,28 @@ static bool is_signed_bpf_cond(u8 cond)
>> >               cond == BPF_JSGE || cond == BPF_JSLE;
>> >  }
>> >
>> > +static int emit_call(bool fixed, u64 addr, struct rv_jit_context *ctx)
>> > +{
>> > +     s64 off = 0;
>> > +     u64 ip;
>> > +     u8 rd;
>> > +
>> > +     if (addr && ctx->insns) {
>> > +             ip = (u64)(long)(ctx->insns + ctx->ninsns);
>> > +             off = addr - ip;
>> > +             if (!is_32b_int(off)) {
>> > +                     pr_err("bpf-jit: target call addr %pK is out of range\n",
>> > +                            (void *)addr);
>> > +                     return -ERANGE;
>> > +             }
>> > +     }
>> > +
>> > +     emit_jump_and_link(RV_REG_RA, off, !fixed, ctx);
>> > +     rd = bpf_to_rv_reg(BPF_REG_0, ctx);
>> > +     emit(rv_addi(rd, RV_REG_A0, 0), ctx);
>>
>> Why are they out of order?  It seems like it'd be better to just have the BPF
>> calling convention match the RISC-V calling convention, as that'd avoid
>> juggling the registers around.
>>
>
> BPF passes arguments in R1, R2, ..., and return value in R0. Given
> that a0 plays the role of R1 and R0, how can we avoid the register
> juggling (without complicating the JIT too much)? It would be nice
> though... and ARM64 has the same concern AFAIK.

Oh, why did you say that?  This kind of stuff is why I'm twenty days behind on
email...

https://lore.kernel.org/bpf/20200128021145.36774-1-palmerdabbelt@google.com/T/#t

:)

> [...]
>> > @@ -1599,36 +1611,51 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>> >       for (i = 0; i < 16; i++) {
>> >               pass++;
>> >               ctx->ninsns = 0;
>> > -             if (build_body(ctx, extra_pass)) {
>> > +             if (build_body(ctx, extra_pass, ctx->offset)) {
>> >                       prog = orig_prog;
>> >                       goto out_offset;
>> >               }
>> >               build_prologue(ctx);
>> >               ctx->epilogue_offset = ctx->ninsns;
>> >               build_epilogue(ctx);
>> > -             if (ctx->ninsns == prev_ninsns)
>> > -                     break;
>> > +
>> > +             if (ctx->ninsns == prev_ninsns) {
>> > +                     if (jit_data->header)
>> > +                             break;
>> > +
>> > +                     image_size = sizeof(u32) * ctx->ninsns;
>> > +                     jit_data->header =
>> > +                             bpf_jit_binary_alloc(image_size,
>> > +                                                  &jit_data->image,
>> > +                                                  sizeof(u32),
>> > +                                                  bpf_fill_ill_insns);
>> > +                     if (!jit_data->header) {
>> > +                             prog = orig_prog;
>> > +                             goto out_offset;
>> > +                     }
>> > +
>> > +                     ctx->insns = (u32 *)jit_data->image;
>> > +                     /* Now, when the image is allocated, the image
>> > +                      * can potentially shrink more (auipc/jalr ->
>> > +                      * jal).
>> > +                      */
>> > +             }
>>
>> It seems like these fragments should go along with patch #2 that introduces the
>> code, as I don't see anything above that makes this necessary here.
>>
>
> No, you're right.
>
>
> Björn
