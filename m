Return-Path: <bpf+bounces-61473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C6BAE73A6
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9B2168520
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2086D17;
	Wed, 25 Jun 2025 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoqVKqUY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332C3FD1
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 00:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810310; cv=none; b=nYTA3lZxWZD3iDdAM7Vmr13XOVaj5VzeIw3gZdGsWmj0c3DAgOF24VDlF1+nyyHQVMZu56LTqPVHIlsatlZM55++afYi8aNy5GH/tRk30peE7MMftjJ5MizGZakan/OL32iok+9+x2bM1eL99G0upbL2jNgyxvdj8vzT0vu2L2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810310; c=relaxed/simple;
	bh=oGzx7uvaT56Z25xwgfzoaQN2TYRPiGwHaDQzRG/Y+FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m56gVVUcTGpGSjsNDetkm4FC0DNFf1NDXj3De5wGW9gJsUSUu0X03iuVL+Y/b4zyZvoyWHSbXndEf/jLGF8Mn+DoX0Ry20OaRArK/1Q0mf5lAhoAi6oQyIMN757ROujsX2IjX2/T8Oro9RzupC1q1Om3QVL15x6xs9tNxbOExo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoqVKqUY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a5257748e1so3984050f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750810307; x=1751415107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsf12Ltjwy5rP/qG/RgLzBYI040b+2yYb3tQ7UWbSFo=;
        b=KoqVKqUYkOiv6yChzp8f1wsWdi9AdgpflVhx8SRMGgRKD3a6CeMJdcceWFKja292jr
         dS4XDQPhNyZANAfTx7noNrt/w16ME8xpNPtKRhi3QjaDlvYEw3r/9aLd55OeHbx5nSvu
         LbFFAhUnQbtEOkevBTnsFNSVZxo+1sW/eQZMgWUzK1tg5ProwuRhxT2kMa1sWE/oUSLG
         L5jlDGa9zg16L9evd1WEuP4UKAxDOKXmbeDqfHn8tvFb2X+eg0e4Gk6vwAOBDUzwMumr
         b75bOdwJX6oSAEdFCjNXTTrPNjkbQUn9AYJz4h4k4doNXVVpf4tpEyZ6LwE/ni29Ok1K
         UK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750810307; x=1751415107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsf12Ltjwy5rP/qG/RgLzBYI040b+2yYb3tQ7UWbSFo=;
        b=CHNdcxpOD5CP3RS0Wz7sibcotsIaz5XwQG6jBK1PcCqAnFzL2gaeW5XqiYH07A+nA2
         FIMf4k0WYZ1MdkfzTnYpjQGv7CXm012EoVNnfaH/vfjrj9oC1nuKnPYuXdKk3B5AGpwa
         g5AcHaObQGQENsKiCugyUtTjEiM/MxErYX8CHoBXLEiW/u/LaTgm5/zaaeSJLdylc4BN
         HfEw2mZRNdQ/U0QpmC140BXV+KtFhmhuGfy0pz6BNyvTcwDoc6SQyoZiWF7tr6mThUAP
         0INrwhztumZ/kUiByAAnQy0QxmnGOmPyB8HplPs88ITyjPDuwyBsXT9mH+2nZcbYqbwf
         gmbw==
X-Gm-Message-State: AOJu0YxOXKY9soi+f1t31uoPVVaGbYTcPd5rBpv3td3PLO8/emS/2dMk
	iOAulK9lKNbnT/xxHThJEiHKkZeWsTQqgYKQe/aJ/+hftNIez1uv5l8D7eqKY12yjxWBGKvpYbB
	mbm6ooR7TRhZjAVDj3ZkdBYhZCTXH01o=
X-Gm-Gg: ASbGnctjOq5kG17jVbWFR3CwGVgAqc/FXkcvAH+ksWiR70IOOaFNLzrVX6Tsap1JmRp
	sMe/fE6sLWBgvp/n5zaNvINgWHU5NEC9BF/++SvfUIyYW20rlHWKonjG08ZNuBjyIFcnBKK9uJ4
	Q6xjkqsgRym0hdpcMlXXxIMoXZNVhqXSaV8VREEyHl+13l3b1fiBYE+S9GQm38Zvk2oleAmdzS
X-Google-Smtp-Source: AGHT+IF9P+fRaEctC8qVUUhnukzp9eEZorVag0JLNMDuM28w7GdjYhGzA3fsfZfXShnRui73sAwB2VKaH5s4sLJNxp8=
X-Received: by 2002:a05:6000:40cf:b0:3a4:d02e:84af with SMTP id
 ffacd0b85a97d-3a6ed67b12bmr405308f8f.58.1750810306752; Tue, 24 Jun 2025
 17:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625000520.2700423-1-eddyz87@gmail.com> <20250625000520.2700423-3-eddyz87@gmail.com>
In-Reply-To: <20250625000520.2700423-3-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 17:11:35 -0700
X-Gm-Features: Ac12FXwAYIfANIF4uWnimmffHJM6dbIOQF4WiDgsTbOUICgkPv0HJT9VcHQRiuQ
Message-ID: <CAADnVQ+OjowmcVdYkAR-VLZUWNbvkG=i78gV4-76YdFJL2DJ6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: allow void* cast using bpf_rdonly_cast()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 5:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Introduce support for `bpf_rdonly_cast(v, 0)`, which casts the value
> `v` to an untyped, untrusted pointer, logically similar to a `void *`.
> The memory pointed to by such a pointer is treated as read-only.
> As with other untrusted pointers, memory access violations on loads
> return zero instead of causing a fault.
>
> Technically:
> - The resulting pointer is represented as a register of type
>   `PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED` with size zero.
> - Offsets within such pointers are not tracked.
> - Same load instructions are allowed to have both
>   `PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED` and `PTR_TO_BTF_ID`
>   as the base pointer types.
>   In such cases, `bpf_insn_aux_data->ptr_type` is considered the
>   weaker of the two: `PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED`.
>
> The following constraints apply to the new pointer type:
> - can be used as a base for LDX instructions;
> - can't be used as a base for ST/STX or atomic instructions;
> - can't be used as parameter for kfuncs or helpers.
>
> These constraints are enforced by existing handling of `MEM_RDONLY`
> flag and `PTR_TO_MEM` of size zero.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 75 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 62 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 71de4c9487d5..6b2c38b7a7b6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -45,7 +45,8 @@ static const struct bpf_verifier_ops * const bpf_verifi=
er_ops[] =3D {
>  };
>
>  enum bpf_features {
> -       __MAX_BPF_FEAT =3D 0,
> +       BPF_FEAT_RDONLY_CAST_TO_VOID =3D 0,
> +       __MAX_BPF_FEAT =3D 1,

and the idea is to manually adjust it every time?!
That's way too much churn.
Either remove it or keep it without assignment.
Just as __MAX_BPF_FEAT. Like similar thing in enum bpf_link_type.

--
pw-bot: cr

