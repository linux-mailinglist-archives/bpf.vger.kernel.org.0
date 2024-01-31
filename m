Return-Path: <bpf+bounces-20846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B58445B6
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682D71F21A3E
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C7612BF31;
	Wed, 31 Jan 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKUtBu03"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A062E851
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721009; cv=none; b=ZhXrw+LTW/7DLRWd4NjdFzSXxjnW4Xu8Zga7RpiXJZ9nntdY8gpUdfeBVib5aqh+XeBPB8n8IxHW0HL5XTa4M47mWjcM+tRjeAlKzjRxc0HuoIvMXa0D/DN84VSMaZu6Ek7tSHF3pk1Ea89HGFXnVQn9RRSo0T7a801nkOmHwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721009; c=relaxed/simple;
	bh=xbcr4P3D0nqx90KjjdnL288VemTyylOVPfuafJ7rc28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9xkcb4+rJocj4Z735pFBCFwkn9iwY5EbdBPJd1kN32NP0r7QONGBMGYhqWmfChoSg70bXHvCFtEkaynxTChom5NlhdPHC0rkfyPPgKmiOgPEtZhrwCw2ZRGmUJ9AuntWA7gk8lZCj9WtKwYOe9Yrw9GlNi7uFWW867vR01Pa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKUtBu03; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6de0f53f8e8so922545b3a.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 09:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706721007; x=1707325807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOsg5X5uTICORYjOKaWHM1/qGZIfdD2P9FoNc132nfs=;
        b=TKUtBu03AD5QZiQwJye3ByoNGhCa1fMe1VSYqmcNOWozU8y0WN+C9AiqoNniS7sYUP
         U2zVxDMWzWrcLCaqMSEkkgBdln7faxfqheQnieMIHVpR8o40Fs+wLu2KJBb3DveT1pOj
         m1yY+GtnbwpRREzsYYMBYD5Fn9/j9Nf8Qe5O7Q3BZH9PJU2M+vz07+TCBIyMBJJzn94M
         jMy6+AL2I8Anxgirg20pfUP3JSnipye3DXHPkqThGVSF3wfS7KujJYz3xT+1wPlsZn1N
         Xnt5vFN5mmA2UivNUV0L1cDTVNsJNg1mz5oW5s4ftmBWtTltu+rmWBcI6JOWKshq6srU
         Y98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706721007; x=1707325807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOsg5X5uTICORYjOKaWHM1/qGZIfdD2P9FoNc132nfs=;
        b=P8amg/XDBe2axOBh/5sWQ4uGoil9ElPiB9euKtkZsIUQ6jTd11vt+ZXuB+sX3pLEFu
         MAQUTBeR7zYciPkhOyazCw1euHDzWDRDJVVnlQmOd6WJoXeK0okklFgRfAj0nCLQN1FM
         d9jWx7KBglfF8cBZvHHXzbtkrPbz7S2uhKgmhep2ATmFDWVR7zqOdXdThSHuKnxQqx6P
         MX9m2F183Bmt4wXMPSI7neGLIHtIYy48J7MVW0/OAcRO4lx6dLTAz03RXcfs1bFW3rOi
         qCPObfUEah1pZLZ3trit/M0j4sGkDdSfpJjCZC1rbiXuwjBsMcyBaQl1s3djmYhMlr+W
         eukw==
X-Gm-Message-State: AOJu0YwDXZc69PzBxwCqYkwZ8mm290PWSpDKoVfKb7pQtTkbln4DKpC/
	LoNLVMxaX9v8oMsLbjN9twS26MyroVHEBUpjTb2BMSKrCwf/nkQQvMEiVy+kcoDE1akebCfEEW6
	CvqAhBVvtmH0uddm67xFLJ3yfvuqc5DrYpEU=
X-Google-Smtp-Source: AGHT+IG5N/0vLI4JPvaJxhi3NpV6P5A6OfEpZCCE6419O8EyOPJUe4cz00oWv6Zet0EVKMLO3oxYkxY/NRyvXAHTNIs=
X-Received: by 2002:a05:6a20:2449:b0:199:29c4:b4b2 with SMTP id
 t9-20020a056a20244900b0019929c4b4b2mr6085296pzc.29.1706721007653; Wed, 31 Jan
 2024 09:10:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130193649.3753476-1-andrii@kernel.org> <20240130193649.3753476-3-andrii@kernel.org>
 <aa043e86-586d-45dd-83c0-f47b271c2634@linux.dev>
In-Reply-To: <aa043e86-586d-45dd-83c0-f47b271c2634@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 Jan 2024 09:09:55 -0800
Message-ID: <CAEf4Bza1eKtnRmaUfCo_-zkKTz-ZzcoTSLg6dhOQK9N-G97X_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] libbpf: add missing LIBBPF_API annotation to
 libbpf_set_memlock_rlim API
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 9:16=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
> > LIBBPF_API annotation seems missing on libbpf_set_memlock_rlim API, so
> > add it to make this API callable from libbpf's shared library version.
> >
> > Fixes: e542f2c4cd16 ("libbpf: Auto-bump RLIMIT_MEMLOCK if kernel needs =
it for BPF")
>
> Maybe we should the following commit as Fixes?
>
>    ab9a5a05dc48 libbpf: fix up few libbpf.map problems
>

The one I referenced introduced the problem, the ab9a5a05dc48 one
fixed some problems, but not all of them (for
libbpf_set_memlock_rlim). So it feels like pointing to the originating
commit is better?

> Other than the above, LGTM.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   tools/lib/bpf/bpf.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index 1441f642c563..f866e98b2436 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -35,7 +35,7 @@
> >   extern "C" {
> >   #endif
> >
> > -int libbpf_set_memlock_rlim(size_t memlock_bytes);
> > +LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
> >
> >   struct bpf_map_create_opts {
> >       size_t sz; /* size of this struct for forward/backward compatibil=
ity */

