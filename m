Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9382A32C169
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447022AbhCCWli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442919AbhCCKvS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 05:51:18 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD3CC061794
        for <bpf@vger.kernel.org>; Wed,  3 Mar 2021 02:41:40 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id u20so25141285iot.9
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 02:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTFbqq7wf2oiwXghMNZFKdevlJLnKuAoGi+RpBPGCa4=;
        b=UJHsBYlGb8wnqy1QwPn7c1u8wADAC505uOTdONnRAvEBcyVm6BKaUY+E+ULppdviN1
         A/Z6jXuB7eQGcQ9AjFxxVr0+pVEAljvLmu+fOttaHoQED6vFuwibNqP9MWZD/VbJydZU
         9/8tY44E3IV12W6RMtMpHIdX5Z/CsrmKY2bWcfdWQZo1Sx12VtDSkE4I70nWjydiwCCX
         2CcapQ8umNsweYlqCFJtKckNK/e1pQqh/6vyy3QOfLai6d46+l4nH2KJe+m0Aul6bymU
         mfthXUfeT1jDHSY/D4MYMT8yoD7xD2nm5tYUPGyibgNCYiUfto2Lb+enPEgTw2DfQGI6
         dSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTFbqq7wf2oiwXghMNZFKdevlJLnKuAoGi+RpBPGCa4=;
        b=SBpZNe9zfYYFTg9ZLkN10IZvzf0Pzm56hQ3ESzsQas/conJOUf6zC/uqmHEs1Uj7oh
         Qqu1rMkHVO2QNfPQ50XcRD0CPZpzBQsAFYmyscPPQK+veCHoZC21KUiMHYJRRP+6WQEm
         I+LILbn4107SIiPVTxP8UysXzKCF+Fs6BA/98SC/xM3NZ9ZDQU/I0SiaF5orlBtguPxN
         F+pC+GODE1yZetyNANQ/j28d0bFmixi1cV6tqCCD3th5xWc9TiXy73i10/Z+BGz28i3O
         kOHjHqwv/j5dcs0ogSiR/N/10ScIdvqA0cbWlm70nK0Ff3vvVY0iWFjoqmrT0bTECjE4
         R5OA==
X-Gm-Message-State: AOAM531ffhb14L2tqrw7tKTQ6ImzTx35n6uvYv+z3OckpHk9k8bzvE2t
        Eoeivx/xvYe/IUjTpJriy1Co/sO8RLELGCvCVB5/hg==
X-Google-Smtp-Source: ABdhPJwWVBIn0C+8uwgH3aQgheY35dvbEVzbLOMwZUegOTMh5jP7Wae4n3VbJx/MC5WwcepLkbHH/Wef82GbQdLT574=
X-Received: by 2002:a6b:7302:: with SMTP id e2mr13719609ioh.106.1614768099735;
 Wed, 03 Mar 2021 02:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20210302105400.3112940-1-jackmanb@google.com> <20210302184306.ishsga6xkg2glnzj@kafai-mbp.dhcp.thefacebook.com>
 <3b994f4c-2847-60be-834e-22c58c2b7470@fb.com>
In-Reply-To: <3b994f4c-2847-60be-834e-22c58c2b7470@fb.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 3 Mar 2021 11:41:28 +0100
Message-ID: <CA+i-1C1qFapuADxzT4BUXzS6X5JBc9ZpuYfiYu-tUQrUwRsuiA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
To:     Yonghong Song <yhs@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks once again for the reviews.

On Wed, 3 Mar 2021 at 08:29, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/2/21 10:43 AM, Martin KaFai Lau wrote:
> > On Tue, Mar 02, 2021 at 10:54:00AM +0000, Brendan Jackman wrote:
> >> As pointed out by Ilya and explained in the new comment, there's a
> >> discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> >> the value from memory into r0, while x86 only does so when r0 and the
> >> value in memory are different. The same issue affects s390.
> >>
> >> At first this might sound like pure semantics, but it makes a real
> >> difference when the comparison is 32-bit, since the load will
> >> zero-extend r0/rax.
> >>
> >> The fix is to explicitly zero-extend rax after doing such a
> >> CMPXCHG. Since this problem affects multiple archs, this is done in
> >> the verifier by patching in a BPF_ZEXT_REG instruction after every
> >> 32-bit cmpxchg. Any archs that don't need such manual zero-extension
> >> can do a look-ahead with insn_is_zext to skip the unnecessary mov.
> >>
> >> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> >> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> >> ---
> >>
> >>
> >> Differences v4->v5[1]:
> >>   - Moved the logic entirely into opt_subreg_zext_lo32_rnd_hi32, thanks to Martin
> >>     for suggesting this.
> >>
> >> Differences v3->v4[1]:
> >>   - Moved the optimization against pointless zext into the correct place:
> >>     opt_subreg_zext_lo32_rnd_hi32 is called _after_ fixup_bpf_calls.
> >>
> >> Differences v2->v3[1]:
> >>   - Moved patching into fixup_bpf_calls (patch incoming to rename this function)
> >>   - Added extra commentary on bpf_jit_needs_zext
> >>   - Added check to avoid adding a pointless zext(r0) if there's already one there.
> >>
> >> Difference v1->v2[1]: Now solved centrally in the verifier instead of
> >>    specifically for the x86 JIT. Thanks to Ilya and Daniel for the suggestions!
> >>
> >> [1] v4: https://lore.kernel.org/bpf/CA+i-1C3ytZz6FjcPmUg5s4L51pMQDxWcZNvM86w4RHZ_o2khwg@mail.gmail.com/T/#t
> >>      v3: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
> >>      v2: https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
> >>      v1: https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
> >>
> >>
> >>   kernel/bpf/core.c                             |  4 +++
> >>   kernel/bpf/verifier.c                         | 17 +++++++++++-
> >>   .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 ++++++++++++++++++
> >>   .../selftests/bpf/verifier/atomic_or.c        | 26 +++++++++++++++++++
> >>   4 files changed, 71 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> >> index 0ae015ad1e05..dcf18612841b 100644
> >> --- a/kernel/bpf/core.c
> >> +++ b/kernel/bpf/core.c
> >> @@ -2342,6 +2342,10 @@ bool __weak bpf_helper_changes_pkt_data(void *func)
> >>   /* Return TRUE if the JIT backend wants verifier to enable sub-register usage
> >>    * analysis code and wants explicit zero extension inserted by verifier.
> >>    * Otherwise, return FALSE.
> >> + *
> >> + * The verifier inserts an explicit zero extension after BPF_CMPXCHGs even if
> >> + * you don't override this. JITs that don't want these extra insns can detect
> >> + * them using insn_is_zext.
> >>    */
> >>   bool __weak bpf_jit_needs_zext(void)
> >>   {
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 4c373589273b..37076e4c6175 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -11237,6 +11237,11 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
> >>      return 0;
> >>   }
> >>
> >> +static inline bool is_cmpxchg(struct bpf_insn *insn)
> > nit. "const" struct bpf_insn *insn.
> >
> >> +{
> >> +    return (BPF_MODE(insn->code) == BPF_ATOMIC && insn->imm == BPF_CMPXCHG);
> > I think it is better to check BPF_CLASS(insn->code) == BPF_STX also
> > in case in the future this helper will be reused before do_check()
> > has a chance to verify the instructions.
>
> If this is the case, I would suggest to move is_cmpxchg() earlier
> in verifier.c so later on for reuse we do not need to move this
> function. Also, in the return statement, there is no need
> for outmost ().

Yep, all good points, thanks. Spinning v6 now.

> >
> >> +}
> >> +
> >>   static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
> >>                                       const union bpf_attr *attr)
> >>   {
> >> @@ -11296,7 +11301,17 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
> >>                      goto apply_patch_buffer;
> >>              }
> >>
> >> -            if (!bpf_jit_needs_zext())
> >> +            /* Add in an zero-extend instruction if a) the JIT has requested
> >> +             * it or b) it's a CMPXCHG.
> >> +             *
> >> +             * The latter is because: BPF_CMPXCHG always loads a value into
> >> +             * R0, therefore always zero-extends. However some archs'
> >> +             * equivalent instruction only does this load when the
> >> +             * comparison is successful. This detail of CMPXCHG is
> >> +             * orthogonal to the general zero-extension behaviour of the
> >> +             * CPU, so it's treated independently of bpf_jit_needs_zext.
> >> +             */
> >> +            if (!bpf_jit_needs_zext() && !is_cmpxchg(&insn))
> >>                      continue;
> >>
> >>              if (WARN_ON_ONCE(load_reg == -1)) {
> >> diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> >> index 2efd8bcf57a1..6e52dfc64415 100644
> >> --- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> >> +++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> >> @@ -94,3 +94,28 @@
> >>      .result = REJECT,
> >>      .errstr = "invalid read from stack",
> >>   },
> >> +{
> >> +    "BPF_W cmpxchg should zero top 32 bits",
> >> +    .insns = {
> >> +            /* r0 = U64_MAX; */
> >> +            BPF_MOV64_IMM(BPF_REG_0, 0),
> >> +            BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
> >> +            /* u64 val = r0; */
> >> +            BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
> >> +            /* r0 = (u32)atomic_cmpxchg((u32 *)&val, r0, 1); */
> >> +            BPF_MOV32_IMM(BPF_REG_1, 1),
> >> +            BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8),
> >> +            /* r1 = 0x00000000FFFFFFFFull; */
> >> +            BPF_MOV64_IMM(BPF_REG_1, 1),
> >> +            BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
> >> +            BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
> >> +            /* if (r0 != r1) exit(1); */
> >> +            BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_1, 2),
> >> +            BPF_MOV32_IMM(BPF_REG_0, 1),
> >> +            BPF_EXIT_INSN(),
> >> +            /* exit(0); */
> >> +            BPF_MOV32_IMM(BPF_REG_0, 0),
> >> +            BPF_EXIT_INSN(),
> >> +    },
> >> +    .result = ACCEPT,
> >> +},
> >> diff --git a/tools/testing/selftests/bpf/verifier/atomic_or.c b/tools/testing/selftests/bpf/verifier/atomic_or.c
> >> index 70f982e1f9f0..0a08b99e6ddd 100644
> >> --- a/tools/testing/selftests/bpf/verifier/atomic_or.c
> >> +++ b/tools/testing/selftests/bpf/verifier/atomic_or.c
> >> @@ -75,3 +75,29 @@
> >>      },
> >>      .result = ACCEPT,
> >>   },
> >> +{
> >> +    "BPF_W atomic_fetch_or should zero top 32 bits",
> >> +    .insns = {
> >> +            /* r1 = U64_MAX; */
> >> +            BPF_MOV64_IMM(BPF_REG_1, 0),
> >> +            BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
> >> +            /* u64 val = r0; */
> > s/r0/r1/
> >
> >> +            BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
> >> +            /* r1 = (u32)atomic_sub((u32 *)&val, 1); */
> >                  r1 = (u32)atomic_fetch_or((u32 *)&val, 2)
> >
> >> +            BPF_MOV32_IMM(BPF_REG_1, 2),
> >> +            BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
> >> +            /* r2 = 0x00000000FFFFFFFF; */
> >> +            BPF_MOV64_IMM(BPF_REG_2, 1),
> >> +            BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 32),
> >> +            BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 1),
> >> +            /* if (r2 != r1) exit(1); */
> >> +            BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 2),
> >> +            /* BPF_MOV32_IMM(BPF_REG_0, 1), */
> >> +            BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
> >> +            BPF_EXIT_INSN(),
> >> +            /* exit(0); */
> >> +            BPF_MOV32_IMM(BPF_REG_0, 0),
> >> +            BPF_EXIT_INSN(),
> >> +    },
> >> +    .result = ACCEPT,
> >> +},
> >>
> >> base-commit: f2cfe32e8a965a86e512dcb2e6251371d4a60c63
> >> --
> >> 2.30.1.766.gb4fecdf3b7-goog
> >>
