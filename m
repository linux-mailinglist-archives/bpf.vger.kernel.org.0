Return-Path: <bpf+bounces-42704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D789A93EA
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF24B23D28
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 23:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90BB1FF044;
	Mon, 21 Oct 2024 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbVsABC7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49D1FF039
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729552093; cv=none; b=refzIxbY71w8xes4aedJdw/MXVhTRl6C81wFFVLHop/4IcgEgEnr0+Dmjb4Cc6RZV3PUKfRg524qzODsJX4bGUSEBuF3ufYgKoO3bO1/EhzPuwWecW5CZlZ6Vsj68kKA9E15h5JQjwLUTxGFRSXenE1Y/Sz5kemFHZVLUHwk5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729552093; c=relaxed/simple;
	bh=W/I87J1/ddLhUg1TmijOBFGvGfUbJ5PKaLM59sI1wJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CK7VSCJn3n7X5T2BPEDXuCP1IJwkMeHHRU7jVJHk5Oz0871CKFaapsMZbfoKWr/VYYA/CJAA+GhOpNGoeEq0la6NRorxWw05JdtgjrhQH47rgFiXwuFzmLHs1ICx9OkWBSweU/iG/B4noenaANMMvci0JjAXDZM/gpBCKxkJnxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbVsABC7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e579abb99so3577404b3a.2
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 16:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729552091; x=1730156891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SChu6n6jYUsSj6QhM2ZJ2l5KbWbTq5g4GEsc1ZXiwSo=;
        b=KbVsABC7FuC6EqqmlEpfNHUcGpB6SxVD36p0E05VAvXSM3mWdPjGFrvbybwSEswypF
         BtiTWLO6DpMSy0RZtzeT/YfuILS22+dc9Hb0cyKOyKd5cggiZ20yjFb6pygS4hJ4GnOa
         FNcfIZxZZM8RpowJuS2Bm87GZ361rBtWGylVck7alRAZzEZxIyg+H0tVuZLVv1V7q2bB
         vOlXMxELaOwp2Ng5ycO1h3+5Dt0Cbx9YPyIF8EhHerl8DMTPD2bS/YuDhhmRijxNhm1y
         UnE3h8fHCyMomeHbI6G41sL/5psIx2W/GWHUpnxlexbfSrtYXUjpriBKp9RM9UKVnRfi
         d9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729552091; x=1730156891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SChu6n6jYUsSj6QhM2ZJ2l5KbWbTq5g4GEsc1ZXiwSo=;
        b=VhMxgLKfhevYA5CfBBseLMTvd5nHSNpH0esbcL3sUSoUQCNW2H3pmKKgn8jm7YXQqH
         BVfm7f24it0y5+kEEVPlvwaIa5l17n9e/RhjOCiEzGE7PliBOEOBCCQPKIsqFcC/mYdl
         3OIzvhfJ4WtvGZClUB1EmWmNMGaHzi/D61/RkCtkNpg6416cEs4gaXtS6hyAc+SkwW0K
         4UuGO/P1c70gvlSsgBuBfaxhHvhJRv3zPguRHY3mfAnVLs4/GoyLVOr8BrEM2zLRuSzd
         /RY6upElmX5xVfPejeHnBemCwXDQhQpvoHvGYC9aDzI0nKTLdEkqQn4/paZL/tKRva/u
         RJ8w==
X-Gm-Message-State: AOJu0YwSjCmFGkIUTkYVYef97GUU9ye73NzpM1cb+tou35YGNiC7myq9
	hKle9z6/F9ygo1Ev17KTuP5QBEMyZLu/7ZUfy0d1MfRw+2FQgZrTXAlXl3SjMSg4QsysaW9jzBV
	mn5yYekttyK+VUZOSZ5F++Zz5KjsIKMmd
X-Google-Smtp-Source: AGHT+IGf1UnGZjfb9Dh0i+8YLEM7pTkOVHFrLDKe00Xu5nCc2bDrCR/G153DL3XO+im+0iLOyddTaVnFFRLVllKVFvI=
X-Received: by 2002:a05:6a00:17a9:b0:71d:eb7d:20d5 with SMTP id
 d2e1a72fcca58-71ea31ae82dmr19630605b3a.8.1729552090850; Mon, 21 Oct 2024
 16:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-5-houtao@huaweicloud.com> <91affb00-82af-49ad-69bd-9c9ad57c9a9b@huaweicloud.com>
In-Reply-To: <91affb00-82af-49ad-69bd-9c9ad57c9a9b@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 16:07:58 -0700
Message-ID: <CAEf4BzY=q3tk3FPkcwwY5Ax7VQqEwphQ2RX64VXXAxLO=_D_Ag@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/7] bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, xukuohai@huawei.com, 
	"houtao1@huawei.com" <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 7:45=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 10/21/2024 9:40 AM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > bpf_iter_bits_destroy() uses "kit->nr_bits <=3D 64" to check whether th=
e
> > bits are dynamically allocated. However, the check is incorrect and may
> > cause a kmemleak as shown below:
> >
> > unreferenced object 0xffff88812628c8c0 (size 32):
> >   comm "swapper/0", pid 1, jiffies 4294727320
> >   hex dump (first 32 bytes):
> >       b0 c1 55 f5 81 88 ff ff f0 f0 f0 f0 f0 f0 f0 f0  ..U.............
> >       f0 f0 f0 f0 f0 f0 f0 f0 00 00 00 00 00 00 00 00  ................
> >   backtrace (crc 781e32cc):
> >       [<00000000c452b4ab>] kmemleak_alloc+0x4b/0x80
> >       [<0000000004e09f80>] __kmalloc_node_noprof+0x480/0x5c0
> >       [<00000000597124d6>] __alloc.isra.0+0x89/0xb0
> >       [<000000004ebfffcd>] alloc_bulk+0x2af/0x720
> >       [<00000000d9c10145>] prefill_mem_cache+0x7f/0xb0
> >       [<00000000ff9738ff>] bpf_mem_alloc_init+0x3e2/0x610
> >       [<000000008b616eac>] bpf_global_ma_init+0x19/0x30
> >       [<00000000fc473efc>] do_one_initcall+0xd3/0x3c0
> >       [<00000000ec81498c>] kernel_init_freeable+0x66a/0x940
> >       [<00000000b119f72f>] kernel_init+0x20/0x160
> >       [<00000000f11ac9a7>] ret_from_fork+0x3c/0x70
> >       [<0000000004671da4>] ret_from_fork_asm+0x1a/0x30
> >
> > That is because nr_bits will be set as zero in bpf_iter_bits_next()
> > after all bits have been iterated.
> >
> > Fix the problem by not setting nr_bits to zero in bpf_iter_bits_next().
> > Instead, use "bits >=3D nr_bits" to indicate when iteration is complete=
d
> > and still use "nr_bits > 64" to indicate when bits are dynamically
> > allocated.
> >
> > Fixes: 4665415975b0 ("bpf: Add bits iterator")
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  kernel/bpf/helpers.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 1a43d06eab28..62349e206a29 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2888,7 +2888,7 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const=
 u64 *unsafe_ptr__ign, u32 nr_w
> >
> >       kit->nr_bits =3D 0;
> >       kit->bits_copy =3D 0;
> > -     kit->bit =3D -1;
> > +     kit->bit =3D 0;
>
> Sent the patch out in a hurry and didn't run the related test.
>
> The change above will break "fewer words" test in verifier_bits_iter,
> because it will skip bit 0 in the bit. The correct fix should be as below=
:
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1a43d06eab28..190b730e0f86 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2934,15 +2934,13 @@ __bpf_kfunc int *bpf_iter_bits_next(struct
> bpf_iter_bits *it)
>         const unsigned long *bits;
>         int bit;
>
> -       if (nr_bits =3D=3D 0)
> +       if (kit->bit >=3D 0 && kit->bit >=3D nr_bits)

this looks quite weird. Maybe instead of this seemingly unnecessary
`kit->bit >=3D 0` check, either add (int)nr_bits cast or just switch
nr_bits from u32 to int?


BTW,

u32 nr_bytes =3D nr_words * sizeof(u64);

seems like a problem, no? nr_words is u32, so this can overflow,
please check and fix as well, while you are at it?

>                 return NULL;
>
>         bits =3D nr_bits =3D=3D 64 ? &kit->bits_copy : kit->bits;
>         bit =3D find_next_bit(bits, nr_bits, kit->bit + 1);
> -       if (bit >=3D nr_bits) {
> -               kit->nr_bits =3D 0;
> +       if (bit >=3D nr_bits)
>                 return NULL;
> -       }
>
>         kit->bit =3D bit;
>         return &kit->bit;
>
> >
> >       if (!unsafe_ptr__ign || !nr_words)
> >               return -EINVAL;
> > @@ -2934,15 +2934,13 @@ __bpf_kfunc int *bpf_iter_bits_next(struct bpf_=
iter_bits *it)
> >       const unsigned long *bits;
> >       int bit;
> >
> > -     if (nr_bits =3D=3D 0)
> > +     if (kit->bit >=3D nr_bits)
> >               return NULL;
> >
> >       bits =3D nr_bits =3D=3D 64 ? &kit->bits_copy : kit->bits;
> >       bit =3D find_next_bit(bits, nr_bits, kit->bit + 1);
> > -     if (bit >=3D nr_bits) {
> > -             kit->nr_bits =3D 0;
> > +     if (bit >=3D nr_bits)
> >               return NULL;
> > -     }
> >
> >       kit->bit =3D bit;
> >       return &kit->bit;
>

