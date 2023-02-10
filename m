Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963F66929D0
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 23:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjBJWF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 17:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjBJWFZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 17:05:25 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEF0611E3
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 14:05:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m2so19280014ejb.8
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 14:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=frkmtsRyxC3q/3d/VqKiwbVwtoYQv7tBRCAcEy61ufc=;
        b=ExdXSAXnmjw3ykXSQ/n7GmP3Fv5VxihasahIsMLrZsEbm1zXeVWoLWdY11WiwZsxYg
         AbnJ7gV3EdF/O5wTKvJ243aCz/q8AvcGQkqkgmvW6a+xjliBPJgfX4A1Z5sQvuTF3OEA
         Pbjg8x8CwPh+RyxECH/EKvDfwN2W7H/k/cCbXMfiFVp8arCRS04XyMQH4rilATYR3t4+
         vyWk2w0rCZzuduVhw2q4SN3z+S19ZUztf6GXeFnbvQqWx75F9SqNT3VYwK25ih8G9TON
         ZOJfLvkMj/fknlT8/XTBobHvjECPndrkDEINn4EOgk6QoDmWyUtRNgI5mY0ReymlfW4I
         sbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frkmtsRyxC3q/3d/VqKiwbVwtoYQv7tBRCAcEy61ufc=;
        b=DCUwWLiwiNt2tUf9HJu+3l6nG0o3tVwY8eIWuqCTFiu6w10+q2u9XXKd6iCQAyTtIH
         eWE84r45x8DBVHUYqV7dAmOAG0s71nT2sFPlzIDAouC9C9vuYp+s9M7VKPJIPOXse6uk
         z7PAHwcn2sqmk0uibRD7phhESPJVHbjVK3wLHoFZom8tyT/2FBat2085apuyMQZ3xh+s
         FWsKBcHGh5Mh/HGDBOpdXrLrnSNXiIdtcUouAoNuAYKISn0v4fjRo/QiojeVcpHm29mO
         qCjQklKHQyqCqXnWMH/uFa9XXcqbRSE3QSccAhH65ORFx8811QvEuWo+dN3dfrPKyhrN
         FfHg==
X-Gm-Message-State: AO0yUKXHV+SsVzVSjajVto3ekjBtWtXKZsRckja6dpV8mKQZ30aWuuSH
        afhK4k5EV1+4eAixzYAh5x66amKgdaINunDVbfE=
X-Google-Smtp-Source: AK7set+KFmBUd/FKYQJ4AzH1huq3Ff9Ykj/R6QWjwefK32B3PBkcIodxaWHA0QNdokmoviPpM2tID/a6fFA4+07XsZA=
X-Received: by 2002:a17:906:af15:b0:8af:b63:b4ba with SMTP id
 lx21-20020a170906af1500b008af0b63b4bamr1712030ejb.3.1676066722398; Fri, 10
 Feb 2023 14:05:22 -0800 (PST)
MIME-Version: 1.0
References: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com>
 <87fsbe8l8n.fsf@oracle.com> <87357e8f9m.fsf@oracle.com> <878rh5h9vh.fsf@oracle.com>
In-Reply-To: <878rh5h9vh.fsf@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 10 Feb 2023 14:05:11 -0800
Message-ID: <CAADnVQJ6HF4q1=nA_ahx-fc+-idRxjPxehReA_MtMr64uSo9Fw@mail.gmail.com>
Subject: Re: bpf: Propose some new instructions for -mcpu=v4
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Yonghong Song <yhs@meta.com>, alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
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

On Fri, Feb 10, 2023 at 6:29 AM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> >> Hi Yonghong.
> >> Thanks for the proposal!
> >>
> >>> SDIV/SMOD (signed div and mod)
> >>> ==============================
> >>>
> >>> bpf already has unsigned DIV and MOD. They are encoded as
> >>>
> >>>   insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
> >>>   off(16 bits)
> >>>   DIV     0x3              0/1               BPF_ALU/BPF_ALU64          0
> >>>   MOD     0x9              0/1               BPF_ALU/BPF_ALU64          0
> >>>
> >>> The current 'code' field only has two value left, 0xe and 0xf.
> >>> gcc used these two values (0xe and 0xf) for SDIV and SMOD.
> >>> But using these two values takes up all 'code' space and makes
> >>> future extension hard.
> >>>
> >>> Here, I propose to encode SDIV/SMOD like below:
> >>>
> >>>   insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
> >>>   off(16 bits)
> >>>   DIV     0x3              0/1               BPF_ALU/BPF_ALU64          1
> >>>   MOD     0x9              0/1               BPF_ALU/BPF_ALU64          1
> >>>
> >>> Basically, we reuse the same 'code' value but changing 'off' from 0 to 1
> >>> to indicate signed div/mod.
> >>
> >> I have a general concern about using instruction operands to encode
> >> opcodes (in this case, 'off').
> >>
> >> At the moment we have two BPF instruction formats:
> >>
> >>  - The 64-bit instructions:
> >>
> >>     code:8 regs:8 offset:16 imm:32
> >>
> >>  - The 128-bit instructions:
> >>
> >>     code:8 regs:8 offset:16 imm:32 unused:32 imm:32
> >>
> >> Of these, `code', `regs' and `unused' are what is commonly known as
> >> instruction fields.  These are typically used for register numbers,
> >> flags, and opcodes.
> >>
> >> On the other hand, offset, imm32 and imm:32:::imm:32 are instruction
> >> operands (the later is non-contiguous and conforms the 64-bit operand in
> >> the 128-bit instruction).
> >>
> >> The main difference between these is that the bytes conforming
> >> instruction operands are themselves impacted by endianness, on top on
> >> the endianness effect on the whole instruction.  (The weird endian-flip
> >> in the two nibbles of `regs' is unfortunate, but I guess there is
> >> nothing we can do about it at this point and I count them as
> >> non-operands.)
> >>
> >> If you use an instruction operand (such as `offset') in order to act as
> >> an opcode, you incur in two inconveniences:
> >>
> >> 1) In effect you have "moving" opcodes that depend on the endianness.
> >>    The opcode for signed-operation will be 0x1 in big-endian BPF, but
> >>    0x8000 in little-endian bpf.
> >>
> >> 2) You lose the ability of easily adding more complementary opcodes in
> >>    these 16 bits in the future, in case you ever need them.
> >>
> >> As far as I have seen in other architectures, the usual way of doing
> >> this is to add an additional instruction format, in this case for the
> >> class of arithmetic instructions, where the bits dedicated to the unused
> >> operand (offset) becomes a new opcodes field:
> >>
> >>   - 32-bit arithmetic instructions:
> >>
> >>     code:8 regs:8 code2:16 imm:32
> >>
> >> Where code2 is now an additional field (not an operand) that provides
> >> extra additional opcode space for this particular class of instructions.
> >> This can be divided in a 1-bit field to signify "signed" and the rest
> >> reserved for future use:
> >>
> >>    opcode2 ::= unused(15) signed(1)
> >
> > Actually this would be just for DIV/MOD instructions, so the new format
> > should only apply to them.  The new format would be something like:
> >
> >   - 64-bit ALU/ALU64 div/mod instructions (code=3,9):
> >
> >     code:8 regs:8 unused:15 signed:1 imm:32
> >
> > And for the rest of the ALU and ALU64 instructions
> > (code=0,1,2,4,5,6,7,8,a,b,c,d):
> >
> >   - 64-bit ALU/ALU64 instructions:
> >
> >     code:8 regs:8 unused:16 imm:32
>
> Re-reading what I wrote above I realize that it is messy and uses
> confusing terms that are not used in instruction-set.rst, and it also
> has mistakes.  Sorry about that, 3:30AM posting.
>
> After sleeping over it I figured I better start over and this time I
> keep it short and stick to instruction-set.rst terminology :)
>
> What I am proposing is, instead of using the `offset' multi-byte field
> to encode an opcode:
>
>   =============  =======  =======  =======  ============
>   32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>   =============  =======  =======  =======  ============
>   imm            offset   src_reg  dst_reg  opcode
>   =============  =======  =======  =======  ============
>
> To introduce a new opcode2 field for ALU32/ALU instructions like this:
>
>   =============  ======= ======= =======  =======  ============
>   32 bits (MSB)  8 bits  8 bits  4 bits   4 bits   8 bits (LSB)
>   =============  ======= ======= =======  =======  ============
>   imm            opcode2 unused  src_reg  dst_reg  opcode
>   =============  ======= ======= =======  =======  ============
>
> This way:
>
> 1) The opcode2 field's stored value will be the same regardless of
>    endianness.
>
> 2) The remaining 8 bits stay free for future extensions.
>
> That is from a purely ISA perspective.  But then this morning I thought
> about the kernel and its uapi.  This is in uapi/linux/bpf.h:
>
>   struct bpf_insn {
>         __u8    code;           /* opcode */
>         __u8    dst_reg:4;      /* dest register */
>         __u8    src_reg:4;      /* source register */
>         __s16   off;            /* signed offset */
>         __s32   imm;            /* signed immediate constant */
>   };
>
> If the bpf_insn struct is supposed to reflect the encoding of stored BPF
> instructions, and since it is part of the uapi, does this mean we are
> stuck with that instruction format (and only that format) forever?
>
> Because if changing the internal structure of the bpf_insn struct is a
> no-no, then there is no way to expand the existing opcode space without
> using unused multi-byte fields like `off' as such :/

Yes. It's an uapi and we're stuck with it.
If I understand correctly you want to extend 8-bit opcode field
with another endian independent 8 or 1 bit field.
It's possible on paper, but very challenging and ugly in the code.
llvm backend does this for 'off' field:
OSE.write<uint16_t>((Value >> 32) & 0xffff);
where OSE is endian dependent writer.
It does it unconditionally for all insns when it emits them into elf.
While in BPFInstrInfo.td we set this 16 bits as:
let Inst{47-32} = offset;
so to make it 'endian independent' from ISA point of view
the llvm backend would need to undo the endianness OSE.write
and become endian dependent when it sets Inst{47-32} which is
possible, but quite ugly.
Another alternative is to teach binary emitter to different opcodes
and do OSE.write<uint16_t> one way for one set of opcode
and differently for another. Which is equally ugly.

The same ugliness will be on the kernel side.
Instead of doing if (bpf_insn->off == 1) in the interpreter and all JITs
in all architectures (both little and big)
the kernel would need to do this pseudo-endian-independent dance
and little end arch would do if (bpf_insn->off == 1) while
big-endian arch would do if (bpf_insn->off == 255)
which is double ugly.

imo Yonghong's proposal to encode off=1 for signed div/mod is cleaner.
It fits well to what we have already for other insns.
