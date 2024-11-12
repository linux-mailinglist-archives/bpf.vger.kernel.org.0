Return-Path: <bpf+bounces-44590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFD59C4DC8
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 05:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2752858E3
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 04:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B675208224;
	Tue, 12 Nov 2024 04:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFjV/kZj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507441A01C3
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731386144; cv=none; b=SnluFWfD2FrpaHYCCgJkBUfNw0dN0P0X35akFqkftsMFO/24VAmsYk1TdyyHBfQq8lwy3l+5ZQGviHu3mkdtxyZc/Jxi1SMaKnpCFMzN+6ojnulB7nMed9QYJ+6pmBOCMrZz40lnQ3FnIVc+KaYdB3o1LuHdGBVqpZRBlH0wXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731386144; c=relaxed/simple;
	bh=jBWnzH7UbPQMoV2IfTznM3mAUc9EZ+uHBOtX3S4DACs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6Gd+LbLvU6YXoSHH4zZMNRhLHssOOL5UvHesavGDy9RmbIIKcnH1nF849x5krKs+VB9agYpij1voO3nlTTHuSaiUJKnDcuOOuTdAps/eiKo3BdYfj8oBSQa/ewrnLgbyz5SZ1G/enNpmynpct9zSsDC87q1iTYK9WXAjMSt7Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFjV/kZj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7240fa50694so3854337b3a.1
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 20:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731386142; x=1731990942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhYDr0TaxzMSAOlDTSUnG+EG0HrrgAXoqlBcGu7F2tQ=;
        b=DFjV/kZju28xBQWrq/vRQI4rqyVz1JpsVj/NIAk3jjys1JEk8vEdfpyPv/czwtm8XA
         1p2Ula0xUmTW9MTPeFBNe5EWcJ9vGmuOdKEVdcHcVfXMlG4bpAQ149kseySHZlS4JYZX
         GZJoKG0CriNl1rzassHV1+BNaDoP5zy7wdSGZLvkCwRScBIp7WickoKLy7Z3SeOGGgt7
         a4umweIFmbskzFquuBqFlnrad6zFIrc0i13kwV6HvCuiESoIV1fF4B43oe0YStWKa9Yi
         d/F/eGgayuoHimloRPAV0ZM/RqNtTSVDYhLBsyApkOeWeXSgLY76QArjYI/IBzAwMv1s
         cpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731386142; x=1731990942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhYDr0TaxzMSAOlDTSUnG+EG0HrrgAXoqlBcGu7F2tQ=;
        b=HzhOjJ5KE0Dkf6KCxudxXZYXyJi/Q00D5FWIHmpbhOGu9t+JPuRT7Z1Gefm+eofW1Q
         OKnlt7BAephEuOuMixYiC+barQmqLmO9ZtuC4M9rbQQDz+BkOST0fjW0MD1384eEyaiC
         PKrJNo39T+oazv+49KE85lvye3KE2UBajY9fZS+nelqaq2t8KJLOKdJ7cvm+uZNounUI
         P+wA+rrITLg5JLjVhiDNTbYTC47LLZu9uDWnC+IeQL32yzvNga2qwLe7p4tRzTNyEHi8
         9FQVY6vgrPCTVxu1tiDI/8MHtjcbrUgCncOUNte8/4Exlsm7UsR5GEY6uhek3KWJuvW7
         DnIA==
X-Gm-Message-State: AOJu0Yz15H64Do1VDIbWKNg18Qck2/bnUh0PSamSrwyxI4RudNIBqlaP
	Tfe5B456NAAWq6aKc+VDUeLvVOipYsCQuiIS3WQvFhFGzL4Dd5bTQzPaQN4y9IkMs5EzdNqIXKT
	Pi2bEMmMrXdzA6H7ZzpdLErirDqg=
X-Google-Smtp-Source: AGHT+IFr7QKnCvHwM6Z3xYCwLaI6HMs4/WUUf6fdXdr0131+wwMF9kH+v7VBtBaHar/kpkOPKGQIy4DlsxbS42w7jnk=
X-Received: by 2002:a05:6a20:3d87:b0:1db:9367:d018 with SMTP id
 adf61e73a8af0-1dc229d6d4dmr22840005637.20.1731386141766; Mon, 11 Nov 2024
 20:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111212919.368971-1-mykyta.yatsenko5@gmail.com> <20241111212919.368971-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20241111212919.368971-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Nov 2024 20:35:29 -0800
Message-ID: <CAEf4Bzb0i7wgNbstGyDCgDXBCcBRGasxqos3t+cJnw5Vp=RVtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] libbpf: introduce errstr() for
 stringifying errno
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 1:29=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add function errstr(int err) that allows converting numeric error codes
> into string representations.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/str_error.c | 59 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/str_error.h |  7 +++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
> index 5e6a1e27ddf9..cf817c0c7ddd 100644
> --- a/tools/lib/bpf/str_error.c
> +++ b/tools/lib/bpf/str_error.c
> @@ -5,6 +5,10 @@
>  #include <errno.h>
>  #include "str_error.h"
>
> +#ifndef ENOTSUPP
> +#define ENOTSUPP       524
> +#endif
> +
>  /* make sure libbpf doesn't use kernel-only integer typedefs */
>  #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
>
> @@ -31,3 +35,58 @@ char *libbpf_strerror_r(int err, char *dst, int len)
>         }
>         return dst;
>  }
> +
> +const char *errstr(int err)
> +{
> +       static __thread char buf[12];
> +
> +       if (err > 0)
> +               err =3D -err;
> +
> +       switch (err) {
> +       case -EINVAL: return "-EINVAL";
> +       case -EPERM: return "-EPERM";
> +       case -ENXIO: return "-ENXIO";
> +       case -ENOMEM: return "-ENOMEM";
> +       case -ENOENT: return "-ENOENT";
> +       case -E2BIG: return "-E2BIG";
> +       case -EEXIST: return "-EEXIST";
> +       case -EFAULT: return "-EFAULT";
> +       case -ENOSPC: return "-ENOSPC";
> +       case -EACCES: return "-EACCES";
> +       case -EAGAIN: return "-EAGAIN";
> +       case -EBADF: return "-EBADF";
> +       case -ENAMETOOLONG: return "-ENAMETOOLONG";
> +       case -ESRCH: return "-ESRCH";
> +       case -EBUSY: return "-EBUSY";
> +       case -ENOTSUPP: return "-ENOTSUPP";
> +       case -EPROTO: return "-EPROTO";
> +       case -ERANGE: return "-ERANGE";
> +       case -EMSGSIZE: return "-EMSGSIZE";
> +       case -EINTR: return "-EINTR";
> +       case -ENODATA: return "-ENODATA";
> +       case -ENODEV: return "-ENODEV";
> +       case -ENOLINK:return "-ENOLINK";
> +       case -EIO: return "-EIO";
> +       case -EUCLEAN: return "-EUCLEAN";
> +       case -EDOM: return "-EDOM";
> +       case -ELOOP: return "-ELOOP";
> +       case -EPROTONOSUPPORT: return "-EPROTONOSUPPORT";
> +       case -EDEADLK: return "-EDEADLK";
> +       case -EOVERFLOW: return "-EOVERFLOW";
> +       case -EOPNOTSUPP: return "-EOPNOTSUPP";
> +       case -EINPROGRESS: return "-EINPROGRESS";
> +       case -EBADFD: return "-EBADFD";
> +       case -EADDRINUSE: return "-EADDRINUSE";
> +       case -EADDRNOTAVAIL: return "-EADDRNOTAVAIL";
> +       case -ECANCELED: return "-ECANCELED";
> +       case -EILSEQ: return "-EILSEQ";
> +       case -EMFILE: return "-EMFILE";
> +       case -ENOTTY: return "-ENOTTY";
> +       case -EALREADY: return "-EALREADY";
> +       case -ECHILD: return "-ECHILD";

I added a few error code from include/uapi/asm-generic/errno-base.h
that were missing (just for completeness, as we already had absolute
majority of them), reordered alphabetically and reformatted to be a
bit more table-like. Applied to bpf-next.

Thanks a lot for this massive clean up, it's great!

> +       default:
> +               snprintf(buf, sizeof(buf), "%d", err);
> +               return buf;
> +       }
> +}
> diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
> index 626d7ffb03d6..66ffebde0684 100644
> --- a/tools/lib/bpf/str_error.h
> +++ b/tools/lib/bpf/str_error.h
> @@ -6,4 +6,11 @@
>
>  char *libbpf_strerror_r(int err, char *dst, int len);
>
> +/**
> + * @brief **errstr()** returns string corresponding to numeric errno
> + * @param err negative numeric errno
> + * @return pointer to string representation of the errno, that is invali=
dated
> + * upon the next call.
> + */
> +const char *errstr(int err);
>  #endif /* __LIBBPF_STR_ERROR_H */
> --
> 2.47.0
>

