Return-Path: <bpf+bounces-77069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DC0CCE06D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA51230495B2
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5753015539A;
	Fri, 19 Dec 2025 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLLZRNqF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E2DDAB
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766102753; cv=none; b=nf2SLDDjkG37qYsCgO32nFsJeJHkGgGlfdktoZ4aRhcrrY9eu4NVOcLF9RaPAM0Y84c76gUJZA+whYRRzZiurWI6VrsKs1AYvlTw7HekvO+jUlMx80f8GqGZQDkYxch1Ks7xij5h1vtOMBnPIJ5wpTsam1pIyoX4zCt44R7aLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766102753; c=relaxed/simple;
	bh=KrPlzOUPPhmYSfs16q6j5wqlISAIfTuVFGH4r/JLPF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNv16ycZTtvMx+yq2IeILZ2BMZWFXBlAa01LLSlLIRhKZ3AbATj3b1xKZ6OXMGPwPRd4ddZ3cKDjV4yTDeK9+/mBkHfTGD4B6OOAN0/VlvGsi/doQKzqEads1HOtK/UgCOEnwToXuUVtY9wU08KMx9XuBATXbap1WHiDPGpeDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLLZRNqF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34ccbf37205so959630a91.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 16:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766102751; x=1766707551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W38EWWdDRia0twE8MUdk6p9MJgTVOZZr+EjComvdICA=;
        b=LLLZRNqFad0/Ezj34PA8UtcJ/urnhlnFXWvwlXBhDz2gBV5FCBXe0+4dPdCsKco+P6
         VFx022LkkRS2urskDYym1TpoXrMD0XYxxqk13VtajH3Q7ydiyTBe8hfbTr2agZaIU5r8
         0T9rpKIDDTyINlg4LD3rlCXcfGMVT2arkywabYLKtFkpzH5W34sG33+PMdxh6CTfb03S
         4pSle3r8lcljjUX1ASHXoYCjrUEg3D25P2aYnSSF2bDF+6YnyZBl5lKdC/9IsthE+Pkm
         Lz4QJZovqyCQ3oVvbwQo+ayDxvO4juClXDpNzCf++aNa4c4ndOm1fD2AwjpzZWN+ZOtn
         TAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766102751; x=1766707551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W38EWWdDRia0twE8MUdk6p9MJgTVOZZr+EjComvdICA=;
        b=CBbo78qDM5iER8GtbU/aQ67lUaLt8mYtoUsoQZyU3lIoqth19kcj9ZrI2ZMB+uHcxK
         1Aeo9Q9vcOi8y6yDUtHqPimQy4yfC43pwXlkv4hu+XL/hbMnM6K3uvUdzQoubik9+XBQ
         AWIcc1UIbhXevVa1eRBuxRiF9u9Z9/MCPcO9hTf06JrrEXwYKDduPINXHYPYSdg+Rb39
         Hv/GWcJncVoH6lDr9Fdi+lFLwneD98wO6c9Ejnri0EnJa/ZG4fltIyQSjpylcvL6FHVb
         Kr40G8fCivoTvMZekLujuZZ8qNG/JMx1R1HDX8B01E0fOxqQc7tIaLcuHZkXNqktCnjF
         Hm+g==
X-Forwarded-Encrypted: i=1; AJvYcCXQitVojW6efBMESrKJXTT88VgbAHrQk2l3K9acxjRvvn9lxeqX7QvbUh0+bCSG9kjGY/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVf8VgJ7VlW9WiXAhXkinn4DHVhVwwby+QoP+EzpJP9J7uSm+M
	W/rqBPPNuVNPsVqYYe8LWH/SZwQRQqM0vEYKHuKm47zZCyy77JGucZgwBpSCKAW/gpLQr76sHkd
	86CfcYvAX5hKh6Zpc1kYilFyDzqEpOwk=
X-Gm-Gg: AY/fxX7bx4ba6H5Aomyx0fFKM41cO31P1EwsJL9AnErgrtOwqmjv0tDfzpB/1Nl7ptM
	XxWX2RcUFGXAyxivlt37yZwvz2/Uewo3tR6ZtkQMrVkrciTri/DnmSoXqSoSTVU2jW/A2jj/hzE
	n+c6IXLZD5ZBV9np0Xw9kkE7Mh4/1jkU+MN6a+d1TCD0x/Dc/DvPUUFcqpB6oP44g8lQlAVJtCP
	8mi4EyNnRxfp4K+xE/dbBwukFj67/VNFg4I2gjIWg/Qbs3THlSdNSutDuX3BC8tgC2aOMNFPSoq
	wm6xqxM1ubo=
X-Google-Smtp-Source: AGHT+IEoc0YoxBLwW7VQqqjVpm7SUNA3lm+HP3FAztDK3O9o4IUPyetYTo7w8Y32+E5kqxFZwcPvwlBiSAtyC9nS1Zo=
X-Received: by 2002:a17:90b:548c:b0:32d:e07f:3236 with SMTP id
 98e67ed59e1d1-34e921be38bmr621859a91.22.1766102751592; Thu, 18 Dec 2025
 16:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com> <20251218113051.455293-13-dolinux.peng@gmail.com>
In-Reply-To: <20251218113051.455293-13-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 16:05:37 -0800
X-Gm-Features: AQt7F2oGwuurU7QbM9Vu35VgHacNwICF2nOAK8RIwBdV8-RQ-WkZyfplPO_xEtg
Message-ID: <CAEf4BzYwEywc2y8VV=1s2gjrQxsHZzOipNiCeKGTK0bjnqj7LQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 12/13] btf: Add btf_is_sorted to refactor the code
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Introduce a new helper function to clarify the code and no
> functional changes are introduced.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  include/linux/btf.h | 1 +
>  kernel/bpf/btf.c    | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>

let's drop, this is not necessary


> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 2d28f2b22ae5..947ed2abf632 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -221,6 +221,7 @@ bool btf_is_vmlinux(const struct btf *btf);
>  struct module *btf_try_get_module(const struct btf *btf);
>  u32 btf_nr_types(const struct btf *btf);
>  u32 btf_sorted_start_id(const struct btf *btf);
> +bool btf_is_sorted(const struct btf *btf);
>  struct btf *btf_base_btf(const struct btf *btf);
>  bool btf_type_is_i32(const struct btf_type *t);
>  bool btf_type_is_i64(const struct btf_type *t);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 3aeb4f00cbfe..0f20887a6f02 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -555,6 +555,11 @@ u32 btf_sorted_start_id(const struct btf *btf)
>         return btf->sorted_start_id ?: (btf->start_id ?: 1);
>  }
>
> +bool btf_is_sorted(const struct btf *btf)
> +{
> +       return btf->sorted_start_id > 0;
> +}
> +
>  /*
>   * Assuming that types are sorted by name in ascending order.
>   */
> @@ -649,9 +654,9 @@ s32 btf_find_by_name_kind(const struct btf *btf, cons=
t char *name, u8 kind)
>                         return idx;
>         }
>
> -       if (btf->sorted_start_id > 0 && name[0]) {
> +       if (btf_is_sorted(btf) && name[0]) {
>                 /* skip anonymous types */
> -               s32 start_id =3D btf->sorted_start_id;
> +               s32 start_id =3D btf_sorted_start_id(btf);
>                 s32 end_id =3D btf_nr_types(btf) - 1;
>
>                 idx =3D btf_find_by_name_bsearch(btf, name, start_id, end=
_id);
> --
> 2.34.1
>

