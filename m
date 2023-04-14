Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAC66E1C27
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 08:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDNGDN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 02:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNGDM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 02:03:12 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FA03C03
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 23:03:10 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fbee98814so78361577b3.8
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 23:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681452190; x=1684044190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evuk1/8ztC17fBGzjxutGF4lApuz7awJbMQtxO/Pxd0=;
        b=LKkhi/xEnNf7qAkmeO8Y/cD3ycWUi6apnsINbRX607MWb1d1Lrd+gGmfYHaRD6gu1W
         E1WdklRN/mu5Znx2YtyxrcAMxAT4djDNHP5n61o5bdQg6CG2ZqRn6FcSTgOylTBjDSoj
         I7DUBqnZPv8gT96qteAnRe1Qd7nu8o9mC7pwg4kIQ6Vs2Bp5z4BLura8sq3VdEPCuT3k
         2n7TmI302g9VYIGnaXVgOzo7WBg/nrd+kEnZsfpg8vmHD/v0YjIAkR0OkufgqvuwlOHX
         PRfVA86fYHM80X/7sGe9NrkIoiq+XO15BZwCIoHDEMO/5bygD1BrBciik5TZEhLjA9XN
         J6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681452190; x=1684044190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evuk1/8ztC17fBGzjxutGF4lApuz7awJbMQtxO/Pxd0=;
        b=IzL9iB1Hn3+xmQPRBA20KfYIV4rQ5EaOY7Ub4RloWcERI0GU6sekKXxey+FuADuOQh
         Kd9Huj+qO2HZCsoChfU8q1RQrOHGKvRPlaGn/Efh3OP/rNyVZOau4aE+Y7jmjJu0p/q5
         MutQt5LRqzrdgEbo6Asj0ttzcjC9ozKYY8+0F0Jrb25AOCzhMWvISxVZe+mjjKaM477i
         i5BnzhwzH5fe4sMBZpyrSF9wILfV6kgnhOvCuI30FspTYsaC8+s/RKXTJtFzLpiwCy6k
         FhSNdcQkpyTu40FaCjjF+DIBY6oDjUX5Xs7PHq/YXa4PWE61fWyZAjWcf3ZkWg3RQf9a
         l6Xw==
X-Gm-Message-State: AAQBX9e6fxweC/Oei/HPd/211oXwdEUvxxycGyNA0jbZ7i4cga5p/yk7
        YpdbiNQCeH2OrZisipHPYh770eMI3/3UAl2to0oDSEuMBRHtEg==
X-Google-Smtp-Source: AKy350YLTBsPsc3vvdWwhZcOqEaBZMZUq9QTjmkvCFOO5YnTryPrYiaLJLTMvpB7aIxlFBZePeaQE4CZD5jc6UaGFXI=
X-Received: by 2002:a81:b702:0:b0:544:b9b2:5c32 with SMTP id
 v2-20020a81b702000000b00544b9b25c32mr2870071ywh.7.1681452189659; Thu, 13 Apr
 2023 23:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
 <20230409033431.3992432-5-joannelkoong@gmail.com> <CAEf4BzZXgY3nZEPvAFhx3xd_uieDcpeQOBMYAUGDxrSnBEL+3w@mail.gmail.com>
In-Reply-To: <CAEf4BzZXgY3nZEPvAFhx3xd_uieDcpeQOBMYAUGDxrSnBEL+3w@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 13 Apr 2023 23:02:58 -0700
Message-ID: <CAJnrk1b+FsAUHneWdyarMs6kwd8CBNFi9s7n38KXQ2uF+NkvTw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 4/5] bpf: Add bpf_dynptr_clone
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 3:12=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > The cloned dynptr will point to the same data as its parent dynptr,
> > with the same type, offset, size and read-only properties.
> >
> > Any writes to a dynptr will be reflected across all instances
> > (by 'instance', this means any dynptrs that point to the same
> > underlying data).
> >
> > Please note that data slice and dynptr invalidations will affect all
> > instances as well. For example, if bpf_dynptr_write() is called on an
> > skb-type dynptr, all data slices of dynptr instances to that skb
> > will be invalidated as well (eg data slices of any clones, parents,
> > grandparents, ...). Another example is if a ringbuf dynptr is submitted=
,
> > any instance of that dynptr will be invalidated.
> >
> > Changing the view of the dynptr (eg advancing the offset or
> > trimming the size) will only affect that dynptr and not affect any
> > other instances.
> >
> > One example use case where cloning may be helpful is for hashing or
> > iterating through dynptr data. Cloning will allow the user to maintain
> > the original view of the dynptr for future use, while also allowing
> > views to smaller subsets of the data after the offset is advanced or th=
e
> > size is trimmed.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  kernel/bpf/helpers.c  |  14 +++++
> >  kernel/bpf/verifier.c | 125 +++++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 126 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index bac4c6fe49f0..108f3bcfa6da 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2351,6 +2351,19 @@ __bpf_kfunc __u32 bpf_dynptr_get_offset(const st=
ruct bpf_dynptr_kern *ptr)
> >         return ptr->offset;
> >  }
> >
> > +__bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
> > +                                struct bpf_dynptr_kern *clone__uninit)
>
> I think most of uses for bpf_dynptr_clone() would be to get a partial
> view (like you mentioned above, to, e.g., do a hashing of a part of
> the memory range). So it feels it would be best UX if clone would
> allow you to define a new range in one go. So e.g., to create a
> "sub-dynptr" for range of bytes [10, 30), it should be enough to:
>
> struct bpf_dynptr orig_ptr, new_ptr;
>
> bpf_dynptr_clone(&orig_ptr, 10, 30, &new_ptr);
>
> Instead of:
>
> bpf_dynptr_clone(&orig_ptr, &new_ptr);
> bpf_dynptr_advance(&new_ptr, 10);
> bpf_dynptr_trim(&new_ptr, bpf_dynptr_get_size(&orig_ptr) - 30);
>

I don't think we can do this because we can't have bpf_dynptr_clone()
fail (which might happen if we take in a range, if the range is
invalid). This is because in the case where the clone is of a
reference-counted dynptr (eg like a ringbuf-type dynptr), the clone
even if it's invalid must be treated by the verifier as a legit dynptr
(since the verifier can't know ahead of time whether the clone call
will succeed or not) which means if the invalid clone dynptr is then
passed into a reference-releasing function, the verifier will release
the reference but the actual reference won't be released at runtime
(since the clone dynptr is invalid), which would leak the reference.
An example is something like:

 // invalid range is passed, error is returned and new_ptr is invalid
bpf_dynptr_clone(&ringbuf_ptr, 9999999, 9999999, &new_ptr);
// this releases the reference and invalidates both new_ptr and ringbuf_ptr
bpf_ringbuf_discard_dynptr(&new_ptr, 0);

At runtime, bpf_ringbuf_discard_dynptr() will be a no-op since new_ptr
is invalid - the ringbuf record still needs to be submitted/discarded,
but the verifier will think this already happened

>
> This, btw, shows the awkwardness of the bpf_dynptr_trim() approach.
>
> If someone really wanted an exact full-sized copy, it's trivial:
>
> bpf_dynptr_clone(&orig_ptr, 0, bpf_dynptr_get_size(&orig_ptr), &new_ptr);
>
>
> BTW, let's rename bpf_dynptr_get_size -> bpf_dynptr_size()? That
> "get_" is a sore in the eye, IMO.

Will do!
>
>
> > +{
> > +       if (!ptr->data) {
> > +               bpf_dynptr_set_null(clone__uninit);
> > +               return -EINVAL;
> > +       }
> > +
> > +       memcpy(clone__uninit, ptr, sizeof(*clone__uninit));
>
> why memcpy instead of `*clone__uninit =3D *ptr`?
>
No good reason :) I'll change this for v2
> > +
> > +       return 0;
> > +}
> > +
> >  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> >  {
> >         return obj;
> > @@ -2429,6 +2442,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >  BTF_ID_FLAGS(func, bpf_dynptr_get_size)
> >  BTF_ID_FLAGS(func, bpf_dynptr_get_offset)
> > +BTF_ID_FLAGS(func, bpf_dynptr_clone)
> >  BTF_SET8_END(common_btf_ids)
> >
> >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 3660b573048a..804cb50050f9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -302,6 +302,7 @@ struct bpf_kfunc_call_arg_meta {
> >         struct {
> >                 enum bpf_dynptr_type type;
> >                 u32 id;
> > +               u32 ref_obj_id;
> >         } initialized_dynptr;
> >         struct {
> >                 u8 spi;
> > @@ -963,24 +964,15 @@ static int mark_stack_slots_dynptr(struct bpf_ver=
ifier_env *env, struct bpf_reg_
> >         return 0;
> >  }
> >
> > -static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg)
> > +static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf=
_func_state *state, int spi)
> >  {
> > -       struct bpf_func_state *state =3D func(env, reg);
> > -       int spi, i;
> > -
> > -       spi =3D dynptr_get_spi(env, reg);
> > -       if (spi < 0)
> > -               return spi;
> > +       int i;
> >
> >         for (i =3D 0; i < BPF_REG_SIZE; i++) {
> >                 state->stack[spi].slot_type[i] =3D STACK_INVALID;
> >                 state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
> >         }
> >
> > -       /* Invalidate any slices associated with this dynptr */
> > -       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr=
.type))
> > -               WARN_ON_ONCE(release_reference(env, state->stack[spi].s=
pilled_ptr.ref_obj_id));
> > -
> >         __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> >         __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> >
> > @@ -1007,6 +999,51 @@ static int unmark_stack_slots_dynptr(struct bpf_v=
erifier_env *env, struct bpf_re
> >          */
> >         state->stack[spi].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
> >         state->stack[spi - 1].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
> > +}
> > +
> > +static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg)
> > +{
> > +       struct bpf_func_state *state =3D func(env, reg);
> > +       int spi;
> > +
> > +       spi =3D dynptr_get_spi(env, reg);
> > +       if (spi < 0)
> > +               return spi;
> > +
> > +       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr=
.type)) {
> > +               int ref_obj_id =3D state->stack[spi].spilled_ptr.ref_ob=
j_id;
> > +               int i;
> > +
> > +               /* If the dynptr has a ref_obj_id, then we need to inva=
ldiate
>
> typo: invalidate
>
> > +                * two things:
> > +                *
> > +                * 1) Any dynptrs with a matching ref_obj_id (clones)
> > +                * 2) Any slices associated with the ref_obj_id
>
> I think this is where this dynptr_id confusion comes from. The rule
> should be "any slices derived from this dynptr". But as mentioned on
> another thread, it's a separate topic which we can address later.
>
If there's a parent and a clone and slices derived from the parent and
slices derived from the clone, if the clone is invalidated then we
need to invalidate slices associated with the parent as well. So
shouldn't it be "any slices associated with the ref obj id" not "any
slices derived from this dynptr"? (also just a note, parent/clone
slices will share the same ref obj id and the same dynptr id, so
checking against either does the same thing)

> > +                */
> > +
> > +               /* Invalidate any slices associated with this dynptr */
> > +               WARN_ON_ONCE(release_reference(env, ref_obj_id));
> > +
> > +               /* Invalidate any dynptr clones */
> > +               for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE=
; i++) {
> > +                       if (state->stack[i].spilled_ptr.ref_obj_id =3D=
=3D ref_obj_id) {
>
> nit: invert if condition and continue to reduce nestedness of the rest
> the loop body

Ooh good idea
>
> > +                               /* it should always be the case that if=
 the ref obj id
> > +                                * matches then the stack slot also bel=
ongs to a
> > +                                * dynptr
> > +                                */
> > +                               if (state->stack[i].slot_type[0] !=3D S=
TACK_DYNPTR) {
> > +                                       verbose(env, "verifier internal=
 error: misconfigured ref_obj_id\n");
> > +                                       return -EFAULT;
> > +                               }
> > +                               if (state->stack[i].spilled_ptr.dynptr.=
first_slot)
> > +                                       invalidate_dynptr(env, state, i=
);
> > +                       }
> > +               }
> > +
> > +               return 0;
> > +       }
> > +
> > +       invalidate_dynptr(env, state, spi);
> >
> >         return 0;
> >  }
> > @@ -6967,6 +7004,50 @@ static int process_iter_next_call(struct bpf_ver=
ifier_env *env, int insn_idx,
> >         return 0;
> >  }
> >
> > +static int handle_dynptr_clone(struct bpf_verifier_env *env, enum bpf_=
arg_type arg_type,
> > +                              int regno, int insn_idx, struct bpf_kfun=
c_call_arg_meta *meta)
> > +{
> > +       struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[re=
gno];
> > +       struct bpf_reg_state *first_reg_state, *second_reg_state;
> > +       struct bpf_func_state *state =3D func(env, reg);
> > +       enum bpf_dynptr_type dynptr_type =3D meta->initialized_dynptr.t=
ype;
> > +       int err, spi, ref_obj_id;
> > +
> > +       if (!dynptr_type) {
> > +               verbose(env, "verifier internal error: no dynptr type f=
or bpf_dynptr_clone\n");
> > +               return -EFAULT;
> > +       }
> > +       arg_type |=3D get_dynptr_type_flag(dynptr_type);
>
>
> what about MEM_RDONLY and MEM_UNINIT flags, do we need to derive and add =
them?

I don't think we need MEM_UNINIT because we can't clone an
uninitialized dynptr. But yes, definitely MEM_RDONLY. I missed that, I
will add it in in v2

>
> > +
> > +       err =3D process_dynptr_func(env, regno, insn_idx, arg_type);
> > +       if (err < 0)
> > +               return err;
> > +
> > +       spi =3D dynptr_get_spi(env, reg);
> > +       if (spi < 0)
> > +               return spi;
> > +
> > +       first_reg_state =3D &state->stack[spi].spilled_ptr;
> > +       second_reg_state =3D &state->stack[spi - 1].spilled_ptr;
> > +       ref_obj_id =3D first_reg_state->ref_obj_id;
> > +
> > +       /* reassign the clone the same dynptr id as the original */
> > +       __mark_dynptr_reg(first_reg_state, dynptr_type, true, meta->ini=
tialized_dynptr.id);
> > +       __mark_dynptr_reg(second_reg_state, dynptr_type, false, meta->i=
nitialized_dynptr.id);
>
> I'm not sure why clone should have the same dynptr_id? Isn't it a new
> instance of a dynptr? I get preserving ref_obj_id (if refcounted), but
> why reusing dynptr_id?..
>
I think we need to also copy over the dynptr id because in the case of
a non-reference counted dynptr, if the parent (or clone) is
invalidated (eg overwriting bytes of the dynptr on the stack), we must
also invalidate the slices of the clone (or parent)
>
> > +
> > +       if (meta->initialized_dynptr.ref_obj_id) {
> > +               /* release the new ref obj id assigned during process_d=
ynptr_func */
> > +               err =3D release_reference_state(cur_func(env), ref_obj_=
id);
> > +               if (err)
> > +                       return err;
>
> ugh... this is not good to create reference just to release. If we
> need to reuse logic, let's reuse the logic without parts that
> shouldn't happen. Please check if we can split process_dynptr_func()
> appropriately to allow this.

I'll change this for v2. I think the simplest approach would be having
mark_stack_slots_dynptr() take in a boolean or something that'll
indicate whether it should acquire a new reference state or not
>
> > +               /* reassign the clone the same ref obj id as the origin=
al */
> > +               first_reg_state->ref_obj_id =3D meta->initialized_dynpt=
r.ref_obj_id;
> > +               second_reg_state->ref_obj_id =3D meta->initialized_dynp=
tr.ref_obj_id;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
>
> [...]
