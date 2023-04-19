Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A028C6E7FB9
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 18:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjDSQeg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 12:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjDSQef (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 12:34:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B119359FB
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 09:34:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u3so31342183ejj.12
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681922064; x=1684514064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWsQO4oBp9uTdEKAqyFwlPtx40z7loTzOxzxC78ROZo=;
        b=hgH7ocuZVUnA84AEbTSX5zlD9QRrAfXL8kxlvltt8visOyxMyz2q4vxxct2TPXAxql
         quvL2tnaw21l30GFnMZeKGw6yLHUHVRkG5HjrOtgGe3e6uGZvFKrz7jtU9cmxmsoR6WH
         dT+KxYH7dj39vNmF8utk9flzBttjUXHUz0W3aNT4KNL8l/Rsq4B75eAllWOBWh9u4pYN
         XV0cQ+9kDQfXy0YXOBxcsAjghk3CYkrLYglAv7/qfZPeHzbWXHcXoRAFMPcZLU9Ec4+z
         BYrGQq2uHBnh4rqIcyQyZtjKr2oqVJSYYXtJc0/8zuaxWncQxarPGBp9x67V/2OOfx9Y
         wZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681922064; x=1684514064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWsQO4oBp9uTdEKAqyFwlPtx40z7loTzOxzxC78ROZo=;
        b=dnVwvTtSnNbAOQfsDMitR9vtvLs4n6c2POvxEP3J+7GJBEfF7Mt2iza+lGfanOIpQx
         E4RhcJmyRjkwbGur2qYWOnLJLyofDg1Cy3vbPl0KYwknmFXPXf/FKeek1nkEanEdgpkM
         YYMjlQXFXaPNlmj+0nzVvVrRq7tGss0DXeSUH2GlgZLbY6bbTWHxUHT49mlNnyLZMUyq
         9nZADLtOyCLDbcct4STZ02bCEbfQXQXSDK08nUqrxz8UiheAOX4/ltc/Yteu+FKGdfdh
         TCAHgpmVTM4BbJo++VE/bZ/mM3Zhgtny+KjolurMRhQPbcy9DkB74e8UEQc8FHTmEhqS
         7HPA==
X-Gm-Message-State: AAQBX9d23ag9X6Z0zfNEP0I7DD/O1cCUpD7WBwwPIIAwoLQPmFQPF88n
        AFs2UPINW1ZFvcpxf/Lt62EwfNtDo3K94vCduOY=
X-Google-Smtp-Source: AKy350a6P/2hRTTKKCcc1LswAFwQukAj1Nqte9rfzsT4mIBI6cTcoqWAcWVUx0L15dvJ2TtNHh4WBS1LfAebz3iA9Lc=
X-Received: by 2002:a17:906:3ed6:b0:94f:5847:8a8 with SMTP id
 d22-20020a1709063ed600b0094f584708a8mr12110820ejj.23.1681922063823; Wed, 19
 Apr 2023 09:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
 <20230409033431.3992432-5-joannelkoong@gmail.com> <CAEf4BzZXgY3nZEPvAFhx3xd_uieDcpeQOBMYAUGDxrSnBEL+3w@mail.gmail.com>
 <CAJnrk1b+FsAUHneWdyarMs6kwd8CBNFi9s7n38KXQ2uF+NkvTw@mail.gmail.com>
 <CAEf4BzZPUmcSAPwtgVRebCDWccaU6EC3yHt99Asm=akoewbBEA@mail.gmail.com> <CAJnrk1a-+uC4najAKfP8T80tRUFSkOWt20-BG7+d9FZvo9-3AA@mail.gmail.com>
In-Reply-To: <CAJnrk1a-+uC4najAKfP8T80tRUFSkOWt20-BG7+d9FZvo9-3AA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Apr 2023 09:34:11 -0700
Message-ID: <CAEf4BzbvV401TD3SZJhPk_CY9HVUdPXX5bjq7hh5qwfDO01jxw@mail.gmail.com>
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

On Tue, Apr 18, 2023 at 11:56=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Mon, Apr 17, 2023 at 4:46=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 13, 2023 at 11:03=E2=80=AFPM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> > >
> > > On Wed, Apr 12, 2023 at 3:12=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@g=
mail.com> wrote:
> > > > >
> > > > > The cloned dynptr will point to the same data as its parent dynpt=
r,
> > > > > with the same type, offset, size and read-only properties.
> > > > >
> > > > > Any writes to a dynptr will be reflected across all instances
> > > > > (by 'instance', this means any dynptrs that point to the same
> > > > > underlying data).
> > > > >
> > > > > Please note that data slice and dynptr invalidations will affect =
all
> > > > > instances as well. For example, if bpf_dynptr_write() is called o=
n an
> > > > > skb-type dynptr, all data slices of dynptr instances to that skb
> > > > > will be invalidated as well (eg data slices of any clones, parent=
s,
> > > > > grandparents, ...). Another example is if a ringbuf dynptr is sub=
mitted,
> > > > > any instance of that dynptr will be invalidated.
> > > > >
> > > > > Changing the view of the dynptr (eg advancing the offset or
> > > > > trimming the size) will only affect that dynptr and not affect an=
y
> > > > > other instances.
> > > > >
> > > > > One example use case where cloning may be helpful is for hashing =
or
> > > > > iterating through dynptr data. Cloning will allow the user to mai=
ntain
> > > > > the original view of the dynptr for future use, while also allowi=
ng
> > > > > views to smaller subsets of the data after the offset is advanced=
 or the
> > > > > size is trimmed.
> > > > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > ---
> > > > >  kernel/bpf/helpers.c  |  14 +++++
> > > > >  kernel/bpf/verifier.c | 125 ++++++++++++++++++++++++++++++++++++=
+-----
> > > > >  2 files changed, 126 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > index bac4c6fe49f0..108f3bcfa6da 100644
> > > > > --- a/kernel/bpf/helpers.c
> > > > > +++ b/kernel/bpf/helpers.c
> > > > > @@ -2351,6 +2351,19 @@ __bpf_kfunc __u32 bpf_dynptr_get_offset(co=
nst struct bpf_dynptr_kern *ptr)
> > > > >         return ptr->offset;
> > > > >  }
> > > > >
> > > > > +__bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
> > > > > +                                struct bpf_dynptr_kern *clone__u=
ninit)
> > > >
> > > > I think most of uses for bpf_dynptr_clone() would be to get a parti=
al
> > > > view (like you mentioned above, to, e.g., do a hashing of a part of
> > > > the memory range). So it feels it would be best UX if clone would
> > > > allow you to define a new range in one go. So e.g., to create a
> > > > "sub-dynptr" for range of bytes [10, 30), it should be enough to:
> > > >
> > > > struct bpf_dynptr orig_ptr, new_ptr;
> > > >
> > > > bpf_dynptr_clone(&orig_ptr, 10, 30, &new_ptr);
> > > >
> > > > Instead of:
> > > >
> > > > bpf_dynptr_clone(&orig_ptr, &new_ptr);
> > > > bpf_dynptr_advance(&new_ptr, 10);
> > > > bpf_dynptr_trim(&new_ptr, bpf_dynptr_get_size(&orig_ptr) - 30);
> > > >
> > >
> > > I don't think we can do this because we can't have bpf_dynptr_clone()
> > > fail (which might happen if we take in a range, if the range is
> > > invalid). This is because in the case where the clone is of a
> > > reference-counted dynptr (eg like a ringbuf-type dynptr), the clone
> > > even if it's invalid must be treated by the verifier as a legit dynpt=
r
> > > (since the verifier can't know ahead of time whether the clone call
> > > will succeed or not) which means if the invalid clone dynptr is then
> > > passed into a reference-releasing function, the verifier will release
> > > the reference but the actual reference won't be released at runtime
> > > (since the clone dynptr is invalid), which would leak the reference.
> > > An example is something like:
> > >
> > >  // invalid range is passed, error is returned and new_ptr is invalid
> > > bpf_dynptr_clone(&ringbuf_ptr, 9999999, 9999999, &new_ptr);
> > > // this releases the reference and invalidates both new_ptr and ringb=
uf_ptr
> > > bpf_ringbuf_discard_dynptr(&new_ptr, 0);
> > >
> > > At runtime, bpf_ringbuf_discard_dynptr() will be a no-op since new_pt=
r
> > > is invalid - the ringbuf record still needs to be submitted/discarded=
,
> > > but the verifier will think this already happened
> >
> > Ah, tricky, good point. But ok, I guess with bpf_dynptr_adjust()
> > proposal in another email this would be ok:
> >
> > bpf_dynptr_clone(..); /* always succeeds */
> > bpf_dynptr_adjust(&new_ptr, 10, 30); /* could fail to adjust, but
> > dynptr is left valid */
> >
> > Right?
>
> Yes, this would be okay because if bpf_dynptr_adjust fails, the clone
> is valid (it was unaffected) so submitting/discarding it later on
> would correctly release the reference

ok, cool, let's do that and keep things simple

> >
> > >
> > > >
> > > > This, btw, shows the awkwardness of the bpf_dynptr_trim() approach.
> > > >
> > > > If someone really wanted an exact full-sized copy, it's trivial:
> > > >
> > > > bpf_dynptr_clone(&orig_ptr, 0, bpf_dynptr_get_size(&orig_ptr), &new=
_ptr);
> > > >
> > > >
> [...]
> > > > > +static int unmark_stack_slots_dynptr(struct bpf_verifier_env *en=
v, struct bpf_reg_state *reg)
> > > > > +{
> > > > > +       struct bpf_func_state *state =3D func(env, reg);
> > > > > +       int spi;
> > > > > +
> > > > > +       spi =3D dynptr_get_spi(env, reg);
> > > > > +       if (spi < 0)
> > > > > +               return spi;
> > > > > +
> > > > > +       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.=
dynptr.type)) {
> > > > > +               int ref_obj_id =3D state->stack[spi].spilled_ptr.=
ref_obj_id;
> > > > > +               int i;
> > > > > +
> > > > > +               /* If the dynptr has a ref_obj_id, then we need t=
o invaldiate
> > > >
> > > > typo: invalidate
> > > >
> > > > > +                * two things:
> > > > > +                *
> > > > > +                * 1) Any dynptrs with a matching ref_obj_id (clo=
nes)
> > > > > +                * 2) Any slices associated with the ref_obj_id
> > > >
> > > > I think this is where this dynptr_id confusion comes from. The rule
> > > > should be "any slices derived from this dynptr". But as mentioned o=
n
> > > > another thread, it's a separate topic which we can address later.
> > > >
> > > If there's a parent and a clone and slices derived from the parent an=
d
> > > slices derived from the clone, if the clone is invalidated then we
> > > need to invalidate slices associated with the parent as well. So
> > > shouldn't it be "any slices associated with the ref obj id" not "any
> > > slices derived from this dynptr"? (also just a note, parent/clone
> > > slices will share the same ref obj id and the same dynptr id, so
> > > checking against either does the same thing)
> >
> > So, we have a ringbuf dynptr with ref_obj_id=3D1, id=3D2, ok? We clone =
it,
> > clone gets ref_obj_id=3D1, id=3D3. If either original dynptr or clone
> > dynptr is released due to bpf_ringbuf_discard_dynptr(), we invalidate
> > all the dynptrs with ref_obj_id=3D1. During invalidation of each dynptr=
,
> > we invalidate all the slices with ref_obj_id=3D=3Ddynptr's id. So we'll
> > invalidate slices derived from dynptr with id=3D2 (original dynptr), an=
d
> > then all the slices derived from dynptr with id=3D3?
> >
> When we create a slice for a dynptr (through bpf_dynptr_data()), the
> slice's reg->ref_obj_id is set to the dynptr's ref_obj_id (not
> dynptr's id). During invalidation of the dynptr, we invalidate all the
> slices with that ref obj id, which means we invalidate all slices for
> any parents/clones.
> [...]

Yep, because of how we define that ref_obj_id should be in refs array.
What I'm saying is that we should probably change that to be more
general "ID of an object which lifetime we are associated with". That
would need some verifier internals adjustments.

So let's wrap up this particular ref_obj_id revamp discussion for now,
it's a separate topic that will be just distracting us.

> > > > > +
> > > > > +       err =3D process_dynptr_func(env, regno, insn_idx, arg_typ=
e);
> > > > > +       if (err < 0)
> > > > > +               return err;
> > > > > +
> > > > > +       spi =3D dynptr_get_spi(env, reg);
> > > > > +       if (spi < 0)
> > > > > +               return spi;
> > > > > +
> > > > > +       first_reg_state =3D &state->stack[spi].spilled_ptr;
> > > > > +       second_reg_state =3D &state->stack[spi - 1].spilled_ptr;
> > > > > +       ref_obj_id =3D first_reg_state->ref_obj_id;
> > > > > +
> > > > > +       /* reassign the clone the same dynptr id as the original =
*/
> > > > > +       __mark_dynptr_reg(first_reg_state, dynptr_type, true, met=
a->initialized_dynptr.id);
> > > > > +       __mark_dynptr_reg(second_reg_state, dynptr_type, false, m=
eta->initialized_dynptr.id);
> > > >
> > > > I'm not sure why clone should have the same dynptr_id? Isn't it a n=
ew
> > > > instance of a dynptr? I get preserving ref_obj_id (if refcounted), =
but
> > > > why reusing dynptr_id?..
> > > >
> > > I think we need to also copy over the dynptr id because in the case o=
f
> > > a non-reference counted dynptr, if the parent (or clone) is
> > > invalidated (eg overwriting bytes of the dynptr on the stack), we mus=
t
> > > also invalidate the slices of the clone (or parent)
> >
> > yep, right now we'll have to do that because we have dynptr_id. But if
> > we get rid of it and stick to ref_obj_id and id, then clone would need
> > to get a new id, but keep ref_obj_id, right?
> >
> Thinking about this some more, I think you're right that we shouldn't
> reuse the dynptr id. in fact, i think reusing it would lead to
> incorrect behavior - in the example of a non-reference counted dynptr,
> if the parent dynptr is overwritten on the stack (and thus
> invalidated), that shouldn't invalidate the slices of the clone at
> all. I'll change this in the next version

ok

> > > >
> [...]
