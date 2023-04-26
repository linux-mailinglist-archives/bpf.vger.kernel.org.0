Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FE96EF9E8
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 20:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjDZSQy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 14:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbjDZSQx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 14:16:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E07DB0
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 11:16:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-504fce3d7fbso11516859a12.2
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682533010; x=1685125010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSJjfTp9BF/c3lgFOhXd3iue4rIwAt3YVys1O3wyRLs=;
        b=jGwmzmTe4mjwOYhkNGF9t7EidpjB8dwub1LbIhFy8mQ9K7QDqaXyPHr8U21p+fkz8S
         q25GV87QjCgtqvxluW1R/lg+p7cJ1MQiozh0NCFiT4lYtTkfKZb4SZG1X+e9FG+B2AZ/
         iebagT5vHw9lcN0LsiYdBLulBbM1XtCSOzX1xiu+pgtJDcDKqTc3FHCf050FczB7XMqJ
         srNZAfzT7hC/oZp0GLJdktpBq/92MVYJs6/2/1LO35AynNGgBz9XeGOzW/y8GEmtFt/Z
         e9QeSjuAREzLKTCrKji+uEfmD4hPZWO+W0ofqd/V7/F4QrMstV4s41BCZXqIYJB+LOQp
         SMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682533010; x=1685125010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSJjfTp9BF/c3lgFOhXd3iue4rIwAt3YVys1O3wyRLs=;
        b=cJa3DfbExDSZmqR5CSRc7oIVP+XUp6Q6xUb/nDoCtnUq3tIxZyw4PNwxjBdygypuV1
         vL0b52ClvJs1VBiZ3zGvWttfFwE91cnFKCVlxreNIXfszg8MpQmbuOuQUzg3i9SssroO
         u97oyQm/HQqve6lO4FnDzjl1mGDvln12gAc9270ApcI6m2GzRQNL63ASE+MxgzqiXMlw
         Iyut7uRt1MA74jDoXXy+dENMaXHwHPefTXbGQRguVt9GqFmhtAETnWrfK+DJpj+iXuDR
         Z2DvSjvJz2vlklqNd8bdSI4vPbapKgZkaLhJIkTsk9vO00Qk1Is6i+iV4TIN0Q1EJHBl
         GgeQ==
X-Gm-Message-State: AAQBX9dEZdiVFOU0KaZcI6/G58ooaq0rZGqnrjFVDLfGM58CBdmVeH+H
        1D1qU/2fSfJjs+zmJNeBmD0tF3JwOXeSIOmOKj8=
X-Google-Smtp-Source: AKy350Y2N3pnVfAUsaFMxNKkw1FEZUfJ4AAUlrsvG/1g5aM/uXd9R8+tIxztWRp7uTIbZlpJVhAFxTEVe7i+eBIJ7EQ=
X-Received: by 2002:a05:6402:1807:b0:504:8173:ec8c with SMTP id
 g7-20020a056402180700b005048173ec8cmr20881912edy.13.1682533010357; Wed, 26
 Apr 2023 11:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230420071414.570108-1-joannelkoong@gmail.com> <20230420071414.570108-5-joannelkoong@gmail.com>
In-Reply-To: <20230420071414.570108-5-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 11:16:37 -0700
Message-ID: <CAEf4BzbbC7jizOPn9J=MOEZXeMErP4sgWNV82QVooufs4DZVeA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] bpf: Add bpf_dynptr_clone
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

On Thu, Apr 20, 2023 at 12:15=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
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
>  kernel/bpf/helpers.c  |  14 ++++++
>  kernel/bpf/verifier.c | 105 ++++++++++++++++++++++++++++++++++--------
>  2 files changed, 99 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9018646b86db..1ebdc7f1a574 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2343,6 +2343,19 @@ __bpf_kfunc __u32 bpf_dynptr_size(const struct bpf=
_dynptr_kern *ptr)
>         return __bpf_dynptr_size(ptr);
>  }
>
> +__bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
> +                                struct bpf_dynptr_kern *clone__uninit)
> +{
> +       if (!ptr->data) {
> +               bpf_dynptr_set_null(clone__uninit);
> +               return -EINVAL;
> +       }
> +
> +       *clone__uninit =3D *ptr;
> +
> +       return 0;
> +}
> +
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>  {
>         return obj;
> @@ -2419,6 +2432,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
> +BTF_ID_FLAGS(func, bpf_dynptr_clone)
>  BTF_SET8_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1e05355facdc..164726673086 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -309,6 +309,7 @@ struct bpf_kfunc_call_arg_meta {
>         struct {
>                 enum bpf_dynptr_type type;
>                 u32 id;
> +               u32 ref_obj_id;
>         } initialized_dynptr;
>         struct {
>                 u8 spi;
> @@ -847,11 +848,11 @@ static int destroy_if_dynptr_stack_slot(struct bpf_=
verifier_env *env,
>                                         struct bpf_func_state *state, int=
 spi);
>
>  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg,
> -                                  enum bpf_arg_type arg_type, int insn_i=
dx)
> +                                  enum bpf_arg_type arg_type, int insn_i=
dx, int clone_ref_obj_id)
>  {
>         struct bpf_func_state *state =3D func(env, reg);
>         enum bpf_dynptr_type type;
> -       int spi, i, id, err;
> +       int spi, i, err;
>
>         spi =3D dynptr_get_spi(env, reg);
>         if (spi < 0)
> @@ -887,7 +888,13 @@ static int mark_stack_slots_dynptr(struct bpf_verifi=
er_env *env, struct bpf_reg_
>
>         if (dynptr_type_refcounted(type)) {
>                 /* The id is used to track proper releasing */
> -               id =3D acquire_reference_state(env, insn_idx);
> +               int id;
> +
> +               if (clone_ref_obj_id)
> +                       id =3D clone_ref_obj_id;
> +               else
> +                       id =3D acquire_reference_state(env, insn_idx);
> +
>                 if (id < 0)
>                         return id;
>
> @@ -901,24 +908,15 @@ static int mark_stack_slots_dynptr(struct bpf_verif=
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
> @@ -945,6 +943,52 @@ static int unmark_stack_slots_dynptr(struct bpf_veri=
fier_env *env, struct bpf_re
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

I inverted this condition, did invalidate_dynptr(spi), return 0. This
reduced nestedness of refcounted case handling code below.

The rest looks great!

> +               int ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_=
id;
> +               int i;
> +
> +               /* If the dynptr has a ref_obj_id, then we need to invali=
date
> +                * two things:
> +                *
> +                * 1) Any dynptrs with a matching ref_obj_id (clones)
> +                * 2) Any slices derived from this dynptr.
> +                */
> +

[...]
