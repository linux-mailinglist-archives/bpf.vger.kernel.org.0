Return-Path: <bpf+bounces-56325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E58DA95633
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 20:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4428E1895C31
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776CA1EBFFC;
	Mon, 21 Apr 2025 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QBgCCfBd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB361EB182
	for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261575; cv=none; b=GRP90KCPDZLWe0Ub1Z2tqB0sEswn1Bfe1nRpbVSY5Mqw50NS1se6T198fS4HVKZ5L1PkxN4nZBfFgkSXxhxjV00fz5lbgRGzG8n+EdsZObedM7BI6xBXr0+w57ELMHo+ZSabd6TqDqaG157T85L8QQAsfSwpyDyPE1OcJ/p1r9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261575; c=relaxed/simple;
	bh=MAT6Ew2gJpdMJ8irAU8emiSANZdL6DjJHNFxnFPsi3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mg9glCyt78qE3dopuVJMGA+rWpc3tZaUZMQrsZd+j5UJTteRsmVM1OMI6Pp3ocJ11oyxR7/9oAN+JZinaoR+HnTvjDxGoGRHpiz0xeSdldF0p/+f5gIiWXBSaMPIyiylrGRiGuzTUTd80/TY1UOekyVAQEYp1Ffw6ggog+hlvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QBgCCfBd; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70565ccf3bcso38824637b3.0
        for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 11:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745261569; x=1745866369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz3xUPpEUe/pX3Hqv/1lT4GmPjs/7L4gms/heykjQds=;
        b=QBgCCfBdZ+Y261pLXknquCzeKzGiOf6WfhHPt2eOubBqKoeSWNCbuZat5VWRZCmHlB
         p2hdRfZ9LQz+qqYLKmUZnysoVo6VJm0QITXShrmVsSbBQlNpMSbNNDYIgqXTk/H3SeIY
         zOJyFN9d8HNrYCjZCDNLCAfP+NjkuPDlV9j9qqlD/ajZT0Js+JT0H/Ks4qRmenSCErF5
         xWnQrw9zxvS4qe0ZcMmmKhXs8m6D3fpToPJ1nW7T2WH8DSGv1hH0DDNyfsIXnemSobv2
         gpMvWmjckK4tIFu8T38+ZUQMNq1L4dhqn2XHhUUFpzqtxP/PNx5QcfWoOswf6z8muSS6
         YgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745261569; x=1745866369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lz3xUPpEUe/pX3Hqv/1lT4GmPjs/7L4gms/heykjQds=;
        b=upmKEwuRjPVQnBlokuoEx3e1Rz4U5aSkYWZc63bi0QLFFmm+rCgbZZRiV8qrT9BSOS
         486Ive2DaOEhFK+PXLqK8ZCZ7GMm6nZDzSKxJOu/RVtc0REyauqI1KrnQaZhv2EkhlFB
         mUdq4LqXQTsldz3WFARJycZmWntkCRe/pq+A0lHcxVw2qMqmTf2shFbHO/UOiBIqWyqx
         KPUxaqop12Bo16MA/Auhcoy0NnxMghl1SVy7X4iV0IcyPmJAFoYQpKNu1sR4PpNoIMwr
         gnGzBrLb7Kwd4GBe/Xm4Jqr1+/BGOzCdQcREoCHU9lzjhPpvnODzDBQrDtFvlIxvUldu
         F6kg==
X-Forwarded-Encrypted: i=1; AJvYcCXltuvVsaWjmBZBY8GBl7uBfM6Xr+Yg3KDE+yTvwgUROqH27mscqu5ZPZsk1fZS5NK4dFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVaSBrZarfOyK7cY277YumbEy8N4P/T07cdhbbYnXPgf7peWB
	kZjFuDyWFrsIuO+d4rcHLFLrmP4WIVXMyVIJIWJC1vhWs0IHJPmxVNoxXP/glsm+/7PbH4gKk32
	FswjBWDnk3Tv9W8E9i3N/ee8p/kpDnZEjGAYw
X-Gm-Gg: ASbGnctyTEgYOH5ShxORfUCVnc0d75bLgtl6HYvT7JFf6DncuWqWFquV/FkLdmXLaQH
	rAtR9FRUGaia9xGutZuT+t+euV7SsiLzRIl+jgxDbzCLnk/2KZcvLxIgivQL9eYkzRFY22Q4hK0
	1lWKmQy4h/vFCzzmkpfVBHYw==
X-Google-Smtp-Source: AGHT+IEuH9hzO8L5xENmqEA5+rCv5QU5f2RwWDzAiO15hUKUo3LnS3Mbacdqm494PthrNYTv96+oKoVST5i5x+eAlHw=
X-Received: by 2002:a05:690c:648a:b0:6fe:abff:cb17 with SMTP id
 00721157ae682-706ccda15f4mr176888017b3.26.1745261569456; Mon, 21 Apr 2025
 11:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <64859c5c8fd969186c1997a340ed6307e2c70f06.camel@HansenPartnership.com>
In-Reply-To: <64859c5c8fd969186c1997a340ed6307e2c70f06.camel@HansenPartnership.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 21 Apr 2025 14:52:38 -0400
X-Gm-Features: ATxdqUEW2UYysWiho25YbREtPd_DwN7ErCdbG2Ug5RajPR5M9exUr19Bmcv_5Vs
Message-ID: <CAHC9VhSu_tn6d2A4-CYQn_Kr4mdRKEBXLabbPkLZuwQcC2KhJA@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, nkapron@google.com, 
	teknoraver@meta.com, roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 2:43=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Fri, 2025-04-04 at 14:54 -0700, Blaise Boscaccy wrote:
> [...]
> > diff --git a/include/linux/kernel_read_file.h
> > b/include/linux/kernel_read_file.h
> > index 90451e2e12bd..7ed9337be542 100644
> > --- a/include/linux/kernel_read_file.h
> > +++ b/include/linux/kernel_read_file.h
> > @@ -14,6 +14,7 @@
> >       id(KEXEC_INITRAMFS, kexec-initramfs)    \
> >       id(POLICY, security-policy)             \
> >       id(X509_CERTIFICATE, x509-certificate)  \
> > +     id(EBPF, ebpf)                          \
>
> This causes a BUILD_BUG_ON for me in security/selinux/hooks.c with
> CONFIG_SECURITY_SELINUX=3Dy because READING_MAX_ID and LOADING_MAX_ID
> become 8.
>
> Below is what I had to do to get the compile to work.

That code was updated during the v6.15 merge window, depending on what
kernel sources Blaise is using for development it's possible he didn't
bump into this even if he was building with SELinux enabled.

Otherwise the changes below look reasonable to me.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e7a7dcab81db..9a7ed0b4b08d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4133,7 +4133,7 @@ static int selinux_kernel_read_file(struct file *fi=
le,
>  {
>         int rc =3D 0;
>
> -       BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
> +       BUILD_BUG_ON_MSG(READING_MAX_ID > 8,
>                          "New kernel_read_file_id introduced; update SELi=
nux!");
>
>         switch (id) {
> @@ -4158,6 +4158,10 @@ static int selinux_kernel_read_file(struct file *f=
ile,
>                 rc =3D selinux_kernel_load_from_file(file,
>                                                 SYSTEM__X509_CERTIFICATE_=
LOAD);
>                 break;
> +       case READING_EBPF:
> +               rc =3D selinux_kernel_load_from_file(file,
> +                                               SYSTEM__EBPF_LOAD);
> +               break;
>         default:
>                 break;
>         }
> @@ -4169,7 +4173,7 @@ static int selinux_kernel_load_data(enum kernel_loa=
d_data_id id, bool contents)
>  {
>         int rc =3D 0;
>
> -       BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
> +       BUILD_BUG_ON_MSG(LOADING_MAX_ID > 8,
>                          "New kernel_load_data_id introduced; update SELi=
nux!");
>
>         switch (id) {
> @@ -4195,6 +4199,10 @@ static int selinux_kernel_load_data(enum kernel_lo=
ad_data_id id, bool contents)
>                 rc =3D selinux_kernel_load_from_file(NULL,
>                                                 SYSTEM__X509_CERTIFICATE_=
LOAD);
>                 break;
> +       case LOADING_EBPF:
> +               rc =3D selinux_kernel_load_from_file(NULL,
> +                                                  SYSTEM__EBPF_LOAD);
> +               break;
>         default:
>                 break;
>         }
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 04a9b480885e..671db23451df 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -65,7 +65,7 @@ const struct security_class_mapping secclass_map[] =3D =
{
>           { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
>             "module_request", "module_load", "firmware_load",
>             "kexec_image_load", "kexec_initramfs_load", "policy_load",
> -           "x509_certificate_load", NULL } },
> +           "x509_certificate_load", "ebpf_load", NULL } },
>         { "capability", { COMMON_CAP_PERMS, NULL } },
>         { "filesystem",
>           { "mount", "remount", "unmount", "getattr", "relabelfrom",
>

--=20
paul-moore.com

