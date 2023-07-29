Return-Path: <bpf+bounces-6327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E31E7680D9
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 19:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883BC1C20A81
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E958174C8;
	Sat, 29 Jul 2023 17:56:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F91715BD
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 17:56:15 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2AF2D64
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 10:56:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so49571611fa.2
        for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690653372; x=1691258172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJR5ivEB83OgZOd7G1HfH8uKhMkWUiic2SCw4A6juvY=;
        b=VPOfmgj/poaaS8ODMePUQFxSTOgPEwS5ZdS4CcQ3+G8OI+PsYk9cSN9Owb+gqg/Y1N
         ZUYCZDjhBc/I9gLsar2V8apqmxbPHSqg65fK9D7f3U0rOGrS8Gcq7LZI+eVNEQPfalm7
         ru0zXXoNHLeZuy8lziVCj4jiMjQll5JnYzkSm9aEkR0aSbYkqQ4A4BYdR8x/f1i0VUyJ
         zpZdpOn7mrzXeY8kD18KLO0XBhSHQbARZCe1GFPs02mMZL9NLLvW/9TvNDg6YZUxjkP0
         mbIGu1RNk61voKSqt+rvnSz6HW8mEJlstilL+NexW0ditxJneG+mav90DcMpdpFjcJFv
         52cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690653372; x=1691258172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJR5ivEB83OgZOd7G1HfH8uKhMkWUiic2SCw4A6juvY=;
        b=Alk+2YadXyuh8z+xjjUGGn63c3paUfvYMJofkvcVlONp3XVmqB7VqxDvsBTNA6smwp
         iXrg/OEl85r5M9RBdmn2TbpoGnHqqCyuTrQEGAdIoaV5pVyOKVbFvcd4lvJWeazyPQ8Q
         uuxFaIQZavs9aFKyJyFDBsJa9Cjmf9VfIDO3YWuU7XPxlipXfewtWBArmrvn8gFcNE7e
         kBCe5/42a86aaIszIE9GIJl91w2wcarFyDCPKW3Q+pLk6ZJ82ybF+J5MpHkIzlAs3xkS
         c94FihyO0l3RZOrs3DDigNiZasbmVmI7pvxwN86jOBhczAqL05mx/eWdQaoBqhNVA0O3
         ykiA==
X-Gm-Message-State: ABy/qLYl+qF01bbllNn0+dnaJPXpdRY589n5PVzFvUznQ3DIQFp8n29m
	PDLlUfhcsFyUOUhQPcAiWjFzN0LFxuoic40wuVo=
X-Google-Smtp-Source: APBJJlF6GWCd40M3dhmq+0hHboOuNgqmbju2SW3Th1aaqa2YW3+zSJroMlBNlPXonUSe8ozFGQwXqwZGSCfWH84DChU=
X-Received: by 2002:a2e:8612:0:b0:2b1:a89a:5f2b with SMTP id
 a18-20020a2e8612000000b002b1a89a5f2bmr3839610lji.2.1690653371390; Sat, 29 Jul
 2023 10:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878rb0yonc.fsf@oracle.com> <13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev>
 <87v8e4x7cr.fsf@oracle.com> <87pm4bykxw.fsf@oracle.com> <CAADnVQLaZrqq232fxts0GmymaaG=fpvRbSZaBkfNnKFuy0LM8A@mail.gmail.com>
 <87jzujnms6.fsf@oracle.com>
In-Reply-To: <87jzujnms6.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 29 Jul 2023 10:56:00 -0700
Message-ID: <CAADnVQ+2mHqRc2EBCKe+NHHPQ+FqaNt2PmD6t9DN6GwPnu1RQg@mail.gmail.com>
Subject: Re: GCC and binutils support for BPF V4 instructions
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 1:29=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Fri, Jul 28, 2023 at 11:01=E2=80=AFAM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >>
> >>
> >> >> On 7/28/23 9:41 AM, Jose E. Marchesi wrote:
> >> >>> Hello.
> >> >>> Just a heads up regarding the new BPF V4 instructions and their
> >> >>> support
> >> >>> in the GNU Toolchain.
> >> >>> V4 sdiv/smod instructions
> >> >>>    Binutils has been updated to use the V4 encoding of these
> >> >>>    instructions, which used to be part of the xbpf testing dialect=
 used
> >> >>>    in GCC.  GCC generates these instructions for signed division w=
hen
> >> >>>    -mcpu=3Dv4 or higher.
> >> >>> V4 sign-extending register move instructions
> >> >>> V4 signed load instructions
> >> >>> V4 byte swap instructions
> >> >>>    Supported in assembler, disassembler and linker.  GCC generates
> >> >>> these
> >> >>>    instructions when -mcpu=3Dv4 or higher.
> >> >>> V4 32-bit unconditional jump instruction
> >> >>>    Supported in assembler and disassembler.  GCC doesn't generate
> >> >>> that
> >> >>>    instruction.
> >> >>>    However, the assembler has been expanded in order to perform th=
e
> >> >>>    following relaxations when the disp16 field of a jump instructi=
on is
> >> >>>    known at assembly time, and is overflown, unless -mno-relax is
> >> >>>    specified:
> >> >>>      JA disp16  -> JAL disp32
> >> >>>      Jxx disp16 -> Jxx +1; JA +1; JAL disp32
> >> >>>    Where Jxx is one of the conditional jump instructions such as
> >> >>> jeq,
> >> >>>    jlt, etc.
> >> >>
> >> >> Sounds great. The above 'JA/Jxx disp16' transformation matches
> >> >> what llvm did as well.
> >> >
> >> > Not by chance ;)
> >> >
> >> > Now what is pending in binutils is to relax these jumps in the linke=
r as
> >> > well.  But it is very low priority, compared to get these kernel
> >> > selftests building and running.  So it will happen, but probably not
> >> > anytime soon.
> >>
> >> By the way, for doing things like that (further object transformations
> >> by linkers and the like) we will need to have the ELF files annotated
> >> with:
> >>
> >> - The BPF cpu version the object was compiled for: v1, v2, v3, v4, and
> >>
> >> - Individual flags specifying the BPF cpu capabilities (alu32, bswap,
> >>   jmp32, etc) required/expected by the code in the object.
> >>
> >> Note it is interesting to being able to denote both, for flexibility.
> >>
> >> There are 32 bits available for machine-specific flags in e_flags, whi=
ch
> >> are commonly used for this purpose by other arches.  For BPF I would
> >> suggest something like:
> >>
> >> #define EF_BPF_ALU32  0x00000001
> >> #define EF_BPF_JMP32  0x00000002
> >> #define EF_BPF_BSWAP  0x00000004
> >> #define EF_BPF_SDIV   0x00000008
> >> #define EF_BPF_CPUVER 0x00FF0000
> >
> > Interesting idea. I don't mind, but what are we going to do with this i=
nfo?
> > I cannot think of anything useful libbpf could do with it.
> > For other archs such flags make sense, since disasm of everything
> > to discover properties is hard. For BPF we will parse all insns anyway,
> > so additional info in ELF doesn't give any additional insight.
>
> I mainly had link-time relaxation in mind.  The linker needs to know
> what instructions are available (JMP32 or not) in order to decide what
> to relax, and to what.

But the assembler has little choice when the jump target is >16bits.
It can use jmp32 or error.
I guess you're proposing to encode this e_flags in the text of asm ?
Special asm directive that will force asm to error or use jmp32?

> Also as you mention the disassembler can look in the object to determine
> which instructions shall be recognized and with insructions shall be
> reported as <unknown>.  Right now it is necessary to pass an explicit
> option to the assembler, and the default is v4.

Disambiguating between unknown and exact insn kinda makes sense for disasm.
For assembler it's kinda weird. If text says 'sdiv' the asm should emit
binary code for it regardless of asm directive.
It seems e_flags can only be emitted by assembler.
Like if it needs to use jmp32 it will add EF_BPF_JMP32.

Still feels that we can live without these flags, but not a bad addition.

As far as flag names, let's use EF_ prefix. I think it's more canonical.
And single 0xF is probably enough for cpu ver.

