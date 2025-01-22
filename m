Return-Path: <bpf+bounces-49493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA273A19710
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE3A3AB3FE
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEAC21516A;
	Wed, 22 Jan 2025 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9PviVkX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53F1527B1;
	Wed, 22 Jan 2025 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565354; cv=none; b=rauvdwW1QV7NBX9aS8NYTh0zeXadR3Y5nsdYqYGXU931czEqIx95oV29mfisNdeFv50k1++fVglj34jj8NT6nW06nkATev4CrfA2e2Fg00BAE0QdvpXpHGh8ziF8mwVvBBwDfe7xqMKL6lhqrc+kilgnvZNWHA+gigXgh+JUKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565354; c=relaxed/simple;
	bh=qII0OcQL3uVEtdhXOov0WSjojSDt1i39EyG+M6OTm4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J57uZOG5/qe+XdT/k/DvA2CnVNGnAqJmN+KlKP8/deTZR86R31K7DVZxjOYym1tBBE0s0Zh5GovvcnA+dJdN7XnYfS0tI8MJMy8wx9mCfH/PxHWt1VBMIPfeW+k4Puxb5bZs03HTOlQDhbgoVgAgELx9M3CfzhsU/kCTa21sQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9PviVkX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e0e224cbso3818877f8f.2;
        Wed, 22 Jan 2025 09:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737565351; x=1738170151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOBYe7hKKWrQVbbMlG221tX99JGFkXrB+lL0aGAMCbo=;
        b=b9PviVkXqRABVGYss6gR/EIsxQ8WvGLx1me6dJMYVOi67qAMh/IIbiFcgXbW5ZN+os
         2qVoW3jNSVrbOr9HfuI3KPYy+kvf20OqT2mwDxBZTJkkb2qIEVPJraRiFajR2hUzsMki
         nZqd+mhNn3j6R9EycJD8EBm6NIlDAj9jmi0Mj4GBKNl70qWkhUN0eY2YjzqzSvSOzvFX
         eXFZ+4qdDzxQcVUqtW3+hcWbo7DOCUBxM8VdKeHNobJRzDLGCGMOgBqT6xZLH3nhSIlU
         aXGikjjTReAZDEX+buI0UQXrNg7dUFTuq2HaIMtB57wRIwNu5+Yq2LBP3YcxQxkdcJYk
         oWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737565351; x=1738170151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOBYe7hKKWrQVbbMlG221tX99JGFkXrB+lL0aGAMCbo=;
        b=r869/gt+qIlE8QJfdlU+QT5He+GZpyfb1W7gUJtM8wuKcc5ncOHUPe/QgzZZ1+l5qT
         ygSmcddjlQl1azsGmXv/iPncGPHERRxAoX+Y0OaaDfvjEMPKebbhPPN6qs5gQIhd/sXq
         Poru17tFTgEHZ+eTE20j7R2b3EtXTO0e+ntJqio9aY8rlPETwpaX5zN+DAy0FU4A8qqB
         E4b+CUtJ246exG3qQxgz027SFRQ6y5cTh9qD7eMC6e/EwMPUcooBHATjKgWWwZEH5sXU
         8LbKpAVh1ZaESQpJfPlDA8UmcCSE8Tn4cSZu1J1bfDrd6nD5bYwdW8pv39BhfsycF/o6
         bPPg==
X-Forwarded-Encrypted: i=1; AJvYcCVOMWN+p/UMoJvCIwKUhN3e4UqBzm7sPqXx7Sh+BLYgG94Zi0AXqBJw2Bx4OguhB4iYOjVZNVcZecqzmKA7zg==@vger.kernel.org, AJvYcCVaS0hGO7KcVaeNpAgOE7vB9EWiO/K4DEldksSXdtL2wX332s2bXgEOAE0dPuLEkGAkv34=@vger.kernel.org, AJvYcCXYf9fjZY5w8R4YQnO5CRYq0aIcz83l25dRhzc80WplVnqZYdKG0ngpObnczzJb+eu7ZgfIb3xyleyDdEON@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJdyPqRvmVNV1/ZDCYN2WC2Y9c+dPR5cdZsiB4eoIyu55I1nV
	dCORb/PDmf/JcGFSLGzFO8tLFlN5vXaMHrHy9B8CAKsb9G2ZM/NSy1zn7KppQ03AZC82bXgxzOP
	VEfVEU0pUBe0qCl9ygj5kzQCKNDA=
X-Gm-Gg: ASbGncsj00OO/7pPIsGb/T9XWsUfYLQJrH4RSGUj1BKqW/lyWaiQ8wKb1RFrvOh0KoY
	I1LcqLeLsK08+qnHUrBH6sZSQyGOI398cPjYHtze+h7Ax+U4QKHFh0xErWL2a8+z2IBd+goGata
	UntWijHnU=
X-Google-Smtp-Source: AGHT+IEso7FyrlnWyoMakPOiYmt/PWGxB55N/abpHk+7pmcuierztBMBZu5jYE24VGcqprVRxSX7Xofsnoaoi/GZz7M=
X-Received: by 2002:a5d:4d8f:0:b0:38a:6807:f86 with SMTP id
 ffacd0b85a97d-38bf5662417mr15301581f8f.17.1737565350296; Wed, 22 Jan 2025
 09:02:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c@eucas1p1.samsung.com>
 <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com> <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
In-Reply-To: <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Jan 2025 09:02:19 -0800
X-Gm-Features: AWEUYZmVm4oP6wOtkq7sVcFiVog35GahkeJfBhYYmlM8eZhXpLkseZyiVq1qGeg
Message-ID: <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-modules@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, iovisor-dev <iovisor-dev@lists.iovisor.org>, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 5:12=E2=80=AFAM Daniel Gomez <da.gomez@samsung.com>=
 wrote:
>
> Add support for a module error injection tool. The tool
> can inject errors in the annotated module kernel functions
> such as complete_formation(), do_init_module() and
> module_enable_rodata_after_init(). Module name and module function are
> required parameters to have control over the error injection.
>
> Example: Inject error -22 to module_enable_rodata_ro_after_init for
> brd module:
>
> sudo moderr --modname=3Dbrd --modfunc=3Dmodule_enable_rodata_ro_after_ini=
t \
> --error=3D-22 --trace
> Monitoring module error injection... Hit Ctrl-C to end.
> MODULE     ERROR FUNCTION
> brd        -22   module_enable_rodata_after_init()
>
> Kernel messages:
> [   89.463690] brd: module loaded
> [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
> ro_after_init data might still be writable
>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  tools/bpf/Makefile            |  13 ++-
>  tools/bpf/moderr/.gitignore   |   2 +
>  tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
>  tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
>  tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++=
++++++
>  tools/bpf/moderr/moderr.h     |  40 +++++++
>  6 files changed, 510 insertions(+), 3 deletions(-)

The tool looks useful, but we don't add tools to the kernel repo.
It has to stay out of tree.

The value of error injection is not clear to me.
Other places in the kernel use it to test paths in the kernel
that are difficult to do otherwise.
These 3 functions don't seem to be in this category.

