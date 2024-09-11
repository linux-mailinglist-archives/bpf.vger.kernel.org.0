Return-Path: <bpf+bounces-39631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC49757A2
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61871C2629D
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511961B1D44;
	Wed, 11 Sep 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDcpAxZN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381551AC435
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069950; cv=none; b=rKs2r/7POYEmQg5kQly1xT+wfamLkFWkHEBcX+IcFxY7z96rwq6/DIs7Pi4LRi9C9/ufIqnwl+hhMSIL/3BK8D0NbNayR2uXoK0/OU2ZI/6ZDJWKFsaoJjcR6cGZH+T6NurujpZIAFWKna6VKRgnIqo84MQAbyDGf/4yx8bnbfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069950; c=relaxed/simple;
	bh=MAm91h+lr6pqEybIQdAFKbu5lHuivjg0gAJ68+ozGRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1MkQn5Tzs+RIHjwccifzRC++9XfggqG1+6lwsir+5eJJx0vaLw8kmLjJZPTLKCwQBWXE6B8AjLVpvsrgailNiAw43L0EDH8mpWZJdIaAsfYBsnw7L2eMHB5z17fmA55eJhkcbtHgQSFci6tpeH+T1sSNHaM47K3usrII6QwJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDcpAxZN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so2788f8f.3
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726069947; x=1726674747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQr4wmjfniBtcEDrbWM2u1ob3VxqPKNJ5hGVt3GltBU=;
        b=TDcpAxZNrsV9FJKU+vslTq+ix7Gu0k7uHy6m5uGrhgx0vQ6Ntf3e7okWKw4zokqY1z
         nAzDMBo1u1GQ53QqL0p9Gd/fsEKho+tIcDlp7iFMUC/NK6q0EWl5cpsqdTtFzxi6z9aO
         NKKAVYC4tGYgDprYDP8KUctVvC6u4Z7eARXs8ezLbRkVXtqc1HC4V4rFVZwE1LHpuNYh
         gp8y+5nhEM0hP7rR7b9FH4Ew+7fMPwETo53hbnZtKa7OetcflR3ku93uyrhsldE51CSG
         7+2WSvf6U0Kxor/1NNQuwlUXuJan83Rv56UM3nqVjIazjN4EM1vyktGA6/QJiQCrVN/z
         uvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726069947; x=1726674747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQr4wmjfniBtcEDrbWM2u1ob3VxqPKNJ5hGVt3GltBU=;
        b=MNqA+Fb+jTClIXH5wQxmu5T7LXG3qwULfjv9finUCQS2XONhVakwY14FLdFQJANFZv
         PFXDxUWIiR6bfDVmSKUwGQ87nqOmirs8ZdPktBWUk2QMRm4P3GWrH1nLJw1e6jnJXQE+
         y1ld7flZaytEGxErivhDzLTdCPBfOAl0zKReHwmZhotXHNUcbbKgDvOnSJlUM6mk9D1V
         kUQtaa1UfIWo1/Ud3pz5spkSNIvdy7c7jA2OmXmJlZRV1Gtvo2rDelECvaXl4BUEgGqr
         H74JeXACHREWve+s+AnkQHeJnVANXiW5TBhor8v69rgfkIqgnXVDVKMZ2UehbMRhGizu
         vy1A==
X-Gm-Message-State: AOJu0YxpjtiDA3ndvpvPt+xBg+N4Nm9sR52lcqgS2rRIc1KisUr2fITH
	ZSCox+uSZFpuci87l4flTjfxVU7xOJ1zCHh51sOXF4RWAw5r8h5rSuCq05xpLkemTFEkHxiRDhO
	JIaNQ0Jmrx1EJqaNPhUfY4xPTvro=
X-Google-Smtp-Source: AGHT+IER4xeRpk6aCbfFQ6GvBUsc/FysnPbYQAmL+jq0gNYoo/WC9hJlOdw/uOVx1Vtizz5N3PTlaK4y7s+oQeJhJY4=
X-Received: by 2002:adf:fe02:0:b0:374:c29a:a0d6 with SMTP id
 ffacd0b85a97d-3789229bbeamr12337848f8f.2.1726069947018; Wed, 11 Sep 2024
 08:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911044017.2261738-1-yonghong.song@linux.dev>
In-Reply-To: <20240911044017.2261738-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Sep 2024 08:52:15 -0700
Message-ID: <CAADnVQL=s8dZ1qAnMUnFxCY4WRuhcHFOGPRtL8zsEvySZN8ReA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix a sdiv overflow issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Zac Ecob <zacecob@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 9:40=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Zac Ecob reported a problem where a bpf program may cause kernel crash du=
e
> to the following error:
>   Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
>
> The failure is due to the below signed divide:
>   LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
> LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,775,=
808,
> but it is impossible since for 64-bit system, the maximum positive
> number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
> cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
> LLONG_MIN.
>
> So for 64-bit signed divide (sdiv), some additional insns are patched
> to check LLONG_MIN/-1 pattern. If such a pattern does exist, the result
> will be LLONG_MIN. Otherwise, it follows normal sdiv operation.
>
>   [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZp=
AaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=3D@pro=
tonmail.com/
>
> Reported-by: Zac Ecob <zacecob@protonmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f35b80c16cda..d77f1a05a065 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20506,6 +20506,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                     insn->code =3D=3D (BPF_ALU | BPF_DIV | BPF_X)) {
>                         bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_AL=
U64;
>                         bool isdiv =3D BPF_OP(insn->code) =3D=3D BPF_DIV;
> +                       bool is_sdiv64 =3D is64 && isdiv && insn->off =3D=
=3D 1;

I suspect signed mod has the same issue.

Also is it only a 64-bit ? 32-bit sdiv/smod are also affected, no?

pw-bot: cr

