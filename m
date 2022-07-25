Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E07B5806F9
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 23:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiGYVxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 17:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGYVxH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 17:53:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1A5CC1
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 14:53:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i13so6517877edj.11
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnKSBUJTnZEuE2qVPPSDaphJwXy7spbur3S2wahPwWI=;
        b=KUaKYepC61k5FuRjujkdrrLTZ0kXLqq/Hfi5as/eG1jnE/1CmHXUm9L5oG5iJsQZJO
         frFdP+TW4r3bGuM4ZWkVxa9FHZClWmORd4ohnrgFbKHHx9TCKUTqNLzwTbBi76C7RmmS
         HHX12qFggcsGdrLzCT4Q/F98YJipg/d4wBOalYo6WQJF3EMP9pQpkfng95D8mqX+t0Zi
         DNOUM47ijmvYDdybvhFe4csvZefFNUpblfKo1v2Jf1KD6QanSDwsuQ5TFNFKyUmVVdgf
         uPenOrem6kZ70gr5mlh48CLL3+JdAx8uGayvaofAMdB4umvLH1Ho8Ug2hDW7SdKU+4Ey
         CzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnKSBUJTnZEuE2qVPPSDaphJwXy7spbur3S2wahPwWI=;
        b=29HIY9draA9lkNUGC0+e5aRWQL689Exvvxvx3DcXUAFP6xxJyDMkNMbiZRKRfRd1gZ
         MM+8AtH2cG9JUk3+1OmF9LUL6V0FypQPNUrAnXQsxJGJVeffo0P7N+cm5Wb1Wm7NfAsO
         UGKOVlYYFyJTmnfwAHlqyL1Rm3TxSD2tgz7N5Jl2MPU4EDpQGx1TiGvUAG8i/pZpVCnq
         OeeJHpC6MP3WaHi/jOR+RNvMuhbKxaRegp3m4J7BOu7TfHYZNj9pb2bVsntmmsrk3eqv
         7mk81d6e9yN3B+JD9ziRcTou+Cb7uG1PMIoJPM4gzMRcXZUo+p50lLkO6w/q+2jaNqcz
         r8xg==
X-Gm-Message-State: AJIora/+ohAnjtwAasz+gdDMzgruS1YPqcd+R02ncUmvXuvji9dxzgWB
        MbqDdXleX1EggvV6fnF8BlpvrKsVB1kUBEjv/pw=
X-Google-Smtp-Source: AGRyM1u4oVz3fXZUV9q1d2r8TBTezEjOV6sIivwcp3u4HZUgPS/Wi/SqRRc/etvSAxlRfYAKl1zGqTe5m0JGFLchhEc=
X-Received: by 2002:a05:6402:190e:b0:43c:34ba:1903 with SMTP id
 e14-20020a056402190e00b0043c34ba1903mr3356334edz.229.1658785984686; Mon, 25
 Jul 2022 14:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220722175807.4038317-1-joannelkoong@gmail.com> <20220725191023.qxfna7whgllffekt@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220725191023.qxfna7whgllffekt@kafai-mbp.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 25 Jul 2022 14:52:53 -0700
Message-ID: <CAJnrk1ZTSnK5S4F4E8qsPy2D8QXENEKurSAoij0+DK6DS8eCjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix ref_obj_id for dynptr data
 slices in verifier
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, jolsa@kernel.org,
        Hao Luo <haoluo@google.com>,
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

On Mon, Jul 25, 2022 at 12:10 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Jul 22, 2022 at 10:58:06AM -0700, Joanne Koong wrote:
> > When a data slice is obtained from a dynptr (through the bpf_dynptr_data API),
> > the ref obj id of the dynptr must be found and then associated with the data
> > slice.
> >
> > The ref obj id of the dynptr must be found *before* the caller saved regs are
> > reset. Without this fix, the ref obj id tracking is not correct for
> > dynptrs that are at an offset from the frame pointer.
> >
> > Please also note that the data slice's ref obj id must be assigned after the
> > ret types are parsed, since RET_PTR_TO_ALLOC_MEM-type return regs get
> > zero-marked.
> >
> > Fixes: 34d4ef5775f776ec4b0d53a02d588bf3195cada6 ("bpf: Add dynptr data slices");
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 62 ++++++++++++++++++++-----------------------
> >  1 file changed, 29 insertions(+), 33 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c59c3df0fea6..29987b2ea26f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5830,7 +5830,8 @@ static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state
> >
> >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                         struct bpf_call_arg_meta *meta,
> > -                       const struct bpf_func_proto *fn)
> > +                       const struct bpf_func_proto *fn,
> > +                       int func_id)
> >  {
> >       u32 regno = BPF_REG_1 + arg;
> >       struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > @@ -6040,23 +6041,33 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                       }
> >
> >                       meta->uninit_dynptr_regno = regno;
> > -             } else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> > -                     const char *err_extra = "";
> > +             } else {
> > +                     if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> > +                             const char *err_extra = "";
> >
> > -                     switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> > -                     case DYNPTR_TYPE_LOCAL:
> > -                             err_extra = "local ";
> > -                             break;
> > -                     case DYNPTR_TYPE_RINGBUF:
> > -                             err_extra = "ringbuf ";
> > -                             break;
> > -                     default:
> > -                             break;
> > -                     }
> > +                             switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> > +                             case DYNPTR_TYPE_LOCAL:
> > +                                     err_extra = "local ";
> > +                                     break;
> > +                             case DYNPTR_TYPE_RINGBUF:
> > +                                     err_extra = "ringbuf ";
> > +                                     break;
> > +                             default:
> > +                                     break;
> > +                             }
> >
> > -                     verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> > -                             err_extra, arg + 1);
> > -                     return -EINVAL;
> > +                             verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> > +                                     err_extra, arg + 1);
> > +                             return -EINVAL;
> > +                     }
> > +                     if (func_id == BPF_FUNC_dynptr_data) {
> > +                             if (meta->ref_obj_id) {
> > +                                     verbose(env, "verifier internal error: multiple refcounted args in BPF_FUNC_dynptr_data");
> If 'func_id == BPF_FUNC_dynptr_data' is not checked first,
> this verbose (or the earlier one in the 'if (reg->ref_obj_id) {...}')
> may be hit for the bpf_dynptr_write helper?
If the 'func_id == BPF_FUNC_dynptr_data' is not checked first, the
bpf_dynptr_write helper may hit the verbose if the source it's writing
from is ref-counted (for example if the source is a ringbuf record).
bpf_dynptr_write doesn't trigger the earlier "if (reg->ref_obj_id)"
case when the source is ref-counted because the dynptr isn't stored in
a reg; the dynptr's refcount is stored on the stack since the dynptr
is stored on the stack, so in that case there is only 1
reg->ref_obj_id (belonging to the src) found for bpf_dynptr_write.
>
> Overall lgtm.
>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
>
>
> > +                                     return -EFAULT;
> > +                             }
> > +                             /* Find the id of the dynptr we're tracking the reference of */
> > +                             meta->ref_obj_id = stack_slot_get_id(env, reg);
> > +                     }
> >               }
> >               break;
> >       case ARG_CONST_ALLOC_SIZE_OR_ZERO:
> > @@ -7227,7 +7238,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >       meta.func_id = func_id;
> >       /* check args */
> >       for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> > -             err = check_func_arg(env, i, &meta, fn);
> > +             err = check_func_arg(env, i, &meta, fn, func_id);
> >               if (err)
> >                       return err;
> >       }
> > @@ -7457,7 +7468,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >       if (type_may_be_null(regs[BPF_REG_0].type))
> >               regs[BPF_REG_0].id = ++env->id_gen;
> >
> > -     if (is_ptr_cast_function(func_id)) {
> > +     if (is_ptr_cast_function(func_id) || func_id == BPF_FUNC_dynptr_data) {
> >               /* For release_reference() */
> >               regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
> >       } else if (is_acquire_function(func_id, meta.map_ptr)) {
