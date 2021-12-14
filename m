Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E8D4742E3
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 13:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhLNMq5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 07:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234109AbhLNMqx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Dec 2021 07:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639486013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zP9WPv2zcgiB2fBLCStTdij7J/n3WqYBCTnC2D/9kSY=;
        b=QUG8vUrgXTMJuZzX39xjyYt9g7HH5+wGVc2UR0Id6c1GwxwIOHqwfLDsmRYdoMiV3Q4IgD
        eaQo2h6sevSMu4CZMdVc3Dw1GazB7terq6PsshejZf4AeYfW8WfTYbY+j4EJUjaVZKt6bk
        FM2Nz1Pp2uIJ4XYmBG5pM5Y4FzYhA8I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-HbLjhru3Ouy-r18I9SOjXw-1; Tue, 14 Dec 2021 07:46:52 -0500
X-MC-Unique: HbLjhru3Ouy-r18I9SOjXw-1
Received: by mail-wm1-f70.google.com with SMTP id l34-20020a05600c1d2200b00344d34754e4so420399wms.7
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 04:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zP9WPv2zcgiB2fBLCStTdij7J/n3WqYBCTnC2D/9kSY=;
        b=hpWjiF5yqmybbcVsRXqopr4T3Bv7Yt2oDTlq277FwF8zzuU3T/Pd5Et7KGGCzictBR
         p4FXHFD74f9JoYgho5gxQb/ha6XB1NUY0iZAlyGH/sGXQUnaixcAs2mW8na35JocHUTo
         khLBBLVMZkhDUI4aaOHjvxeP3ZY5Gw/CWhOtxSBJwWahk9Vvb9m+60c/pQSkXL4ZABew
         3RlNU4phZT1saiizgrfzHvtfc6eAsVl+COA8VafxLbIVhz77GrSbuxzrNY+QTwpbgrDs
         3LgSHs6IzjA0VRuYKbA7r2HJ1JATlOcJFU57dYnl8S/3OZjhU13hM1bdidG/SXKfBsO6
         fQCA==
X-Gm-Message-State: AOAM530qE1T9Z0ug7U6zuaCzLWNx+3eEbkiRes1ZQMBp8TqLQs95jxrS
        ng3katouGsGo7YhezlNerOCPOtL2sQD5VoRGxdfjDBIpegDuLstJ0iZfaV4D5UellxFx5eqFkmB
        J4KBemq0kE4T5+h4aNR+PJgcyWvBL
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr5785303wrw.36.1639486010712;
        Tue, 14 Dec 2021 04:46:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaNSOpTDyWfDloewyBzmx6JhH6oQqw90E95q9szrMniUzK7GxZjXpZHsjG6G3/CrFj2H30WaQOTuL5VRrJ/Hs=
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr5785279wrw.36.1639486010447;
 Tue, 14 Dec 2021 04:46:50 -0800 (PST)
MIME-Version: 1.0
References: <xunylf0o872l.fsf@redhat.com> <1639483040.nhfgn2cmvh.naveen@linux.ibm.com>
In-Reply-To: <1639483040.nhfgn2cmvh.naveen@linux.ibm.com>
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Tue, 14 Dec 2021 14:46:34 +0200
Message-ID: <CANoWswkVLUDzwivbkiJ28LKo8F2YZJ4sRR=76NNcYwpdncquwA@mail.gmail.com>
Subject: Re: PPC jit and pseudo_btf_id
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

On Tue, Dec 14, 2021 at 2:11 PM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> Hi Yauheni,
>
>
> Yauheni Kaliuta wrote:
> > Hi!
> >
> > I get kernel oops on my setup due to unresolved pseudo_btf_id for
> > ld_imm64 (see 4976b718c355 ("bpf: Introduce pseudo_btf_id")) for
> > example for `test_progs -t for_each/hash_map` where callback
> > address is passed to a bpf helper:
> >
> >
> > [  425.853991] kernel tried to execute user page (100000014) - exploit attempt? (uid: 0)
> > [  425.854173] BUG: Unable to handle kernel instruction fetch
> > [  425.854255] Faulting instruction address: 0x100000014

[...]

>
> Thanks for the problem report. I noticed this recently and have prepared
> a fix as part of a larger patchset.
>

Ah, cool! That was  actually my main question, do I miss the fix somewhere :)

> >
> > The simple patch fixes it for me:
> >
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index 90ce75f0f1e2..554c26480387 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > @@ -201,8 +201,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> >                */
> >               bpf_jit_fixup_subprog_calls(fp, code_base, &cgctx, addrs);
> >
> > -             /* There is no need to perform the usual passes. */
> > -             goto skip_codegen_passes;
> > +             /* Due to pseudo_btf_id resolving, regenerate */
> >       }
> >
> >       /* Code generation passes 1-2 */
> > @@ -222,7 +221,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> >                               proglen - (cgctx.idx * 4), cgctx.seen);
> >       }
> >
> > -skip_codegen_passes:
> >       if (bpf_jit_enable > 1)
> >               /*
> >                * Note that we output the base address of the code_base
> >
> >
> >
> > Do I miss something?
>
> The problem with the above approach is that we generate variable number
> of instructions for certain BPF instructions and so, unless we reserve
> space for maximum number of powerpc instructions beforehand, we risk
> writing past the end of the allocated buffer.

Yes, agree.

> Can you please check if the below patch fixes the issue for you?

It does, thanks!

I was actually thinking later about something similar and I wonder
about naming. Should the function be renamed to more generic, and is
it really for func_addr only or can be any generic value?

>
>
> Thanks,
> Naveen
>
>
> ---
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 463f99ecaa459e..e16d421ce22a65 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -66,7 +66,15 @@ static int bpf_jit_fixup_subprog_calls(struct bpf_prog *fp, u32 *image,
>                          * of the JITed sequence remains unchanged.
>                          */
>                         ctx->idx = tmp_idx;
> +               } else if (insn[i].code == (BPF_LD | BPF_IMM | BPF_DW)) {
> +                       func_addr = ((u64)(u32) insn[i].imm) | (((u64)(u32) insn[i+1].imm) << 32);
> +                       tmp_idx = ctx->idx;
> +                       ctx->idx = addrs[i] / 4;
> +                       PPC_LI64(b2p[insn[i].dst_reg], func_addr);
> +                       ctx->idx = tmp_idx;
> +                       i++;
>                 }
> +
>         }
>
>         return 0;
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 74b465cc7a84d0..4d3973cd78b46f 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -324,6 +324,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>                 u64 imm64;
>                 u32 true_cond;
>                 u32 tmp_idx;
> +               int j;
>
>                 /*
>                  * addrs[] maps a BPF bytecode address into a real offset from
> @@ -858,7 +859,11 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>                                     (((u64)(u32) insn[i+1].imm) << 32);
>                         /* Adjust for two bpf instructions */
>                         addrs[++i] = ctx->idx * 4;
> +                       tmp_idx = ctx->idx;
>                         PPC_LI64(dst_reg, imm64);
> +                       /* padding to allow full 5 instructions for later patching */
> +                       for (j = ctx->idx - tmp_idx; j < 5; j++)
> +                               EMIT(PPC_RAW_NOP());
>                         break;
>
>                 /*
>


-- 
WBR, Yauheni

