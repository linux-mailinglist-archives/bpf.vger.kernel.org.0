Return-Path: <bpf+bounces-56364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A35FA95AB4
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B897A308A
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 01:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF801922C4;
	Tue, 22 Apr 2025 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR/OrQLS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA25645;
	Tue, 22 Apr 2025 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286802; cv=none; b=Z7BYe7QqViutyLoF0JhU0oeO1Eu7L3TLpPDQVJflyuEL4yfOPqNlUYt5kTCxvMGBtJlKZNu+Ur4DExSPlsb5umxbYbdY2Myx4mfB+C+Ay8bhabjuH6TD5mlQGgcwd6FauDnSaNRBgqI1Kmo6hLmScKJWsYp8UiQhqu2yYNpRpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286802; c=relaxed/simple;
	bh=9/Gp41Nj4fyCpab9jidsNFSw5KJZh/4V6W2yG+43wjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKTk/ihPA0cMQBhzZLlhy0/E0JvRwakzKI43MAMnDUERxEBRvLORZ2Nyht69IoV12o7K4PepzL6A6sZejRzCJlUvi9HCrjED4s0oKRpETAPkBJI8stZzt/nkCc8PslWhZLjg51ZmII1khxXcYvF2ov53GPm4ouvdW6RBqCysPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TR/OrQLS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso44590295e9.2;
        Mon, 21 Apr 2025 18:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745286799; x=1745891599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfvktjZv01Gj5yOFSx7wh/p5A8watYNH/WSAyys/EaA=;
        b=TR/OrQLSKMD0wC34k33QWZLTSBMQdBlGrarQ/ZJA66kooDDgB3eFIURuyEr9LfkeZ1
         ikYvl0guJb+IjKaYp9lKlzxsq65RsF09urGEBpV2BaX9zjwrp3sEOEiRcwG7+dZ1XyVF
         y04UKL/Uc+OXn9sGbm3EyJY66++i4fS0gFCnyQbiU9Rjac+PxzfEL3BLvlyiVsQVeHS/
         G2oqM84Ziag1G+VNvS9D+78NoGsEz1kUYcnHuUNd0oIpzble7DcqsihpApQo3OULemjy
         XTAWstfH0Wv+By6MsjNry/Haj83rq++VjijpfVO7+paW8oGjgfwxoPN9WoiLDRu23JNd
         P+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745286799; x=1745891599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfvktjZv01Gj5yOFSx7wh/p5A8watYNH/WSAyys/EaA=;
        b=PdC/NvNKWmOauc0yyGrVtvSibKg2DWXdxIrbKfjkifQjdBB7gFR7/XTmvWoBvOLt4l
         VrczTJ9/8ObpTyBMu4BRh6Ysb9NRQYwZfe9lVqT2x18jiChvFjwbvmaN73QPYomXsAWV
         tDZdfv1hKLais1idK3Cir4T1e16uKZuvuaCjSVV1GIzx6enS/Rjxa9HVVr+9erfPYHpo
         9lTErVBjQ3xY9lzSzwx1bw2cwoAy+P46aCkoCVxeJ2S45P5wXan2QZfkHcUYvFk2MqAD
         bKuWII9j99lAvmw5bOqNGq+1sk1zvlPf5YTwm/EkSF6+lzJ3EFFn5dP4/H7X0pIkrRX6
         /XJw==
X-Forwarded-Encrypted: i=1; AJvYcCUhnNhmuO7zZ1iouK6/Z8IIuwQm2r+q5AvksVhm5WRohD/sHpzlKPeBOqjBGf32GZ0spx/HOpy4Ftxvn2lW@vger.kernel.org, AJvYcCVNtdWmK+cIeruw6d/Uz9Kvu0uAHfqmZRadHonORdOiWPPMjtK16kHltrarTHPxz3B7hPPWa67oAy5RBIAZFDmxxFzZ@vger.kernel.org, AJvYcCVPVspNxadOZhS+2kH53JSxBjI2tTYDjwmCRQ87qDA6KU1bdGbNpqzAkZeniyuICT9WAzR9LYaR@vger.kernel.org, AJvYcCWKAf5UG0KXxngQWh03fk/qhbOpSLmig4lZMLPwEAIhXzbfkpdcvnCQNi38Zfdi/S39iv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKZ4uVrFYcx0rq/rjTO1K5aKQvt35PUb6Ba6UBJUFLmC9FJ3G
	i2tYXbwelBEEwhZqD1OJ6fQzw7gAJ1eEB6vn64l5WgNpG7pYRw8yLPJYIkiCIQwxzW8TQsvwBtN
	l7sI2baL2IyhHxEdyklD0qXgv+bo=
X-Gm-Gg: ASbGncvXbF/Y4Shh6VyAHItA32AEYiHU+A8tVkGNoMXNVam/xq+OXJOn1acblJ66c+2
	KmnLYHgiZw4KfxtIAN0DZyCqv+DdloGX8Swosk6aqIYM7h56o6QqNBVmouH1wfdDE1R3oSNvj7E
	s0xuAZ7FpHSi8FQHTNwWj6WAalAbQ7Y7ssiqrpGA==
X-Google-Smtp-Source: AGHT+IH/pGw08v9ztRrFp9vvkSv8Wp7CIlNdwvbhoNWjWiv31plZAX9GpfvjYhhosYMVDhoLLuZmgA2hGoM7a/g1+aI=
X-Received: by 2002:a05:600c:4708:b0:43d:300f:fa4a with SMTP id
 5b1f17b1804b1-4406ab97c6cmr111382045e9.12.1745286799172; Mon, 21 Apr 2025
 18:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418034055.5757-1-yangfeng59949@163.com>
In-Reply-To: <20250418034055.5757-1-yangfeng59949@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Apr 2025 18:53:07 -0700
X-Gm-Features: ATxdqUEWtQel_AzXDM0gOyJhoV4DM0Xxipiggq7IXcLLFfCggGMNLvcU6KuebrE
Message-ID: <CAADnVQLnij-d3Hif1x8ocoYD=8sZG67qACXPZhK78cpYKczwkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Remove bpf_get_smp_processor_id_proto
To: Feng Yang <yangfeng59949@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Feng Yang <yangfeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 8:41=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> All BPF programs either disable CPU preemption or CPU migration,
> so the bpf_get_smp_processor_id_proto can be safely removed,
> and the bpf_get_raw_smp_processor_id_proto in bpf_base_func_proto works p=
erfectly.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  include/linux/bpf.h      |  1 -
>  kernel/bpf/core.c        |  1 -
>  kernel/bpf/helpers.c     | 12 ------------
>  kernel/trace/bpf_trace.c |  2 --
>  net/core/filter.c        |  6 ------
>  5 files changed, 22 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3f0cc89c0622..36e525141556 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3316,7 +3316,6 @@ extern const struct bpf_func_proto bpf_map_peek_ele=
m_proto;
>  extern const struct bpf_func_proto bpf_map_lookup_percpu_elem_proto;
>
>  extern const struct bpf_func_proto bpf_get_prandom_u32_proto;
> -extern const struct bpf_func_proto bpf_get_smp_processor_id_proto;
>  extern const struct bpf_func_proto bpf_get_numa_node_id_proto;
>  extern const struct bpf_func_proto bpf_tail_call_proto;
>  extern const struct bpf_func_proto bpf_ktime_get_ns_proto;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ba6b6118cf50..1ad41a16b86e 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2943,7 +2943,6 @@ const struct bpf_func_proto bpf_spin_unlock_proto _=
_weak;
>  const struct bpf_func_proto bpf_jiffies64_proto __weak;
>
>  const struct bpf_func_proto bpf_get_prandom_u32_proto __weak;
> -const struct bpf_func_proto bpf_get_smp_processor_id_proto __weak;
>  const struct bpf_func_proto bpf_get_numa_node_id_proto __weak;
>  const struct bpf_func_proto bpf_ktime_get_ns_proto __weak;
>  const struct bpf_func_proto bpf_ktime_get_boot_ns_proto __weak;
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e3a2662f4e33..2d2bfb2911f8 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -149,18 +149,6 @@ const struct bpf_func_proto bpf_get_prandom_u32_prot=
o =3D {
>         .ret_type       =3D RET_INTEGER,
>  };
>
> -BPF_CALL_0(bpf_get_smp_processor_id)
> -{
> -       return smp_processor_id();
> -}
> -
> -const struct bpf_func_proto bpf_get_smp_processor_id_proto =3D {
> -       .func           =3D bpf_get_smp_processor_id,
> -       .gpl_only       =3D false,
> -       .ret_type       =3D RET_INTEGER,
> -       .allow_fastcall =3D true,
> -};
> -

bpf_get_raw_smp_processor_id_proto doesn't have
allow_fastcall =3D true

so this breaks tests.

Instead of removing BPF_CALL_0(bpf_get_smp_processor_id)
we should probably remove BPF_CALL_0(bpf_get_raw_cpu_id)
and adjust SKF_AD_OFF + SKF_AD_CPU case.
I don't recall why raw_ version was used back in 2014.

pw-bot: cr

