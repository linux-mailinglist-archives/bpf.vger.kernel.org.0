Return-Path: <bpf+bounces-19765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1418830F73
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 23:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D581F1C226D2
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198281E886;
	Wed, 17 Jan 2024 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTANPlPJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122628DB8
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531454; cv=none; b=rbUMh7wkHeCfNIK04ZfqBIYky7lrDOFEpaSYzZgw4xeoBB19iEC313bvJJFvhPq+R1CddZwrSPd+qNAw8bBePF8oK5d250OcsbkBAfnj/A6OQmhppgg2QtdwbwUR2qQohBHpRsd0eTil/xWvyLAv99euuLep9D98hLquGUtCm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531454; c=relaxed/simple;
	bh=TzJiQXBhcm52feeBP+kx4JgqRfg1wU7AZuJX87J0TRY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=RmZVogzqv2NarOQdm+Yb+OzUFWBaPD26ZL0KGROMRSpQKTThS3UnzFAFHVZWgw04LX758FUHk+xUrodXsI/LiD4m3XGU1Ulsc2So2GgIpzuCHBDOU6WHStOXrXrdhfB+diqWK4HMqEe2AntDUc3BXifBSfpqd3HF1NAJYqG5+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTANPlPJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e884ac5c8so14226265e9.2
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 14:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705531451; x=1706136251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2nUjoT+2mT680QaZ47I9RAZPD7/G4vnGFBoRpPwY+Y=;
        b=UTANPlPJV9GwN+RSIchadxXzuZlVctYeVlb1jNnj3/QEr6KuouSDpDrA+qwT+mn19a
         Td93+qc4A4v3VKrxK3xcgDqnyGk10+xoOPiUJqsRw3hvc122lnSbjuqP0szF6KnpseLI
         qXELbxPsENt1FpNE2mNvhrHLonaHR4lklOSTihqYQtTJBl6VS4GGZ0YXKobRTX6mN3aB
         kofc07yqReqH4BmbQkfUIAgsTcxvzgYOap0OfbuWCLKOCnM1vVaQcRqDggpCFqSCUQCD
         /BgY8KphOZKJpiNZgep4r+01QSovsq8y3CluiiZH7kO9GYiVtJd8onPZgggb+cCkh6hb
         B1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705531451; x=1706136251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2nUjoT+2mT680QaZ47I9RAZPD7/G4vnGFBoRpPwY+Y=;
        b=thgo9RXMoymmSmRghE8MwRr6v9lBNUXSFWbg6NL+Ssk/jeC6PMrZlrteHKRUZ8UKkK
         ebdN1ov6r76kDHiAdR2SYbHPmK7bJFS+YDNR1zO3AlOx6dk2S2xfHTgJxWi4rZOOJxwr
         4jBdngm6YsoPXS6/K5y4ZaJFQSxG0WM9X0/1/H4A5IKFEU0/B1r5mMxtfUcz95Agv4Wj
         aFkBLU4srHC29moXkC161yNoX8aN3G89u1fYTbovj6Iah4mFB7RGXh1gXaAupMdP5E6q
         2+3gJTj96YB/j1BCH+MN6xT8mCLgxOIqTp4tNVtzIL/1k273dLinIhvSE/foo3vnYMeG
         pY/w==
X-Gm-Message-State: AOJu0YxoEQSCRjQCs7V+Yl5ZlaDe3UNHZAjLb/H0zxY9RGaYE1oSvFjX
	fYDkLQlX63wgXijIdhPGhnvi2F6slmiQMBsyfs8=
X-Google-Smtp-Source: AGHT+IH/NCjlynNLoxOqxt4u4RQseStj5MpPmKeHp7ibRfhcKMw3Q9Bg1jiY218ElRIGhsourOOrzX7/h8OaJ8IrRh4=
X-Received: by 2002:a1c:7418:0:b0:40e:4830:4d4d with SMTP id
 p24-20020a1c7418000000b0040e48304d4dmr2621339wmc.242.1705531450854; Wed, 17
 Jan 2024 14:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
 <20231221033854.38397-3-alexei.starovoitov@gmail.com> <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
 <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
 <87h6jm6atm.fsf@oracle.com> <87mste4sjv.fsf@oracle.com> <878r4vra87.fsf@oracle.com>
 <95388269687be49d7896a881eda8aa3bb89e40a4.camel@gmail.com>
 <CAADnVQKGkPaCMyesJ=U469AOS5iJ=vmL20B7Ya7HFp8ouC3C5g@mail.gmail.com>
 <48a7a7db-978d-4e8c-8378-2851975a1ddb@linux.dev> <CAADnVQJTaDrXsn=EXSmEvRX6Zs-kAGtHmMxfS6S__NPD73yoeg@mail.gmail.com>
 <317a4996-2bb4-48b7-911b-96f053d60e3c@linux.dev>
In-Reply-To: <317a4996-2bb4-48b7-911b-96f053d60e3c@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Jan 2024 14:43:59 -0800
Message-ID: <CAADnVQ+5CrmZ3eaWyu0SqZ3LdcFttiGKFB3xOQDhKJx2sxwntw@mail.gmail.com>
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 3:14=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> On 1/16/24 11:34 AM, Alexei Starovoitov wrote:
>
> > On Tue, Jan 16, 2024 at 11:07=E2=80=AFAM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >>
> >> On 1/16/24 9:47 AM, Alexei Starovoitov wrote:
> >>> On Mon, Jan 15, 2024 at 8:33=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> >>>> [0] Updated LLVM
> >>>>       https://github.com/eddyz87/llvm-project/tree/bpf-inline-asm-po=
lymorphic-r
> >>> 1.
> >>> // Use sequence 'wX =3D wX' if 32-bits ops are available.
> >>> let Predicates =3D [BPFHasALU32] in {
> >>>
> >>> This is unnecessary conservative.
> >>> wX =3D wX instructions existed from day one.
> >>> The very first commit of the interpreter and the verifier recognized =
it.
> >>> No need to gate it by BPFHasALU32.
> >> Actually this is not true from llvm perspective.
> >> wX =3D wX is available in bpf ISA from day one, but
> >> wX register is only introduced in llvm in 2017
> >> and at the same time alu32 is added to facilitate
> >> its usage.
> > Not quite. At that time we added general support in the verifier
> > for the majority of alu32 insns. The insns worked in the interpreter
> > earlier, but the verifier didn't handle them.
> > While wX=3DwX was supported by the verifier from the start.
> > So this particular single insn shouldn't be part of alu32 flag
> > It didn't need to be back in 2017 and doesn't need to be now.
>
> Okay, IIUC, currently 32-bit subreg is enabled
> only if alu32 is enabled.
>    if (STI.getHasAlu32())
>      addRegisterClass(MVT::i32, &BPF::GPR32RegClass);
>
> We should unconditionally enable 32-bit subreg with.
>    addRegisterClass(MVT::i32, &BPF::GPR32RegClass);

Makes sense to me.
It should be fine with -mcpu=3Dv1,v2.

> We may need to add Alu32 control in some other
> places which trying to access 32-bit subreg.
> But for wX =3D wX thing, we do not need Alu32 control
> and the following is okay:
>   def : Pat<(i64 (and (i64 GPR:$src), 0xffffFFFF)),
>            (INSERT_SUBREG
>              (i64 (IMPLICIT_DEF)),
>              (MOV_rr_32 (i32 (EXTRACT_SUBREG GPR:$src, sub_32))),
>              sub_32)>;
>
> I tried with the above change with unconditionally
> doing addRegisterClass(MVT::i32, &BPF::GPR32RegClass).
>
> $ cat t1.c
> unsigned long test1(unsigned long x) {
>          return (unsigned)x;
> }
> unsigned long test2(unsigned x) {
>          return x;
> }
> #if 0
> unsigned test3(unsigned x, unsigned y) {
>          return x + y;
> }
> #endif
> $ clang --target=3Dbpf -mcpu=3Dv1 -O2 -c t1.c && llvm-objdump -d t1.o
>
> t1.o:   file format elf64-bpf
>
> Disassembly of section .text:
>
> 0000000000000000 <test1>:
>         0:       bc 10 00 00 00 00 00 00 w0 =3D w1
>         1:       95 00 00 00 00 00 00 00 exit
>
> 0000000000000010 <test2>:
>         2:       bc 10 00 00 00 00 00 00 w0 =3D w1
>         3:       95 00 00 00 00 00 00 00 exit
> $
>
> More changes in BPFInstrInfo.td and possible other
> places need to make the above test3() function work
> at -mcpu=3Dv1.

All makes sense to me.

