Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7556E7388
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 08:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjDSG5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 02:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjDSG5A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 02:57:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2F52698
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 23:56:58 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-555bc7f6746so43665007b3.6
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 23:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681887417; x=1684479417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbeI56zPPbHUNL/dH0F1jy5HluCZH7TFXGQFdEdOZaA=;
        b=SB3mgyua5bEOodNPgLkf/1gqp/mdqUJz5F0Qz+3Abb13oHhm5rA1xRDgcVQaoUVkQT
         adWTOtUU2fVlZiqTSqlC+iRXTNrEu4I/T5F/AN5iVuQ2B8v3LzqVo1skVkIOIt1Btx/H
         +DjX74Dxlmx2M5uXjjMPOFNGVQCKi8MHNOn7G2MWgsHU3+psY7hRWccC/PBALAaFMwef
         HfoOVmjgQ5lfe7yJTGk2q8P1DO+sXC098Lt34hYHbz5uJuE/54Ak/lhj+odyMDYXckTr
         fYPucCUnMUS4Hp6I5kDllIi94Lag77Mkzv6GC4Yz51QKR0F5gf03rOOrI2538ATasNDI
         TOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681887417; x=1684479417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbeI56zPPbHUNL/dH0F1jy5HluCZH7TFXGQFdEdOZaA=;
        b=CRAD0cRWBJAtLXCNrHVXE9DQtJHH3Ahk5X1Z9S2QDf66txjYTybsGPJEAkIcIOly4R
         /KfJAPQG0F4YCiAAfwNHsVFZF5CEjAqiYjySORvX+p6EUUKYja2J9ksg1/zxHF7bguRl
         UTegYkYQuxOuKgRqQyZ2wHM/UnnnM5pleAXVvBU7CKWZ6IEzKeu8WdTqOxXuipOnck9B
         fVKKBhh68D6EbFn7s3wVk0Vy1UrbHfSYUoYD5yiyKH9El277v9huC4guLSxj+gwhiZIO
         gDASMNKnhmZq/skWQyo+cgdJiQiDHeSlPKNTqpc/mz4KBZsFhxSn+WW7c4eNaUpaO4OG
         Rdeg==
X-Gm-Message-State: AAQBX9fHsHTbvHpDZ6vJcgTWBydvI1Hehc+qk40+hAbQPrD0tXDFGes9
        11mupRmW6mV/FCvH924okxB219lV2G+KEYPEB3g=
X-Google-Smtp-Source: AKy350bN/Hf9mXO7Qxk2GRcj1cr0Y+Xzl+LoG35eB7GLnCyavw3r8Tq4AnOe+EKq4pfN825QxxzvRyu4I36D3IZGSy8=
X-Received: by 2002:a81:dc0c:0:b0:545:1d7f:abfe with SMTP id
 h12-20020a81dc0c000000b005451d7fabfemr1348754ywj.7.1681887417695; Tue, 18 Apr
 2023 23:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
 <20230409033431.3992432-5-joannelkoong@gmail.com> <CAEf4BzZXgY3nZEPvAFhx3xd_uieDcpeQOBMYAUGDxrSnBEL+3w@mail.gmail.com>
 <CAJnrk1b+FsAUHneWdyarMs6kwd8CBNFi9s7n38KXQ2uF+NkvTw@mail.gmail.com> <CAEf4BzZPUmcSAPwtgVRebCDWccaU6EC3yHt99Asm=akoewbBEA@mail.gmail.com>
In-Reply-To: <CAEf4BzZPUmcSAPwtgVRebCDWccaU6EC3yHt99Asm=akoewbBEA@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 18 Apr 2023 23:56:47 -0700
Message-ID: <CAJnrk1a-+uC4najAKfP8T80tRUFSkOWt20-BG7+d9FZvo9-3AA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 4/5] bpf: Add bpf_dynptr_clone
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Mon, Apr 17, 2023 at 4:46=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 13, 2023 at 11:03=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> >
> > On Wed, Apr 12, 2023 at 3:12=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> > > >
> > > > The cloned dynptr will point to the same data as its parent dynptr,
> > > > with the same type, offset, size and read-only properties.
> > > >
> > > > Any writes to a dynptr will be reflected across all instances
> > > > (by 'instance', this means any dynptrs that point to the same
> > > > underlying data).
> > > >
> > > > Please note that data slice and dynptr invalidations will affect al=
l
> > > > instances as well. For example, if bpf_dynptr_write() is called on =
an
> > > > skb-type dynptr, all data slices of dynptr instances to that skb
> > > > will be invalidated as well (eg data slices of any clones, parents,
> > > > grandparents, ...). Another example is if a ringbuf dynptr is submi=
tted,
> > > > any instance of that dynptr will be invalidated.
> > > >
> > > > Changing the view of the dynptr (eg advancing the offset or
> > > > trimming the size) will only affect that dynptr and not affect any
> > > > other instances.
> > > >
> > > > One example use case where cloning may be helpful is for hashing or
> > > > iterating through dynptr data. Cloning will allow the user to maint=
ain
> > > > the original view of the dynptr for future use, while also allowing
> > > > views to smaller subsets of the data after the offset is advanced o=
r the
> > > > size is trimmed.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > > >  kernel/bpf/helpers.c  |  14 +++++
> > > >  kernel/bpf/verifier.c | 125 +++++++++++++++++++++++++++++++++++++-=
----
> > > >  2 files changed, 126 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > index bac4c6fe49f0..108f3bcfa6da 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > > @@ -2351,6 +2351,19 @@ __bpf_kfunc __u32 bpf_dynptr_get_offset(cons=
t struct bpf_dynptr_kern *ptr)
> > > >         return ptr->offset;
> > > >  }
> > > >
> > > > +__bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
> > > > +                                struct bpf_dynptr_kern *clone__uni=
nit)
> > >
> > > I think most of uses for bpf_dynptr_clone() would be to get a partial
> > > view (like you mentioned above, to, e.g., do a hashing of a part of
> > > the memory range). So it feels it would be best UX if clone would
> > > allow you to define a new range in one go. So e.g., to create a
> > > "sub-dynptr" for range of bytes [10, 30), it should be enough to:
> > >
> > > struct bpf_dynptr orig_ptr, new_ptr;
> > >
> > > bpf_dynptr_clone(&orig_ptr, 10, 30, &new_ptr);
> > >
> > > Instead of:
> > >
> > > bpf_dynptr_clone(&orig_ptr, &new_ptr);
> > > bpf_dynptr_advance(&new_ptr, 10);
> > > bpf_dynptr_trim(&new_ptr, bpf_dynptr_get_size(&orig_ptr) - 30);
> > >
> >
> > I don't think we can do this because we can't have bpf_dynptr_clone()
> > fail (which might happen if we take in a range, if the range is
> > invalid). This is because in the case where the clone is of a
> > reference-counted dynptr (eg like a ringbuf-type dynptr), the clone
> > even if it's invalid must be treated by the verifier as a legit dynptr
> > (since the verifier can't know ahead of time whether the clone call
> > will succeed or not) which means if the invalid clone dynptr is then
> > passed into a reference-releasing function, the verifier will release
> > the reference but the actual reference won't be released at runtime
> > (since the clone dynptr is invalid), which would leak the reference.
> > An example is something like:
> >
> >  // invalid range is passed, error is returned and new_ptr is invalid
> > bpf_dynptr_clone(&ringbuf_ptr, 9999999, 9999999, &new_ptr);
> > // this releases the reference and invalidates both new_ptr and ringbuf=
_ptr
> > bpf_ringbuf_discard_dynptr(&new_ptr, 0);
> >
> > At runtime, bpf_ringbuf_discard_dynptr() will be a no-op since new_ptr
> > is invalid - the ringbuf record still needs to be submitted/discarded,
> > but the verifier will think this already happened
>
> Ah, tricky, good point. But ok, I guess with bpf_dynptr_adjust()
> proposal in another email this would be ok:
>
> bpf_dynptr_clone(..); /* always succeeds */
> bpf_dynptr_adjust(&new_ptr, 10, 30); /* could fail to adjust, but
> dynptr is left valid */
>
> Right?

Yes, this would be okay because if bpf_dynptr_adjust fails, the clone
is valid (it was unaffected) so submitting/discarding it later on
would correctly release the reference
>
> >
> > >
> > > This, btw, shows the awkwardness of the bpf_dynptr_trim() approach.
> > >
> > > If someone really wanted an exact full-sized copy, it's trivial:
> > >
> > > bpf_dynptr_clone(&orig_ptr, 0, bpf_dynptr_get_size(&orig_ptr), &new_p=
tr);
> > >
> > >
[...]
> > > > +static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env,=
 struct bpf_reg_state *reg)
> > > > +{
> > > > +       struct bpf_func_state *state =3D func(env, reg);
> > > > +       int spi;
> > > > +
> > > > +       spi =3D dynptr_get_spi(env, reg);
> > > > +       if (spi < 0)
> > > > +               return spi;
> > > > +
> > > > +       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dy=
nptr.type)) {
> > > > +               int ref_obj_id =3D state->stack[spi].spilled_ptr.re=
f_obj_id;
> > > > +               int i;
> > > > +
> > > > +               /* If the dynptr has a ref_obj_id, then we need to =
invaldiate
> > >
> > > typo: invalidate
> > >
> > > > +                * two things:
> > > > +                *
> > > > +                * 1) Any dynptrs with a matching ref_obj_id (clone=
s)
> > > > +                * 2) Any slices associated with the ref_obj_id
> > >
> > > I think this is where this dynptr_id confusion comes from. The rule
> > > should be "any slices derived from this dynptr". But as mentioned on
> > > another thread, it's a separate topic which we can address later.
> > >
> > If there's a parent and a clone and slices derived from the parent and
> > slices derived from the clone, if the clone is invalidated then we
> > need to invalidate slices associated with the parent as well. So
> > shouldn't it be "any slices associated with the ref obj id" not "any
> > slices derived from this dynptr"? (also just a note, parent/clone
> > slices will share the same ref obj id and the same dynptr id, so
> > checking against either does the same thing)
>
> So, we have a ringbuf dynptr with ref_obj_id=3D1, id=3D2, ok? We clone it=
,
> clone gets ref_obj_id=3D1, id=3D3. If either original dynptr or clone
> dynptr is released due to bpf_ringbuf_discard_dynptr(), we invalidate
> all the dynptrs with ref_obj_id=3D1. During invalidation of each dynptr,
> we invalidate all the slices with ref_obj_id=3D=3Ddynptr's id. So we'll
> invalidate slices derived from dynptr with id=3D2 (original dynptr), and
> then all the slices derived from dynptr with id=3D3?
>
When we create a slice for a dynptr (through bpf_dynptr_data()), the
slice's reg->ref_obj_id is set to the dynptr's ref_obj_id (not
dynptr's id). During invalidation of the dynptr, we invalidate all the
slices with that ref obj id, which means we invalidate all slices for
any parents/clones.
[...]
> > > > +
> > > > +       err =3D process_dynptr_func(env, regno, insn_idx, arg_type)=
;
> > > > +       if (err < 0)
> > > > +               return err;
> > > > +
> > > > +       spi =3D dynptr_get_spi(env, reg);
> > > > +       if (spi < 0)
> > > > +               return spi;
> > > > +
> > > > +       first_reg_state =3D &state->stack[spi].spilled_ptr;
> > > > +       second_reg_state =3D &state->stack[spi - 1].spilled_ptr;
> > > > +       ref_obj_id =3D first_reg_state->ref_obj_id;
> > > > +
> > > > +       /* reassign the clone the same dynptr id as the original */
> > > > +       __mark_dynptr_reg(first_reg_state, dynptr_type, true, meta-=
>initialized_dynptr.id);
> > > > +       __mark_dynptr_reg(second_reg_state, dynptr_type, false, met=
a->initialized_dynptr.id);
> > >
> > > I'm not sure why clone should have the same dynptr_id? Isn't it a new
> > > instance of a dynptr? I get preserving ref_obj_id (if refcounted), bu=
t
> > > why reusing dynptr_id?..
> > >
> > I think we need to also copy over the dynptr id because in the case of
> > a non-reference counted dynptr, if the parent (or clone) is
> > invalidated (eg overwriting bytes of the dynptr on the stack), we must
> > also invalidate the slices of the clone (or parent)
>
> yep, right now we'll have to do that because we have dynptr_id. But if
> we get rid of it and stick to ref_obj_id and id, then clone would need
> to get a new id, but keep ref_obj_id, right?
>
Thinking about this some more, I think you're right that we shouldn't
reuse the dynptr id. in fact, i think reusing it would lead to
incorrect behavior - in the example of a non-reference counted dynptr,
if the parent dynptr is overwritten on the stack (and thus
invalidated), that shouldn't invalidate the slices of the clone at
all. I'll change this in the next version
> > >
[...]
