Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA713120B0
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 02:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBGBM3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 20:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhBGBM2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 20:12:28 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB36C06178B
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 17:11:40 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id m17so802228ioy.4
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 17:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eDywPtQ9z5anwNWiV+B3uY068Ow5G+xsxVns8UWZrs=;
        b=hBXvgzrDJJv1IdPjD/mkuoIAswnBPccXXWKsj7iM5oDAcxsMFMua6JF2m/oLFF0maF
         yfhAXuXcTBQo432kkQDzbhromuxanCdcCs6k5a9NRaE3ebXFz5ymDnun7vMeRoVobn6y
         Jef7IF6L6oHPhlvhnyZA2VcMYLxRpopNBWclTJ5v77pEiz4cW9Y11AbiUvIznVAhBwjq
         Nmuz0Eaqai6nWq1XxZzkJWxaNtFVMT72t6k7SOR6Yhe45EhoBKtXMNXVJi2TOI8erQVa
         TweDCCQDwdBp7uDXP13B1qVXH4M8yIICypdjzYnBf8VLEWY+y1yaLvOpPvcFn2RgHu7M
         zVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eDywPtQ9z5anwNWiV+B3uY068Ow5G+xsxVns8UWZrs=;
        b=AtQV0e3YIw+GA+prjeQg+8NcFmj1Kw12wuKpIbGEH72UkufYF4Y+Z9MWQLsoUugxab
         tpdgGIznPVkM74sc3Q+KBU97cSr2OfqaHGNej3FZQffnxrC5oxcnpyneFUxnAa15vYh7
         FLLa9yMColJKAa8Ap6CRRGOI5DVFvakfVuFVy/m7Vo8E5a0ES2Ex6hCgpaRpfXNWQKUR
         StpE5QX2ocCCk3pf5yEjbeLZ9NQ7OHHN1+q6GOZmMMBnVr1fXI47ZU/lx9o4TE2kZfz5
         qUGNOa7WCeNM6iNO1xtfxce4iYdtGnMHWHAQ1ZQjJ87G1byDOXKy/XxrjxwPGmSR+Kc5
         NWbQ==
X-Gm-Message-State: AOAM531PEoJz9IgNF2S7wXeaye0uPJ7ymtWsJsg/GbeTaUYGd1kGuPsN
        ozilYiwa8QEmD8Klov3+C6XMEwrpxv8uN4zsE3zGf8pn1SXfUA==
X-Google-Smtp-Source: ABdhPJxkR4qCClciGtiuImAjy8rm8VOfAx6lHQCfzUcxzcVMj1XOqoWZOuBQ2VI+kizjYtABL4X9YwGOkxugitqdd6A=
X-Received: by 2002:a6b:5801:: with SMTP id m1mr10420630iob.140.1612660299744;
 Sat, 06 Feb 2021 17:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20210124194909.453844-1-andreimatei1@gmail.com>
 <20210124194909.453844-2-andreimatei1@gmail.com> <20210127225818.3uzw3tehbu3qlyd6@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210127225818.3uzw3tehbu3qlyd6@ast-mbp.dhcp.thefacebook.com>
From:   Andrei Matei <andreimatei1@gmail.com>
Date:   Sat, 6 Feb 2021 20:11:28 -0500
Message-ID: <CABWLseue7vA6P61oGS9i7b6F8AT_MkYZwdxhR4Z+2cok+7J33Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: allow variable-offset stack access
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > +/* Check that the stack access at 'regno + off' falls within the maximum stack
> > + * bounds.
> > + *
> > + * 'off' includes `regno->offset`, but not its dynamic part (if any).
> > + */
> > +static int check_stack_access_within_bounds(
> > +             struct bpf_verifier_env *env,
> > +             int regno, int off, int access_size,
> > +             enum stack_access_src src, enum bpf_access_type type)
> > +{
> > +     struct bpf_reg_state *regs = cur_regs(env);
> > +     struct bpf_reg_state *reg = regs + regno;
> > +     struct bpf_func_state *state = func(env, reg);
> > +     int min_off, max_off;
> > +     int err;
> > +     char *err_extra;
> > +
> > +     if (src == ACCESS_HELPER)
>
> the ACCESS_HELPER|DIRECT enum should probably be moved right before this function.
> It's not used earlier, I think, and it made the reviewing a bit harder than could have been.

It is, unfortunately. ACCESS_DIRECT is used close to where it is
defined, in check_stack_read_var_off().

>
> > +             /* We don't know if helpers are reading or writing (or both). */
> > +             err_extra = " indirect access to";
> > +     else if (type == BPF_READ)
> > +             err_extra = " read from";
> > +     else
> > +             err_extra = " write to";
>
> Thanks for improving verifier errors.
>
> > +
> > +     if (tnum_is_const(reg->var_off)) {
> > +             min_off = reg->var_off.value + off;
> > +             if (access_size > 0)
> > +                     max_off = min_off + access_size - 1;
> > +             else
> > +                     max_off = min_off;
> > +     } else {
> > +             if (reg->smax_value >= BPF_MAX_VAR_OFF ||
> > +                 reg->smax_value <= -BPF_MAX_VAR_OFF) {
>
> hmm. are you sure about smax in both conditions? looks like typo?

This is how it used to be before this patch btw, but I think you're
right. It looks like the second one should have been smin_value.
Fixing here.
Existing code: https://github.com/torvalds/linux/blob/1e0d27fce010b0a4a9e595506b6ede75934c31be/kernel/bpf/verifier.c#L3721

>
> > +                     verbose(env, "invalid unbounded variable-offset%s stack R%d\n",
> > +                             err_extra, regno);
> > +                     return -EACCES;
> > +             }
> > +             min_off = reg->smin_value + off;
> > +             if (access_size > 0)
> > +                     max_off = reg->smax_value + off + access_size - 1;
> > +             else
> > +                     max_off = min_off;
> > +     }
>
> The rest looks good.
