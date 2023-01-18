Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB545670F27
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 01:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjARAxg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 19:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjARAwk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 19:52:40 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366EC46082
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 16:41:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id v23so30377086plo.1
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 16:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvtvbFcu8/sAS6/k33PRgFD5NoeFjBVPt56XgLELszI=;
        b=WTtr0z2OuSCYeljT8HCLh559zud9JHZmB3uz+tXIuMOtx+02M2k0S7UJk1ZUo59qSh
         yqCLxfgnkGmCUsRqKymyB1q2gzhK+BuQGY36nwUg1eXj2vMaIax7CegD5/cr9EpwpcuQ
         H3+ReJ5gLNcNewnDQ2CkApdBTZAVwQCF3MSbYdoJ+sNrGydPhT+WuvCk9mPCyFTO53HJ
         v+1mC5hQ3v7VF+7bFhWnV0HuSI261d+eIdS8R32eA2Nuamp3c6ChRgc4lavXYZpxgXHn
         EIsD+YZhn2JR6PaV0Q1AF2tiA+eoM+k+evSfxSCbp9dkSwxJ9V1gKwa4q1wUsz9xr6Mm
         fXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvtvbFcu8/sAS6/k33PRgFD5NoeFjBVPt56XgLELszI=;
        b=CoZU0Ke7n+RR1EOBVVK4I1U5eS0rCpePlUsGalApsj8/7Ze7zy+QaVgqKHQR4GSem5
         gxzjfzJ3cH1CS9vIa5g/PEgLnogbwH6amZevJhHj5Y/wWULeF1oIo2pkFSVfL0ACMUdN
         FxHX/q9rD0Q2X/+ie/V5/BEAtHyQscumahxWIhNGSf+CctcgDd1El00vrFt1FLRcF69J
         WJX/1nfyFQu51xU4HTBGc2airtzi/vfz38TrlAcwmlAkG5QTi1KjD6Q+bL30mMZRN0NA
         aM2Tx1lDYjPB+arS/xTAu/wCMMT6z+E5Cnl8DTaY4w4qTdFwOAiAktDHBO4pokRruLkU
         RHCw==
X-Gm-Message-State: AFqh2kpDQvtUqu81Cuz7xBEovSijz1Rx/cN5sBYxfWv1EHTsZZg5d+nq
        mDSXILk6dmkc9MK1IthR0/8=
X-Google-Smtp-Source: AMrXdXv2BFE77ASd9bSk3z5yQZ4T/yMCmOS7vmEHAD20s2BZcbBeshrFgS53N7aYHUlKjZw0EMpntw==
X-Received: by 2002:a05:6a20:2d12:b0:b6:40ae:823e with SMTP id g18-20020a056a202d1200b000b640ae823emr5371591pzl.5.1674002505587;
        Tue, 17 Jan 2023 16:41:45 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:194d])
        by smtp.gmail.com with ESMTPSA id g75-20020a62524e000000b0058c8bdd5eafsm6181451pfb.87.2023.01.17.16.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:41:44 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:41:42 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Migrate release_on_unlock logic to
 non-owning ref semantics
Message-ID: <20230118004142.7dnzg4dgda6l6ilq@MacBook-Pro-6.local>
References: <20221230010738.45277-1-alexei.starovoitov@gmail.com>
 <CAADnVQ+Ur_Z2j9SEP73BZdYPQrMxzjOWa-45z-cw9zvtANTmCQ@mail.gmail.com>
 <58508fcb-5b0f-5e29-8e2d-3e2d3c77118a@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58508fcb-5b0f-5e29-8e2d-3e2d3c77118a@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 05:42:39PM -0500, Dave Marchevsky wrote:
> On 12/29/22 8:13 PM, Alexei Starovoitov wrote:
> > On Thu, Dec 29, 2022 at 5:07 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> @@ -11959,7 +11956,10 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
> >>                 dst_reg->type = PTR_TO_MAP_VALUE;
> >>                 dst_reg->off = aux->map_off;
> >>                 WARN_ON_ONCE(map->max_entries != 1);
> >> -               /* We want reg->id to be same (0) as map_value is not distinct */
> >> +               /* map->id is positive s32. Negative map->id will not collide with env->id_gen.
> >> +                * This lets us track active_lock state as single u32 instead of pair { map|btf, id }
> >> +                */
> >> +               dst_reg->id = -map->id;
> > 
> > Here is what I meant in my earlier reply to Dave's patches 1 and 2.
> > imo this is a simpler implementation of the same logic.
> > The only tricky part is above bit that is necessary
> > to use a single u32 in bpf_reg_state to track active_lock.
> > We can follow up with clean up of active_lock comparison
> > in other places of the verifier.
> > Instead of:
> >                 if (map)
> >                         cur->active_lock.ptr = map;
> >                 else
> >                         cur->active_lock.ptr = btf;
> >                 cur->active_lock.id = reg->id;
> > it will be:
> >   cur->active_lock_id = reg->id;
> > 
> > Another cleanup is needed to compare active_lock_id properly
> > in regsafe().
> > 
> > Thoughts?
> 
> Before Kumar's commit d0d78c1df9b1d ("bpf: Allow locking bpf_spin_lock global
> variables"), setting of dst_reg->id in that code path was guarded by "does
> map val have spin_lock check":
> 
>   if (btf_record_has_field(map->record, BPF_SPIN_LOCK))
>     dst_reg->id = ++env->id_gen;
> 
> Should we do that here as well? Not sure what the implications of overzealous
> setting of dst_reg->id are.

That won't work, since for spin_locks in global data that 'id' has to be stable.
Hence I went with -map->id.

> More generally: I see why doing -map->id will not overlap with env->id_gen
> in practice. For PTR_TO_BTF_ID, I'm not sure that we'll always have a nonzero
> reg->id here. check_kfunc_call has
> 
>   if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
>     regs[BPF_REG_0].id = ++env->id_gen;

correct.

> when checking retval, but there's no such equivalent in check_helper_call,
> which instead does
> 
>   if (type_may_be_null(regs[BPF_REG_0].type))
>     regs[BPF_REG_0].id = ++env->id_gen;
> 
> and similar in a few paths.
> 
> Should we ensure that "any PTR_TO_BTF_ID reg that has a spin_lock must
> have a nonzero id"? If we don't, a helper which returns
> PTR_TO_BTF_ID w/ spin_lock that isn't MAYBE_NULL will break this whole scheme.

correct. it's not a problem in practice, because there are few helpers
that return PTR_TO_BTF_ID and none of them point to spin_lock.

> Some future-proofing concerns:
> 
> Kumar's commit above mentions this in the summary:
> 
>   Note that this can be extended in the future to also remember offset
>   used for locking, so that we can introduce multiple bpf_spin_lock fields
>   in the same allocation.

Yeah. I forgot about this 'offset' idea.

> When the above happens we'll need to go back to a struct - or some packed
> int - to describe "lock identity" anyways.

yeah.
I was hoping we can represent all of 'active_lock' as a single id,
but 'offset' is hard to encode into an integer.
We won't be able to add it in top 32-bits, since the resulting 64-bit 'id'
would need to go through check_ids(). Even if we extend idmap_scratch to be 64-bit
it won't be correct. Two different 32-bit IDs are ok to see and the states
might still be equivalent, but two different 'offset' are not ok.
The offset in 'old' state and offset in 'cur' state has to be the same for
states to be equivalent. So the future 'offset' would need to be compared in regsafe()
manually anyway. Since we'd have to do that there is little point combining
active_lock.ptr comparison into 32-bit id.
Sigh.

> IIRC in the long term we wanted to stop overloading reg->id's meaning,
> with the ideal end state being reg->id used only for "null id" purposes. If so,
> this is moving us back towards the overloaded state.
> 
> Happy to take this over and respin once we're done discussing, unless you
> want to do it.

Please go ahead.
Let's scratch my -map->id idea for now.
Let's go with embedding 'struct bpf_active_lock {void *ptr; u32 id;}' into bpf_reg_state,
but please make sure that bpf_reg_state grows by 8 bytes only.
Simply adding bpf_active_lock in btf_id part of it will grow by 16.

Note the other idea you had to keep a pointer to active_lock in bpf_reg_state is
too dangerous and probably incorrect. That pointer might become dangling after we
copy_verifier_state. All pointers in bpf_reg_state need to be stable objects.
The only exception is 'parent' which is very tricky on its own.

Maybe we can do
struct bpf_active_lock {
   u32 map_btf_id;  /* instead of void *ptr */
   u32 id;
};
and init map_btf_id with -map->id or btf->id;
It's guaranteed not to overlap and != 0.
Don't know whether other pointers will be there. Maybe premature optimization.
