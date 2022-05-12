Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADFF5242D6
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 04:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbiELCjs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 22:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiELCjr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 22:39:47 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E130A14A26B
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 19:39:45 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id bs17so3757284qkb.0
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 19:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y90N8tOUma3AJ9n0Nwm8rTi29ne4uJwQQ7ukg3qfGC4=;
        b=TquMCjUDFIm0DcnUxVQBJ4BgONsM63lIGwxXoX7vkjLNuYWxPnLJgLVMA86quw1h2u
         b9uhGvglrDxiEExPxLPKtSo9nseDo7QBhRw6oAoFR700H9qPOutTGlCt6ghaEUo6u2Nj
         b/Dnj2/FULhzA3DBawB4MTqPob2SXWyz5Q5xmbApoLL2HwxDunNcwuNQQezXIliTOuYX
         HeGJROa6ZbX4bBH11ylY6TduF2hxLbfKnmXIbXXNb8+6vBtb8i6hvfShO+EPg0YBOQ5i
         Yv+nUfmyiaHixh6Co9V7QHidlxKulxxw3+U6URNwmFQ4Myw4Gq6m885zudhzcHDzE/l1
         UNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y90N8tOUma3AJ9n0Nwm8rTi29ne4uJwQQ7ukg3qfGC4=;
        b=cmxsIZQSPr+ndjd5bTgwTji098qpBRwYlhMtU9ttb0K7osBdKmSwVsNfhjNB1koCvN
         gJZ74gWRN3qkN+I5EmryTW0LVlLOzaQSmXWzXRnffskQfCpLu8v6tqdMbXYGU29SGVwL
         1gueNnFJ3O2Q7faFP6OfGvnh4gPwIxx+C/yU6zghLG5bjylAo9VPLu1w6GtSWNMJGu53
         mn5gua3Kc+C1f6pjlslrSCU8cV0E1j6KIY+zDn5I6T8LLeD2t9VycnFIOF5JkOZq/oL1
         7RW+qdNrhZAIYNqrkZJaVHQGOJDpErkrhCHTjJswaOUbZYZcU55cHOuRlqPUMRi7oLbO
         c2pQ==
X-Gm-Message-State: AOAM533lEP4swzzswfOK4apDciM2W/s59uoG4hwwQHhi4JeMzjB142Mw
        Gtr85vYH/gREM+17uNqWTV+Jwv5s3VTc54jhAx8=
X-Google-Smtp-Source: ABdhPJw/624jrgDdE6ZwG/XQ0IuiiAdfgJO2CAEjM/jJLyhLLaB+Ptea8HXTEK0Gd7JWKcrvrLPHyB80BtV7JlrUwPc=
X-Received: by 2002:a05:620a:28c7:b0:6a0:5de3:e6 with SMTP id
 l7-20020a05620a28c700b006a05de300e6mr16828861qkp.464.1652323184964; Wed, 11
 May 2022 19:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220503140449.GA22470@lst.de> <20220510081657.GA12910@lst.de>
In-Reply-To: <20220510081657.GA12910@lst.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 11 May 2022 19:39:34 -0700
Message-ID: <CAADnVQKBbh6T0-cs0WB2bsapg0wbb9Zu1az==CHD19sxeD5o_g@mail.gmail.com>
Subject: Re: LSF/MM session: eBPF standardization
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "Harris, James R" <james.r.harris@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Thaler <dthaler@microsoft.com>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Joe Stringer <joe@cilium.io>
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

On Tue, May 10, 2022 at 1:17 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Thanks everyone who participated.
>
> Here is my rough memory an action items from the meeting.  As I
> was on stage and did not take notes these might be a bit off and
> may need correction.
>
> The separate instruction set document wasn't known by everyone but
> seens as a good idea.
>
> The content needs a little more work:
>
>  - document the version levels, based on the clang cpu levels
>    (I plan to do this ASAP)

Turns out that clang -mcpu=v1,v2,v3 are not exactly correct.
We've extended ISA more than three times.
For example when we added more atomics insns in
https://lore.kernel.org/bpf/20210114181751.768687-1-jackmanb@google.com/

The corresponding llvm diff didn't add a new -mcpu flavor.
There was no need to do it.

Also llvm flags can turn a subset of insns on and off.
Like llvm can turn on alu32, but without <,<= insns.
-mcpu=v3 includes both. -mcpu=v2 are only <,<=.

So we need a plan B.

How about using the commit sha where support was added to the verifier
as a 'version' of the ISA ?

We can try to use a kernel version, but backports
will ruin that picture.
Looks like upstream 'commit sha' is the only stable number.

Another approach would be to declare the current ISA as
1.0 (or bpf-isa-may-2022) and
in the future bump it with every new insn.

>  - we need to decide to do about the legacy BPF packet access
>    instrutions.  Alexei mentioned that the modern JIT doesn't
>    even use those internally any more.

I think we need to document them as supported in the linux kernel,
but deprecated in general.
The standard might say "implementation defined" meaning that
different run-times don't have to support them.

>  - we need to document behavior for underflows / overflows and
>    other behavior not mentioned.  The example in the session
>    was divive by zero behavior.  Are there any notes on what
>    the consensus for a lot of this behavior is, or do we need
>    to reverse engineer it from the implementation?  I'd happily
>    write the documentation, but I'd be really grateful for any
>    input into what needs to go into it

For div by zero see do_misc_fixups().
We patch it with: 'if src_reg == 0 -> xor dst_reg, dst_reg'.
Interpreter and JITs will execute div/0 as-is, but in practice
it cannot happen because the verifier patched it.

Other undefined/underflows/overflows are implementation defined.
Meaning after JIT-ing they may behave differently on
different architectures.
For example the interpreter for shifts does
DST = DST OP (SRC & 63);
where OP is <<, >>
to avoid undefined behavior in C.

The JITs won't be adding the masking insns, since CPU HW will
do a mask implicitly. Which could potentially change
from one CPU to another.
I don't think it's worth documenting all that.
I would group all undefined/underflow/overflow as implementation
defined and document only things that matter.

>
> Discussion on where to host a definitive version of the document:
>
>  - I think the rough consensus is to just host regular (hopefully
>    low cadence) documents and maybe the latest gratest at a eBPF
>    foundation website.  Whom do we need to work with at the fundation
>    to make this happen?

foundation folks cc-ed.

>  - On a technical side we need to figure out a way how to build a
>    standalone document from the kerneldoc tree of documents.  I
>    volunteers to look into that as well.

+1

> The verifier is not very well documented, and mixes up generic behavior
> with that of specific implementations and program types.
>
>  - as idea it was brought up to write a doument with the minimal
>    verification requirements required for any eBPF implementation
>    independent of the program type.  Again I can volunteer to
>    draft a documentation, but I need input on what such a consensus
>    would be.  In this case input from the non-Linux verifier
>    implementors (I only know the Microsoft research one) would
>    be very helpful as well.

The verifier is a moving target.
I'd say minimal verification is the one that checks that:
- instructions are formed correctly
- opcode is valid
- no reserved bits are used
- registers are within range (r11+ are not used)
- combination of opcode+regs+off+imm is valid
- simple things like that
