Return-Path: <bpf+bounces-43138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358899AF988
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 08:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0EE2835AF
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 06:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D87193089;
	Fri, 25 Oct 2024 06:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZnyUj9y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC8192587
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836283; cv=none; b=d/dA0Vx9aEuZ3pX7BSpKcMvtYdUQjciQEfSmuOL1NsVGMa8ZV7+P82Sp6uazm+S5fG/bh7+SM5yabbW7j9O25gexStAfUpgAzqVw5bNgLWDTvsDiQ5im4PxJT9/CU/v5CJp8yYeE3wgt5Dttvzm0YGuvjXEO4DOyVL3xgLJdhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836283; c=relaxed/simple;
	bh=29O6j7zsVoP+ttnvkKhuC16LEi+eywMIhrLTg3hwaVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkiUClJLbuF22tRe/4kSeVHyT8CHdrwdXjQpEkfFFoN4fAHL9UMdW9k6el3ZzSyqUZ9eaPbgpXRqh8rwCM49abZ+9y/zuRgjuGMquj2H11qwODkFaImSWNladGLnXBA3McxFjiisOOtgMrHCvrQzWzlAvC82I9LrlKtkIFIW9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZnyUj9y; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b14077ec5aso254974985a.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 23:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729836280; x=1730441080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scD1yM4kqdTSZtX8JLOg1OIi+XDymlvbplf4effvKHI=;
        b=jZnyUj9yBauWrfj0UfBPPskPSHzpUsxWHd8WfKU7ArZ+lQZJcpBpDpkhRaR0kneyzu
         G6XqSWpjwitY/ZUbMgtHrQMknyZEksu8SzYpPnrvk7jDVHvNQ3q3Nj7H1T25Q56xCO4a
         oe9cZgp2NXuWVqQkJlaYn1cbSSM1Y+BCSbFUFzAthuRcNMVfW7YTNh2DL1BxVy3F0hVy
         P3cExPZI8cAOFh74pOFvl0zOQMx0Mi49nNysoqVbaavkqmld6NKptB08JHneA6eof4Jc
         vjGDxxq9FuqOWDOCgMLCeVCDWQCaab81Ii/yWod1gudsGry/86FQaLscjU8WrTH87rLd
         wNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836280; x=1730441080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scD1yM4kqdTSZtX8JLOg1OIi+XDymlvbplf4effvKHI=;
        b=scVxXPp3+KHhx0dxt/qeWaDHlnn4ZkRMKLotn4EOadsGVNqGEu1uBn9Q5CuDanmHCk
         aDEcVzPOLI3bk2lp8CY18z/dmdFizvvz6ilLcbAFH5tbxDmeVAXNEi57mtDNyarBpQn7
         ahY2VSLdEtVeM6ZP0Qcg5THgyUsqFx4vQ/3ccwOSdxEaIBupSdCkc5vSk+o7c4Xt6U0w
         hizVlIZXFwHxUYdl4FoISzMoxcTVRwAuM3S0gfIZ6hLufrXJZI/ixN/1ch6EpbuyssVQ
         QzGb5eRiqP9HY7B95TU3/JQuw/Sv2Y9wFnDBkFSbjN+XKtShIgNfbhnC1nMurp2s/Hwr
         R4DQ==
X-Gm-Message-State: AOJu0YyBnt5M0LKE9fPpoVmUJylIypbgjxb8ZeZRPi6csMErQDmuTe3w
	WLRjEaVaL+8FLTiaforHpsWN+bUgeHpgvUyN5rqqEdbNCo9eWJTyZHYhPaWGdEy4sPPaYqn15ov
	LYyM1Tix1D+ACNjvPOTmjNGW0KeI=
X-Google-Smtp-Source: AGHT+IGGuv3+WqkWw1iSkTNAKkK+rpHAOirJXC8bqIqH5ZQ+PONG8LUI6PsUHLMvumfu12ukA5JxJVcJpyVKzy2W/+o=
X-Received: by 2002:a05:6214:3d8b:b0:6cb:fbb5:8a57 with SMTP id
 6a1803df08f44-6d07a5fffa0mr78280306d6.1.1729836279945; Thu, 24 Oct 2024
 23:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025013233.804027-1-houtao@huaweicloud.com> <20241025013233.804027-4-houtao@huaweicloud.com>
In-Reply-To: <20241025013233.804027-4-houtao@huaweicloud.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 25 Oct 2024 14:04:04 +0800
Message-ID: <CALOAHbDwKh3xZa1pFURSuOV=md+eAfKbrsPGyxh3xH39e50qWA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/5] bpf: Check the validity of nr_words in bpf_iter_bits_new()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:20=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Check the validity of nr_words in bpf_iter_bits_new(). Without this
> check, when multiplication overflow occurs for nr_bits (e.g., when
> nr_words =3D 0x0400-0001, nr_bits becomes 64), stack corruption may occur
> due to bpf_probe_read_kernel_common(..., nr_bytes =3D 0x2000-0008).
>
> Fix it by limiting the maximum value of nr_words to 511. The value is
> derived from the current implementation of BPF memory allocator. To
> ensure compatibility if the BPF memory allocator's size limitation
> changes in the future, use the helper bpf_mem_alloc_check_size() to
> check whether nr_bytes is too larger. And return -E2BIG instead of
> -ENOMEM for oversized nr_bytes.
>
> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 40ef6a56619f..daec74820dbe 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
>         __u64 __opaque[2];
>  } __aligned(8);
>
> +#define BITS_ITER_NR_WORDS_MAX 511
> +
>  struct bpf_iter_bits_kern {
>         union {
>                 unsigned long *bits;
> @@ -2865,7 +2867,8 @@ struct bpf_iter_bits_kern {
>   * @it: The new bpf_iter_bits to be created
>   * @unsafe_ptr__ign: A pointer pointing to a memory area to be iterated =
over
>   * @nr_words: The size of the specified memory area, measured in 8-byte =
units.
> - * Due to the limitation of memalloc, it can't be greater than 512.
> + * The maximum value of @nr_words is @BITS_ITER_NR_WORDS_MAX. This limit=
 may be
> + * further reduced by the BPF memory allocator implementation.
>   *
>   * This function initializes a new bpf_iter_bits structure for iterating=
 over
>   * a memory area which is specified by the @unsafe_ptr__ign and @nr_word=
s. It
> @@ -2878,8 +2881,7 @@ __bpf_kfunc int
>  bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, =
u32 nr_words)
>  {
>         struct bpf_iter_bits_kern *kit =3D (void *)it;
> -       u32 nr_bytes =3D nr_words * sizeof(u64);
> -       u32 nr_bits =3D BYTES_TO_BITS(nr_bytes);
> +       u32 nr_bytes, nr_bits;
>         int err;
>
>         BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(struct=
 bpf_iter_bits));
> @@ -2892,9 +2894,14 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const =
u64 *unsafe_ptr__ign, u32 nr_w
>
>         if (!unsafe_ptr__ign || !nr_words)
>                 return -EINVAL;
> +       if (nr_words > BITS_ITER_NR_WORDS_MAX)
> +               return -E2BIG;
> +
> +       nr_bytes =3D nr_words * sizeof(u64);
> +       nr_bits =3D BYTES_TO_BITS(nr_bytes);
>
>         /* Optimization for u64 mask */
> -       if (nr_bits =3D=3D 64) {
> +       if (nr_words =3D=3D 1) {
>                 err =3D bpf_probe_read_kernel_common(&kit->bits_copy, nr_=
bytes, unsafe_ptr__ign);
>                 if (err)
>                         return -EFAULT;
> @@ -2903,6 +2910,9 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u=
64 *unsafe_ptr__ign, u32 nr_w
>                 return 0;
>         }
>
> +       if (bpf_mem_alloc_check_size(false, nr_bytes))
> +               return -E2BIG;
> +

Is this check necessary here? If `E2BIG` is a concern, perhaps it
would be more appropriate to return it using ERR_PTR() in
bpf_mem_alloc()?

>         /* Fallback to memalloc */
>         kit->bits =3D bpf_mem_alloc(&bpf_global_ma, nr_bytes);
>         if (!kit->bits)
> --
> 2.29.2
>


--=20
Regards
Yafang

