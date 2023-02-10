Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A49B69297E
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 22:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjBJVsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 16:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjBJVsC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 16:48:02 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E253D09C
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 13:48:01 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qb15so17157616ejc.1
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 13:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=av83o7pv3RS57YJItphqGhOLH7WjdNDNKULFxZXfBd8=;
        b=QQEuuuoVg+UEFlm7XI1yC+dFxkmNeSKtaaKR+TsFFgmBSnLNbx42YNa8pJ410PLqIu
         4SLcCOlscDPdR+0zaW/0P4fNvejqFls6ApHLxo8Fa1cB1zN8E8uKuOI42HjsMY++D55d
         fulFlOLZKAvuY7OFtnvLCEaOvDs7RfGxwUyjc5NFfLs9LfIF8MqamG7f0IOrKPY93CkR
         KmqmpjPSIum5uVIClP/sLl7Eg4++SNQAxhzq2dVPQqhA6meJ3KNrQEyd6XSdfUl3Bg79
         CnPgI0vZcsyf+zMaioTSdE61n7tu4Y+7mlifXqiI0bIZELbu7kVw1l18Ffe6nkdURfzW
         YEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=av83o7pv3RS57YJItphqGhOLH7WjdNDNKULFxZXfBd8=;
        b=6RHAwvaDB7a9URfv+WU5HJEtZcu75SRzMw6Jy4eME2+e7gdFrg0YxPvMuv5JQDBWvT
         vLPUFJ69G2/KN3nGGnHZk3CmJeVWOrBjuzqYMRem+qAYLSqVsw8Z6Q0Xenp5zEuoYbwK
         v5zbUii/7D5NOlKNEoDTU+1zJb+jFhQLr/TpJ6MqHVfWBTZ/Uj/IdkLYrSDBix0TmM+C
         o7Efy3nK1YYcmjxIzipmjQGoQM44LEtjQiCgTdNhlCXUflsXRVG91juGjgPEGn9Bj7I0
         tR9GoHWTdqv7mJRE9Yv4QXvFY9FoZF5fvCFKx5XaeqxRP3i/v9hN872raV8mGtT78F6Q
         IDsw==
X-Gm-Message-State: AO0yUKUozb6vQya9wDlasLC3hErKty+eHNyn1a76ZBOEgyiQOS0HJsU2
        ekWUl8mb7S3cid6cHRxjtMxnYcScAA3kpWP1YiE=
X-Google-Smtp-Source: AK7set9m6HvX9U8XKvXnQ0TfejrxYSzpahf7ZS3NsTgfqldietbL+FUhhdQQ33e+vEwgAVeniO/8rYJx5H4bsBy0skI=
X-Received: by 2002:a17:906:aec1:b0:889:8f1a:a153 with SMTP id
 me1-20020a170906aec100b008898f1aa153mr1607974ejb.15.1676065679391; Fri, 10
 Feb 2023 13:47:59 -0800 (PST)
MIME-Version: 1.0
References: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com>
 <CAEf4BzZwTGWWvhMgNvNqrA0MurMeczok4Jz5dMWrvfKT2avPrw@mail.gmail.com> <84a318e7-6f61-2912-7065-1e10a9e39e72@meta.com>
In-Reply-To: <84a318e7-6f61-2912-7065-1e10a9e39e72@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Feb 2023 13:47:47 -0800
Message-ID: <CAEf4BzbzM_HDS_wE8qv8shgKK0iadWS+Yo-MgW2omA1q_tvO+g@mail.gmail.com>
Subject: Re: bpf: Propose some new instructions for -mcpu=v4
To:     Yonghong Song <yhs@meta.com>
Cc:     alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
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

On Fri, Feb 10, 2023 at 10:54 AM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 2/9/23 3:39 PM, Andrii Nakryiko wrote:
> > On Thu, Feb 9, 2023 at 2:55 PM Yonghong Song <yhs@meta.com> wrote:
> >>
> >> Over the past, there are some discussions to extend bpf
> >> instruction ISA to accommodate some new use cases or
> >> fix some potential issues. These new instructions will
> >> be included in new cpu flavor -mcpu=v4.
> >>
> >> The following are the proposal
> >> to add new instructions in 6 different categories.
> >> The proposal is a little bit rough. You can find bpf insn
> >> background information in Documentation/bpf/instruction-set.rst.
> >> You comments or suggestions are welcome!
> >>
> >
> > Great that we are trying to fix and complete the instruction set! Just
> > one comment/question below for condition jumps.
> >
> > [...]
> >
> >>
> >> 32-bit JA
> >> =========
> >>
> >> Currently, the whole range of operations with BPF_JMP32/BPF_JMP insn are
> >> implemented like below
> >>
> >>     ========  =====  =========================  ============
> >>     code      value  description                notes
> >>     ========  =====  =========================  ============
> >>     BPF_JA    0x00   PC += off                  BPF_JMP only
> >>     BPF_JEQ   0x10   PC += off if dst == src
> >>     BPF_JGT   0x20   PC += off if dst > src     unsigned
> >>     BPF_JGE   0x30   PC += off if dst >= src    unsigned
> >>     BPF_JSET  0x40   PC += off if dst & src
> >>     BPF_JNE   0x50   PC += off if dst != src
> >>     BPF_JSGT  0x60   PC += off if dst > src     signed
> >>     BPF_JSGE  0x70   PC += off if dst >= src    signed
> >>     BPF_CALL  0x80   function call
> >>     BPF_EXIT  0x90   function / program return  BPF_JMP only
> >>     BPF_JLT   0xa0   PC += off if dst < src     unsigned
> >>     BPF_JLE   0xb0   PC += off if dst <= src    unsigned
> >>     BPF_JSLT  0xc0   PC += off if dst < src     signed
> >>     BPF_JSLE  0xd0   PC += off if dst <= src    signed
> >>     ========  =====  =========================  ============
> >>
> >> Here the 'off' is 16 bit so the range of jump is [-32768, 32767].
> >> In rare cases, people may have large programs or have loops fully unrolled.
> >> This may cause some jump offset beyond the above range. In current
> >> llvm implementation, wrong code (after truncation) will be generated.
> >>
> >> To fix this issue, the following new insn is proposed
> >>
> >>     ========  =====  =========================  ============
> >>     code      value  description                notes
> >>     ========  =====  =========================  ============
> >>     BPF_JA    0x00   PC += imm                  BPF_JMP32 only, src = 1
> >>
> >> The way, the jump offset range become [-2^31, 2^31 - 1].
> >>
> >> For other jump instructions, e.g., BPF_JEQ, with a jmp offset
> >> beyond [-32768, 32767]. It can be simulated with a
> >> 'BPF_JA (PC += imm)' followed by the original
> >> BPF_JEQ with the range 'off', or BPF_JEQ with a short range followed
> >> by a BPF_JA.
> >
> > Why not implement the same approach (using imm if src = 1) for all the
> > conditional jumps? Just too much JIT work or some other reasons?
>
> We cannot use 'src' since 'src' is used in conditional jump, e.g.,

Right, I missed this part, thanks.

>
>    ========  =====  =========================  ============
>    code      value  description                notes
>    ========  =====  =========================  ============
>    BPF_JEQ   0x10   PC += off if dst == src
>
> In this particular case, there is no good way to extend
> the insn with range [-2^31, 2^31 - 1] as 'off/dst/src' all
> used by the above insn. The sample extension to original
> BPF_JEQ seems not working so I came up with the above
> BPF_JA (32bit range) + BPF_JEQ(16 bit range) approach.
> It is ugly and increase implementation complexity, but
> considering this is a corner case. It may not be
> worthwhile to design a whole range of 32bit range of
> BPF_JEQ/JGT/... instructions.
>
> >
> > [...]
