Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6582564F06D
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiLPRfb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 12:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiLPRfa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 12:35:30 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CCB1C932
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 09:35:28 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id bw27so1115744qtb.3
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 09:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yry1pSsyAUQ9D9QM+/qrFawxY99AxWgvbHDsHZU3h+g=;
        b=CKYokNDjRvu8ma9mLbsmZJ3LECdYuUh5gykJ+lNCJpMhh1C45JOO+y7l+ZCGa7+aLZ
         5T4uROcQ19NEn2L6xbFCZrMm72FakNw0pYpXI92QMAhHgPjj8IFCYi7E5QtdWSWPTLZl
         DiWFiqL1kNiGqFjX/jsJXWpnFclJ+ReJ39S30WnSbsjyFh+P2Gc3+9Nvn6M7l67Bq1tk
         LmyEqPsQDJQpby1l1mVRtHF6OpxQjZ8QQ5/HfuuR/So+BAk27QdWJ5V9mZM++58cKH5N
         O7lhaznKvF3WTC1XgXr0z4vUtpNhNY/v0l848eZo766JpPHhUlWGF4bVqefYx2+5drGd
         krug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yry1pSsyAUQ9D9QM+/qrFawxY99AxWgvbHDsHZU3h+g=;
        b=qccS6eHJcsqLadJxIXJMHk1GlPqry7lJ04YkRtJoBSZt3+2DSN2YlbfgvnvM0BWsxz
         YXwqSNoZtKQqVC56YF+PhpUxHJP+HzROKSu/TV/4FrBSZwajiFjDK3NtU5KxwaUftqSE
         8szNmcG+Y9k997H5OPBsNd9WgKTho8Scov4bN2nDt+xxo2iF8uJb9lLUL29Q5IVJ0APC
         LPxYkInVcRrTjUnqQwIwSFzeaOBZTT4xRzqnJbi/Zdsvw82/mKFb5ilJI0VPcK9TAK7/
         xDPBf40w0UjZ2uBj1KZ42CPIeJh8Pa22Ep/AllAzqQc4moLNZXUgkGrBAqMVC5cwDCTc
         vIuQ==
X-Gm-Message-State: ANoB5pm3/USkICFSr/zXhQNUv1nLjVsMosnKDTuwFHaWfWbLG3Stykn7
        pDxKp+gyn0Hq5LqpLQWwF/M=
X-Google-Smtp-Source: AA0mqf6Ahsz1gGEN5kq3QI+CRZx/P9Q6pdhU2uviAmgRLTYfpyUnLo7ua6KKXiEmKLc0TuGlB2a13A==
X-Received: by 2002:ac8:4e19:0:b0:3a7:efe3:47c8 with SMTP id c25-20020ac84e19000000b003a7efe347c8mr39121390qtw.6.1671212127956;
        Fri, 16 Dec 2022 09:35:27 -0800 (PST)
Received: from MacBook-Pro-6.local ([2601:700:4100:1740:99:c9bc:492c:46e4])
        by smtp.gmail.com with ESMTPSA id d19-20020ac800d3000000b003a527d29a41sm1670910qtg.75.2022.12.16.09.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:35:27 -0800 (PST)
Date:   Fri, 16 Dec 2022 09:35:26 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH v2 bpf-next 0/6] Dynptr convenience helpers
Message-ID: <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
References: <20221207205537.860248-1-joannelkoong@gmail.com>
 <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
 <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 12:12:09PM -0800, Andrii Nakryiko wrote:
> 
> There is no clean way to ever move from unstable kfunc to a stable helper.

No clean way? Yet in the other email you proposed a way.
Not pretty, but workable.
I'm sure if ever there will be a need to stabilize the kfunc we will
find a clean way to do it.
Strongly arguing right now that this is an issue without doing the home work
is not productive.

> BPF helpers also have the advantage of working on all architectures,
> whether that architecture supports kfuncs or not, whether it supports
> JIT or not.

Correct, but applying the same argument we should argue that
all features must work in the interpreter as well, because
not all architectures support JIT.
This way struct-ops and bpf based TCP-CC would never be possible.
Some JITs don't support tail calls with subprogs.
freplace (bpf prog replacement) works when JITed only.
bpf trampoline works on x86-64 only.
while kfuncs work on more than one arch.

Now comapre the amount of .text that kernel has to contain
to support hundreds of helpers vs same amount of kfuncs.
In the former it's a whole bunch of code that is there in the kernel
in case bpf prog will call that helper. With 200+ helpers and half
of them already deprecated we have quite a bit of dead code in the kernel
that we cannot delete.
While with kfunc approach there is no extra code that deals with
conversion of the registers from bpf psABI to arch psABI.
With kfuncs we generate this code on demand.

> BPF helpers are also nicely self-discoverable and documented in
> include/uapi/linux/bpf.h, in one place where other BPF helpers are.
> This is a big deal, especially for non-expert BPF users (a vast
> majority of BPF users).

Good point. In general the kfuncs are not up to the level of
documentation of helpers and we should work on improving that,
but some of kfuncs are better documented than helpers.
So it's not black and white.

Discoverability we discussed in the past.
The task to automatically emit kfuncs into vmlinux.h is still not complete.
Time to prioritize it higher.

> 
> > non-gpl and consistency don't even come close.
> > We've been doing everything new as kfuncs and dynptr is not special.
> 
> I think dynptr is quite special. It's a very generic and fundamental
> concept, part of core BPF experience. It's a more dynamic counterpart
> to an inflexible statically sized `void * + size` pair of arguments
> sent to helpers for input or output memory regions. Dynptr has no
> inherent dependencies on BTF, kfuncs, trampolines, JIT, nothing.

imo dynptr and kptr are more or less equivalent in terms of being core
building blocks.
kptrs are done via kfuncs, so dynptr can do just as well.

> By requiring kfunc-based helpers we are significantly raising the
> obstacles towards adopting dynptr across a wide range of BPF
> applications.

Sorry, but I have to disagree. kptr and dynptr are left and right hand.
Both will work just fine as kfuncs.

> And the only advantage in return is that we get a hypothetical chance
> to change something in the future. But let's see if that will ever be
> necessary for the helpers Joanne is adding:
> 
> 1. Generic accessors to check validity of *any* dynptr, and it's
> inherent properties like offset, available size, read-only property
> (just as useful somethings as bpf_ringbuf_query() is for ringbufs,
> both for debugging and for various heuristics in production).
> 
> bpf_dynptr_is_null(struct bpf_dynptr *ptr)
> long bpf_dynptr_get_size(struct bpf_dynptr *ptr)
> long bpf_dynptr_get_offset(struct bpf_dynptr *ptr)
> bpf_dynptr_is_rdonly(struct bpf_dynptr *ptr)
> 
> There is nothing to add or remove here. No flags, no change in semantics.

Disagree, since there is an obvious counter example.
See all of bpf_get_current_task*().
Some of them are still used, but
bpf_get_current_task vs bpf_get_current_task_btf is our acknowledgement
of the fact that we suck in inventing uapi.
It's the lesson that we've learned the hard way.
Not going to repeat that mistake again.

To be completely honest I expect that dynptr may get obsolete
as the whole concept several years from now.
We still don't have a single actual user of it.
Just like kptr. Could be deprecated eventually just as well.

> 3. This one is the only one I feel less strongly about, but mostly
> because I can implement the same (even though less ergonomically, of
> course) with bpf_loop() and bpf_dynptr_{clone,advance}.
> 
> long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn,
> void *callback_ctx, u64 flags)

Speaking of your upcoming inline iterators.
Please make sure that you're adding them as kfuncs.
We've made a mistake with bpf_loop. It's a stable helper,
but inline iterators will immediately deprecate most uses of bpf_loop.
If bpf_loop was a kfunc we would have deleted it.

> Let's also note that verifier knows specific flavor of dynptr and thus
> can enforce additional restrictions based on specifically SKB/XDP
> flavor vs LOCAL/RINGBUF. So just because there is no perfect way to
> handle all the SKB/XDP physical non-contiguity, doesn't mean that the
> dynptr concept itself is flawed or not well thought out. It's just

I think that's exactly what it means. dynptr concept is flawed.
It's ok to add this flawed feature to the kernel right now,
because we don't see a better way today, but that might change
in the future and we gotta be able to fix our mistakes.
