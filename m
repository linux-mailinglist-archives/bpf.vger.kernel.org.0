Return-Path: <bpf+bounces-62654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820AAAFC5AA
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 10:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4163D1685CA
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 08:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB052BE027;
	Tue,  8 Jul 2025 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz82vO/X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504602BD59C
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963408; cv=none; b=EOjT9ciRAbOGnzDpUeZ2/6Z+LvEYznrNAEBwp/hWGyRLfxQexEM1PeMFtA76UrqK/WJn6J4zBdQZLnwNUNKw6K9SbcZrMHavSB+CtLxqf2mhbtp3iilZ/AFCtXzEmDb0/QB2N8XNhxAlYgFoZmjptW8ISLTApnHls32YQHijolo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963408; c=relaxed/simple;
	bh=24d5bF+TI4poLI0gylAWbmaGgrv3h/n0VgZfBPUVEuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9bCubuP91UC8XqhQNhUy/Irr5quGZILO1MqtwVFup4swjZR6ujC8rvngFxrftM34hwWFhpSs5PFsgjlayy5brb4uNFyyC+SafY7vUAVswPK9LWcyezq2KHbOURMQjdolijy2nGt5O2kacC/Agc8mMFUweF9SVB1Fqr4tUNCMCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz82vO/X; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23694cec0feso35336705ad.2
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751963407; x=1752568207; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d1AMVimMjL7afuTTctUTykV4yiX09HbqOcXCoSq0Nng=;
        b=Nz82vO/XbtZvtJaRYX8Dx60Ruy0ssJ9AVHVnOfpGFyH46UhXQaT0HqlSfcfHBdTehu
         vCdOdg51MbBFEDZ5Q7bEhGRZngz9rcni6RsUsFfPijC5zJoK5F2lQofDHdH5vlo5/XHr
         DaXXqaAjtMpkm0L/a6p7V76Sken6wZyJGQlChl4VHsSDsLABddK6srHRzjqhCHaqsleG
         zDq4H8GsHlMr//Ml951HnWr1Y0tS1N/ahqx2f9pqlcXUaYL25jfQD3QJn8HZuYEgVXv6
         42cwW0uT9MD6pQbCIChIc9MqNweEujdRk8DRMpyeZ0ivOdhHhZ+yxlkfnRbaHj77UmUt
         IICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751963407; x=1752568207;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1AMVimMjL7afuTTctUTykV4yiX09HbqOcXCoSq0Nng=;
        b=AeVLnWP1grmNrDsmNOPCRvvdH0mWlAfJC9aNErMX7sPJxRqMXGqh+pb/cN7wTzM85g
         WpvLSREkAZfQx/JNPRhfudThtnnNJt2UR90sN2CPJ+Fk3Pi468ZONINs95+tDrem2iNu
         ThVV0E+385tNSg5fP2BwqQnFsH2UTp1KH2edeQ1rY13YQGG5hE3a6IPpLIkglVCWeN11
         WKEGGpasv28hT1c/HySfLQDCWjni1LgSQK/zOPbvvbaAAraNZucYrvf9NztZFs4UcPnO
         19N+USbHYsizFFgrg5I+KIU3pxqHtyH4X5GL6Y6VW3lR0efcyj9IRADXTiIAwo0072dQ
         x/oA==
X-Gm-Message-State: AOJu0YxXg3pFHIJ1zFNzB1gxW5d0AC92Vic4qzl1RQHJLw68UPDxHtrI
	F6rVIVKtESb5dlfPw2kPFHrNhn4lpHJTTrMIqX0HJY5phrbV3Vylg/Je
X-Gm-Gg: ASbGncs+scG/TI5GlzApxPdIcXYcKX33668wgYr3KuTIvE5d2MdeTvnsCs/rUCWaLFK
	cQ2g7W/cjvpD1nhg0aLxmedvYciutWg+NJwHcTXz7V2Li7mK8Dnd0BcgEjYw9KV3x5KHX/guftW
	VmI6qE4sNKgbh8QCJNeZHRKo1sCCNEzH7gCuNQFWws4Gnh4RVREHLzuPP4S1wU6kCjkXDvhFWZ3
	fQKmYIQnWqhF2S3biPP4FN/jUdB90lnXy6nmycnTe1bGOZ/ESpuC2xwrgTiRJjLRWmkoLcn3RwE
	4lSEKi95rBYA2SQg9mdMqkssK4R4hJ3kNuRexHs4Q6w3oozMgvWQJQ/s4Q==
X-Google-Smtp-Source: AGHT+IEG0tsRxZVntDTvnyQvqgtjANvnXJwsdt8K2z5wSR6fz97IHPZrCXlPh+TWbchCFoGtxRDCJg==
X-Received: by 2002:a17:902:e78f:b0:234:bca7:292e with SMTP id d9443c01a7336-23dd1ce1c0dmr31471895ad.14.1751963406436;
        Tue, 08 Jul 2025 01:30:06 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21edab34sm1515397a91.44.2025.07.08.01.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 01:30:06 -0700 (PDT)
Message-ID: <32da86698de643097bbd2b1f15221730b063a527.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>
Date: Tue, 08 Jul 2025 01:30:04 -0700
In-Reply-To: <e8a7a143ad1ebb087ff06032068201023aa893f4.camel@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
			 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
			 <1c17cd755a3e8865ad06baad86d42e42e289439a.camel@gmail.com>
			 <f8bc4e5469e73b99943ff7783fbe4a7758bbbe32.camel@gmail.com>
			 <aF5v8Yw5LUgVDgjB@mail.gmail.com>
		 <454128db01c0a01f3459783cd5a0ea37af01c34e.camel@gmail.com>
	 <e8a7a143ad1ebb087ff06032068201023aa893f4.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 12:07 -0700, Eduard Zingerman wrote:
> On Thu, 2025-07-03 at 11:21 -0700, Eduard Zingerman wrote:
>=20
> [...]
>=20
> > > > >   .jumptables
> > > > >     <subprog-rel-off-0>
> > > > >     <subprog-rel-off-1> | <--- jump table #1 symbol:
> > > > >     <subprog-rel-off-2> |        .size =3D 2   // number of entri=
es in the jump table
> > > > >     ...                          .value =3D 1  // offset within .=
jumptables
> > > > >     <subprog-rel-off-N>                          ^
> > > > >                                                  |
> > > > >   .text                                          |
> > > > >     ...                                          |
> > > > >     <insn-N>     <------ relocation referencing -'
> > > > >     ...                  jump table #1 symbol
>=20
> [...]
>=20
> I think I got it working in:
> https://github.com/eddyz87/llvm-project/tree/separate-jumptables-section
>=20
> Changes on top of Yonghong's work.
> An example is in the attachment the gist is:
>=20
> -------------------------------
>=20
> $ clang --target=3Dbpf -c -o jump-table-test.o jump-table-test.c
> There are 8 section headers, starting at offset 0xaa0:
>=20
> Section Headers:
>   [Nr] Name              Type            Address          Off    Size   E=
S Flg Lk Inf Al
>   ...
>   [ 4] .jumptables       PROGBITS        0000000000000000 000220 000260 0=
0      0   0  1
>   ...
>=20
> Symbol table '.symtab' contains 8 entries:
>    Num:    Value          Size Type    Bind   Vis       Ndx Name
>      ...
>      3: 0000000000000000   256 NOTYPE  LOCAL  DEFAULT     4 .BPF.JT.0.0
>      4: 0000000000000100   352 NOTYPE  LOCAL  DEFAULT     4 .BPF.JT.0.1
>      ...
>=20
> $ llvm-objdump --no-show-raw-insn -Sdr jump-table-test.o
> jump-table-test.o:      file format elf64-bpf
>=20
> Disassembly of section .text:
>=20
> 0000000000000000 <foo>:
>        ...
>        6:       r2 <<=3D 0x3
>        7:       r1 =3D 0x0 ll
>                 0000000000000038:  R_BPF_64_64  .jumptables

I just realized that this relocation references a wrong symbol.
Instead of .BPF.JT.0.0 it references jump table itself.
Need more time to investigate.

>        9:       r1 +=3D r2
>       10:       r1 =3D *(u64 *)(r1 + 0x0)
>       11:       gotox r1

Adding a relocation here requires to bend over backwards a little bit.
Need more time to figure this out.

>       ...
>       34:       r2 <<=3D 0x3
>       35:       r1 =3D 0x100 ll
>                 0000000000000118:  R_BPF_64_64  .jumptables
>       37:       r1 +=3D r2
>       38:       r1 =3D *(u64 *)(r1 + 0x0)
>       39:       gotox r1
>       ...
>=20
> -------------------------------
>=20
> The changes only touch BPF backend. Can be simplified a bit if I move
> MachineFunction::getJTISymbol to TargetLowering in the shared LLVM
> parts.

