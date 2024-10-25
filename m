Return-Path: <bpf+bounces-43140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C74B9AF9C7
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 08:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7001F25659
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 06:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECF9199948;
	Fri, 25 Oct 2024 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R80VCaq5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8B18BC1C
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837111; cv=none; b=rh5w1SS2z1dbZYPufeRv1ps1Z7U0Js9ge0JpW0aa+YqyX3OGdgfgwv8lP5E0vgTFg4UlxHqMu/Cjz+ePdF54U9apceaRyBLN9GXL/BvCV9i5km5dkqL1Oxu0IgjVi7f4qsYKvIc5q3NZ113KMArPpQmZNNj5eTMjnKeOdY5MLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837111; c=relaxed/simple;
	bh=3nX00DpCKJE+ppAZtXvW86d6yJuBfg1tubDUjDWVEEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zdw6o4SbPNNzVb08ePSbg5z/S725zz7DxA0w2kEMdUaZ5etUKAeI7nabd/G0Iz/SQPf3UxZz/efTxfQQgREwMT/UlfoANFw54SQaehGkBOEN0wpy6pfXSiKum8ZpsoX7nlLLkqSED1e/UhBkh2+fAYFbmvSbHDcBF81AI4W5TUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R80VCaq5; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbe8119e21so10098836d6.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 23:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729837108; x=1730441908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ru64Vs0yuTbUe1cHuTMd+MT/iR0OY0HESCLOze2sKs=;
        b=R80VCaq5ZgR5fLs2RowmhizFDPT5tNG8SC6spKdE7QlQdA/QWLo++qaRZwXC1rja3F
         kcYLAbVogiOFjLHjbWJ9LbkkFpdPCMWeeExZmEcani1gxkDKDkLVuSmDlwDiv3nzG/oE
         l9CbGgt+EdIgdy14eDi8tuEDl6IxvJj3lruBLolh2VBsCuh1igF7Gm/vmxBQQIB1ugPw
         L/OvZ+OwM5kyc57l0GzjK7EltUdqUza6ZcgkeSPg9xSPxgtJToizavaC9xFYnF2aKFBT
         3Xor9HUcaEbbIek7zcqz4LMayhWx7bnfsD//Ah1/Z4qnJIfdddOmSKRPZJtKtv9wBtrs
         kZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837108; x=1730441908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ru64Vs0yuTbUe1cHuTMd+MT/iR0OY0HESCLOze2sKs=;
        b=ArSBSHSll4QyoomY/V7E0bPpxRpyD1cnsnVQ5Jy7yeQ9c85Zsq+MUjAYSMe7XGcVId
         Bs0cVqimbudqs3Dr4lmUPKGJvX4sRoMPqKIa4ZjRBos6QbNeuf2CPMkc3ltz4si7bGfg
         Hz0rBDPd/i3BYHeDRrv6dud2VwJEcWGZ/F/SmNxaiDpjzhNG2jevsLfQannCY2J9PFUT
         KM8vg9HW5xaZFNimstTwhxNLPxzD9EYAQ1RSHH+lUqjvFFwXkuBlvs8qzQKNwroT08vp
         9s0aDJ9NwcHUtjtB/mtA4ZYgAAuLspPPfg6ruJVauTxxtXYlJAT35cUV8uHsWXZM4MXr
         UKEA==
X-Gm-Message-State: AOJu0YzfCD7mH911bVWnQsJM6BfXs1DW35x3Vi1BAUh5c3DF7rJUgVfO
	iKKRnGT8jEOMI9z0hktLJyx6kb/LL86dMVjWo6vwiCcBX5apADybTCy2wEsYaaFQT2SVHmxqm90
	a2o4jBdFT9e9dsF0jpR6bWlK2bWAjJWxp9LI=
X-Google-Smtp-Source: AGHT+IHzXEy67ukBgB2xLU94+ltg6Rp5YjjuGSYQSd/+A4PV7gsdvYLQy6+9grvWklNQcBA0++IV7uAt3fM54HivoTE=
X-Received: by 2002:a05:6214:5d12:b0:6cb:bfb5:6fc with SMTP id
 6a1803df08f44-6d08efd96f7mr46301206d6.25.1729837107866; Thu, 24 Oct 2024
 23:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025013233.804027-1-houtao@huaweicloud.com> <20241025013233.804027-2-houtao@huaweicloud.com>
In-Reply-To: <20241025013233.804027-2-houtao@huaweicloud.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 25 Oct 2024 14:17:51 +0800
Message-ID: <CALOAHbAdCY_yEyG9e1rxMmZ26_EUxUd8j3qL0C7zg0a40O_H4A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/5] bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
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
> bpf_iter_bits_destroy() uses "kit->nr_bits <=3D 64" to check whether the
> bits are dynamically allocated. However, the check is incorrect and may
> cause a kmemleak as shown below:
>
> unreferenced object 0xffff88812628c8c0 (size 32):
>   comm "swapper/0", pid 1, jiffies 4294727320
>   hex dump (first 32 bytes):
>         b0 c1 55 f5 81 88 ff ff f0 f0 f0 f0 f0 f0 f0 f0  ..U...........
>         f0 f0 f0 f0 f0 f0 f0 f0 00 00 00 00 00 00 00 00  ..............
>   backtrace (crc 781e32cc):
>         [<00000000c452b4ab>] kmemleak_alloc+0x4b/0x80
>         [<0000000004e09f80>] __kmalloc_node_noprof+0x480/0x5c0
>         [<00000000597124d6>] __alloc.isra.0+0x89/0xb0
>         [<000000004ebfffcd>] alloc_bulk+0x2af/0x720
>         [<00000000d9c10145>] prefill_mem_cache+0x7f/0xb0
>         [<00000000ff9738ff>] bpf_mem_alloc_init+0x3e2/0x610
>         [<000000008b616eac>] bpf_global_ma_init+0x19/0x30
>         [<00000000fc473efc>] do_one_initcall+0xd3/0x3c0
>         [<00000000ec81498c>] kernel_init_freeable+0x66a/0x940
>         [<00000000b119f72f>] kernel_init+0x20/0x160
>         [<00000000f11ac9a7>] ret_from_fork+0x3c/0x70
>         [<0000000004671da4>] ret_from_fork_asm+0x1a/0x30
>
> That is because nr_bits will be set as zero in bpf_iter_bits_next()
> after all bits have been iterated.
>
> Fix the issue by setting kit->bit to kit->nr_bits instead of setting
> kit->nr_bits to zero when the iteration completes in
> bpf_iter_bits_next(). In addition, use "!nr_bits || bits >=3D nr_bits" to
> check whether the iteration is complete and still use "nr_bits > 64" to
> indicate whether bits are dynamically allocated. The "!nr_bits" check is
> necessary because bpf_iter_bits_new() may fail before setting
> kit->nr_bits, and this condition will stop the iteration early instead
> of accessing the zeroed or freed kit->bits.
>
> Considering the initial value of kit->bits is -1 and the type of
> kit->nr_bits is unsigned int, change the type of kit->nr_bits to int.
> The potential overflow problem will be handled in the following patch.
>
> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

LGTM
Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  kernel/bpf/helpers.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1a43d06eab28..40ef6a56619f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2856,7 +2856,7 @@ struct bpf_iter_bits_kern {
>                 unsigned long *bits;
>                 unsigned long bits_copy;
>         };
> -       u32 nr_bits;
> +       int nr_bits;
>         int bit;
>  } __aligned(8);
>
> @@ -2930,17 +2930,16 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const=
 u64 *unsafe_ptr__ign, u32 nr_w
>  __bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
>  {
>         struct bpf_iter_bits_kern *kit =3D (void *)it;
> -       u32 nr_bits =3D kit->nr_bits;
> +       int bit =3D kit->bit, nr_bits =3D kit->nr_bits;
>         const unsigned long *bits;
> -       int bit;
>
> -       if (nr_bits =3D=3D 0)
> +       if (!nr_bits || bit >=3D nr_bits)
>                 return NULL;
>
>         bits =3D nr_bits =3D=3D 64 ? &kit->bits_copy : kit->bits;
> -       bit =3D find_next_bit(bits, nr_bits, kit->bit + 1);
> +       bit =3D find_next_bit(bits, nr_bits, bit + 1);
>         if (bit >=3D nr_bits) {
> -               kit->nr_bits =3D 0;
> +               kit->bit =3D bit;
>                 return NULL;
>         }
>
> --
> 2.29.2
>


--=20
Regards
Yafang

