Return-Path: <bpf+bounces-8313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDA0784D00
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4EA1C20B4E
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 22:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55DD34CF2;
	Tue, 22 Aug 2023 22:54:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4A2019C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 22:54:27 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026DFCFC
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 15:54:25 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso5572123e87.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 15:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692744864; x=1693349664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XTwuQe9ZB45yHC0i3uR5QLP6TeyUodBKaPgZzQfY39c=;
        b=VhllwdTgxnG+vdjAD9Hp5AqAEs8oBBtk1eXmgNrrh0gxCT1vi89N/I87rzKJrZLcpp
         Q0lrjRG/ejXTCUFMNmkv/vPL6wj+noN2sD6A41YOM9Ts+fq7bi1FSErffFbAmsC3R/e2
         /0jzS1bqEcBh1m8DHqrAFPySvrm1eJgwjBP0j3ToRcCVcDOcy86fABe9ctxjFWSU/sXT
         dm9oFN6rFieQ4LvfeWmbhsDwt7zcqA+2sFbIpkbUOpLyQLqwzWAOVHcWYdMm4/ZzQ6JL
         7n9fhRDAW4QA71a67r5diiKI0GoShtVuvnNkUPy4V2R8Njqm86PFVttD+nEnWIEqMTgs
         Xy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692744864; x=1693349664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTwuQe9ZB45yHC0i3uR5QLP6TeyUodBKaPgZzQfY39c=;
        b=RPGWHGkqve9cZo6FzXYCekdZ0l6iLGtHuCVmtN3m1DaCLcsaIg5U6GqsJpM+21dYtY
         pt3Nu/TiqgQMuv6rTZAlzZiTsJ9VpxcQITp+xKbjo8yWNkCfXuFqw3EN/fQIe86F6JjW
         86Q/rcEFFjRibl1i3fs14OLBXZiIiVIU0CBbxoID+ubQl73TtUUbdLri++VOFDRlCZH8
         2ydgc/FfC3/fAJFnEYfTco0JW5Oj1xDQ18LEYN0gX7YQrPkLrYj2qIHcYG44JU95M/UF
         /5ipHe8OY440ayZ0eDWgqDhUWAdmcnQN7iv42Rvuqvd1eKWBipK5dS7Ob344tQUhsGTq
         w8hw==
X-Gm-Message-State: AOJu0YykhNq2vkfwc9dy5FfcO9PIQmE6HB9h3Dbf0RUu9p0WZUYafGID
	i8XnZPv0lynxaTEjjnEfr3aSUlFA0E/SGTkwfLpkaC51wnCXxg==
X-Google-Smtp-Source: AGHT+IEMzpKLs7xccR5EwLx0wpX5ugnrp6MBvg4bq3c2/GNo2r+sDFZCStQAvGcxUoZ/XMuNUMoSjtZTNPyjc/+uyCY=
X-Received: by 2002:a05:6512:a94:b0:4fe:c4e:709f with SMTP id
 m20-20020a0565120a9400b004fe0c4e709fmr8984542lfu.20.1692744863906; Tue, 22
 Aug 2023 15:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <CAP01T75MjLeu01FJjxcEF3O1f+4=MiP3St_2M5fmTW9RqkGPnw@mail.gmail.com>
 <87lee2enow.fsf@oracle.com> <f7c404d8-41b5-a48d-f156-5556b38f384e@linux.dev>
In-Reply-To: <f7c404d8-41b5-a48d-f156-5556b38f384e@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 23 Aug 2023 04:23:47 +0530
Message-ID: <CAP01T757oTUPuRaxiaNZh2E5FtLdWiYybZy453LUYEE7RmY63Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/14] Exceptions - 1/2
To: yonghong.song@linux.dev
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 23 Aug 2023 at 04:09, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
>
> On 8/22/23 3:07 PM, Jose E. Marchesi wrote:
> >
> >> On Wed, 9 Aug 2023 at 17:11, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >>>
> >>> [...]
> >>>
> >>> Known issues
> >>> ------------
> >>>
> >>>   * Just asm volatile ("call bpf_throw" :::) does not emit DATASEC .ksyms
> >>>     for bpf_throw, there needs to be explicit call in C for clang to emit
> >>>     the DATASEC info in BTF, leading to errors during compilation.
> >>>
> >>
> >> Hi Yonghong, I'd like to ask you about this issue to figure out
> >> whether this is something worth fixing in clang or not.
> >> It pops up in programs which only use bpf_assert macros (which emit
> >> the call to bpf_throw using inline assembly) and not bpf_throw kfunc
> >> directly.
> >>
> >> I believe in case we emit a call bpf_throw instruction, the BPF
> >> backend code will not see any DWARF debug info for the respective
> >> symbol, so it will also not be able to convert it and emit anything to
> >> .BTF section in case no direct call without asm volatile is present.
> >> Therefore my guess is that this isn't something that can be fixed in
> >> clang/LLVM.
> >
> > Besides, please keep in mind that GCC doens't have an integrated
> > assembler, and therefore relying on clang's understanding on the
> > instructions in inline assembly is something to avoid.
> >
> >> There are also options like the one below to work around it.
> >> if ((volatile int){0}) bpf_throw();
> >> asm volatile ("call bpf_throw");
> >
> > I can confirm the above results in a BTF entry for bpf_throw with
> > bpf-unknown-none-gcc -gbtf.
>
> Kumar, you are correct.
> For clang, symbols inside 'asm volatile' statement or generally
> inside any asm code (e.g., kernel .s files) won't generate an entry
> in dwarf. The
>    if ((volatile int){0}) bpf_throw();
> will force a dwarf, hence btf, entry.
>
> The unfortunately thing is the above code will generate redundant code
> like
>    0000000000000000 <foo>:
>         0:       b7 01 00 00 00 00 00 00 r1 = 0x0
>         1:       63 1a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) = r1
>         2:       61 a1 fc ff 00 00 00 00 r1 = *(u32 *)(r10 - 0x4)
>         3:       15 01 01 00 00 00 00 00 if r1 == 0x0 goto +0x1 <LBB0_2>
>         4:       85 10 00 00 ff ff ff ff call -0x1
>
> 0000000000000028 <LBB0_2>:
>         5:       85 10 00 00 ff ff ff ff call -0x1
>         6:       b7 00 00 00 00 00 00 00 r0 = 0x0
>         7:       95 00 00 00 00 00 00 00 exit
>

Yes, I am relying on the verifier to eliminate dead code later, but it
is obviously a hack.

> I am curious why in bpf_assert macro bpf_throw() kfunc cannot
> be used?

The reason was to force the compiler to emit a specific branch for the
assertion check without being influenced by compiler optimizations,
and tying comparison to the register holding a value being tested in
assertion. Secondly we also enforce that the first argument is in a
register and the second a constant, so as to apply the verifier bounds
gained after comparison op to the original register.

I am aware (though correct me if this is wrong) that the compiler can
select a different register for the input operand of the asm
constraint, but find_equal_id_scalars should still do correct
propagation. This is partly why I disabled usage of this macro for
variable widths < 64-bit, because then the compiler sometimes performs
shifts etc. for integer promotion implicitly, sometimes destroying
whatever information we gained through an assertion check. Depending
on the signedness of the variable, we emit the signed/unsigned
comparison.

I suppose we could switch to the ' if (!(LHS <op> RHS)) bpf_throw(); '
sequence in C, force volatile load for LHS and __builtin_constant_p
for RHS to get the same behavior. Emitting these redundant checks is
definitely a bit weird just to emit BTF.

