Return-Path: <bpf+bounces-41391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF909968F7
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8321C2344C
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20014191F66;
	Wed,  9 Oct 2024 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR0+2TCg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB2189F58
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473890; cv=none; b=PPM7sEsoSHdbAC2OAPkOYteIhTzYwdFZNZzOjWwcPdtqaB2SQHX887vXsMaqGXdCWH3HzIBt8jyDjPZVVH/dpcKWpHE73jsW19o5ZcD3EeoNUDZXLqt03WbA5boPBHkzrJIUWlwH/Es13BYOB1JLPieiQhJPu1psxAs2zOaDU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473890; c=relaxed/simple;
	bh=WHAdRn0/fMJ4Zp/L5+X63FVF5c+PNtl/emR4UrIkOIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEkQ6bxZLvc2V7xjyUk10uVsXQW4WZwXK4b9b4md+E0PspERujfZjtMv3FzUURJaCDJzxo6NswzFLuLvm8WZ+WXjEE2qHobuuhjNG0vOwmSvwbw+eR50naYuPf/P/Xd/rxxSUooKxWDCEgX1UYHg4+cmC+pAIixQ+pwAcKklc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LR0+2TCg; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbbe3f6931so16729266d6.0
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 04:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728473888; x=1729078688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJ0Haj0FQF9WJl4eEb9dqqMNNwLLZekM0/1r5KwEWrI=;
        b=LR0+2TCg8B0JStybwLT0NR/Kx6geRnLZMb6/jGdUsRvThDBLadqkqk7sumVDG8lKjT
         kd1BW/yHTrjhcm06Dy4Sj7hj6sgj5l2ih5Q7FLFcVdccggl5RBapn+ASlolmXhQ6FWpp
         SN04NeW5nVfwH7qCCHnNb/UhN3kwz1YJ/RNPaEWco7mfuuzuP64DTI19x750sh+0aM8U
         AA8Cxv2i6ACt+DrYsq9+NvadGWEDlXw7G15g+dHcXGLhKPhmbjqzgtjLKSet3uvAuOKA
         ELZiBcCOsrUVeBXLPl3e3xBumMCNKuVZloexy+ydadLOV1bocfPVZUvuccSzLqxB335g
         4ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728473888; x=1729078688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJ0Haj0FQF9WJl4eEb9dqqMNNwLLZekM0/1r5KwEWrI=;
        b=SJkd2k62QdM8jK9L7oTJJweJyqmaNesOEXhAivEvLSLZbLstE1O7Jdt2QjLWCEj6oV
         km/HB3C1xHTZ3hFH+Tg69FJ7NMAuB/JH6qFMNVdZpzS/UyUUjGgs1BHcaqpzIm1gWIGE
         6knCAzd7XwIeKr24eOlqUwJhx4+gIm8lzNvBdGpfLBsuqeEZgrPedjIS81BnegoC4uvg
         szJ3I3ksDGVy0dNoyiVe6W3Cdr6nzZeQ25PqMBwwPEd+WUzptYwTiIeuN/KjcxoiJ2H1
         d99Ici2WGHGFXl+kf9WpM1iI7bbHFF7FuIYousbh0QCOl5zIxLlC38HWcjqoGzbb/O4B
         2LQw==
X-Forwarded-Encrypted: i=1; AJvYcCUeudpgBnDn7ooNlZmXCNEIHCIFtXZBqcFR0t9/yr00z21jjT9erDigbdoppquBmxZ3PIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/Z0OaiP2AjCc8Z3gud4way6LdA1MpCkArkAglayKPlzTBQeZ
	TGAaSKMKiPgcI1BsI7yYA8+DrF/vUZpbNsnO49SlzpGLrxr3MpP2cROuT9pv391beC1tjEm7MAI
	9Ka9yvlYOI1HtKmpuX/XmRJyJVus=
X-Google-Smtp-Source: AGHT+IGkSGqR4la2hkTNwJcnTEfU2p21TLo6HYRaMyWdbH+R5jipStCIxk4Rxl5nt/205kerStZqIp5IYq+xCSeabq8=
X-Received: by 2002:a05:6214:5788:b0:6cb:d1a7:aa1e with SMTP id
 6a1803df08f44-6cbd1a7af4cmr9516806d6.21.1728473887926; Wed, 09 Oct 2024
 04:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
 <20241008091718.3797027-4-houtao@huaweicloud.com> <CAEf4BzaxYNZ=xc15O7ai5Fqd8XOON5t-Z25mFGGaSu=63j1T1A@mail.gmail.com>
In-Reply-To: <CAEf4BzaxYNZ=xc15O7ai5Fqd8XOON5t-Z25mFGGaSu=63j1T1A@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 9 Oct 2024 19:37:31 +0800
Message-ID: <CALOAHbASB9OXkmVnhirB217Ndf9RR4vOZqnJF142UyKaAvdkPw@mail.gmail.com>
Subject: Re: [PATCH bpf 3/7] bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:26=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 8, 2024 at 2:05=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> w=
rote:
> >
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
> >     b0 c1 55 f5 81 88 ff ff f0 f0 f0 f0 f0 f0 f0 f0  ..U.............
> >     f0 f0 f0 f0 f0 f0 f0 f0 00 00 00 00 00 00 00 00  ................
> >   backtrace (crc 781e32cc):
> >     [<00000000c452b4ab>] kmemleak_alloc+0x4b/0x80
> >     [<0000000004e09f80>] __kmalloc_node_noprof+0x480/0x5c0
> >     [<00000000597124d6>] __alloc.isra.0+0x89/0xb0
> >     [<000000004ebfffcd>] alloc_bulk+0x2af/0x720
> >     [<00000000d9c10145>] prefill_mem_cache+0x7f/0xb0
> >     [<00000000ff9738ff>] bpf_mem_alloc_init+0x3e2/0x610
> >     [<000000008b616eac>] bpf_global_ma_init+0x19/0x30
> >     [<00000000fc473efc>] do_one_initcall+0xd3/0x3c0
> >     [<00000000ec81498c>] kernel_init_freeable+0x66a/0x940
> >     [<00000000b119f72f>] kernel_init+0x20/0x160
> >     [<00000000f11ac9a7>] ret_from_fork+0x3c/0x70
> >     [<0000000004671da4>] ret_from_fork_asm+0x1a/0x30
> >
> > That is because nr_bits will be set as zero in bpf_iter_bits_next()
> > after all bits have been iterated.
> >
>
> so maybe don't touch nr_bits and just use `kit->bit >=3D kit->nr_bits`
> condition to know when iterator is done?

No, we can't do that. The iterator may only process a few bits, which
would result in `kit->bit < kit->nr_bits`. Wouldn't it be better to
simply remove the line `kit->nr_bits =3D 0;`?

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab28..7fcd3163cf68 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2939,10 +2939,8 @@ __bpf_kfunc int *bpf_iter_bits_next(struct
bpf_iter_bits *it)

        bits =3D nr_bits =3D=3D 64 ? &kit->bits_copy : kit->bits;
        bit =3D find_next_bit(bits, nr_bits, kit->bit + 1);
-       if (bit >=3D nr_bits) {
-               kit->nr_bits =3D 0;
+       if (bit >=3D nr_bits)
                return NULL;
-       }

        kit->bit =3D bit;
        return &kit->bit;

--
Regards

Yafang

