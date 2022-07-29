Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D1585614
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 22:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiG2U0q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 16:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2U0q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 16:26:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A46FA36
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 13:26:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v17so7156727edc.1
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6usqecbZDEBijPawR7ofPwCug/h1TymgVTHvmpp52Vs=;
        b=jfCmxqZTzFInk+o1dwJ6nqOB0ItVzqZPlZ72x+n22orZb6GNw/5QYAZ4d08JXHALXo
         HoYMP03QTEZ8T4fXE7pPU4RkdP+FCkeY2rBrNulBdm17YfygkRojsEpziSzq2v/27rpw
         Ivv8RGau9W+edN57WKUqThFEPHqg9u8TW9XTAAF1yv/O1lbZadTErH+F3CAWh/N0YMkj
         6I+jLdvZAPtGEvUajgOYjU7edy2v3ZTuwowO7+zAuX2eAQE4SOKEVyhVFY15xqJ9/OM1
         fPmYdDEMGmATta+IBzWJ37mosxZxzGN/mBd3rZsKcyl0OJFgrtDcCOrlQaAmegH0xBpl
         Uebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6usqecbZDEBijPawR7ofPwCug/h1TymgVTHvmpp52Vs=;
        b=4vUTuhSX+OppxLU9/1xTCa4r/0uBddv1U++gFwnDR/PkwQYVRMNURdFbWaWGE0vYQe
         /HO4nKbUEXyKGZOL4KMKKnuHX5ahz7cBP7fufTDHDudarbGVH98JWiyNLGXrGSUNa6V1
         tcwi2oM8maymU/pOC0B6DFnMLDoUMDt5cZv2FHhyP70/0IZ22DcldalYkVZCxkH91SXk
         Hqas9557LvWBKfENM7WkKJP2Or3ugh/cS0eg0YcK2fzczQ4ZHl/G5adZQ5wlpxkmK07J
         +SPgiB5ju4edXSnmMwUdizf3xC+Bxo3TxKc9ZNnn1JXxPsXAC62QAqBK/Ffz5YBmz7TV
         I+Vw==
X-Gm-Message-State: AJIora/T7J9IyZ+DQNH9u04Xe4igcSPobyOREbmgdxB+Y8cvjeBlW6+M
        DVWZFJEgrOv/wnvyEyw2jJBqcSf9rS3SxCJcog5qEV3mOSQ=
X-Google-Smtp-Source: AGRyM1tT0+nDEL+lBIpE94k9ocsnW9m1YAnoFejJpTQB90PDS2PFJMiSXHTwZgvWtuPvEdqlAagto+iNh2kxZ4OeQiQ=
X-Received: by 2002:a05:6402:190e:b0:43c:34ba:1903 with SMTP id
 e14-20020a056402190e00b0043c34ba1903mr5288737edz.229.1659126402732; Fri, 29
 Jul 2022 13:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 29 Jul 2022 13:26:31 -0700
Message-ID: <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Thu, Jul 28, 2022 at 4:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Jul 26, 2022 at 11:47:04AM -0700, Joanne Koong wrote:
> > @@ -1567,6 +1607,18 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
> >       if (bpf_dynptr_is_rdonly(ptr))
> Is it possible to allow data slice for rdonly dynptr-skb?
> and depends on the may_access_direct_pkt_data() check in the verifier.

Ooh great idea. This should be very simple to do, since the data slice
that gets returned is assigned as PTR_TO_PACKET. So any stx operations
on it will by default go through the may_access_direct_pkt_data()
check. I'll add this for v2.

>
> >               return 0;
> >
> > +     type = bpf_dynptr_get_type(ptr);
> > +
> > +     if (type == BPF_DYNPTR_TYPE_SKB) {
> > +             struct sk_buff *skb = ptr->data;
> > +
> > +             /* if the data is paged, the caller needs to pull it first */
> > +             if (ptr->offset + offset + len > skb->len - skb->data_len)
> > +                     return 0;
> > +
> > +             return (unsigned long)(skb->data + ptr->offset + offset);
> > +     }
> > +
> >       return (unsigned long)(ptr->data + ptr->offset + offset);
> >  }
>
> [ ... ]
>
> > -static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > +static void stack_slot_get_dynptr_info(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                                    struct bpf_call_arg_meta *meta)
> >  {
> >       struct bpf_func_state *state = func(env, reg);
> >       int spi = get_spi(reg->off);
> >
> > -     return state->stack[spi].spilled_ptr.id;
> > +     meta->ref_obj_id = state->stack[spi].spilled_ptr.id;
> > +     meta->type = state->stack[spi].spilled_ptr.dynptr.type;
> >  }
> >
> >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > @@ -6052,6 +6057,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                               case DYNPTR_TYPE_RINGBUF:
> >                                       err_extra = "ringbuf ";
> >                                       break;
> > +                             case DYNPTR_TYPE_SKB:
> > +                                     err_extra = "skb ";
> > +                                     break;
> >                               default:
> >                                       break;
> >                               }
> > @@ -6065,8 +6073,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                                       verbose(env, "verifier internal error: multiple refcounted args in BPF_FUNC_dynptr_data");
> >                                       return -EFAULT;
> >                               }
> > -                             /* Find the id of the dynptr we're tracking the reference of */
> > -                             meta->ref_obj_id = stack_slot_get_id(env, reg);
> > +                             /* Find the id and the type of the dynptr we're tracking
> > +                              * the reference of.
> > +                              */
> > +                             stack_slot_get_dynptr_info(env, reg, meta);
> >                       }
> >               }
> >               break;
> > @@ -7406,7 +7416,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >               regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
> >       } else if (base_type(ret_type) == RET_PTR_TO_ALLOC_MEM) {
> >               mark_reg_known_zero(env, regs, BPF_REG_0);
> > -             regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> > +             if (func_id == BPF_FUNC_dynptr_data &&
> > +                 meta.type == BPF_DYNPTR_TYPE_SKB)
> > +                     regs[BPF_REG_0].type = PTR_TO_PACKET | ret_flag;
> > +             else
> > +                     regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> >               regs[BPF_REG_0].mem_size = meta.mem_size;
> check_packet_access() uses range.
> It took me a while to figure range and mem_size is in union.
> Mentioning here in case someone has similar question.
For v2, I'll add this as a comment in the code or I'll include
"regs[BPF_REG_0].range = meta.mem_size" explicitly to make it more
obvious :)
>
> >       } else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
> >               const struct btf_type *t;
> > @@ -14132,6 +14146,25 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >                       goto patch_call_imm;
> >               }
> >
> > +             if (insn->imm == BPF_FUNC_dynptr_from_skb) {
> > +                     if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE))
> > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, true);
> > +                     else
> > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, false);
> > +                     insn_buf[1] = *insn;
> > +                     cnt = 2;
> > +
> > +                     new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > +                     if (!new_prog)
> > +                             return -ENOMEM;
> > +
> > +                     delta += cnt - 1;
> > +                     env->prog = new_prog;
> > +                     prog = new_prog;
> > +                     insn = new_prog->insnsi + i + delta;
> > +                     goto patch_call_imm;
> > +             }
> Have you considered to reject bpf_dynptr_write()
> at prog load time?
It's possible to reject bpf_dynptr_write() at prog load time but would
require adding tracking in the verifier for whether a dynptr is
read-only or not. Do you think it's better to reject it at load time
instead of returning NULL at runtime?
