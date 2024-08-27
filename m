Return-Path: <bpf+bounces-38210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF039618F2
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 23:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF75BB21F78
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 21:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4751D3631;
	Tue, 27 Aug 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm9D3w0X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF61D2F5C
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792496; cv=none; b=pV+4KVUnfll5bQ/MO+WqlgB03MLNnxUMmg7eJJNwhQ3xsfa5V799g+fbcUK1vZUeeqdxcv3NcKrTa9/iyRfs69ImFswqpElntONyNdkUoKW6TBiw0U3ciIC6GLhzuWg/FpXLnocMBgkH91xcwT9yk5ZB8Vy8kgdqVhEitBfvn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792496; c=relaxed/simple;
	bh=aIvVj5GB7VcDLbNMVHvRWLjgqRh/7swXoZjUbpS5dG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsILwyqlJ61zUi0FJdoUvhjZiwxOFtRl/pC2S3MOAqs9mbARyUtZare3pz6RdtdFJrIS8iPMsv/16QpeANWHidxFcQf67wZDD1X7l2o4jjV81MnVoMFsl0wUe4Qjo4ALooumRuKCUD/GHgOjIaT4hAbvTbY/9wuNwOVNOF0yYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm9D3w0X; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-371a92d8c90so3088482f8f.3
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 14:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724792493; x=1725397293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXozvQ8yAFMtEYsjhmoA8OgUC22pqhoiVfJSYp4fgcU=;
        b=Mm9D3w0XeBftreC1Df/sf7fLeo8H0b+O6wouhoJuXsE6+XnzEq8JG3MhvXjIZsUhDp
         sNPuUUUIOJH+HBiUKIWGba3qvs9zKRyF5wY4q61gqsbRPQBmcpz15yYlNc1xl2BEVONq
         F7QRCD/EXzPe798oqd3HbR9KSw3m3G7qdx/A3jxx4qM109xWbytrDXvADe6AQQpLUa1P
         DHfGRVtRqrCX1+jcCDvqErZSRSMXSbjV7RGkm4j/rls8YVaVlo7573KStVjV7yfDeqFd
         n1br/GZyM+LuqMM047RjhN1rS7EpwaDXqH9+zRcXVyuMsGXO8V4SOdm4pttalQ65fwME
         z6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724792493; x=1725397293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXozvQ8yAFMtEYsjhmoA8OgUC22pqhoiVfJSYp4fgcU=;
        b=qiFawh04N6yZHz8y+WfkvB2cAJHSeDJ+9icKpbIeBiTr4E/irRscc7JQF2bpcQ3l2k
         he9yBj38BbSIEjH94wkakuomKNtTRd5Ir6Xb4zNTYQ9aqBx+Psb0MgitZEUTOsLq6GpL
         3gtAncuNATLfdrAwasBgU3rJ6eeGgf4XZxUeFTwC27OrfkYvGv2YR1Z9hhNxXW67hzy8
         uhpKsn+BSvSrO/dWP8u7/sVYZU9AheabN+QBL7xRt/zZhIdLc1fbARxQsHcgbffyzTCb
         XHTGDqDMNrTMXSXpckuEv+ncMvhfBvuRJ7Ux+vCwi+DWqvHMgcfF2Uyu5pI56DLiZSfe
         c/lA==
X-Forwarded-Encrypted: i=1; AJvYcCUwzSP6WRt7vfwwbjd1wKmGnIKzuJfcnog8LR0JlpHy0Ltlyg6mRq+qDi0vcnRheFXm0Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0I8jRrhC3+NLxY7hdjoDxR/1JBCZBVIGySEm8jJbYkaw4g07
	s3VzEhxg9yCF1Eh/lptvImuimv1QRbNPt4UNDbmmE/2cufINdSxN5FVSH3fNugL0CnMPj6La2dI
	b3AoU7FXT8RAAaC03h9oob0Yu9IM=
X-Google-Smtp-Source: AGHT+IH5kNejjb7CdlX1AG65ecmLJBgfIl1Y/n1AhTWYemFKKYxxMal6c61kiFbDTelq9X+/YW9JuuWbplHyAlRvXAU=
X-Received: by 2002:a5d:428f:0:b0:371:8277:6649 with SMTP id
 ffacd0b85a97d-3748c7c7892mr2571797f8f.2.1724792492573; Tue, 27 Aug 2024
 14:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826224814.289034-1-inwardvessel@gmail.com> <20240826224814.289034-2-inwardvessel@gmail.com>
In-Reply-To: <20240826224814.289034-2-inwardvessel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Aug 2024 14:01:21 -0700
Message-ID: <CAADnVQJp3Me_tXRs6Nupbi93bAj2D-sFuN-N7DMfKU=EtMu5ow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: new btf kfunc hooks for tracepoint
 and perf event
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 3:48=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> The additional hooks (and prog-to-hook mapping) for tracepoint and perf
> event programs allow for registering kfuncs to be used within these
> program types.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  kernel/bpf/btf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 520f49f422fe..4816e309314e 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -210,6 +210,7 @@ enum btf_kfunc_hook {
>         BTF_KFUNC_HOOK_TC,
>         BTF_KFUNC_HOOK_STRUCT_OPS,
>         BTF_KFUNC_HOOK_TRACING,
> +       BTF_KFUNC_HOOK_TRACEPOINT,
>         BTF_KFUNC_HOOK_SYSCALL,
>         BTF_KFUNC_HOOK_FMODRET,
>         BTF_KFUNC_HOOK_CGROUP_SKB,
> @@ -219,6 +220,7 @@ enum btf_kfunc_hook {
>         BTF_KFUNC_HOOK_LWT,
>         BTF_KFUNC_HOOK_NETFILTER,
>         BTF_KFUNC_HOOK_KPROBE,
> +       BTF_KFUNC_HOOK_PERF_EVENT,
>         BTF_KFUNC_HOOK_MAX,
>  };
>
> @@ -8306,6 +8308,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_pro=
g_type prog_type)
>         case BPF_PROG_TYPE_TRACING:
>         case BPF_PROG_TYPE_LSM:
>                 return BTF_KFUNC_HOOK_TRACING;
> +       case BPF_PROG_TYPE_TRACEPOINT:
> +               return BTF_KFUNC_HOOK_TRACEPOINT;

why special case tp and perf_event and only limit them to cpumask?
The following would be equally safe, no?
         case BPF_PROG_TYPE_TRACING:
         case BPF_PROG_TYPE_LSM:
 +       case BPF_PROG_TYPE_TRACEPOINT:
 +       case BPF_PROG_TYPE_PERF_EVENT:
                return BTF_KFUNC_HOOK_TRACING;
?

