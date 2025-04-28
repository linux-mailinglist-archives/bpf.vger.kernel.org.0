Return-Path: <bpf+bounces-56870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A626FA9FAC7
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 22:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02186464E18
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11831F4720;
	Mon, 28 Apr 2025 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRdyeGBZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21DB101C8;
	Mon, 28 Apr 2025 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873520; cv=none; b=kEezUe8J638S4vcmf5n+DmImXKd+RT4c1fYBv4/AIDbw6wsZFo8PM9iXcWSjz3sAVFrM/QnYE0UkxHfHeJ8mCqK13DwF24vmZ1IMf4xifAGVxsB1eck58b9Za53mpGyUEAbUteIS5Iu7vTyRUfkOfLv9qqhhr8A2z4wOVN4r5DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873520; c=relaxed/simple;
	bh=o8f0HJnyQyuQnDskvFI4YYim73bBglpvcujhzltdE2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQKxusZKzTrfsA4GbO3xX2NucqKrv3nltIJ9cTsVyek48BM6lJVBPBQbwskaLKY31SMtjInZMCE3TkaeDoIZIHzToG5HwZWq3nYIXvzb8UoNgRibSiTyaHw49ROMu4qHAThEtzibBZrthXrQV4BH/7ZrnEcZCmbK2nyb/FWGmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRdyeGBZ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso6212800f8f.0;
        Mon, 28 Apr 2025 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745873517; x=1746478317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/5eVQAfEAmYqimzL4pb9uZj3Ovus2eKagdjKqZf52U=;
        b=lRdyeGBZhjk/9jERh7h2m34buy1L7FSXG6/xFpmDqy1FYx9VSwmM9THQ8FhMupDMCb
         g+pMVxZ9L/67qUSqFeaUT4vAn5SV7LQbmAlvs7MV9NOho4lFn0BnxoWo59fTfFPDEb1R
         vrM7O1S6vN6m0VxALt6UsZ9UcI3cPrRKk8elBqHLikcxc4/LIPRfU72PfU6ms5MGj/Z/
         6LvQg69Rmi1K+G1YaRmqMukKRN+HVaKK9dr0ZLGckWLOWKOM3PiYUoQyCUJsdBSpGvMW
         qpAGABLqGpBjOGd6TlZczH1kpTl562RZL+yHImN1I4qY6cJvomQcwOE2UnEDGj2KgGZ4
         7/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873517; x=1746478317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/5eVQAfEAmYqimzL4pb9uZj3Ovus2eKagdjKqZf52U=;
        b=FyQa8Kr8pol0sjjh0Xr//O3ERs90++OmzAwc78lqtCk8BqgM/6Uwn/InLDoixxcPfv
         ByZWrsfR8yP3FP5izp9ujsf8AJ7q8SPEtteVXcXOrsl1MHsOBQtAvrLrXPTD2qrror3C
         1Bsm3d5xBopEEq5AdcPZ0yyAQnnSzIYPl0jCfswgZkgywBivTmI68ERQO/7Dly1vE7ve
         p1M2sqg1ptXVpfoL6Z2OMHVcNiQqzzuJykwCsB6EflpReOGAJUKB7ysmnFem1l1I9LwS
         8kuyUSBSepvPIMoxXZx1qGUB4IuKs5kDxvvQ/oJJxsRLI3XrXfgQa6jg1GvsDtiCotRt
         6ZYA==
X-Forwarded-Encrypted: i=1; AJvYcCW7SK3PHCn5VJjhbbsfC/oehWCsKK6Rdxw0h8d5tqHYlUwBvw2e6exnWo3CcsC7IBXFWeErwC2bkg==@vger.kernel.org, AJvYcCXgklZ7OCe60l62r+1JFHz3eyoHjL3zq/KoHcylJXm/IAd9RDvPB5/bPGa/38WMiHriHns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTMdjwO0SewA7xYd5o7KZzwXnwL3EGZbqAtrVc4KbytB7iz6hN
	dPP9hWR/ClR38Bs4KE3Cizvu7kMf7t0emW+wA7kUYd7trUkDW6NgUW2QbGX205dukPNLMOE+f1e
	y3uM1KoLuDDlqIQMiTDjWF9JUApg=
X-Gm-Gg: ASbGncshtadHjGn21/6+dJzhRE4f8gGyLxwBCdN4Ybsbyliq6t9QUZNi0wPdD/TVs4g
	tcjBax24WomlOojCvrjDXB1zcVOWtqXKykkM6jS2GLuRxJlWbKHIpHBMHRGEmaQPgyx6MvAVetZ
	nsVuRByMqJQbkGLPA7dUP5Q5DG2nzh++A0CF5GtQ==
X-Google-Smtp-Source: AGHT+IEIunVHoKcJ+Npb/7qUKwcr9CNRB+2faTDZucDDC0Z7NgOVHyhvv5YcjECnxt4r46qg+Jko0o0ogcieCGCRQOw=
X-Received: by 2002:a05:6000:4305:b0:390:e62e:f31f with SMTP id
 ffacd0b85a97d-3a08ad2b5e3mr128195f8f.3.1745873516943; Mon, 28 Apr 2025
 13:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com> <fcjioco2rdnrupme4gixd4vynh52paudcc7br7smqhmdhdr4js@5uolobs4ycsi>
In-Reply-To: <fcjioco2rdnrupme4gixd4vynh52paudcc7br7smqhmdhdr4js@5uolobs4ycsi>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Apr 2025 13:51:45 -0700
X-Gm-Features: ATxdqUH5zld_m0cG4z3u3S4RDm0rug81Nl7H7VgQCZMUzqgDLxAnDpvHFiWXbh4
Message-ID: <CAADnVQJ1y1ktKDgORynENQLC73FZ162XXL2qMSshpb2gKXHBjw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ttreyer@meta.com, dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Song Liu <songliubraving@meta.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Mykola Lysenko <mykolal@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 11:41=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> > We propose to re-encode DWARF location expressions into a custom BTF
> > location expression format. It operates on a stack of values, similar t=
o
> > DWARF's location expressions, but is stripped of unused operators,
> > while allowing future expansions.
>
> A stack machine seems overkill. I'm certainly not an expert on DWARF
> location expressions, but I think we need to get away from arbitrarily
> complex expressions, even if they are simpler than DWARF ones. I don't
> think we want consumers implementing any kind of interpreter or VM.

+1
This was already brought up at lsfmm.
stack machine in BTF is not an option.
I see the appeal of simple inline_encoder__encode_location() logic
that takes dwarf VM and re-encodes things pretty much as-is.
This is a wrong trade-off.
pahole side needs to do full expression analysis and emit
easy to parse location expression.

> >  ID | Operator Name        | Operands[...]
> > ----+----------------------+-------------------------------------------
> >   0 | LOC_END_OF_EXPR      | _none_
> >   1 | LOC_SIGNED_CONST_1   |  s8: constant's value
> >   2 | LOC_SIGNED_CONST_2   | s16: constant's value
> >   3 | LOC_SIGNED_CONST_4   | s32: constant's value
> >   4 | LOC_SIGNED_CONST_8   | s64: constant's value
> >   5 | LOC_UNSIGNED_CONST_1 |  u8: constant's value
> >   6 | LOC_UNSIGNED_CONST_2 | u16: constant's value
> >   7 | LOC_UNSIGNED_CONST_4 | u32: constant's value
> >   8 | LOC_UNSIGNED_CONST_8 | u64: constant's value
> >   9 | LOC_REGISTER         |  u8: DWARF register number from the ABI
> >  10 | LOC_REGISTER_OFFSET  |  u8: DWARF register number from the ABI
> >                            | s64: offset added to the register's value
> >  11 | LOC_DEREF            |  u8: size of the deref'd type

LOC_END_OF_EXPR shouldn't be there. This is just an artifact of stack VM.
I don't see patch 3 using LOC_DEREF.
register vs register_offset is another artifact of dwarf.
It looks to me we only need:
- register
- load_from_reg_plus_offset
- constant

>
> I think supporting fully inlined functions as part of this work would
> add a lot of value to users. It doesn't necessarily have to happen in
> the first patchset, but we probably want to plan on doing it.
>
> Regarding BTF, another option is to just leave `callee_id` unset, right?
> Consumers should be able to recognize BTF for the inlined function isn't
> available and then act accordingly. For bpftrace, that probably means
> not allowing function argument access.

For fully inlined we still need callee_id otherwise bpftrace won't know
argument types. It shouldn't be hard to emit btf even for fully
inlined functions, but we need to be smart not to bloat BTF to dwarf sizes.

