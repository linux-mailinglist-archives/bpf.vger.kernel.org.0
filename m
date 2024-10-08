Return-Path: <bpf+bounces-41279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02353995683
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B898B282E7C
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E567521265E;
	Tue,  8 Oct 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzHOPaN3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4965189910
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412013; cv=none; b=hbuGLHbvj8nt+UGMnoHo3xPcOA+EWr8SE4zJC/M7vmXxHPfgf3h+yxNwVYHzBXyDNUsM7okCDm7V89A/TyNyepuZ7s+MFGg1DB15F/pWGmVVpPNF8oA4wX6bupy24lZNJdAwsG2OQu0risAkamjg+R6eeRjve9EzNzgDVWXbOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412013; c=relaxed/simple;
	bh=mNyCPqLVzIHYsOoLkVkwx2hWbV0e1qRycKVUZ9yoTaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIEyKzv7XIJit4uQiDV09OwW3OgguCsRfsTd6+uOi684U+lGU9utHGb40Pcje39iQkCZnfdmnOjwIxacTOUjdBFUm8zNh4KAsGCH9IQ2pzvg5JWyEyrVFzFimqtBFtO19ylO8IMPwHz9fH9mIGzvmv6DkXDc7pZlUYYL5l1n6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzHOPaN3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3874008a12.2
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728412011; x=1729016811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkgap5T2uQz2Z0sQeoTwn2E09L0TVFCNd1afoWhaAnk=;
        b=CzHOPaN3Bq8/pholbfTI6V9hxFSuCaS8TaSwfGCxMTIMkGICsBytIQkrkthrNonvmz
         RAeccGnEfJnfks8CEXpvKzGnHxATKglQcOi+tdFbIVDxdMkuU3+ym0rKzVzi966WNWI5
         30UGGZ1P+0AmNcYVCLyQNH4fyvCl+tvEt+Tvq1X9xIMQ04UNkSiK7G7Zvay3GCuoxQk0
         BrGFGD++asiituRzoPU3nM3lU7qjhEWcgDPvL48xSuJnIRpwdV0o3nKoE/9Pk5oJmsSe
         Q0xE9PCfiVtELiaRxCb9MhIeIQDfQm9cICOr9TYs+hZjJcNZNR5j7/PQjj5jdyvAyvLx
         vAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412011; x=1729016811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dkgap5T2uQz2Z0sQeoTwn2E09L0TVFCNd1afoWhaAnk=;
        b=JkfGfQHtbO6JrW7dm1F7RIsOHdOA88H7O8fQpu0XpnINeWq8quUw/pSPqLokA7ltqI
         tO+dNIoVNlWM357yn1ZYWDnieWzKbQiBwWfqf+cnnloPWk1EFo9GGWSgUqzYg/AfrfBy
         ba5XVl5rjMTUxBELkc0XQJ6QmTFSK5ckoQxBiNDhaw5Gb1AlmUb+Lese7wIoHrd2Dn3x
         B1zYGXNjU7VFFW+v92Mxf7oQBXhgTVlvOJPin8w7e3Iu9jaLp+0at+1IWmcg8fWUqzIb
         U4ep0rpDajn1V/H1YorRlvqvBHIiCmWFf7dUYNYKhRLj6iGGhk1JXT3xDPg7vJDAIHSo
         ehhA==
X-Gm-Message-State: AOJu0Yyta2XLVxv4H3/FH6cVMtWlC9HZ43Bx3SuouDTBWEpwCuiMoMwL
	2y7Pj6clc/5KlElCqgynaP5NEN7qQ0UNJH6RbwVL5TCCkIP2xYOSig5yMeqZlpogZHSBo1yNysV
	vSlavNrTcSWwXdUQ9g2L53g6p3qQ=
X-Google-Smtp-Source: AGHT+IEFK9qsLASvOxvWnX9IttQtoA9r4DNPvO2dkszKYmrfGpCeLN+ezvd6qDrRNozLj8VioMwyVoYV6zVaAQD21bY=
X-Received: by 2002:a17:90b:1e4c:b0:2e1:8a29:99e with SMTP id
 98e67ed59e1d1-2e1e6321816mr19447502a91.26.1728412011160; Tue, 08 Oct 2024
 11:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091718.3797027-1-houtao@huaweicloud.com> <20241008091718.3797027-4-houtao@huaweicloud.com>
In-Reply-To: <20241008091718.3797027-4-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 8 Oct 2024 11:26:39 -0700
Message-ID: <CAEf4BzaxYNZ=xc15O7ai5Fqd8XOON5t-Z25mFGGaSu=63j1T1A@mail.gmail.com>
Subject: Re: [PATCH bpf 3/7] bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, houtao1@huawei.com, 
	xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:05=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
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
>     b0 c1 55 f5 81 88 ff ff f0 f0 f0 f0 f0 f0 f0 f0  ..U.............
>     f0 f0 f0 f0 f0 f0 f0 f0 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 781e32cc):
>     [<00000000c452b4ab>] kmemleak_alloc+0x4b/0x80
>     [<0000000004e09f80>] __kmalloc_node_noprof+0x480/0x5c0
>     [<00000000597124d6>] __alloc.isra.0+0x89/0xb0
>     [<000000004ebfffcd>] alloc_bulk+0x2af/0x720
>     [<00000000d9c10145>] prefill_mem_cache+0x7f/0xb0
>     [<00000000ff9738ff>] bpf_mem_alloc_init+0x3e2/0x610
>     [<000000008b616eac>] bpf_global_ma_init+0x19/0x30
>     [<00000000fc473efc>] do_one_initcall+0xd3/0x3c0
>     [<00000000ec81498c>] kernel_init_freeable+0x66a/0x940
>     [<00000000b119f72f>] kernel_init+0x20/0x160
>     [<00000000f11ac9a7>] ret_from_fork+0x3c/0x70
>     [<0000000004671da4>] ret_from_fork_asm+0x1a/0x30
>
> That is because nr_bits will be set as zero in bpf_iter_bits_next()
> after all bits have been iterated.
>

so maybe don't touch nr_bits and just use `kit->bit >=3D kit->nr_bits`
condition to know when iterator is done?

> Fix the problem by introducing an extra allocated status in
> bpf_iter_bits and using it to indicate whether the bits are
> dynamically allocated.
>
> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1a43d06eab28..9484b5f7c4c0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2856,7 +2856,8 @@ struct bpf_iter_bits_kern {
>                 unsigned long *bits;
>                 unsigned long bits_copy;
>         };
> -       u32 nr_bits;
> +       u32 allocated:1;
> +       u32 nr_bits:31;
>         int bit;
>  } __aligned(8);
>
> @@ -2886,6 +2887,7 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u=
64 *unsafe_ptr__ign, u32 nr_w
>         BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=3D
>                      __alignof__(struct bpf_iter_bits));
>
> +       kit->allocated =3D 0;
>         kit->nr_bits =3D 0;
>         kit->bits_copy =3D 0;
>         kit->bit =3D -1;
> @@ -2914,6 +2916,7 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u=
64 *unsafe_ptr__ign, u32 nr_w
>                 return err;
>         }
>
> +       kit->allocated =3D 1;
>         kit->nr_bits =3D nr_bits;
>         return 0;
>  }
> @@ -2937,7 +2940,7 @@ __bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter=
_bits *it)
>         if (nr_bits =3D=3D 0)
>                 return NULL;
>
> -       bits =3D nr_bits =3D=3D 64 ? &kit->bits_copy : kit->bits;
> +       bits =3D !kit->allocated ? &kit->bits_copy : kit->bits;
>         bit =3D find_next_bit(bits, nr_bits, kit->bit + 1);
>         if (bit >=3D nr_bits) {
>                 kit->nr_bits =3D 0;
> @@ -2958,7 +2961,7 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_i=
ter_bits *it)
>  {
>         struct bpf_iter_bits_kern *kit =3D (void *)it;
>
> -       if (kit->nr_bits <=3D 64)
> +       if (!kit->allocated)
>                 return;
>         bpf_mem_free(&bpf_global_ma, kit->bits);
>  }
> --
> 2.29.2
>

