Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2340F6E01B4
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 00:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDLWMW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 18:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDLWMV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 18:12:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F9C5FD5
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 15:12:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id si1so2406485ejb.10
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681337535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4Sn2efdI8XfIicYgSyCh1YoFXTAtt1SdSiypFyqlgk=;
        b=Y25XbcwCZMiav5xB6prD+RrObcOsuwv8Yfvcw89H2OkkdXKrpQQ0tY1INKZVswd3GW
         /YPWwDE2z/1DXWrzbpKss9OXcStRl77JUlMZpiizlreGgoaButScIEplquIv2X2Qrr+W
         KJQMHWp8aozATys0Ixatj4igSH91dJHloaeZ06+leQWRaOtZNRR/Ztaa5zysGEq2sCcM
         WHsQoIMqGLYq1W4G0ydyzFSeeAf/kj5gX2jlNIDtwZb0I6ASNqUPk2UEU5NVVH8PsEeE
         +O/q8kNszvWNW1karibeiUuHD6n6H/jFeJgtdsEPwb3bT72GqWI48fcOAG4wpy4wvGk7
         hJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681337535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4Sn2efdI8XfIicYgSyCh1YoFXTAtt1SdSiypFyqlgk=;
        b=F4ws+bMdKJpIoiNQsVXh7D0vYvQ6AtWT1qExpaM2dSlEStOgWThOaAQkzG2SQ9KlOY
         ImLyoBZ3viHvIwAV97HFjkn19p2VmNLb6Icj/KNZqVK3jgLt+gAxGW4DdM7X8Vye8UFp
         1581gs32KWIe8JkiKq8oEX6B18wetqn9NAxz9dQH8033eyueKWjfRifLDbekdSkxU8CL
         Um6LM+sQsqfMgQnIGwQDTP8U0F2yM7kzN+KSfcb8i1CWaXmv4DPDoqysFJoKAlbcJBmB
         UYicIZ/Nkw1V5pneJEkLoimtnTN4+zHz5le/0J15Wp1Q8djcfuZWeuSqYX3SxEoOjB/F
         5pgg==
X-Gm-Message-State: AAQBX9dI2YidsR+U+WSOeGzJguhJbbMektVd6KRig7ppJFOaj5aT8LET
        qzCXLN8z41GF+UzJQIXFSJRVCqwY3tHdsjr0dtE=
X-Google-Smtp-Source: AKy350b69diT921wh06qf2wG+qZtIH8lS3ZdtpEHu7fghKZ7LOFjbkF2HWT/8qTUTQ4MJfCAIu7MraFwK7J8mHh5aIA=
X-Received: by 2002:a17:906:15cf:b0:94e:7c3c:77ea with SMTP id
 l15-20020a17090615cf00b0094e7c3c77eamr203054ejd.5.1681337534644; Wed, 12 Apr
 2023 15:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com> <20230409033431.3992432-5-joannelkoong@gmail.com>
In-Reply-To: <20230409033431.3992432-5-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 15:12:02 -0700
Message-ID: <CAEf4BzZXgY3nZEPvAFhx3xd_uieDcpeQOBMYAUGDxrSnBEL+3w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 4/5] bpf: Add bpf_dynptr_clone
To:     Joanne Koong <joannelkoong@gmail.com>
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

On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> The cloned dynptr will point to the same data as its parent dynptr,
> with the same type, offset, size and read-only properties.
>
> Any writes to a dynptr will be reflected across all instances
> (by 'instance', this means any dynptrs that point to the same
> underlying data).
>
> Please note that data slice and dynptr invalidations will affect all
> instances as well. For example, if bpf_dynptr_write() is called on an
> skb-type dynptr, all data slices of dynptr instances to that skb
> will be invalidated as well (eg data slices of any clones, parents,
> grandparents, ...). Another example is if a ringbuf dynptr is submitted,
> any instance of that dynptr will be invalidated.
>
> Changing the view of the dynptr (eg advancing the offset or
> trimming the size) will only affect that dynptr and not affect any
> other instances.
>
> One example use case where cloning may be helpful is for hashing or
> iterating through dynptr data. Cloning will allow the user to maintain
> the original view of the dynptr for future use, while also allowing
> views to smaller subsets of the data after the offset is advanced or the
> size is trimmed.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  kernel/bpf/helpers.c  |  14 +++++
>  kernel/bpf/verifier.c | 125 +++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 126 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index bac4c6fe49f0..108f3bcfa6da 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2351,6 +2351,19 @@ __bpf_kfunc __u32 bpf_dynptr_get_offset(const stru=
ct bpf_dynptr_kern *ptr)
>         return ptr->offset;
>  }
>
> +__bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
> +                                struct bpf_dynptr_kern *clone__uninit)

I think most of uses for bpf_dynptr_clone() would be to get a partial
view (like you mentioned above, to, e.g., do a hashing of a part of
the memory range). So it feels it would be best UX if clone would
allow you to define a new range in one go. So e.g., to create a
"sub-dynptr" for range of bytes [10, 30), it should be enough to:

struct bpf_dynptr orig_ptr, new_ptr;

bpf_dynptr_clone(&orig_ptr, 10, 30, &new_ptr);

Instead of:

bpf_dynptr_clone(&orig_ptr, &new_ptr);
bpf_dynptr_advance(&new_ptr, 10);
bpf_dynptr_trim(&new_ptr, bpf_dynptr_get_size(&orig_ptr) - 30);


This, btw, shows the awkwardness of the bpf_dynptr_trim() approach.

If someone really wanted an exact full-sized copy, it's trivial:

bpf_dynptr_clone(&orig_ptr, 0, bpf_dynptr_get_size(&orig_ptr), &new_ptr);


BTW, let's rename bpf_dynptr_get_size -> bpf_dynptr_size()? That
"get_" is a sore in the eye, IMO.


> +{
> +       if (!ptr->data) {
> +               bpf_dynptr_set_null(clone__uninit);
> +               return -EINVAL;
> +       }
> +
> +       memcpy(clone__uninit, ptr, sizeof(*clone__uninit));

why memcpy instead of `*clone__uninit =3D *ptr`?

> +
> +       return 0;
> +}
> +
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>  {
>         return obj;
> @@ -2429,6 +2442,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_get_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_get_offset)
> +BTF_ID_FLAGS(func, bpf_dynptr_clone)
>  BTF_SET8_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3660b573048a..804cb50050f9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -302,6 +302,7 @@ struct bpf_kfunc_call_arg_meta {
>         struct {
>                 enum bpf_dynptr_type type;
>                 u32 id;
> +               u32 ref_obj_id;
>         } initialized_dynptr;
>         struct {
>                 u8 spi;
> @@ -963,24 +964,15 @@ static int mark_stack_slots_dynptr(struct bpf_verif=
ier_env *env, struct bpf_reg_
>         return 0;
>  }
>
> -static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg)
> +static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_f=
unc_state *state, int spi)
>  {
> -       struct bpf_func_state *state =3D func(env, reg);
> -       int spi, i;
> -
> -       spi =3D dynptr_get_spi(env, reg);
> -       if (spi < 0)
> -               return spi;
> +       int i;
>
>         for (i =3D 0; i < BPF_REG_SIZE; i++) {
>                 state->stack[spi].slot_type[i] =3D STACK_INVALID;
>                 state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
>         }
>
> -       /* Invalidate any slices associated with this dynptr */
> -       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.t=
ype))
> -               WARN_ON_ONCE(release_reference(env, state->stack[spi].spi=
lled_ptr.ref_obj_id));
> -
>         __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
>         __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
>
> @@ -1007,6 +999,51 @@ static int unmark_stack_slots_dynptr(struct bpf_ver=
ifier_env *env, struct bpf_re
>          */
>         state->stack[spi].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
>         state->stack[spi - 1].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
> +}
> +
> +static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg)
> +{
> +       struct bpf_func_state *state =3D func(env, reg);
> +       int spi;
> +
> +       spi =3D dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return spi;
> +
> +       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.t=
ype)) {
> +               int ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_=
id;
> +               int i;
> +
> +               /* If the dynptr has a ref_obj_id, then we need to invald=
iate

typo: invalidate

> +                * two things:
> +                *
> +                * 1) Any dynptrs with a matching ref_obj_id (clones)
> +                * 2) Any slices associated with the ref_obj_id

I think this is where this dynptr_id confusion comes from. The rule
should be "any slices derived from this dynptr". But as mentioned on
another thread, it's a separate topic which we can address later.

> +                */
> +
> +               /* Invalidate any slices associated with this dynptr */
> +               WARN_ON_ONCE(release_reference(env, ref_obj_id));
> +
> +               /* Invalidate any dynptr clones */
> +               for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; =
i++) {
> +                       if (state->stack[i].spilled_ptr.ref_obj_id =3D=3D=
 ref_obj_id) {

nit: invert if condition and continue to reduce nestedness of the rest
the loop body

> +                               /* it should always be the case that if t=
he ref obj id
> +                                * matches then the stack slot also belon=
gs to a
> +                                * dynptr
> +                                */
> +                               if (state->stack[i].slot_type[0] !=3D STA=
CK_DYNPTR) {
> +                                       verbose(env, "verifier internal e=
rror: misconfigured ref_obj_id\n");
> +                                       return -EFAULT;
> +                               }
> +                               if (state->stack[i].spilled_ptr.dynptr.fi=
rst_slot)
> +                                       invalidate_dynptr(env, state, i);
> +                       }
> +               }
> +
> +               return 0;
> +       }
> +
> +       invalidate_dynptr(env, state, spi);
>
>         return 0;
>  }
> @@ -6967,6 +7004,50 @@ static int process_iter_next_call(struct bpf_verif=
ier_env *env, int insn_idx,
>         return 0;
>  }
>
> +static int handle_dynptr_clone(struct bpf_verifier_env *env, enum bpf_ar=
g_type arg_type,
> +                              int regno, int insn_idx, struct bpf_kfunc_=
call_arg_meta *meta)
> +{
> +       struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regn=
o];
> +       struct bpf_reg_state *first_reg_state, *second_reg_state;
> +       struct bpf_func_state *state =3D func(env, reg);
> +       enum bpf_dynptr_type dynptr_type =3D meta->initialized_dynptr.typ=
e;
> +       int err, spi, ref_obj_id;
> +
> +       if (!dynptr_type) {
> +               verbose(env, "verifier internal error: no dynptr type for=
 bpf_dynptr_clone\n");
> +               return -EFAULT;
> +       }
> +       arg_type |=3D get_dynptr_type_flag(dynptr_type);


what about MEM_RDONLY and MEM_UNINIT flags, do we need to derive and add th=
em?

> +
> +       err =3D process_dynptr_func(env, regno, insn_idx, arg_type);
> +       if (err < 0)
> +               return err;
> +
> +       spi =3D dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return spi;
> +
> +       first_reg_state =3D &state->stack[spi].spilled_ptr;
> +       second_reg_state =3D &state->stack[spi - 1].spilled_ptr;
> +       ref_obj_id =3D first_reg_state->ref_obj_id;
> +
> +       /* reassign the clone the same dynptr id as the original */
> +       __mark_dynptr_reg(first_reg_state, dynptr_type, true, meta->initi=
alized_dynptr.id);
> +       __mark_dynptr_reg(second_reg_state, dynptr_type, false, meta->ini=
tialized_dynptr.id);

I'm not sure why clone should have the same dynptr_id? Isn't it a new
instance of a dynptr? I get preserving ref_obj_id (if refcounted), but
why reusing dynptr_id?..


> +
> +       if (meta->initialized_dynptr.ref_obj_id) {
> +               /* release the new ref obj id assigned during process_dyn=
ptr_func */
> +               err =3D release_reference_state(cur_func(env), ref_obj_id=
);
> +               if (err)
> +                       return err;

ugh... this is not good to create reference just to release. If we
need to reuse logic, let's reuse the logic without parts that
shouldn't happen. Please check if we can split process_dynptr_func()
appropriately to allow this.

> +               /* reassign the clone the same ref obj id as the original=
 */
> +               first_reg_state->ref_obj_id =3D meta->initialized_dynptr.=
ref_obj_id;
> +               second_reg_state->ref_obj_id =3D meta->initialized_dynptr=
.ref_obj_id;
> +       }
> +
> +       return 0;
> +}
> +

[...]
