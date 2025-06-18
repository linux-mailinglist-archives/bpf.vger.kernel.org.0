Return-Path: <bpf+bounces-61005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE1AADF90B
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 23:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D017AA5CC
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 21:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677D927E1D0;
	Wed, 18 Jun 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT8mT8jK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AEB27E044
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750283985; cv=none; b=JNZ4YUW25p9tQh4cvS6l1KVmfk2RYESMFsbBs+OZ3co4KH46pmDF2SYng3wvQuhjwquxsyaLaW0cj6WTD6QPsH9YblJJnHVOIH0LneF/NDJlBHpItSudSrg06zZTQ1I9injCfAfqYbJHyhTGkucvvZyB0gqZNadK2K6vBXGq680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750283985; c=relaxed/simple;
	bh=7nGvX5WWNrwrnFJvm86lFz12xKyHqiqJeLale5KfaYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePlXgHWDhMAEjIeOFY84eZu+5e+eS9YUR85hTgBHMdjn6Fl7KIRiLzSUktFreexVA3SROu3hXjHob2DAEc/FnwMerJEnG2zA1cfROR+iGaOwVCfV8tGzwcIKQdPmg0KNm0f8SKFahVbJohkMlsVWaPanX6AdX1EPldDQ6YpI7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT8mT8jK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so80352f8f.1
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750283981; x=1750888781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWKaX7Uqa3jo+GIPCuaDb5VGbrS8+M8C2JgytHjAudU=;
        b=VT8mT8jKzjQCoNaFbhXkQ+4N9eZEW9HiPJ3TAKF2CKpUpWoLlbkXRkpA9dAU7DFRI3
         4ZON9hsmLtxznpx1XtgIO+XNEH0H2cPhS5STNf7KhKG4E4UVeQBL8DI5GIY3oG35xea4
         G7ILMU4uP7vG0fbhMmgdtQjJy5Qt7gL5Pnvq6nTihiu7PAP1biMuPX4oWZ/d3/AVW4XS
         n74WUSOgR4Pthl3awrMyilHm6KZ2hTpCIDf4j5rjMmqK/dBlwYfJWLbUCGpUi20NMWNw
         +AUVd5DX+NBwBF0AHv0gnsku6Wm1ZZVibmtqmuIwtGisXb8kl1vwmtIXaG5Frn2Zy7+8
         2yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750283981; x=1750888781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWKaX7Uqa3jo+GIPCuaDb5VGbrS8+M8C2JgytHjAudU=;
        b=tkv9ef4VG+w9+oVohmgaY+8nYorUrwGTccdRCY5X/VTPwSXSJzLGjcmLszA5vZOtpp
         Me39po/BIKVIO2oTKLgl2VCGKKYIm/dNyAbEhZ33e01MjZw/MhzHXSv+Af8ykWJp7hZS
         44AFnmPnL10U3PTZZuSNPlDCU4U8HaL3XVWURlhp8qftz/TIIun4nTHBDJvSLUrjSwzF
         +2+/3DL8Q31AVoNU4A3fklq4QLQLs/vCCzmimqeLdRylIWzYPQKtjeytJJls01XzvPfi
         ze04dMUtV901ILVhJp0cEAbwjjmSWymG3WuPHvx5Lay85vBIUi3SH43csWDBr2PqsxXU
         CNoA==
X-Gm-Message-State: AOJu0Ywu4GcHbPuj0HwOS2SaBsfX7OmCRS5G76VQgvDLkOyFzFQ/wDMW
	mfL3SeHUfm2gxq90HMYULJM4Y39Y0BWGiIevBMRhbG05IrnBbcWuTwI0m7lfkTlUtBRCnTpr4FK
	EDF0Jv5St81jndHoBSG0pxGuAepbpXgY=
X-Gm-Gg: ASbGnct8APTClOOzbyVNxU/Lis2tTQ4SyGhxjrhz7uxdMKTgsN9kHU492q1RwQPX2jX
	/GTkAhG0eFkgFIBegs1ieyNPxPkfpJwNN3frif94AeFCQ/QEo5N2SU4GbP/YEIxqzSYJxQYvmA8
	uP455zB6XKE3aYtPMuf62vERHyFprUgebQ34ogYr9JWLoVlovP8pv9C/tXWcZ+0p4y2Mal2ul5
X-Google-Smtp-Source: AGHT+IEz2M3D5mj5nFzTLJkc6fIEUPA9KOoTVRbvThrycywPaqeFQu1n/57Gqx6tp9TDUJCCGmJ+d8iI3nt59c4EYKw=
X-Received: by 2002:a05:6000:2893:b0:3a5:26fd:d46f with SMTP id
 ffacd0b85a97d-3a5723a2765mr15125652f8f.32.1750283981062; Wed, 18 Jun 2025
 14:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-10-a.s.protopopov@gmail.com> <CAADnVQKPbBRGOj2mB5Um80VFUh_vVg=oRJCdYUgyz_DrObuagQ@mail.gmail.com>
 <aFLR7NrdX3gbjC1s@mail.gmail.com> <CAADnVQ+nHemrEgeWYHxLi1UVeJ2u7DtSDTpcrPR7w2PgFPgQZw@mail.gmail.com>
 <aFLq/blfEEiIqXGz@mail.gmail.com> <CAADnVQK7M7L4j8ydo7GOFqZ4rbdJwg_Ghx6uNcD8SqMQnBbZCQ@mail.gmail.com>
 <aFMgvroYZapTkTSj@mail.gmail.com>
In-Reply-To: <aFMgvroYZapTkTSj@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 14:59:30 -0700
X-Gm-Features: Ac12FXweevxEIF-oeAZ_keR9jYCvP2ZcGeDaqg_bRWViFHsRDzYieIagzGmJArg
Message-ID: <CAADnVQ+H-OMe0rUGr63SEJpYT4MVv=j9=5hcDBShfCNKSHf+mQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 9/9] selftests/bpf: add selftests for indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 1:19=E2=80=AFPM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/06/18 09:43AM, Alexei Starovoitov wrote:
> > On Wed, Jun 18, 2025 at 9:30=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > On 25/06/18 09:01AM, Alexei Starovoitov wrote:
> > > > On Wed, Jun 18, 2025 at 7:43=E2=80=AFAM Anton Protopopov
> > > > <a.s.protopopov@gmail.com> wrote:
> > > > >
> > > > > On 25/06/17 08:24PM, Alexei Starovoitov wrote:
> > > > > > On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
> > > > > > <a.s.protopopov@gmail.com> wrote:
> > > > > > > +SEC("syscall")
> > > > > > > +int two_towers(struct simple_ctx *ctx)
> > > > > > > +{
> > > > > > > +       switch (ctx->x) {
> > > > > > >
> > > > > >
> > > > > > Not sure why you went with switch() statements everywhere.
> > > > > > Please add few tests with explicit indirect goto
> > > > > > like interpreter does: goto *jumptable[insn->code];
> > > > >
> > > > > This requires to patch libbpf a bit more, as some meta-info
> > > > > accompanying this instruction should be emitted, like LLVM does w=
ith
> > > > > jump_table_sizes. And this probably should be a different section=
,
> > > > > such that it doesn't conflict with LLVM/GCC. I thought to add thi=
s
> > > > > later, but will try to add to the next version.
> > > >
> > > > Hmm. I'm not sure why llvm should handle explicit indirect goto
> > > > any different than the one generated from switch.
> > > > The generated bpf.o should be the same.
> > >
> > > For a switch statement LLVM will create a jump table
> > > and create the {,.rel}.llvm_jump_table_sizes tables.
> > >
> > > For a direct goto *, say
> > >
> > >     static const void *table[] =3D {
> > >             &&l1, &&l2, &&l3, &&l4, &&l5,
> > >     };
> > >     if (index > ARRAY_SIZE(table))
> > >             return 0;
> > >     goto *table[index];
> > >
> > > it will not generate {,.rel}.llvm_jump_table_sizes. I wonder, does
> > > LLVM emit the size of `table`? (If no, then some assembly needed to
> > > emit it.) In any case it should be easy to add this case, but still
> > > it is a bit of coding, thus a bit different case.)
> >
> > It's controlled by -emit-jump-table-sizes-section flag.
> > I haven't looked at pending llvm/bpf diff, but it should be possible
> > to standardize. Emit it for both or for none.
> > My preference would be for _none_.
> >
> > Not sure why you made libbpf rely on that section name.
> > Relocations against text can be in other rodata sections.
> > Normal behavior for x86 and other backends.
>
> So, those sections are just an easier way to find jump table sizes.
> The other way is as was described by Yonghong in [1] (parse
> .rel.rodata, follow each symbol to its section, find offset, then
> find each gotox instruction, map it to a load, then one can find that
> the load is from a jump table, etc.). Just to be sure, is the latter by
> your opinion the better way (because it doesn't depend on emitting
> tables?)?
>
> Those tables are _not_ generated for the code I've listed above.
> However, in this case I can get the size of the table directly from
> the symtab.

Since Yonghong's diff did:
bool BPFAsmPrinter::doInitialization(Module &M) {

EmitJumpTableSizesSection =3D true;

and llvm did not emit jump table for explicit 'goto *table[index]'
I suspect it will be hard to fix.
Meaning libbpf cannot rely on a special section name.
So it makes sense not to force this mode in llvm
(especially since no other backend does it) and do generic
detection in libbpf. It will work for both explicit gotox and
switch generated at the end.

