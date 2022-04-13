Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08C44FEEBC
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 07:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiDMFxL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 01:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiDMFxK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 01:53:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46150442
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 22:50:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so1049181plk.8
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 22:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LnDCbdfqtMBwSq/AehstOHMNmVa8Q5nPW+KVXKuvotU=;
        b=YOCVkhm09hIJ9l0/U2BKNNco71fbueG5BQ2xR7MX444rJ0r6aBeHRxtQ1dnQJNs5tK
         6etOzTYOmWV8n4aD4DnEmEYCXVNgHNg08mfmmz+kxCbnrtWnnsig1Med2oQS3WAB/+y4
         vh+TlHdS3NOVZT32DGiqpNS1FetsnU73kXu/ACY+V56VglLfG+OK38MfAgNq2cjtXqQe
         LtknR6/j0U7g1+GbIV1QZU1vPKH+cjvzSPnxpqsYHGBcsNrOTOcel2hpHypW+T3OGcp3
         dT8WH57JGUuDLr7ropoSlKksg2f/mPRHGymL70LgtLGSHnXH7ggzDztIc7ei6SZfAAhZ
         1yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LnDCbdfqtMBwSq/AehstOHMNmVa8Q5nPW+KVXKuvotU=;
        b=rMLg8lxONERTpRSiuniI1UA3a6i7WIY7XaPxiAXu7ZJtnQ8KRqbdcwUwH8zjOK9uql
         FS27eI71EdqRQZ0/5Iy9H3ciAXgQ68LsuikHS5voXCK/ZdfgWAnWGs6gZrIhXIU3ligt
         zi8Lr33rAns8ToLBEeCHmOvAyNcqZHYXR8P+OeLvFs84n6HRNmATzh/I4GPIovbwtt27
         muBpupAsZpQR2qXbAYFdgmGi0DMU0a3+xc+608s7Hri7lee3TNy6FEqAOk5ZXU5z0ijR
         FPfUYGCEAuVQ93P2XokDd2ni7NgFpJYFeiCzLJQwd/8EjQMj1OktMbzHy066JY42rYtH
         pZzQ==
X-Gm-Message-State: AOAM530sOSl3rMyAK6SJ8yoh7eWEkHc3Qo6nFAkCNRXoRfPtkEEGqWHv
        xqCkPzNZv6NZ4fHAgwF3IRo=
X-Google-Smtp-Source: ABdhPJyKP8/2N46vstzZKysDmJn7f0J4fmydLygwj5sd0Qp8ZDohE13qJU2S8JvmLuQp8FZPlhjY6w==
X-Received: by 2002:a17:90a:454a:b0:1ca:91c7:df66 with SMTP id r10-20020a17090a454a00b001ca91c7df66mr8807461pjm.186.1649829049580;
        Tue, 12 Apr 2022 22:50:49 -0700 (PDT)
Received: from localhost ([112.79.166.120])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b0050583cb0adbsm16657101pff.196.2022.04.12.22.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:50:49 -0700 (PDT)
Date:   Wed, 13 Apr 2022 11:20:49 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v4 03/13] bpf: Allow storing unreferenced kptr
 in map
Message-ID: <20220413055049.ufhax2phfb2viwlm@apollo.legion>
References: <20220409093303.499196-1-memxor@gmail.com>
 <20220409093303.499196-4-memxor@gmail.com>
 <CAJnrk1YA_y_kAr+Z4nq=0pJ0kxDz==dCNc62Fqdk_PXkwr=Wwg@mail.gmail.com>
 <20220412191629.bsuc37subi6mlpwa@apollo.legion>
 <CAJnrk1b+LdkAoRbTNQmxqzQGkS_rMk9qDCePpxissAVYBfHiyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b+LdkAoRbTNQmxqzQGkS_rMk9qDCePpxissAVYBfHiyg@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 13, 2022 at 05:26:12AM IST, Joanne Koong wrote:
> On Tue, Apr 12, 2022 at 12:16 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, Apr 12, 2022 at 06:02:11AM IST, Joanne Koong wrote:
> > > On Sat, Apr 9, 2022 at 6:18 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
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
> > > > Only BPF_LDX, BPF_STX, and BPF_ST (with insn->imm = 0 to denote NULL)
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
> > > > having kptrs, similar to the bpf_timer case.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  include/linux/bpf.h     |  29 +++++++-
> > > >  include/linux/btf.h     |   2 +
> > > >  kernel/bpf/btf.c        | 160 ++++++++++++++++++++++++++++++++++------
> > > >  kernel/bpf/map_in_map.c |   5 +-
> > > >  kernel/bpf/syscall.c    | 114 +++++++++++++++++++++++++++-
> > > >  kernel/bpf/verifier.c   | 116 ++++++++++++++++++++++++++++-
> > > >  6 files changed, 399 insertions(+), 27 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index bdb5298735ce..e267db260cb7 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -155,6 +155,22 @@ struct bpf_map_ops {
> > > >         const struct bpf_iter_seq_info *iter_seq_info;
> > > >  };
> > > >
> > > > +enum {
> > > > +       /* Support at most 8 pointers in a BPF map value */
> > > > +       BPF_MAP_VALUE_OFF_MAX = 8,
> > > > +};
> > > nit: should this be a typedef instead of an enum?
> >
> > typedef? Do you mean #define? I prefer enum constants as they get emitted to
> > BTF.
> Yeah I meant #define, not typedef :) Oh I see - out of curiosity since
> I'm still getting acquainted with BTF, what is the utility of the enum
> constant getting emitted to the vmlinux BTF? For more detailed
> debuggability?
>

Yes, once it becomes visible in BTF it will be available from vmlinux.h, so
instead of hardcoding the value you can refer to the enum constant by name, and
libbpf relocates it to the correct value on load as well, so overall it is more
convenient.

> > [...]
> > > > +       if (map_value_has_kptrs(map)) {
> > > > +               if (!bpf_capable()) {
> > > > +                       ret = -EPERM;
> > > > +                       goto free_map_tab;
> > > > +               }
> > > > +               if (map->map_flags & BPF_F_RDONLY_PROG) {
> > > Why is it an error if BPF_F_RDONLY_PROG is set? Maybe I'm
> > > misunderstanding what BPF_F_RDONLY_PROG means, but why can't a program
> > > have read-only access to the kptr value?
> >
> > It would be useless, kptr can only be set from inside a BPF program.
> If the kptr is embedded inside a larger struct, couldn't there be use
> cases where a program wants to read the other fields in this struct
> that have been updated by the userspace application?

It should already be able to read such fields without this flag, right? This
flag removes write permissions to the map from BPF program side, which would
make it useless for the purposes of kptr, since setting a kptr requires either
BPF_STX/BPF_ST for unreferenced case, or bpf_kptr_xchg for referenced case.

> >
> > > > +                       ret = -EACCES;
> > > > +                       goto free_map_tab;
> > > > +               }
> > > > +               if (map->map_type != BPF_MAP_TYPE_HASH &&
> > > > +                   map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> > > > +                   map->map_type != BPF_MAP_TYPE_ARRAY) {
> > > Out of curiosity, do you also plan to add kptr support in the future
> > > to local storage maps as well?
> >
> > Yes, those and percpu maps are on the TODO list.
> Awesome!!
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
> > > > @@ -1639,7 +1747,7 @@ static int map_freeze(const union bpf_attr *attr)
> > > >                 return PTR_ERR(map);
> > > >
> > > >         if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
> > > > -           map_value_has_timer(map)) {
> > > > +           map_value_has_timer(map) || map_value_has_kptrs(map)) {
> > > >                 fdput(f);
> > > >                 return -ENOTSUPP;
> > > >         }
> > >
> > > Maybe I'm missing something, but I'm not seeing it in this patch - do
> > > we also need to add checks that prohibit userspace programs from
> > > trying to do bpf_map_update_elem syscalls that manipulate kptr map
> > > values?
> >
> > Userspace should be allowed to do bpf_map_update_elem, whether map value has
> > timers, spin_lock, kptrs, or dynptrs in the future. copy_map_value will skip
> > over these fields when updating map value. See patch 7.
>
> Within the context of this patch, a userspace program can do
> bpf_map_update_elem, put in some unsafe value for the kptr, which will
> cause the bpf program to crash the kernel when it accesses that value.
> That was my main concern, but since this is going to be addressed in
> your patch 7, I don't think this matters then.
>

Yep, patch 7 is doing too much stuff, so I thought it would be best to split it
into its own patch to make review easier.

> >
> > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 71827d14724a..01d45c5010f9 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -3507,6 +3507,83 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
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
> > > > +       if (base_type(reg->type) != PTR_TO_BTF_ID || type_flag(reg->type) != PTR_MAYBE_NULL)
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
> > > > +       return -EINVAL;
> > > > +}
> > > > +
> > > > +static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> > > > +                                int value_regno, int insn_idx,
> > > > +                                struct bpf_map_value_off_desc *off_desc)
> > > > +{
> > > > +       struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
> > > > +       int class = BPF_CLASS(insn->code);
> > > > +       struct bpf_reg_state *val_reg;
> > > > +
> > > > +       /* Things we already checked for in check_map_access and caller:
> > > > +        *  - Reject cases where variable offset may touch kptr
> > > > +        *  - size of access (must be BPF_DW)
> > > > +        *  - tnum_is_const(reg->var_off)
> > > > +        *  - off_desc->offset == off + reg->var_off.value
> > > > +        */
> > > > +       /* Only BPF_[LDX,STX,ST] | BPF_MEM | BPF_DW is supported */
> > > > +       if (BPF_MODE(insn->code) != BPF_MEM)
> > > > +               goto end;
> > > I think this needs its own verbose statement - the one in end: doesn't
> > > seem to match this error
> >
> > Maybe we should say BPF_LDX_MEM, BPF_STX_MEM, BPF_ST_MEM?
> I think it'd be clearest if there were separate error messages for the
> case where the program is using a different mode than BPF_MEM vs. the
> program using an unsupported instruction class.

Ok, I'll add it.

> >
> > > > +
> > > > +       if (class == BPF_LDX) {
> > > > +               val_reg = reg_state(env, value_regno);
> > > > +               /* We can simply mark the value_regno receiving the pointer
> > > > +                * value from map as PTR_TO_BTF_ID, with the correct type.
> > > > +                */
> > > > +               mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->btf,
> > > > +                               off_desc->btf_id, PTR_MAYBE_NULL);
> > > > +               val_reg->id = ++env->id_gen;
> > > > +       } else if (class == BPF_STX) {
> > > > +               val_reg = reg_state(env, value_regno);
> > > > +               if (!register_is_null(val_reg) &&
> > > > +                   map_kptr_match_type(env, off_desc, val_reg, value_regno))
> > > > +                       return -EACCES;
> > > > +       } else if (class == BPF_ST) {
> > > > +               if (insn->imm) {
> > > > +                       verbose(env, "BPF_ST imm must be 0 when storing to kptr at off=%u\n",
> > > > +                               off_desc->offset);
> > > > +                       return -EACCES;
> > > > +               }
> > > > +       } else {
> > > > +               goto end;
> > > > +       }
> > > > +       return 0;
> > > > +end:
> > > > +       verbose(env, "kptr in map can only be accessed using BPF_LDX/BPF_STX/BPF_ST\n");
> > > > +       return -EACCES;
> > > > +}
> > > > +
> > > >  /* check read/write into a map element with possible variable offset */
> > > >  static int check_map_access(struct bpf_verifier_env *env, u32 regno,
> > > >                             int off, int size, bool zero_size_allowed)
> > > > @@ -3545,6 +3622,32 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
> > > >                         return -EACCES;
> > > >                 }
> > > >         }
> > > > +       if (map_value_has_kptrs(map)) {
> > > > +               struct bpf_map_value_off *tab = map->kptr_off_tab;
> > > > +               int i;
> > > > +
> > > > +               for (i = 0; i < tab->nr_off; i++) {
> > > > +                       u32 p = tab->off[i].offset;
> > > > +
> > > > +                       if (reg->smin_value + off < p + sizeof(u64) &&
> > > > +                           p < reg->umax_value + off + size) {
> > > > +                               if (!tnum_is_const(reg->var_off)) {
> > > > +                                       verbose(env, "kptr access cannot have variable offset\n");
> > > > +                                       return -EACCES;
> > > > +                               }
> > > > +                               if (p != off + reg->var_off.value) {
> > > > +                                       verbose(env, "kptr access misaligned expected=%u off=%llu\n",
> > > > +                                               p, off + reg->var_off.value);
> > > > +                                       return -EACCES;
> > > > +                               }
> > > > +                               if (size != bpf_size_to_bytes(BPF_DW)) {
> > > > +                                       verbose(env, "kptr access size must be BPF_DW\n");
> > > > +                                       return -EACCES;
> > > > +                               }
> > > > +                               break;
> > > > +                       }
> > > > +               }
> > > > +       }
> > > >         return err;
> > > >  }
> > > >
> > > > @@ -4412,6 +4515,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> > > >                 if (value_regno >= 0)
> > > >                         mark_reg_unknown(env, regs, value_regno);
> > > >         } else if (reg->type == PTR_TO_MAP_VALUE) {
> > > > +               struct bpf_map_value_off_desc *off_desc = NULL;
> > > > +
> > > >                 if (t == BPF_WRITE && value_regno >= 0 &&
> > > >                     is_pointer_value(env, value_regno)) {
> > > >                         verbose(env, "R%d leaks addr into map\n", value_regno);
> > > > @@ -4421,7 +4526,16 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> > > >                 if (err)
> > > >                         return err;
> > > >                 err = check_map_access(env, regno, off, size, false);
> > > > -               if (!err && t == BPF_READ && value_regno >= 0) {
> > > > +               if (err)
> > > > +                       return err;
> > > > +               if (tnum_is_const(reg->var_off))
> > > > +                       off_desc = bpf_map_kptr_off_contains(reg->map_ptr,
> > > > +                                                            off + reg->var_off.value);
> > > > +               if (off_desc) {
> > > I think this logic would be a little clearer if you renamed off_desc
> > > to kptr_off_desc to denote that this only applies to kptrs.
> >
> > Ok, will change.
> >
> > > > +                       err = check_map_kptr_access(env, regno, value_regno, insn_idx, off_desc);
> > > > +                       if (err)
> > > > +                               return err;
> > > I don't think you need this if check - it'll return err by default at
> > > the end of the function.
> >
> > Right, will drop this.
> >
> > > > +               } else if (t == BPF_READ && value_regno >= 0) {
> > > >                         struct bpf_map *map = reg->map_ptr;
> > > >
> > > >                         /* if map is read-only, track its contents as scalars */
> > > > --
> > > > 2.35.1
> > > >
> >
> > --
> > Kartikeya

--
Kartikeya
