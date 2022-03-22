Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA434E4649
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 19:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiCVSyB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCVSyA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 14:54:00 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FFC8CDB9
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 11:52:32 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z7so21341579iom.1
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+HFPZJkMQ8Gpd8OOaaNp3lE16NYVQ8vNrG0egyXRjQ=;
        b=ohw9m390CsfpgLi3HfgBgHC89TIm0ujLD/Lwu0rHy6rskJULf83JyMbh29acOBd2u7
         kLihX5NQsERTjSGcVuNsOF3KsfQoPgF+4PZfJI+92Hh0eS6pe9ZozHJrGbo/W/geOXfv
         EhuWwlV62d0iqFIBh2cGF+8CniaSRZSdB4udT3CIYXewHoZ+eD22so5yCAPpn5PTw7yq
         0+jD2D5XMef5NlZGeXlZVlinGBgQuIqIXYqcxk78DU1w3i7dVZMNSiUsqZGGxy1EZuul
         LWQi/PufRZzkJ3tFD6LIz4vqz1dXu3IXa1JNELD58Ho0wXus0aM2A9wvAvpr6HznjFur
         Stgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+HFPZJkMQ8Gpd8OOaaNp3lE16NYVQ8vNrG0egyXRjQ=;
        b=vhEbkcqXSg7iqF7hCTi10kuZmGthfqbSXj8LUM3Pp/35lQlAqqCCdWAO16uboDJTE8
         RsBFkaZS1OPgAWeNRP1CVUyxP/+rxtBu8KRydTlJyCUGv75gbtvXBcHV41Kgx3/DfIPM
         uUFhS0ciymiJSsQBySdFnx74imSp/18AMdaenaN0fDlemuQnxj5EPXJw+3l7hqlmKReV
         bag4HKhhcN4oo7astP/HFwUfcS34SczIUesgy+5VPN3StHwUkY4us2noPQXB3vim17V5
         LUOqAzodvK+Qs4dQfXgBoLO4s4uXnbYziKWWqAxqMUjsdCKM43EanvVitqBVUHjRz2VD
         z8Kw==
X-Gm-Message-State: AOAM531VCg/Twx7CC5a/aX1xMBQr/RV/OmN54XVf68qrFYqSZu3MXdXQ
        jLFlcMKNnc8s/hqJFSYuRv20sp1X/tGLe29PSrE=
X-Google-Smtp-Source: ABdhPJwTSQXq2g5RausHxvBVFD+ND3F9zV6diapu2YdtRAJOyFQYx4bO6O6Fd55iJJT/mG3geuqCinTXcxWBPmOB8QM=
X-Received: by 2002:a5d:948a:0:b0:645:b742:87c0 with SMTP id
 v10-20020a5d948a000000b00645b74287c0mr12638042ioj.79.1647975151577; Tue, 22
 Mar 2022 11:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220320155510.671497-1-memxor@gmail.com> <20220320155510.671497-4-memxor@gmail.com>
 <CAEf4BzaJuW8tdmFz_NDe8K2qeNuLcOjVo3ZP4g5H1Yp60sQrTA@mail.gmail.com> <20220322071640.nqc2he44grixyhle@apollo>
In-Reply-To: <20220322071640.nqc2he44grixyhle@apollo>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 22 Mar 2022 11:52:20 -0700
Message-ID: <CAEf4BzYCuueZwFeGHxqcx=fZ5mEg2vQas7mKb2bj0MWp70VxCg@mail.gmail.com>
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

On Tue, Mar 22, 2022 at 12:16 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, Mar 22, 2022 at 11:15:42AM IST, Andrii Nakryiko wrote:
> > On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
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
> >
> > [...]
> >
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
> >
> > Can we have tag -> const -> tag -> volatile -> tag in BTF? Wouldn't
> > you assume there are no more tags with just this check?
> >
>
> All tags are supposed to be before other modifiers, so tags come first, in
> continuity. See [0].

Doesn't seem like kernel's BTF validator enforces this, we should
probably tighten that up a bit. Clang won't emit such BTF, but nothing
prevents user from generating non-conformant BTF on its own either.

>
> Alexei suggested to reject all other tags for now.
>
>  [0]: https://lore.kernel.org/bpf/20220127154627.665163-1-yhs@fb.com
>
> >
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

[...]

> > > +       if (map_value_has_kptr(map)) {
> > > +               if (!bpf_capable())
> > > +                       return -EPERM;
> > > +               if (map->map_flags & BPF_F_RDONLY_PROG) {
> > > +                       ret = -EACCES;
> > > +                       goto free_map_tab;
> > > +               }
> > > +               if (map->map_type != BPF_MAP_TYPE_HASH &&
> > > +                   map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> > > +                   map->map_type != BPF_MAP_TYPE_ARRAY) {
> >
> > what about PERCPU_ARRAY, for instance? Is there something
> > fundamentally wrong to support it for local storage maps?
> >
>
> Plugging in support into maps that already take timers was easier to begin, I
> can do percpu support as a follow up.
>
> In case of local storage, I'm a little worried about how we prevent creating
> reference cycles. There was a thread where find_get_task_by_pid was proposed as
> unstable helper, once we e.g. support embedding task_struct in map, and allow
> storing such pointer in task local storage, it would be pretty easy to construct
> a circular reference cycle.
>
> Should we think about this now, or should we worry about this when task_struct
> is actually supported as kptr? It's not only task_struct, same applies to sock.
>
> There's a discussion to be had, hence I left it out for now.

PERCPU_ARRAY seemed (and still seems) like a safe map to support (same
as PERCPU_HASH), which is why I asked. I see concerns about local
storage, though, thanks.

>
> > > +                       ret = -EOPNOTSUPP;
> > > +                       goto free_map_tab;
> > > +               }
> > > +       }
> > > +
> > > +       if (map->ops->map_check_btf) {
> > >                 ret = map->ops->map_check_btf(map, btf, key_type, value_type);
> > > +               if (ret < 0)
> > > +                       goto free_map_tab;
> > > +       }
> > >
> > > +       return ret;
> > > +free_map_tab:
> > > +       bpf_map_free_kptr_off_tab(map);
> > >         return ret;
> > >  }
> > >
> > > @@ -1639,7 +1745,7 @@ static int map_freeze(const union bpf_attr *attr)
> > >                 return PTR_ERR(map);
> > >
> > >         if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
> > > -           map_value_has_timer(map)) {
> > > +           map_value_has_timer(map) || map_value_has_kptr(map)) {
> > >                 fdput(f);
> > >                 return -ENOTSUPP;
> > >         }
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 4ce9a528fb63..744b7362e52e 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3507,6 +3507,94 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
> > >         return __check_ptr_off_reg(env, reg, regno, false);
> > >  }
> > >
> > > +static int map_kptr_match_type(struct bpf_verifier_env *env,
> > > +                              struct bpf_map_value_off_desc *off_desc,
> > > +                              struct bpf_reg_state *reg, u32 regno)
> > > +{
> > > +       const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
> > > +       const char *reg_name = "";
> > > +
> > > +       if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
> >
> > base_type(reg->type) != PTR_TO_BTF_ID ?
> >
> > > +               goto bad_type;
> > > +
> > > +       if (!btf_is_kernel(reg->btf)) {
> > > +               verbose(env, "R%d must point to kernel BTF\n", regno);
> > > +               return -EINVAL;
> > > +       }
> > > +       /* We need to verify reg->type and reg->btf, before accessing reg->btf */
> > > +       reg_name = kernel_type_name(reg->btf, reg->btf_id);
> > > +
> > > +       if (__check_ptr_off_reg(env, reg, regno, true))
> > > +               return -EACCES;
> > > +
> > > +       if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > > +                                 off_desc->btf, off_desc->btf_id))
> > > +               goto bad_type;
> > > +       return 0;
> > > +bad_type:
> > > +       verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
> > > +               reg_type_str(env, reg->type), reg_name);
> > > +       verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> >
> > why two separate verbose calls, you can easily combine them (and they
> > should be output on a single line given it's a single error)
> >
>
> reg_type_str cannot be called more than once in the same statement, since it
> reuses the same buffer.
>

ah, subtle, ok, never mind then, no big deal to have two verbose()
calls if there is a reason for it

> > > +       return -EINVAL;
> > > +}
> > > +
> >
> > [...]
>
> --
> Kartikeya
