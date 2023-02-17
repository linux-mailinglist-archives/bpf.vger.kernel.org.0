Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A389569B458
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 22:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBQVGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 16:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBQVGb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 16:06:31 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31F05DE38
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 13:06:29 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id q9so2191129ybu.11
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 13:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PXi1BeBDBpANK7kqzMXZZEun61YLLhzkxWec/5pVmWM=;
        b=a5n8T94H0486WroXEDN2F/Ntl9WFTJjhzJCmMLo970ZmJmj/DI5/V/f7zB0KfI3KV5
         nNPDhNBhJ7LZZPwkfgIrTdgS8JcQJ3QZ8Hgn/3KIhA2LRxO7WJ88EQw/PdqEtLipHlJ4
         IbyWrZ1F23smDeS/eWMVVXFxI64Yil7lzTeoSxV6rx2QxHgn/5SfVvhESidNZN434UEn
         ArD6to7pzWV9bDSKrfVYwLNjvv1hNNtlpcWdDHMyVP2NNG1ePINhcIVElKB5w49XdY9H
         1+IH17fEtCl7boivjnmZLiu/Cqt8hTJz2dmsaVBBhbG9vumknglAvYcjpaphbWZzORIk
         sMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXi1BeBDBpANK7kqzMXZZEun61YLLhzkxWec/5pVmWM=;
        b=Gcu2cPs/hCibuZtdc0oubVTT0M9VQUW5v5cgLUydoJH/w1zhgojCHFTRCMwyAGXL2s
         pTHjM7snDbYGrjLa0ZFl4UOs0mUgP5zyY5GzpJ/netIegn/KbssJ+/shjQndW3YZ/PnY
         pIRNODtgpRv+jY3O5PKX2ccXHzCwVdGBQkZn1xqbB/CBPtpEDO6fJYQfzVA8spN/lUj6
         mfQXBtTjI9TiS6qgxoGnxbubiaJnjP4jN1DkZ/vIw3eXVt+Zdjiwh5EZZfWxC+Lfj0JL
         MWEawn9Sjo+foLKMNs5D06dIWrQJzr6P2Ue5fgNE3BGKIZdtbN70l5FzUUacF5ePFu2b
         C8Ag==
X-Gm-Message-State: AO0yUKXlTLjTKe7mu7IZorMIR+djm4655Wjn+ex0KlIyjUU6atjbR+1g
        zx1e7MDA5IGejbGEOooTUZ5B1yMJ1oaDYakWXhBMqEc8Kwo=
X-Google-Smtp-Source: AK7set9DyLfTik7DqoSxDOJPgxiQ2kbvIIoR2gWTC3MNOaFkk9kE7CTaapzA6W3lT4dfxax/fb1WAgZYPLsu566synw=
X-Received: by 2002:a5b:cc6:0:b0:90d:f673:2657 with SMTP id
 e6-20020a5b0cc6000000b0090df6732657mr1336364ybr.500.1676667988815; Fri, 17
 Feb 2023 13:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20230217005451.2438147-1-joannelkoong@gmail.com>
 <Y+9Ddvey0iPgC8ZS@krava> <CAJnrk1a_2-L3Ldr+GaHdzE6bQ2EFSxDyxKSh95mc9vmrMajWAQ@mail.gmail.com>
In-Reply-To: <CAJnrk1a_2-L3Ldr+GaHdzE6bQ2EFSxDyxKSh95mc9vmrMajWAQ@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 17 Feb 2023 13:06:17 -0800
Message-ID: <CAJnrk1YvDoajRBcSC-tzsW4bOWkjdbzuajGUidtcsDyborUEsA@mail.gmail.com>
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

On Fri, Feb 17, 2023 at 10:15 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Fri, Feb 17, 2023 at 1:06 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Feb 16, 2023 at 04:54:51PM -0800, Joanne Koong wrote:
> > > This change refactors check_mem_access() to check against the base type of
> > > the register, and uses switch case checking instead of if / else if
> > > checks. This change also uses the existing clear_called_saved_regs()
> > > function for resetting caller saved regs in check_helper_call().
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 67 +++++++++++++++++++++++++++++--------------
> > >  1 file changed, 46 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 272563a0b770..b40165be2943 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -5317,7 +5317,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> > >       /* for access checks, reg->off is just part of off */
> > >       off += reg->off;
> > >
> > > -     if (reg->type == PTR_TO_MAP_KEY) {
> > > +     switch (base_type(reg->type)) {
> > > +     case PTR_TO_MAP_KEY:
> > >               if (t == BPF_WRITE) {
> > >                       verbose(env, "write to change key R%d not allowed\n", regno);
> > >                       return -EACCES;
> > > @@ -5329,7 +5330,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> > >                       return err;
> > >               if (value_regno >= 0)
> > >                       mark_reg_unknown(env, regs, value_regno);
> > > -     } else if (reg->type == PTR_TO_MAP_VALUE) {
> > > +
> > > +             break;
> > > +     case PTR_TO_MAP_VALUE:
> > > +     {
> >
> > I'm getting failure in this test:
> >   #92/1    jeq_infer_not_null/jeq_infer_not_null_ptr_to_btfid:FAIL
> >
> > I wonder with this change we execute this case even if there's PTR_MAYBE_NULL set,
> > which we did not do before, so the test won't fail now as expected
>
> Thanks for reviewing this, I will investigate this test failure!

I'm going to abandon this patch, on a closer look I don't think it's
accurate. For most of these matches, it needs to be a strict match (eg
reg->type should be exactly PTR_TO_MAP_KEY) and any type modifiers
should fail (eg PTR_MAYBE_NULL)

>
> >
> > >               struct btf_field *kptr_field = NULL;
> > >
> > >               if (t == BPF_WRITE && value_regno >= 0 &&
> > > @@ -5369,7 +5373,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> > >                               mark_reg_unknown(env, regs, value_regno);
> > >                       }
> > >               }
> > > -     } else if (base_type(reg->type) == PTR_TO_MEM) {
> > > +             break;
> > > +     }
> >
> > SNIP
> >
> > > @@ -5521,7 +5539,17 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> > >
> > >               if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
> > >                       mark_reg_unknown(env, regs, value_regno);
> > > -     } else {
> > > +             break;
> > > +     }
> > > +     case PTR_TO_BTF_ID:
> > > +             if (!type_may_be_null(reg->type)) {
> > > +                     err = check_ptr_to_btf_access(env, regs, regno, off, size, t,
> > > +                                                   value_regno);
> > > +                     break;
> > > +             } else {
> > > +                     fallthrough;
> > > +             }
> >
> > nit, no need for the else branch, just use fallthrough directly
> >
> > > +     default:
> > >               verbose(env, "R%d invalid mem access '%s'\n", regno,
> > >                       reg_type_str(env, reg->type));
> > >               return -EACCES;
> > > @@ -8377,10 +8405,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > >               return err;
> > >
> > >       /* reset caller saved regs */
> >
> > nit, we could remove the comment as well, the function name says it all
> >
> > jirka
> >
> > > -     for (i = 0; i < CALLER_SAVED_REGS; i++) {
> > > -             mark_reg_not_init(env, regs, caller_saved[i]);
> > > -             check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> > > -     }
> > > +     clear_caller_saved_regs(env, regs);
> > >
> > >       /* helper call returns 64-bit value. */
> > >       regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
> > > --
> > > 2.30.2
> > >
