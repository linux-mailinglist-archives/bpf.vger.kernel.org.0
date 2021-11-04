Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03870445CA6
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 00:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhKDXdN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 19:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhKDXdL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 19:33:11 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C950C061714
        for <bpf@vger.kernel.org>; Thu,  4 Nov 2021 16:30:32 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id w5-20020a654105000000b002692534afceso4761684pgp.8
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9jEelQ1kmwoVcHTHOWutr9a4iB4dYFWpOgpAivbGHMk=;
        b=Mol/7xr/LOshkyvy6y8sA7XtNheShKffzNUjzISlHMGG3LDqX0dtmH4CE6JAEIzV26
         N9Eftw/y1f0sha+3wEk3MaBLI/gqvbT0QzhM4OpKI2fUyN0lEh05tjhceYYotVbib7St
         T8sUZSr4fKtqXsBv2gEaH8vpn84JcOi9j4ZwuMe2wJStER+wSHgTtw/FY9vg3scnYezw
         7OAAZch7FUGrKZGtoGC0nOR5aXulQbSTyCMgKXMU7Vhg5yirWzrzJMmRtoXHgdiYZo7e
         T5b2NUO8ybM3Sa8TewiE28nt7aRRAA62UNCdMjVTjjaMaYdGEGh6qT017HSFRFiNwKaa
         4QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9jEelQ1kmwoVcHTHOWutr9a4iB4dYFWpOgpAivbGHMk=;
        b=y92RBd/4TC7DJKxWZaUo2VQharfOkR06cXkkH7ycnUz/676XB5Wtk+zoU8i/plUqpj
         AeAbeAmT4mZg5+YWS/4Zfmo6r+cWNfMErL3xw0OgkL8YChJ3Gx1jBND2Oi+xNw2eLF+G
         K8tG1bZhUt+8axi/ufcNBQHLwdExHWiuMuhO4CrZB/UVgrt5fqUgbQqWPgqcLgK6Hz7V
         QSeNTal3JndY0VIxN/GX2ouphzcTKgrk/Y00oYOZVUT5Vdq0rM3slE/ikSq/aYRX1k4M
         ooLtahoGXzKV/5sF1AH6fcC3G0yAkFVqE2nkTPhr6rJ7pmwyBO+V2IeQUzOZ6qTqc5ca
         KIAA==
X-Gm-Message-State: AOAM532Utx7WJHfg1rgM9zFqUypUFq0EUKZkGQiRAFYha2Se3cQ4Hy3m
        5b1v6PAXwaNApNCukgpA5kugF/A=
X-Google-Smtp-Source: ABdhPJzsjEbBTCOOQdiLohQw9MdQXv8rAFFKUBhxX/YxieXGV0tIbL1qxZYuYEESu7lcXbnqsmAIdmo=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:268c:cb2d:5cc8:ad4])
 (user=sdf job=sendgmr) by 2002:a05:6a00:a1d:b0:44d:aa2d:9665 with SMTP id
 p29-20020a056a000a1d00b0044daa2d9665mr55115963pfh.24.1636068631714; Thu, 04
 Nov 2021 16:30:31 -0700 (PDT)
Date:   Thu, 4 Nov 2021 16:30:30 -0700
In-Reply-To: <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
Message-Id: <YYRtFp7GOEAi7vQH@google.com>
Mime-Version: 1.0
References: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
 <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
Subject: Re: Verifier rejects previously accepted program
From:   sdf@google.com
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, regressions@lists.linux.dev,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/04, Alexei Starovoitov wrote:
> On Wed, Nov 3, 2021 at 4:55 AM Lorenz Bauer <lmb@cloudflare.com> wrote:

> > #pragma clang loop unroll(full)
> >     for (int b = 1 << 10; b >= 4; b >>= 1) {
> >         if (start + b > end) {
> >             continue;
> >         }
> >
> >         // If we do 8 byte reads, we have to handle overflows which is
> > slower than 4 byte reads.
> >         for (int i = 0; i < b; i += 4) {
> >             csum += *(uint32_t *)(start + i);
> >         }
> >
> >         start += b;
> >     }
> >     if (start + 2 <= end) {
> >         csum += *(uint16_t *)(start);
> >         start += 2;
> >     }
> >     if (start + 1 <= end) {
> >         csum += *(start);
> >     }

> Thanks for flagging!
> Could you craft a test case that we can use a repro and future
> test case?

> > fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
> ...
> > I've bisected the problem to commit 3e8ce29850f1 ("bpf: Prevent
> > pointer mismatch in bpf_timer_init.") The commit seems unrelated to
> > loop processing though (it does touch the verifier however). Either I
> > got the bisection wrong or there is something subtle going on.

> I stared at that commit and the example asm.
> I suspect the bisect went wrong.

> Could you try reverting a single
> commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
> ?
> The above fp-112=inv means that the verifier is tracking scalar spill.
> That could be the reason for bounded loop logic seeing different
> stack state on every iteration.
> But the asm snippet doesn't have the store to stack at [fp-112]
> location, so it could be a red herring.

> Are you using the same llvm during bisect?
> The commit 354e8f1970f8 should be harmless
> (when commit f30d4968e9ae ("bpf: Do not reject when the stack read
> size is different from the tracked scalar size"))
> is also applied. That fix is in bpf tree only, so far.
> The tracking of 8-byte spill is the most useful with the latest llvm
> that was taught to use 8-byte aligned stack for such spills.

> Without being able to repro it's hard to investigate much further.

Not to derail the conversation, but we do actually see a problem
with commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and
refill"). Program that passed without it now gets:

  R0=inv(id=0) R1_w=invP0 R2_w=invP0 R5_w=inv0 R6=ctx(id=0,off=0,imm=0)  
R7=map_value(id=0,off=0,ks=4,vs=9616,imm=0) R8=inv(id=0)  
R9_w=map_value(id=0,off=0,ks=4,vs=9616,imm=0) R10=fp0 fp-8=mmmm????  
fp-16=mmmmmmmm fp-24=00000000 fp-32=inv fp-40=00000000 fp-48=inv  
fp-56=mmmmmmmm fp-64=mmmmmmmm
479: (79) r1 = *(u64 *)(r10 -32)
corrupted spill memory
processed 970 insns (limit 1000000) max_states_per_insn 2 total_states 73  
peak_states 73 mark_read 24

Here is where R10 flips from 'fp0' to 'fp-8=mmmm????':

137: (5d) if r3 != r4 goto pc-102
  R0=inv(id=0) R1=invP0 R2=inv0 R3_w=inv4294901760 R4_w=inv4294901760  
R6=ctx(id=0,off=0,imm=0) R7=inv8 R10=fp0 fp-16=00000000 fp-24=00000000  
fp-32=00000000 fp-40=00000000 fp-48=00000000 fp-56=mmmmmmmm
138: (61) r7 = *(u32 *)(r6 +28)
139: (61) r2 = *(u32 *)(r6 +24)
140: (63) *(u32 *)(r10 -48) = r2
141: (63) *(u32 *)(r10 -32) = r7
142: (63) *(u32 *)(r10 -4) = r1
143: (bf) r2 = r10
144: (07) r2 += -4
145: (18) r1 = 0xffff8803fe837e00
147: (85) call bpf_map_lookup_elem#1
148: (55) if r0 != 0x0 goto pc+5
  R0=inv0 R6=ctx(id=0,off=0,imm=0)  
R7=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0  
fp-8=mmmm???? fp-16=00000000 fp-24=00000000 fp-32=inv fp-40=00000000  
fp-48=inv fp-56=mmmmmmmm

We are not using latest clang (don't have https://reviews.llvm.org/D109073).

Added Martin to CC in case he can get any clues from the verifier log.
