Return-Path: <bpf+bounces-20433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0331B83E53B
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 23:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FD91C23358
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 22:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02325250F1;
	Fri, 26 Jan 2024 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBGNnOZe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319441869
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307711; cv=none; b=CTUPhUbZ7usAytHGuTiC8URJeXw+UjavWESTx5kDxF2oBqIGeesoC//pkA86Vdkj9tvA3xbqLuvVnnjzEQ+KZLzcy+PFTJliufdK4vqcE9lxsvN084Ln1Ss9r96MhCbwiTihqabWj97EkGuTNzl2Hm6gGXdtRovKA2vkn3IGZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307711; c=relaxed/simple;
	bh=l+j/aWY1Lh7TJ56SHyZ+9pdNloVm58ZUN6mU5iEVVJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsGTAzHDSMd7ylXlsrL7AwrFM96SsQo2t9K63a9JsKhuh5bEPKEQwVqg/Gh9FAaYfwiTjnOMwNHcBadwiSQkwwseQgi3Gu15dwgth7dFWpYE3xQQQK0VHsaXMc98/7xtosa9KHioZNDuNH5jSvknuOWOxdKdri4AGSq3R+IWMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBGNnOZe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ddd19552e6so562983b3a.1
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 14:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706307709; x=1706912509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psiNLHwz3C6n7nD33U3XoxwynNuZMXeBi7Sm6Pw1I/s=;
        b=jBGNnOZe0AwfpjE8I2UETJEnip2GMEc0QCvyeBclHEAMmxOeLwhiGrPJJ153NqSF0T
         mIVTt0alVesLlgDik0qHbtxAIe2KKrqWluQ+AGhYX2A6GxzsRNm3gPgZmjwnjWTWPDPF
         XZtjnmFEvTXPUmG3RWheeyESI6IGoqSibMKu21yZlAv53FvHbkD5tFEA+2qWJatRP0Eu
         SqF9J0y5N5saQ3n23AAJy7zSpjoklloV/rMeM7dYW5wqyCiIg3WlHtALS6E2fRGMrOMy
         gzzftrqeqzFIqm9wEilc1MF0XsgSmUJfH9VWO2BLpmUh/8qJ1bPiGVq1nHkijn4G6yBe
         S9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307709; x=1706912509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psiNLHwz3C6n7nD33U3XoxwynNuZMXeBi7Sm6Pw1I/s=;
        b=BOUNy/pyD+c08J24ov+L0FYLe8/rH0JdFB1f6Z3hrlwFuQDXCJg2IU38tiViSUoh5t
         qy92e48Lf1aLrYn5yeN5wbHMkVEArxPICvZ1CbwcuM7/t4QPxHoe9Zwj4KBOy4xFaiUB
         5xLwSkGyBw3O9WI/nKx4IxnbuZxkyjbUsEWhe0DfdcJJL5t2THexTLuLgG0BLY4axbaq
         enid5LKnMrlyY5pSxet7c/MW+jKX8iQnidrgjZ4n/y6NaIFCcwu2xXx4m3OHfU2RwPRI
         bWJ9bnoR4J9fLw7UvwsgZ2EOBFxNWmjReEo+gReUdmcFEPx/WrEH1h2Ew1ml5bMTYAYy
         EwWQ==
X-Gm-Message-State: AOJu0YxLRiop5200UGkvWBk3vGvfMqs2fj7ywKEXJrJA1GnytAjGWN0b
	Lvi1CLHaD7yjUCJg2HRfWZN4NmvjDcBW+K9mvg71v5tj1G5NNhZak3kun9ysZK5sYDwtFB3uyfa
	fADCY9XFMpkdiScRAYmowMl0BSRM=
X-Google-Smtp-Source: AGHT+IGgGGKWulkm32z48chygTGaHge8RuVyB6peaOH19HHQyFzqRc761IwVYsd3inKtK2Voq4RX9G5G/xTiOvpCzzs=
X-Received: by 2002:a05:6a00:6807:b0:6dd:c1f2:8ae4 with SMTP id
 hq7-20020a056a00680700b006ddc1f28ae4mr695147pfb.14.1706307709406; Fri, 26 Jan
 2024 14:21:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125205510.3642094-1-andrii@kernel.org> <20240125205510.3642094-3-andrii@kernel.org>
 <3223cf369859b119914403664f549d1fb20bc644.camel@gmail.com>
 <CAEf4BzY8XoPmHCTzp=THQr+kYpXGo5G9hLwzJWGSquFt-DZHnw@mail.gmail.com> <63c28870a70aceed3385b2c018880399f32357df.camel@gmail.com>
In-Reply-To: <63c28870a70aceed3385b2c018880399f32357df.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jan 2024 14:21:37 -0800
Message-ID: <CAEf4BzaLjinKfxuOa0SHtK3Vx10WeVxdit2qYxaZ7hOwHLa5NQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/7] libbpf: fix __arg_ctx type enforcement
 for perf_event programs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:32=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-01-26 at 11:06 -0800, Andrii Nakryiko wrote:
> > On Fri, Jan 26, 2024 at 5:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Thu, 2024-01-25 at 12:55 -0800, Andrii Nakryiko wrote:
> > > [...]
> > >
> > > > @@ -6379,11 +6388,21 @@ static bool need_func_arg_type_fixup(const =
struct btf *btf, const struct bpf_pro
> > > >       /* special cases */
> > > >       switch (prog->type) {
> > > >       case BPF_PROG_TYPE_KPROBE:
> > > > -     case BPF_PROG_TYPE_PERF_EVENT:
> > > >               /* `struct pt_regs *` is expected, but we need to fix=
 up */
> > > >               if (btf_is_struct(t) && strcmp(tname, "pt_regs") =3D=
=3D 0)
> > > >                       return true;
> > > >               break;
> > >
> > > Sorry, this was probably discussed, but I got lost a bit.
> > > Kernel side does not change pt_regs for BPF_PROG_TYPE_KPROBE
> > > (in ./kernel/bpf/btf.c:btf_validate_prog_ctx_type)
> > > but here we do, why do it differently?
> > >
> >
> > Hm... We do the same. After this patch w end up with this logic on
> > libbpf side (which matches kernel-side one, I believe):
> >
> > for KPROBE =3D> allow pt_regs (unconditionally)
> > for PERF_EVENT =3D> allow user_regs_struct|user_pt_regs|pt_regs,
> > depending on bpf_user_pt_regs_t definition on host platform
> >
> > That should match what the kernel is doing.
>
> Oh..., I see:
> After (and before) this patch on libbpf side for KPROBE/pt_regs
> need_func_arg_type_fixup() would return true,
> thus bpf_program_fixup_func_info() would apply type transformation
> (convert it to bpf_user_pt_regs_t).
> And kernel before the arg:ctx series expected bpf_user_pt_regs_t
> for global subprograms called from KPROBE programs,
> hence old kernel would accept program with KPROBE/pt_regs
> thanks to libbpf manipulations.

Yep, with libbpf it's always a "time travel" kind of thinking, taking
into account old kernels.

>
> I was put off by need_func_arg_type_fixup() returning true,
> thus requiring change, and btf_validate_prog_ctx_type()
> just accepting pt_regs =3D> not doing anything.
>
> Thank you for explaining.

Well... I didn't explain all the above, you pieced it all together yourself=
 ;)

