Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC363098B1
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 23:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhA3W43 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jan 2021 17:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3W43 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jan 2021 17:56:29 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3772C061573
        for <bpf@vger.kernel.org>; Sat, 30 Jan 2021 14:55:48 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id p8so12071419ilg.3
        for <bpf@vger.kernel.org>; Sat, 30 Jan 2021 14:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goUywacmnhii+s3t7UTYfrLFm5QGiLQ4zxgLfh7RotY=;
        b=dfko77tPS1BBoE+ugWg1XbGrkk9vtprnx94C2J3DzQzC0TXORY3vYyjrLiV0PqTCeV
         dD46YMl3ffl+T/hUsYgdoW/G48gZisbdsjAryFfS26+1Gzf9sq7HGK2oVyKtavlclNiE
         djZZNepsT5Msv0CyjzW8lGOgCTKChwYzlhD6MNdARfFUpaiN3ZGbwpKxXeOowLUQW5RJ
         jVzCly4OOAI+3bQIuhQSdLQ/sLURi8SaAzMzhPoKHGE+pDTO4sAgOaJX6+sG5zoyJ4st
         jN2I0GS3Rn35WM7QLn0jJ+H86K6d1d8bNnBs5IU6bFxiSsT91dVwiz2VQdS76jKnr74u
         jm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goUywacmnhii+s3t7UTYfrLFm5QGiLQ4zxgLfh7RotY=;
        b=GI5Wyul4i5nr562TGm0WdEulJllc/ui2EoKKXmK4qvuNoI09TswKYv6l+o8E+fBvkj
         Tx5jngVEaDW9jty2AfECxwzx+53JWylm+skJiqa4QizXQS2XQRFGkreWdFhBjB9QkLkx
         pXiTe9PWidWFtFK+n7tYdQwUEY5XuqnZyBeThtTzukIU51l/kmY2RIx6pJuDi+0fxx58
         QIVjqONKnilCDJlMKTW5OyDOUabMXJ38pdp3EwD3sztbTilODlHMI7GkiytO8Q1m8pYB
         cHVGLy3GqqcNgwGjjlNAQArDRUiyGIMHDxoEiVC+WOjrYTujQJa1uX38j2ssiTDxEvht
         wkMA==
X-Gm-Message-State: AOAM531ekI++8Qo55eLYXPjKur+2yAEc2wDoP9U1kCkfXjeOBvK9O0Pu
        X6V+Cgi9LH7HTcb7QFvyO+621OgdKGXxRzUIDio=
X-Google-Smtp-Source: ABdhPJzI667+ESuOkQLzoke03zVwBTcTf1ugvHntpADO5lKO7cOqqJsqNOnFk2x8bPF+Bhk+c9cs/pyoYOBF0ZM/IwE=
X-Received: by 2002:a92:a18e:: with SMTP id b14mr2337943ill.120.1612047347883;
 Sat, 30 Jan 2021 14:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20210124194909.453844-1-andreimatei1@gmail.com>
 <20210124194909.453844-2-andreimatei1@gmail.com> <20210127225818.3uzw3tehbu3qlyd6@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210127225818.3uzw3tehbu3qlyd6@ast-mbp.dhcp.thefacebook.com>
From:   Andrei Matei <andreimatei1@gmail.com>
Date:   Sat, 30 Jan 2021 17:55:36 -0500
Message-ID: <CABWLsetKoJ033hbaOxGKmv6jsWEvXebr3fpXxj9itW7yP7XqOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: allow variable-offset stack access
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for reviewing this!

On Wed, Jan 27, 2021 at 5:58 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Jan 24, 2021 at 02:49:05PM -0500, Andrei Matei wrote:
> > + *
> > + * If some stack slots in range are uninitialized (i.e. STACK_INVALID), the
> > + * write is not automatically rejected. However, they are left as
> > + * STACK_INVALID, which means that reads with the same variable offset will be
> > + * rejected.
> ...
> > +             /* If the slot is STACK_INVALID, we leave it as such. We can't
> > +              * mark the slot as initialized, as the slot might not actually
> > +              * be written to (and so marking it as initialized opens the
> > +              * door to leaks of uninitialized stack memory.
> > +              */
> > +             if (*stype != STACK_INVALID)
> > +                     *stype = new_type;
>
> 'leaks of uninitialized stack memory'...
> well that's true, but the way the user would have to deal with this
> is to use __builtin_memset(&buf, 0, 16); for the whole buffer
> before doing var_off write into it.
> In the test in patch 5 would be good to add a read after this write:
> buf[len] = buf[idx];
> // need to do another read of buf[len] here.
>
> Without memset() it would fail and the user would flame us:
> "I just wrote into this stack slot!! Why cannot the verifier figure out
> that the read from the same location is safe?... stupid verifier..."
>
> I think for your use case where you read the whole thing into a stack and
> then parse it all locations potentially touched by reads/writes would
> be already written via helper, but imo this error is too unpleasant to
> explain to users.
> Especially since it happens later at a different instruction there is
> no good verifier hint we can print.
> It would just hit 'invalid read from stack'.
>
> Currently we don't allow uninit read from stack even for root.
> I think we have to sacrifice the perfection of the verification here.
> We can either allow reading uninit for _fixed and _var_off
> or better yet do unconditional '*stype = new_type' here.
> Yes it would mean that following _fixed or _var_off read could be
> reading uninited stack. I think we have to do it for the sake
> of user friendliness.
> The completely buggy uninited reads from stack will still be disallowed.
> Only the [min,max] of var_off range in stack will be considered
> init, so imo it's a reasonable trade-off between user friendliness
> and verifier's perfection.
> Wdyt?

I'm happy to do whatever you tell me. But, I dunno, the verifier
currently seems to be paranoid in ways I don't even understand (around
speculative execution). In comparison, preventing trivial leaks of
uninitialized memory seems relatively important. We're only talking
about root here (as you've noted), and other various checks are less
paranoid for root, so maybe it's no big deal. Where does the stack
memory come from? Can it be *any* previously used kernel memory?
A few possible alternatives (without necessarily knowing what I'm
talking about):
1) Perhaps it wouldn't be a big deal to zero-initialize all the stack
memory (up to 512 bytes) for a program. Is that out of the question?
In many cases it'd be less than 512 bytes; the verifier knows the max
stack needed. If the stack was always initialized, various verifier
checks could go away.
2) We could leave this patch as is, and work on improving the error
you get on rejected stack reads after var-offset stack writes. I think
the verifier could track what stack slots might have or might have not
been written to, and when a read to such an uncertain slot is
rejected, it could point to the previous var-off write (or one of the
possibly many such writes) and suggest a memset. Sounds potentially
complicated though.
3) Perhaps we could augment helper metadata with information about
whether each helper promises to overwrite every byte in the buffer
it's being passed in. This wouldn't solve the general usability
problem we're discussing, but it would make common cases just work.
Namely, bpf_probe_read_user() can make the required promise.
bpf_probe_read_user_str(), however, could not.

But, again, if you think relaxing the verification is OK, I'm very
happy to do that.

>
> > +     }
> > +     if (zero_used) {
> > +             /* backtracking doesn't work for STACK_ZERO yet. */
> > +             err = mark_chain_precision(env, value_regno);
> > +             if (err)
> > +                     return err;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/* When register 'regno' is assigned some values from stack[min_off, max_off),
> > + * we set the register's type according to the types of the respective stack
> > + * slots. If all the stack values are known to be zeros, then so is the
> > + * destination reg. Otherwise, the register is considered to be SCALAR. This
> > + * function does not deal with register filling; the caller must ensure that
> > + * all spilled registers in the stack range have been marked as read.
> > + */
> > +static void mark_reg_stack_read(struct bpf_verifier_env *env,
> > +                             /* func where src register points to */
> > +                             struct bpf_func_state *ptr_state,
> > +                             int min_off, int max_off, int regno)
>
> may be use 'dst_regno' here like you've renamed below?
>
> > -static int check_stack_access(struct bpf_verifier_env *env,
> > -                           const struct bpf_reg_state *reg,
> > -                           int off, int size)
> > +enum stack_access_src {
> > +     ACCESS_DIRECT = 1,  /* the access is performed by an instruction */
> > +     ACCESS_HELPER = 2,  /* the access is performed by a helper */
> > +};
> > +
> > +static int check_stack_range_initialized(struct bpf_verifier_env *env,
> > +                                      int regno, int off, int access_size,
> > +                                      bool zero_size_allowed,
> > +                                      enum stack_access_src type,
> > +                                      struct bpf_call_arg_meta *meta);
> > +
> > +static struct bpf_reg_state *reg_state(struct bpf_verifier_env *env, int regno)
> > +{
> > +     return cur_regs(env) + regno;
> > +}
> > +
> > +/* Read the stack at 'ptr_regno + off' and put the result into the register
> > + * 'dst_regno'.
> > + * 'off' includes the pointer register's fixed offset(i.e. 'ptr_regno.off'),
> > + * but not its variable offset.
> > + * 'size' is assumed to be <= reg size and the access is assumed to be aligned.
> > + *
> > + * As opposed to check_stack_read_fixed_off, this function doesn't deal with
> > + * filling registers (i.e. reads of spilled register cannot be detected when
> > + * the offset is not fixed). We conservatively mark 'dst_regno' as containing
> > + * SCALAR_VALUE. That's why we assert that the 'ptr_regno' has a variable
> > + * offset; for a fixed offset check_stack_read_fixed_off should be used
> > + * instead.
> > + */
> > +static int check_stack_read_var_off(struct bpf_verifier_env *env,
> > +                                 int ptr_regno, int off, int size, int dst_regno)
> >  {
> > -     /* Stack accesses must be at a fixed offset, so that we
> > -      * can determine what type of data were returned. See
> > -      * check_stack_read().
> > +     /* The state of the source register. */
> > +     struct bpf_reg_state *reg = reg_state(env, ptr_regno);
> > +     struct bpf_func_state *ptr_state = func(env, reg);
> > +     int err;
> > +     int min_off, max_off;
> > +
> > +     if (tnum_is_const(reg->var_off)) {
> > +             char tn_buf[48];
> > +
> > +             tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> > +             verbose(env, "%s: fixed stack access illegal: reg=%d var_off=%s off=%d size=%d\n",
> > +                     __func__, ptr_regno, tn_buf, off, size);
> > +             return -EINVAL;
>
> The caller just checked that and this condition can never happen, right?
> What is the point of checking it again?
>
> > +     }
> > +     /* Note that we pass a NULL meta, so raw access will not be permitted.
> >        */
> > -     if (!tnum_is_const(reg->var_off)) {
> > +     err = check_stack_range_initialized(env, ptr_regno, off, size,
> > +                                         false, ACCESS_DIRECT, NULL);
> > +     if (err)
> > +             return err;
> > +
> > +     min_off = reg->smin_value + off;
> > +     max_off = reg->smax_value + off;
> > +     mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
> > +     return 0;
> > +}
> > +
> > +/* check_stack_read dispatches to check_stack_read_fixed_off or
> > + * check_stack_read_var_off.
> > + *
> > + * The caller must ensure that the offset falls within the allocated stack
> > + * bounds.
> > + *
> > + * 'dst_regno' is a register which will receive the value from the stack. It
> > + * can be -1, meaning that the read value is not going to a register.
> > + */
> > +static int check_stack_read(struct bpf_verifier_env *env,
> > +                         int ptr_regno, int off, int size,
> > +                         int dst_regno)
> > +{
> > +     struct bpf_reg_state *reg = reg_state(env, ptr_regno);
> > +     struct bpf_func_state *state = func(env, reg);
> > +     int err;
> > +     /* Some accesses are only permitted with a static offset. */
> > +     bool var_off = !tnum_is_const(reg->var_off);
> > +
> > +     /* The offset is required to be static when reads don't go to a
> > +      * register, in order to not leak pointers (see
> > +      * check_stack_read_fixed_off).
> > +      */
> > +     if (dst_regno < 0 && var_off) {
> >               char tn_buf[48];
> >
> >               tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> > -             verbose(env, "variable stack access var_off=%s off=%d size=%d\n",
> > +             verbose(env, "var-offset stack reads only permitted to register; var_off=%s off=%d size=%d\n",
>
> The message is confusing. "read to register"? what is "read to not register" ?
> Users won't be able to figure out that it means helpers access.
> Also nowadays it means that atomic ops won't be able to use var_off into stack.
> I think both limitations are ok for now. Only the message needs to be clear.

What message would you suggest? Would you plumb information about what
the read type is (helper vs atomic op)?

>
> >                       tn_buf, off, size);
> >               return -EACCES;
> >       }
> > +     /* Variable offset is prohibited for unprivileged mode for simplicity
> > +      * since it requires corresponding support in Spectre masking for stack
> > +      * ALU. See also retrieve_ptr_limit().
> > +      */
> > +     if (!env->bypass_spec_v1 && var_off) {
> > +             char tn_buf[48];
> >
> > -     if (off >= 0 || off < -MAX_BPF_STACK) {
> > -             verbose(env, "invalid stack off=%d size=%d\n", off, size);
> > +             tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> > +             verbose(env, "R%d variable offset stack access prohibited for !root, var_off=%s\n",
> > +                             ptr_regno, tn_buf);
> >               return -EACCES;
> >       }
> >
> > -     return 0;
> > +     if (tnum_is_const(reg->var_off)) {
>
> This is the same as 'bool var_off' variable above. Why not to use it here?
>
> > +             off += reg->var_off.value;
> > +             err = check_stack_read_fixed_off(env, state, off, size,
> > +                                              dst_regno);
> > +     } else {
> > +             /* Variable offset stack reads need more conservative handling
> > +              * than fixed offset ones. Note that dst_regno >= 0 on this
> > +              * branch.
> > +              */
> > +             err = check_stack_read_var_off(env, ptr_regno, off, size,
> > +                                            dst_regno);
> > +     }
> > +     return err;
> > +}
> > +
> > +
> > +/* check_stack_write dispatches to check_stack_write_fixed_off or
> > + * check_stack_write_var_off.
> > + *
> > + * 'ptr_regno' is the register used as a pointer into the stack.
> > + * 'off' includes 'ptr_regno->off', but not its variable offset (if any).
> > + * 'value_regno' is the register whose value we're writing to the stack. It can
> > + * be -1, meaning that we're not writing from a register.
> > + *
> > + * The caller must ensure that the offset falls within the maximum stack size.
> > + */
> > +static int check_stack_write(struct bpf_verifier_env *env,
> > +                          int ptr_regno, int off, int size,
> > +                          int value_regno, int insn_idx)
> > +{
> > +     struct bpf_reg_state *reg = reg_state(env, ptr_regno);
> > +     struct bpf_func_state *state = func(env, reg);
> > +     int err;
> > +
> > +     if (tnum_is_const(reg->var_off)) {
> > +             off += reg->var_off.value;
> > +             err = check_stack_write_fixed_off(env, state, off, size,
> > +                                               value_regno, insn_idx);
> > +     } else {
> > +             /* Variable offset stack reads need more conservative handling
> > +              * than fixed offset ones. Note that value_regno >= 0 on this
> > +              * branch.
>
> I don't understand what the last sentence above means.
> The value_regno can still be == -1 here. It's not a bug.
> It's not handled yet, but it probably should be eventually.
> Please rephrase it.
>
> > +              */
> > +             err = check_stack_write_var_off(env, state,
> > +                                             ptr_regno, off, size,
> > +                                             value_regno, insn_idx);
> > +     }
> > +     return err;
> >  }
> >
> > +/* Check that the stack access at the given offset is within bounds. The
> > + * maximum valid offset is -1.
> > + *
> > + * The minimum valid offset is -MAX_BPF_STACK for writes, and
> > + * -state->allocated_stack for reads.
> > + */
> > +static int check_stack_slot_within_bounds(int off,
> > +                                       struct bpf_func_state *state,
> > +                                       enum bpf_access_type t)
> > +{
> > +     int min_valid_off;
> > +
> > +     if (t == BPF_WRITE)
> > +             min_valid_off = -MAX_BPF_STACK;
> > +     else
> > +             min_valid_off = -state->allocated_stack;
> > +
> > +     if (off < min_valid_off || off > -1)
> > +             return -EACCES;
> > +     return 0;
> > +}
> > +
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
