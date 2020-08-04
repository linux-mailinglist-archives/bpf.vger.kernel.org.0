Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006F423B968
	for <lists+bpf@lfdr.de>; Tue,  4 Aug 2020 13:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHDLTY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Aug 2020 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbgHDLOs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Aug 2020 07:14:48 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C620BC06179F
        for <bpf@vger.kernel.org>; Tue,  4 Aug 2020 04:13:56 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id b22so10045948oic.8
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2020 04:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GrI9w8HWkjADHcg7T1QBEwERlzTc0/K0EbIgQ9ux3w=;
        b=opmKQxSyjsauuGeHLNU2NfBXXqIZwQY+hNIGtFzx1ug/iflsmbmTtD6aeFMsytb75u
         rJ8LvzRINH07uYvccs1F2uUBBCJt/7l4Pbn1r/UZwi/JDCZSH7/byx9kezP2IvrG0q5c
         cG51UZX+mk/CAMFIGffF3lWBch7WtKEDlSfGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GrI9w8HWkjADHcg7T1QBEwERlzTc0/K0EbIgQ9ux3w=;
        b=IHW6KXW/w3GNFB050B3tue49LQMs6ByeQWKElFC+Hc4Sf6yNmGaPzpc+wj4JBExEY+
         yCb9wkzo4n/Z1BeFCaeODWM6amCpjfMFryppFd0LC+sUKM43a525fB7RI9ztBflvL3Wf
         JQvmdlwuwPSFfAdPj0sBvKR+ldsoZ62p2UxGUTlqQoLH8I1FedL0tKtzr3OCxPdWL7iQ
         btzXXBCiukBjDDZcjCmUF4iI907z+2GGzaTdFM1MKh698o4yhKMFEkgCXxO88UNLrwdP
         nghrEryL24HdyKqOhckN+K7Hzcydkk65wi1d8pRGjQZsij6n75nKZtzR/aWveJbQ8HTZ
         hlgw==
X-Gm-Message-State: AOAM530Dd0kObtgxNGg1oWCdVH0zKoJpzfm7lYDUM7YFoWlq4xVUlmBG
        5m8P7GmJVS7JjmSTtmecaDzORWo2P6FYGsRzOBthMw==
X-Google-Smtp-Source: ABdhPJyw1cCR4DRMkC9jkxGwSToaHHMtZf0zS0GQEQNn0tj1PEnVi1zEEM5Jzr/4TpC04QuoQGaHT0+5IHYGiGdRMiA=
X-Received: by 2002:a54:4795:: with SMTP id o21mr2983254oic.13.1596539636094;
 Tue, 04 Aug 2020 04:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_g6mgg_DoYpbMaWpE8BQAC+S5XG8U4aw1JAMoOxiDtPQ@mail.gmail.com>
 <20200720203755.icfvzannjwqusbes@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200720203755.icfvzannjwqusbes@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 4 Aug 2020 12:13:44 +0100
Message-ID: <CACAyw98Ddv=bCtcvbceRA+2dKJxDnbGrS9+Lb9d6d0zZt9cmEg@mail.gmail.com>
Subject: Re: Verification speed w/ KASAN builds
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 20 Jul 2020 at 21:37, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 17, 2020 at 11:46:37AM +0100, Lorenz Bauer wrote:
> > Hi list,
> >
> > I'm not sure whether this is a bug report or just the way of life.
> > The problem: we have a couple of machines that run KASAN
> > kernels to weed out bugs. On those machines, loading our
> > cls-redirect TC classifier takes so long that our user space
> > program aborts.
> >
> > I've reproduced this in a VM: loading cls-redirect on a VM
> > with a 5.4 kernel without KASAN takes around 4 seconds.
> > Doing the same on recent bpf-next with KASAN and other
> > shenanigans enabled it takes more like a minute.
>
> a minute to load single program? that sounds high.
> While processing patches I build the kernel with kasan and lockdep.
> None of test_progs and test_verifier programs have such drastic
> slowdowns. I'm not sure what is the reason.

Sorry for the long delay, I was on holiday.

> do you use kasan inline or outline ?

CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=1
# CONFIG_KASAN_VMALLOC is not set
# CONFIG_TEST_KASAN is not set

Looks like the inline version.

>
> > Is it expected that the overhead of KASAN is this large?
>
> sounds like 20x overhead ? I think 10x is normal.
>
> > I went and collected a perf profile of loading the program
> > in the VM:
> >
> > -   96.31%     1.00%  redirect.test  [kernel.kallsyms]  [k] do_check_common
> >    - 95.32% do_check_common
> >       - 69.24% states_equal.isra.0
> >          + 49.81% kmem_cache_alloc_trace
> >          + 16.77% kfree
> >          + 1.22% regsafe.part.0
> >       - 12.75% push_stack
> >          - 10.65% copy_verifier_state
> >             - 4.50% realloc_stack_state
> >                + 4.48% __kmalloc
> >             + 4.16% kmem_cache_alloc_trace
> >             + 1.82% __kmalloc
> >          + 2.07% kmem_cache_alloc_trace
> >       + 5.25% pop_stack
> >       + 2.84% push_jmp_history.isra.0
> >       + 2.46% copy_verifier_state
> >       + 1.00% free_verifier_state
> >         0.53% kmem_cache_alloc_trace
> >    + 1.00% runtime.goexit
>
> the perf profile makes sense.
> how many insn it processed?

On a fresh bpf-next build in the VM:

    TestLoadProgram: redirect.go:76: cls_redirect load time 1m11.886066762s
    TestLoadProgram: redirect.go:77: 25735 insns (limit 1000000)
max_states_per_insn 28 total_states 26728 peak_states 1362 mark_read
26

On my ubuntu 5.4.0-40-generic #44-Ubuntu (not VM!):

    TestLoadProgram: redirect.go:76: cls_redirect load time 3.025380047s
    TestLoadProgram: redirect.go:77: 25735 insns (limit 1000000)
max_states_per_insn 28 total_states 26728 peak_states 1362 mark_read
26

> what are test_progs -s stats ?

#7/1 loop3.o:OK
verification time 2215681 usec
stack depth 8+0
processed 554754 insns (limit 1000000) max_states_per_insn 18
total_states 8636 peak_states 2141 mark_read 3
#7/2 test_verif_scale1.o:OK
verification time 4037383 usec
stack depth 8
processed 773445 insns (limit 1000000) max_states_per_insn 13
total_states 3048 peak_states 788 mark_read 1
#7/3 test_verif_scale2.o:OK
verification time 2132131 usec
stack depth 8+0
processed 845499 insns (limit 1000000) max_states_per_insn 18
total_states 8636 peak_states 2141 mark_read 3
#7/4 test_verif_scale3.o:OK
verification time 95848 usec
stack depth 0+352
processed 6102 insns (limit 1000000) max_states_per_insn 1
total_states 422 peak_states 422 mark_read 111
#7/5 pyperf_global.o:OK
verification time 1308885 usec
stack depth 352
processed 46378 insns (limit 1000000) max_states_per_insn 5
total_states 3263 peak_states 3241 mark_read 113
#7/6 pyperf50.o:OK
verification time 5858365 usec
stack depth 352
processed 99548 insns (limit 1000000) max_states_per_insn 5
total_states 6909 peak_states 6883 mark_read 214
#7/7 pyperf100.o:OK
verification time 20829297 usec
stack depth 344
processed 163461 insns (limit 1000000) max_states_per_insn 5
total_states 11566 peak_states 11539 mark_read 375
#7/8 pyperf180.o:OK
verification time 20471329 usec
stack depth 368
processed 628090 insns (limit 1000000) max_states_per_insn 7
total_states 30369 peak_states 30283 mark_read 751
#7/9 pyperf600.o:OK
verification time 7413522 usec
stack depth 320
processed 580752 insns (limit 1000000) max_states_per_insn 13
total_states 37099 peak_states 2118 mark_read 1292
#7/10 pyperf600_nounroll.o:OK
verification time 1046239 usec
stack depth 0
processed 361349 insns (limit 1000000) max_states_per_insn 4
total_states 5504 peak_states 5504 mark_read 31
#7/11 loop1.o:OK
verification time 32021 usec
stack depth 0
processed 1783 insns (limit 1000000) max_states_per_insn 8
total_states 57 peak_states 30 mark_read 2
#7/12 loop2.o:OK
verification time 8095 usec
stack depth 0
processed 524 insns (limit 1000000) max_states_per_insn 12
total_states 18 peak_states 17 mark_read 2
#7/13 loop4.o:OK
verification time 1116 usec
stack depth 0
processed 84 insns (limit 1000000) max_states_per_insn 2 total_states
9 peak_states 9 mark_read 2
#7/14 loop5.o:OK
verification time 8415325 usec
stack depth 496
processed 728100 insns (limit 1000000) max_states_per_insn 19
total_states 15783 peak_states 12404 mark_read 2674
#7/15 strobemeta.o:OK
verification time 1105531 usec
stack depth 488
processed 73803 insns (limit 1000000) max_states_per_insn 22
total_states 1997 peak_states 395 mark_read 137
#7/16 strobemeta_nounroll1.o:OK
verification time 13689512 usec
stack depth 488
processed 591026 insns (limit 1000000) max_states_per_insn 67
total_states 18823 peak_states 1901 mark_read 262
#7/17 strobemeta_nounroll2.o:OK
verification time 13242 usec
stack depth 488
processed 1464 insns (limit 1000000) max_states_per_insn 4
total_states 27 peak_states 27 mark_read 22
#7/18 test_sysctl_loop1.o:OK
verification time 13769 usec
stack depth 300+144
processed 1564 insns (limit 1000000) max_states_per_insn 4
total_states 28 peak_states 28 mark_read 22
#7/19 test_sysctl_loop2.o:OK
verification time 6436 usec
stack depth 36
processed 416 insns (limit 1000000) max_states_per_insn 1 total_states
19 peak_states 19 mark_read 6
#7/20 test_xdp_loop.o:OK
verification time 601603 usec
stack depth 88
processed 33670 insns (limit 1000000) max_states_per_insn 14
total_states 2214 peak_states 89 mark_read 7
#7/21 test_seg6_loop.o:OK
#7 bpf_verif_scale:OK
--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
