Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29918528BA6
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 19:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiEPRNP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 13:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiEPRNO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 13:13:14 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A7C31902
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 10:13:13 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i15so1045208ilk.5
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUomNp+skmyyyZHCiUlkBBqqpocqzv6ZbhJP/7J4z2k=;
        b=med6IjkglxDoJGbYEUA1BUIWre8fcapL7uc+2trdyrvsBtlgwArGNq8vl2Gnh1kIKG
         xCYLqtZLKvpZvvnofSqNentC6r129NSdrf7BppbqB2uq6omEifaGxFrQY7BHXrfbb6EL
         Tz7c623K+oNvl/ExfbZvdu6y8Y5s6KgLT+PLhXEy856iFAovxID1Siug9WuYmljgoQU+
         IaxB636TMVBAV9tl8SOxZYqtPeTSxKkOlL6M4dBj6PMj1eqmaIlbPvQaFpPlhufo+sqp
         f/iWbo2B8sr+tcIBoLCGVIChMUow6xuKZhBGqXB1l5psgtwdbOu0VGno0LCMpHQIg2VS
         jKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUomNp+skmyyyZHCiUlkBBqqpocqzv6ZbhJP/7J4z2k=;
        b=XylQ8wkBF23MUcQBmZ4PJaNiLccHoNJ5LrQxvkDZdTGzLT7hNbYwmbtiUX16vE7cvK
         rcyICGl4Ax0kMS3BFT/irkeMsTEeNCFe9abibNlSTXRFQWPDhjHWGBxuNTkeaFmJZEeq
         +w2sJTNxCaQDKigxCcFtILxfbzY0fzeb8SHOFHrzAW/jPWJ3AGiiYP+yDfkJulO556y9
         lWAkhe+BLm8TZ4oNwu2zxM9BfMBLbgqm0d6a9PX7kNyJDu2CUM7TKSfk7R5l9osHWnDI
         fx0oNZhWZ70Za3Nrjuo5zhVgZrBPCWLc0spOddN/gkv8Ys4OYRo9pAQ0342yJgzRhpbN
         vogA==
X-Gm-Message-State: AOAM533GEQQ08o/en7DElsriLFFCPRUXGYyKXSCo1K1O70ixcc7DSV7l
        Fye8SzCMpMXumyM+ShYILMx2dGemGwXY+9FoUcsD3ph5Znc=
X-Google-Smtp-Source: ABdhPJxqnXM/gXWd8Jo27TQvspj5fF39VMlKuNwH8LJCDm6FBIw5WhhA4OrDAXC0ZkUESgC4DoS3xFtBCjO3A39J7f0=
X-Received: by 2002:a05:6e02:1c82:b0:2cf:2b74:d155 with SMTP id
 w2-20020a056e021c8200b002cf2b74d155mr9591747ill.4.1652721192751; Mon, 16 May
 2022 10:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-6-joannelkoong@gmail.com> <20220513213747.j3tj2qtbnjszy64n@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220513213747.j3tj2qtbnjszy64n@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 16 May 2022 10:13:00 -0700
Message-ID: <CAJnrk1bJx04bPj4BVypVXyugw-EX7xn+zYRShv8+1zZSoxrDDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/6] bpf: Add dynptr data slices
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Fri, May 13, 2022 at 2:37 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 09, 2022 at 03:42:56PM -0700, Joanne Koong wrote:
> >       } else if (is_acquire_function(func_id, meta.map_ptr)) {
> > -             int id = acquire_reference_state(env, insn_idx);
> > +             int id = 0;
> > +
> > +             if (is_dynptr_ref_function(func_id)) {
> > +                     int i;
> > +
> > +                     /* Find the id of the dynptr we're acquiring a reference to */
> > +                     for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> > +                             if (arg_type_is_dynptr(fn->arg_type[i])) {
> > +                                     if (id) {
> > +                                             verbose(env, "verifier internal error: more than one dynptr arg in a dynptr ref func\n");
> > +                                             return -EFAULT;
> > +                                     }
> > +                                     id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
>
> I'm afraid this approach doesn't work.
> Consider:
>   struct bpf_dynptr ptr;
>   u32 *data1, *data2;
>
>   bpf_dynptr_alloc(8, 0, &ptr);
>   data1 = bpf_dynptr_data(&ptr, 0, 8);
>   data2 = bpf_dynptr_data(&ptr, 8, 8);
>   if (data1)
>      *data2 = 0; /* this will succeed, but shouldn't */
>
> The same 'id' is being reused for data1 and data2 to make sure
> that bpf_dynptr_put(&ptr); will clear data1/data2,
> but data1 and data2 will look the same in mark_ptr_or_null_reg().
>
> > +                             }
> > +                     }
> > +                     if (!id) {
> > +                             verbose(env, "verifier internal error: no dynptr args to a dynptr ref func\n");
> > +                             return -EFAULT;
> > +                     }
> > +             } else {
> > +                     id = acquire_reference_state(env, insn_idx);
> > +                     if (id < 0)
> > +                             return id;
> > +             }
> >
> > -             if (id < 0)
> > -                     return id;
> >               /* For mark_ptr_or_null_reg() */
> >               regs[BPF_REG_0].id = id;
> >               /* For release_reference() */
> > @@ -9810,7 +9864,8 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
> >       u32 id = regs[regno].id;
> >       int i;
> >
> > -     if (ref_obj_id && ref_obj_id == id && is_null)
> > +     if (ref_obj_id && ref_obj_id == id && is_null &&
> > +         !is_ref_obj_id_dynptr(state, id))
>
> This bit is avoiding doing release of dynptr's id,
> because id is shared between dynptr and slice's id.
>
> In this patch I'm not sure what is the purpose of bpf_dynptr_data()
> being an acquire function. data1 and data2 are not acquiring.
> They're not incrementing refcnt of dynptr.
>
> I think normal logic of check_helper_call() that does:
>         if (type_may_be_null(regs[BPF_REG_0].type))
>                 regs[BPF_REG_0].id = ++env->id_gen;
>
> should be preserved.
> It will give different id-s to data1 and data2 and the problem
> described earlier will not exist.
>
> The transfer of ref_obj_id from dynptr into data1 and data2 needs to happen,
> but this part:
>         u32 ref_obj_id = regs[regno].ref_obj_id;
>         u32 id = regs[regno].id;
>         int i;
>
>         if (ref_obj_id && ref_obj_id == id && is_null)
>                 /* regs[regno] is in the " == NULL" branch.
>                  * No one could have freed the reference state before
>                  * doing the NULL check.
>                  */
>                 WARN_ON_ONCE(release_reference_state(state, id));
>
> should be left alone.
> bpf_dynptr_put(&ptr); will release dynptr and will clear data1 and data2.
> if (!data1)
>    will not release dynptr, because data1->id != data1->ref_obj_id.
>
> In other words bpf_dynptr_data() should behave like is_ptr_cast_function().
> It should trasnfer ref_obj_id to R0, but should give new R0->id.
> See big comment in bpf_verifier.h next to ref_obj_id.
Great, thanks for your feedback. I agree with everything you wrote. I
will make these changes for v5 and add your data1 data2 example as a
test case.
