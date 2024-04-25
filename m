Return-Path: <bpf+bounces-27837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7208B281F
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361161F21959
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC4014F10D;
	Thu, 25 Apr 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/PDM/Or"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6AE37152
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714069233; cv=none; b=sZIWK/XSk33Diz1UULNfULan/ioujzMWmLUMWXrhIxG2coCKtsjIkCdhTxBe/LS1aGM+4d+y2KANCDVpPGSOpDdBmgKDlhbcXbAC93yq7KPF6GRajJp2NPJeBT2VFCI2ptBXw6Y2uq5pnaUAOTILVU9/87ax+T85/FOu9wE4VR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714069233; c=relaxed/simple;
	bh=z+WgMCnIYMWy4WyilqO817zADzZESezWnkKGNwqrFgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbHQ03riEs8BGLVkYk9AfHSaBUYobiN7/DrHdnht2I4rQfaBBoMGNkFFcE5/mQGiVNUiEIoMI1I16OirKYRUfaYpM9Rg26MZVcGoMYtyR6HSod9UeO6nco8c8fcY9X4Fy5roPFODNoKrNVXsV1yKUyklHd+mhFAaiUEnznGryo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/PDM/Or; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eab699fcddso8890945ad.0
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714069231; x=1714674031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnGEyqWzcbZF6GNO0j1SyNDKJv0STUKffdj+NAUOSKg=;
        b=K/PDM/OrGN+eO/JhTERsMgvhX61Cqq0tqL4IQCzLtBNBceeq4rvuZNymgDklnS0S+y
         zLdVgMA1SG45Z0qh3c0HcM8/lY+TnaX6nBWM98CXk1fxmt24lksvanFfTBp6jfBxiJjB
         be/DcT75C18E0/Z4W/uIT5JKBJFpFDKXh3Ujek8XoV/WN5tPFV5bld7ksa9TsJnjdQfJ
         NgDEqduVLQJHlyEcTRq88pSaH5YZj8YPg8EouiHicetLiEL5JcJIKYWBjbpfEwcaxFID
         pYGm37xAC8MQOMELxONYZ6zpGMU95pX2epvsMyjgSsSPYYZbDT6m+VbQMFvZJgpi+Fex
         Gg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714069231; x=1714674031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnGEyqWzcbZF6GNO0j1SyNDKJv0STUKffdj+NAUOSKg=;
        b=IJZ+jy3sxdc+DhRRgYgIwoOYB9PnmetGc50LbVGXK6IBhDMmYD+qaHCGm1fNZwrD3L
         64t3gn4+tgRzqLN/UPRxLE0iEjGFzCVS0C3n8+5siGsMWNkcROxN2jXPLdqC/8Xyj8zs
         7H6ATZTb0pNm7TrUHkJ7w6V/TX8+WdHGjdaiPSXc16236IbQbbdlHNYjmp0giS+m5GGV
         WbkWVGrg0CLdyj9UWqGgvG5GsURtoI8WdkOYt+TqBPrMtGRTAZfAHEVOmHwi4fKR9LFh
         nvkDzrwlZPlwRVNzDOPuI93eHb+6Z9H4ftIQKBSlFcJI8ysIOOkSLlnG3FeeGpK72Owu
         RcFg==
X-Forwarded-Encrypted: i=1; AJvYcCVSbHZTPFI2KzRQJwiMPVkQIXtXwGEGhWx2aqX0j+Hd7Z2emUPN9PEyjDafSNQs+joe+ufWgP9jwk269Vz2LWLNh2if
X-Gm-Message-State: AOJu0Yznm10pufWr74+8JHNB2U9DW7n5zMoxuVhl/8ZtgfPEIi19Wmw4
	qt+wOJMYb5/j/PfWihqQbcVak3ESaHDVUUmQk7un/A4Og09kt7neL/3BS4cvaqlgSEkO969xzBJ
	8syaQaIu0tHv1D9v51mq/6q27tRY=
X-Google-Smtp-Source: AGHT+IGQy/xvmXv+lxXQ7jASyi11PP+aZTgNBzGCupvoR5CIWCnxU7WgUWd7hzArsWeFP++Bqp6HPQCR8SdQUnwUins=
X-Received: by 2002:a17:902:d491:b0:1e4:c09:7f37 with SMTP id
 c17-20020a170902d49100b001e40c097f37mr382058plg.54.1714069230934; Thu, 25 Apr
 2024 11:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424084141.31298-1-jose.marchesi@oracle.com>
 <744420fb-4b2b-44c8-9e35-1ffd9f086fd9@linux.dev> <87v8465u8p.fsf@oracle.com>
 <CAADnVQJzLzrxtHeVcpNBtb-rnwWfApFEy_kv7LzWDee4pH1ezQ@mail.gmail.com> <87a5lh4o7r.fsf@oracle.com>
In-Reply-To: <87a5lh4o7r.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 11:20:18 -0700
Message-ID: <CAEf4BzZqHHx22c=k88A4oa3+afQvk6ph6SB4Zq1tHJ1sOhpv8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in selftests/bpf/Makefile
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Faust <david.faust@oracle.com>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	indu.bhagat@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:33=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Wed, Apr 24, 2024 at 2:30=E2=80=AFPM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >>
> >>
> >> Hi Yonghong.
> >>
> >> > On 4/24/24 1:41 AM, Jose E. Marchesi wrote:
> >> >> This little patch modifies selftests/bpf/Makefile so it passes the
> >> >> following extra options when invoking gcc-bpf:
> >> >>
> >> >>   -gbtf
> >> >>     This makes GCC to emit BTF debug info in .BTF and .BTF.ext.
> >> >
> >> > Could we do if '-g' is specified, for bpf program,
> >> > btf will be automatically generated?
> >>
> >> Hmm, in principle I wouldn't oppose for -g to mean -gbtf instead of
> >> -gdwarf.  DWARF can always be generated by using -gdwarf.
> >>
> >> Faust, Indu, WDYT?
> >>
> >> >>
> >> >>   -mco-re
> >> >>     This tells GCC to generate CO-RE relocations in .BTF.ext.
> >> >
> >> > Can we make this default? That is, remove -mco-re option. I
> >> > can imagine for any serious bpf program, co-re is a must.
> >>
> >> CO-RE depends on BTF.  So I understand the above as making -mco-re the
> >> default if BTF is generated, i.e. if -gbtf (or -g with the modificatio=
n
> >> above) are specified.  Isn't that what clang does?  Am I interpreting
> >> correctly?
> >>
> >> >>
> >> >>   -masm=3Dpseudoc
> >> >>     This tells GCC to emit BPF assembler using the pseudo-c syntax.
> >> >
> >> > Can we make it the other way round such that -masm=3Dpseudoc is
> >> > the default? You can have an option e.g., -masm=3Dnon-pseudoc,
> >> > for the other format?
> >>
> >> We could add a configure-time build option:
> >>
> >>   --with-bpf-default-asm-syntax=3D{pseudoc,normal}
> >>
> >> so that GCC can be built to use whatever selected syntax as default.
> >> Distros and people can then decide what to do.
> >
> > distros just ship stuff.
> > It's our job to pick good defaults.
>
> Yeah it was a rather dumb idea that would only complicate things for no
> good reason.
>
> The unfortunate fact is that at this point the kernel headers that
> almost all BPF programs use contain pseudo-C inline assembly and having
> the toolchain using the conventional assembly syntax by default would
> force users to specify the command-line option explicitly, which is a
> great PITA.  So I guess this is one of these situations where the worse
> option is indeed the best default, in practical terms.
>
> So ok, as much as it sucks we will make -masm=3Dpseudoc the default in GC=
C
> for the sake of practicality.
>
> > I agree with Yonghong that -g should imply -gbtf for bpf target
> > and -mco-re doesn't need to be a flag at all.
>
> We like the idea of -g implying -gbtf rather than -gdwarf for the BPF
> target.  It makes sense.  Faust is already working on it.
>
> As for -mco-re, it is already the default with -gbtf, and now it will be
> the default for -g.
>
> > Compiler should do it when it sees those special attributes in C code.
> > -masm=3Dpseudoc is a good default as well, since that's what
> > everyone in bpf community is used to.
>
> We will try to get all the changes above upstream before GCC 14 gets
> branched, which shall happen any day now.  Once they are in GCC the only
> extra option to be added to GCC_BPF_BUILD_RULE will be -g.  Will send an
> updated patch then.

-g is already passed through common BPF_CFLAGS, see Clang rules, you
won't see explicit -g, but it's there (all those flags are passed as
$3 argument)

>
> Salud!
>

