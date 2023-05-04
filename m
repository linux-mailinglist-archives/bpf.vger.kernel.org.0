Return-Path: <bpf+bounces-41-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09D76F78F0
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82891C2093C
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EB3C158;
	Thu,  4 May 2023 22:19:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8947C
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:19:28 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB6A12480
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:19:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so171611966b.0
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683238760; x=1685830760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqhQhTgSBMWKa9tHiMNcx4UPBdNaw7iEHqfYLkDn53U=;
        b=apTOvcvUGMhcQ9AEjGQ5071TcJPYsm0ca4N/MASaacLyV+LIvhyj4VOZa7b2JYVyZQ
         zR/nmYZPcuUBXyw3zI/jTD42FdWivQDg3TY1+wvxNBtkW4A2XXcVHU267E/XRgIofR6k
         3TH+nmT1PwvaMUpEPBzarBPWPBcDxEiKBFem3M6oNMbQKVRRBOawgQW8sftjXedSBRgQ
         TfpDAeScVPhEXZoxG3Me63Nf9rzne3j7jL0FcV3YVkUdePcOabmgGFgYpvb/JOHBk29y
         bZHUNHTf9+2Bt7FZbDUuvuGty4omyPAKV1xKDoGv2IqnzsobaYGAL4JGgazenYSNALWH
         J/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238760; x=1685830760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqhQhTgSBMWKa9tHiMNcx4UPBdNaw7iEHqfYLkDn53U=;
        b=iQa/sJz1JWnnyQBG/AD7oOY75YIQYlwTXU6BBzCf42AIoiqJF0amBafw634NJh2HM9
         szEHPja0f/3YP2353huHsQZhmifIUk1LVaXlu0umZoT9KZzuNUpWmS2mCIuVQKi3QA6v
         0cfFbZxlmnqrBKKExOqVdDY8RuPdB7jFPKBtXGIXLSGoMbsl49izHpWo93Z8MoZi5BQK
         VLOuvYXvqfRjnsFXjoT/w+xMv8KAzMQj2Fvr/VApxnoSSlT25iP2jRKcLfaeNF2xVM1E
         i5xX78ppkvAvGuLTsVsuUblu2dyB2IY4jpLiPAjqMp05SMpHAFeroPnx4FylJPhDtaYo
         vUMQ==
X-Gm-Message-State: AC+VfDy1XXDkYvJOHxBHDfRJyn2V0nzkPrWxNovbeRy28AS/4ljX/6e4
	66oBX/rTRtp+2lbDc45M7dxZ/kf57LMQ8I88JWw=
X-Google-Smtp-Source: ACHHUZ7eFr6foHgW+6/Yfsdrh3mwrjQbwj1KsbVrFHPPdnSO3qglnn2IAJqg+BnlrN6+8ExSvTkicpWJzl3GELveB7U=
X-Received: by 2002:a17:906:974d:b0:94b:b4a5:30f with SMTP id
 o13-20020a170906974d00b0094bb4a5030fmr333042ejy.55.1683238760308; Thu, 04 May
 2023 15:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230425234911.2113352-1-andrii@kernel.org> <20230425234911.2113352-9-andrii@kernel.org>
 <20230504194058.uhnyup7xang5mq5i@MacBook-Pro-6.local>
In-Reply-To: <20230504194058.uhnyup7xang5mq5i@MacBook-Pro-6.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 15:19:08 -0700
Message-ID: <CAEf4Bzb9bjNXu4axm7C39i+6PBRibXuPMT0TOo30hBFt2WRYCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/10] bpf: support precision propagation in the
 presence of subprogs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 12:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 25, 2023 at 04:49:09PM -0700, Andrii Nakryiko wrote:
> >       if (insn->code =3D=3D 0)
> >               return 0;
> > @@ -3424,14 +3449,72 @@ static int backtrack_insn(struct bpf_verifier_e=
nv *env, int idx,
> >               if (class =3D=3D BPF_STX)
> >                       bt_set_reg(bt, sreg);
> >       } else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {
> > -             if (opcode =3D=3D BPF_CALL) {
> > -                     if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> > -                             return -ENOTSUPP;
> > -                     /* BPF helpers that invoke callback subprogs are
> > -                      * equivalent to BPF_PSEUDO_CALL above
> > +             if (bpf_pseudo_call(insn)) {
> > +                     int subprog_insn_idx, subprog;
> > +                     bool is_global;
> > +
> > +                     subprog_insn_idx =3D idx + insn->imm + 1;
> > +                     subprog =3D find_subprog(env, subprog_insn_idx);
> > +                     if (subprog < 0)
> > +                             return -EFAULT;
> > +                     is_global =3D subprog_is_global(env, subprog);
> > +
> > +                     if (is_global) {
>
> could you add a warn_on here that checks that jmp history doesn't have in=
sns from subprog.

wouldn't this be very expensive to go over the entire jmp history to
check that no jump point there overlaps with the global function? Or
what do you have in mind specifically for this check?

>
> > +                             /* r1-r5 are invalidated after subprog ca=
ll,
> > +                              * so for global func call it shouldn't b=
e set
> > +                              * anymore
> > +                              */
> > +                             if (bt_reg_mask(bt) & BPF_REGMASK_ARGS)
> > +                                     return -EFAULT;
>
> This shouldn't be happening, but backtracking is delicate.
> Could you add verbose("backtracking bug") here, so we know why the prog g=
ot rejected.
> I'd probably do -ENOTSUPP, but EFAULT is ok too.

Will add verbose(). EFAULT because valid code should never use r1-r5
after call. Invalid code should be rejected before that, and if not,
then it is really a bug and best to bail out.


>
> > +                             /* global subprog always sets R0 */
> > +                             bt_clear_reg(bt, BPF_REG_0);
> > +                             return 0;
> > +                     } else {
> > +                             /* static subprog call instruction, which
> > +                              * means that we are exiting current subp=
rog,
> > +                              * so only r1-r5 could be still requested=
 as
> > +                              * precise, r0 and r6-r10 or any stack sl=
ot in
> > +                              * the current frame should be zero by no=
w
> > +                              */
> > +                             if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS)
> > +                                     return -EFAULT;
>
> same here.

ack

>
> > +                             /* we don't track register spills perfect=
ly,
> > +                              * so fallback to force-precise instead o=
f failing */
> > +                             if (bt_stack_mask(bt) !=3D 0)
> > +                                     return -ENOTSUPP;
> > +                             /* propagate r1-r5 to the caller */
> > +                             for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i=
++) {
> > +                                     if (bt_is_reg_set(bt, i)) {
> > +                                             bt_clear_reg(bt, i);
> > +                                             bt_set_frame_reg(bt, bt->=
frame - 1, i);
> > +                                     }
> > +                             }
> > +                             if (bt_subprog_exit(bt))
> > +                                     return -EFAULT;
> > +                             return 0;
> > +                     }
> > +             } else if ((bpf_helper_call(insn) &&
> > +                         is_callback_calling_function(insn->imm) &&
> > +                         !is_async_callback_calling_function(insn->imm=
)) ||
> > +                        (bpf_pseudo_kfunc_call(insn) && is_callback_ca=
lling_kfunc(insn->imm))) {
> > +                     /* callback-calling helper or kfunc call, which m=
eans
> > +                      * we are exiting from subprog, but unlike the su=
bprog
> > +                      * call handling above, we shouldn't propagate
> > +                      * precision of r1-r5 (if any requested), as they=
 are
> > +                      * not actually arguments passed directly to call=
back
> > +                      * subprogs
> >                        */
> > -                     if (insn->src_reg =3D=3D 0 && is_callback_calling=
_function(insn->imm))
> > +                     if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS)
> > +                             return -EFAULT;
> > +                     if (bt_stack_mask(bt) !=3D 0)
> >                               return -ENOTSUPP;
> > +                     /* clear r1-r5 in callback subprog's mask */
> > +                     for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
> > +                             bt_clear_reg(bt, i);
> > +                     if (bt_subprog_exit(bt))
> > +                             return -EFAULT;
> > +                     return 0;
>
> jmp history will include callback insn, right?
> So skip of jmp history is missing here ?

This is, say, `call bpf_loop;` instruction. Which means we just got
out of bpf_loop's callback's jump history (so already "skipped" them,
except we didn't skip, we properly processed them). So there is
nothing to skip anymore. We are in the parent program already.

This is exactly the situation described in the third example in the
commit description. We are at instruction #11 here.

Note how we don't bail out on r1-r5 being set, because it's expected
that callback might require some of its input arguments to be precise
and that's not an error condition. This is similar to handling global
function, where r1-r5 might be still required to be precise when we
already processed the entire jump history.

It's a bit mind bending to reason about all this, because everything
is backwards.

>
> > +             } else if (opcode =3D=3D BPF_CALL) {
> >                       /* kfunc with imm=3D=3D0 is invalid and fixup_kfu=
nc_call will
> >                        * catch this error later. Make backtracking cons=
ervative
> >                        * with ENOTSUPP.
> > @@ -3449,7 +3532,39 @@ static int backtrack_insn(struct bpf_verifier_en=
v *env, int idx,
> >                               return -EFAULT;
> >                       }
> >               } else if (opcode =3D=3D BPF_EXIT) {
> > -                     return -ENOTSUPP;
> > +                     bool r0_precise;
> > +
> > +                     if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> > +                             /* if backtracing was looking for registe=
rs R1-R5
> > +                              * they should have been found already.
> > +                              */
> > +                             verbose(env, "BUG regs %x\n", bt_reg_mask=
(bt));
> > +                             WARN_ONCE(1, "verifier backtracking bug")=
;
> > +                             return -EFAULT;
> > +                     }
> > +
> > +                     /* BPF_EXIT in subprog or callback always jump ri=
ght
>
> I'd say 'subprog always returns right after the call'. 'jump' is a bit co=
nfusing here,
> since it doesn't normally used to describe function return address.

this was described in the context of "jump history", but I'll adjust
the wording to "return".

>
> > +                      * after the call instruction, so by check whethe=
r the
> > +                      * instruction at subseq_idx-1 is subprog call or=
 not we
> > +                      * can distinguish actual exit from *subprog* fro=
m
> > +                      * exit from *callback*. In the former case, we n=
eed
> > +                      * to propagate r0 precision, if necessary. In th=
e
> > +                      * former we never do that.
> > +                      */
> > +                     r0_precise =3D subseq_idx - 1 >=3D 0 &&
> > +                                  bpf_pseudo_call(&env->prog->insnsi[s=
ubseq_idx - 1]) &&
> > +                                  bt_is_reg_set(bt, BPF_REG_0);
> > +
>
> The rest all makes sense.

Cool. Thanks for taking a thorough look. I'm a bit confused on what
exactly you'd like me to check on global subprog call, so please
elaborate. I'll address all the other feedback meanwhile.

