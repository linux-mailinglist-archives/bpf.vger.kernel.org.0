Return-Path: <bpf+bounces-20504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFDE83F2A6
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 01:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067F91C22236
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 00:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E99B10F4;
	Sun, 28 Jan 2024 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a3bvGxTH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572D0EC2
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 00:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706403206; cv=none; b=J7jTiLdmkXZsPNEGO13B4tiF9S/TBhzNe0d5989XQ/48itUE0ujrxg7d2F5yQS+NO0ZIUZVw8Ih//KRHbOpyCNQyx+MOKodEe6yLp+frLDO9XA+gJ71tfBA31lEvj4FYnVGyARNrZQz3UG69R+TnV0HpNDsfYGqnV68TW65ZVqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706403206; c=relaxed/simple;
	bh=YK7baQj10g0Fylli6PPy1P7kIOdyiGQ+8VHC48FOMs8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cl1enLGoYPVgX5XNfSxT/bfaUacd5FoMH3W6rpkq0rdyjxRNNjZvJdF5lsR2aZP0LI9B0vfmUvlpXJc4hKzIAXijWwwVTblBJLmq4k/ARnaxaiFBJk1I4GJbFV2bYycG7srvUC3/HK1P3drOhyhY4jwASnTmOagg2Nto7BEhTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=a3bvGxTH; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bda4bd14e2so1287695b6e.2
        for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 16:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706403204; x=1707008004; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Im7YhTaYRhDehpNrv3eU0xpPSS7YJXBfNuKMWuSHYY=;
        b=a3bvGxTHNw4dkowZmyC3SDTrzhlg7fam7i50oLVdfvLnuFjotrWUU59lcilsCWjTxg
         9URDx+y2jC29sjS7FHKzVtgQcbp+c8Dwk1NH3nEo85vjv29MhSNqvtUISeHurj4mN0g1
         TJhykPEuzQRG2mCITPc8xKNQkIyE1C8usMUI9j+T/zc4ShbWzPY7TES410uH0pQLB8bw
         54Yw64AhuS8CR6xlPvJCibaHOWuegzXbkYHEXii6AL4hn5HiwoLd9FjB9+oWjX6Om3X6
         3Btytxq0Hddqhbn4TG4IMMaWlgTFQCP+HUgo9LvSOvw1qfZkqPUkxkBDhakkSDb+lsXd
         E2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706403204; x=1707008004;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Im7YhTaYRhDehpNrv3eU0xpPSS7YJXBfNuKMWuSHYY=;
        b=IQqfOPjEIj2M2uU4SQXNtxXzrghY5ev/7v/zVlvKtxpYtvFoVLwBhxVrtk+Sf8vr6P
         MbSFvETcL0a3qjsXwwwuh7ME33W8vklF91Xc3CT5QVKcdI6AVXD+CePebqNcxjeGXic+
         n26YOyXEWMoPNtD7Ikc1rTZ2q6CUL+wn63taFq5OYAcmiZaLYczLV1/k76t5CHJlozYq
         YXUpm5trDLBx4qQx0stjtfRDERhwp/Czcj9ppVMf4J0t2QfshDGnrHo8bWVYh5ybwhb5
         DaLyqPBMQ23msTWdZKUWxnztCykdlgDfQCu/LrmoHgSB41grvZel7K5zBegXoDBXDbnW
         fg8w==
X-Gm-Message-State: AOJu0Yy1iOQcLE0aSbyE4qS/4IVgUCYcDaq4ink2AkgD8RRVDO3rTARa
	9+pEXlNE46fEEEIvMUM4ojD5y6giaKqI1+JIUb27LZmVgr+VGQER
X-Google-Smtp-Source: AGHT+IHdJRFravhNWRefXc0X8EJicmnodKw1jgAfDrhh1WVi+obZflBJMLaOfcC3Q1GzQLTxZyim0w==
X-Received: by 2002:a05:6808:399a:b0:3bd:e016:c2c9 with SMTP id gq26-20020a056808399a00b003bde016c2c9mr5396026oib.7.1706403204136;
        Sat, 27 Jan 2024 16:53:24 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id b1-20020a62cf01000000b006d9c65cc854sm3488170pfg.26.2024.01.27.16.53.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jan 2024 16:53:23 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <006601da5151$a22b2bb0$e6818310$@gmail.com> <0c3d023f-0f19-47c3-8615-6c1ec006e2d8@linux.dev>
In-Reply-To: <0c3d023f-0f19-47c3-8615-6c1ec006e2d8@linux.dev>
Subject: RE: ISA: BPF_MSH and deprecated packet access instructions
Date: Sat, 27 Jan 2024 16:53:21 -0800
Message-ID: <018901da5184$647f7ae0$2d7e70a0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI/mTVZUZpeNhzShIl9oGl01BkM9QIYN44CsBMUalA=

> -----Original Message-----
> From: Yonghong Song <yonghong.song@linux.dev>
> Sent: Saturday, January 27, 2024 4:27 PM
> To: dthaler1968@googlemail.com
> Cc: bpf@ietf.org; bpf@vger.kernel.org
> Subject: Re: ISA: BPF_MSH and deprecated packet access instructions
>=20
>=20
> On 1/27/24 10:50 AM, dthaler1968@googlemail.com wrote:
> > Under "Load and store instructions", various mode modifiers are
> documented.
> > I notice that BPF_MSH (0xa0) is not documented, but appears to be in
> > use in various projects, including Linux, BSD, seccomp, etc. and is
> > even documented in various books such as
> >
> https://www.google.com/books/edition/Programming_Linux_Hacker_Tools_Un
> > covere
> >
> d/yqHVAwAAQBAJ?hl=3Den&gbpv=3D1&dq=3D%22BPF_MSH%22&pg=3DPA129&printsec
> =3Dfrontco
> > ver
> >
> > Should we document it as deprecated and add it to the set of
> > deprecated instructions (the legacy conformance group) like BPF_ABS
> > and BPF_IND already are?
> >
> > Also, for purposes of the IANA registry of instructions where we =
list
> > which opcodes are "(deprecated, implementation-specific)", I =
currently
> > list all possible BPF_ABS and BPF_IND opcodes regardless of whether
> > they were ever used (I didn't check which were used and which might
> > not have been), so I could just list all possible BPF_MSH opcodes
> > similarly.  But if we know that some were never used then I don't =
need
> > to do so, so I guess I should
> > ask:
> > do we have a list of which combinations were actually used or should
> > we continue to just deprecate all combinations?
> >
> > As an example,
> > =
https://github.com/seccomp/libseccomp/blob/main/tools/scmp_bpf_disasm.
> > c#L68 lists 6 variants of BPF_MSH: LD and LDX, for B, H, and W (but
> > not DW).
> > Other sources like the book page referenced above, and the BSD man
> > page, list only BPF_LDX | BPF_B | BPF_MSH, which is in Linux sources
> > such as
> > https://elixir.bootlin.com/linux/v6.8-rc1/source/lib/test_bpf.c#L368
>=20
>  From kernel source code (net/core/filter.c), the only supported =
format is
>     BPF_LDX | BPF_MSH | BPF_B
>=20
> The insn (BPF_LDX | BPF_MSH | BPF_B) is only used when cBPF (classic =
BPF) is
> converted to BPF insn set. If the current BPF program has this insn, =
verifier will
> reject it and bpf kernel interpreter does not support this insn =
either. So
> technically, (BPF_LDX | BPF_MSH | BPF_B) is not supported by BPF =
program.
>
> > So, should we list the DW variants as deprecated, or never assigned?
> > Should we list the H, W, and LD variants as deprecated, or never =
assigned?

Thanks for confirming.  I think the doc is ok as is for this part.

> > What about DW and LDX variants of BPF_IND and BPF_ABS?

What about this question?

Dave


