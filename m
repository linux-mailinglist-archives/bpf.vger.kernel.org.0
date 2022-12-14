Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80E764CEA0
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 18:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiLNRKv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 12:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbiLNRKu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 12:10:50 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3C2266F
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 09:10:48 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so46123158ejc.4
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v1LOySi22SqrYU1rblrsa4vulXuuN5FvoyygFmCjW0g=;
        b=Diu5CZ4ipU/QPhFMnswqCjg8vs9smwNMVt3FX3DFsNzbmjZ2DA25Z36PLcQbEpe4hq
         ox3LQ64ZGKTJCfWKgCCKrtizNasJeWO41bMKcSd8oorc214yQidXhYRABo/9An7MGBvD
         LzYVw8jyK943oIcjV59z7g+rAoMiBr3DMKU0sj54XEJLtDQhzk49ha5P2LNw87/n+aFE
         n9DA9RS81KzZmL4Es2b/1UNHDiXim5Re6xA3yRejQFE/WTVqPusBpOi4FaNIiS49t14Q
         tY7ZmqHWwRFYjMA6n/+xCfYh/VCgs7q0C6QYW2xb8rcJC3X3QOJsRMKbh0HoiuOThrN8
         2sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1LOySi22SqrYU1rblrsa4vulXuuN5FvoyygFmCjW0g=;
        b=t/1rWn4ndVqLnSMwNXl5frmvdUFgyW84mB2kfFijl8YSDl0Xh1Q8AKs0PcWV8eNxGY
         mEt1EqB9G5tjHQtXUzzNBlZ8gXlUVOuqGx1wDsZcziWpSLj6NwNV49Vepgm+t4A2G1bT
         XnN5gH1DIMTENlWGA7HIlXYuopGVO3r95KL0MjM1M2SalnErDjabk6vb/pA6Sa6eYfXg
         T6Qugxu5wHFw5COjpisFs5PQmUTI3Bxs6AqrY24Sxj57cAqTNRXh2RDA3u37UcfOvI/3
         9Ztp4nYFs7cngV0XnOnQYR7lrL6U+hCJWkjTYD3FC/lQXrx6QGNL+k/ARuSMyRkEE9Ag
         MVyg==
X-Gm-Message-State: ANoB5pls/tyu5fpy+t7Tgg2l3esbEHL2DXWcb/qRjDd/dopD/p2r2bkC
        vyjgYPHHAVdkSjITGUJJkD0qweZ4ZZrtcpFYN8A=
X-Google-Smtp-Source: AA0mqf4l7u6L1e9uPIOAujJwGexirVvOJkUUbAyMHDTI7ErXApfleny3nGCYlfHChx2QKfYIY4M1KYGntIf4yAy1g5o=
X-Received: by 2002:a17:906:30c1:b0:7b7:eaa9:c1cb with SMTP id
 b1-20020a17090630c100b007b7eaa9c1cbmr11606351ejb.745.1671037846460; Wed, 14
 Dec 2022 09:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20221209135733.28851-1-eddyz87@gmail.com> <20221209135733.28851-5-eddyz87@gmail.com>
 <CAEf4BzZ7VEdYb+qSFLnY2jkvUHEfNHtzK7WYWMKezyRcjkV=Zg@mail.gmail.com> <943ce05e135fae9450d2b6e0c59f50f11bf022b2.camel@gmail.com>
In-Reply-To: <943ce05e135fae9450d2b6e0c59f50f11bf022b2.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Dec 2022 09:10:34 -0800
Message-ID: <CAEf4BzYPsDWdRgx+ND1wiKAB62P=WwoLhr2uWkbVpQfbHqi1oA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] selftests/bpf: verify states_equal()
 maintains idmap across all frames
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
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

On Wed, Dec 14, 2022 at 8:38 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2022-12-13 at 16:35 -0800, Andrii Nakryiko wrote:
> > On Fri, Dec 9, 2022 at 5:58 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > A test case that would erroneously pass verification if
> > > verifier.c:states_equal() maintains separate register ID mappings for
> > > call frames.
> > >
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> >
> > It's so hard to read these tests. Moving forward, let's try adding new
> > verifier tests like this using __naked functions and embedded
> > assembly. With recent test loader changes ([0]), there isn't much
> > that's needed, except for a few simple examples to get us started and
> > perhaps __flags(BPF_F_TEST_STATE_FREQ) support. The upside is that
> > using maps or global variables from assembly is now possible and easy,
> > and doesn't require any custom loader support at all.
> >
> >
> >   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=702713&state=*
> >
> >
>
> This is very nice, I'll try to use it for the next patch-set.
> How do you think it should look like for test_verifier kind of tests?
> The easiest way would be to just add new BPF sources under progs/
> and have some prog_tests/verifier.c like this:
>
> int test_verifier()
>   ...
>   RUN_TESTS(array_access),
>   RUN_TESTS(scalar_ids)
>   ...
>
> Thus reusing the build mechanics for skeletons etc.
> However, it seems to break current logical separation
> between "unit" tests in test_verifier and "functional"
> tests in test_progs. But this may be ok.

Yes, reusing skeletons and stuff, of course. But I wouldn't
necessarily make all of them as part of a single test_verifier test.
I'd probably have multiple tests with logically grouped sets of tests.

The interesting part is whether we can somehow automatically convert
macro-based test_verifier tests to this new embedded asm :) At least
most of them, but it's not clear how much work that would be, so I
just mentioned the possibility. I don't think we should manually
rewrite 1000+ tests, of course.

>
>
> > >  tools/testing/selftests/bpf/verifier/calls.c | 82 ++++++++++++++++++++
> > >  1 file changed, 82 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> > > index 3193915c5ee6..bcd15b26dcee 100644
> > > --- a/tools/testing/selftests/bpf/verifier/calls.c
> > > +++ b/tools/testing/selftests/bpf/verifier/calls.c
> > > @@ -2305,3 +2305,85 @@
> > >         .errstr = "!read_ok",
> > >         .result = REJECT,
> > >  },
> > > +/* Make sure that verifier.c:states_equal() considers IDs from all
> > > + * frames when building 'idmap' for check_ids().
> > > + */
> > > +{
> > > +       "calls: check_ids() across call boundary",
> > > +       .insns = {
> > > +       /* Function main() */
> > > +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > > +       /* fp[-24] = map_lookup_elem(...) ; get a MAP_VALUE_PTR_OR_NULL with some ID */
> > > +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> > > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> > > +       BPF_LD_MAP_FD(BPF_REG_1,
> > > +                     0),
> > > +       BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> > > +       BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_0, -24),
> > > +       /* fp[-32] = map_lookup_elem(...) ; get a MAP_VALUE_PTR_OR_NULL with some ID */
> > > +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> > > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> > > +       BPF_LD_MAP_FD(BPF_REG_1,
> > > +                     0),
> > > +       BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> > > +       BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_0, -32),
> > > +       /* call foo(&fp[-24], &fp[-32])   ; both arguments have IDs in the current
> > > +        *                                ; stack frame
> > > +        */
> > > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_FP),
> > > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -24),
> > > +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
> > > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -32),
> > > +       BPF_CALL_REL(2),
> > > +       /* exit 0 */
> > > +       BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +       BPF_EXIT_INSN(),
> > > +       /* Function foo()
> > > +        *
> > > +        * r9 = &frame[0].fp[-24]  ; save arguments in the callee saved registers,
> > > +        * r8 = &frame[0].fp[-32]  ; arguments are pointers to pointers to map value
> > > +        */
> > > +       BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
> > > +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_2),
> > > +       /* r7 = ktime_get_ns() */
> > > +       BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
> > > +       BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
> > > +       /* r6 = ktime_get_ns() */
> > > +       BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
> > > +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
> > > +       /* if r6 > r7 goto +1      ; no new information about the state is derived from
> > > +        *                         ; this check, thus produced verifier states differ
> > > +        *                         ; only in 'insn_idx'
> > > +        * r9 = r8
> > > +        */
> > > +       BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
> > > +       BPF_MOV64_REG(BPF_REG_9, BPF_REG_8),
> > > +       /* r9 = *r9                ; verifier get's to this point via two paths:
> > > +        *                         ; (I) one including r9 = r8, verified first;
> > > +        *                         ; (II) one excluding r9 = r8, verified next.
> > > +        *                         ; After load of *r9 to r9 the frame[0].fp[-24].id == r9.id.
> > > +        *                         ; Suppose that checkpoint is created here via path (I).
> > > +        *                         ; When verifying via (II) the r9.id must be compared against
> > > +        *                         ; frame[0].fp[-24].id, otherwise (I) and (II) would be
> > > +        *                         ; incorrectly deemed equivalent.
> > > +        * if r9 == 0 goto <exit>
> > > +        */
> > > +       BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_9, 0),
> > > +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_9, 0, 1),
> > > +       /* r8 = *r8                ; read map value via r8, this is not safe
> > > +        * r0 = *r8                ; because r8 might be not equal to r9.
> > > +        */
> > > +       BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_8, 0),
> > > +       BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_8, 0),
> > > +       /* exit 0 */
> > > +       BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +       BPF_EXIT_INSN(),
> > > +       },
> > > +       .flags = BPF_F_TEST_STATE_FREQ,
> > > +       .fixup_map_hash_8b = { 3, 9 },
> > > +       .result = REJECT,
> > > +       .errstr = "R8 invalid mem access 'map_value_or_null'",
> > > +       .result_unpriv = REJECT,
> > > +       .errstr_unpriv = "",
> > > +       .prog_type = BPF_PROG_TYPE_CGROUP_SKB,
> > > +},
> > > --
> > > 2.34.1
> > >
>
