Return-Path: <bpf+bounces-70229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDEDBB4E40
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 20:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7446D17E0D2
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 18:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066C3279346;
	Thu,  2 Oct 2025 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+/EVN76"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA33276027
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430096; cv=none; b=OaiYgt/56j8CNmJS1zYuQh3xOqGGgaZRuvt77hxOfTnf2jJeBliB2TwjxeXybnShqHJtZaqJLVDcL4mUhyWFf3D44I67vRXs76VQF8XuAM7LXrSQaDqwM7JfYg5UCA+8XTNluqmYVfYYlnzVCxVbDU5KS3yrpX42DzexDc6fq/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430096; c=relaxed/simple;
	bh=Qc7kDcuKcrwdK88InHinjWMs9GPtvX9GFYLvaYFbMkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bw7OtwLRt1D5k6OFCdsFUst4PAClx4Djxw2rGlW9Nhj7qnaHOvq/x13QY6+NhYgUyP0R5ijxLt2Tl6XJwW7QPgz56Y6qO+I/tDlILr8us1e5IUqwSZDjbpaTKg53ProFy1/a0J+xfddALeFtM1m1jSvw5f99MrlAHoGh+iLWEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+/EVN76; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so14197125e9.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430093; x=1760034893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5Rh5QFgh829/Pn0O2nx/ASS/vTSf9rjMxCiKvL0cCw=;
        b=J+/EVN76CkKK08IJ0Kl0RmhyX7nexFAL65sNu38EVCfTu7qHGMrZVjSMIVK/v6bAsx
         XAXy5bMqbMMIS5h7ohXs6QLQmBqYNzBJ8u0PQQFLRN9VjuKyNp2NU9ocJR01vXK88fMU
         bykpqmPMhwPNM9fuEnS8LjX7EVmfWC2zO2eKRh8q83zQ8ihtzS6yE7LF5bjCc8wOMlof
         FSkc5WWJ4xcahtp3uBsV2T9lmsCnij/caGJL/zDz+9IQUvpHlT6W0ddTZAhxGh+IzbQ8
         GlshbfBQk8d2a/q4Zi71FrueTpYpQhiE7UkL+Lodr5kY4UxU1XCMMKnwDdBVoaWIdjYF
         ze2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430093; x=1760034893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5Rh5QFgh829/Pn0O2nx/ASS/vTSf9rjMxCiKvL0cCw=;
        b=hskFNpmVpEZS9GpKfs9Qyf1T2QtHZddkKIeDbuPYLnNMyecV1UuSr5snMd+Qugaewy
         n4BJL1POachUeMW/23PgO55VFeexMJvNoBax0rKcxEy9CiY4LUmR+Tf2pZSemfVJ5fvX
         Hm26Hs9o4ns7w+xhQTsbv13eB6kgXh2dlLeRbl1ptoKDdfOvWsJkTRRPH+zEnwIjgwer
         14iD0tXkm/++cwTdLvQf+IzizypH4n6uE4vYmpeXu7p+WCrxDNcAKzNooEXDiBvO2asz
         0It19DwcIPw0x+dKJzPEPRQb6RlzLbr8xkoze/oDlbVaUjo3D6o/jES5SzVhhOOfoKzt
         ImbQ==
X-Gm-Message-State: AOJu0YyGRkmnDVjCdvxG/hUmP1ST5fIU8Yhu6YYWeP0N2DSsOQBMu2/F
	BDgbIvkwBlCA/27+wbwfrgeiOJs/0wgqFBd62FF1a0OwiFHwAp5XHifzy+haJQjzusSwUkNoSkf
	OkxunH537B+Gn9pmZDXljGa5ul+R+0mQ=
X-Gm-Gg: ASbGnctZ2rN/0Zct2iS4hh1w2dpEm7aYCDOBa3gnz/OelqcV9KKdD0/7QBK7Va4kVm6
	9MuZZeK6QmbUr9LeJ1PfcvxzM9Nkgsp1xg3EuP5Z2/bjpYqCgNw6NymMtEOtZXw2pAwnurcAQQB
	TQ82aR1wuUsiHMtTb1dIrfVgCFYburb/etLIy+0CCCZOIeIArsr+fiRHBY7qKhe3l4t0NhrM0yJ
	GhUJ2gXhxyi8z+yisErNNoxWQpP78Vx5NeA84Qg1E+7yOA=
X-Google-Smtp-Source: AGHT+IEKoeLEuZgLkjMERXFwPCcY/syDx2ZByjnfM+GoDluMr2Y9QO76AXXpnmkSfai2JsygQlytZwIdzqr2JJzOQTs=
X-Received: by 2002:a5d:5f92:0:b0:3e7:1f63:6e7d with SMTP id
 ffacd0b85a97d-425671c0b98mr182173f8f.45.1759430092729; Thu, 02 Oct 2025
 11:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002154841.99348-1-leon.hwang@linux.dev> <20251002154841.99348-4-leon.hwang@linux.dev>
In-Reply-To: <20251002154841.99348-4-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 11:34:39 -0700
X-Gm-Features: AS18NWAE97sp5K0-E8skDXERjv4kv8keUYPmHMBI83dUqmofPnmdCx6OCpAXpsg
Message-ID: <CAADnVQKarwu9xciE=itxxXDS+DRtdHmVxD3rftuqBU5iu9FYLA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 03/10] bpf: Refactor reporting
 log_true_size for prog_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 8:49=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> In the next commit, it will be able to report logs via extended common
> attributes, which will report 'log_true_size' via the extended common
> attributes meanwhile.
>
> Therefore, refactor the way of 'log_true_size' reporting in order to
> report 'log_true_size' via the extended common attributes easily.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h   |  2 +-
>  kernel/bpf/syscall.c  | 24 ++++++++++++++++++++----
>  kernel/bpf/verifier.c | 12 ++----------
>  3 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a98c833461347..4f595439943d7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2738,7 +2738,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t=
 expected_size,
>                              size_t actual_size);
>
>  /* verify correctness of eBPF program */
> -int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr=
, u32 uattr_size);
> +int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr=
);
>
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>  void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8d97d67e6abaa..2bdc0b43ec832 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2841,7 +2841,7 @@ static int bpf_prog_verify_signature(struct bpf_pro=
g *prog, union bpf_attr *attr
>  /* last field in 'union bpf_attr' used by this command */
>  #define BPF_PROG_LOAD_LAST_FIELD keyring_id
>
> -static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr=
_size)
> +static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
>  {
>         enum bpf_prog_type type =3D attr->prog_type;
>         struct bpf_prog *prog, *dst_prog =3D NULL;
> @@ -3059,7 +3059,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
>                 goto free_prog_sec;
>
>         /* run eBPF verifier */
> -       err =3D bpf_check(&prog, attr, uattr, uattr_size);
> +       err =3D bpf_check(&prog, attr, uattr);
>         if (err < 0)
>                 goto free_used_maps;
>
> @@ -6092,12 +6092,25 @@ static int prog_stream_read(union bpf_attr *attr)
>         return ret;
>  }
>
> +static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t u=
attr, unsigned int size)
> +{
> +       if (!attr->log_true_size)
> +               return 0;

We've been through this many times :(
The commit log says that it's a refactoring patch, but
you introduce this new logic.
Do NOT do it.
If you want to add such additional check, do it in a separate patch
and explain why it's ok.

So why is it ok to skip writing to user space when it's zero?

> +       if (size >=3D offsetofend(union bpf_attr, log_true_size) &&
> +           copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_tru=
e_size),
> +                                 &attr->log_true_size, sizeof(attr->log_=
true_size)))
> +               return -EFAULT;
> +
> +       return 0;
> +}

