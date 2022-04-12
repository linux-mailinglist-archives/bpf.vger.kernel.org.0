Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471124FE922
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 21:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiDLTzg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 15:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiDLTzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 15:55:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50326830D
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 12:48:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s137so15483957pgs.5
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 12:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DT+bSrdLBlVwt4kyO/I8QPjgT0HTcOAun/NTUSpYZdw=;
        b=WE97K6/HhUwBAtZvOpX2gTVliAcr+BjcIGJTeyMBZKAVHymRvlVT/8eb/+hKC9Z95P
         6f3pdI2uaudJ/CMN2jhidfWLvByxxawAKr8RgDPq2C5iuKCfBvkvZZgGeTQeu0xvS/ab
         Sf0vENfjMzS33Pt1rt90IBYncx+iLe1ZqrRgpSjnvMU7dC+0WYmQERURM+qNgcVkSG6Y
         /5D6vkD/L/omHHR5wGzprtR0kRbdV65dH5iysQShJFoRiGoPmp/+osJuk7f/v8mty3s/
         QImNkREVHmoshm/Qkfujs0i1FplIf4AN9fTVv1P33wUaTuvgWIrgWDY9bpdHGfthuehZ
         2+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DT+bSrdLBlVwt4kyO/I8QPjgT0HTcOAun/NTUSpYZdw=;
        b=PsBbpkn7lqPN1SrCGejd0UnFsQqp2z8PoXU9VFIOoeHPH1OhvGWUY7p+MRT4bJHDPD
         TqpuN2VJmFXbbaD3HNdRZgUh/2FSpRaMorenn1L+ksPE267qukDYFgDbbHGbKv5nj9Uy
         rmWG9fTEc90dvd/z56mCTy6Pxsm+6ZqvW3N9vXtgLyY4+iVYHEaKvts1Bzz1SuU4l9YR
         1rUJEkCgK+TzWTkMIZ5ek0pTpnTOehVqTVmYX/323JhNM3RgNyQnH8QLz7OISPRg2fPo
         NHHAArVWI38XB1MWhTGtXafdDuUL8X4V6s2IDn+n2UUGZutNlYCPND2vZBrjeC+FSs2h
         x1WQ==
X-Gm-Message-State: AOAM531lV+yVxOfImUXltCpGW7mxKmsak6zOqPw7AoX/NoMYwQdCQcOx
        CXS6x+1YHReku5onZNelBYN0rGBBjT/g5Q==
X-Google-Smtp-Source: ABdhPJxH8dU0oIQhTgaLKTGHoCCnY6TggkQ65Lep4N126QH3jtmB8CJQOoBNw+veivqSPxSV7QFE6Q==
X-Received: by 2002:a63:e5c:0:b0:39d:8460:4708 with SMTP id 28-20020a630e5c000000b0039d84604708mr5921071pgo.401.1649792890868;
        Tue, 12 Apr 2022 12:48:10 -0700 (PDT)
Received: from localhost ([112.79.143.3])
        by smtp.gmail.com with ESMTPSA id p64-20020a622943000000b004fdd5c07d0bsm37165092pfp.63.2022.04.12.12.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:48:10 -0700 (PDT)
Date:   Wed, 13 Apr 2022 01:18:09 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v4 01/13] bpf: Make btf_find_field more generic
Message-ID: <20220412194809.l5lfslbrzohrgnnc@apollo.legion>
References: <20220409093303.499196-1-memxor@gmail.com>
 <20220409093303.499196-2-memxor@gmail.com>
 <CAJnrk1Z2tKHXxj1do31DfhZqBck21dSCEZhBCXOP9hkyOv1EpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1Z2tKHXxj1do31DfhZqBck21dSCEZhBCXOP9hkyOv1EpA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 12, 2022 at 01:50:28AM IST, Joanne Koong wrote:
> On Sat, Apr 9, 2022 at 2:32 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Next commit introduces field type 'kptr' whose kind will not be struct,
> > but pointer, and it will not be limited to one offset, but multiple
> > ones. Make existing btf_find_struct_field and btf_find_datasec_var
> > functions amenable to use for finding kptrs in map value, by moving
> > spin_lock and timer specific checks into their own function.
> >
> > The alignment, and name are checked before the function is called, so it
> > is the last point where we can skip field or return an error before the
> > next loop iteration happens. The name parameter is now optional, and
> > only checked if it is not NULL. Size of the field and type is meant to
> > be checked inside the function, and base type will need to be obtained
> > by skipping modifiers.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 129 +++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 96 insertions(+), 33 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 0918a39279f6..db7bf05adfc5 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -3163,71 +3163,126 @@ static void btf_struct_log(struct btf_verifier_env *env,
> >         btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
> >  }
> >
> > +enum {
> > +       BTF_FIELD_SPIN_LOCK,
> > +       BTF_FIELD_TIMER,
> > +};
> > +
> > +struct btf_field_info {
> > +       u32 off;
> > +};
> > +
> > +static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t,
> > +                                u32 off, int sz, struct btf_field_info *info)
> > +{
> > +       if (!__btf_type_is_struct(t))
> > +               return 0;
> > +       if (t->size != sz)
> > +               return 0;
> Do we need these two checks? I think in the original version we did
> because we were checking this before doing the name comparison, but
> now that the name comparison check is first, if the struct name is a
> match, then won't these two things always be true (or if not, then it
> seems like we should return -EINVAL)? But maybe I'm missing something
> here - I'm still getting more familiar with BTF :)

The name can be the same, but since this comes from map BTF, it could be a
different struct with the same name string in the map BTF, with a different
size as well. So checking both is still needed.

Returning -EINVAL now would be backwards incompatible, code this is replacing
continues when it doesn't find struct with the required size.

>
> Also, as a side-note: I personally find this function name
> "btf_find_field_struct" confusing since there's also the
> "btf_find_struct_field" function that exists. I wonder whether we
> should just keep the logic inside btf_find_struct_field instead of
> putting it in this separate function?

I'm open to renaming, how about we just call it btf_find_struct? Then in the
next patch I could rename btf_find_field_kptr to btf_find_kptr.

>
> > +       if (info->off != -ENOENT)
> > +               /* only one such field is allowed */
> > +               return -E2BIG;
> In the future, do you plan to add support for multiple fields? I think
> this would be useful for dynptrs as well, so just curious what your
> plans for this are.

In the next patch it is modified to deal with one info at once, so supporting
multiple fields is a matter of passing different info_cnt. It won't do this
info->off check to ensure it only saw one field from next patch, that will be
handled outside in the loop.

> > +       info->off = off;
> > +       return 0;
> > +}
> > +
> >  static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
> > -                                const char *name, int sz, int align)
> > +                                const char *name, int sz, int align, int field_type,
>
> What are your thoughts on just passing in field_type in place of name,
> sz, and align? As in a function signature like:
>
> static int btf_find_struct_field(const struct btf *btf, const struct
> btf_type *t, int field_type, struct btf_field_info *info);
>
> where inside btf_find_struct_field when we do the switch statement on
> field_type, we can have the name, sz, and align for each of the
> different field types there? That to me seems a bit cleaner where the
> descriptors for the field types are all in one place (instead of also
> in btf_find_spin_lock() and btf_find_timer() functions) and the
> function definition for btf_find_struct_field is more straightforward.
> At that point, I don't think we'd even need btf_find_spin_lock() and
> btf_find_timer() as functions since it'd be just a straightforward
> "btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK/BTF_FIELD_TIMER)" call
> instead. Curious to hear your thoughts.

Isn't btf_find_field doing exactly this? btf_find_timer e.g. only passed
BTF_FIELD_TIMER; name, sz, and alignment come from btf_find_field.

Also, after btf_find_field, there needs to be handling for the info that was
populated. In case of timer and spin_lock, we just return the offset, but in
case of kptrs we populate the kptr_off_tab. If we move this inside
btf_find_field, then it would be done based on field type inside the same
function (either using if/else or switch cases), not sure that is cleaner than
doing it in separate wrappers.

>
> nit: should field_type be a u32 since it's an enum? Or should we be
> explicit and give the enum a name and define this as something like
> "enum btf_field_type type"?
>

Ok, I'll do that (since I'm respinning anyway), though it doesn't really matter,
the underlying type is still int in C.

> > +                                struct btf_field_info *info)
> >  {
> >         const struct btf_member *member;
> > -       u32 i, off = -ENOENT;
> > +       u32 i, off;
> > +       int ret;
> >
> >         for_each_member(i, t, member) {
> >                 const struct btf_type *member_type = btf_type_by_id(btf,
> >                                                                     member->type);
> > -               if (!__btf_type_is_struct(member_type))
> > -                       continue;
> > -               if (member_type->size != sz)
> > -                       continue;
> > -               if (strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
> > -                       continue;
> > -               if (off != -ENOENT)
> > -                       /* only one such field is allowed */
> > -                       return -E2BIG;
> > +
> >                 off = __btf_member_bit_offset(t, member);
> nit: should this be moved to after the strcmp on the name? Since if
> the name doesn't match, there's no point in doing this
> __btf_member_bit_offset call

Ack.

> > +
> > +               if (name && strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
> I'm confused by the if (name) part of the check. If name is NULL, then
> won't this "btf_find_struct_field" function always return the offset
> to the first struct? I don't think name will ever be NULL so maybe we
> should just remove this? Or do something like if (name) return
> -EINVAL; before doing the strcmp?
>

I'll move it to the next patch, since you noted there that you realised this is
for kptr.

> > +                       continue;
> >                 if (off % 8)
> >                         /* valid C code cannot generate such BTF */
> >                         return -EINVAL;
> >                 off /= 8;
> >                 if (off % align)
> >                         return -EINVAL;
> > +
> > +               switch (field_type) {
> > +               case BTF_FIELD_SPIN_LOCK:
> > +               case BTF_FIELD_TIMER:
> > +                       ret = btf_find_field_struct(btf, member_type, off, sz, info);
> nit: I think we can just do "return btf_find_field_struct(btf,
> member_type, off, sz, info);" here and remove the "int ret;"
> declaration a few lines above.
>

Ack.

> > +                       if (ret < 0)
> > +                               return ret;
> > +                       break;
> > +               default:
> > +                       return -EFAULT;
> > +               }
> >         }
> > -       return off;
> > +       return 0;
> >  }
> >
> >  static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
> > -                               const char *name, int sz, int align)
> > +                               const char *name, int sz, int align, int field_type,
> > +                               struct btf_field_info *info)
> The same comments for the btf_find_struct_field function also apply to
> this function
> >  {
> >         const struct btf_var_secinfo *vsi;
> > -       u32 i, off = -ENOENT;
> > +       u32 i, off;
> > +       int ret;
> >
> >         for_each_vsi(i, t, vsi) {
> >                 const struct btf_type *var = btf_type_by_id(btf, vsi->type);
> >                 const struct btf_type *var_type = btf_type_by_id(btf, var->type);
> >
> > -               if (!__btf_type_is_struct(var_type))
> > -                       continue;
> > -               if (var_type->size != sz)
> > +               off = vsi->offset;
> > +
> > +               if (name && strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
> >                         continue;
> >                 if (vsi->size != sz)
> >                         continue;
> > -               if (strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
> > -                       continue;
> > -               if (off != -ENOENT)
> > -                       /* only one such field is allowed */
> > -                       return -E2BIG;
> > -               off = vsi->offset;
> >                 if (off % align)
> >                         return -EINVAL;
> > +
> > +               switch (field_type) {
> > +               case BTF_FIELD_SPIN_LOCK:
> > +               case BTF_FIELD_TIMER:
> > +                       ret = btf_find_field_struct(btf, var_type, off, sz, info);
> > +                       if (ret < 0)
> > +                               return ret;
> > +                       break;
> > +               default:
> > +                       return -EFAULT;
> > +               }
> >         }
> > -       return off;
> > +       return 0;
> >  }
> >
> >  static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> > -                         const char *name, int sz, int align)
> > +                         int field_type, struct btf_field_info *info)
> >  {
> > +       const char *name;
> > +       int sz, align;
> > +
> > +       switch (field_type) {
> > +       case BTF_FIELD_SPIN_LOCK:
> > +               name = "bpf_spin_lock";
> > +               sz = sizeof(struct bpf_spin_lock);
> > +               align = __alignof__(struct bpf_spin_lock);
> > +               break;
> > +       case BTF_FIELD_TIMER:
> > +               name = "bpf_timer";
> > +               sz = sizeof(struct bpf_timer);
> > +               align = __alignof__(struct bpf_timer);
> > +               break;
> > +       default:
> > +               return -EFAULT;
> > +       }
> >
> >         if (__btf_type_is_struct(t))
> > -               return btf_find_struct_field(btf, t, name, sz, align);
> > +               return btf_find_struct_field(btf, t, name, sz, align, field_type, info);
> >         else if (btf_type_is_datasec(t))
> > -               return btf_find_datasec_var(btf, t, name, sz, align);
> > +               return btf_find_datasec_var(btf, t, name, sz, align, field_type, info);
> >         return -EINVAL;
> >  }
> >
> > @@ -3237,16 +3292,24 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> >   */
> >  int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
> >  {
> > -       return btf_find_field(btf, t, "bpf_spin_lock",
> > -                             sizeof(struct bpf_spin_lock),
> > -                             __alignof__(struct bpf_spin_lock));
> > +       struct btf_field_info info = { .off = -ENOENT };
> > +       int ret;
> > +
> > +       ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, &info);
> I'm confused about why we pass in "struct btf_field_info" as the out
> parameter. Maybe I'm missing something here, but why can't
> "btf_find_field" just return back the offset?
> > +       if (ret < 0)
> > +               return ret;
> > +       return info.off;
> >  }
> >
> >  int btf_find_timer(const struct btf *btf, const struct btf_type *t)
> >  {
> > -       return btf_find_field(btf, t, "bpf_timer",
> > -                             sizeof(struct bpf_timer),
> > -                             __alignof__(struct bpf_timer));
> > +       struct btf_field_info info = { .off = -ENOENT };
> > +       int ret;
> > +
> > +       ret = btf_find_field(btf, t, BTF_FIELD_TIMER, &info);
> > +       if (ret < 0)
> > +               return ret;
> > +       return info.off;
> >  }
> >
> >  static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
> > --
> > 2.35.1
> >

--
Kartikeya
