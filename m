Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD64D589356
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 22:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiHCUgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 16:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbiHCUgk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 16:36:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F8F5B7B9
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 13:36:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e13so3948992edj.12
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PC/CGCZ4juv4hvjcmhdu4dwiRCVxdfue08CbGAiR7Gc=;
        b=Vu9xgXbntHB2VqvrZ/tvQHyJ3QPmHd4Z8B+8Zr0nzk72h8OTmUgRO7r4u+aRUyh0H/
         J9YYO6mLswZy6B7/dpePRDur7my0tX6zllz8BDBhxZbuCiWmd1tpZzg2wUIW+HY1vmgX
         JD7W5vrF+Tcs1TLUS+wZz+yYO8EPKHWG03KY21VTv6VvAHa1gW5yKDfpngw6f369QONu
         NoKdE1sMX0OC3P0C3F7ohJ1dU8qFpEF9XRMtqpWeYtmXkgxsN/JJLJVn778JnoiNXLAc
         wbBgKGhH2kT8I/qoCUSHmzLaf7lojdbte9c9i7l4MxItTt2akdURLF4FVRaYLXj408Ct
         g/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PC/CGCZ4juv4hvjcmhdu4dwiRCVxdfue08CbGAiR7Gc=;
        b=pi0SvZeZnpkUcPgWLMl93CjbWbt8SLNzVvgLvm1VdsM0GHO2X7KQE2jbWvg1tuz+9X
         al8cc41V5jh63wLJij8P5Y8FEu+3JhD34N4TrHH6GkNpDOf4aYrB9AZZwuoMp7eVKbhW
         SylWYKDAS6DNJ1TvvG+wnAEi1+QdhX1D4RcBS4BzVZSq3P0uho+KedM5MsmiPWIkQkcg
         AxN7khzTz1ZpCorqdmiSV4LqSclt95m3VNiyJrTQcyEpNizaSARAe/FfxYjdlHEfDO/b
         animoU8Bg0HIUA25VZPqZ5kTeUZLNroQR6fNO4NaPjxm1aW3Cq/hzjedbWo9SLVYPCU1
         EY7w==
X-Gm-Message-State: AJIora/IEKa9+c+jCdmeaXsHpS30Ra9ER8fIkCZvnboNV2lqIPNadsTX
        X9aoW0JXclBLEG3gEYh2IBf8IsQgNVPZmgySRTc=
X-Google-Smtp-Source: AGRyM1txNu04galfyDAPEoSHIOPDO4NyEHExgQcEUnVYK0VFleNqdAm0k5HCA9umysqA3pPK8aulSMEXgL8UoSon4i0=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr27375708edb.333.1659558997389; Wed, 03
 Aug 2022 13:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
 <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com> <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com>
In-Reply-To: <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Aug 2022 13:36:26 -0700
Message-ID: <CAEf4BzZAvuLXX+LitHYH_0oufMBaaTmV2nB4VNqkTFt9Hep-Sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
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

On Wed, Aug 3, 2022 at 1:29 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Fri, Jul 29, 2022 at 2:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Fri, Jul 29, 2022 at 01:26:31PM -0700, Joanne Koong wrote:
> > > On Thu, Jul 28, 2022 at 4:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Tue, Jul 26, 2022 at 11:47:04AM -0700, Joanne Koong wrote:
> > > > > @@ -1567,6 +1607,18 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
> > > > >       if (bpf_dynptr_is_rdonly(ptr))
> > > > Is it possible to allow data slice for rdonly dynptr-skb?
> > > > and depends on the may_access_direct_pkt_data() check in the verifier.
> > >
> > > Ooh great idea. This should be very simple to do, since the data slice
> > > that gets returned is assigned as PTR_TO_PACKET. So any stx operations
> > > on it will by default go through the may_access_direct_pkt_data()
> > > check. I'll add this for v2.
> > It will be great.  Out of all three helpers (bpf_dynptr_read/write/data),
> > bpf_dynptr_data will be the useful one to parse the header data (e.g. tcp-hdr-opt)
> > that has runtime variable length because bpf_dynptr_data() can take a non-cost
> > 'offset' argument.  It is useful to get a consistent usage across all bpf
> > prog types that are either read-only or read-write of the skb.
> >
> > >
> > > >
> > > > >               return 0;
> > > > >
> > > > > +     type = bpf_dynptr_get_type(ptr);
> > > > > +
> > > > > +     if (type == BPF_DYNPTR_TYPE_SKB) {
> > > > > +             struct sk_buff *skb = ptr->data;
> > > > > +
> > > > > +             /* if the data is paged, the caller needs to pull it first */
> > > > > +             if (ptr->offset + offset + len > skb->len - skb->data_len)
> > > > > +                     return 0;
> > > > > +
> > > > > +             return (unsigned long)(skb->data + ptr->offset + offset);
> > > > > +     }
> > > > > +
> > > > >       return (unsigned long)(ptr->data + ptr->offset + offset);
> > > > >  }
> > > >
> > > > [ ... ]
> > > >
> > > > > -static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > > > > +static void stack_slot_get_dynptr_info(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > > > +                                    struct bpf_call_arg_meta *meta)
> > > > >  {
> > > > >       struct bpf_func_state *state = func(env, reg);
> > > > >       int spi = get_spi(reg->off);
> > > > >
> > > > > -     return state->stack[spi].spilled_ptr.id;
> > > > > +     meta->ref_obj_id = state->stack[spi].spilled_ptr.id;
> > > > > +     meta->type = state->stack[spi].spilled_ptr.dynptr.type;
> > > > >  }
> > > > >
> > > > >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > > > @@ -6052,6 +6057,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > > >                               case DYNPTR_TYPE_RINGBUF:
> > > > >                                       err_extra = "ringbuf ";
> > > > >                                       break;
> > > > > +                             case DYNPTR_TYPE_SKB:
> > > > > +                                     err_extra = "skb ";
> > > > > +                                     break;
> > > > >                               default:
> > > > >                                       break;
> > > > >                               }
> > > > > @@ -6065,8 +6073,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > > >                                       verbose(env, "verifier internal error: multiple refcounted args in BPF_FUNC_dynptr_data");
> > > > >                                       return -EFAULT;
> > > > >                               }
> > > > > -                             /* Find the id of the dynptr we're tracking the reference of */
> > > > > -                             meta->ref_obj_id = stack_slot_get_id(env, reg);
> > > > > +                             /* Find the id and the type of the dynptr we're tracking
> > > > > +                              * the reference of.
> > > > > +                              */
> > > > > +                             stack_slot_get_dynptr_info(env, reg, meta);
> > > > >                       }
> > > > >               }
> > > > >               break;
> > > > > @@ -7406,7 +7416,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > > > >               regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
> > > > >       } else if (base_type(ret_type) == RET_PTR_TO_ALLOC_MEM) {
> > > > >               mark_reg_known_zero(env, regs, BPF_REG_0);
> > > > > -             regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> > > > > +             if (func_id == BPF_FUNC_dynptr_data &&
> > > > > +                 meta.type == BPF_DYNPTR_TYPE_SKB)
> > > > > +                     regs[BPF_REG_0].type = PTR_TO_PACKET | ret_flag;
> > > > > +             else
> > > > > +                     regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> > > > >               regs[BPF_REG_0].mem_size = meta.mem_size;
> > > > check_packet_access() uses range.
> > > > It took me a while to figure range and mem_size is in union.
> > > > Mentioning here in case someone has similar question.
> > > For v2, I'll add this as a comment in the code or I'll include
> > > "regs[BPF_REG_0].range = meta.mem_size" explicitly to make it more
> > > obvious :)
> > 'regs[BPF_REG_0].range = meta.mem_size' would be great.  No strong
> > opinion here.
> >
> > > >
> > > > >       } else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
> > > > >               const struct btf_type *t;
> > > > > @@ -14132,6 +14146,25 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> > > > >                       goto patch_call_imm;
> > > > >               }
> > > > >
> > > > > +             if (insn->imm == BPF_FUNC_dynptr_from_skb) {
> > > > > +                     if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE))
> > > > > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, true);
> > > > > +                     else
> > > > > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, false);
> > > > > +                     insn_buf[1] = *insn;
> > > > > +                     cnt = 2;
> > > > > +
> > > > > +                     new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > > > > +                     if (!new_prog)
> > > > > +                             return -ENOMEM;
> > > > > +
> > > > > +                     delta += cnt - 1;
> > > > > +                     env->prog = new_prog;
> > > > > +                     prog = new_prog;
> > > > > +                     insn = new_prog->insnsi + i + delta;
> > > > > +                     goto patch_call_imm;
> > > > > +             }
> > > > Have you considered to reject bpf_dynptr_write()
> > > > at prog load time?
> > > It's possible to reject bpf_dynptr_write() at prog load time but would
> > > require adding tracking in the verifier for whether a dynptr is
> > > read-only or not. Do you think it's better to reject it at load time
> > > instead of returning NULL at runtime?
> > The check_helper_call above seems to know 'meta.type == BPF_DYNPTR_TYPE_SKB'.
> > Together with may_access_direct_pkt_data(), would it be enough ?
> > Then no need to do patching for BPF_FUNC_dynptr_from_skb here.
>
> Thinking about this some more, I think BPF_FUNC_dynptr_from_skb needs
> to be patched regardless in order to set the rd-only flag in the
> metadata for the dynptr. There will be other helper functions that
> write into dynptrs (eg memcpy with dynptrs, strncpy with dynptrs,
> probe read user with dynptrs, ...) so I think it's more scalable if we
> reject these writes at runtime through the rd-only flag in the
> metadata, than for the verifier to custom-case that any helper funcs
> that write into dynptrs will need to get dynptr type + do
> may_access_direct_pkt_data() if it's type skb or xdp. The
> inconsistency between not rd-only in metadata vs. rd-only in verifier
> might be a little confusing as well.
>
> For these reasons, I'm leaning more towards having bpf_dynptr_write()
> and other dynptr write helper funcs be rejected at runtime instead of
> prog load time, but I'm eager to hear what you prefer.
>

+1, that's sort of the point of dynptr to move move checks into
runtime and leave BPF verifier simpler

> What are your thoughts?
>
> >
> > Since we are on bpf_dynptr_write, what is the reason
> > on limiting it to the skb_headlen() ?  Not implying one
> > way is better than another.  would like to undertand the reason
> > behind it since it is not clear in the commit message.
