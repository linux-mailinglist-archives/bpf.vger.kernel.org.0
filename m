Return-Path: <bpf+bounces-62319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65672AF7FD2
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC141C868A7
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC98E2F49F2;
	Thu,  3 Jul 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHGROzht"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E42F4335
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566875; cv=none; b=uKWSrO/VUsFduxmaW29I4JhqEGIBItU9vdGCEjjF/pJ3ZZ4j9v/AfZWym+81L4vxgZKwl2hiVJhD3mew1H0TpEaHJuuJ48TXGF6dsSZ3ODBo9yqjoqe+gUrLWkKc0hh0ehsuinZttLl8tDrmA2Veif6vf2IZGO+tTFPjFXST5Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566875; c=relaxed/simple;
	bh=DXTsZp2vvJuBwWFvXI1tDCnV+Hg7uoja8wErEZUV7UA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1brj+1azPNXPcRujIaNKqvMj62C0Y/2P/sJqOmOrrhdFH1QvRw19MosUOrI38t3m0fq+wXzTcRbonMDrFvPoVNb33XUk+eh5p0ogNhPfWNkjz8jmStP+UbnJAF6aWrWtxUS2Llr89h17AkYvN8gMLv1aC+Xj7fVlw/FHETzNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHGROzht; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2350b1b9129so2285575ad.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751566873; x=1752171673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xMZVMuakD1u/pPXToXIHPbwwu3Op/ngWKnu/eVrwCCA=;
        b=cHGROzhtX44unGniEzUwiAM59PjUQ2iOSds40OHDstLuAGmyauXW89VDOX7iX5inux
         xLgnXSvSaalrrVDRNlNFsHG1KiUUS7Yo117Lhyq+fsv4QWBBbq+944f6LCwIOsBnv9ie
         MCBcwAPwrTUvmJGrhmrYtLPq4cXRIHBiAsF6v+BzrSSQAHdidoxVxMNWbOgL8Hu4Q1Pz
         AWQLl2alMD8QiDEvYa5mPoN5ZnWHNB4WLtCyr26Lo7iTp4BV/+sbo93RbwVKyCLHb2+v
         PBvya8VBXzNv0rIctwN6F90wciVrWAvjpI6dIhcj3lb6uBn5XH9AfQlwlPfIHcANl8Ha
         xw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751566873; x=1752171673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMZVMuakD1u/pPXToXIHPbwwu3Op/ngWKnu/eVrwCCA=;
        b=XszHsRzimU7GjpWh2+BZNgPgX7pRRzyZr6t8aKGQ3L/iLMsfqQdwWQrL8mu740m8jE
         QxsFf+hPvgKqjT+DdLIkBsD1cHZXlsaRaA+YX++3QkWG3HhWPiedIunMHlGc4unad2MM
         7gu5yChmt5Miei+/FZXu2X01vppjp3sNG+dHhR7SsiAL8aRiYOQuF68/kaWhVVDVyXZU
         jiA+ueX3aw34KBjLR5voNFzek5fLh8pkZe9zzxOHkn0knjhjt+UVTGM+ziCFkodf5wOK
         5G6PyH/c5FRHouRjkZophNdAw2RxSBfdxR/ewzOgfkKcE7vtyy55PymrUAW5Sp0dD10B
         cPHw==
X-Gm-Message-State: AOJu0YyPN9viB9BQe9GF5oyyi+Sd6wTrn2sqK9TANisgO0w9eFkjiAch
	zY/ZohcdVrxWdGDp8+xKVHW2nahzM71UMwaZq1v9RNl1t5o1dVvtXQkM
X-Gm-Gg: ASbGncssGNw/khAY6QrOkbHJx1HsjsbdjarxxT/eHaqC1gijp9bU+Ixq7qOcbMtMjGq
	qTs/hXB0gyzacnTBrkX39LkOHiC/meH+bNI9M2ihjAnB6rprCVSpKgtSzaXk3/Nxu9GaObY5vY8
	S+G7Vxc492JgF4HZeM+hSjmHfQRwI2j9pcZxXofpetfrYyzhvyYI7pRaA12JsRJJUznJszCtL+t
	FcTD1eOq8+/WjuntADaZzX3zbo6avuVUI5/kec08q8WMGvwCwef8tIY3nSgTmoVSehT3SUKYq5i
	Udp2l8o4jYtj8XEoRsODV98wcSF7Zo5go4jm7BGDemY7m3SCKNt9Fs8noc+DK73dZZSrL+vu1uZ
	MAvc=
X-Google-Smtp-Source: AGHT+IGDCtOQJMqmUalirn5z/96gxtd/Vrq3+1h7GeDSpDlLlDPkNzdTZ4UUQdMwECIaZvhHLVPZPw==
X-Received: by 2002:a17:902:ec81:b0:235:81c7:3c45 with SMTP id d9443c01a7336-23c797cdb44mr54743195ad.46.1751566872925;
        Thu, 03 Jul 2025 11:21:12 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:90c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845bccbbsm1337975ad.238.2025.07.03.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 11:21:12 -0700 (PDT)
Message-ID: <454128db01c0a01f3459783cd5a0ea37af01c34e.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Thu, 03 Jul 2025 11:21:11 -0700
In-Reply-To: <aF5v8Yw5LUgVDgjB@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
	 <1c17cd755a3e8865ad06baad86d42e42e289439a.camel@gmail.com>
	 <f8bc4e5469e73b99943ff7783fbe4a7758bbbe32.camel@gmail.com>
	 <aF5v8Yw5LUgVDgjB@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-27 at 10:18 +0000, Anton Protopopov wrote:
> On 25/06/26 07:28PM, Eduard Zingerman wrote:
> > On Wed, 2025-06-18 at 12:49 -0700, Eduard Zingerman wrote:
> > > On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
> > >=20
> > > [...]
> > >=20
> > > > @@ -698,6 +712,14 @@ struct bpf_object {
> > > >  	bool has_subcalls;
> > > >  	bool has_rodata;
> > > > =20
> > > > +	const void *rodata;
> > > > +	size_t rodata_size;
> > > > +	int rodata_map_fd;
> > >=20
> > > This is sort-of strange, that jump table metadata resides in one
> > > section, while jump section itself is in .rodata. Wouldn't it be
> > > simpler make LLVM emit all jump tables info in one section?
> > > Also note that Elf_Sym has name, section index, value and size,
> > > hence symbols defined for jump table section can encode jump tables.
> > > E.g. the following implementation seems more intuitive:
> > >=20
> > >   .jumptables
> > >     <subprog-rel-off-0>
> > >     <subprog-rel-off-1> | <--- jump table #1 symbol:
> > >     <subprog-rel-off-2> |        .size =3D 2   // number of entries i=
n the jump table
> > >     ...                          .value =3D 1  // offset within .jump=
tables
> > >     <subprog-rel-off-N>                          ^
> > >                                                  |
> > >   .text                                          |
> > >     ...                                          |
> > >     <insn-N>     <------ relocation referencing -'
> > >     ...                  jump table #1 symbol
> >=20
> > Anton, Yonghong,
> >=20
> > I talked to Alexei about this yesterday and we agreed that the above
> > arrangement (separate jump tables section, separate symbols for each
> > individual jump table) makes sense on two counts:
> > - there is no need for jump table to occupy space in .rodata at
> >   runtime, actual offsets are read from map object;
> > - it simplifies processing on libbpf side, as there is no need to
> >   visit both .rodata and jump table size sections.
> >=20
> > Wdyt?
>=20
> Yes, this seems more straightforward. Also this will look ~ the same
> for used-defined (=3D non-llvm-generated) jump tables.
>=20
> Yonghong, what do you think, are there any problems with this?
> Also, how complex this would be to directly link a gotox instruction
> to a particular jump table? (For a switch, for "user-defined" jump
> tables this is obviously easy to do.)

I think I know how to hack this:
- in BPFAsmPrinter add a function generating a global symbol for jump
  table (same as MachineFunction::getJTISymbol(), but that one always
  produces a private symbol (one starting with "L"));
- override TargetLowering::getPICJumpTableRelocBaseExpr to use the
  above function;
- modify BPFMCInstLower::Lower to use the above function;
- override AsmPrinter::emitJumpTableInfo, a simplified version of the
  original one:
  - a loop over all jump tables:
	- before each jump table emit start global symbol
	- after each jump table emit temporary symbol to mark jt end
	- set jump table symbol size to
		OutStreamer->emitELFSize(StartSym,
		                         MCBinaryExpr::createSub(MCSymbolRefExpr::create(=
EndSym, OutContext),
								 MCSymbolRefExpr::create(StartSym, OutContext),
								 OutContext)
	- use AsmPrinter::emitJumpTableEntry to emit individual jump table
      entries;
- plus the code to create jump tables section.

I should be able to share the code for this tomorrow or on the weekend.

