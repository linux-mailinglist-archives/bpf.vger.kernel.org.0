Return-Path: <bpf+bounces-41528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E3D997A86
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 04:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D472D1C21589
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 02:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C436088F;
	Thu, 10 Oct 2024 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6nlBzIv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D692AEFC
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526985; cv=none; b=W0M/9Orymqq/YRRSI5tNP+gfdsWbXJ6rBYwg2Itw765otFPHLWcH4rWq8K/V6Unuy4go1/bK018+akB2Z3WR0SkBG2Jh/638Tg5sOMbwjKD+lc/kvTd669nhQF2bX9q3hOISE6XXpPaCwca+i69Any1YJbu/yaB/u3dMiCgEfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526985; c=relaxed/simple;
	bh=IsNH8uAWvvbPZRgB0DQOV06WW12RcxWQPcw0EMM/3FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNd4HryTL8w8JBl76lAtckXIytLWidcGrLAFeRcOpogFIRu3UB9rSCLVzrne4KT+/xMa13cTvRWYNddMWZ5Y4A1zQiQpKGIpGone+DO5Ws9Vwk80LAF4iXTkjBDmwUoN1lyh1Ol6wgP4X56F1EAc7CC/AYQequF44XuS7Y7/+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6nlBzIv; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6c3f12d3930so2933336d6.3
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 19:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728526982; x=1729131782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV8EMcPxE9ZY5C/AwVc3Ao82taAPsoTMCmoaLyov2Ew=;
        b=E6nlBzIvssvFthZ39CX1bjFzs0argvt4GPdRZNXUpZH/g0oTPTNOSI5OQqZvR4721I
         FZa4XhvgMBElOmWNIo9WO/Yw2vwJ2Rtiv/kjH08bEmreUURhui9WuJiLOoKCqh9YgBZ6
         1q2AaqU1+f5pCNJf9Rma3/m9YzHB9K4R03sDoL+CmFjIWggFHiYzbJowsscavWiZjN/j
         x57O+gvKWrMBRz9LeKW4z74YW1cUmY/OtW5U0vYabfynARkCGXrdMCV4R5RjFoEo4NXW
         7CP6wH8lx3TKFDSyWP8uUzWX9ggTEhH/c6dVJagd0vuSPxjTFAoBRqjf6yA7yBYJ6lYT
         3O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728526982; x=1729131782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EV8EMcPxE9ZY5C/AwVc3Ao82taAPsoTMCmoaLyov2Ew=;
        b=eHdrwSZlFYnbLcE0DuS74Baik1QzVpF+1oX12w4IoqNouosebyHliJv4Q2jCvfYUI/
         4TXidNnVv0EB6a1HnoGzdDghlrUYTKa1stEOm1QCtG0ia+LaRbTJJczQHpt+H+Qd0uz0
         7gqcYjkHPtPxfRMQVZdN9h1E3HInm0nnhgXVGVyU3N5WMl8GtCYPIVTJl+TLqM18+pWb
         9yimvKhcgY9NSve4Ei8718zJoWMK3FWFHguIutIGfA97lXvW4H5x9AxI/gGb6iN6GsIZ
         DZ6jD3dLvQBLowfebiA2tAR2piV6SU/U9zQF1XgC3HVRdI7my8uXpylQeuMQZcGbiIKJ
         gVLg==
X-Forwarded-Encrypted: i=1; AJvYcCV3wErrsCSlU166QLhwZv5rOyKSPJPbqI1RhTQRAGCRQT0bxPXbPeecA4vl+cJgakT9TL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMf9RX/FTdnSK1v4EOyhMh/0j4nxl1HaVObJ9bhaybxCyuKO7V
	mKyXDT0yb1acv0EMymdY+IW0gcTusF7I2/8B/g/d7ztgNyNmDA+1mAt5rYjgU2EuA0eZsUPpDcF
	XpLgX+bXT6gwVtub14evPN282tt/w7znXwZo=
X-Google-Smtp-Source: AGHT+IG/9bbyZHEP0RxqGUFryXGyx/J2+QU+Negjnt6tKSjQJbcse2oDur3GoTNcW0TwKAZpS6ehnKp0QmEkC165lYw=
X-Received: by 2002:a05:6214:5d05:b0:6cb:c0cb:c07d with SMTP id
 6a1803df08f44-6cbc9309b77mr50487256d6.12.1728526981769; Wed, 09 Oct 2024
 19:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
 <20241008091718.3797027-4-houtao@huaweicloud.com> <CAEf4BzaxYNZ=xc15O7ai5Fqd8XOON5t-Z25mFGGaSu=63j1T1A@mail.gmail.com>
 <CALOAHbASB9OXkmVnhirB217Ndf9RR4vOZqnJF142UyKaAvdkPw@mail.gmail.com> <a14be468-6792-1d24-f127-29fd96a2013d@huaweicloud.com>
In-Reply-To: <a14be468-6792-1d24-f127-29fd96a2013d@huaweicloud.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 10 Oct 2024 10:22:25 +0800
Message-ID: <CALOAHbAn0O-PYeokZcqPOE8Z3tY_axK2Rpc-SONZ9BM8Q2x4aw@mail.gmail.com>
Subject: Re: [PATCH bpf 3/7] bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 9:10=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 10/9/2024 7:37 PM, Yafang Shao wrote:
> > On Wed, Oct 9, 2024 at 2:26=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Tue, Oct 8, 2024 at 2:05=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >>> From: Hou Tao <houtao1@huawei.com>
> >>>
> >>> bpf_iter_bits_destroy() uses "kit->nr_bits <=3D 64" to check whether =
the
> >>> bits are dynamically allocated. However, the check is incorrect and m=
ay
> >>> cause a kmemleak as shown below:
> >>>
> >>> unreferenced object 0xffff88812628c8c0 (size 32):
> >>>   comm "swapper/0", pid 1, jiffies 4294727320
> >>>   hex dump (first 32 bytes):
> >>>     b0 c1 55 f5 81 88 ff ff f0 f0 f0 f0 f0 f0 f0 f0  ..U.............
> >>>     f0 f0 f0 f0 f0 f0 f0 f0 00 00 00 00 00 00 00 00  ................
> >>>   backtrace (crc 781e32cc):
> >>>     [<00000000c452b4ab>] kmemleak_alloc+0x4b/0x80
> >>>     [<0000000004e09f80>] __kmalloc_node_noprof+0x480/0x5c0
> >>>     [<00000000597124d6>] __alloc.isra.0+0x89/0xb0
> >>>     [<000000004ebfffcd>] alloc_bulk+0x2af/0x720
> >>>     [<00000000d9c10145>] prefill_mem_cache+0x7f/0xb0
> >>>     [<00000000ff9738ff>] bpf_mem_alloc_init+0x3e2/0x610
> >>>     [<000000008b616eac>] bpf_global_ma_init+0x19/0x30
> >>>     [<00000000fc473efc>] do_one_initcall+0xd3/0x3c0
> >>>     [<00000000ec81498c>] kernel_init_freeable+0x66a/0x940
> >>>     [<00000000b119f72f>] kernel_init+0x20/0x160
> >>>     [<00000000f11ac9a7>] ret_from_fork+0x3c/0x70
> >>>     [<0000000004671da4>] ret_from_fork_asm+0x1a/0x30
> >>>
> >>> That is because nr_bits will be set as zero in bpf_iter_bits_next()
> >>> after all bits have been iterated.
> >>>
> >> so maybe don't touch nr_bits and just use `kit->bit >=3D kit->nr_bits`
> >> condition to know when iterator is done?
> > No, we can't do that. The iterator may only process a few bits, which
> > would result in `kit->bit < kit->nr_bits`. Wouldn't it be better to
> > simply remove the line `kit->nr_bits =3D 0;`?
>
> I think that is Andrii wanted to say. And is it more reasonable to also
> change the check in the begin of bpf_iter_bits_next() to "bit >=3D nr_bit=
s" ?
>
> @@ -2934,15 +2934,13 @@ __bpf_kfunc int *bpf_iter_bits_next(struct
> bpf_iter_bits *it)
>         const unsigned long *bits;
>         int bit;
>
> -       if (nr_bits =3D=3D 0)
> +       if (kit->bit >=3D nr_bits)
>                 return NULL;

Agreed. I misunderstood what Andrii suggested.

--=20
Regards
Yafang

