Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E741515AEF
	for <lists+bpf@lfdr.de>; Sat, 30 Apr 2022 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382244AbiD3HUv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Apr 2022 03:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377650AbiD3HUu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Apr 2022 03:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BED8B6D08
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651303047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tykVI9/zoqtl7cmOgED25FcoQmE9xTThulvos9c73qM=;
        b=A4UnNzBGCfFxf1m8y0O6texr325Iq1PBd1dJyxgRik7JKmQ3DEqc9+1JHsbq9dKxwi96xO
        CUb6UvUT0TJQhu937tmBnakH/2LWMX22pQueag1w79RHfXdhqCNXKt8F37h7lOAb1ywFpS
        sD5p2Lm/VmZOTg+DQOYwZk3gPfiEUy4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-wVvQajv3N2Gx806S1soXew-1; Sat, 30 Apr 2022 03:17:26 -0400
X-MC-Unique: wVvQajv3N2Gx806S1soXew-1
Received: by mail-pj1-f69.google.com with SMTP id a23-20020a17090a6d9700b001d60327d73aso7978612pjk.7
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 00:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tykVI9/zoqtl7cmOgED25FcoQmE9xTThulvos9c73qM=;
        b=FL/tD6xdz3Vyf3r9ZzO3xV9Co8uJu17FFGspg/uL/NgOGdENuhyz7ORGM7bbENPbx0
         iHmUq7/xQlaCYRbQCQ/8ZRzDd0tFPfUqQt9O6ifKkWLizZcj2pAMiKf+ZASQlWH0yjan
         K1n/SKvkTkMSH0KwKo8SQ/gKaKCy+qOz9La81RkPNUMHRuN3DR/NHnqw1ELmtMawjdcD
         ihK3eIDqswAGKN5i6NZqsbUhQFqjiXUtcgx6on8Owyon8UuEmdYGop6T3lAelM2qDXUq
         MruQOlrp0OtmMwfTYE/dbcYom+99Zp36YilBgFNBUon1zmzW83vv+YsERh6GONKPVDCt
         8LVA==
X-Gm-Message-State: AOAM5322cpcaxU3/O2n3G/Hbcp315cRfoCPSYJW2tfju/8qOTbFkmKb7
        ddOyunLAofbNIDOrSxVuM3jYxienGZ9IGo3AG8l/yCkmQiAgv0d1Tfu1yEX5FazV8TYtsSAiUwS
        C1uBgkvTrhW+d/wB4orEQkZbNe9Xe
X-Received: by 2002:a17:90a:e008:b0:1d9:2f9a:b7f1 with SMTP id u8-20020a17090ae00800b001d92f9ab7f1mr7863946pjy.173.1651303044907;
        Sat, 30 Apr 2022 00:17:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVaSGO6mjpNduoKcpZKvEOVufQoqqULad8OAK6f9TVKQ27a+ZWEP4Nx5zY7Hfttm8lP2FCPlCwTiXb5Wn7HEs=
X-Received: by 2002:a17:90a:e008:b0:1d9:2f9a:b7f1 with SMTP id
 u8-20020a17090ae00800b001d92f9ab7f1mr7863937pjy.173.1651303044637; Sat, 30
 Apr 2022 00:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220421140740.459558-3-benjamin.tissoires@redhat.com> <20220426040851.q3ovelrlcldvwhv5@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAO-hwJ+0w9-bX2LMJU1z7SGeGUbX1t-iMtfkrK=4M5HcfyjFCw@mail.gmail.com> <CAADnVQK2jJc94UTQyqKCs_CnWcLYmAP37-YcH=_DsPOrtAbDhA@mail.gmail.com>
In-Reply-To: <CAADnVQK2jJc94UTQyqKCs_CnWcLYmAP37-YcH=_DsPOrtAbDhA@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Sat, 30 Apr 2022 09:17:13 +0200
Message-ID: <CAO-hwJ+kj8LQJz8vMezkQOgUcUy28v3U2CTishDjS03DJeFa7A@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 2/7] bpf/verifier: allow kfunc to return an
 allocated mem
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 30, 2022 at 5:26 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 26, 2022 at 12:30 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Tue, Apr 26, 2022 at 6:09 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Apr 21, 2022 at 04:07:35PM +0200, Benjamin Tissoires wrote:
> > > > When a kfunc is not returning a pointer to a struct but to a plain type,
> > > > check if one of the arguments is called __sz and is a const from the
> > > > caller, and use this as the size of the allocated memory.
> > > >
> > > > For tracing programs, we consider the provided memory to be read only
> > > > unless the program is BPF_MODIFY_RETURN.
> > > >
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > >
> > > > ---
> > > >
> > > > new in v4
> > > > ---
> > > >  include/linux/btf.h   |  6 ++++
> > > >  kernel/bpf/btf.c      | 31 ++++++++++++++++----
> > > >  kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++----------
> > > >  3 files changed, 83 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > > index 36bc09b8e890..76a3ff48ae2a 100644
> > > > --- a/include/linux/btf.h
> > > > +++ b/include/linux/btf.h
> > > > @@ -332,6 +332,12 @@ static inline struct btf_param *btf_params(const struct btf_type *t)
> > > >       return (struct btf_param *)(t + 1);
> > > >  }
> > > >
> > > > +struct bpf_reg_state;
> > > > +
> > > > +bool btf_is_kfunc_arg_mem_size(const struct btf *btf,
> > > > +                            const struct btf_param *arg,
> > > > +                            const struct bpf_reg_state *reg);
> > > > +
> > > >  #ifdef CONFIG_BPF_SYSCALL
> > > >  struct bpf_prog;
> > > >
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 76318a4c2d0e..22e6e3cdc7ee 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -5851,9 +5851,9 @@ static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
> > > >       return true;
> > > >  }
> > > >
> > > > -static bool is_kfunc_arg_mem_size(const struct btf *btf,
> > > > -                               const struct btf_param *arg,
> > > > -                               const struct bpf_reg_state *reg)
> > > > +bool btf_is_kfunc_arg_mem_size(const struct btf *btf,
> > > > +                            const struct btf_param *arg,
> > > > +                            const struct bpf_reg_state *reg)
> > > >  {
> > > >       int len, sfx_len = sizeof("__sz") - 1;
> > > >       const struct btf_type *t;
> > > > @@ -5976,7 +5976,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >                               reg_btf = reg->btf;
> > > >                               reg_ref_id = reg->btf_id;
> > > >                               /* Ensure only one argument is referenced
> > > > -                              * PTR_TO_BTF_ID, check_func_arg_reg_off relies
> > > > +                              * PTR_TO_BTF_ID or PTR_TO_MEM, check_func_arg_reg_off relies
> > > >                                * on only one referenced register being allowed
> > > >                                * for kfuncs.
> > > >                                */
> > > > @@ -6012,7 +6012,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >                       u32 type_size;
> > > >
> > > >                       if (is_kfunc) {
> > > > -                             bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> > > > +                             bool arg_mem_size = i + 1 < nargs &&
> > > > +                                                 btf_is_kfunc_arg_mem_size(btf,
> > > > +                                                                           &args[i + 1],
> > > > +                                                                           &regs[regno + 1]);
> > >
> > > bpf allows ~100 chars. No need to break the line so much.
> > >
> > > >
> > > >                               /* Permit pointer to mem, but only when argument
> > > >                                * type is pointer to scalar, or struct composed
> > > > @@ -6039,6 +6042,24 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >                                       i++;
> > > >                                       continue;
> > > >                               }
> > > > +
> > > > +                             if (rel && reg->ref_obj_id) {
> > > > +                                     /* Ensure only one argument is referenced
> > > > +                                      * PTR_TO_BTF_ID or PTR_TO_MEM, check_func_arg_reg_off
> > > > +                                      * relies on only one referenced register being allowed
> > > > +                                      * for kfuncs.
> > > > +                                      */
> > > > +                                     if (ref_obj_id) {
> > > > +                                             bpf_log(log,
> > > > +                                                     "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> > > > +                                                     regno,
> > > > +                                                     reg->ref_obj_id,
> > > > +                                                     ref_obj_id);
> > > > +                                             return -EFAULT;
> > > > +                                     }
> > > > +                                     ref_regno = regno;
> > > > +                                     ref_obj_id = reg->ref_obj_id;
> > > > +                             }
> > > >                       }
> > > >
> > > >                       resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 71827d14724a..0f339f9058f3 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -6974,7 +6974,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > > >       int err, insn_idx = *insn_idx_p;
> > > >       const struct btf_param *args;
> > > >       struct btf *desc_btf;
> > > > +     enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> > > >       bool acq;
> > > > +     size_t reg_size = 0;
> > > >
> > > >       /* skip for now, but return error when we find this in fixup_kfunc_call */
> > > >       if (!insn->imm)
> > > > @@ -7015,8 +7017,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > > >               }
> > > >       }
> > > >
> > > > -     for (i = 0; i < CALLER_SAVED_REGS; i++)
> > > > -             mark_reg_not_init(env, regs, caller_saved[i]);
> > > > +     /* reset REG_0 */
> > > > +     mark_reg_not_init(env, regs, BPF_REG_0);
> > > >
> > > >       /* Check return type */
> > > >       t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
> > > > @@ -7026,6 +7028,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > +     nargs = btf_type_vlen(func_proto);
> > > > +     args = btf_params(func_proto);
> > > > +
> > > >       if (btf_type_is_scalar(t)) {
> > > >               mark_reg_unknown(env, regs, BPF_REG_0);
> > > >               mark_btf_func_reg_size(env, BPF_REG_0, t->size);
> > > > @@ -7033,24 +7038,54 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > > >               ptr_type = btf_type_skip_modifiers(desc_btf, t->type,
> > > >                                                  &ptr_type_id);
> > > >               if (!btf_type_is_struct(ptr_type)) {
> > > > -                     ptr_type_name = btf_name_by_offset(desc_btf,
> > > > -                                                        ptr_type->name_off);
> > > > -                     verbose(env, "kernel function %s returns pointer type %s %s is not supported\n",
> > > > -                             func_name, btf_type_str(ptr_type),
> > > > -                             ptr_type_name);
> > > > -                     return -EINVAL;
> > > > +                     /* if we have an array, we must have a const argument named "__sz" */
> > > > +                     for (i = 0; i < nargs; i++) {
> > > > +                             u32 regno = i + BPF_REG_1;
> > > > +                             struct bpf_reg_state *reg = &regs[regno];
> > > > +
> > > > +                             /* look for any const scalar parameter of name "__sz" */
> > > > +                             if (!check_reg_arg(env, regno, SRC_OP) &&
> > > > +                                 tnum_is_const(regs[regno].var_off) &&
> > > > +                                 btf_is_kfunc_arg_mem_size(desc_btf, &args[i], reg))
> > > > +                                     reg_size = regs[regno].var_off.value;
> > > > +                     }
> > > > +
> > > > +                     if (!reg_size) {
> > > > +                             ptr_type_name = btf_name_by_offset(desc_btf,
> > > > +                                                                ptr_type->name_off);
> > > > +                             verbose(env,
> > > > +                                     "kernel function %s returns pointer type %s %s is not supported\n",
> > > > +                                     func_name,
> > > > +                                     btf_type_str(ptr_type),
> > > > +                                     ptr_type_name);
> > > > +                             return -EINVAL;
> > > > +                     }
> > > > +
> > > > +                     mark_reg_known_zero(env, regs, BPF_REG_0);
> > > > +                     regs[BPF_REG_0].type = PTR_TO_MEM;
> > > > +                     regs[BPF_REG_0].mem_size = reg_size;
> > > > +
> > > > +                     /* in case of tracing, only allow write access to
> > > > +                      * BPF_MODIFY_RETURN programs
> > > > +                      */
> > > > +                     if (prog_type == BPF_PROG_TYPE_TRACING &&
> > > > +                         env->prog->expected_attach_type != BPF_MODIFY_RETURN)
> > > > +                             regs[BPF_REG_0].type |= MEM_RDONLY;
> > >
> > > MOD_RET restriction looks artificial.
> > > We can distinguish readonly vs writeable PTR_TO_MEM based on
> > > another naming convention.
> > > Currently arg_name__sz applies to the previous argument.
> > > Matching suffix made sense there.
> >
> > Oh, I missed the point of the "__sz". I did not realize it was
> > supposed to be a suffix.
> >
> > > Reusing the same suffix matching for a different purpose could be confusing.
> > > For this use case we may reserve a full argument name.
> > > Like "rdonly_buf_size" and "rdwr_buf_size" ?
> > >
> >
> > I like the idea but I have 2 problems here:
> > 1. I do not really want to have 2 separate kfuncs for read only and
> > write operations
> > 2. How can I restrict the write operation to fmod_ret?
> >
> > For 1, my guess is that the read-only operation will not be used
> > unless we solve 2.
> > For 2, the rationale is that I think tracing functions are not
> > supposed to change the behavior. This was said on the thread about
> > priorities for BPF programs. And it somehow makes sense that fentry
> > should be used for tracing only. OTOH, fmod_ret is clearly affecting
> > the behavior of the program, so I see it more "natural" that it can
> > change the context too.
>
> Well, if we say that fentry is rdonly and fmod_ret is rdwr
> then we probably shouldn't stop at return value.

Yeah, it makes sense, but it will be a slightly bigger effort.

> If bpf prog can access the argument and this argument is an array
> it should be writable.
> We can allow different kfuncs for fentry and fmod_ret too.

Good idea. No idea if this will be easy to implement though :)

But after the prototype I describe in 0/7 I don't really need to
enforce if read or write is based on fentry/fmod_ret.
So I think let's not over engineer this, and stick to your initial
suggestion of the naming system which will be largely enough for my
use case.

> They can be two tiny wrappers with different arg names (to distinguish
> rdonly vs rdwr) on top of the single always_inline function
> that returns a buffer.
>

Cheers,
Benjamin

