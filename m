Return-Path: <bpf+bounces-30802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C66E8D28B9
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2C01F25CF5
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 23:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F413F01A;
	Tue, 28 May 2024 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgQ7/ndi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767113EFE5
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938875; cv=none; b=gcxSDBJUlgNwWJ8FFIWcwl14Y+IudScTDy2i9ftaPzCDbDqo7gzakRsAzHFEFH6RfIZ466I1WysOnTVt/1fRxBb80yDODD6dojSCMcwzp+m2rglC4/cGVgfxsfhprG7kTnufR6OhKz7ri7anVwZKzTaCSfyioVMdAKvHkwdCB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938875; c=relaxed/simple;
	bh=JpTc8+a2XccpnWCfLwDbtZoGlGIOOpOvMeYlUoE24aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha3kBFmn3gxmQdpfdiatPagXbbN5C5ENrtEHiPkb9mto7eC40kkl7xS501Sdm2fw2pqDi51dE9I0v4hxbNv83KbDXPKWmtqf79KQUur4UlMjgPVg6QA+KMuv+vpw55fcoX1Cd+oQtxZRrm9I2QYmQHbl2JGzSAL/OUgE4e2AwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgQ7/ndi; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so278001a12.0
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 16:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716938873; x=1717543673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBKVGh7ejHhZQEoEoeCi1+hlP0sB0jX9hjueKjjEbLA=;
        b=PgQ7/ndi94hPZd+p2Pb0NCm6SvBet+m66D2u9YwFpZYv7YRJWlnQiUuuagE2Tn1KPw
         5T75Jt3OB2SdSyK3W4aRzd6BrvGI0RY8XXbKGiVgIMbtg+1gerRixVqK9gm7D9brAJn+
         ekoiXFQ8pT0f6Nf8t3QyiEMkAKoZfWZVdRsnrDjWf7fZuoJSgf1q8lQbGJX9VdTXixbc
         EkFzJbLKtA7WGEG0nCvuTM9hR4xOBp3CIMPWh11xkAYd7yOwkuizW7NKWzqkHyiH+1s+
         om6qCj1OmZC7nDQnXD1uMvoi5mW5xZx4ZgujwYj7w/Vvf/EnKbvvdJfKAulhkA6CDg+E
         WbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716938873; x=1717543673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBKVGh7ejHhZQEoEoeCi1+hlP0sB0jX9hjueKjjEbLA=;
        b=lhNfBR0O3vYHe7heJ27oxoQTljFeAtuRx2AqPAj9xcrCeHAVfnXr1umFkfppKicFbj
         RcAgkXzCDs8dj3fR6tRZhtjcW9qXQWRnwntZF9SfUUT9dT6fB/petWVxBo99Yg1XQKVp
         zfpzODSPGjjolJS7j9agPA/7p83WAaL7KJhP11yYNJR63e4ObOT5Lkf29dXBK/zwtYQ1
         D8mMf2lfkWnfcgAMDf0S0UrrXtxhNHaf7oCnls7cL75J9abki13GmCBvPITq5MPLQ8tV
         KW5EwhV6SgMveuFNw0wnywY3rMaxbsKxjMVUHwaAhQgyQflcZt05ZZ9+3cyUyFXorYrz
         clsA==
X-Gm-Message-State: AOJu0YxhzejyWpKN8yDxHLvPBPHo75polgS5Hp2/fxB10jveRwmYpJR8
	r3z5fS0ny1iggP9EN/jR1HP7b55GtyW1lwJYvIm6aWcNbN10g8NLIKwZCK0FCOwHawQXVxGThWx
	3SzS9J1wEH6gbv0JfOwF59xff2e0=
X-Google-Smtp-Source: AGHT+IFgjyYXAzlSkjJAj0SAdNxl6/ICkuL+PaGRyP16RGtuSDl6DV40Fu0NdrLyVGzfFvtdo8MXvQLzSJJBlYx/nUY=
X-Received: by 2002:a17:90a:b891:b0:2bf:7dd0:1713 with SMTP id
 98e67ed59e1d1-2c02ec40e6cmr703796a91.16.1716938873025; Tue, 28 May 2024
 16:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524131840.114289-1-yatsenko@meta.com>
In-Reply-To: <20240524131840.114289-1-yatsenko@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 May 2024 16:27:40 -0700
Message-ID: <CAEf4BzZS=wu+cuV0-CuLLY4QqP+mOxjRMKOhMHJ0VcA-cDniEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: configure log verbosity with env variable
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 6:21=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Configure logging verbosity by setting LIBBPF_LOG_LEVEL environment
> variable, which is applied only to default logger. Once user set their
> custom logging callback, it is up to them to handle filtering.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  Documentation/bpf/libbpf/libbpf_overview.rst |  7 ++++++
>  tools/lib/bpf/libbpf.c                       | 24 +++++++++++++++++++-
>  tools/lib/bpf/libbpf.h                       |  5 +++-
>  3 files changed, 34 insertions(+), 2 deletions(-)
>

I did a few tweaks, mentioned below, and applied to bpf-next. Thanks!

> diff --git a/Documentation/bpf/libbpf/libbpf_overview.rst b/Documentation=
/bpf/libbpf/libbpf_overview.rst
> index f36a2d4ffea2..982dfd71a13d 100644
> --- a/Documentation/bpf/libbpf/libbpf_overview.rst
> +++ b/Documentation/bpf/libbpf/libbpf_overview.rst
> @@ -219,6 +219,13 @@ compilation and skeleton generation. Using Libbpf-rs=
 will make building user
>  space part of the BPF application easier. Note that the BPF program them=
selves
>  must still be written in plain C.
>
> +libbpf logging
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +By default, libbpf logs informational and warning messages to stderr. Th=
e verbosity of these
> +messages can be controlled by setting the environment variable LIBBPF_LO=
G_LEVEL to either warn,
> +info, or debug. A custom log callback can be set using ``libbpf_set_prin=
t()``.
> +

reformatted this to use line length consistent with the rest of the documen=
t

>  Additional Documentation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 5401f2df463d..d0465ca74afc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -229,7 +229,29 @@ static const char * const prog_type_name[] =3D {
>  static int __base_pr(enum libbpf_print_level level, const char *format,
>                      va_list args)
>  {
> -       if (level =3D=3D LIBBPF_DEBUG)
> +       static enum libbpf_print_level min_level =3D LIBBPF_INFO;
> +       static const char *env_var =3D "LIBBPF_LOG_LEVEL";

no need for this to be static

> +       static bool initialized;
> +
> +       if (!initialized) {
> +               char *verbosity;
> +
> +               initialized =3D true;
> +               verbosity =3D getenv(env_var);
> +               if (verbosity) {
> +                       if (strcasecmp(verbosity, "warn") =3D=3D 0)
> +                               min_level =3D LIBBPF_WARN;
> +                       else if (strcasecmp(verbosity, "debug") =3D=3D 0)
> +                               min_level =3D LIBBPF_DEBUG;
> +                       else if (strcasecmp(verbosity, "info") =3D=3D 0)
> +                               min_level =3D LIBBPF_INFO;
> +                       else
> +                               fprintf(stderr, "Unexpected value of %s e=
nv variable\n", env_var);

I've added "libbpf: " prefix and expanded the message with supported values=
.

> +               }
> +       }
> +
> +       /* if too verbose, skip logging  */
> +       if (level > min_level)
>                 return 0;
>
>         return vfprintf(stderr, format, args);
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index c3f77d9260fe..26e4e35528c5 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -98,7 +98,10 @@ typedef int (*libbpf_print_fn_t)(enum libbpf_print_lev=
el level,
>
>  /**
>   * @brief **libbpf_set_print()** sets user-provided log callback functio=
n to
> - * be used for libbpf warnings and informational messages.
> + * be used for libbpf warnings and informational messages. If the user c=
allback
> + * is not set, messages are logged to stderr by default. The verbosity o=
f these
> + * messages can be controlled by setting the environment variable
> + * LIBBPF_LOG_LEVEL to either warn, info, or debug.
>   * @param fn The log print function. If NULL, libbpf won't print anythin=
g.
>   * @return Pointer to old print function.
>   *
> --
> 2.45.0
>

