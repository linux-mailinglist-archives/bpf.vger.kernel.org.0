Return-Path: <bpf+bounces-56714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAD6A9D065
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7544C3269
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533B217677;
	Fri, 25 Apr 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naiBT775"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F4215F72
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605219; cv=none; b=gK1blep/jmw6nM7O3HdLjAbXeJHRlHrKfYbyxTY45JHVdmxAk2YyUcvDfwa3q8ifT49YpPIqr6CYYnreXDoT9OJu2mTztFENZixnfcm8Eg60SVvKVjQ6V/nb1rM5Aasq2BtI2ICUzB0Am6YkBLwXWkWvlF1T3usEYUA8Z4+wKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605219; c=relaxed/simple;
	bh=MRaKAlHesyBtN5fRah5LGDulBzqfSWVJYntguyIjtRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFdZxaHIrzQMZ42mo674xq0O3YhAy1NCs5Bl2BXoKLh1eAwlua/rCJ8TgOe3AmWxJ6tzeGn/Zi+6THmz+ipKotO/Wd8Tb4x81JEUvBMfuUqTAvHzk+EiTSxLXsmu5okdPJLUq4tPLU/pOtWLuJoKxZIpPimMxAUWRv1qaOLEu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naiBT775; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so2386556b3a.1
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745605216; x=1746210016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1lhpZIuLYuY+ASeYY4LH6DFo+KUvp4954DURKOodnc=;
        b=naiBT775tqEiKpTSDZaKNrd1kJSd8aKL4KQZvLc0BryI6DG/tl7bsLNcyOsmtvz1gr
         nvceMOZlBTVsYVitUyfwMmy9Jk6yOn+MdxsCH1O+wph5CMIL6LauFXrwfTzR8CeDEQQ+
         sXm3x15KLJoP3XIS2Lpps/icZFcVtAke7Y1EfNcm0bLivVDq5pzjnMRiSJFhQBsguC9O
         AkUBdiu2fwxpgX184IyjkanUVugRi5t/ilvEKz5cl8THsI8Ry+bAq+eCjfVxU5MRwj1Y
         QAxsIKWREO4/iW/AZ6mPXvSWIdrPNimtS40N67Pgp61SSQTaeGAbhC9UyuxX2zPtgvHH
         vLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745605216; x=1746210016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1lhpZIuLYuY+ASeYY4LH6DFo+KUvp4954DURKOodnc=;
        b=B2iEqvDSZUXgheYblqCvllC/Ro36sOdWr7aILKU3vo5y7HOGAfpFI/QZ7Sho1Ri1o9
         /Ku6GCHWcUALbZ7Ze8xX90jdsMfdh/iBWTyphKyIDQy1mc1c0S1XdjPM12VQwxi1X5D+
         zgFP9DJeKhoYHM4tMXARlVz2ZKKeJUnlMGDBJGx8ADKI1A/dueUzh7jlEQZqKsE+xIbu
         PLi1tEVabRGd6CV1EzdQqParV+dMLMoAmJ0tyLC9N8XwJqywF2rqMP6NRXMG3XAyOmdL
         k46c4lg3qaj+dAqXyA61AIvtuHcDZxhDiGv9HjDGfuxFhp/HsoMDGDd1KrZxR444XTDh
         UWGg==
X-Gm-Message-State: AOJu0YzPDX29BE12dxIfwW/CgL4mQhIlsjLYu12GYZqTpwsjK4eaHF2z
	FSINhz2TwRaMT5vtTFj6gg27Q/83MOs/RUQwRLc03tzHwCyrrsmqrtB0mYPgNn/lnW/033tQICa
	QHLAlQc9b8Vi1TkbPI15chYMKyqw=
X-Gm-Gg: ASbGncuty0Yq77jH7pQtJgb3iXyKwMbrlM4XQsYXwZt+tEuyTxKE5Fsl83C3V2oBd5p
	FrmBh5t7U5TeErio+KxlBCMfbCOWz/mcQq23e5LCVEmy5yZMk9+hxM5LHLl7ZxqLI9AEcqseZet
	cylHW6QjsxRGUro+vMuPercZwtKT95Lr2iTrNeOA==
X-Google-Smtp-Source: AGHT+IGfvzBEpUpOAsQCOJgk/vXUxQIB7kohIHNvqgwKUvgitEDiP8YH34+NF/bZxC9F3l//zBBKxJL0Ie2xuBQpk4U=
X-Received: by 2002:a05:6a00:2402:b0:736:2a73:675b with SMTP id
 d2e1a72fcca58-73fd876d982mr5090587b3a.19.1745605216224; Fri, 25 Apr 2025
 11:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com> <20250425125839.71346-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250425125839.71346-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Apr 2025 11:20:03 -0700
X-Gm-Features: ATxdqUH5hw-FUV-rWk989jxgVjOxQ2YQlhj3aS2_ZHuHbz4u07f6uiuhpKfOb-k
Message-ID: <CAEf4BzZc=RORQTWdTO4T2VvXqn_7+u=WH6hxJjMR-JKTFeMnEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: implement dynptr copy kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 5:59=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> This patch introduces a new set of kfuncs for working with dynptrs in
> BPF programs, enabling reading variable-length user or kernel data
> into dynptr directly. To enable memory-safety, verifier allows only
> constant-sized reads via existing bpf_probe_read_{user|kernel} etc.
> kfuncs, dynptr-based kfuncs allow dynamically-sized reads without memory
> safety shortcomings.
>
> The following kfuncs are introduced:
> * `bpf_probe_read_kernel_dynptr()`: probes kernel-space data into a dynpt=
r
> * `bpf_probe_read_user_dynptr()`: probes user-space data into a dynptr
> * `bpf_probe_read_kernel_str_dynptr()`: probes kernel-space string into
> a dynptr
> * `bpf_probe_read_user_str_dynptr()`: probes user-space string into a
> dynptr
> * `bpf_copy_from_user_dynptr()`: sleepable, copies user-space data into
> a dynptr for the current task
> * `bpf_copy_from_user_str_dynptr()`: sleepable, copies user-space string
> into a dynptr for the current task
> * `bpf_copy_from_user_task_dynptr()`: sleepable, copies user-space data
> of the task into a dynptr
> * `bpf_copy_from_user_task_str_dynptr()`: sleepable, copies user-space
> string of the task into a dynptr
>
> The implementation is built on two generic functions:
>  * __bpf_dynptr_copy
>  * __bpf_dynptr_copy_str
> These functions take function pointers as arguments, enabling the
> copying of data from various sources, including both kernel and user
> space. Notably, these indirect calls are typically inlined.

you mean there are no indirect calls due to __bpf_dynptr_copy[_str]
marked as __always_inline, right? We still call
strncpy_from_user_nofault (as one example) as an underlying data
reading step, right?

>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c     |   8 ++
>  kernel/trace/bpf_trace.c | 199 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 207 insertions(+)
>

Logic and code structure look great, few nits around naming below, but
LGTM overall.

Reviewed-by: Andrii Nakryiko <andrii@kernel.org>

> +static __always_inline int copy_kernel_data_nofault(void *dst, const voi=
d *unsafe_src,
> +                                                   u32 size, struct task=
_struct *tsk)
> +{
> +       if (WARN_ON_ONCE(tsk))
> +               return -EFAULT;
> +
> +       return copy_from_kernel_nofault(dst, unsafe_src, size);
> +}
> +
> +static __always_inline int copy_user_data_str_nofault(void *dst, const v=
oid __user *unsafe_src,

"user_data_str" is a bit mouthful, maybe just "copy_user_str_nofault"?

> +                                                     u32 size, struct ta=
sk_struct *tsk)
> +{
> +       if (WARN_ON_ONCE(tsk))
> +               return -EFAULT;
> +
> +       return strncpy_from_user_nofault(dst, unsafe_src, size);
> +}
> +
> +static __always_inline int copy_user_data_str_sleepable(void *dst, const=
 void __user *unsafe_src,
> +                                                       u32 size, struct =
task_struct *tsk)
> +{
> +       int ret;
> +
> +       if (unlikely(size =3D=3D 0))
> +               return 0;
> +
> +       if (tsk) {
> +               ret =3D copy_remote_vm_str(tsk, (unsigned long)unsafe_src=
, dst, size, 0);
> +       } else {
> +               ret =3D strncpy_from_user(dst, unsafe_src, size - 1);
> +               /* strncpy_from_user does not guarantee NUL termination *=
/
> +               if (ret >=3D 0)
> +                       ((char *)dst)[ret] =3D '\0';
> +       }
> +
> +       if (ret < 0)
> +               return ret;
> +       return ret + 1;
> +}
> +
> +static __always_inline int copy_kernel_data_str_nofault(void *dst, const=
 void *unsafe_src,
> +                                                       u32 size, struct =
task_struct *tsk)

ditto here and above, "data_str" is confusing. let's use "data" for
fixed-size reads and "str" for zero-terminated strings?

> +{
> +       if (WARN_ON_ONCE(tsk))
> +               return -EFAULT;
> +
> +       return strncpy_from_kernel_nofault(dst, unsafe_src, size);
> +}
> +
>  __bpf_kfunc_start_defs();
>
>  __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, =
enum pid_type type,

[...]

