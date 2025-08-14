Return-Path: <bpf+bounces-65683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ACBB26F42
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 20:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281BE1CE29D3
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 18:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A621CA1E;
	Thu, 14 Aug 2025 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOhlrM+m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B1319871;
	Thu, 14 Aug 2025 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197189; cv=none; b=hBnwSRR/gUQaoUXOBoeY/WRA42khvOHQAbtevvmRiiSTre9P6L3H5/o1WW46TzciQSuKjt6LXfBEphtFuyEZITNIjoS6pb3t3avklquQ5YqLPtPYKyzd0KifhvvgpCrEa9/1YH8uhrlgAUcf+0UQ96N6edpWgnV5CIRLqleknFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197189; c=relaxed/simple;
	bh=a6n8Iu6FZeMKuaXu8lvvUCoC0bgRkqYHDoPaT2CPWJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dybLL96VN4CZUwhB/5EZD10zTcJiqgZKwdGCKYvyXKvYUB6RfvHowZGZbKyqCC4ofqNG1H8bdcIKtn8x4VBS2a04pZ8v8ymikBg1e20AycpaOX5Y92XbxQHrtEUThseo3jmeVsBAYu3uz6v0lticByxWCNxYfdjrxnBh21GACEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOhlrM+m; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326bd4f4dso1367349a91.1;
        Thu, 14 Aug 2025 11:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755197187; x=1755801987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF5k2ycHGvbJY//0DmnDLC/Hoc1hEECAW07VH5T2vh4=;
        b=JOhlrM+mxRZj7iixpKfQB1nT14IIwLF1P1M6FMOvCny7QcJJa2yYtScSuwluUoMocI
         zzUpkl8LrkQAXQfe5+nYzpQoX8W9wef7xPNVTVjWpJyqBnOMAReCXwQ5IQxks9uBnTvo
         R5MFEa1G48ZPecW4kq3i6VfPWYpQHt7ZbiPTw7mdlZjZ3AMHXqAH1ntjpNLPmcMGWsSA
         Tnp80e+kVhEND7uBnH89pQjaErA4EfRgEOHc9Bqtz82fdsTfMY5tjNy/G8wlIpFb/Pra
         8w3SRRybokM2x6j0qJ55x1ASkDU0/9uTLRyWl2pbN1d1z32Jv+pKw/Vvk8ABIZ8A9u09
         Ut7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755197187; x=1755801987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF5k2ycHGvbJY//0DmnDLC/Hoc1hEECAW07VH5T2vh4=;
        b=PBfmgZLB5oc0CgnBjlfgLlrH1KjIk9HE2JVDfuLGkXa/aIUmZtwsH40yKnu6Sv6+yo
         tzCYIpePd2I1mnvDNS2wrVSPGOHOv9ytZPheaZPsGq3tdJlYLIIyb9BW9/Z8Dv/rsd8g
         m6FIxWzqmBNpOt95VcpQ0BF5RSZNEkQ9okkoxmjOhxddxMDmU+8/ZVDGREDADZCo353j
         TsF4lvwW1jzLq0NpZWRk3jDfTqTg757A2hVJPUpVFQMdDJ2T+IGxFT4ZJciz8GFdaMld
         f/Xtmazsfml74cVjK4CAkuBz7AJgEkLdOYMPvyjEKP1rBEcrnb11yaoYEUt8oHtxMOQs
         33pg==
X-Forwarded-Encrypted: i=1; AJvYcCVKaClIT3j90ejRMblq57iJXZxlKUKp7WV/D0KU+g0+vCaqFYQUFiqXB1NVHvtdaZnxMK1+UpgVh0Ahf9ldQmssz/cyId0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9rEjqPYWVa9PdDs2cGr+RDJotrhstlr1KuX1xnv+p3o/dvNh
	YN7no2nLj0Ke/K5s0AmoWmV7x0QRQC+ItXtHokxArl6kGqi+jvjdTuqBOnYTpM3ijFMU1tDxiCx
	TL3uRpWIDgxSLFgkwK/wSdhJgr8Ly92U=
X-Gm-Gg: ASbGncv64mlPhYVNF5gbi4fXxwbn16qwAtAninQ/+qtFplxmTSqY+lWI5b83rs4bC5b
	vjA69pkbt+ugF7mwAwKgMSyhGnHDDAQvt7gneVqmMtf1KGlgAb3I0RuRhdApBFDggzlWE7x38JI
	BMs+lRsEIviHHEscixw4bT8Hdh/jyQMeUkKSF1qb+MXL42tNpA2uK+ZJvbtrTgEr5QYsRcuKjpg
	ojM
X-Google-Smtp-Source: AGHT+IFWsVJ6U4WCBsHjtQAcHwKusamUd3HswCJZVBEXoDslP+2cSy/4x/Snv69UDq0ZMoWMrc5kofTOqEyKelDJKbY=
X-Received: by 2002:a17:90b:580e:b0:313:d361:73d7 with SMTP id
 98e67ed59e1d1-32329ae3857mr5793927a91.13.1755197186845; Thu, 14 Aug 2025
 11:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-4-kpsingh@kernel.org>
In-Reply-To: <20250813205526.2992911-4-kpsingh@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Aug 2025 11:46:13 -0700
X-Gm-Features: Ac12FXw7bXjtzkmEcBggdprzyVrDzvWxSBYT565h9nfpmC-8yGNwNh3nqyF4qLM
Message-ID: <CAEf4BzaPJzR71X4ctBtu-Zasr+==uO_hwFqoL8v+gKJWiQ7gnw@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] libbpf: Implement SHA256 internal helper
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> Use AF_ALG sockets to not have libbpf depend on OpenSSL. The helper is
> used for the loader generation code to embed the metadata hash in the
> loader program and also by the bpf_map__make_exclusive API to calculate
> the hash of the program the map is exclusive to.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c          | 59 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h |  4 +++
>  2 files changed, 63 insertions(+)
>

LGTM, but see note about unnecessary libbpf_err()

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8f5a81b672e1..0bb3d71dcd9f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -43,6 +43,9 @@
>  #include <sys/vfs.h>
>  #include <sys/utsname.h>
>  #include <sys/resource.h>
> +#include <sys/socket.h>
> +#include <linux/if_alg.h>
> +#include <linux/socket.h>
>  #include <libelf.h>
>  #include <gelf.h>
>  #include <zlib.h>
> @@ -14207,3 +14210,59 @@ void bpf_object__destroy_skeleton(struct bpf_obj=
ect_skeleton *s)
>         free(s->progs);
>         free(s);
>  }
> +
> +int libbpf_sha256(const void *data, size_t data_sz, void *sha_out, size_=
t sha_out_sz)
> +{
> +       struct sockaddr_alg sa =3D {
> +               .salg_family =3D AF_ALG,
> +               .salg_type   =3D "hash",
> +               .salg_name   =3D "sha256"
> +       };
> +       int sock_fd =3D -1;
> +       int op_fd =3D -1;
> +       int err =3D 0;
> +
> +       if (sha_out_sz !=3D SHA256_DIGEST_LENGTH) {
> +               pr_warn("sha_out_sz should be exactly 32 bytes for a SHA2=
56 digest");
> +               return libbpf_err(-EINVAL);

this is an internal function, so there is no need to use libbpf_err()
to return error codes. Here and everywhere below should be just
`return -Exxx;`


> +       }
> +
> +       sock_fd =3D socket(AF_ALG, SOCK_SEQPACKET, 0);
> +       if (sock_fd < 0) {
> +               err =3D -errno;
> +               pr_warn("failed to create AF_ALG socket for SHA256: %s\n"=
, errstr(err));
> +               return libbpf_err(err);
> +       }
> +
> +       if (bind(sock_fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
> +               err =3D -errno;
> +               pr_warn("failed to bind to AF_ALG socket for SHA256: %s\n=
", errstr(err));
> +               goto out;
> +       }
> +
> +       op_fd =3D accept(sock_fd, NULL, 0);
> +       if (op_fd < 0) {
> +               err =3D -errno;
> +               pr_warn("failed to accept from AF_ALG socket for SHA256: =
%s\n", errstr(err));
> +               goto out;
> +       }
> +
> +       if (write(op_fd, data, data_sz) !=3D data_sz) {
> +               err =3D -errno;
> +               pr_warn("failed to write data to AF_ALG socket for SHA256=
: %s\n", errstr(err));
> +               goto out;
> +       }
> +
> +       if (read(op_fd, sha_out, SHA256_DIGEST_LENGTH) !=3D SHA256_DIGEST=
_LENGTH) {
> +               err =3D -errno;
> +               pr_warn("failed to read SHA256 from AF_ALG socket: %s\n",=
 errstr(err));
> +               goto out;
> +       }
> +
> +out:
> +       if (op_fd >=3D 0)
> +               close(op_fd);
> +       if (sock_fd >=3D 0)
> +               close(sock_fd);
> +       return libbpf_err(err);
> +}
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 477a3b3389a0..8a055de0d324 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -736,4 +736,8 @@ int elf_resolve_pattern_offsets(const char *binary_pa=
th, const char *pattern,
>
>  int probe_fd(int fd);
>
> +#define SHA256_DIGEST_LENGTH 32
> +#define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
> +
> +int libbpf_sha256(const void *data, size_t data_sz, void *sha_out, size_=
t sha_out_sz);
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> --
> 2.43.0
>

