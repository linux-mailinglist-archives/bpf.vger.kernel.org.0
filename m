Return-Path: <bpf+bounces-30436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27808CDC54
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111631C20BE6
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 21:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE66127E2B;
	Thu, 23 May 2024 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqFn3Kw7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15483CD6
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716501037; cv=none; b=g69ebrk0QY7BaXt34+l6wn/C6TcANmi7DV8x5VGKssdmL1fXmGF6t7O34B2lqNbWm4wy32mBk4aEGIvL5Lwk2PLKGNmaIJkmKXvMH+ZZYHOdeef9xzO8sFz9rISJwXSLlknPUWDV758gDYO27o7W4niqXW3+/+0CIRZAUlLZbVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716501037; c=relaxed/simple;
	bh=vI5KN3uIL4kXRnDlPpz2BDvsUkwEsq1SeTTlSJOmDc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7wLWo7jYHqzY6KPB/5p2LNfA6dh4JnTSia2Gf4LZQJ9Q1tcAcmv3AEI6wd7IRdmcA4fVOFydCcuztWb0rvmnat31zuJ6VQsQfvenAO8mwuHsQ/Rna2Whv7L0t1cdhE5IESpmS8ZSs580zJQGcCnMwUNtmsrZe7ZC9088O5mTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqFn3Kw7; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2bd9284dd31so2288206a91.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716501035; x=1717105835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5Q9Z+mgEZTfkaKHYMMAE1evcB+YM0KGqOQxOMLQ/cs=;
        b=EqFn3Kw7Pgk37r6lnL6KdJofcBEOq0h+Gwl3S528extMuIRBIPyvL38Dxl5CCA7wWr
         BMXyeiBzhhFU2SRfB8gCVRxSWW4oMlpjxdFSbqHcR3gaGwQ6qTiq/+iqRECZw/whhsnB
         QoRtKNXNlFvIUGOlfW52Z4f8sd85LXIHWF0jP7IO6zLfPTAWXmzDfDAdk8cqjzAl0X1b
         0UuiH9XzV2JYz88oMpwDvTDF+BGY5zSZ3VCuchKu2NC1nVYWHQORMZAYcP88HqFHL6h9
         8vUgeSWTxwm0B+3Q9yVGhF46pBFWL4OG+4rtSQxaPfWhWRNO789RgShiftPaqMZdsezt
         h5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716501035; x=1717105835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5Q9Z+mgEZTfkaKHYMMAE1evcB+YM0KGqOQxOMLQ/cs=;
        b=Qa9h5UuSWy7hXxsQnN+6sAGbhU3KKD+sQ4xVJZMxa31RF5NkziuFNppLUPgb5GYkYH
         YJxyTctXoOCgCUthKuAO0qIJsIhmrTfB++H3KJtwQgseykXdYdcRb1A3czZC+do+a0D2
         9fGOFxkpDZL6EUO1UI3ewOkBWCX21yH7xgIfHawKq+HVgfMTl+u2R7Y4Yr28Aecylgh9
         RLTL9/2vY8dBCNISfF0zDAnvmUOIqlbDIRyw/PuPDdtdC5P1rtQLuwRhsjC7QwO4bS+p
         x0SXaBhBDUWUjMKo1H326uRxsZz9UxgyJyX77t5G5JlQ9NVdmWtCS2bTT95eGMeWfF3R
         iN5g==
X-Gm-Message-State: AOJu0YxwvwBtxdRSQ+z+WdILsVxIXYZCTRxfW19ppRcRR7d+KRLJkGns
	cJrtFo7kKcz+nWoCCGseurlh8BkfVgXG/8+iEC0p7ajQeh9cJM7f5cTQb2QZ+76HmYI0JdKqNEl
	RSYNgA2QxDhUdkt5pW05ym/XQcE0=
X-Google-Smtp-Source: AGHT+IGAbrFSGhW0ELKY/FtBc0fXxpACR/AIxMm4kWJCNKG57WqgwsJowjfipZGCgmuojPbNn6cskQ2lPbixwizdkUQ=
X-Received: by 2002:a17:90a:db93:b0:2bf:5977:931a with SMTP id
 98e67ed59e1d1-2bf5ea3ad51mr457317a91.10.1716501034941; Thu, 23 May 2024
 14:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523205337.951410-1-yatsenko@meta.com>
In-Reply-To: <20240523205337.951410-1-yatsenko@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 May 2024 14:50:22 -0700
Message-ID: <CAEf4BzYTY8JWwMKuTbjQEZRFeS1Dwb3-_u8uCDaP2bi7i10uNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: configure log verbosity with env variable
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 1:53=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Configure logging verbosity by setting LIBBPF_LOG environment
> variable. Only applying to default logger. Once user set their custom
> logging callback, it is up to them to filter.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 5401f2df463d..8805607073da 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -229,7 +229,23 @@ static const char * const prog_type_name[] =3D {
>  static int __base_pr(enum libbpf_print_level level, const char *format,
>                      va_list args)
>  {
> -       if (level =3D=3D LIBBPF_DEBUG)
> +       static enum libbpf_print_level env_level =3D LIBBPF_INFO;

this doesn't have to come from just the environment, we might add an
API to set the default log level programmatically (in the future, not
saying we should do it right now). Maybe more generic "min_level" or
"log_level"?

> +       static bool initialized;
> +
> +       if (!initialized) {
> +               char *verbosity;
> +
> +               initialized =3D true;
> +               verbosity =3D getenv("LIBBPF_LOG");

I'd be confused whether LIBBPF_LOG is log *level* or some sort of file
path to which default log should go (and who knows, maybe we'll add
that). So let's maybe call it LIBBPF_LOG_LEVEL=3D... ?

> +               if (verbosity) {
> +                       if (strcmp(verbosity, "warn") =3D=3D 0)

let's do case-insensitive comparison?

> +                               env_level =3D LIBBPF_WARN;
> +                       else if (strcmp(verbosity, "debug") =3D=3D 0)
> +                               env_level =3D LIBBPF_DEBUG;

let's handle the "info" level as well?

and for unrecognized value, let's print a warning directly with fprintf(std=
err)?

Let's also add this LIBBPF_LOG_LEVEL envvar description to the doc
comment for libbpf_set_print() and a short section somewhere in
Documentation/bpf/libbpf/libbpf_overview.rst ?

> +               }
> +       }
> +
> +       if (env_level < level)

super nitpicky, sorry, but my brain refuses to intuitively understand
this, can you invert the condition please (and maybe add a comment):

/* if too verbose, skip logging */
if (level > min_level)
    return 0;

But in general this is a useful feature, thanks!

pw-bot: cr

>                 return 0;
>
>         return vfprintf(stderr, format, args);
> --
> 2.45.0
>

