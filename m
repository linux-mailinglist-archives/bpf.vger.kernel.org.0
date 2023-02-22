Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59269FEA6
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 23:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjBVWoA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 17:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBVWn7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 17:43:59 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267B510D9
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:43:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id da10so37850011edb.3
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GPU0Dt9ZvMuvtsi0K/OfiMRDtedAJMLPwN161+wKdaI=;
        b=Mpi2jFD9iladxD4Mp+0fjy1Wrss3Uf94Lvg6sU0a3QfG8cLdzu7XQUPCYMjjxIE15H
         E1scd2VishNVkgy3ppVo3+sdyshrvxs4QzxenMChkW5TqSV+GrTgyjrcZqwwNF26t9j7
         dvJdjSfJPD5BJZqVmG2rAfBVNipNwDkIyYyzDp/X80dmjS3b5dN+Rn4TwuNCdRUZr8+Y
         jJcz363X72BI/jPjlfarfvTKvNyGy4GUc3BtezmPE6MfT7XHMo/w9okzHo35NXGdeliI
         F6zcPwg2Wl1jZu4VqQKYOLiR4P45XCeIgRelu1VduoFpgV0ZSIn5AybPLlFodPXuzoGI
         hWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPU0Dt9ZvMuvtsi0K/OfiMRDtedAJMLPwN161+wKdaI=;
        b=bnD7Ot8OYeMLuHJT9l3vtQpR8V87XtuCa25p9M62Rw+kAxfYGkJk+fsL6m5IirJ0L6
         ZccRAM7wX/jGAUytmnh5vO7McEk66HHKxqLHQ3+X1uQTUGtslT4fGauZ7vIMQSX/6SHu
         +wqcy5sUA389zo4yEZ8cJDH8i5MBbeuzFzU6RBgJ8+vsGqh0IU3ahFYO5zMSdFBYOm8w
         S1GpBq2XVIxAnxs2uQxgN9855VX9nxlfhONlDxbat0A3RJ+EaAWWUtBMu1Z9pecNE/qJ
         2YZITErKM7C0cgPVwlaH4ch3uN/KNFu+8wLY62o7GVhhKhBHijVC+7PFuPGp9z9pOMQU
         cbeQ==
X-Gm-Message-State: AO0yUKWZmjYQqMpg+xDfuQYD/5l1aABFtOGwMsNMYCbgShnG3lFaCrdY
        b7CuzRyB/6mTxvEUxVKy/qqy9dgycruTASXcNAo=
X-Google-Smtp-Source: AK7set8jesjxpAW/gl3n1T8wSazpMuPla8v+Wb5sS0mycUc4D4UulLLy1OyVYvb9udjthFhrczdeB7F9JZK+xxdJB/Y=
X-Received: by 2002:a17:906:3416:b0:879:b98d:eb08 with SMTP id
 c22-20020a170906341600b00879b98deb08mr7959778ejb.3.1677105836414; Wed, 22 Feb
 2023 14:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20230220225228.2129-1-dthaler1968@googlemail.com>
 <CAADnVQJHvFCTq-fWiore4iL9MV7CicDt=Tn697ZU3QMu-wWxeA@mail.gmail.com> <PH7PR21MB38786142836F214747C82A92A3AA9@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB38786142836F214747C82A92A3AA9@PH7PR21MB3878.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 14:43:45 -0800
Message-ID: <CAADnVQL+6i7DRsE9kVdEwQ00ciB95FceRYv4DYdwEMF1HUif9A@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v3] bpf, docs: Explain helper functions
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
        bpf <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>,
        David Vernet <void@manifault.com>
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

On Wed, Feb 22, 2023 at 2:23 PM Dave Thaler <dthaler@microsoft.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> [...]
> > > +Helper functions
> > > +~~~~~~~~~~~~~~~~
> > > +
> > > +Helper functions are a concept whereby BPF programs can call into a
> > > +set of function calls exposed by the runtime.  Each helper function
> > > +is identified by an integer used in a ``BPF_CALL`` instruction.
> > > +The available helper functions may differ for each program type.
> > > +
> > > +Conceptually, each helper function is implemented with a commonly
> > > +shared function signature defined as:
> > > +
> > > +  u64 function(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5)
> > > +
> > > +In actuality, each helper function is defined as taking between 0 and
> > > +5 arguments, with the remaining registers being ignored.  The
> > > +definition of a helper function is responsible for specifying the
> > > +type (e.g., integer, pointer, etc.) of the value returned, the number of
> > arguments, and the type of each argument.
> >
> > Above is correct, but it aims to describe the calling convention which should
> > be done in a separate BPF psABI doc and not in instruction-set.rst.
> > And if we start describing calling convention we should talk about promotion
> > rules, sign extensions, expectations for return values, for passing structs by
> > value, etc.
>
> The instruction itself requires defining the concept of a helper function,

Not really. BPF_CALL instruction doesn't have to define what it's calling
and how the call is being made.
Typical cpu will define CALL insn as:

1. pushes the return address on the stack.
2. changes IP to the call destination

That's it. Mechanics of CALL have no overlap with calling convention.
Different languages and operating systems can do it differently.
BPF ISA doc should describe mechanics of instructions only.

> so is the
> text in question the part starting with "Conceptually," down to the end of the
> quoted text?

Right, that part doesn't belong in BPF ISA doc.
Even
"Each helper function is identified by an integer used in a
``BPF_CALL`` instruction."
arguably belongs in psABI, since it's a bpf's flavor of relocations.
Other cpus do it in ELF relocations while bpf does it inline as part
of instruction encoding. That is not an ISA.
It's a protocol between user and kernel.
We just happen to use bits in instruction to indicate relocation
that kernel has to perform before executing call insn.
At the end JITs will map BPF_CALL insn one to one to CPU call insn
on architectures where calling conventions match.

> Since there is no separate BPF psABI document (and I'm not sure the scope of
> that document myself) can we put it here for now and move it when that doc
> is created?   If not, what part of the text above would be in a separate document?

BPF psABI should look like:
https://raw.githubusercontent.com/wiki/hjl-tools/x86-psABI/x86-64-psABI-1.0.pdf

Ours will be shorter, hopefully.
We haven't defined a bunch of things yet. Like how to pass 6th argument.
