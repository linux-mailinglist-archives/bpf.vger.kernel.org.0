Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4DA446251
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 11:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhKEKod (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhKEKod (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 06:44:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC91C061714
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 03:41:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so17822971lfu.5
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xmnVTe46GHU0w7SZuBsP49gfSkv1JiBHvxo+85QBejA=;
        b=D1oFNgNWtAXahC9Ropy9GnV4qyoD19V0ZnFqtIhLWMErMeCbf9glfvlTdLap/jwYPK
         FiWGEeGAj4McGXuTdr8eX2qajJIomom1nltbBlDvI1C9reytaxZO2aZVasEUxai5U3/U
         9yfIOR141Y5HPPX0SqZgNuNclfsdYDQ0KQyH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmnVTe46GHU0w7SZuBsP49gfSkv1JiBHvxo+85QBejA=;
        b=IIzM26NXAbqXdkrQ9w0Ps/vOYZjcRVnojx2s4M4mx3aSnVAcp0OBddHkZtL5ljCg3R
         +BOg8fOPT0c0+jqBGMHNwppyqAluSUBy2QZvpvpUHA4ZZ4xXrBm2Hddc/fM32vVgN+gl
         eDZN2InVYLuVv5GtmDzpdl8iZ8SaOMTBIdIIB4q15rsByVtZjYs60PgW+ONFN7JSW9Y/
         Qt78WJ85ghFgw8OWoxCAfP8hcOULDQD/6RHDAV0FXbHO+pzftnuKuUIHsbpVE+sIYCce
         EK5kTidTAPI3xuXFJ7T1Mwy5XuJQSEYOom5zVcEFn5q1BB36g8Nhjl/xmGj2rWdoqHx7
         oe5A==
X-Gm-Message-State: AOAM530Jk8YhFKX/dRjD4g5HAmnXoLD3wWQ/jTVz6DoEyaJ/cfubu878
        OIrEzKlx7L6ojlZKlstVTMYpov3Vru2len5VD4s/+g==
X-Google-Smtp-Source: ABdhPJzCY/2nbNfnPQC6rAx7r/EojV40PjJF5NGf5GyKBDjLa2EMLPX0wO1XYpHpHfWsvaDkMAGcu88uRyBP7zrgFQ4=
X-Received: by 2002:a05:6512:39d6:: with SMTP id k22mr22986038lfu.39.1636108911882;
 Fri, 05 Nov 2021 03:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
 <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
In-Reply-To: <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 5 Nov 2021 10:41:40 +0000
Message-ID: <CACAyw9_GmNotSyG0g1OOt648y9kx5Bd72f58TtS-QQD9FaV06w@mail.gmail.com>
Subject: Re: Verifier rejects previously accepted program
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, regressions@lists.linux.dev,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 4 Nov 2021 at 16:51, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Thanks for flagging!
> Could you craft a test case that we can use a repro and future
> test case?

Yes, I'll give it a shot.

> > fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
> ...
> > I've bisected the problem to commit 3e8ce29850f1 ("bpf: Prevent
> > pointer mismatch in bpf_timer_init.") The commit seems unrelated to
> > loop processing though (it does touch the verifier however). Either I
> > got the bisection wrong or there is something subtle going on.
>
> I stared at that commit and the example asm.
> I suspect the bisect went wrong.

I tried the parent of the offending commit, and it worked fine. Weird.
Could the problem be that there are multiple regressions? See below,
we also get hit with the corrupted stack spill.

> Could you try reverting a single
> commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
> ?
> The above fp-112=inv means that the verifier is tracking scalar spill.
> That could be the reason for bounded loop logic seeing different
> stack state on every iteration.
> But the asm snippet doesn't have the store to stack at [fp-112]
> location, so it could be a red herring.
>
> Are you using the same llvm during bisect?

I'm compiling the test case once and then invoke it via git bisect
run, so the BPF should be identical. clang-11.

> The commit 354e8f1970f8 should be harmless
> (when commit f30d4968e9ae ("bpf: Do not reject when the stack read
> size is different from the tracked scalar size"))
> is also applied. That fix is in bpf tree only, so far.

I did some more tests. TL;DR: commit 3e8ce29850f1 ("bpf: Prevent
pointer mismatch in bpf_timer_init.") is the first one that fails with
"BPF program too large", it's ancestor loads OK. commit 354e8f1970f8
("bpf: Support <8-byte scalar spill and refill") makes verification
fail earlier with "corrupted spill memory". The following solves both
issues:

    git checkout 354e8f1970f8 # "bpf: Support <8-byte scalar spill and refill"
    git cherry-pick f30d4968e9ae # "bpf: Do not reject when the stack
read size is different from the tracked scalar size"

I think you're on the money wrt scalar spill tracking. Maybe I
misattributed the problem to the wrong bit of code, instead of having
found the wrong commit?

Details:

bpf-next: commit be2f2d1680df ("libbpf: Deprecate bpf_program__load() API"):

    ; v = *pos++;
    1099: (79) r1 = *(u64 *)(r10 -72)
    corrupted spill memory
    processed 48649 insns (limit 1000000) max_states_per_insn 4
total_states 1305 peak_states 290 mark_read 53

bpf-next with f30d4968e9ae on top:

    works!

bpf-next with commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill
and refill") reverted:

    2225: (05) goto pc+13
    BPF program is too large. Processed 1000001 insn
    processed 1000001 insns (limit 1000000) max_states_per_insn 28
total_states 40641 peak_states 1104 mark_read 53

commit 3e8ce29850f1 ("bpf: Prevent pointer mismatch in
bpf_timer_init.") (found via bisection):

    BPF program is too large. Processed 1000001 insn

commit 3e8ce29850f1^ ("bpf: Add map side support for bpf timers."):

   works!

commit 3e8ce29850f1 with commit 354e8f1970f8 ("bpf: Support <8-byte
scalar spill and refill") reverted:

   doesn't revert cleanly

commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill"):

    corrupted spill memory

commit 354e8f1970f8^ ("bpf: Check the other end of slot_type for STACK_SPILL"):

    2225: (05) goto pc+13
    BPF program is too large. Processed 1000001 insn
    processed 1000001 insns (limit 1000000) max_states_per_insn 28
total_states 40641 peak_states 1104 mark_read 53

commit 354e8f1970f8~2 ("selftests/bpf: Fix btf_dump __int128 test
failure with clang build kernel"):

    same as above

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
