Return-Path: <bpf+bounces-6285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEE1767924
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 01:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBD41C20A6F
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 23:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC120FB7;
	Fri, 28 Jul 2023 23:49:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F50525C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 23:49:22 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2164C422B
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:49:21 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9c0391749so40658271fa.0
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690588159; x=1691192959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvjslTV8dcXFYHH1cIkUZv3Bh4WKXkqP1ZgucmBlBok=;
        b=Bnnt/RfzcPhGtgPsDriAEigUJZEcNR2xgFn2kLZdl83Hb8KGaiAAtFIt/d7BLv8mUq
         q7cvh3129+6E4v+mAn2IPSTW1yNCuFjJRNhb7lxFbVJiptdeS8ncuR7EsrvSQgCr434T
         BIxje1Q/oHcHnawBDC6+t9Qf+cyJThOBkvVOPjMBT18gkz0SMqNfY+/OA2axCZhtPDUt
         swtkIivTqBpSQu65cGMoUapkfR88NJj2f1i38njf7morAJoTCSLqpoxc7TJNK7TzwKnh
         25KGFpvnzm+iEAgzGg492O8D0Cpe9Xup695cmoSTmR5w4h45A9vXNzHd4IXhvXPgpLUe
         ye2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690588159; x=1691192959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvjslTV8dcXFYHH1cIkUZv3Bh4WKXkqP1ZgucmBlBok=;
        b=BXt7jC1ff5c47a+gxdEviFQhyh/iIJINrcpEpRTw/WnQlLrsslypq8Qj+eUW/49A2K
         +CxuHB5HOQKQYOY0j7Bwwg+C76MM5xNF9t0+CmAeN25L2b5DSngJdPFNfE1cmKgJ9/Ha
         pFckzPnKCjzoL/c69hRHFNojTf00OCnzXbyD5DUZaF8Gdy9G0A7KZRtU6Aso2qor4Jnw
         0ksGWjICXn5+KdunlcWM3xxyctefG8rtEJeHtDIMgK2/1uu1HbPkjKMG0JPjLX1SNS4p
         Pkw2PMIk/Lmnz43O9VhrxRv8tNQH4L8c14hVPWBnQuOzFz2r2JFeSk0E6AEsrzaY2++N
         Qjpg==
X-Gm-Message-State: ABy/qLYJ++L4lHeLGyJUG/DoIAV9VhL1l4YC/yGAXCZkj/TGSd7nMbHY
	AzSpPxeoUlzZYeVP2COfQHqcXNzKy5pA1sEiGuwPuCQA
X-Google-Smtp-Source: APBJJlEd5m9E5Drrc8cmSwFwjntwLF4CTzwykF62zPcztP+axgzADqxWYKQDR9oq7K9321g54vohojFlGbtUbcLZKiU=
X-Received: by 2002:a2e:8816:0:b0:2b9:ac48:d7fe with SMTP id
 x22-20020a2e8816000000b002b9ac48d7femr2819657ljh.38.1690588159075; Fri, 28
 Jul 2023 16:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878rb0yonc.fsf@oracle.com> <13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev>
 <87v8e4x7cr.fsf@oracle.com> <87pm4bykxw.fsf@oracle.com>
In-Reply-To: <87pm4bykxw.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 16:49:07 -0700
Message-ID: <CAADnVQLaZrqq232fxts0GmymaaG=fpvRbSZaBkfNnKFuy0LM8A@mail.gmail.com>
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

On Fri, Jul 28, 2023 at 11:01=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> >> On 7/28/23 9:41 AM, Jose E. Marchesi wrote:
> >>> Hello.
> >>> Just a heads up regarding the new BPF V4 instructions and their
> >>> support
> >>> in the GNU Toolchain.
> >>> V4 sdiv/smod instructions
> >>>    Binutils has been updated to use the V4 encoding of these
> >>>    instructions, which used to be part of the xbpf testing dialect us=
ed
> >>>    in GCC.  GCC generates these instructions for signed division when
> >>>    -mcpu=3Dv4 or higher.
> >>> V4 sign-extending register move instructions
> >>> V4 signed load instructions
> >>> V4 byte swap instructions
> >>>    Supported in assembler, disassembler and linker.  GCC generates
> >>> these
> >>>    instructions when -mcpu=3Dv4 or higher.
> >>> V4 32-bit unconditional jump instruction
> >>>    Supported in assembler and disassembler.  GCC doesn't generate
> >>> that
> >>>    instruction.
> >>>    However, the assembler has been expanded in order to perform the
> >>>    following relaxations when the disp16 field of a jump instruction =
is
> >>>    known at assembly time, and is overflown, unless -mno-relax is
> >>>    specified:
> >>>      JA disp16  -> JAL disp32
> >>>      Jxx disp16 -> Jxx +1; JA +1; JAL disp32
> >>>    Where Jxx is one of the conditional jump instructions such as
> >>> jeq,
> >>>    jlt, etc.
> >>
> >> Sounds great. The above 'JA/Jxx disp16' transformation matches
> >> what llvm did as well.
> >
> > Not by chance ;)
> >
> > Now what is pending in binutils is to relax these jumps in the linker a=
s
> > well.  But it is very low priority, compared to get these kernel
> > selftests building and running.  So it will happen, but probably not
> > anytime soon.
>
> By the way, for doing things like that (further object transformations
> by linkers and the like) we will need to have the ELF files annotated
> with:
>
> - The BPF cpu version the object was compiled for: v1, v2, v3, v4, and
>
> - Individual flags specifying the BPF cpu capabilities (alu32, bswap,
>   jmp32, etc) required/expected by the code in the object.
>
> Note it is interesting to being able to denote both, for flexibility.
>
> There are 32 bits available for machine-specific flags in e_flags, which
> are commonly used for this purpose by other arches.  For BPF I would
> suggest something like:
>
> #define EF_BPF_ALU32  0x00000001
> #define EF_BPF_JMP32  0x00000002
> #define EF_BPF_BSWAP  0x00000004
> #define EF_BPF_SDIV   0x00000008
> #define EF_BPF_CPUVER 0x00FF0000

Interesting idea. I don't mind, but what are we going to do with this info?
I cannot think of anything useful libbpf could do with it.
For other archs such flags make sense, since disasm of everything
to discover properties is hard. For BPF we will parse all insns anyway,
so additional info in ELF doesn't give any additional insight.

