Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAAA50605F
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 01:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiDRX7x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 19:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiDRX7w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 19:59:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263A529CA7
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 16:57:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j70so938667pgd.4
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 16:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zpaFr7xqNv+C5D79Ho6dbseJlwLm1DLXSnzUiwUDuPs=;
        b=V6Q3Lt5vI9Jg6QAhLlAhxiZZ9bduejwiOq7oT48PVkq3hdF3+VBm+YWuYQRznhOZXl
         dhA/LkQWxEwRzjiqB6sQ+zj5NWJ+PO1XDGIpBJ23yXfKdWZw+0YrlXveU9V/P5IaRE5a
         VTcSukHNBLOt/tNvPXC9sitA+jLnZKIilZr63x3N2gDsfPuHMZdhkpzobk1hkHZRkx0L
         GL/7jmhQM1fdor1E91CrwIUUhh7N8WOqpi3pIRep0LXa4RDJhY0EYcW3VD/usbvdEUEl
         PcjhHMv1JncnFDdyOp57N3w5mAv/ULte2tV02tutboayXbhoYO6CniO6Ij434Wh39UZ1
         BZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zpaFr7xqNv+C5D79Ho6dbseJlwLm1DLXSnzUiwUDuPs=;
        b=xZgMK752INENBFeVroSirGv4cWRgNxkHOfQRL0yASp9ENcxOi37LRUohUO53BTIjVr
         Hgw9uzYpYESkKtDu5WRRF5dGJwdll3s3Tuaka72CTgiXqu7K4WWPo+Njb10hKRP1Qfkx
         8gtLL0pBBnlc8dPNzh6lCDVP/sB4n1jLlOkm8VCEd+kOrLKhVJehZQ8t2W1QbWajAIuV
         A+4JmxEziFbbhhTF1S+ZfC1XIzYWctsjmUFrHpZKBMe7r6Q8E2793VqEvihEarFOkDjk
         /+rEvuKb933rmD6d3gLKt1sz2iLgS2dMILB5Dsuf5d6pZ70gpqntl1EkwnXSt6+py4KG
         M3Ow==
X-Gm-Message-State: AOAM531tqSzdSzNzftn+vqU2tJSV/0TrWm4JHSnzJTPh6gWfu0UJVzP6
        EoyUE6uAMnf8eL3W9cRPsIhIS2kEy7ZjVg==
X-Google-Smtp-Source: ABdhPJwY6ySARjn4VRojR/IjKvnw3JtOe3wE5DjEKZLW4dm0ms2RWpCx/OoNhWZR/RJSv/thEtlolg==
X-Received: by 2002:a63:f642:0:b0:386:53e:9cd4 with SMTP id u2-20020a63f642000000b00386053e9cd4mr12013325pgj.265.1650326230645;
        Mon, 18 Apr 2022 16:57:10 -0700 (PDT)
Received: from localhost ([112.79.142.143])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090a66c400b001d0e448810asm11069038pjl.36.2022.04.18.16.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 16:57:10 -0700 (PDT)
Date:   Tue, 19 Apr 2022 05:27:18 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_dynptr_alloc, bpf_dynptr_put
Message-ID: <20220418235718.izeq7kkwinedpkuj@apollo.legion>
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-4-joannelkoong@gmail.com>
 <20220416174205.hezp2jnow3hqk6s6@apollo.legion>
 <CAJnrk1adv16+wgEN+euJgfhXFQ+TUDjL36Bo=w_TtzqgomX00Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1adv16+wgEN+euJgfhXFQ+TUDjL36Bo=w_TtzqgomX00Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 19, 2022 at 03:50:38AM IST, Joanne Koong wrote:
> ()On Sat, Apr 16, 2022 at 10:42 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> > [...]
> > >
> > >       if (arg_type == ARG_CONST_MAP_PTR) {
> > > @@ -5565,6 +5814,44 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > >               bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
> > >
> > >               err = check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
> > > +     } else if (arg_type_is_dynptr(arg_type)) {
> > > +             /* Can't pass in a dynptr at a weird offset */
> > > +             if (reg->off % BPF_REG_SIZE) {
> >
> > In invalid_helper2 test, you are passing &dynptr + 8, which means reg will be
> > fp-8 (assuming dynptr is at top of stack), get_spi will compute spi as 0, so
> > spi-1 will lead to OOB access for the second dynptr stack slot. If you run the
> > dynptr test under KASAN, you should see a warning for this.
> >
> > So we should ensure here that reg->off is atleast -16.
> I think this is already checked against in is_spi_bounds(), where we
> explicitly check that spi - 1 and spi is between [0, the allocated
> stack). is_spi_bounds() gets called in "is_dynptr_reg_valid_init()" a
> few lines down where we check if the initialized dynptr arg that's
> passed in by the program is valid.
>
> On my local environment, I simulated this "reg->off = -8" case and
> this fails the is_dynptr_reg_valid_init() -> is_spi_bounds() check and
> we get back the correct verifier error "Expected an initialized dynptr
> as arg #3" without any OOB accesses. I also tried running it with
> CONFIG_KASAN=y as well and didn't see any warnings show up. But maybe
> I'm missing something in this analysis - what are your thoughts?

I should have been clearer, the report is for accessing state->stack[spi -
1].slot_type[0] in is_dynptr_reg_valid_init, when the program is being loaded.

I can understand why you might not see the warning. It is accessing
state->stack[spi - 1], and the allocation comes from kmalloc slab cache, so if
another allocation has an object that covers the region being touched, KASAN
probably won't complain, and you won't see the warning.

Getting back the correct result for the test can also happen if you don't load
STACK_DYNPTR at the state->stack[spi - 1].slot_type[0] byte. The test is passing
for me too, fwiw.

Anyway, digging into this reveals the real problem.

>>> static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>>> 				     enum bpf_arg_type arg_type)
>>> {
>>> 	struct bpf_func_state *state = func(env, reg);
>>> 	int spi = get_spi(reg->off);
>>>

Here, for reg->off = -8, get_spi is (-(-8) - 1)/BPF_REG_SIZE = 0.

>>> 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||

is_spi_bounds_valid will return true, probably because of the unintended
conversion of the expression (spi - nr_slots + 1) to unsigned, so the test
against >= 0 is always true (compiler will optimize it out), and just test
whether spi < allocated_stacks.

You should probably declare nr_slots as int, instead of u32. Just doing this
should be enough to prevent this, without ensuring reg->off is <= -16.

>>> 	    state->stack[spi].slot_type[0] != STACK_DYNPTR ||

Execution moves on to this, which is (second dynptr slot is STACK_DYNPTR).

>>> 	    state->stack[spi - 1].slot_type[0] != STACK_DYNPTR ||

and it accesses state->stack[-1].slot_type[0] here, which triggers the KASAN
warning for me.

>>> 	    !state->stack[spi].spilled_ptr.dynptr.first_slot)
>>> 		return false;
>>>
>>> 	/* ARG_PTR_TO_DYNPTR takes any type of dynptr */
>>> 	if (arg_type == ARG_PTR_TO_DYNPTR)
>>> 		return true;
>>>
>>> 	return state->stack[spi].spilled_ptr.dynptr.type == arg_to_dynptr_type(arg_type);
>>> }

> > [...]

There is another issue I noticed while basing other work on this. You have
declared bpf_dynptr in UAPI header as:

	struct bpf_dynptr {
		__u64 :64;
		__u64 :64;
	} __attribute__((aligned(8)));

Sadly, in C standard, the compiler is under no obligation to initialize padding
bits when the object is zero initialized (using = {}). It is worse, when
unrelated struct fields are assigned the padding bits are assumed to attain
unspecified values, but compilers are usually conservative in that case (C11
6.2.6.1 p6).

See 5eaed6eedbe9 ("bpf: Fix a bpf_timer initialization issue") on how this has
bitten us once before.

I was kinda surprised you don't hit this with your selftests, since in the BPF
assembly of dynptr_fail.o/dynptr_success.o I seldom see stack location of dynptr
being zeroed out. But after applying the fix for the above issue, I see this
error and many failing tests (only 26/36 passed).

verifier internal error: variable not initialized on stack in mark_as_dynptr_data

So I think the bug above was papering over this issue? I will look at it in more
detail later.

--
Kartikeya
