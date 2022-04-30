Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63587515A20
	for <lists+bpf@lfdr.de>; Sat, 30 Apr 2022 05:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382126AbiD3D3U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Apr 2022 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240594AbiD3D3Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Apr 2022 23:29:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0F3DDD9;
        Fri, 29 Apr 2022 20:25:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i62so7825048pgd.6;
        Fri, 29 Apr 2022 20:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/rmb8mYDIfG0Dw8vTZLFMAEPsG/q8erNk+9VYwTdkg=;
        b=I6WvoswiznRnOAxJ07JT0J/zUA2m7hmIUBXHW1SIJG7eWjPrR8N+tUXHyBas0vSy6u
         qCyPAvs+6pVOeAeu5LEK9396HjkU5pgY/5y5LMRZsm+5F8Q/yibQAzwKUlEBjat/S/fD
         6ULCetFHwO8QKTs+gTf8QUS7N2maFnjyL4Ur+hSaDF/45eowzKMdbmqACGQc826qJJ1f
         zgiAbuJ/wbfFIViV0ElsCr6nS0rTR0Gq++FQftYKNcLoi179ji0czDYc36E7ZGfqiqxx
         Ii0qUkj644d3rrbWtwFkAchd4iOdeERMjUPBOobwbQ1mruXq2dLnuRMC4ilj/UrZZocF
         /0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/rmb8mYDIfG0Dw8vTZLFMAEPsG/q8erNk+9VYwTdkg=;
        b=XEQ9Q0xELrUt/rZd4fzuK7m4wODZw5qC08iPcolmOL8hiYGAzev000dUAP6NjS7QaF
         t1aC0OellvB0Ywvn/fqBxt/abzd6pwx4E4MgUamFDFLRsVdPB8mJjLZzf1BX/N6sbN4t
         jjY86FHrC9hPeLLA7x1WGSwBPrfHCO1WJ91Y7af3967mW4UMo2IrsiHQ2F+1e8cYjykB
         /VfxxvBTbG1TG5rqV+ekx2ZGgHlK21+SRtCEWRgq/Y4hJ1746NYCmggEN3/RiXTlgFC+
         E9uO4xLuO9QZhazN4XDrl1LuqAcUu6xFKLBsYEFPr8StavX4CCUWtr8SGt1KGYUugw1E
         R1Gw==
X-Gm-Message-State: AOAM532XRRUc4B1JYmKuPh5gRrgDu7FnEjvMXQx8IUDGbc3MNjEWvIBx
        QCOmJk+oTd2YCdFN776/rE9k4997Hwmhcxkcfkc=
X-Google-Smtp-Source: ABdhPJzXPaHYqtfJNgLlpRjIlztZU5R50o/ioVcsPfNm8OX4cCd5O7f+dna5yjUe4VmJu7X8bf7ajAVr2iepX0iTX54=
X-Received: by 2002:a65:6e41:0:b0:39c:c97b:2aef with SMTP id
 be1-20020a656e41000000b0039cc97b2aefmr1812385pgb.473.1651289155031; Fri, 29
 Apr 2022 20:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220421140740.459558-3-benjamin.tissoires@redhat.com> <20220426040851.q3ovelrlcldvwhv5@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAO-hwJ+0w9-bX2LMJU1z7SGeGUbX1t-iMtfkrK=4M5HcfyjFCw@mail.gmail.com>
In-Reply-To: <CAO-hwJ+0w9-bX2LMJU1z7SGeGUbX1t-iMtfkrK=4M5HcfyjFCw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 29 Apr 2022 20:25:43 -0700
Message-ID: <CAADnVQK2jJc94UTQyqKCs_CnWcLYmAP37-YcH=_DsPOrtAbDhA@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 2/7] bpf/verifier: allow kfunc to return an
 allocated mem
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 26, 2022 at 12:30 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Tue, Apr 26, 2022 at 6:09 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Apr 21, 2022 at 04:07:35PM +0200, Benjamin Tissoires wrote:
> > > When a kfunc is not returning a pointer to a struct but to a plain type,
> > > check if one of the arguments is called __sz and is a const from the
> > > caller, and use this as the size of the allocated memory.
> > >
> > > For tracing programs, we consider the provided memory to be read only
> > > unless the program is BPF_MODIFY_RETURN.
> > >
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> > > ---
> > >
> > > new in v4
> > > ---
> > >  include/linux/btf.h   |  6 ++++
> > >  kernel/bpf/btf.c      | 31 ++++++++++++++++----
> > >  kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++----------
> > >  3 files changed, 83 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > index 36bc09b8e890..76a3ff48ae2a 100644
> > > --- a/include/linux/btf.h
> > > +++ b/include/linux/btf.h
> > > @@ -332,6 +332,12 @@ static inline struct btf_param *btf_params(const struct btf_type *t)
> > >       return (struct btf_param *)(t + 1);
> > >  }
> > >
> > > +struct bpf_reg_state;
> > > +
> > > +bool btf_is_kfunc_arg_mem_size(const struct btf *btf,
> > > +                            const struct btf_param *arg,
> > > +                            const struct bpf_reg_state *reg);
> > > +
> > >  #ifdef CONFIG_BPF_SYSCALL
> > >  struct bpf_prog;
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 76318a4c2d0e..22e6e3cdc7ee 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -5851,9 +5851,9 @@ static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
> > >       return true;
> > >  }
> > >
> > > -static bool is_kfunc_arg_mem_size(const struct btf *btf,
> > > -                               const struct btf_param *arg,
> > > -                               const struct bpf_reg_state *reg)
> > > +bool btf_is_kfunc_arg_mem_size(const struct btf *btf,
> > > +                            const struct btf_param *arg,
> > > +                            const struct bpf_reg_state *reg)
> > >  {
> > >       int len, sfx_len = sizeof("__sz") - 1;
> > >       const struct btf_type *t;
> > > @@ -5976,7 +5976,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >                               reg_btf = reg->btf;
> > >                               reg_ref_id = reg->btf_id;
> > >                               /* Ensure only one argument is referenced
> > > -                              * PTR_TO_BTF_ID, check_func_arg_reg_off relies
> > > +                              * PTR_TO_BTF_ID or PTR_TO_MEM, check_func_arg_reg_off relies
> > >                                * on only one referenced register being allowed
> > >                                * for kfuncs.
> > >                                */
> > > @@ -6012,7 +6012,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >                       u32 type_size;
> > >
> > >                       if (is_kfunc) {
> > > -                             bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> > > +                             bool arg_mem_size = i + 1 < nargs &&
> > > +                                                 btf_is_kfunc_arg_mem_size(btf,
> > > +                                                                           &args[i + 1],
> > > +                                                                           &regs[regno + 1]);
> >
> > bpf allows ~100 chars. No need to break the line so much.
> >
> > >
> > >                               /* Permit pointer to mem, but only when argument
> > >                                * type is pointer to scalar, or struct composed
> > > @@ -6039,6 +6042,24 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >                                       i++;
> > >                                       continue;
> > >                               }
> > > +
> > > +                             if (rel && reg->ref_obj_id) {
> > > +                                     /* Ensure only one argument is referenced
> > > +                                      * PTR_TO_BTF_ID or PTR_TO_MEM, check_func_arg_reg_off
> > > +                                      * relies on only one referenced register being allowed
> > > +                                      * for kfuncs.
> > > +                                      */
> > > +                                     if (ref_obj_id) {
> > > +                                             bpf_log(log,
> > > +                                                     "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> > > +                                                     regno,
> > > +                                                     reg->ref_obj_id,
> > > +                                                     ref_obj_id);
> > > +                                             return -EFAULT;
> > > +                                     }
> > > +                                     ref_regno = regno;
> > > +                                     ref_obj_id = reg->ref_obj_id;
> > > +                             }
> > >                       }
> > >
> > >                       resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 71827d14724a..0f339f9058f3 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -6974,7 +6974,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > >       int err, insn_idx = *insn_idx_p;
> > >       const struct btf_param *args;
> > >       struct btf *desc_btf;
> > > +     enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> > >       bool acq;
> > > +     size_t reg_size = 0;
> > >
> > >       /* skip for now, but return error when we find this in fixup_kfunc_call */
> > >       if (!insn->imm)
> > > @@ -7015,8 +7017,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > >               }
> > >       }
> > >
> > > -     for (i = 0; i < CALLER_SAVED_REGS; i++)
> > > -             mark_reg_not_init(env, regs, caller_saved[i]);
> > > +     /* reset REG_0 */
> > > +     mark_reg_not_init(env, regs, BPF_REG_0);
> > >
> > >       /* Check return type */
> > >       t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
> > > @@ -7026,6 +7028,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > >               return -EINVAL;
> > >       }
> > >
> > > +     nargs = btf_type_vlen(func_proto);
> > > +     args = btf_params(func_proto);
> > > +
> > >       if (btf_type_is_scalar(t)) {
> > >               mark_reg_unknown(env, regs, BPF_REG_0);
> > >               mark_btf_func_reg_size(env, BPF_REG_0, t->size);
> > > @@ -7033,24 +7038,54 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > >               ptr_type = btf_type_skip_modifiers(desc_btf, t->type,
> > >                                                  &ptr_type_id);
> > >               if (!btf_type_is_struct(ptr_type)) {
> > > -                     ptr_type_name = btf_name_by_offset(desc_btf,
> > > -                                                        ptr_type->name_off);
> > > -                     verbose(env, "kernel function %s returns pointer type %s %s is not supported\n",
> > > -                             func_name, btf_type_str(ptr_type),
> > > -                             ptr_type_name);
> > > -                     return -EINVAL;
> > > +                     /* if we have an array, we must have a const argument named "__sz" */
> > > +                     for (i = 0; i < nargs; i++) {
> > > +                             u32 regno = i + BPF_REG_1;
> > > +                             struct bpf_reg_state *reg = &regs[regno];
> > > +
> > > +                             /* look for any const scalar parameter of name "__sz" */
> > > +                             if (!check_reg_arg(env, regno, SRC_OP) &&
> > > +                                 tnum_is_const(regs[regno].var_off) &&
> > > +                                 btf_is_kfunc_arg_mem_size(desc_btf, &args[i], reg))
> > > +                                     reg_size = regs[regno].var_off.value;
> > > +                     }
> > > +
> > > +                     if (!reg_size) {
> > > +                             ptr_type_name = btf_name_by_offset(desc_btf,
> > > +                                                                ptr_type->name_off);
> > > +                             verbose(env,
> > > +                                     "kernel function %s returns pointer type %s %s is not supported\n",
> > > +                                     func_name,
> > > +                                     btf_type_str(ptr_type),
> > > +                                     ptr_type_name);
> > > +                             return -EINVAL;
> > > +                     }
> > > +
> > > +                     mark_reg_known_zero(env, regs, BPF_REG_0);
> > > +                     regs[BPF_REG_0].type = PTR_TO_MEM;
> > > +                     regs[BPF_REG_0].mem_size = reg_size;
> > > +
> > > +                     /* in case of tracing, only allow write access to
> > > +                      * BPF_MODIFY_RETURN programs
> > > +                      */
> > > +                     if (prog_type == BPF_PROG_TYPE_TRACING &&
> > > +                         env->prog->expected_attach_type != BPF_MODIFY_RETURN)
> > > +                             regs[BPF_REG_0].type |= MEM_RDONLY;
> >
> > MOD_RET restriction looks artificial.
> > We can distinguish readonly vs writeable PTR_TO_MEM based on
> > another naming convention.
> > Currently arg_name__sz applies to the previous argument.
> > Matching suffix made sense there.
>
> Oh, I missed the point of the "__sz". I did not realize it was
> supposed to be a suffix.
>
> > Reusing the same suffix matching for a different purpose could be confusing.
> > For this use case we may reserve a full argument name.
> > Like "rdonly_buf_size" and "rdwr_buf_size" ?
> >
>
> I like the idea but I have 2 problems here:
> 1. I do not really want to have 2 separate kfuncs for read only and
> write operations
> 2. How can I restrict the write operation to fmod_ret?
>
> For 1, my guess is that the read-only operation will not be used
> unless we solve 2.
> For 2, the rationale is that I think tracing functions are not
> supposed to change the behavior. This was said on the thread about
> priorities for BPF programs. And it somehow makes sense that fentry
> should be used for tracing only. OTOH, fmod_ret is clearly affecting
> the behavior of the program, so I see it more "natural" that it can
> change the context too.

Well, if we say that fentry is rdonly and fmod_ret is rdwr
then we probably shouldn't stop at return value.
If bpf prog can access the argument and this argument is an array
it should be writable.
We can allow different kfuncs for fentry and fmod_ret too.
They can be two tiny wrappers with different arg names (to distinguish
rdonly vs rdwr) on top of the single always_inline function
that returns a buffer.
