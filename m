Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ACB4E753E
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 15:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbiCYOoK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 10:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiCYOoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 10:44:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61427D8F73
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:42:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z16so6614966pfh.3
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HMdjUjXvlsLqYDt15qXj516pQNJiFjQgGZNh3N4TevQ=;
        b=LuC86gdj1sAHKTrbbC+ZXt36ti9XZOhPZuhxNLhr+uUl4K37Gi/uflhQLHefYHjlV4
         2daq04hfRP24MNmMpBn/f2rhCiEF75+a4R9Dmzh0b4kTnfh6Pbd/vAa3cJbbsD5v0fD5
         rbWRzN7vafFpl7xGjhwn0UBPgPSH1raBCa/hJQ0a2M2KV7H8gaN7wQFLz8fmyPNhVsim
         tzx+dKNXruOEl+Sa+cGoZ1bRTY0lq/C9jPhrLsKDvn9j6VrpMnbE00w0M1nxKpTR3eGD
         N0lqabOQX99H9s9CpVXI8fhcMiLfmdHS1ihHFAopNiBfHKjF7soO1ZQ2lHoXfeo4gEkP
         LCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HMdjUjXvlsLqYDt15qXj516pQNJiFjQgGZNh3N4TevQ=;
        b=W55IVWdeWkeXADUNjdXNIVwMIbTvdmGdG01LoaBFHSFrxvcnFgIc713KtVE5CTN7bK
         zgKaUPN0HkOv6wii6YX7DQG2dBy7NvwmxsWAhEkPaVcvnhkHGBy6OBY9d6M7TomETnul
         97JgNVvU3TDBxzJLPew/VgZU3WulknM+oyTg0M7V7r/gv2T1X8FHeb21FS4cc/JnRbOV
         vm7jZoL0Kt5xfcBE4Q0UBN6yEhcgsqBoU9QIxEWMSbfyrO2LjPjwo+4Zfuqajv2+A3Gr
         xCJlrGhcAoTWwTw+JZpbzD/geOXDKhHoZ8hC3bIX09QA2zCmEYGI8xi9cyma7yBdzNmo
         P1Ew==
X-Gm-Message-State: AOAM533uK6MLVeGgTpzkYWZrmg160TaYCoTOMT9ViDopiZZBxwJOBdzr
        kj/qHC31/dgPBzp1lAvJqyg=
X-Google-Smtp-Source: ABdhPJxFf8pCEz5exXpWO6yxTJfJWx0O0BiJoVna71aWB8wz9k0oX3Sc7tAIDqncv5RkkTST3ZTMew==
X-Received: by 2002:a05:6a02:20c:b0:381:f276:98d6 with SMTP id bh12-20020a056a02020c00b00381f27698d6mr8031962pgb.39.1648219352614;
        Fri, 25 Mar 2022 07:42:32 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a4bc600b001c7ba889551sm5877608pjl.5.2022.03.25.07.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 07:42:32 -0700 (PDT)
Date:   Fri, 25 Mar 2022 20:12:29 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Allow storing unreferenced kptr
 in map
Message-ID: <20220325144229.z2cft7me2gwghwm6@apollo>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-4-memxor@gmail.com>
 <CAEf4BzaJuW8tdmFz_NDe8K2qeNuLcOjVo3ZP4g5H1Yp60sQrTA@mail.gmail.com>
 <20220322071640.nqc2he44grixyhle@apollo>
 <CAEf4BzYCuueZwFeGHxqcx=fZ5mEg2vQas7mKb2bj0MWp70VxCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYCuueZwFeGHxqcx=fZ5mEg2vQas7mKb2bj0MWp70VxCg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 23, 2022 at 12:22:20AM IST, Andrii Nakryiko wrote:
> On Tue, Mar 22, 2022 at 12:16 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, Mar 22, 2022 at 11:15:42AM IST, Andrii Nakryiko wrote:
> > > On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > This commit introduces a new pointer type 'kptr' which can be embedded
> > > > in a map value as holds a PTR_TO_BTF_ID stored by a BPF program during
> > > > its invocation. Storing to such a kptr, BPF program's PTR_TO_BTF_ID
> > > > register must have the same type as in the map value's BTF, and loading
> > > > a kptr marks the destination register as PTR_TO_BTF_ID with the correct
> > > > kernel BTF and BTF ID.
> > > >
> > > > Such kptr are unreferenced, i.e. by the time another invocation of the
> > > > BPF program loads this pointer, the object which the pointer points to
> > > > may not longer exist. Since PTR_TO_BTF_ID loads (using BPF_LDX) are
> > > > patched to PROBE_MEM loads by the verifier, it would safe to allow user
> > > > to still access such invalid pointer, but passing such pointers into
> > > > BPF helpers and kfuncs should not be permitted. A future patch in this
> > > > series will close this gap.
> > > >
> > > > The flexibility offered by allowing programs to dereference such invalid
> > > > pointers while being safe at runtime frees the verifier from doing
> > > > complex lifetime tracking. As long as the user may ensure that the
> > > > object remains valid, it can ensure data read by it from the kernel
> > > > object is valid.
> > > >
> > > > The user indicates that a certain pointer must be treated as kptr
> > > > capable of accepting stores of PTR_TO_BTF_ID of a certain type, by using
> > > > a BTF type tag 'kptr' on the pointed to type of the pointer. Then, this
> > > > information is recorded in the object BTF which will be passed into the
> > > > kernel by way of map's BTF information. The name and kind from the map
> > > > value BTF is used to look up the in-kernel type, and the actual BTF and
> > > > BTF ID is recorded in the map struct in a new kptr_off_tab member. For
> > > > now, only storing pointers to structs is permitted.
> > > >
> > > > An example of this specification is shown below:
> > > >
> > > >         #define __kptr __attribute__((btf_type_tag("kptr")))
> > > >
> > > >         struct map_value {
> > > >                 ...
> > > >                 struct task_struct __kptr *task;
> > > >                 ...
> > > >         };
> > > >
> > > > Then, in a BPF program, user may store PTR_TO_BTF_ID with the type
> > > > task_struct into the map, and then load it later.
> > > >
> > > > Note that the destination register is marked PTR_TO_BTF_ID_OR_NULL, as
> > > > the verifier cannot know whether the value is NULL or not statically, it
> > > > must treat all potential loads at that map value offset as loading a
> > > > possibly NULL pointer.
> > > >
> > > > Only BPF_LDX, BPF_STX, and BPF_ST with insn->imm = 0 (to denote NULL)
> > > > are allowed instructions that can access such a pointer. On BPF_LDX, the
> > > > destination register is updated to be a PTR_TO_BTF_ID, and on BPF_STX,
> > > > it is checked whether the source register type is a PTR_TO_BTF_ID with
> > > > same BTF type as specified in the map BTF. The access size must always
> > > > be BPF_DW.
> > > >
> > > > For the map in map support, the kptr_off_tab for outer map is copied
> > > > from the inner map's kptr_off_tab. It was chosen to do a deep copy
> > > > instead of introducing a refcount to kptr_off_tab, because the copy only
> > > > needs to be done when paramterizing using inner_map_fd in the map in map
> > > > case, hence would be unnecessary for all other users.
> > > >
> > > > It is not permitted to use MAP_FREEZE command and mmap for BPF map
> > > > having kptr, similar to the bpf_timer case.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  include/linux/bpf.h     |  29 +++++++-
> > > >  include/linux/btf.h     |   2 +
> > > >  kernel/bpf/btf.c        | 161 ++++++++++++++++++++++++++++++++++------
> > > >  kernel/bpf/map_in_map.c |   5 +-
> > > >  kernel/bpf/syscall.c    | 112 +++++++++++++++++++++++++++-
> > > >  kernel/bpf/verifier.c   | 120 ++++++++++++++++++++++++++++++
> > > >  6 files changed, 401 insertions(+), 28 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > > +static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
> > > > +                              u32 off, int sz, struct btf_field_info *info)
> > > > +{
> > > > +       /* For PTR, sz is always == 8 */
> > > > +       if (!btf_type_is_ptr(t))
> > > > +               return BTF_FIELD_IGNORE;
> > > > +       t = btf_type_by_id(btf, t->type);
> > > > +
> > > > +       if (!btf_type_is_type_tag(t))
> > > > +               return BTF_FIELD_IGNORE;
> > > > +       /* Reject extra tags */
> > > > +       if (btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
> > > > +               return -EINVAL;
> > >
> > > Can we have tag -> const -> tag -> volatile -> tag in BTF? Wouldn't
> > > you assume there are no more tags with just this check?
> > >
> >
> > All tags are supposed to be before other modifiers, so tags come first, in
> > continuity. See [0].
>
> Doesn't seem like kernel's BTF validator enforces this, we should
> probably tighten that up a bit. Clang won't emit such BTF, but nothing
> prevents user from generating non-conformant BTF on its own either.
>

Right, what would be a good place to do this validation? When loading a BTF
using bpf(2) syscall, or when we do this btf_parse_kptrs?

> >
> > Alexei suggested to reject all other tags for now.
> >
> >  [0]: https://lore.kernel.org/bpf/20220127154627.665163-1-yhs@fb.com
> >
> > >
> > > > +       if (strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
> > > > +               return -EINVAL;
> > > > +
> > > > +       /* Get the base type */
> > > > +       if (btf_type_is_modifier(t))
> > > > +               t = btf_type_skip_modifiers(btf, t->type, NULL);
> > > > +       /* Only pointer to struct is allowed */
> > > > +       if (!__btf_type_is_struct(t))
> > > > +               return -EINVAL;
> > > > +
> > > > +       info->type = t;
> > > > +       info->off = off;
> > > > +       return BTF_FIELD_FOUND;
> > > >  }
>
> [...]
>
> > > > +       if (map_value_has_kptr(map)) {
> > > > +               if (!bpf_capable())
> > > > +                       return -EPERM;
> > > > +               if (map->map_flags & BPF_F_RDONLY_PROG) {
> > > > +                       ret = -EACCES;
> > > > +                       goto free_map_tab;
> > > > +               }
> > > > +               if (map->map_type != BPF_MAP_TYPE_HASH &&
> > > > +                   map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> > > > +                   map->map_type != BPF_MAP_TYPE_ARRAY) {
> > >
> > > what about PERCPU_ARRAY, for instance? Is there something
> > > fundamentally wrong to support it for local storage maps?
> > >
> >
> > Plugging in support into maps that already take timers was easier to begin, I
> > can do percpu support as a follow up.
> >
> > In case of local storage, I'm a little worried about how we prevent creating
> > reference cycles. There was a thread where find_get_task_by_pid was proposed as
> > unstable helper, once we e.g. support embedding task_struct in map, and allow
> > storing such pointer in task local storage, it would be pretty easy to construct
> > a circular reference cycle.
> >
> > Should we think about this now, or should we worry about this when task_struct
> > is actually supported as kptr? It's not only task_struct, same applies to sock.
> >
> > There's a discussion to be had, hence I left it out for now.
>
> PERCPU_ARRAY seemed (and still seems) like a safe map to support (same
> as PERCPU_HASH), which is why I asked. I see concerns about local
> storage, though, thanks.
>

I'll look into it after this lands.

> >
> > > > +                       ret = -EOPNOTSUPP;
> > > > +                       goto free_map_tab;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       if (map->ops->map_check_btf) {
> > > >                 ret = map->ops->map_check_btf(map, btf, key_type, value_type);
> > > > +               if (ret < 0)
> > > > +                       goto free_map_tab;
> > > > +       }
> > > >
> > > > +       return ret;
> > > > +free_map_tab:
> > > > +       bpf_map_free_kptr_off_tab(map);
> > > >         return ret;
> > > >  }
> > > >
> > > > @@ -1639,7 +1745,7 @@ static int map_freeze(const union bpf_attr *attr)
> > > >                 return PTR_ERR(map);
> > > >
> > > >         if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
> > > > -           map_value_has_timer(map)) {
> > > > +           map_value_has_timer(map) || map_value_has_kptr(map)) {
> > > >                 fdput(f);
> > > >                 return -ENOTSUPP;
> > > >         }
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 4ce9a528fb63..744b7362e52e 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -3507,6 +3507,94 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
> > > >         return __check_ptr_off_reg(env, reg, regno, false);
> > > >  }
> > > >
> > > > +static int map_kptr_match_type(struct bpf_verifier_env *env,
> > > > +                              struct bpf_map_value_off_desc *off_desc,
> > > > +                              struct bpf_reg_state *reg, u32 regno)
> > > > +{
> > > > +       const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
> > > > +       const char *reg_name = "";
> > > > +
> > > > +       if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
> > >
> > > base_type(reg->type) != PTR_TO_BTF_ID ?
> > >
> > > > +               goto bad_type;
> > > > +
> > > > +       if (!btf_is_kernel(reg->btf)) {
> > > > +               verbose(env, "R%d must point to kernel BTF\n", regno);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +       /* We need to verify reg->type and reg->btf, before accessing reg->btf */
> > > > +       reg_name = kernel_type_name(reg->btf, reg->btf_id);
> > > > +
> > > > +       if (__check_ptr_off_reg(env, reg, regno, true))
> > > > +               return -EACCES;
> > > > +
> > > > +       if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > > > +                                 off_desc->btf, off_desc->btf_id))
> > > > +               goto bad_type;
> > > > +       return 0;
> > > > +bad_type:
> > > > +       verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
> > > > +               reg_type_str(env, reg->type), reg_name);
> > > > +       verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> > >
> > > why two separate verbose calls, you can easily combine them (and they
> > > should be output on a single line given it's a single error)
> > >
> >
> > reg_type_str cannot be called more than once in the same statement, since it
> > reuses the same buffer.
> >
>
> ah, subtle, ok, never mind then, no big deal to have two verbose()
> calls if there is a reason for it
>
> > > > +       return -EINVAL;
> > > > +}
> > > > +
> > >
> > > [...]
> >
> > --
> > Kartikeya

--
Kartikeya
