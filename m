Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7296269B23B
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 19:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBQSP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 13:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQSP3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 13:15:29 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD6E2D4C
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 10:15:28 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536583d96a7so19650487b3.4
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 10:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Q+r0Hf6i7T61NM/VM6TeZhnahQ9bcgKOBs5zvPjXz4=;
        b=XSeOAvwu2Dq8Z9wQAmKad0cZ9jMVSms/x03CYJA41VJL27N616gBnh8VvMeheV30SW
         qSqwf99tqSzEYEHDvlbu+YecIAx6R6uSV85+gbDarSkFxBwi/tFdY+qaP4bt+5DaCClj
         RISFx9w03rJhuo0pry0lrD5BVAoCOY39ZdWCmBW8Vwna+Z866WGBEXHLRD2UtyEKqANH
         xKzeZJ75ufIMnxA+tQd2Y/DZhU1483ezYXCEbNCcYqcXC0w9gihoecbJ9z1/VPJJsEWG
         o6wna01ijW8ViVJc3DEwP9vABPfnuS0O1piC5xHl/+jSrNWI4jCG+tMHiaWvX6Tf8sa8
         zT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Q+r0Hf6i7T61NM/VM6TeZhnahQ9bcgKOBs5zvPjXz4=;
        b=b5mCkeQNqVXWb+OexudjLW/190nlSf4nQ7I4ZbKK/Zt/ItOc1Hb32NKzkcKuSJlNf8
         hKUOeLndxexUNDiXi0INKEAQT61dqDCxKMlzu/8KkmG4h6bq/02IbHkH5rdJJ1uSx5rz
         INuITNDCFrMd4b6W+NaRZvwZV/2eV6tbsGNit+SDgaVpUcJWtZ4CGxL+xPc1xI41qvDf
         72aCLKleGab++lkUQcb73bn9h5n2Y4wQr2qCAVdqHAu9ZHi5vM5HVHNxe1edAc0RXata
         iXNOUPgpNNM75vT3NhhA/AV20LBDGDt5IQYEW7tQOF2Um9OZxgQl8v0kwVq/LDiqR4gx
         JiYA==
X-Gm-Message-State: AO0yUKXaPvcdyeoAXKFzP12FKFxOtcHwyiLxcgA6k7ZFo1pnrQYt5Dis
        GSWglXhbZ3YcMlHALvc1AaL7g6p9pt2z3T8aAyM=
X-Google-Smtp-Source: AK7set+elZ4QCVja+8zX5PybvX82KM/YAVFRweOE0EpWBtZkgrCpEU92EpkbvUSstGoMwGMkGlxk116cCuUCB8KBgTw=
X-Received: by 2002:a81:af09:0:b0:52f:3399:ed08 with SMTP id
 n9-20020a81af09000000b0052f3399ed08mr195927ywh.6.1676657727544; Fri, 17 Feb
 2023 10:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20230217005451.2438147-1-joannelkoong@gmail.com> <Y+9Ddvey0iPgC8ZS@krava>
In-Reply-To: <Y+9Ddvey0iPgC8ZS@krava>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 17 Feb 2023 10:15:16 -0800
Message-ID: <CAJnrk1a_2-L3Ldr+GaHdzE6bQ2EFSxDyxKSh95mc9vmrMajWAQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next] bpf: Tidy up verifier checking
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Fri, Feb 17, 2023 at 1:06 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Feb 16, 2023 at 04:54:51PM -0800, Joanne Koong wrote:
> > This change refactors check_mem_access() to check against the base type of
> > the register, and uses switch case checking instead of if / else if
> > checks. This change also uses the existing clear_called_saved_regs()
> > function for resetting caller saved regs in check_helper_call().
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 67 +++++++++++++++++++++++++++++--------------
> >  1 file changed, 46 insertions(+), 21 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 272563a0b770..b40165be2943 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5317,7 +5317,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >       /* for access checks, reg->off is just part of off */
> >       off += reg->off;
> >
> > -     if (reg->type == PTR_TO_MAP_KEY) {
> > +     switch (base_type(reg->type)) {
> > +     case PTR_TO_MAP_KEY:
> >               if (t == BPF_WRITE) {
> >                       verbose(env, "write to change key R%d not allowed\n", regno);
> >                       return -EACCES;
> > @@ -5329,7 +5330,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >                       return err;
> >               if (value_regno >= 0)
> >                       mark_reg_unknown(env, regs, value_regno);
> > -     } else if (reg->type == PTR_TO_MAP_VALUE) {
> > +
> > +             break;
> > +     case PTR_TO_MAP_VALUE:
> > +     {
>
> I'm getting failure in this test:
>   #92/1    jeq_infer_not_null/jeq_infer_not_null_ptr_to_btfid:FAIL
>
> I wonder with this change we execute this case even if there's PTR_MAYBE_NULL set,
> which we did not do before, so the test won't fail now as expected

Thanks for reviewing this, I will investigate this test failure!

>
> >               struct btf_field *kptr_field = NULL;
> >
> >               if (t == BPF_WRITE && value_regno >= 0 &&
> > @@ -5369,7 +5373,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >                               mark_reg_unknown(env, regs, value_regno);
> >                       }
> >               }
> > -     } else if (base_type(reg->type) == PTR_TO_MEM) {
> > +             break;
> > +     }
>
> SNIP
>
> > @@ -5521,7 +5539,17 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >
> >               if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
> >                       mark_reg_unknown(env, regs, value_regno);
> > -     } else {
> > +             break;
> > +     }
> > +     case PTR_TO_BTF_ID:
> > +             if (!type_may_be_null(reg->type)) {
> > +                     err = check_ptr_to_btf_access(env, regs, regno, off, size, t,
> > +                                                   value_regno);
> > +                     break;
> > +             } else {
> > +                     fallthrough;
> > +             }
>
> nit, no need for the else branch, just use fallthrough directly
>
> > +     default:
> >               verbose(env, "R%d invalid mem access '%s'\n", regno,
> >                       reg_type_str(env, reg->type));
> >               return -EACCES;
> > @@ -8377,10 +8405,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >               return err;
> >
> >       /* reset caller saved regs */
>
> nit, we could remove the comment as well, the function name says it all
>
> jirka
>
> > -     for (i = 0; i < CALLER_SAVED_REGS; i++) {
> > -             mark_reg_not_init(env, regs, caller_saved[i]);
> > -             check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> > -     }
> > +     clear_caller_saved_regs(env, regs);
> >
> >       /* helper call returns 64-bit value. */
> >       regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
> > --
> > 2.30.2
> >
