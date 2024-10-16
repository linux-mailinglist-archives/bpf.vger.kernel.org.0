Return-Path: <bpf+bounces-42208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653C39A0FA5
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C5728103F
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DAB2101A3;
	Wed, 16 Oct 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtIBj55w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B082E20F5CF;
	Wed, 16 Oct 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095956; cv=none; b=GtJmcHPHtXFTpTTluWMgRJ7Vsr1t3hUOGz3DOZrERqVyTuJFqJVhcQUn7stfZDRRpBkSNssAa9imLxgbgtJtwkvnr+poewZgW8HIhDrlAjmVWv67Lpd51qVrXrJT+ixtXoQqmcarijAE+Z1lUTatXPkGzHHGySICMlYWT5cQoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095956; c=relaxed/simple;
	bh=IdnkNhSAEXmp5sxcZT/I2gew6kZAgvyxl1oAYR5Y4zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyeoAzKtjTmDKe7zD3ESfSfyBt4VZunGr68xj2663vEN38V1jj8xc4HXwD7vRcGpJ51bhkHICYI+Mnz8wQ+TtghGwqof2+fCTk8G13ec+8VJYtOLNgPzcMj0xKLJiOtOgyBY5O+JL8AASeOBvz5qLIvaKRV5DUZV7iJ/fblfhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtIBj55w; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso4657292f8f.0;
        Wed, 16 Oct 2024 09:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729095953; x=1729700753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR3RsLxzUItppKn1EAT2PNKyiFhGJaytTGKswiLvCnk=;
        b=QtIBj55wI2ssfoVpTq/cKQMBnN8MYO5rmC2zPTjzF1C1WetvD66rAt5ByLS9DG/PtU
         aIQzvTfucALiRYhhvxvlfIdzsdM2+NYJqsexF5LPONpRhTmyQ1EfHvTSgXOc2fm4yR6I
         FazGOsSja3NeBxjN77Kmzpwr7asgMJ5pqmhCX3Kd0BVD1GKG7aX0PcI4p/39cRgYUxsh
         z6JOz3/EVyxA538NW5nvVLKBbkWyd9LBrvwQ88FS1tEtQGOW0hINQ6E7TIOJeed8d8LB
         26lAxl/vZUDXe6UXCVB71Dm7E21h5aZH3dE6b+XYGsgJyWVPNL5tjkVfnaZ1EXq2Gm5p
         PyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729095953; x=1729700753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR3RsLxzUItppKn1EAT2PNKyiFhGJaytTGKswiLvCnk=;
        b=wLBkJBJnQ+VuWWmgRLGzqv2tseR5cXt36d6N92FLidFFpFp6hqc4QcSkGIf8FLf1Lq
         rUSnl0gYmi69hOTh0dYLDXRIacU5PKGMa80P8F76GCRt6CqXzsY2xQeJuA0A4rTQNSEw
         d++2avZ0AU0EhDp3bc+H+Sdh1+REvT9W8xULUIE0Uk1/bqO0mukaBGJMY41fHO2213Ep
         57DQ7ninAajkv0NF6aPkOcUS6lIdQrAqAkBLwPRx8uA/cuSeqoHQcd18vWI4plj/mFak
         gFeMJ169z8hzTo3Kfcm8pjwAVpi0qHkbISoavsvCcSTqrOAHDDKa2Rz9r+oUNbz4OXiy
         UXew==
X-Forwarded-Encrypted: i=1; AJvYcCVE2htGSkX5Lr7+oU4rfNzxLxtPaMZ547lcgUN2W3z1mxTs1QqSyXatUT5FFVxnzjvJTRyTapja@vger.kernel.org, AJvYcCWIjN4MYqquG63Lclzb3l/2LLKAi/vNxgH5yLG8HwF3sHhinMZC/16i7K0o9K9GqJ4i9XW5pkY2sYaCiA==@vger.kernel.org, AJvYcCXDwro4igwoGP4XBQVcxciDIWIQL2MNbGd5/IFTbFYHBZFk+aCzJAyAl5nexC1avufrifc=@vger.kernel.org, AJvYcCXsuaGJWEfVCqX7OmdjASHbOsTiP7PGfnbDTBkEZaTqJOsg5gjdG4vgMGIml5Mg6S5mvLkYGzmcc047gMHk@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRG/Zr/yEvdg4KHD+ECiyflF39lB9VuWijp25ObZDm0d9RBYz
	5g7CWCEKdeabTsy58WG88htKSyIdWl/AnImwuXGXQ3E7GsM+xaSfWokIySMWI+6UGzSdTJD33iN
	wC6Y0cHF9ns8Sewq5oDuNNn5ptVI=
X-Google-Smtp-Source: AGHT+IHGey79evvc844ZfIKNi1g2MdcE+aKhvjfz19yoOhZwP8OYIT7m9n40nhWhPFs2cICVI1xPIrMK8SK7QN8Bbwo=
X-Received: by 2002:a5d:690c:0:b0:37d:633a:b361 with SMTP id
 ffacd0b85a97d-37d86d6944cmr2992713f8f.51.1729095952917; Wed, 16 Oct 2024
 09:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016170542.7e22b03c@canb.auug.org.au>
In-Reply-To: <20241016170542.7e22b03c@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Oct 2024 09:25:41 -0700
Message-ID: <CAADnVQJ=Woq=82EDvMT1YRLLTvNgFVSbnZDiR5HUgEhcyBLW4Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:05=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> After merging the bpf-next tree, today's linux-next build (arm64
> defconfig) failed like this:
>
> Building: arm64 defconfig
> In file included from arch/arm64/include/asm/thread_info.h:17,
>                  from include/linux/thread_info.h:60,
>                  from arch/arm64/include/asm/preempt.h:6,
>                  from include/linux/preempt.h:79,
>                  from include/linux/spinlock.h:56,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:7,
>                  from include/linux/slab.h:16,
>                  from mm/slab_common.c:7:
> mm/slab_common.c: In function 'bpf_get_kmem_cache':
> arch/arm64/include/asm/memory.h:427:66: error: passing argument 1 of 'vir=
t_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
>   427 |         __is_lm_address(__addr) && pfn_is_map_memory(virt_to_pfn(=
__addr));      \
>       |                                                                  =
^~~~~~
>       |                                                                  =
|
>       |                                                                  =
u64 {aka long long unsigned int}
> mm/slab_common.c:1260:14: note: in expansion of macro 'virt_addr_valid'
>  1260 |         if (!virt_addr_valid(addr))
>       |              ^~~~~~~~~~~~~~~
> arch/arm64/include/asm/memory.h:382:53: note: expected 'const void *' but=
 argument is of type 'u64' {aka 'long long unsigned int'}
>   382 | static inline unsigned long virt_to_pfn(const void *kaddr)
>       |                                         ~~~~~~~~~~~~^~~~~
>
> Caused by commit
>
>   04b069ff0181 ("mm/bpf: Add bpf_get_kmem_cache() kfunc")
>
> I have reverted commit
>
>   08c837461891 ("Merge branch 'bpf-add-kmem_cache-iterator-and-kfunc'")
>
> for today.

Thanks for flagging.
Fixed and force pushed.

