Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE49764627C
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLGUlM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiLGUlL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:41:11 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAAF30558
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:41:09 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 130so18501086pfu.8
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 12:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxHt6fD/++AAiJAXeL0+27YLobwQnq8YQypkQOX0UxA=;
        b=NlPhc1QImETyE3kwyeC/jJeghrs5lorZ3qk6cQdntBJbB8Hub6MBCtAOb4CPvfyX3D
         JbUlFtutTukAsIqZhaFufpv8LGhdm3Ol8kebx47KXQIQLbCj5UwNxjJ0ozrjxhq8lhX1
         qTJ+L3Dd5segb7mfjv0lZjA8K67YFL7IGl/vn0HyUzftHMag49AMKguyEL1jWFswdvwq
         fUZQVdm7l0pJoTBgITkdLInAmgCpEZJLZ91XrH5Mu4iKSGnLsCl7EUM6M8HO6FCbw7ro
         EjM6Og5dByN6BEc08c5JShL02vZKDudy7kT8rWryigptblnpnFtQelH3CiByJxC3t9QU
         ffVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxHt6fD/++AAiJAXeL0+27YLobwQnq8YQypkQOX0UxA=;
        b=pGDTelNvDi4SRv5vYUe2pVgg+62ZU3yWxNRf1KzlxNEUYyFYEB5hbDxObqMB2dBtxF
         VPODxW6QwX5upT1UjjkovljslyQJh9OA5vmNuKkMBJIH03kp7ZByLBD8mb/FGfRRImt1
         CKg5s0FvcVZ64iFYE0DMr0hBPOJMjfqEuMJwO+6rBqXbThSZ6B7rKgNU8+Iou1CKRxla
         Gz7g2shuKdAL8yopMZr7dMVBs1f5zoFAVSPVQT4SA6l38mY/EtPi6foSHHM+M1PPLuPL
         nIOyGOZ9ddeeIZXqQdAlt8DKMKV1WQx1JbU/Ce3mQgdml2XV7tF964yRNKhEBnr0/L0o
         T27A==
X-Gm-Message-State: ANoB5pm9QtRjzNY5VjR04y2TZ2NNdgdgDhpmifZExujjJnV0QFRU1MrZ
        6PVnZuXSxlWL7CkWDD82vP1GSW3rXrKhkD5t
X-Google-Smtp-Source: AA0mqf66ivwL16EmF8nMh84SEboJFHbjuN6nMJrTettwdhNbKdSZ/TeNAMipziPZoqVMef7ufauVfQ==
X-Received: by 2002:a63:5262:0:b0:477:6e5d:4e44 with SMTP id s34-20020a635262000000b004776e5d4e44mr69504382pgl.7.1670445668804;
        Wed, 07 Dec 2022 12:41:08 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b00189c62eac37sm9090491plk.32.2022.12.07.12.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:41:08 -0800 (PST)
Date:   Thu, 8 Dec 2022 02:11:05 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Move PTR_TO_STACK alignment check
 to process_dynptr_func
Message-ID: <20221207204105.emz525gb4qjodipq@apollo>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-6-memxor@gmail.com>
 <Y3bIhyOWs1r22R+2@maniforge.lan>
 <20221120191013.plzlna24vwluxebk@apollo>
 <Y3soXvFs4WV7/KXj@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3soXvFs4WV7/KXj@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 12:57:26PM IST, David Vernet wrote:
> On Mon, Nov 21, 2022 at 12:40:13AM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Fri, Nov 18, 2022 at 05:19:27AM IST, David Vernet wrote:
> > > On Tue, Nov 15, 2022 at 05:31:28AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > After previous commit, we are minimizing helper specific assumptions
> > > > from check_func_arg_reg_off, making it generic, and offloading checks
> > > > for a specific argument type to their respective functions called after
> > > > check_func_arg_reg_off has been called.
> > >
> > > What's the point of check_func_arg_reg_off() if helpers have to check
> > > offsets after it's been called? Also, in [0], there's now logic in
> > > check_func_arg_reg_off() which checks for OBJ_RELEASE arg types, so
> > > there's still a precedent for looking at arg types there. IMO it's
> > > actually less confusing to just push as much offset checking as possible
> > > into one place.
> > >
> >
> > I think you need to define 'as much offset checking'.
>
> We certainly don't want to make check_func_arg_reg_off() a monster
> function, but I think we can do better in terms of making the verifier
> consistent and easier to reason about by pushing more logic into it.
>
> My view (subject to change upon learning new context I may be missing)
> is that the job of check_func_arg_reg_off() should be to map all
> (reg_type x arg_type) combinations to checking the correct offset,
> likely by calling __check_ptr_off_reg() with the correct arguments. The
> signature / implementation of __check_ptr_off_reg() may need to change
> for that to happen, and we may need to e.g. also leverage
> __check_mem_access() to accommodate the mem register types.
>
> Yes, doing this may cause check_func_arg_reg_off() to have a potentially
> very large switch statement (though there are other ways to address
> that), but isn't that preferable to having to read through hundreds or
> thousands of lines of verifier code to convince yourself that an offset
> was correctly determined for every possible (register x arg_type)?
> Having all of that contained in one, well-defined spot seems much
> simpler. Please let me know if I've grossly misunderstood something, or
> am missing important / relevant context.
>
> > Consider process_kptr_func, it requires var_off to be constant. Same for
>
> IMO that check should certainly go in check_func_arg_reg_off().
> __check_ptr_off_reg() already checks for tnum_is_const(reg->var_off) in
> __check_ptr_off_reg(), and check_func_arg_reg_off() has all the
> information it needs to encapsulate the logic for that check.
>

I think this will be a bigger change that should be probably go in on its own,
since you've expressed in the reply to patch 4 that you intend to discuss this
with Daniel, I'm respinning without this for now.

> > bpf_timer, bpf_spin_lock, bpf_list_head, bpf_list_node, etc. They take
> > PTR_TO_MAP_VALUE, PTR_TO_BTF_ID, PTR_TO_BTF_ID | MEM_ALLOC. Should we move all
> > of that into check_func_arg_reg_off?
> >
> > Some argument types like ARG_PTR_TO_MEM are ok with variable offset, should that
> > exception go in this function as well?
> >
> > Where do you draw the line here in terms of what that function does?
>
> Personally I think "drawing the line" is the wrong way to think about
> it. We need to decide what role the function plays, and generalize it in
> a way that's consistent and clear. IMO its role at a high level should
> be, "The verify arg / register offsets step in the verifier". If you
> break that encapsulation, it becomes much more difficult to build a
> consistent mental model of what the verifier is doing. Note that this
> applies to other verification steps as well, such as e.g. verifying
> types, verifying proper refcounts, etc. Perhaps I'm grossly naive for
> thinking this is possible? Please let me know if you think that's the
> case.
>
> Anyways, it might not be possible to aggregate all logic for checking
> reg->off into the function in the codebase as it exists today, but it
> seems like a desirable end-state, and it feels like a step backwards to
> start selectively moving reg->off checking out of
> check_func_arg_reg_off() and into arg / helper specific functions.
>
> > IMO, there are a certain set of properties that check_func_arg_reg_off provides,
> > you could say that if each register type was a class, then the checks there
> > would be what you would do while constructing them on calling:
> >
> > PtrToStack(off, var_off /* can be const or variable */)
> > PtrToMapValue(off, var_off /* can be const or variable */)
> > PtrToBtfId(off /* must be >= 0 */) /* no var_off */
>
> Hmmm, but these are all just reg_type, right? Why are we checking
> OBJ_RELEASE in check_func_arg_reg_off() if that's the case?
>

Probably for the same reason we handle meta->release_regno in a unified manner
for all helpers. Earlier OBJ_RELEASE was not an arg_type, but a list of func_ids
matched in a function, so in that sense it had nothing to do with the arg type
until then.

> > How they get used by each helper and what further checks each helper needs to do
> > on them based on the arg_type should be done at a later stage when the specific
> > argument type is processed.
>
> I definitely agree that there may be helper-specific verification that
> needs to be done. We're talking about arg_type and reg_type, though.
> Those aren't specific to an _individual_ helper (though yes, of course
> arg_types are specific to whatever _sets_ of helpers take them, such as
> e.g. dynptrs).
>
> If we go with the approach of having individual arg types or sets of
> helpers verify offsets, I think that still needs to be generalized so
> that it's happening in a single place. This would involve something
> like:
>
> 1. Having check_func_arg_reg_off() as it exists today be renamed to
> check_func_reg_off(), and be solely responsible for checking reg_type.
>
> 2. Update check_func_arg_reg_off() to contain all the logic which does
> actual arg type checking, possibly calling out to one of many possible
> helper functions depending on the arg type.
>
> My main issue is really just the fact that all of this logic is
> scattered throughout the verifier.
>

I think it's a difference of opinion. I guess it's fine to move all offset
related checks to this function, for every arg_type and every single case as
well, but then it should be part of a bigger change that it does for all of the
existing cases, not just limited to ARG_PTR_TO_{DYNPTR, KPTR, SPIN_LOCK, TIMER}
etc. It will be a bigger refactoring that rearranges and puts all those checks
in a single place, which I think should be done later as its own set.

Though you might end up duplicating some checks because the verification path
from insns won't call check_func_arg_reg_off, but those shared functions are
called from both insns and helpers side, so the checks would need to remain
there unless this refactored function is called for each insn (in which case it
would need to check based on insn type as well). So I might be wrong but there
won't be a lot of code reduction without more involved refactorings.
