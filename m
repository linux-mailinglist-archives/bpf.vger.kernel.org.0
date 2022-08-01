Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60D586FC6
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 19:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiHARw3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 13:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiHARw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 13:52:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3733A18F
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 10:52:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a89so14747113edf.5
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xlUIM1lXTvJCwulFX38aJ5fto7RnBxLM2Y21xBgORWw=;
        b=YRI2iAzqz3xuXq60f/RowS2r0EtvQLbn/mfzPhe+tw7dTJ/Zr40YiMTJRRZ+YAZvPJ
         M95AoHRZxXT7PTDzLqR1mL9sJfe4e6+mq2keOPj9jWc6FgSChc5+0VLloVPvtwfZzOt9
         euD7SlWYePO5SbXxIBw9dpjJEqxnL7V9rMd5ehIpM8gaRaeHciFCxmn+oWlhFeJxl8Y7
         r/LuwqzUFhyb4TOhUb5Svcwsv7r6DE0+0lA90VxQ9DxvThsKVV5jRzS1nrNy9d2uR0TM
         apNzEzMgzHkcgAr5zDTWPQgNxNHCriajOoIs8Ny+pTNJpTWOuqtgbFUoBZ8s1zeoWau4
         OMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlUIM1lXTvJCwulFX38aJ5fto7RnBxLM2Y21xBgORWw=;
        b=M7jwukm0w/3bxe1x08S3gne6qldDkyV7iyQoa550VvftR4XncbY5H1m/F7jjt6oDIL
         P2erVLTwSP2wIgO1bYGQYn69PIRe7TlN/C2U+8gKIZa36GDJrAHq+XejM1M1d2DBTutu
         b0/BpPPHampnQY2jjg+jHgTI8kF8yItm5MXO1cJ74A+B161n7i6kaaECh5RewUR3rWRg
         M7iSoRdBr9/qMAl0Cd39L+YJbHouY4ruAVw1h1xT9jL+4w9T83kqSnqx1TxjnzaVG0Qv
         z5kaR5NeVgDfHzzQfkBlenzqeHUtuB7iaZBCJSbPW3ynMpR02D1f+b8fu1CsL6GjxVix
         Hx8g==
X-Gm-Message-State: ACgBeo0Bc/ucMWoSu+4Ooq0E/ovCRMJ/ALF4Yz1n8Gb4T3l9ECtA67uC
        gHPhj9MzniU59qjqKPsaHB7g/bVaA6TFRyeMAjM=
X-Google-Smtp-Source: AA6agR7dcn+5OZT3NS5mWA/scOt+BgnDDbQ1KypUitsTmGgSFA9UCvkUwSktV3Qb4/F7O23uuxf1rLcJ+r775fFKmMI=
X-Received: by 2002:a05:6402:1907:b0:43d:e91d:e544 with SMTP id
 e7-20020a056402190700b0043de91de544mr291093edz.107.1659376345513; Mon, 01 Aug
 2022 10:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com> <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com> <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 1 Aug 2022 10:52:14 -0700
Message-ID: <CAJnrk1YXSx11TGhKhAZ20R81pUsgBVeAooGJjTR7dR5iyP_eeQ@mail.gmail.com>
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

On Fri, Jul 29, 2022 at 2:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Jul 29, 2022 at 01:26:31PM -0700, Joanne Koong wrote:
> > On Thu, Jul 28, 2022 at 4:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Tue, Jul 26, 2022 at 11:47:04AM -0700, Joanne Koong wrote:
> > > > @@ -1567,6 +1607,18 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
> > > >       if (bpf_dynptr_is_rdonly(ptr))
> > > Is it possible to allow data slice for rdonly dynptr-skb?
> > > and depends on the may_access_direct_pkt_data() check in the verifier.
> >
> > Ooh great idea. This should be very simple to do, since the data slice
> > that gets returned is assigned as PTR_TO_PACKET. So any stx operations
> > on it will by default go through the may_access_direct_pkt_data()
> > check. I'll add this for v2.
> It will be great.  Out of all three helpers (bpf_dynptr_read/write/data),
> bpf_dynptr_data will be the useful one to parse the header data (e.g. tcp-hdr-opt)
> that has runtime variable length because bpf_dynptr_data() can take a non-cost
> 'offset' argument.  It is useful to get a consistent usage across all bpf
> prog types that are either read-only or read-write of the skb.
>
> >
> > >
> > > >               return 0;
> > > >
> > > > +     type = bpf_dynptr_get_type(ptr);
> > > > +
> > > > +     if (type == BPF_DYNPTR_TYPE_SKB) {
> > > > +             struct sk_buff *skb = ptr->data;
> > > > +
> > > > +             /* if the data is paged, the caller needs to pull it first */
> > > > +             if (ptr->offset + offset + len > skb->len - skb->data_len)
> > > > +                     return 0;
> > > > +
> > > > +             return (unsigned long)(skb->data + ptr->offset + offset);
> > > > +     }
> > > > +
> > > >       return (unsigned long)(ptr->data + ptr->offset + offset);
> > > >  }
> > >
> > > [ ... ]
> > >
> > > > -static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > > > +static void stack_slot_get_dynptr_info(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > > +                                    struct bpf_call_arg_meta *meta)
> > > >  {
> > > >       struct bpf_func_state *state = func(env, reg);
> > > >       int spi = get_spi(reg->off);
> > > >
> > > > -     return state->stack[spi].spilled_ptr.id;
> > > > +     meta->ref_obj_id = state->stack[spi].spilled_ptr.id;
> > > > +     meta->type = state->stack[spi].spilled_ptr.dynptr.type;
> > > >  }
> > > >
> > > >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > > @@ -6052,6 +6057,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > >                               case DYNPTR_TYPE_RINGBUF:
> > > >                                       err_extra = "ringbuf ";
> > > >                                       break;
> > > > +                             case DYNPTR_TYPE_SKB:
> > > > +                                     err_extra = "skb ";
> > > > +                                     break;
> > > >                               default:
> > > >                                       break;
> > > >                               }
> > > > @@ -6065,8 +6073,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > >                                       verbose(env, "verifier internal error: multiple refcounted args in BPF_FUNC_dynptr_data");
> > > >                                       return -EFAULT;
> > > >                               }
> > > > -                             /* Find the id of the dynptr we're tracking the reference of */
> > > > -                             meta->ref_obj_id = stack_slot_get_id(env, reg);
> > > > +                             /* Find the id and the type of the dynptr we're tracking
> > > > +                              * the reference of.
> > > > +                              */
> > > > +                             stack_slot_get_dynptr_info(env, reg, meta);
> > > >                       }
> > > >               }
> > > >               break;
> > > > @@ -7406,7 +7416,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > > >               regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
> > > >       } else if (base_type(ret_type) == RET_PTR_TO_ALLOC_MEM) {
> > > >               mark_reg_known_zero(env, regs, BPF_REG_0);
> > > > -             regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> > > > +             if (func_id == BPF_FUNC_dynptr_data &&
> > > > +                 meta.type == BPF_DYNPTR_TYPE_SKB)
> > > > +                     regs[BPF_REG_0].type = PTR_TO_PACKET | ret_flag;
> > > > +             else
> > > > +                     regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
> > > >               regs[BPF_REG_0].mem_size = meta.mem_size;
> > > check_packet_access() uses range.
> > > It took me a while to figure range and mem_size is in union.
> > > Mentioning here in case someone has similar question.
> > For v2, I'll add this as a comment in the code or I'll include
> > "regs[BPF_REG_0].range = meta.mem_size" explicitly to make it more
> > obvious :)
> 'regs[BPF_REG_0].range = meta.mem_size' would be great.  No strong
> opinion here.
>
> > >
> > > >       } else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
> > > >               const struct btf_type *t;
> > > > @@ -14132,6 +14146,25 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> > > >                       goto patch_call_imm;
> > > >               }
> > > >
> > > > +             if (insn->imm == BPF_FUNC_dynptr_from_skb) {
> > > > +                     if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE))
> > > > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, true);
> > > > +                     else
> > > > +                             insn_buf[0] = BPF_MOV32_IMM(BPF_REG_4, false);
> > > > +                     insn_buf[1] = *insn;
> > > > +                     cnt = 2;
> > > > +
> > > > +                     new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > > > +                     if (!new_prog)
> > > > +                             return -ENOMEM;
> > > > +
> > > > +                     delta += cnt - 1;
> > > > +                     env->prog = new_prog;
> > > > +                     prog = new_prog;
> > > > +                     insn = new_prog->insnsi + i + delta;
> > > > +                     goto patch_call_imm;
> > > > +             }
> > > Have you considered to reject bpf_dynptr_write()
> > > at prog load time?
> > It's possible to reject bpf_dynptr_write() at prog load time but would
> > require adding tracking in the verifier for whether a dynptr is
> > read-only or not. Do you think it's better to reject it at load time
> > instead of returning NULL at runtime?
> The check_helper_call above seems to know 'meta.type == BPF_DYNPTR_TYPE_SKB'.
> Together with may_access_direct_pkt_data(), would it be enough ?
> Then no need to do patching for BPF_FUNC_dynptr_from_skb here.
Yeah! That would detect it just as well. I'll add this to v2 :)
>
> Since we are on bpf_dynptr_write, what is the reason
> on limiting it to the skb_headlen() ?  Not implying one
> way is better than another.  would like to undertand the reason
> behind it since it is not clear in the commit message.
For bpf_dynptr_write, if we don't limit it to skb_headlen() then there
may be writes that pull the skb, so any existing data slices to the
skb must be invalidated. However, in the verifier we can't detect when
the data slice should be invalidated vs. when it shouldn't (eg
detecting when a write goes into the paged area vs when the write is
only in the head). If the prog wants to write into the paged area, I
think the only way it can work is if it pulls the data first with
bpf_skb_pull_data before calling bpf_dynptr_write. I will add this to
the commit message in v2
