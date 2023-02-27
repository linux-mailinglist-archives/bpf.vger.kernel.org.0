Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C4A6A4FA6
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 00:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjB0X3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 18:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjB0X3Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 18:29:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1C1ABE8
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 15:29:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h16so32624905edz.10
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 15:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsjTzldCV7M/h1Qa1eoLkZdYsxldZWaq8edKwKs7NlM=;
        b=nHDcilMuWbebLl33BzVLpkG5fXddA/KrnNo6pApWyJn4raBE+gTzAwTi0k0FQ9rb8Y
         rVRc9wujyOqXDH4ITYAtAv0DubTWws1wuydPGkHxYUQFwn/Z2UnQR8pC/fm98dN+mza5
         Qcpx0EwqjdJjBg0S6zR8suYrUow6U16RmzSvpXhwVrQ9g/K0HwC7IBXmOFxJysQg4Sjb
         yWI2s75kN7EK9DkNb6F2LRinlO20s8vBqpu8VCLGTF1aG4mx3Io/xZnSm+Bj0iNwR4p6
         0hzRy2G21YG+MDpHlBI+VBF2CElh0FS2nqQ7lL3drzDLXUL15QPzFgr2XO2NvFCVy26T
         2SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsjTzldCV7M/h1Qa1eoLkZdYsxldZWaq8edKwKs7NlM=;
        b=1citjAehFs9zoa8mdwZcHYnEMAb3Q1i6i/b6EHbdQAXojupCBKDJP2MOzMorRzM69U
         yLD5nB0OTPpppbu7YXhzSvWaLP7PgaHDUbEdKUGSpLsvjmQvJZZARQxfBFkCDcq+sBxU
         Dp+/Itpuu6fQO8NdnMn4VbH86KCt4u5Kf9uulI896yLg8P5Xw9DUVxZL3SLgh5kA5JhE
         yOMltmKD+ZzLawrdfqrEUmaph14KWf0FiANshkL1Zd1vCT4I0WkYYHcN4ZrBSOIvFYCw
         xe+ETHQLK3s5ot8VMtQcDA3PthkK4Lpy3kegwgPeJr1NwsOQHEjc5DIISdYviTVYH8SE
         5hSQ==
X-Gm-Message-State: AO0yUKUYlnye1MuACMcCZeLgWcfZpOED3KQ1m6khGZx96tj6N8KnSAC4
        QFsN+/ETsA0rNqlzQb9Vm891oV3IfBiH7ZNbig2QNr5P
X-Google-Smtp-Source: AK7set+l2mOxZj60+Ll5Se1V0JS4fEAyLHRaR2rWx3NnVahh1+E2sP+VMq/i91MLmDfU+eLpg5zBlosAl3h3DdsVArE=
X-Received: by 2002:a50:a6da:0:b0:4ae:e5d8:f9ab with SMTP id
 f26-20020a50a6da000000b004aee5d8f9abmr657746edc.6.1677540553105; Mon, 27 Feb
 2023 15:29:13 -0800 (PST)
MIME-Version: 1.0
References: <4bfe98be-5333-1c7e-2f6d-42486c8ec039@meta.com>
 <CAEf4BzZ+pA4QQGbiS=_-gzGwCOpvGdzkQr1c17j8uGVREykzNQ@mail.gmail.com> <9627c69b-c174-e228-c38f-39598dfbd4cd@meta.com>
In-Reply-To: <9627c69b-c174-e228-c38f-39598dfbd4cd@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 27 Feb 2023 15:29:01 -0800
Message-ID: <CAADnVQ+bm_szOMhhvzrd9ZVrD0u+C3r=GMXDw+WPRVQ9DPv9jQ@mail.gmail.com>
Subject: Re: [v2] bpf: Propose some new instructions for -mcpu=v4
To:     Yonghong Song <yhs@meta.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 3:25=E2=80=AFPM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 2/27/23 2:24 PM, Andrii Nakryiko wrote:
> > On Sun, Feb 26, 2023 at 10:31=E2=80=AFAM Yonghong Song <yhs@meta.com> w=
rote:
> >>
> >> Over the past, there are some discussions to extend bpf
> >> instruction ISA to accommodate some new use cases or
> >> fix some potential issues. These new instructions will
> >> be included in new cpu flavor -mcpu=3Dv4.
> >>
> >> The following are the proposal to add new instructions in 6
> >> different categories. The proposal is a little bit rough.
> >> You can find bpf insn background information in
> >> Documentation/bpf/instruction-set.rst. Compared to previous
> >> proposal (v1) in
> >>
> >> https://lore.kernel.org/bpf/01515302-c37d-2ee5-c950-2f556a4caad0@meta.=
com/
> >> there are two changes:
> >>     . for sign extend load, removing alu32_mode differentiator
> >>       since alu32_mode is only a compiler asm syntax mechanism in
> >>       this case, and not involved in insn encoding.
> >>     . for sign extend mov, there is no support for sign extend
> >>       moving an imm to a register.
> >>
> >> The corresponding llvm implementation is at
> >>       https://reviews.llvm.org/D144829
> >>
> >> The following is the proposal details.
> >>
> >> SDIV/SMOD (signed div and mod)
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>
> >> bpf already has unsigned DIV and MOD. They are encoded as
> >>
> >>      insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 b=
its)
> >>      DIV  0x3          0/1           BPF_ALU/BPF_ALU64        0
> >>      MOD  0x9          0/1           BPF_ALU/BPF_ALU64        0
> >>
> >> The current 'code' field only has two value left, 0xe and 0xf.
> >> gcc used these two values (0xe and 0xf) for SDIV and SMOD.
> >> But using these two values takes up all 'code' space and makes
> >> future extension hard.
> >>
> >> Here, I propose to encode SDIV/SMOD like below:
> >>
> >>      insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 b=
its)
> >>      DIV  0x3          0/1           BPF_ALU/BPF_ALU64        1
> >>      MOD  0x9          0/1           BPF_ALU/BPF_ALU64        1
> >>
> >> Basically, we reuse the same 'code' value but changing 'off' from 0 to=
 1
> >> to indicate signed div/mod.
> >>
> >> Sign extend load
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Currently llvm generated normal load instructions are encoded like bel=
ow.
> >>
> >>      mode(3 bits)      size(2 bits)    instruction class(3 bits)
> >>      BPF_MEM (0x3)     8/16/32/64      BPF_LDX
> >>
> >> For mode, existing used values are 0x0, 0x1, 0x2, 0x3, 0x6.
> >> The proposal is to use mod value 0x4 to encode sign extend loads.
> >>
> >>      mode(3 bits)      size(2 bits)    instruction class(3 bits)
> >>      BPF_SMEM (0x4)    8/16/32         BPF_LDX
> >
> > can we define BPF_SMEM for 64-bit for completeness here? I can see
> > some situations where, for example, libbpf needs to switch between
> > BPF_MEM/BPF_SMEM based on CO-RE relocation and target type, and not
> > having to special-case 64-bit case would be nice.
> >
> > It's minor, but so seems to be to support sign-extended 64-bit load
> > (which would be equivalent to non-sign-extended, of course).
>
> We can support sign-extended 64-bit load. But compiler won't be
> able to generate this insn since 64-bit load will be generated
> with existing non-sign-extended load.
>
> If this can make libbpf life easier, yes, we can do it.
>
> >
> >>
> >> Sign extend register mov
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>
> >> Current BPF_MOV insn is encoded as
> >>      insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 b=
its)
> >>      MOV  0xb          0/1           BPF_ALU/BPF_ALU64        0
> >>
> >> Let us support sign extended move insn as defined below:
> >>
> >>      insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 b=
its)
> >>      MOVS 0xb          1             BPF_ALU                  8/16
> >>      MOVS 0xb          1             BPF_ALU64                8/16/32
> >
> > will this be literal 8, 16, 32 decimal values or similarly to
> > BPF_{B,H,W,DW} we'll just have values 0, 1, 2, 3 to represent 8, 16,
> > 32, 64?
>
> Yes, 8/16/32 are decimal values similar to existing encoding of
> be/le instruction.
>
> >
> > Also, a similar question about uniformly supporting 32 for BPF_ALU and
> > 64 for BPF_ALU64?
>
> Similar to above 64bit SMEM, we could support 32bit sign extend for
> BPF_ALU and 64bit sign extend for BPF_ALU64. Compiler won't pick
> these insns during code generation, but libbpf and inline asm should
> be free to use them.

I don't quite understand how alias of the same insn with different encoding
helps libbpf.
One can argue that x86 has "aliases" for the same command.
Like nop can be 2,3,4,5 and pretty much any number of bytes,
but that's a different use case.
