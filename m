Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF24E7D51
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 01:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbiCYXBB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 19:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiCYXBA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 19:01:00 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54032173F7D
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 15:59:25 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h63so10571326iof.12
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZb6l463qUWt20gyK9xkdGAqJSQXlYr5CxbNJwSFNnA=;
        b=T9uUOU8gQdLggDYdW6irLinxCc1UYAGWCsT4zPGsYoRsgpm5ys0mIwFX+C/sXW36aQ
         O6eib5ihOX549JPpNEaQSTEImsQkRdaC9XlwKKIv9UQx0JcN33NHPNi9xeaw7SodtSBo
         modD9uNHbb2TlKZcEdklRrfYUXLot/R+upFcJcwHDXnkp2VXZhZX4V2MJXb3jCBfRVhw
         SRGMfEYeRfFsr9oNqwkYindEfLrtt7bRoGUCuM1dzl+Zzk+TjK9osJXmV0acERJE5msn
         n5zmz5GhW1nSeA9jl4m9enhpN+QJpl38+hhsLuEshY2xgxCOqZcwJGl7h1lc1xiBheJZ
         UX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZb6l463qUWt20gyK9xkdGAqJSQXlYr5CxbNJwSFNnA=;
        b=e2hcwURD+m14SXu6v6GhUgrL755v4la+HHBUQ0gGtnXskJKGNVyjyLYmEzJyGyL8+y
         sMJFBr25SNRuGuo6k3gXADS1bFegOX59mzc0iJ457BB8xMnsZwfMFW3DlLHgbQ+QidLm
         a6rzI5SNpBnRSoC6VZBIiVQDTh2yBy+r/+vYSzfBWYpZKAkF6scAzsQ2mtPWBDugqZ/Q
         6+WUcfErE3tRxUnVSq75T+6dwFnr5ZfiJtgtrLRQ41m6V5OOYtqQwR3z4HQItolSADJG
         LINhAzCsu/8Ck0FrMDxpXNrn7YZi5T0HOPk40HIhzkrj91QEsK4lj3DHo4wHfIhxLhBp
         n0cw==
X-Gm-Message-State: AOAM533fK6yerM7FEOqEGDdeVYGakwhU2BGMWjTGz3/PfNkzdWrNV7Me
        A0VpNw9L+qfEacmymzM1Ok8XWcPj/LTm02luE6c=
X-Google-Smtp-Source: ABdhPJy/xcr0ylNETeaSaHbS/erk7ZvfufuF9nuONBHpuk2J54jyfE69tmX9/kC02E/6m8TEXWVP9GYeP41S8xI7RAw=
X-Received: by 2002:a05:6638:772:b0:319:e4eb:adb with SMTP id
 y18-20020a056638077200b00319e4eb0adbmr7315512jad.237.1648249164656; Fri, 25
 Mar 2022 15:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220320155510.671497-1-memxor@gmail.com> <20220320155510.671497-4-memxor@gmail.com>
 <CAEf4BzaJuW8tdmFz_NDe8K2qeNuLcOjVo3ZP4g5H1Yp60sQrTA@mail.gmail.com>
 <20220322071640.nqc2he44grixyhle@apollo> <CAEf4BzYCuueZwFeGHxqcx=fZ5mEg2vQas7mKb2bj0MWp70VxCg@mail.gmail.com>
 <20220325144229.z2cft7me2gwghwm6@apollo>
In-Reply-To: <20220325144229.z2cft7me2gwghwm6@apollo>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 25 Mar 2022 15:59:13 -0700
Message-ID: <CAEf4Bzbjyf-kv8w2bd4Ke6y+icXpY35qhxOLkMg7Tfqupr-X-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Allow storing unreferenced kptr in map
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

On Fri, Mar 25, 2022 at 7:42 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, Mar 23, 2022 at 12:22:20AM IST, Andrii Nakryiko wrote:
> > On Tue, Mar 22, 2022 at 12:16 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Tue, Mar 22, 2022 at 11:15:42AM IST, Andrii Nakryiko wrote:
> > > > On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > This commit introduces a new pointer type 'kptr' which can be embedded
> > > > > in a map value as holds a PTR_TO_BTF_ID stored by a BPF program during
> > > > > its invocation. Storing to such a kptr, BPF program's PTR_TO_BTF_ID
> > > > > register must have the same type as in the map value's BTF, and loading
> > > > > a kptr marks the destination register as PTR_TO_BTF_ID with the correct
> > > > > kernel BTF and BTF ID.
> > > > >
> > > > > Such kptr are unreferenced, i.e. by the time another invocation of the
> > > > > BPF program loads this pointer, the object which the pointer points to
> > > > > may not longer exist. Since PTR_TO_BTF_ID loads (using BPF_LDX) are
> > > > > patched to PROBE_MEM loads by the verifier, it would safe to allow user
> > > > > to still access such invalid pointer, but passing such pointers into
> > > > > BPF helpers and kfuncs should not be permitted. A future patch in this
> > > > > series will close this gap.
> > > > >
> > > > > The flexibility offered by allowing programs to dereference such invalid
> > > > > pointers while being safe at runtime frees the verifier from doing
> > > > > complex lifetime tracking. As long as the user may ensure that the
> > > > > object remains valid, it can ensure data read by it from the kernel
> > > > > object is valid.
> > > > >
> > > > > The user indicates that a certain pointer must be treated as kptr
> > > > > capable of accepting stores of PTR_TO_BTF_ID of a certain type, by using
> > > > > a BTF type tag 'kptr' on the pointed to type of the pointer. Then, this
> > > > > information is recorded in the object BTF which will be passed into the
> > > > > kernel by way of map's BTF information. The name and kind from the map
> > > > > value BTF is used to look up the in-kernel type, and the actual BTF and
> > > > > BTF ID is recorded in the map struct in a new kptr_off_tab member. For
> > > > > now, only storing pointers to structs is permitted.
> > > > >
> > > > > An example of this specification is shown below:
> > > > >
> > > > >         #define __kptr __attribute__((btf_type_tag("kptr")))
> > > > >
> > > > >         struct map_value {
> > > > >                 ...
> > > > >                 struct task_struct __kptr *task;
> > > > >                 ...
> > > > >         };
> > > > >
> > > > > Then, in a BPF program, user may store PTR_TO_BTF_ID with the type
> > > > > task_struct into the map, and then load it later.
> > > > >
> > > > > Note that the destination register is marked PTR_TO_BTF_ID_OR_NULL, as
> > > > > the verifier cannot know whether the value is NULL or not statically, it
> > > > > must treat all potential loads at that map value offset as loading a
> > > > > possibly NULL pointer.
> > > > >
> > > > > Only BPF_LDX, BPF_STX, and BPF_ST with insn->imm = 0 (to denote NULL)
> > > > > are allowed instructions that can access such a pointer. On BPF_LDX, the
> > > > > destination register is updated to be a PTR_TO_BTF_ID, and on BPF_STX,
> > > > > it is checked whether the source register type is a PTR_TO_BTF_ID with
> > > > > same BTF type as specified in the map BTF. The access size must always
> > > > > be BPF_DW.
> > > > >
> > > > > For the map in map support, the kptr_off_tab for outer map is copied
> > > > > from the inner map's kptr_off_tab. It was chosen to do a deep copy
> > > > > instead of introducing a refcount to kptr_off_tab, because the copy only
> > > > > needs to be done when paramterizing using inner_map_fd in the map in map
> > > > > case, hence would be unnecessary for all other users.
> > > > >
> > > > > It is not permitted to use MAP_FREEZE command and mmap for BPF map
> > > > > having kptr, similar to the bpf_timer case.
> > > > >
> > > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > > ---
> > > > >  include/linux/bpf.h     |  29 +++++++-
> > > > >  include/linux/btf.h     |   2 +
> > > > >  kernel/bpf/btf.c        | 161 ++++++++++++++++++++++++++++++++++------
> > > > >  kernel/bpf/map_in_map.c |   5 +-
> > > > >  kernel/bpf/syscall.c    | 112 +++++++++++++++++++++++++++-
> > > > >  kernel/bpf/verifier.c   | 120 ++++++++++++++++++++++++++++++
> > > > >  6 files changed, 401 insertions(+), 28 deletions(-)
> > > > >
> > > >
> > > > [...]
> > > >
> > > > > +static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
> > > > > +                              u32 off, int sz, struct btf_field_info *info)
> > > > > +{
> > > > > +       /* For PTR, sz is always == 8 */
> > > > > +       if (!btf_type_is_ptr(t))
> > > > > +               return BTF_FIELD_IGNORE;
> > > > > +       t = btf_type_by_id(btf, t->type);
> > > > > +
> > > > > +       if (!btf_type_is_type_tag(t))
> > > > > +               return BTF_FIELD_IGNORE;
> > > > > +       /* Reject extra tags */
> > > > > +       if (btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
> > > > > +               return -EINVAL;
> > > >
> > > > Can we have tag -> const -> tag -> volatile -> tag in BTF? Wouldn't
> > > > you assume there are no more tags with just this check?
> > > >
> > >
> > > All tags are supposed to be before other modifiers, so tags come first, in
> > > continuity. See [0].
> >
> > Doesn't seem like kernel's BTF validator enforces this, we should
> > probably tighten that up a bit. Clang won't emit such BTF, but nothing
> > prevents user from generating non-conformant BTF on its own either.
> >
>
> Right, what would be a good place to do this validation? When loading a BTF
> using bpf(2) syscall, or when we do this btf_parse_kptrs?

Given this is generic BTF property we are expecting and enforcing, it
should be in normal BTF validation logic.

>
> > >
> > > Alexei suggested to reject all other tags for now.
> > >
> > >  [0]: https://lore.kernel.org/bpf/20220127154627.665163-1-yhs@fb.com
> > >
> > > >
> > > > > +       if (strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       /* Get the base type */
> > > > > +       if (btf_type_is_modifier(t))
> > > > > +               t = btf_type_skip_modifiers(btf, t->type, NULL);
> > > > > +       /* Only pointer to struct is allowed */
> > > > > +       if (!__btf_type_is_struct(t))
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       info->type = t;
> > > > > +       info->off = off;
> > > > > +       return BTF_FIELD_FOUND;
> > > > >  }
> >
> > [...]
> >
> > > > > +       if (map_value_has_kptr(map)) {
> > > > > +               if (!bpf_capable())
> > > > > +                       return -EPERM;
> > > > > +               if (map->map_flags & BPF_F_RDONLY_PROG) {
> > > > > +                       ret = -EACCES;
> > > > > +                       goto free_map_tab;
> > > > > +               }
> > > > > +               if (map->map_type != BPF_MAP_TYPE_HASH &&
> > > > > +                   map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> > > > > +                   map->map_type != BPF_MAP_TYPE_ARRAY) {
> > > >
> > > > what about PERCPU_ARRAY, for instance? Is there something
> > > > fundamentally wrong to support it for local storage maps?
> > > >
> > >
> > > Plugging in support into maps that already take timers was easier to begin, I
> > > can do percpu support as a follow up.
> > >
> > > In case of local storage, I'm a little worried about how we prevent creating
> > > reference cycles. There was a thread where find_get_task_by_pid was proposed as
> > > unstable helper, once we e.g. support embedding task_struct in map, and allow
> > > storing such pointer in task local storage, it would be pretty easy to construct
> > > a circular reference cycle.
> > >
> > > Should we think about this now, or should we worry about this when task_struct
> > > is actually supported as kptr? It's not only task_struct, same applies to sock.
> > >
> > > There's a discussion to be had, hence I left it out for now.
> >
> > PERCPU_ARRAY seemed (and still seems) like a safe map to support (same
> > as PERCPU_HASH), which is why I asked. I see concerns about local
> > storage, though, thanks.
> >
>
> I'll look into it after this lands.
>
> > >
> > > > > +                       ret = -EOPNOTSUPP;
> > > > > +                       goto free_map_tab;
> > > > > +               }
> > > > > +       }
> > > > > +

[...]
