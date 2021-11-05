Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE9445D39
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 02:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhKEBXF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 21:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhKEBXF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 21:23:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B5CC061714
        for <bpf@vger.kernel.org>; Thu,  4 Nov 2021 18:20:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o10-20020a17090a3d4a00b001a6555878a8so2216281pjf.1
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 18:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKeKaxsMJxim9BgJMliTdTdETDAYX56NckZ9IfvJR64=;
        b=KDhy/5LPPSH+nl8S4baB/KctuMl4XjcsUbXNlKf9lFoJaCmcmBEzPT+p2Lcv+oDjYl
         peyz4NNk8uqRizkfw21Suujnc+MR1D+tlPFfyLz3SjqdygDrRJS91HfCeBkExruml+5q
         0vRTPn26K5WREyl1Ik6ecmavvqV0XqSEiPHzv0zEa4Ken9ekaK6IRkhI8Vyqqcm6Hpn4
         p3dlwOObuVwPAMBdEhKUwcXO3PJKbldgvej/JyLt6rPXxe5gXuOBGNp0Z7gPbCxDm8QC
         BpZtHatUl+WIBApWnDb5b95glAv5ikscZhI4xW8gWNQMvsj1mlSzCgobzPWrknh75cnK
         Kg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKeKaxsMJxim9BgJMliTdTdETDAYX56NckZ9IfvJR64=;
        b=gjJ+eULP6P79EQ/v41BSXNlmQtM+vQV83iXJujNf2Pdwgq08VFplA0SgBH65N8MIj0
         oEOr9aqjc203LQBmIuswT8mGJqbB+P3c1uUXuFND8tp7XNZVUJg5x5sLShRIldpSvOdP
         momthF6uSUhWUmJFGTgA9Jlam4ewwkY1k4MAN2bbj4AozrZi4OG//L9Zj3puiSJeVPjo
         khoCr3//7zDPca6O52EniWhrdkiDKEVCve1YHVliSXPRRNH+MQQWl1MRqjZQXxMX5cPT
         VYopZFxcaacJ5Mt0/JTZV3ZGIBQAgiL27uGUKe5fwzsRin4SbByWDI9Ry/KYEbqCXygM
         2thA==
X-Gm-Message-State: AOAM530DBOpLp9o3iD3zFs0ok8Z0clvnAGKQH1PNjvcZ32f7MDFqz3Vl
        MRkjt36DqCJpupZnsjpbs1TfeYGNhZj2aJIVJy4=
X-Google-Smtp-Source: ABdhPJyjiGQONFgZ8ou0mg68PWXEowJTasGta2KiT8LXfY1ziFzPgwb03LrrQlpOm/veaxWoQvtNhnytcOkox+Vx7gM=
X-Received: by 2002:a17:902:f542:b0:141:fa0e:1590 with SMTP id
 h2-20020a170902f54200b00141fa0e1590mr25245804plf.20.1636075225876; Thu, 04
 Nov 2021 18:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
 <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com> <YYRtFp7GOEAi7vQH@google.com>
In-Reply-To: <YYRtFp7GOEAi7vQH@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 4 Nov 2021 18:20:14 -0700
Message-ID: <CAADnVQ+ox52jub6naAoN7dfB4UC+D01r28ubt2Qrf+Q+g26Mmg@mail.gmail.com>
Subject: Re: Verifier rejects previously accepted program
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, regressions@lists.linux.dev,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 4, 2021 at 4:30 PM <sdf@google.com> wrote:
>
> On 11/04, Alexei Starovoitov wrote:
> > On Wed, Nov 3, 2021 at 4:55 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> > > #pragma clang loop unroll(full)
> > >     for (int b = 1 << 10; b >= 4; b >>= 1) {
> > >         if (start + b > end) {
> > >             continue;
> > >         }
> > >
> > >         // If we do 8 byte reads, we have to handle overflows which is
> > > slower than 4 byte reads.
> > >         for (int i = 0; i < b; i += 4) {
> > >             csum += *(uint32_t *)(start + i);
> > >         }
> > >
> > >         start += b;
> > >     }
> > >     if (start + 2 <= end) {
> > >         csum += *(uint16_t *)(start);
> > >         start += 2;
> > >     }
> > >     if (start + 1 <= end) {
> > >         csum += *(start);
> > >     }
>
> > Thanks for flagging!
> > Could you craft a test case that we can use a repro and future
> > test case?
>
> > > fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
> > ...
> > > I've bisected the problem to commit 3e8ce29850f1 ("bpf: Prevent
> > > pointer mismatch in bpf_timer_init.") The commit seems unrelated to
> > > loop processing though (it does touch the verifier however). Either I
> > > got the bisection wrong or there is something subtle going on.
>
> > I stared at that commit and the example asm.
> > I suspect the bisect went wrong.
>
> > Could you try reverting a single
> > commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
> > ?
> > The above fp-112=inv means that the verifier is tracking scalar spill.
> > That could be the reason for bounded loop logic seeing different
> > stack state on every iteration.
> > But the asm snippet doesn't have the store to stack at [fp-112]
> > location, so it could be a red herring.
>
> > Are you using the same llvm during bisect?
> > The commit 354e8f1970f8 should be harmless
> > (when commit f30d4968e9ae ("bpf: Do not reject when the stack read
> > size is different from the tracked scalar size"))
> > is also applied. That fix is in bpf tree only, so far.
> > The tracking of 8-byte spill is the most useful with the latest llvm
> > that was taught to use 8-byte aligned stack for such spills.
>
> > Without being able to repro it's hard to investigate much further.
>
> Not to derail the conversation, but we do actually see a problem
> with commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and
> refill"). Program that passed without it now gets:
>
>   R0=inv(id=0) R1_w=invP0 R2_w=invP0 R5_w=inv0 R6=ctx(id=0,off=0,imm=0)
> R7=map_value(id=0,off=0,ks=4,vs=9616,imm=0) R8=inv(id=0)
> R9_w=map_value(id=0,off=0,ks=4,vs=9616,imm=0) R10=fp0 fp-8=mmmm????
> fp-16=mmmmmmmm fp-24=00000000 fp-32=inv fp-40=00000000 fp-48=inv
> fp-56=mmmmmmmm fp-64=mmmmmmmm
> 479: (79) r1 = *(u64 *)(r10 -32)
> corrupted spill memory
> processed 970 insns (limit 1000000) max_states_per_insn 2 total_states 73
> peak_states 73 mark_read 24

Stan,
please read the 2nd part of my sentence above and try again with that patch.
