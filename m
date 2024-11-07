Return-Path: <bpf+bounces-44187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1295B9BFAD4
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 01:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC431F21828
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F0802;
	Thu,  7 Nov 2024 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5i9FXoR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108441854
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730939982; cv=none; b=teHfUK7Rebtzkr9H3Wv+ZF5CAYdBPvGsyoisJSE2LNChLjYAZhOqJW0wkt9nTSVD9wQVLYTiuyWWG3RV1EAwUZZiI1okmn4aQQfcRFgoVgnGkGr2OlptZAXClwPTIWbmDX7FNLgC8T5gPxeGfFdg+NkHg/qzFyHjfOa4M8JGw6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730939982; c=relaxed/simple;
	bh=/62EcbCWnwq6nSGdl/AS6g9HL9ukTdENc9nBnlu5arg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXLOy5e3RtIpKjVm67fZ6DO12E093SpUmJ4VjRb/eySKfah2vUiNCS4euf8LTupLATqJdh0SdaDkQ0O4569M7JxRFYAsA4MvQTBBd2wVlL2pyHhCzhQ32paeoiMRQKoc6wG4PIyLtk0cvmC0whlXt73dUMEUA+oIU6ohrTqDHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5i9FXoR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c70abba48so4537785ad.0
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 16:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730939980; x=1731544780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z8LNF6NXWb8nh+vGrRYKD0YlRMImn4hQ5yHwL3/JhU=;
        b=d5i9FXoRmIF71ZR7UMBjv2FVVmLN7MV7FfPsb5S0K0IbdpYV6wExs/ubxvDv7k+7NT
         T24igrwqRhx9z8augk8CFqo8O3IDlFqbJjxqatywlMoteAJj6vLPqwUGG++ya9j0y/4x
         0d3Su4TkwtKAdDCfpyBzP5GJ35TMKIXTjdKpGCYzSoiPfLyqW6PQLN+AsYqi5H8kpoA8
         sxe7uczLswIZVHzKVFfofPgx2LPPfK4iaeIzn/2aK2/MDjYo6BMuJXVTwNo5RodUsKzQ
         JRQX2BpfL8UE9JMx4zDaBlbw1nvAAz9/VzU/THAdzYkNqoZrlqYKZRzMRppjHg8pzAGn
         4GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730939980; x=1731544780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z8LNF6NXWb8nh+vGrRYKD0YlRMImn4hQ5yHwL3/JhU=;
        b=oCpBzaDfC39ATLBw1HYhnRW7ftQtq2CJ6DolET5Cp2K5Jeb2csCbowXFB6xsjHarP1
         llIhbC27cAR6dmpkoP8b9v6Y0GA12dds2eWije8SXUorXjumRGRqxBlv3VEvNPVCLMGl
         XjbvL3yEtuuCqyzDPE8oJFDFHLWG6uOdw2d05wRHLmhamWB0Ok2ECWtNGGNdjK9Y0jOO
         Qj3tnf7zkIjBBF+Qi0nht3YZrnN8XGQhdtEG7L1uwC7jB5iJe6OhOS6sC/nf+9T9psnf
         uvrDXfyopjZpBr4AiinWfVRfbtjNb6udtaUskR8E5S1/Tq0skLAhdMHU9gWLgxHZ231i
         EdGw==
X-Gm-Message-State: AOJu0YyNF8VzdaI3rI6D3t0XO0sgNQgR3fdSHdGH7AQL9F9MZ6jdXnmi
	qM1P/6yKpSVQn1Dfaba1l7Md9bIbDIRFd1QkY5l2rpsYE4YXX62tJ9ikjy3p+FqUG0i8+2MklnB
	3iTS7G4pkd352CSIOGDeKH+DdwZzFdzMh9jY=
X-Google-Smtp-Source: AGHT+IEDxroFvmTAsYOpMn7ry8ZmD+wdYvabhNkErVwvuy8dVJirMDY7pulEXKVoVcHGT65xvBaRBz+vgNPHJH8N06Y=
X-Received: by 2002:a17:90b:4a51:b0:2e2:af54:d2fe with SMTP id
 98e67ed59e1d1-2e94c5299afmr28798555a91.34.1730939980302; Wed, 06 Nov 2024
 16:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104170048.1158254-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20241104170048.1158254-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 16:39:28 -0800
Message-ID: <CAEf4BzbB_PuJOKq-QuuS8ztBcAaMEZT3bte0QavXze2HT=2epA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: stringify error codes in warning messages
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 9:01=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Libbpf may report error in 2 ways:
>  1. Numeric errno
>  2. Errno's text representation, returned by strerror
> Both ways may be confusing for users: numeric code requires people to
> know how to find its meaning and strerror may be too generic and
> unclear.
>
> This patch modifies libbpf error reporting by swapping numeric codes and
> strerror with the standard short error name, for example:
> "failed to attach: -22" becomes "failed to attach: EINVAL".
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 429 ++++++++++++++++++++++-------------------

We have use cases for strerr() in all of libbpf .c files, let's do the
conversion there as well. But I'd probably split adding strerr()
helper into first separate patch, and then would do the rest of
conversions in either one gigantic patch or split into some logical
groups of a few .c files (like, linker.c separate from libbpf.c,
separate from bpf.c, if we have any strerr() uses there). We have tons
of error message prints :)

pw-bot: cr

>  1 file changed, 231 insertions(+), 198 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 711173acbcef..26608d8585ec 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -336,6 +336,83 @@ static inline __u64 ptr_to_u64(const void *ptr)
>         return (__u64) (unsigned long) ptr;
>  }
>
> +/*
> + ** string returned from errstr() is invalidated upon the next call
> + */

keep it as single-line comment, but if you needed multi-line, it
should be formatted like so:

/*
 * blah blah blah lorem ipsum
 */

> +static const char *errstr(int err)

let's move this function into str_error.c, it doesn't have to live in
already huge libbpf.c (and you'll need to "expose" it in str_error.h
to use from not just libbpf.c anyways)

> +{
> +       static __thread char buf[11];

nit: make it buf[12] to technically handle "-2000000000" ?

> +       const char *str;
> +       bool neg;
> +
> +       if (err < 0) {
> +               err =3D -err;
> +               neg =3D true;
> +       }

honestly, thinking about this a bit more, I think it's ok to always
emit negative error in the buffer (because that's what it should
always be, at least when this is used internally in libbpf).

So let's have, just:

if (err > 0)
    err =3D -err;

to make it explicit that negative error is the common/expected way


> +
> +       switch (err) {
> +       case EINVAL:
> +               str =3D "-EINVAL"; break;

then for all of these we can have a nice and compact style:

case -EINVAL: return "-EINVAL";
case -EPERM: return "-PERM";

> +       case EPERM:
> +               str =3D "-EPERM"; break;
> +       case ENOMEM:
> +               str =3D "-ENOMEM"; break;
> +       case ENOENT:
> +               str =3D "-ENOENT"; break;
> +       case E2BIG:
> +               str =3D "-E2BIG"; break;
> +       case EEXIST:
> +               str =3D "-EEXIST"; break;
> +       case EFAULT:
> +               str =3D "-EFAULT"; break;
> +       case ENOSPC:
> +               str =3D "-ENOSPC"; break;
> +       case EACCES:
> +               str =3D "-EACCES"; break;
> +       case EAGAIN:
> +               str =3D "-EAGAIN"; break;
> +       case EBADF:
> +               str =3D "-EBADF"; break;
> +       case ENAMETOOLONG:
> +               str =3D "-ENAMETOOLONG"; break;
> +       case ESRCH:
> +               str =3D "-ESRCH"; break;
> +       case EBUSY:
> +               str =3D "-EBUSY"; break;
> +       case ENOTSUP:

Is this one coming from public UAPI header? I don't think so.
include/linux/errno.h is not exported to user-space. This means that
Github version of libbpf will have trouble with compiling this. This
works ok inside kernel repo, but we should be careful about relying on
internal headers.


Please check all the other ones. BTW, how did you end up with this
exact set of errors?

> +               str =3D "-ENOTSUP"; break;
> +       case EPROTO:
> +               str =3D "-EPROTO"; break;
> +       case ERANGE:
> +               str =3D "-ERANGE"; break;
> +       case EMSGSIZE:
> +               str =3D "-EMSGSIZE"; break;
> +       case EINTR:
> +               str =3D "-EINTR"; break;
> +       case ENODATA:
> +               str =3D "-ENODATA"; break;
> +       case EIO:
> +               str =3D "-EIO"; break;
> +       case EUCLEAN:
> +               str =3D "-EUCLEAN"; break;
> +       case EDOM:
> +               str =3D "-EDOM"; break;
> +       case EPROTONOSUPPORT:
> +               str =3D "-EPROTONOSUPPORT"; break;
> +       case EDEADLK:
> +               str =3D "-EDEADLK"; break;
> +       case EOVERFLOW:
> +               str =3D "-EOVERFLOW"; break;
> +       default:
> +               snprintf(buf, sizeof(buf), "%d", err);
> +               return buf;

and then here we'll just

snprintf(buf, sizeof(buf), "%d", err);
return buf;

> +       }
> +       if (!neg)
> +               ++str;
> +
> +       return str;
> +}
> +

[...]

