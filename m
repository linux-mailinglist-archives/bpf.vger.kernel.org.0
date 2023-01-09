Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8E066247F
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 12:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjAILod (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 06:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjAILoN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 06:44:13 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F3DA467
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 03:44:12 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so12509369pjq.1
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 03:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9OsjWyUaS6cL5hdrYlo2jHK+VRtUoAkqdJJbPFhZiE=;
        b=DLkJ4WSUbjJ6/wNnVau0e+WtOLu/pD9xS2sdi8b5iKLi4eKQLhbYk9bFqybbzOC2Bg
         FyrvG5n+jkQKCJ2KcNvN6w1pxXMhS3hZH2OxutDk2r27tLtFvB+zPHDJKVKwBNgjlys/
         gPadrfKJe7YmJ5BFlcWeBQ0hkoXqtxJGJstFioYBkZoc/MRPtDIfr8xA77tAeMUKWQES
         oSS8gOdWBpcTpWZjYVs3zEIVefTrJQXhZtnN46DrbfghfSIt8L3VBfMN8qB11Zzbji8W
         TKvKF/A9huTS8/5Fpor1Kz0v2WOxh/tA8nYsIiZdjaMAnjbzMfETIxYaajKFFehz2RJJ
         xmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9OsjWyUaS6cL5hdrYlo2jHK+VRtUoAkqdJJbPFhZiE=;
        b=yuVQeA9UUrrPece6BFLXDrCy0d8P+r9gdWtJl9iNzMjICqi3CE84Ny/Xzm/1uUoT/M
         mXySU0PKYJvk5XyFpPBQsF9nV/gKEFEKX//30PYOghxhjQ9VnsseDW2XeXbJARt97+dA
         fwdCw8L4V+pT9cs3Bb5erptIszMxWUGfErZ0QQ6I3T2GjEE9z9dIBqaAMtevezewNEJ6
         SfFG6sbjHxo8dP29Iq8DuSUNItoY9z0+RKleHJJXXA3j/e6zlgzEyFYQZ3w1RyFSprJK
         qSwRI8atmuW1Vf+K0qXR5yQlgtMQdOb8339cRgi+HvW2xBmBsiBgZcgPHwW4pmI+/qXR
         jBkA==
X-Gm-Message-State: AFqh2kragaf7P7yTZeE07uOKvdq1yi1VH3J7ab42OQb7zrgvXYzy+b2P
        cM1DXvp+QGVWWmTQWtRsr2Q=
X-Google-Smtp-Source: AMrXdXueDHUaaUTO5vUiFW4+Hl3xzE76F+ZOD8QQIZHOtZxFWPg50igkBy/dOW2NETD+M3HmO/Mmrw==
X-Received: by 2002:a17:902:d491:b0:192:b40b:e41 with SMTP id c17-20020a170902d49100b00192b40b0e41mr51960578plg.61.1673264651825;
        Mon, 09 Jan 2023 03:44:11 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id d12-20020a634f0c000000b0047829d1b8eesm2815598pgb.31.2023.01.09.03.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:44:11 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:14:08 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] selftests/bpf: Add dynptr pruning tests
Message-ID: <20230109114408.ycucovshdvtnpcp6@apollo>
References: <20230101083403.332783-1-memxor@gmail.com>
 <20230101083403.332783-6-memxor@gmail.com>
 <CAEf4Bzac9u4VDMVkuWutY5cGUMpRoxvpszy_gi6OZyXXP=Sp7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzac9u4VDMVkuWutY5cGUMpRoxvpszy_gi6OZyXXP=Sp7Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 05, 2023 at 04:19:30AM IST, Andrii Nakryiko wrote:
> On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Add verifier tests that verify the new pruning behavior for STACK_DYNPTR
> > slots, and ensure that state equivalence takes into account changes to
> > the old and current verifier state correctly.
> >
> > Without the prior fixes, both of these bugs trigger with unprivileged
> > BPF mode.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/verifier/dynptr.c | 90 +++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/verifier/dynptr.c
> >
> > diff --git a/tools/testing/selftests/bpf/verifier/dynptr.c b/tools/testing/selftests/bpf/verifier/dynptr.c
> > new file mode 100644
> > index 000000000000..798f4f7e0c57
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/verifier/dynptr.c
> > @@ -0,0 +1,90 @@
> > +{
> > +       "dynptr: rewrite dynptr slot",
> > +        .insns = {
> > +        BPF_MOV64_IMM(BPF_REG_0, 0),
> > +        BPF_LD_MAP_FD(BPF_REG_6, 0),
> > +        BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> > +        BPF_MOV64_IMM(BPF_REG_2, 8),
> > +        BPF_MOV64_IMM(BPF_REG_3, 0),
> > +        BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
> > +        BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
> > +        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
> > +        BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
> > +        BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> > +        BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0xeB9F),
> > +        BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
> > +        BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -16),
> > +        BPF_MOV64_IMM(BPF_REG_2, 0),
> > +        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
> > +        BPF_MOV64_IMM(BPF_REG_0, 0),
> > +        BPF_EXIT_INSN(),
> > +        },
> > +       .fixup_map_ringbuf = { 1 },
> > +       .result_unpriv = REJECT,
> > +       .errstr_unpriv = "unknown func bpf_ringbuf_reserve_dynptr#198",
> > +       .result = REJECT,
> > +       .errstr = "arg 1 is an unacquired reference",
> > +},
> > +{
> > +       "dynptr: type confusion",
> > +       .insns = {
> > +       BPF_MOV64_IMM(BPF_REG_0, 0),
> > +       BPF_LD_MAP_FD(BPF_REG_6, 0),
> > +       BPF_LD_MAP_FD(BPF_REG_7, 0),
> > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> > +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> > +       BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
> > +       BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -24),
> > +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0xeB9FeB9F),
> > +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -24, 0xeB9FeB9F),
> > +       BPF_MOV64_IMM(BPF_REG_4, 0),
> > +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_2),
> > +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
> > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> > +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
> > +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> > +       BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> > +       BPF_EXIT_INSN(),
> > +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
> > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
> > +       BPF_MOV64_IMM(BPF_REG_2, 8),
> > +       BPF_MOV64_IMM(BPF_REG_3, 0),
> > +       BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
> > +       BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
> > +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
> > +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
> > +       /* pad with insns to trigger add_new_state heuristic for straight line path */
> > +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> > +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> > +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> > +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> > +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> > +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> > +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> > +       BPF_JMP_IMM(BPF_JA, 0, 0, 9),
> > +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
> > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
> > +       BPF_MOV64_IMM(BPF_REG_2, 0),
> > +       BPF_MOV64_IMM(BPF_REG_3, 0),
> > +       BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
> > +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_dynptr_from_mem),
> > +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
> > +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -16),
> > +       BPF_MOV64_IMM(BPF_REG_2, 0),
> > +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
> > +       BPF_MOV64_IMM(BPF_REG_0, 0),
> > +       BPF_EXIT_INSN(),
> > +       },
> > +       .fixup_map_hash_16b = { 1 },
> > +       .fixup_map_ringbuf = { 3 },
> > +       .result_unpriv = REJECT,
> > +       .errstr_unpriv = "unknown func bpf_ringbuf_reserve_dynptr#198",
> > +       .result = REJECT,
> > +       .errstr = "arg 1 is an unacquired reference",
> > +},
>
> have you tried to write these tests as embedded assembly in .bpf.c,
> using __attribute__((naked)) and __failure and __msg("")
> infrastructure? Eduard is working towards converting test_verifier's
> test to this __naked + embed asm approach, so we might want to start
> adding new tests in such form anyways? And they will be way more
> readable. Defining and passing ringbuf map in C is also much more
> obvious and easy.
>

I have been away for a while and missed that discussion, I just saw it. I'll try
writing the tests like that. It does look much better. Thanks for the suggestion!

> > --
> > 2.39.0
> >
