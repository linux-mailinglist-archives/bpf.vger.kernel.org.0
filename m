Return-Path: <bpf+bounces-48008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A08A031ED
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9087C7A1014
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2501E0480;
	Mon,  6 Jan 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3IVtP9c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDE1E04BD
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736198216; cv=none; b=AADmq/P2IWE9mMooAH1bBFT4s31zA+f6Uf50nMJSy059zIMosL7sbMk60XTnRAqSGBujNKFgcRvEyVJECb9aUpRzb7RKynQclBJyGJUr5gyFIjHRLYU2nDErfGouMJjz3L3iZB0SgiZEFnQDHvkNdWIJTy7OguVL2Da3zz70ez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736198216; c=relaxed/simple;
	bh=1MC6P14+AzSGdIuOKneX/6+egizyRUWRAD3wyY6YudA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QS5DyGJtTVd7RqHwXeyK2VagTlej0pO+rifC4sf2ZRSAM1F8iyT3dL2KUaVzTodNOJSTtIvrx0teDex0GfoKfigoiKUMugFq6ZZf/WlJLVHk2OHGwnGSS/JVKOuaSG0QHdvFPI1o5kv0nxNWxmtQgdHGP1QO5DrEK9rl9CKOXAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3IVtP9c; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2161eb94cceso151359735ad.2
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 13:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736198213; x=1736803013; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8FSKo5t/FnwImlCcX+yjCPXUD6uOBgAdeEJO+gk/PUg=;
        b=R3IVtP9cVpYCK+ZfbGi+YPqRdQwI0qq0zjK7wStK3oO/cdPQm7AbZa/8T0OKGsLEnh
         fFRzov9GWHVuCOTVz7Al+KlPRrLrv2uMhrfro/EB0w0il9J7A9Kt6iyBR4juDt29uhTm
         QQd3XeKDnLTBXQhunFGI0nARtqeD84m7ZU177+GFzxu0Lpm14ckInbV/dKFnB/yNkj28
         1ibhHgcFsIBHtYnGvcBwg8+jUjKrcNKQVeuXkCTYyqJVP2sGguOls4ENOmKDX5ZIISYz
         OGbOG+zym8CLqeR+jRlYg2DETkfh5vI2txTtnvhaC6nXmkNfcZy40wjjU5CPHxtq6C5z
         Ws0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736198213; x=1736803013;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FSKo5t/FnwImlCcX+yjCPXUD6uOBgAdeEJO+gk/PUg=;
        b=w73j4j72qhJBXjtpYFHa2GQlZ9gti0dTQCnlfX1SjOa0GiPGzU2GTHexPDW3xVbSjb
         tNSlfqv/4TI1oAwW3RyfvKMDqvGM4eHL0jAU6TRGeCAR6H1a2Xr/PJdnWpBSoiNsF/7I
         aBoVlsXaAgDJuJs5VqZ/FuQHTCp1tsqiLs2ofGFpj+zhMeRdazDVO4Fy54u41UN9x4m0
         M5LsrwPFTmEZLYunxSXPwPHxMngVIn50fKtaqDU4RY2qFjq3V+rIJchgOVqvBEwUlO7a
         zF7e23xc6kcj4+gG9cnVdfZJn6FpEkIzBCaUOFx8+YEgJNCURX/WfUK3KfnNfA4c8lCE
         oZTw==
X-Forwarded-Encrypted: i=1; AJvYcCUnZIt0aRSGn0urXdJCoc1nYVMk11o/SkUeXxisaJMdz+cxLMU8ltq6/P6CMbEHC8BdRZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybyRe+pTLO6OZ3/24yTkQqKUu7DCBtUeVxrbO8/RmwGJJ4ZfMB
	Q9IZjCCzCR9QC0V3D+qVaVHwMwAquGm1NhDKDvR9w0K3aQ8yxTt1
X-Gm-Gg: ASbGnct/xkEq9TR1geUM9zxNZoWH0CFfCri7h/n91E7iwsGRAy+UIUoF9vc2zLEy4zb
	jv1ScwBymILDq261IS+c0AwDf2JvpPZ8rh3XwHTw8SFvZkeiYGH8FfWtwIpWpOXfRpp5r8+ww74
	eo7AaLZV9V5unrm89h8nSOoz01zqIqhLGBWc66Kepj7wp/VdXH+UbN0J12c47+E0aeB1tACFH0H
	NeE/sjd19EEHR2rk8Z9gnPkwyNCyXFoUhJQykwV9jlitABexEbUtQ==
X-Google-Smtp-Source: AGHT+IHh33mCPQGprw29oZbyahR1h2grhBSmLzVjhx9qSciQ7Erw5Em8ZXBgpPZHDmdBkO4Vt+ppGg==
X-Received: by 2002:a17:902:cec3:b0:211:efa9:a4e6 with SMTP id d9443c01a7336-219e6ea2b34mr709578625ad.23.1736198213078;
        Mon, 06 Jan 2025 13:16:53 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96ead1sm297592715ad.91.2025.01.06.13.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 13:16:51 -0800 (PST)
Message-ID: <a621a6f62a3e2b30966a5f84be483f0fb6e9061a.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add -std=gnu17 to GCC BPF build
 rule
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com,
 	jose.marchesi@oracle.com
Date: Mon, 06 Jan 2025 13:16:46 -0800
In-Reply-To: <20250106202715.1232864-1-ihor.solodrai@pm.me>
References: <20250106202715.1232864-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-06 at 20:27 +0000, Ihor Solodrai wrote:
> Latest versions of GCC BPF use C23 standard by default. This causes
> compilation errors in vmlinux.h due to bool types declarations.
>=20
> Pass -std=3Dgnu17 when building selftests BPF objects with GCC.
>=20
> For more details see the discussion at [1].
>=20
> [1] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2=
qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=3D@pm.me=
/
>=20
> CC: Jose E. Marchesi <jose.marchesi@oracle.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  tools/testing/selftests/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index d5be2f94deef..d81bb4773cb7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -479,9 +479,10 @@ define CLANG_CPUV4_BPF_BUILD_RULE
>  	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=3Dv4 -o $2
>  endef
>  # Build BPF object using GCC
> +GCC_BPF_CFLAGS +=3D -std=3Dgnu17 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-att=
ributes

From previous discussion it looks like it's better to just enable some -std=
 option for both gcc and clang.
Kernel is compiled with -std=3Dgnu11.
I tried adding -std=3Dgnu11 to both host and bpf side flags:
test_progs, test_verifier, test_maps, veristat compile ok.

>  define GCC_BPF_BUILD_RULE
>  	$(call msg,GCC-BPF,$4,$2)
> -	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c=
 $1 -o $2
> +	$(Q)$(BPF_GCC) $3 -O2 $(GCC_BPF_CFLAGS) -c $1 -o $2
>  endef
> =20
>  SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c


