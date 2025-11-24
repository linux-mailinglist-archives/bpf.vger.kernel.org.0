Return-Path: <bpf+bounces-75375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4E2C81E69
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 777CF3413E5
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1DD2C21C7;
	Mon, 24 Nov 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXxP1Gvb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA152C0F78
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005361; cv=none; b=svWS+rww2X1qY4T2A5yUvbGXea8bQMr2ytY+clLQJ9O/CnFzecd3nSbq4J549iaFfHM13iZb1s7gGZnwcXqCLWUNAJOB+zBLArnZA5kHHYKLIitPvhOAwGaaB1hIMoHspixADJ3/2s//Y+d6BhmhLoV3W4six4fo4hZoU2qp4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005361; c=relaxed/simple;
	bh=FoylFAiO9KowQfkIFKH3vKLbZCgq3ObHmL1ChBnRRzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1KJRHbldzqSCDXaPsxnc4rz/Wd6nEKpHnk5dmKFDLaWIE7w4KiQXknadwKQIojsNNsOZgHXpnRVgAA5ImqCJZ3wsD80qnBEFSH3JuBFs1ukv4rV2Lw0louIYwHEMMnShRPmv9/YII8WyHjoAjKMfED+q2/Hr5clznAmHuHuJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXxP1Gvb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2984dfae043so41253375ad.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 09:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764005359; x=1764610159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+W4e9tsLLDkjXHZFulNlCiJOde7gp/Rv9ZKDvziLc8=;
        b=mXxP1GvbRkQ3uXtUnO1XtEl3G0h252o43bRE8qr9A618xgvZV2w5TuhxxOwU4c3qjz
         /noe93A17WClT1n14D2S1Z3wQCm0QIUGbhkfGRZ/8mccM66tT3jA4hDoue2QHmMTJCGX
         hmBC6mvHvmV+Ig+wpvfV0nLq3OdEpLxfYOETuY7872hO2GBtx5fa+1kL/435X/OkLScz
         i+Yru1gYCZjsH5l8aQo6yTMA7VO5A5FQZsoVnYYS++caVCXF5F2ILiwAIA7yXnyF1Nrd
         q2k80bOrx5zTcvNusn1ViifrNhUCQDNRlh0ZLFutfpuQ2ukQQD7CVC3Gb91gk+N57QBo
         jQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764005359; x=1764610159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+W4e9tsLLDkjXHZFulNlCiJOde7gp/Rv9ZKDvziLc8=;
        b=DZpsFIxx73TDVecT5JM+/seLwarawBKVoc0OnTCnnxH3OGliT+dGN+YfsU3UWRAxwY
         5TNk8pTJhm5Ku21OWIW1s41OJZGJgJ/igS2kvZkMZml5Srxb3FZ/v6jARJyNUwm3ZEOr
         eVhQgiJOUEcPtsGdB/EqphM+Wb3hPWJ6DBm04CqkqJXOUZBeYaydtOf4EnhK9JNe1xVp
         FLfOWUVSWwVsOcRn8S/RTxchgi96sZWr+konp4s2q0CVFe76zecg8i7Ju6ZU2wxJ/Hc7
         vVGhunJZk+A4Q5Jzp01DQJ5PkfLxg7r/qIQ7+7YABlHRG9LD5cFKLcX5MdMQ0wuPn6la
         kwNw==
X-Forwarded-Encrypted: i=1; AJvYcCW2fFnafZwcDDsvpDFpIio5zeZyZx1aRqsc7VnXR2VK7akeVHZuoE5bkXzNsQQdDf7G3FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrlsS02aywM9MALCibthTRJvKwGXJF8MsZ6ZjXKjVFND0L5Zq
	v+givrv5yERSjBwdWCa8VgaqtvSaHUImFfEMtz60N8vcZOnJ6+yjw1+nWSildaXaSKHXdn3Vumi
	WiGKYA6CmotStBYheYQcNtDE9rsjLqO0=
X-Gm-Gg: ASbGncuIhCCs5pSACT8sAy1bIarJoBydgTFDgu1AVbQ8ykbN3Nm9wVi2z4HgqFhgN/2
	SrG8fA7/BI7X0Tc/vk4kjhTcsw5HevXtYLQtZR+NMbFlEGtnB2M6Qzh1Je/6d0QpRRXxqTey0OU
	wYktFWDTH74tHJtSs6ccGNQwHOuCx3IqXPt5fdk30iHz4ga6/sAOtN091qxrb1zCPBPJK5HiVmg
	isMHGKDxe0uBbrZGrlbqWE3Wn37MufvkG1Jdxgp1AvceE/+LsL427+8xH498iVKM2/Bk0C/RlyE
	5DexGIdNXg==
X-Google-Smtp-Source: AGHT+IFcyL1ClADEA5dEboCZAQK1oIgyZ2Mg8rp8aMYlGLirFt9u6vBIK6YnvuajYKkeKGRbmFXyxY28CKfVC9nhIDU=
X-Received: by 2002:a17:903:1904:b0:298:616b:b2d with SMTP id
 d9443c01a7336-29b6c6b1bf9mr98990655ad.51.1764005358873; Mon, 24 Nov 2025
 09:29:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117083551.517393-1-jolsa@kernel.org> <20251117083551.517393-3-jolsa@kernel.org>
In-Reply-To: <20251117083551.517393-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Nov 2025 09:29:05 -0800
X-Gm-Features: AWmQ_bnSzsniHWAW-fBRzrYdA-6gomZNfUopzRa-9u__Y0W6MXGvqX425Syhag0
Message-ID: <CAEf4BzaXac7JyAOXA8+cFj7ZgORHdVxCHceFv417t1xqAe94HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: Add uprobe syscall feature detection
To: Jiri Olsa <jolsa@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Adding uprobe syscall feature detection that will be used
> in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/features.c        | 22 ++++++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  2 files changed, 24 insertions(+)
>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b842b83e2480..587571c21d2d 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -506,6 +506,25 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>         return probe_fd(prog_fd);
>  }
>
> +#ifdef __x86_64__

nit: <empty line here>, give the code a bit of breathing room :)
> +#ifndef __NR_uprobe
> +#define __NR_uprobe 336
> +#endif

<empty line>

> +static int probe_uprobe_syscall(int token_fd)
> +{
> +       /*
> +        * When not executed from executed kernel provided trampoline,

"executed from executed kernel"? Maybe: "If kernel supports uprobe()
syscall, it will return -ENXIO when called from the outside of a
kernel-generated uprobe trampoline."? Otherwise it will be -ENOSYS or
something like this, right?

> +        * the uprobe syscall returns ENXIO error.
> +        */
> +       return syscall(__NR_uprobe) =3D=3D -1 && errno =3D=3D ENXIO;

nit: please use < 0 check for consistency with other error checking
logic everywhere else


> +}
> +#else
> +static int probe_uprobe_syscall(int token_fd)
> +{
> +       return 0;
> +}
> +#endif
> +
>  typedef int (*feature_probe_fn)(int /* token_fd */);
>
>  static struct kern_feature_cache feature_cache;
> @@ -581,6 +600,9 @@ static struct kern_feature_desc {
>         [FEAT_BTF_QMARK_DATASEC] =3D {
>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qma=
rk_datasec,
>         },
> +       [FEAT_UPROBE_SYSCALL] =3D {
> +               "Kernel supports uprobe syscall", probe_uprobe_syscall,
> +       },
>  };
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index fc59b21b51b5..69aa61c038a9 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -392,6 +392,8 @@ enum kern_feature_id {
>         FEAT_ARG_CTX_TAG,
>         /* Kernel supports '?' at the front of datasec names */
>         FEAT_BTF_QMARK_DATASEC,
> +       /* Kernel supports uprobe syscall */
> +       FEAT_UPROBE_SYSCALL,
>         __FEAT_CNT,
>  };
>
> --
> 2.51.1
>

