Return-Path: <bpf+bounces-78416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D252D0C725
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2839F300BEED
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8871934575D;
	Fri,  9 Jan 2026 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyM1YVEb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD8221F03
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997188; cv=none; b=VpCB/v2MUQWRa+o4bVRAiCu7vVcryRYl2fOr+INsNvG8cPaZHFybFNNaTgLm5jTd8HVWRCV8JPwjYJ7RIk6CA5omPLLYjhcBijBVZSYgTEwQl616jHdmDwXj3nDjRUVS6Mjp8HJoG23Iu7UQyA23tpy5CVnAnzAj+abepSnWcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997188; c=relaxed/simple;
	bh=Vw5vtXpXPT8YmGu/D5QxFDPFmnrcahJfsYJqLDGVzQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8txCgdAWvFmhEDd2yQHHKuEPLu9wh5CodqbwazW/3gLILugF3hLKY+MxiYREts2q8/r/6FQd7Fp3LmCX6hl49tqKJGFyt8TIVNUpuFrEBLPZaTHJ60EqhiEe3rRIyqijMAO3tRgWG+veNnbLMF8X39cm96rO6rwYC7Wm5wdvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyM1YVEb; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c2dd0c24e5cso2131633a12.3
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 14:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997186; x=1768601986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDrhot/uN2Nsv3hGvBzWoEj0s0fmF/A6Pk0yRCb0Mps=;
        b=iyM1YVEbUUquR95ASK3PIXCP+ABWzrHkA5J0aili/GAkCzHcIFjGlGcB7Tn2/EyY3N
         0IIiQUxdBDhwUmdr8FjCO84NokG3h1eM9XVC8H7IW7w6ibDNJ2ecAr7tWRZdxPiOoqsA
         AqZq72/SUL+ElYhsxGKMG5u1u0MjXKVeZIyDLpGHBiQSsN1SHUL5Jfa9yIXXYmWppRrq
         AF0oidzsH2jJr+wb7XcgWmLSBGrhEaHMIYiHt1R+FR5Cu4ZdEhzBC8LZ/bdjKlWQQRjk
         Ra6UTb77IflePtZRsh+Mjz5pcbY9Ki2BYqd6sNqbuQ0a5elwrL4Q5F1+0i/4Yl/MNT4Z
         4b1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997186; x=1768601986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JDrhot/uN2Nsv3hGvBzWoEj0s0fmF/A6Pk0yRCb0Mps=;
        b=FqHv/wK+X5xD5b7mdNt/qArss1WB/vCQfHSczq0GpvYY1HXIegOLjk/R/dFgkL2Fm3
         T/4Vr+Fmq+oomTPERwjqDwfNeIeggNIUnkK7x7qXrsvdPlu+jrty50nfKuXjqJLELqDD
         lD0UzYIiQof2uHWMn1DKkSiiKNxUn+rM/T58t8kx5FdgionlvF4ffJc97Cm+EGAPj61Z
         AQoSyDqwKCmaQAEewTPKcu2DLFVvLn+I92MwYnb40KYKmRLOgzRjniwWwfnjKIC/2Qji
         bDRcOK69Xa7sDp/yxWYdv6NQ7ZZOspu5V4rg+/YboBPNZtOWixLBO+7I6Is+RuC7cEkh
         hN0g==
X-Gm-Message-State: AOJu0YwNYmDR6+SGuzHWQbOPPkJhGGaM9rcW3SoLmT5C8zZn66wSOx08
	SsVMwIUWk7yGzzBmSN8Mp5wJhYnjtvYRMl3bWwjKxc5frjTUTPXlSdMs/1uEq12r95C2PQ+YjcO
	jJCjWDtOcH/393pcyp1+Suj6KkwPwsgE=
X-Gm-Gg: AY/fxX4NDxNPNx0GzqS1U0P0aqKoSzdH+XRBmu7rFN36ez4eY/08yXCn4UBsW3A4bpr
	/IJrBVxMe7AoKxD2NbCaF4aCZlz53e46xh0aVta6xOD1vjBR0229X8CE5M20r2HWn2jKJPX6H2S
	jEC7tUcNpk4JCS64oJC7UtDO0DBgdb7cq6nIvD9ubSPQGA6MiYVqt4QfUydC3TN09VipiXT8+9S
	vcq/u35+j+DghFNSRdqncUmmp+WbuOGxoFyPqPkf1sjankE8HyA78bEnYqk3n2Y+CnwHDEaiH58
	QxlM2f7N
X-Google-Smtp-Source: AGHT+IGWjGt631fMf+CbD+bSmuw661W1UmFT8xu3QSbv8yp/3BpAgXwNquvF78dkDqt4fKO4ITKf4YlL5qXrlpATSDc=
X-Received: by 2002:a17:902:f54e:b0:29d:584e:6349 with SMTP id
 d9443c01a7336-2a3ee451f29mr106376985ad.13.1767997185617; Fri, 09 Jan 2026
 14:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com> <20260107-timer_nolock-v3-7-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-7-740d3ec3e5f9@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 14:19:19 -0800
X-Gm-Features: AQt7F2rAKE79HSbZNaEM45kjPBtqH_AAflT4HaRlb3zKgriiKPqxfM9tdlThchc
Message-ID: <CAEf4BzZXbMzhHx4usag1FxzDn2sfyf7-tJPGW2hnTXgOutdN5g@mail.gmail.com>
Subject: Re: [PATCH RFC v3 07/10] bpf: Introduce bpf_timer_cancel_async() kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:49=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> introducing bpf timer cancel kfunc that attempts canceling timer
> asynchronously, hence, supports working in NMI context.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b90b005a17e1de9c0c62056a665d124b883c6320..1f593df04f326c509398f5019=
07265ec6dae60e9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4439,6 +4439,19 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf=
_dynptr *dynptr)
>         return 0;
>  }
>
> +__bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
> +{
> +       struct bpf_async_cb *cb;
> +       struct bpf_async_kern *async =3D (void *)timer;
> +
> +       guard(rcu)();
> +       cb =3D async->cb;

READ_ONCE(), this cb can be xchg'ed into NULL, and we can't allow
compiler to re-read the pointer


> +       if (!cb)
> +               return -EINVAL;
> +
> +       return bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
> @@ -4620,6 +4633,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_im=
pl)
>  BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_file)
>  BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
> +BTF_ID_FLAGS(func, bpf_timer_cancel_async)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
>
> --
> 2.52.0
>

