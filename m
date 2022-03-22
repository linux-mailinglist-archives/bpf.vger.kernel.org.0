Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC884E4766
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 21:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiCVUYf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 16:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiCVUYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 16:24:34 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C211443C0
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 13:23:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id x4so21575455iop.7
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 13:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GNTFrgDSvTp/p0Vrbr1SbINcSZbX/2uUT+emyx33SVo=;
        b=oGLqniIsKwTVEaSlb5DuWcuGs+YsuHt3qwieoHfl0OxejJyc6MAMxQXMpxnQpEPCXL
         +TLhprt+TljmAwYbJo1zzqKZZW0S0zqxkp3qLK522b6eaJtqieOKraiNLSybajExldZA
         CA/EXy2OL58iaH285E+q+qT31pKbbucGbqKQbQN88HCLl4G3G9+OlnpfQXGZO7iiABzX
         b1ZQ7nBLE5ctN9pF1uKR18AvTHqMOd6GV0/ojTOogPD7jyF4hoD/cN6nX0E0ucO2oUSu
         gYtAjYA0iZERkjrF1BplZv3wVs8R0XZAEWqLJ2ccQMPdXdxt9v+MwQ6OtORVdSBUUdtJ
         qudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GNTFrgDSvTp/p0Vrbr1SbINcSZbX/2uUT+emyx33SVo=;
        b=w77mHvbBI80VzfThoBC7gt5LJaHkMVimH7Dwp3k2R2NujR0H6ArBuoXDuPF7A6UGU+
         C335vM7ohvbOAUKDbIYtQtGDYF0sv0SNSaSI4jhx6QlMbnLodDtbcm/JKTm/hBZxLXS8
         NZCdbp8Ihua4bkbv9jjjthIRjHVX61CVQn3+vetEZaB8IWA4kpDkJrbsXK/oDuJsog5D
         /vGwQuYYehQ8tF6Gvlj1y9jYDJahDQ0GmcEyDZBXCb8RSb7sX5TaDheIyLKbXT9f/a2H
         L5MB59718XsjN4n0XHSBzYs3cucyHPsWcSwUXnBg3PnPYOHT5guqY9GwYI8NpYdCVaQD
         0auw==
X-Gm-Message-State: AOAM531/ekjISH7yY75ycsK2c9Q9FXgIoeIKXgUDncSNUxWMb1Szdkff
        7SS4cMrCw8n5mVzAGAjLofBYz6kW8+eP4Nkzs2w=
X-Google-Smtp-Source: ABdhPJxESgSPgd/d9WxrfPmPFDwsZva16hIKhIqOVhha6/iqOgqs0dWgdvvV+yW7xW5QuboFZ+B8A4H+l3Pz6E1zlOg=
X-Received: by 2002:a02:c00e:0:b0:317:c548:97c with SMTP id
 y14-20020a02c00e000000b00317c548097cmr14555482jai.234.1647980583829; Tue, 22
 Mar 2022 13:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220320155510.671497-1-memxor@gmail.com> <20220320155510.671497-4-memxor@gmail.com>
 <CAJnrk1btaBKMQsLaj3LZX+ipeq0YtA2KYSeN_DSKMjqg7bGiZg@mail.gmail.com> <20220322070451.2ybbkduheovtbv7n@apollo>
In-Reply-To: <20220322070451.2ybbkduheovtbv7n@apollo>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 22 Mar 2022 13:22:52 -0700
Message-ID: <CAEf4BzamUKigWrC+qwAKhRO9KqWfe=aYfkg8ZQo9ZSAW7n7S_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Allow storing unreferenced kptr in map
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 22, 2022 at 12:05 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, Mar 22, 2022 at 05:09:30AM IST, Joanne Koong wrote:
> > On Sun, Mar 20, 2022 at 5:27 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > This commit introduces a new pointer type 'kptr' which can be embedded
> > > in a map value as holds a PTR_TO_BTF_ID stored by a BPF program during
> > > its invocation. Storing to such a kptr, BPF program's PTR_TO_BTF_ID
> > > register must have the same type as in the map value's BTF, and loading
> > > a kptr marks the destination register as PTR_TO_BTF_ID with the correct
> > > kernel BTF and BTF ID.
> > >
> > > Such kptr are unreferenced, i.e. by the time another invocation of the
> > > BPF program loads this pointer, the object which the pointer points to
> > > may not longer exist. Since PTR_TO_BTF_ID loads (using BPF_LDX) are
> > > patched to PROBE_MEM loads by the verifier, it would safe to allow user
> > > to still access such invalid pointer, but passing such pointers into
> > > BPF helpers and kfuncs should not be permitted. A future patch in this
> > > series will close this gap.
> > >
> > > The flexibility offered by allowing programs to dereference such invalid
> > > pointers while being safe at runtime frees the verifier from doing
> > > complex lifetime tracking. As long as the user may ensure that the
> > > object remains valid, it can ensure data read by it from the kernel
> > > object is valid.
> > >
> > > The user indicates that a certain pointer must be treated as kptr
> > > capable of accepting stores of PTR_TO_BTF_ID of a certain type, by using
> > > a BTF type tag 'kptr' on the pointed to type of the pointer. Then, this
> > > information is recorded in the object BTF which will be passed into the
> > > kernel by way of map's BTF information. The name and kind from the map
> > > value BTF is used to look up the in-kernel type, and the actual BTF and
> > > BTF ID is recorded in the map struct in a new kptr_off_tab member. For
> > > now, only storing pointers to structs is permitted.
> > >
> > > An example of this specification is shown below:
> > >
> > >         #define __kptr __attribute__((btf_type_tag("kptr")))
> > >
> > >         struct map_value {
> > >                 ...
> > >                 struct task_struct __kptr *task;
> > >                 ...
> > >         };
> > >
> > > Then, in a BPF program, user may store PTR_TO_BTF_ID with the type
> > > task_struct into the map, and then load it later.
> > >
> > > Note that the destination register is marked PTR_TO_BTF_ID_OR_NULL, as
> > > the verifier cannot know whether the value is NULL or not statically, it
> > > must treat all potential loads at that map value offset as loading a
> > > possibly NULL pointer.
> > >
> > > Only BPF_LDX, BPF_STX, and BPF_ST with insn->imm = 0 (to denote NULL)
> > > are allowed instructions that can access such a pointer. On BPF_LDX, the
> > > destination register is updated to be a PTR_TO_BTF_ID, and on BPF_STX,
> > > it is checked whether the source register type is a PTR_TO_BTF_ID with
> > > same BTF type as specified in the map BTF. The access size must always
> > > be BPF_DW.
> > >
> > > For the map in map support, the kptr_off_tab for outer map is copied
> > > from the inner map's kptr_off_tab. It was chosen to do a deep copy
> > > instead of introducing a refcount to kptr_off_tab, because the copy only
> > > needs to be done when paramterizing using inner_map_fd in the map in map
> > > case, hence would be unnecessary for all other users.
> > >
> > > It is not permitted to use MAP_FREEZE command and mmap for BPF map
> > > having kptr, similar to the bpf_timer case.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h     |  29 +++++++-
> > >  include/linux/btf.h     |   2 +
> > >  kernel/bpf/btf.c        | 161 ++++++++++++++++++++++++++++++++++------
> > >  kernel/bpf/map_in_map.c |   5 +-
> > >  kernel/bpf/syscall.c    | 112 +++++++++++++++++++++++++++-
> > >  kernel/bpf/verifier.c   | 120 ++++++++++++++++++++++++++++++
> > >  6 files changed, 401 insertions(+), 28 deletions(-)
> > >
> > [...]
> > > +
> > >  struct bpf_map *bpf_map_get(u32 ufd);
> > >  struct bpf_map *bpf_map_get_with_uref(u32 ufd);
> > >  struct bpf_map *__bpf_map_get(struct fd f);
> > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > index 36bc09b8e890..5b578dc81c04 100644
> > > --- a/include/linux/btf.h
> > > +++ b/include/linux/btf.h
> > > @@ -123,6 +123,8 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
> > >                            u32 expected_offset, u32 expected_size);
> > >  int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
> > >  int btf_find_timer(const struct btf *btf, const struct btf_type *t);
> > > +struct bpf_map_value_off *btf_find_kptr(const struct btf *btf,
> > > +                                       const struct btf_type *t);
> >
> > nit: given that "btf_find_kptr" allocates memory as well, maybe the
> > name "btf_parse_kptr" would be more reflective?
> >
>
> Good point, will change.
>
> > >  bool btf_type_is_void(const struct btf_type *t);
> > >  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
> > >  const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 9e17af936a7a..92afbec0a887 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -3164,9 +3164,16 @@ static void btf_struct_log(struct btf_verifier_env *env,
> > >  enum {
> > >         BTF_FIELD_SPIN_LOCK,
> > >         BTF_FIELD_TIMER,
> > > +       BTF_FIELD_KPTR,
> > > +};
> > > +
> > > +enum {
> > > +       BTF_FIELD_IGNORE = 0,
> > > +       BTF_FIELD_FOUND  = 1,
> > >  };
> > >
> > >  struct btf_field_info {
> > > +       const struct btf_type *type;
> > >         u32 off;
> > >  };
> > >
> > > @@ -3174,23 +3181,48 @@ static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t
> > >                                  u32 off, int sz, struct btf_field_info *info)
> > >  {
> > >         if (!__btf_type_is_struct(t))
> > > -               return 0;
> > > +               return BTF_FIELD_IGNORE;
> > >         if (t->size != sz)
> > > -               return 0;
> > > -       if (info->off != -ENOENT)
> > > -               /* only one such field is allowed */
> > > -               return -E2BIG;
> > > +               return BTF_FIELD_IGNORE;
> > >         info->off = off;
> > > -       return 0;
> > > +       return BTF_FIELD_FOUND;
> > > +}
> > > +
> > > +static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
> > > +                              u32 off, int sz, struct btf_field_info *info)
> > > +{
> > > +       /* For PTR, sz is always == 8 */
> > > +       if (!btf_type_is_ptr(t))
> > > +               return BTF_FIELD_IGNORE;
> > > +       t = btf_type_by_id(btf, t->type);
> > > +
> > > +       if (!btf_type_is_type_tag(t))
> > > +               return BTF_FIELD_IGNORE;
> > > +       /* Reject extra tags */
> > > +       if (btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
> > > +               return -EINVAL;
> > > +       if (strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
> > > +               return -EINVAL;
> > > +
> > > +       /* Get the base type */
> > > +       if (btf_type_is_modifier(t))
> > > +               t = btf_type_skip_modifiers(btf, t->type, NULL);
> > > +       /* Only pointer to struct is allowed */
> > > +       if (!__btf_type_is_struct(t))
> > > +               return -EINVAL;
> > > +
> > > +       info->type = t;
> > > +       info->off = off;
> > > +       return BTF_FIELD_FOUND;
> > >  }
> > >
> > >  static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
> > >                                  const char *name, int sz, int align, int field_type,
> > > -                                struct btf_field_info *info)
> > > +                                struct btf_field_info *info, int info_cnt)
> >
> > From my understanding, this patch now modifies btf_find_struct_field
> > and btf_find_datasec_var such that the "info" that is passed in has to
> > be an array of size max possible + 1 while "info_cnt" is the max
> > possible count, or we risk writing beyond the "info" array passed in.
> > It seems like we could just modify the
> > btf_find_struct_field/btf_find_datasec_var logic so that the user can
> > just pass in info array of max possible size instead of max possible
> > size + 1 - or is your concern that this would require more idx >=
> > info_cnt checks inside the functions? Maybe we should include a
> > comment here and in btf_find_datasec_var to document that "info"
> > should always be max possible size + 1?
> >
>
> So for some context on why this was changed, follow [0].
>
> I agree it's pretty ugly. My first thought was to check it inside the functions,
> but that is also not very great. So I went with this, one more suggestion from
> Alexei was to split it into a find and then fill info, because the error on
> idx >= info_cnt should only happen after we find. Right now the find and fill
> happens together, so to error out, you need an extra element it can fill before
> you bail for ARRAY_SIZE - 1 (which is the actual max).
>
> TBH the find + fill split looks best to me, but open to more suggestions.

I think there is much simpler way that doesn't require unnecessary
copying or splitting anything:

struct btf_field_info tmp;

...

ret = btf_find_field_struct(btf, member_type, off, sz,
                            idx < info_cnt ? &info[idx] : &tmp);

...

That's it.

>
> [0]: https://lore.kernel.org/bpf/20220319181538.nbqdkprjrzkxk7v4@ast-mbp.dhcp.thefacebook.com
>

[...]
