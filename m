Return-Path: <bpf+bounces-37310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2189953CEA
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8C81F25EE1
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA3154425;
	Thu, 15 Aug 2024 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxN1pM8Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2078C24211
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758448; cv=none; b=LZTjGPAtL44fiLZJ/zqTf4FbR+Kkrxp4svWYxUKJN7aKkd22fvLQUx1S8u6WeLbeh+klit2W5H7HMnVpjLrlcwbV4UIio1sCAkMdf49UnWRc7T1vFS59q4QbS+6R2gaYAvtUiF53FzEMJYuUcbXQ77oU+X/zHlCjeZnkaf9ohHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758448; c=relaxed/simple;
	bh=51HRh+98iYKjvq4HS+MceQqHUGAFm5UAWCMLF+Lijis=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kQlyP5evruTTVH9zdcb7HIwjsvJHKxXC6x9RbbhHX3/UXGd8coPMAh9vb9Pns8Q4VxMGoUpgLsgFs0nAPyC1i2llYQ9tp1xqIMuVg1IClASW2g53082V4ckz36mN4Zqoz0gnmpAYwcLKlm6W17mGkZHYQVbVm/N7aYocxKLBoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxN1pM8Q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso1171599b3a.3
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758446; x=1724363246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sXEOG3xg2I55GL8zKb/FvuaNlfitQIKZZPOKCjYeoYs=;
        b=kxN1pM8QoApUHW4yYnLe63TsHYEbIT6bp+X/C7oGcVVQalgK0jwvNJvtT8tOFmHorv
         Rtjph/MxXy/Z1OXYHos/iGX9u//g92OMMH9a2ddYnDJnXf89w5BVgKzL3i0iNP5ixvjX
         BxfZ+ihnjqWNH5SUljHpJAtxxUaK/XLqdm5b6gH1DM0LAirfaVopm3dIelXvgh8mjhYm
         k7RU4x6b6IY2dUO4PtoQu4WgTEaY9O0/+StvhurqfMUSIfeu4f98wGk/FMy8bnXLjDfu
         WEKJnSGAUay6KBQyO91t9j6dXUKboAtaPtyJ8JR3N6pV1l9iu+h/i8ROX8ZR6VapfpEh
         UkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758446; x=1724363246;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sXEOG3xg2I55GL8zKb/FvuaNlfitQIKZZPOKCjYeoYs=;
        b=SBtoIm+XEPPXDUiKiQfK91gKkdIy5ZRGOLZnJWfWxlzfO8qAWLR5R5/zi5r6ZNJe7y
         nKrUMDvS47CBT865QpB1ArvESOK5zTCDaDcVlY1um4v/RHg+qijbICvh2ikZmwPKamIk
         ucC/VWbuMDgtc+G65gpb7WOArMX4VyngQBijVue4IwzOLKDc0jkSdRuUJ6nYTIMlhAqO
         XUrI2sEKwoOq3OqXjpJQvhJA4SS1rj6km/9KltPWeV/QGjgR8B35J4O6SdY9yN4sS1CR
         VxftiLmlwMFUb9EnjEKiXukLqSLNq/6/JQx+2F42v1ahpTDW2OMB3VyzNwelCrVhsAWE
         XPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbF5ScM+H4MEA7Ge/kBayYhGIS0UIVU5Z/36zLxgwHLb4JEFWGUSBYeGJndtrSaOciuhbf777xo7RWRtuiRIodrJwQ
X-Gm-Message-State: AOJu0YyqSzWp6YQ2wz/qlQintEYTTlm6M6b1OFZJCAc+hoY5eijMB+pN
	k7JCE46j5uXvdc0gL3JlrrQJGFpIX9PaKbvuu3kIIWpg/OGqtYoX
X-Google-Smtp-Source: AGHT+IGFPCgsChF1xeIJD4/wokaD9h0cWnqLUQarqozjbM/xSEh9UvRkEj38z89lBuzpAXXQckRFXA==
X-Received: by 2002:a05:6a00:194e:b0:710:4cf5:c570 with SMTP id d2e1a72fcca58-713c4bac640mr1218259b3a.0.1723758446386;
        Thu, 15 Aug 2024 14:47:26 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1f2cesm1445607b3a.181.2024.08.15.14.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:47:25 -0700 (PDT)
Message-ID: <f49cc01dfea19be0d287995e8bb539a14dd31cf1.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: validate jit behaviour for
 tail calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, hffilwlqm@gmail.com
Date: Thu, 15 Aug 2024 14:47:21 -0700
In-Reply-To: <78d7872d-4644-4a9a-9ef2-f4823fd7944f@linux.dev>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
	 <20240809010518.1137758-5-eddyz87@gmail.com>
	 <78d7872d-4644-4a9a-9ef2-f4823fd7944f@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 14:32 -0700, Yonghong Song wrote:

[...]

> > +__success
> > +/* program entry for main(), regular function prologue */
> > +__jit_x86("	endbr64")
> > +__jit_x86("	nopl	(%rax,%rax)")
> > +__jit_x86("	xorq	%rax, %rax")
> > +__jit_x86("	pushq	%rbp")
> > +__jit_x86("	movq	%rsp, %rbp")
>=20
> How do we hanble multi architectures (x86, arm64, riscv64)?
>=20
> Do we support the following?
>=20
> __jit_x86(...)
> __jit_x86(...)
> ...
>=20
> __jit_arm64(...)
> __jit_arm64(...)
> ...
>=20
> __jit_riscv64(...)
> __jit_riscv64(...)
> ...

^^^^
I was thinking about this variant (and this is how things are now implement=
ed).
Whenever there would be a need for that, just add one more arch
specific macro.

>=20
> Or we can use macro like
>=20
> #ifdef __TARGET_ARCH_x86
> __jit(...)
> ...
> #elif defined(__TARGET_ARCH_arm64)
> __jit(...)
> ...
> #elif defined(...)
>=20
> Or we can have
>=20
> __arch_x86_64
> __jit(...) // code for x86
> ...
>=20
> __arch_arm64
> __jit(...) // code for arm64
> ...
>=20
> __arch_riscv
> __jit(...) // code for riscv
> ...

This also looks good, and will work better with "*_next" and "*_not"
variants if we are going to borrow from llvm-lit/FileCheck.

> For xlated, different archs could share the same code.
> Bot for jited code, different arch has different encoding,
> so we need to figure out a format suitable for multiple
> archs.

I'll go with whatever way mailing list likes better.

[...]


