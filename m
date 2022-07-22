Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640FA57E4DB
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiGVQwk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiGVQwj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 12:52:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0876454
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:52:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l23so9570511ejr.5
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ytH6jMktAXW9Vta9GnlouS/2Z3pe0lQ8OymvYO0mDo=;
        b=QQn164ZDd6kQjOTYIBny42MS61a7il2FBIzSnBeAvRyAQRoGq/NHY4QikuE4sOxs9T
         7aWI+qJIIVQlLHWRMtQNtHcbZSnCctNWtquzBXg5GKloT97psLz623Jy0K5EE8nYaFMj
         BJ955hhVl1JHEcG+Bv2I+B89bqNUUYRSq2e77FmticX8NigHwmc797qs48xHKK0N18Xj
         wZcpb/m7lFN1OdoB0yqQw40oRqWEFZ8HiQ2b3e/GPFEmSEnue2imVoEx70ZN7kbCUU6e
         mShIV7PrA+VuJyTHfrBjFIZ0xH5HXCCdYKLTTBPnY3NYkcGtzDIpxz1WBWddUsPyI9Oc
         JSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ytH6jMktAXW9Vta9GnlouS/2Z3pe0lQ8OymvYO0mDo=;
        b=Lc7ufia2mn+ZUVkTRd7CHCU27Rl7+jPqIDjj+J7WenyZEBqApbPb6o8V1hS9ZfPRcx
         PdaD77g+3jbBFnWF5tB5zNUyaecgyvmgSPL67UrD+pAcNtioqEGKktVPSJ/7xtpqVJJX
         YGFdg/U+AwIuBvyB/2+csciYYzTsFZpRtMq1wUz2/AzDXiL99UyrPnXKFycyPF+LHAJA
         FhXTLZFh+AZmiAH+DNeBahDhhol9CfPoePr2NnAmBJb5fnaiANxPtCn5Sx8NLWPs/5xp
         el56LFmK7w90LkiCfs6S0E0B6iXPzKnd82UBsPA1IXW7ROmYduuCpT/IBg/5pYbRa8jW
         6S0Q==
X-Gm-Message-State: AJIora/pC7EdCRGV2n2xjXQM+eqqsNpzIA06Yuvsrq3xj8QlPMckjlvi
        rCzBYyVEuyQOU4s2ZQEPvALtF7Pf1lTNuNsxoMA=
X-Google-Smtp-Source: AGRyM1sr1I8Oac2GfpWeoFtumYxRT33J5sDFeBB40vNCACDLf8GZXFHgGxI/FrETtRav5HIC9xsHGmBedJdPTGU920g=
X-Received: by 2002:a17:907:a40f:b0:72b:64ee:5b2f with SMTP id
 sg15-20020a170907a40f00b0072b64ee5b2fmr664667ejc.268.1658508756801; Fri, 22
 Jul 2022 09:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220721024821.251231-1-joannelkoong@gmail.com> <20220721170221.jlcvzcxfyrnrmyyc@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220721170221.jlcvzcxfyrnrmyyc@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 22 Jul 2022 09:52:25 -0700
Message-ID: <CAJnrk1bkTvdHGCje_H_Bg1BWihnes1ujhWJzpKVkDL66_cOPJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix ref_obj_id for dynptr data
 slices in verifier
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Thu, Jul 21, 2022 at 10:02 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Jul 20, 2022 at 07:48:20PM -0700, Joanne Koong wrote:
> > When a data slice is obtained from a dynptr (through the bpf_dynptr_data API),
> > the ref obj id of the dynptr must be found and then associated with the data
> > slice.
> >
> > The ref obj id of the dynptr must be found *before* the caller saved regs are
> > reset. Without this fix, the ref obj id tracking is not correct for
> > dynptrs that are at an offset from the frame pointer.
> >
> > Please also note that the data slice's ref obj id must be assigned after the
> > ret types are parsed, since RET_PTR_TO_ALLOC_MEM-type return regs get
> > zero-marked.
> >
> > Fixes: 34d4ef5775f7("bpf: Add dynptr data slices");
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 30 +++++++++++++++++-------------
> >  1 file changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c59c3df0fea6..00f9b5a77734 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7341,6 +7341,22 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                       }
> >               }
> >               break;
> > +     case BPF_FUNC_dynptr_data:
> > +             /* Find the id of the dynptr we're tracking the reference of.
> > +              * We must do this before we reset caller saved regs.
> > +              *
> > +              * Please note as well that meta.ref_obj_id after the check_func_arg() calls doesn't
> > +              * already contain the dynptr ref obj id, since dynptrs are stored on the stack.
> > +              */
> > +             for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> > +                     if (arg_type_is_dynptr(fn->arg_type[i])) {
> > +                             if (meta.ref_obj_id) {
> > +                                     verbose(env, "verifier internal error: multiple refcounted args in func\n");
> > +                                     return -EFAULT;
> > +                             }
> > +                             meta.ref_obj_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> check_func_arg() is setting meta->ref_obj_id for each arg.
> Can this meta.ref_obj_id assignment be done in check_func_arg()
> instead of looping all args again here.
>
I think so! Will update for v2.
> > +                     }
> > +             }
> >       }
> >
> >       if (err)
> > @@ -7470,20 +7486,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >               /* For release_reference() */
> >               regs[BPF_REG_0].ref_obj_id = id;
> >       } else if (func_id == BPF_FUNC_dynptr_data) {
> > -             int dynptr_id = 0, i;
> > -
> > -             /* Find the id of the dynptr we're acquiring a reference to */
> > -             for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> > -                     if (arg_type_is_dynptr(fn->arg_type[i])) {
> > -                             if (dynptr_id) {
> > -                                     verbose(env, "verifier internal error: multiple dynptr args in func\n");
> > -                                     return -EFAULT;
> > -                             }
> > -                             dynptr_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> > -                     }
> > -             }
> >               /* For release_reference() */
> > -             regs[BPF_REG_0].ref_obj_id = dynptr_id;
> > +             regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
> nit. This will be the same as the earlier is_ptr_cast_function().
> Merge the if statements ?
Will do for v2
>
> >       }
> >
> >       do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
Thanks for taking a look at this patch, Jiri and Martin!
> > --
> > 2.30.2
> >
