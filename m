Return-Path: <bpf+bounces-36984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AE594FBAB
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 04:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CDB1F21E05
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 02:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C1D125B9;
	Tue, 13 Aug 2024 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nor7Q43D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792410A1C
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723515040; cv=none; b=TiyXG0V06qg8VB8eSm6xNM23jm1dxjiFp1U1itgaHC91BbG2mlVYbutWaTyR47sNyw7uEa6cQFYG7xFltuo3D1aiO6DQrQeRHfbaHevewDR29WNZIW+ZkhNQ1wv+CZO25GHrDHHf/7HGvgNcxO5ydg18kqK4YElv9JedQv2q31c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723515040; c=relaxed/simple;
	bh=o+HpbbaGdR/E51fSTXfh6zKK/SglcZ8hjLI15YHuGgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRq8zhEIvKIcbyFb6GgUZVl8kfqF8SKBPv6zcaKS8jgJzokDM4w7Iu48TMN9f7lGM/Ut+5liT0UJN1b5JoR7Ax7PE+NNsU3Tp4UyVbfAZMJyxWoB7Rm5+DXmo6UjTlT9Da4rktJ1ZwZ/EMxmMX9/mMNO1hq+PwNz4PPdublQ7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nor7Q43D; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42812945633so39147625e9.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 19:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723515037; x=1724119837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk6+beT41DjQV2FrJuIVy29pQx+jGbF64JucubEuyJI=;
        b=nor7Q43DSr6tGkZLAuzNoDvkxkGryU0Rw69IIjKvVx7VEgnaQVtd2dKntdknxt8iVn
         pGgCIeOZuV169RL85UUJJuT0qq72x/J/7NCEXVjFd84kPvzAlywJ2kwr/EGzjUgBkHGU
         4yVYBXawE7ifcCZRjMfInd4J60G7INpoaXKRNkeSxFzISGnzX2CajwJt7lt3MEdvs18U
         5t6gvX6opBnpKBkscPioRQ02yq/t3db0kctlJ8s14/NVAiJSsHKJNiI83bphhK0pECU9
         iGQXFOldzpES9E/rJY8MjsXgtTtI9dz3xmCVp4gR12Et/EfrVh9v0CMTXYIqAga/kXh3
         CX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723515037; x=1724119837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk6+beT41DjQV2FrJuIVy29pQx+jGbF64JucubEuyJI=;
        b=a4rYefTuu+qceEXOZJFuM3pKviYQjRevfv7ahCzzddsET7sls8fFrUSwT38ZnXITOw
         JCP8xboA7gIFD52r66bgfndOzZlSybxvOnu85Rs1Q3+okWw3QQC5BZ+6gN+JdTWAu/xL
         y+s1V6izBAbOwHiv5vbzAgkL5G9TzNq4ccxyD8OZFUlklXIDBBmCF+Rtvgi3nhkGgVtW
         t6yW7/luoxZJSd+Y9t9oxMSp2KBHJCK0Lnh79i17nvODZjc/uzls7Bok78f1RzU27Cku
         67cCsqWxp7xGD/T9wwTAlMewCSN2uDaz8HJThgrYlFK9us8Z7COz6v0OXu7C8xaLjkIR
         xvbQ==
X-Gm-Message-State: AOJu0YyCRQ+Xtu6SzKaFeMoPTYdUvtRyvbn6t9XaOrva8e4EljFOTVYC
	SsODLVIzmDcSqj5JcYTRWxYjxwVekNV50KnJDfYi8dvPSu1jc2MQ+ZwUrWfhOEaqnFxTD1J6gAH
	URcATvbOmg8EaEK8Y5iAYjCbufpg=
X-Google-Smtp-Source: AGHT+IFot6GUqI9iLMrhl+pdztlGb/O/2MrPmtu/Z6t6v3UjDx9VMyAig3tTyk+14Tr1iWUnLGn/7cPwvs0zFCCTI20=
X-Received: by 2002:a05:600c:4e87:b0:426:6667:5c42 with SMTP id
 5b1f17b1804b1-429d47f427fmr16095775e9.4.1723515036353; Mon, 12 Aug 2024
 19:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813012528.3566133-1-linux@jordanrome.com>
In-Reply-To: <20240813012528.3566133-1-linux@jordanrome.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 19:10:25 -0700
Message-ID: <CAADnVQ+cfn0SMQZwnCcv5VvCCixO+=CsTcF4bfjEYTpHPWngwA@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 6:26=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> This adds a kfunc wrapper around strncpy_from_user,
> which can be called from sleepable BPF programs.
>
> This matches the non-sleepable 'bpf_probe_read_user_str'
> helper.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  kernel/bpf/helpers.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d02ae323996b..e87d5df658cb 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2939,6 +2939,41 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_=
iter_bits *it)
>         bpf_mem_free(&bpf_global_ma, kit->bits);
>  }
>
> +/**
> + * bpf_copy_from_user_str() - Copy a string from an unsafe user address
> + * @dst:             Destination address, in kernel space.  This buffer =
must be at
> + *                   least @dst__szk bytes long.
> + * @dst__szk:        Maximum number of bytes to copy, including the trai=
ling NUL.
> + * @unsafe_ptr__ign: Source address, in user space.
> + *
> + * Copies a NUL-terminated string from userspace to BPF space. If user s=
tring is
> + * too long this will still ensure zero termination in the dst buffer un=
less
> + * buffer size is 0.
> + */
> +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const vo=
id __user *unsafe_ptr__ign)
> +{
> +       int ret;
> +       int count;
> +
> +       if (unlikely(!dst__szk))
> +               return 0;
> +
> +       count =3D dst__szk - 1;
> +       if (unlikely(!count)) {
> +               ((char *)dst)[0] =3D '\0';
> +               return 1;
> +       }
> +
> +       ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
> +       if (ret >=3D 0) {
> +               if (ret =3D=3D count)
> +                       ((char *)dst)[ret] =3D '\0';
> +               ret++;
> +       }
> +
> +       return ret;
> +}

The above will not pad the buffer and it will create instability
when the target buffer is a part of the map key. Consider:

struct map_key {
   char str[100];
};
struct {
        __uint(type, BPF_MAP_TYPE_HASH);
        __type(key, struct map_key);
} hash SEC(".maps");

struct map_key key;
bpf_copy_from_user_str(key.str, sizeof(key.str), user_string);

The verifier will think that all of the 'key' is initialized,
but for short strings the key will have garbage.

bpf_probe_read_kernel_str() has the same issue as above, but
let's fix it here first and update read_kernel_str() later.

pw-bot: cr

