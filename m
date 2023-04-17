Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F766E555F
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDQXq3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDQXq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:46:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6219AC
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 16:46:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sz19so11558450ejc.2
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 16:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681775185; x=1684367185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj61Pa4U3r1XEvZTdAJqSIiaBzzVza1jxYLjBJtUigk=;
        b=lS0acnCZHq5vtTtu+JUHSPs0Owlkvhrc18YcTVaQuF3kjWjLK3chgeuIP2JYpIfc6v
         QbHVQm9dX6hizIs9Ob52OdrX5va6kbQz2H3opbdileTcyI6KRNBKUWPPc0g3qTTGldsm
         XAGefSnu4RHW+LB+xm9Yh1VT0krmjMhMahpxoYIZF7xEg5eR9p3i2yRFADLhhnSciUrg
         LUBfmMEGRBWzMlSAqXN4K5tVU1RWbKf4ZScn5XUlz+AHZUXinP+fbwsVXmN4h52Sabrz
         OzvYqHs/AM5s+3q51KjWiE1L7CLidF9ERum/cBdrxBRl6DKDNbMB94lIZl5kEooRFMbH
         hQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681775185; x=1684367185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj61Pa4U3r1XEvZTdAJqSIiaBzzVza1jxYLjBJtUigk=;
        b=GAIUcJEOAUp0gbFcayJRUAcLj4c38pEW2Vi4PN9u6v8T266Pw/7rEGgHGnCKbTFCTS
         3JuJhkJXw5j6vKeF8xcoS1w6V+QTa+CK85NukVNymnliXX9iyxE5xqwpQygCF5PGEjf2
         tf16ScX6Z+72/g9peW7Yb8K0oUvIV07lEsYDqCRQqL24AQaL72Y3MdV5mBeCOnwumLiX
         UUGOhZjlbUpnWwJ3vZUkkeV5czJIdwc4dOUzynFhmOrCB78YOd+65BroO6Hvdxipt4zI
         Ns0uKNtckGtoj3ltmOHyVqMZwLZGImPK58YlBQHdpGqTXvQtT/P9uFNMXTbDJgSBA2Tg
         y3tw==
X-Gm-Message-State: AAQBX9eW9Juh3wrpbF644ynWBfanhrsYQx93X3ok+3XrirxmgJiQXvV3
        RcNMGN/ZzNMeJjUOsD+HoZHW4ShohEBui0hjOMQ=
X-Google-Smtp-Source: AKy350Z1MMXR2fsCubsBsCY7DZg1Hgu6C4/IXpRPS3GTaESKQO+hIZnatDQBDd/UJSr7S3IWX+0ph0hTKkHzjYBMdIU=
X-Received: by 2002:a17:906:860e:b0:94e:c062:4a8f with SMTP id
 o14-20020a170906860e00b0094ec0624a8fmr4433988ejx.5.1681775185279; Mon, 17 Apr
 2023 16:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
 <20230409033431.3992432-5-joannelkoong@gmail.com> <CAEf4BzZXgY3nZEPvAFhx3xd_uieDcpeQOBMYAUGDxrSnBEL+3w@mail.gmail.com>
 <CAJnrk1b+FsAUHneWdyarMs6kwd8CBNFi9s7n38KXQ2uF+NkvTw@mail.gmail.com>
In-Reply-To: <CAJnrk1b+FsAUHneWdyarMs6kwd8CBNFi9s7n38KXQ2uF+NkvTw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Apr 2023 16:46:13 -0700
Message-ID: <CAEf4BzZPUmcSAPwtgVRebCDWccaU6EC3yHt99Asm=akoewbBEA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 4/5] bpf: Add bpf_dynptr_clone
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 11:03=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Wed, Apr 12, 2023 at 3:12=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> > >
> > > The cloned dynptr will point to the same data as its parent dynptr,
> > > with the same type, offset, size and read-only properties.
> > >
> > > Any writes to a dynptr will be reflected across all instances
> > > (by 'instance', this means any dynptrs that point to the same
> > > underlying data).
> > >
> > > Please note that data slice and dynptr invalidations will affect all
> > > instances as well. For example, if bpf_dynptr_write() is called on an
> > > skb-type dynptr, all data slices of dynptr instances to that skb
> > > will be invalidated as well (eg data slices of any clones, parents,
> > > grandparents, ...). Another example is if a ringbuf dynptr is submitt=
ed,
> > > any instance of that dynptr will be invalidated.
> > >
> > > Changing the view of the dynptr (eg advancing the offset or
> > > trimming the size) will only affect that dynptr and not affect any
> > > other instances.
> > >
> > > One example use case where cloning may be helpful is for hashing or
> > > iterating through dynptr data. Cloning will allow the user to maintai=
n
> > > the original view of the dynptr for future use, while also allowing
> > > views to smaller subsets of the data after the offset is advanced or =
the
> > > size is trimmed.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  kernel/bpf/helpers.c  |  14 +++++
> > >  kernel/bpf/verifier.c | 125 +++++++++++++++++++++++++++++++++++++---=
--
> > >  2 files changed, 126 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index bac4c6fe49f0..108f3bcfa6da 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -2351,6 +2351,19 @@ __bpf_kfunc __u32 bpf_dynptr_get_offset(const =
struct bpf_dynptr_kern *ptr)
> > >         return ptr->offset;
> > >  }
> > >
> > > +__bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
> > > +                                struct bpf_dynptr_kern *clone__unini=
t)
> >
> > I think most of uses for bpf_dynptr_clone() would be to get a partial
> > view (like you mentioned above, to, e.g., do a hashing of a part of
> > the memory range). So it feels it would be best UX if clone would
> > allow you to define a new range in one go. So e.g., to create a
> > "sub-dynptr" for range of bytes [10, 30), it should be enough to:
> >
> > struct bpf_dynptr orig_ptr, new_ptr;
> >
> > bpf_dynptr_clone(&orig_ptr, 10, 30, &new_ptr);
> >
> > Instead of:
> >
> > bpf_dynptr_clone(&orig_ptr, &new_ptr);
> > bpf_dynptr_advance(&new_ptr, 10);
> > bpf_dynptr_trim(&new_ptr, bpf_dynptr_get_size(&orig_ptr) - 30);
> >
>
> I don't think we can do this because we can't have bpf_dynptr_clone()
> fail (which might happen if we take in a range, if the range is
> invalid). This is because in the case where the clone is of a
> reference-counted dynptr (eg like a ringbuf-type dynptr), the clone
> even if it's invalid must be treated by the verifier as a legit dynptr
> (since the verifier can't know ahead of time whether the clone call
> will succeed or not) which means if the invalid clone dynptr is then
> passed into a reference-releasing function, the verifier will release
> the reference but the actual reference won't be released at runtime
> (since the clone dynptr is invalid), which would leak the reference.
> An example is something like:
>
>  // invalid range is passed, error is returned and new_ptr is invalid
> bpf_dynptr_clone(&ringbuf_ptr, 9999999, 9999999, &new_ptr);
> // this releases the reference and invalidates both new_ptr and ringbuf_p=
tr
> bpf_ringbuf_discard_dynptr(&new_ptr, 0);
>
> At runtime, bpf_ringbuf_discard_dynptr() will be a no-op since new_ptr
> is invalid - the ringbuf record still needs to be submitted/discarded,
> but the verifier will think this already happened

Ah, tricky, good point. But ok, I guess with bpf_dynptr_adjust()
proposal in another email this would be ok:

bpf_dynptr_clone(..); /* always succeeds */
bpf_dynptr_adjust(&new_ptr, 10, 30); /* could fail to adjust, but
dynptr is left valid */

Right?

>
> >
> > This, btw, shows the awkwardness of the bpf_dynptr_trim() approach.
> >
> > If someone really wanted an exact full-sized copy, it's trivial:
> >
> > bpf_dynptr_clone(&orig_ptr, 0, bpf_dynptr_get_size(&orig_ptr), &new_ptr=
);
> >
> >
> > BTW, let's rename bpf_dynptr_get_size -> bpf_dynptr_size()? That
> > "get_" is a sore in the eye, IMO.
>
> Will do!
> >
> >
> > > +{
> > > +       if (!ptr->data) {
> > > +               bpf_dynptr_set_null(clone__uninit);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       memcpy(clone__uninit, ptr, sizeof(*clone__uninit));
> >
> > why memcpy instead of `*clone__uninit =3D *ptr`?
> >
> No good reason :) I'll change this for v2
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> > >  {
> > >         return obj;
> > > @@ -2429,6 +2442,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> > >  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> > >  BTF_ID_FLAGS(func, bpf_dynptr_get_size)
> > >  BTF_ID_FLAGS(func, bpf_dynptr_get_offset)
> > > +BTF_ID_FLAGS(func, bpf_dynptr_clone)
> > >  BTF_SET8_END(common_btf_ids)
> > >
> > >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 3660b573048a..804cb50050f9 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -302,6 +302,7 @@ struct bpf_kfunc_call_arg_meta {
> > >         struct {
> > >                 enum bpf_dynptr_type type;
> > >                 u32 id;
> > > +               u32 ref_obj_id;
> > >         } initialized_dynptr;
> > >         struct {
> > >                 u8 spi;
> > > @@ -963,24 +964,15 @@ static int mark_stack_slots_dynptr(struct bpf_v=
erifier_env *env, struct bpf_reg_
> > >         return 0;
> > >  }
> > >
> > > -static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, s=
truct bpf_reg_state *reg)
> > > +static void invalidate_dynptr(struct bpf_verifier_env *env, struct b=
pf_func_state *state, int spi)
> > >  {
> > > -       struct bpf_func_state *state =3D func(env, reg);
> > > -       int spi, i;
> > > -
> > > -       spi =3D dynptr_get_spi(env, reg);
> > > -       if (spi < 0)
> > > -               return spi;
> > > +       int i;
> > >
> > >         for (i =3D 0; i < BPF_REG_SIZE; i++) {
> > >                 state->stack[spi].slot_type[i] =3D STACK_INVALID;
> > >                 state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
> > >         }
> > >
> > > -       /* Invalidate any slices associated with this dynptr */
> > > -       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynp=
tr.type))
> > > -               WARN_ON_ONCE(release_reference(env, state->stack[spi]=
.spilled_ptr.ref_obj_id));
> > > -
> > >         __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> > >         __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> > >
> > > @@ -1007,6 +999,51 @@ static int unmark_stack_slots_dynptr(struct bpf=
_verifier_env *env, struct bpf_re
> > >          */
> > >         state->stack[spi].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
> > >         state->stack[spi - 1].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
> > > +}
> > > +
> > > +static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, s=
truct bpf_reg_state *reg)
> > > +{
> > > +       struct bpf_func_state *state =3D func(env, reg);
> > > +       int spi;
> > > +
> > > +       spi =3D dynptr_get_spi(env, reg);
> > > +       if (spi < 0)
> > > +               return spi;
> > > +
> > > +       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynp=
tr.type)) {
> > > +               int ref_obj_id =3D state->stack[spi].spilled_ptr.ref_=
obj_id;
> > > +               int i;
> > > +
> > > +               /* If the dynptr has a ref_obj_id, then we need to in=
valdiate
> >
> > typo: invalidate
> >
> > > +                * two things:
> > > +                *
> > > +                * 1) Any dynptrs with a matching ref_obj_id (clones)
> > > +                * 2) Any slices associated with the ref_obj_id
> >
> > I think this is where this dynptr_id confusion comes from. The rule
> > should be "any slices derived from this dynptr". But as mentioned on
> > another thread, it's a separate topic which we can address later.
> >
> If there's a parent and a clone and slices derived from the parent and
> slices derived from the clone, if the clone is invalidated then we
> need to invalidate slices associated with the parent as well. So
> shouldn't it be "any slices associated with the ref obj id" not "any
> slices derived from this dynptr"? (also just a note, parent/clone
> slices will share the same ref obj id and the same dynptr id, so
> checking against either does the same thing)

So, we have a ringbuf dynptr with ref_obj_id=3D1, id=3D2, ok? We clone it,
clone gets ref_obj_id=3D1, id=3D3. If either original dynptr or clone
dynptr is released due to bpf_ringbuf_discard_dynptr(), we invalidate
all the dynptrs with ref_obj_id=3D1. During invalidation of each dynptr,
we invalidate all the slices with ref_obj_id=3D=3Ddynptr's id. So we'll
invalidate slices derived from dynptr with id=3D2 (original dynptr), and
then all the slices derived from dynptr with id=3D3?

>
> > > +                */
> > > +
> > > +               /* Invalidate any slices associated with this dynptr =
*/
> > > +               WARN_ON_ONCE(release_reference(env, ref_obj_id));
> > > +
> > > +               /* Invalidate any dynptr clones */
> > > +               for (i =3D 1; i < state->allocated_stack / BPF_REG_SI=
ZE; i++) {
> > > +                       if (state->stack[i].spilled_ptr.ref_obj_id =
=3D=3D ref_obj_id) {
> >
> > nit: invert if condition and continue to reduce nestedness of the rest
> > the loop body
>
> Ooh good idea
> >
> > > +                               /* it should always be the case that =
if the ref obj id
> > > +                                * matches then the stack slot also b=
elongs to a
> > > +                                * dynptr
> > > +                                */
> > > +                               if (state->stack[i].slot_type[0] !=3D=
 STACK_DYNPTR) {
> > > +                                       verbose(env, "verifier intern=
al error: misconfigured ref_obj_id\n");
> > > +                                       return -EFAULT;
> > > +                               }
> > > +                               if (state->stack[i].spilled_ptr.dynpt=
r.first_slot)
> > > +                                       invalidate_dynptr(env, state,=
 i);
> > > +                       }
> > > +               }
> > > +
> > > +               return 0;
> > > +       }
> > > +
> > > +       invalidate_dynptr(env, state, spi);
> > >
> > >         return 0;
> > >  }
> > > @@ -6967,6 +7004,50 @@ static int process_iter_next_call(struct bpf_v=
erifier_env *env, int insn_idx,
> > >         return 0;
> > >  }
> > >
> > > +static int handle_dynptr_clone(struct bpf_verifier_env *env, enum bp=
f_arg_type arg_type,
> > > +                              int regno, int insn_idx, struct bpf_kf=
unc_call_arg_meta *meta)
> > > +{
> > > +       struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[=
regno];
> > > +       struct bpf_reg_state *first_reg_state, *second_reg_state;
> > > +       struct bpf_func_state *state =3D func(env, reg);
> > > +       enum bpf_dynptr_type dynptr_type =3D meta->initialized_dynptr=
.type;
> > > +       int err, spi, ref_obj_id;
> > > +
> > > +       if (!dynptr_type) {
> > > +               verbose(env, "verifier internal error: no dynptr type=
 for bpf_dynptr_clone\n");
> > > +               return -EFAULT;
> > > +       }
> > > +       arg_type |=3D get_dynptr_type_flag(dynptr_type);
> >
> >
> > what about MEM_RDONLY and MEM_UNINIT flags, do we need to derive and ad=
d them?
>
> I don't think we need MEM_UNINIT because we can't clone an
> uninitialized dynptr. But yes, definitely MEM_RDONLY. I missed that, I
> will add it in in v2
>
> >
> > > +
> > > +       err =3D process_dynptr_func(env, regno, insn_idx, arg_type);
> > > +       if (err < 0)
> > > +               return err;
> > > +
> > > +       spi =3D dynptr_get_spi(env, reg);
> > > +       if (spi < 0)
> > > +               return spi;
> > > +
> > > +       first_reg_state =3D &state->stack[spi].spilled_ptr;
> > > +       second_reg_state =3D &state->stack[spi - 1].spilled_ptr;
> > > +       ref_obj_id =3D first_reg_state->ref_obj_id;
> > > +
> > > +       /* reassign the clone the same dynptr id as the original */
> > > +       __mark_dynptr_reg(first_reg_state, dynptr_type, true, meta->i=
nitialized_dynptr.id);
> > > +       __mark_dynptr_reg(second_reg_state, dynptr_type, false, meta-=
>initialized_dynptr.id);
> >
> > I'm not sure why clone should have the same dynptr_id? Isn't it a new
> > instance of a dynptr? I get preserving ref_obj_id (if refcounted), but
> > why reusing dynptr_id?..
> >
> I think we need to also copy over the dynptr id because in the case of
> a non-reference counted dynptr, if the parent (or clone) is
> invalidated (eg overwriting bytes of the dynptr on the stack), we must
> also invalidate the slices of the clone (or parent)

yep, right now we'll have to do that because we have dynptr_id. But if
we get rid of it and stick to ref_obj_id and id, then clone would need
to get a new id, but keep ref_obj_id, right?

> >
> > > +
> > > +       if (meta->initialized_dynptr.ref_obj_id) {
> > > +               /* release the new ref obj id assigned during process=
_dynptr_func */
> > > +               err =3D release_reference_state(cur_func(env), ref_ob=
j_id);
> > > +               if (err)
> > > +                       return err;
> >
> > ugh... this is not good to create reference just to release. If we
> > need to reuse logic, let's reuse the logic without parts that
> > shouldn't happen. Please check if we can split process_dynptr_func()
> > appropriately to allow this.
>
> I'll change this for v2. I think the simplest approach would be having
> mark_stack_slots_dynptr() take in a boolean or something that'll
> indicate whether it should acquire a new reference state or not
> >
> > > +               /* reassign the clone the same ref obj id as the orig=
inal */
> > > +               first_reg_state->ref_obj_id =3D meta->initialized_dyn=
ptr.ref_obj_id;
> > > +               second_reg_state->ref_obj_id =3D meta->initialized_dy=
nptr.ref_obj_id;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> >
> > [...]
