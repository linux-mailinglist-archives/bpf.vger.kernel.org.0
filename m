Return-Path: <bpf+bounces-20423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A183E224
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 20:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C612851FC
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 19:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3171822324;
	Fri, 26 Jan 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OINhW4IJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650AB1DDEA
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295977; cv=none; b=S1Wnv5eQVTJZO/WpifRoLlqkxG8zUsHZcuJHOk851jbR4r9mS+Nl1CxrtTG7QszDew1SyWmafbqqu3cXcA6yhKKN1wNUI1fgirkpKSCLlZ08MP2mlkd4BcmhT0lPS37LK2h0VZ0JQnsfJ9ElKX6cF2H3VdOBjvmHtTDPzr6mJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295977; c=relaxed/simple;
	bh=PcqfK2J3XSWwaC0K1qxEKuZy9BfOhjPkSB63fMuVpDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcP8SyPFdUFatp8StmNGW/AnETqgo36VA92zd428qTNoehzjEmullFTky2IkyKzNBe1FXjTKncyUjj59ASPAHQIJgH3LNspqp28JlWojwTKbPO21e9Mf32Nw8uIlzxeE963lA13GfOGvw4vk1pw87nsF2N3nwlTdmIhZE+a5KeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OINhW4IJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so572798a12.1
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 11:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706295975; x=1706900775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED3wYwBbrm2f6xpS2c691OQ+CYxvEMPnMgyUlfx6RnA=;
        b=OINhW4IJV4mSyGsfAEYIRscCNXrXBkaNxBQYPfuMw3GBazDkxtrjJp8n4N7eLGrvCM
         dxJqhwvBacZjfeRXfygoQ9zhlthStrWn1Pi99t/XaeAJuOOcuxbUullJ/IJ/Cs2jcDcA
         j2bsEHPTWB4Zxkx1TWRFXMHYGEOWdoQhwmjE59BUBktOH24Q9zGQaI4PaBrOiWmY+Dg2
         Z/uCQH5Iy1IB0kW0Rw2c2lolLfMNbxVzbB/1rle397dGrdSkg6Ntl4TgEZn1I825B+3j
         diaqEmLBOF+56iIhXdLtzah6Jqakh+l+qgVe64qgH/EKLz6WlQkQ4HPveetfANgUJ/0f
         HSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706295975; x=1706900775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ED3wYwBbrm2f6xpS2c691OQ+CYxvEMPnMgyUlfx6RnA=;
        b=GsF8newBNMlYSgNvb7RFCLdD05bvzNbGT11EYuT9rwroidZN3HPSBHQfhl3M2IgGpc
         WsBOTnlZwJKfvjLA8L5TX9ZlU1YQtRDdCFDB2GG4am1h42BCm7DGuFUCXBgh/lQaPCpL
         co7kzPcW1uRmWIU1rPVH52SlP/VR2f/uO3Zw+nCFj8vAt5OvtqFovmjjLqimyfzehWz+
         EiaQs/YsiLkn3afSHqTCNCPrZFUB4aoawSjkZyE8Nzz/aBaM4pCPxtvDwD0XFaxWWcP4
         TgfRn/fjr7Q+B4265sTBQ8fg3XwHNwGJxmS0HuBMbsrLBDDWcW1GjyPPcC5ysuC+3Gl9
         074A==
X-Gm-Message-State: AOJu0YymHS4OaSeild/NFa/B+kvRzkka6rbM8fcfmu7Mtq1yRzytaR3+
	22yE+Gy2C/VMhsG0HLQnoOBNbd30YquUPPPt7JKLxDqt71rITghYh5l++Pe8xwvAEnQuVqd/dDs
	Z6iNzXAhoSiga178BJwTWlxjGjLk=
X-Google-Smtp-Source: AGHT+IFkhjgNCy66wOcwynxwVNdXqGhV6gf3+H85edFJmkPYZaXPezz/no1/SCk0w1I35M+dqO3l4WAymP7eG6rheWo=
X-Received: by 2002:a05:6a20:2d0a:b0:19a:241d:d93f with SMTP id
 g10-20020a056a202d0a00b0019a241dd93fmr207639pzl.26.1706295975532; Fri, 26 Jan
 2024 11:06:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125205510.3642094-1-andrii@kernel.org> <20240125205510.3642094-3-andrii@kernel.org>
 <3223cf369859b119914403664f549d1fb20bc644.camel@gmail.com>
In-Reply-To: <3223cf369859b119914403664f549d1fb20bc644.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jan 2024 11:06:03 -0800
Message-ID: <CAEf4BzY8XoPmHCTzp=THQr+kYpXGo5G9hLwzJWGSquFt-DZHnw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/7] libbpf: fix __arg_ctx type enforcement
 for perf_event programs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 5:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-01-25 at 12:55 -0800, Andrii Nakryiko wrote:
> [...]
>
> > @@ -6379,11 +6388,21 @@ static bool need_func_arg_type_fixup(const stru=
ct btf *btf, const struct bpf_pro
> >       /* special cases */
> >       switch (prog->type) {
> >       case BPF_PROG_TYPE_KPROBE:
> > -     case BPF_PROG_TYPE_PERF_EVENT:
> >               /* `struct pt_regs *` is expected, but we need to fix up =
*/
> >               if (btf_is_struct(t) && strcmp(tname, "pt_regs") =3D=3D 0=
)
> >                       return true;
> >               break;
>
> Sorry, this was probably discussed, but I got lost a bit.
> Kernel side does not change pt_regs for BPF_PROG_TYPE_KPROBE
> (in ./kernel/bpf/btf.c:btf_validate_prog_ctx_type)
> but here we do, why do it differently?
>

Hm... We do the same. After this patch w end up with this logic on
libbpf side (which matches kernel-side one, I believe):

for KPROBE =3D> allow pt_regs (unconditionally)
for PERF_EVENT =3D> allow user_regs_struct|user_pt_regs|pt_regs,
depending on bpf_user_pt_regs_t definition on host platform

That should match what the kernel is doing.


> [...]

