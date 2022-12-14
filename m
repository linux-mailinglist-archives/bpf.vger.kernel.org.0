Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865664D021
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 20:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiLNTiA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 14:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbiLNTh7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 14:37:59 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1433429376
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 11:37:58 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s5so24048023edc.12
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 11:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+mxv/CvPAWr5PHYDZat3buBrEYFluzzk6fbnWCsK7WU=;
        b=au8V2vdNQkH0WvYef1kAOOv8g3D/J8JImk60XJtwGuMwDkcGS0Y0RvzXHc+hoTss2j
         NwFZLRnCplU4LME9TcPb/jhscihunTg5uGAp3PlrDs7/X/7KWjPrRKpVGbD5/xkNUCo6
         YevHWaUEnvMs8+nbLLGlA15/EQKG23qgYTSZiqjoRvPmr0454kgU6lTFRHt1Bg/0ncv0
         z4ELKmvU9+YI9mOu9KkzCBnnHnoq+pZ/zy3NjfKT05bGN5IrhesgtwZQ8SiAa47w+0An
         dj+hFRpw+iVu2Cket0WXe6OwN0Qh8rZSUHIAGLMeINmRWBPf+t6WIZhZarB8SCBkPjNe
         pwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mxv/CvPAWr5PHYDZat3buBrEYFluzzk6fbnWCsK7WU=;
        b=bhGLtyzyTgh9zJDbaohjvCsfqgYQ9DB+Ma305tuvll/+ksNtPO4M0I5z1l6aiNdTjG
         YqlNNpWcriU3P+wmHYt3v/Aq5ysFJ/gSaXf0+SAheFGK525PUNVwDU1TEnNxG474Tt5M
         eX8NzgDxWWZFE+zpboVhIJxY00r2eKAiMRjEdzH2SJh3N7mT9fc/4aXYZLBAv4tJAvxN
         Uolgdl/u1uGzTVN/jL378G9Jub5+ffjEK17KTcVHjWh+fj4kB2bpdN5FNnPHcq5bd/ti
         fgNefsmdPf2NliV3fNkeABRFlKlU/vZdVaF2RwwyjJIq8PIX5NaW8GGWxQjugkKH0jCH
         G7FA==
X-Gm-Message-State: ANoB5pmIOZlYO+vLXdsqW19LUt9Gd3LWqOsCmrk/1/JYImG58glnNHW0
        0pKW/HnPB8+ZaKeTgVo3RxDSW9Fulu34lzGOWMQ=
X-Google-Smtp-Source: AA0mqf6KWVb/c2xR7sXPzvTkZo86YlUcnA++L3lYxjd5lciGPaDcy9roMV+8tjf3CG4HWPBWJQxnZWEVqN33/EloJCs=
X-Received: by 2002:aa7:cd05:0:b0:46c:e558:ce90 with SMTP id
 b5-20020aa7cd05000000b0046ce558ce90mr13970572edw.81.1671046676615; Wed, 14
 Dec 2022 11:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20221209135733.28851-1-eddyz87@gmail.com> <20221209135733.28851-2-eddyz87@gmail.com>
 <CAEf4BzbPBeAUzueQ7mxcmSovY2Nqr37RFZnb5B1pwSDqNhyZ6w@mail.gmail.com> <6ff2854e4c1f2a5c3754a8ffaadf5d47fa1c2285.camel@gmail.com>
In-Reply-To: <6ff2854e4c1f2a5c3754a8ffaadf5d47fa1c2285.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Dec 2022 11:37:44 -0800
Message-ID: <CAEf4BzYh9T37BB0BO6ZNDS+VYHPYZ8xGuTO7tpyLMgksYd2B8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: regsafe() must not skip check_ids()
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
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

On Wed, Dec 14, 2022 at 5:26 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2022-12-13 at 16:35 -0800, Andrii Nakryiko wrote:
> > On Fri, Dec 9, 2022 at 5:58 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > The verifier.c:regsafe() has the following shortcut:
> > >
> > >         equal = memcmp(rold, rcur, offsetof(struct bpf_reg_state, parent)) == 0;
> > >         ...
> > >         if (equal)
> > >                 return true;
> > >
> > > Which is executed regardless old register type. This is incorrect for
> > > register types that might have an ID checked by check_ids(), namely:
> > >  - PTR_TO_MAP_KEY
> > >  - PTR_TO_MAP_VALUE
> > >  - PTR_TO_PACKET_META
> > >  - PTR_TO_PACKET
> > >
> > > The following pattern could be used to exploit this:
> > >
> > >   0: r9 = map_lookup_elem(...)  ; Returns PTR_TO_MAP_VALUE_OR_NULL id=1.
> > >   1: r8 = map_lookup_elem(...)  ; Returns PTR_TO_MAP_VALUE_OR_NULL id=2.
> > >   2: r7 = ktime_get_ns()        ; Unbound SCALAR_VALUE.
> > >   3: r6 = ktime_get_ns()        ; Unbound SCALAR_VALUE.
> > >   4: if r6 > r7 goto +1         ; No new information about the state
> > >                                 ; is derived from this check, thus
> > >                                 ; produced verifier states differ only
> > >                                 ; in 'insn_idx'.
> > >   5: r9 = r8                    ; Optionally make r9.id == r8.id.
> > >   --- checkpoint ---            ; Assume is_state_visisted() creates a
> > >                                 ; checkpoint here.
> > >   6: if r9 == 0 goto <exit>     ; Nullness info is propagated to all
> > >                                 ; registers with matching ID.
> > >   7: r1 = *(u64 *) r8           ; Not always safe.
> > >
> > > Verifier first visits path 1-7 where r8 is verified to be not null
> > > at (6). Later the jump from 4 to 6 is examined. The checkpoint for (6)
> > > looks as follows:
> > >   R8_rD=map_value_or_null(id=2,off=0,ks=4,vs=8,imm=0)
> > >   R9_rwD=map_value_or_null(id=2,off=0,ks=4,vs=8,imm=0)
> > >   R10=fp0
> > >
> > > The current state is:
> > >   R0=... R6=... R7=... fp-8=...
> > >   R8=map_value_or_null(id=2,off=0,ks=4,vs=8,imm=0)
> > >   R9=map_value_or_null(id=1,off=0,ks=4,vs=8,imm=0)
> > >   R10=fp0
> > >
> > > Note that R8 states are byte-to-byte identical, so regsafe() would
> > > exit early and skip call to check_ids(), thus ID mapping 2->2 will not
> > > be added to 'idmap'. Next, states for R9 are compared: these are not
> > > identical and check_ids() is executed, but 'idmap' is empty, so
> > > check_ids() adds mapping 2->1 to 'idmap' and returns success.
> > >
> > > This commit pushes the 'equal' down to register types that don't need
> > > check_ids().
> > >
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 29 ++++++++---------------------
> > >  1 file changed, 8 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 3194e9d9e4e4..d05c5d0344c6 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -12926,15 +12926,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
> > >
> > >         equal = memcmp(rold, rcur, offsetof(struct bpf_reg_state, parent)) == 0;
> > >
> > > -       if (rold->type == PTR_TO_STACK)
> > > -               /* two stack pointers are equal only if they're pointing to
> > > -                * the same stack frame, since fp-8 in foo != fp-8 in bar
> > > -                */
> > > -               return equal && rold->frameno == rcur->frameno;
> > > -
> > > -       if (equal)
> > > -               return true;
> > > -
> > >         if (rold->type == NOT_INIT)
> > >                 /* explored state can't have used this */
> > >                 return true;
> > > @@ -12942,6 +12933,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
> > >                 return false;
> > >         switch (base_type(rold->type)) {
> > >         case SCALAR_VALUE:
> > > +               if (equal)
> > > +                       return true;
> > >                 if (env->explore_alu_limits)
> > >                         return false;
> > >                 if (rcur->type == SCALAR_VALUE) {
> > > @@ -13012,20 +13005,14 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
> > >                 /* new val must satisfy old val knowledge */
> > >                 return range_within(rold, rcur) &&
> > >                        tnum_in(rold->var_off, rcur->var_off);
> > > -       case PTR_TO_CTX:
> > > -       case CONST_PTR_TO_MAP:
> > > -       case PTR_TO_PACKET_END:
> > > -       case PTR_TO_FLOW_KEYS:
> > > -       case PTR_TO_SOCKET:
> > > -       case PTR_TO_SOCK_COMMON:
> > > -       case PTR_TO_TCP_SOCK:
> > > -       case PTR_TO_XDP_SOCK:
> > > -               /* Only valid matches are exact, which memcmp() above
> > > -                * would have accepted
> > > +       case PTR_TO_STACK:
> > > +               /* two stack pointers are equal only if they're pointing to
> > > +                * the same stack frame, since fp-8 in foo != fp-8 in bar
> > >                  */
> > > +               return equal && rold->frameno == rcur->frameno;
> > >         default:
> > > -               /* Don't know what's going on, just say it's not safe */
> > > -               return false;
> > > +               /* Only valid matches are exact, which memcmp() */
> > > +               return equal;
> >
> > Is it safe to assume this for any possible register type? Wouldn't
> > register types that use id and/or ref_obj_id need extra checks here? I
> > think preexisting default was a safer approach, in which if we forgot
> > to explicitly add support for some new or updated register type, the
> > worst thing is that for that *new* register we'd have suboptimal
> > verification performance, but not safety concerns.
>
> Well, I don't think that this commit changes regsafe() behavior in
> this regard. Here is how the code was structured before this commit:
>
> static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>                     struct bpf_reg_state *rcur, struct bpf_id_pair *idmap)
> {
>         bool equal;
>
>         if (!(rold->live & REG_LIVE_READ))
>                 return true;
>         equal = memcmp(rold, rcur, offsetof(struct bpf_reg_state, parent)) == 0;
>         if (rold->type == PTR_TO_STACK)
>                 return equal && rold->frameno == rcur->frameno;
> --->    if (equal)
>                 return true;
>         if (rold->type == NOT_INIT)
>                 return true;
>         if (rcur->type == NOT_INIT)
>                 return false;
>         switch (base_type(rold->type)) {
>         case SCALAR_VALUE:
>                 ... it's own logic, always returns ...
>         case PTR_TO_MAP_KEY:
>         case PTR_TO_MAP_VALUE:
>                 ... it's own logic, always returns ...
>         case PTR_TO_PACKET_META:
>         case PTR_TO_PACKET:
>                 ... it's own logic, always returns ...
>         case PTR_TO_CTX:
>         case CONST_PTR_TO_MAP:
>         case PTR_TO_PACKET_END:
>         case PTR_TO_FLOW_KEYS:
>         case PTR_TO_SOCKET:
>         case PTR_TO_SOCK_COMMON:
>         case PTR_TO_TCP_SOCK:
>         case PTR_TO_XDP_SOCK:
>         default:
>                 return false;
>         }
>
>         /* Shouldn't get here; if we do, say it's not safe */
>         WARN_ON_ONCE(1);
>         return false;
> }
>
> So the "safe if byte-to-byte equal" behavior was present already.
> I can add an explicit list of types to the "return equal;" branch
> and add a default "return false;" branch if you think that it is
> more fool-proof.

Sorry, I didn't claim you made it worse. But given we are refactoring
this piece of code, let's make it more "safe-by-default".

So yeah, I think an explicit list of all the recognized register types
would be better, IMO.


>
> >
> >
> > >         }
> > >
> > >         /* Shouldn't get here; if we do, say it's not safe */
> > > --
> > > 2.34.1
> > >
>
