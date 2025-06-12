Return-Path: <bpf+bounces-60541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A80DAD7EA3
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81463B5D0D
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC492327A1;
	Thu, 12 Jun 2025 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM3Qtv6V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA02153BD9;
	Thu, 12 Jun 2025 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749768966; cv=none; b=BzGTAI/KqDR7jGz19feEX54lah6cnEXVcuHZRM8SFuwsnc4cJwfy5ouyUZrfxhW6deHClBHWLn8m2g0xrjM/r8MaB4x9T1sTh35+ab9x46O1X7UMYfswhIo/BhCk/KM07Zgmr0+HWdG5TBX03xME97iZaNOjluFOZcf1OtnYx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749768966; c=relaxed/simple;
	bh=X6sZ0Yd5Wom0ChcuXMKZhTWW+WsXahKrCRICK3YwZGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHIzpeorg7cNN9VjxcYUr2tp0+KH2JNn3IF2DnF4i4yp/hovk1ukf1+ljRqU6IwZxSpJKnqclq2PlPEr1MYceqvp+te2oe+g6kQ93auXsSYRx+CkLQXDvRiQDMmz+n6wCicvycJzskKOZTe7qrJEWDgsZLMDCss/sDy5fZcd8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dM3Qtv6V; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso1902880b3a.2;
        Thu, 12 Jun 2025 15:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749768964; x=1750373764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meOGjJhSwT7qXsTwte/kIbqFN3wRA+oPn73O9vx1JGo=;
        b=dM3Qtv6V/58sFhrIqOQJXNvKO0w5vzPlyUZ8k1De/X0o78AFRx8pBn/pQ3gerkDM5C
         +ywfAN/x0+RdIIIT9GAe3zgSP2yFbx1OTzvFszSfiBjWrbWavtOJtWwtg7/xYSL3Z7x0
         EnGcY8ky0Q6paCTEpjbO9oahxqFAxUzKAQ+tSaW6RHnJbu3NbSWYZfHfQR5YDU/Eg4eM
         YGoULHHfPyXGQroN1XtApESTDH1cq5n1jkRFrgnUS5wrdC+bShGLvgRKa02CHTlnK9Ge
         u3HYHITRmvvOT0GeghfdUeoMlSOhSX61f+UsJNgVHSUAZQub0XawJFRrMTzn2ZJQyoBn
         pogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749768964; x=1750373764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meOGjJhSwT7qXsTwte/kIbqFN3wRA+oPn73O9vx1JGo=;
        b=OSL6J/8dwe7sepRticUlzNb3In0TiJDXdePwo2JXv1hYb5fjzDQp0iDRQ8IzGGZEgD
         wnarqzD5siohY6QgncaCtQ3VK+3x6WSHI+mvYJ14Vn6S4GE39yXkGH0runqT8DCOl32H
         I5h5YTzbdteedbJIzw0HJxhsn+nj+7Cl6oaLEThIM77xXutIluHSymV+NLTChn+rmlDH
         /0x8rIZ/VYmYzJFumd1GujalvAwxZTqkesI3w29M9kE0O61negNOd8K6/r+Dj0o56a/P
         McygOEJVkO6BXZM5ZDvsCPTgbrJL1jkUoaONzLERk0u75Q0U9W0ITyvR+3ig60mkOaGD
         83wg==
X-Forwarded-Encrypted: i=1; AJvYcCU0U0JQJnClSYQXGs5PADKPvWi+pfh73h+uuXxkcs27WIYlmAcm81G21B/IAtAyEZpoDoB0cMo0D+umVEHXyzUiPCk2xao=@vger.kernel.org
X-Gm-Message-State: AOJu0YymIwRHXLB+kO8OQZUrUE2TTVBCenvzwHZHIXqDtnNtNlM5heyk
	nfTmlSDnLIw9wDRRv/m5x1V/Y38oMyjDsXhTMmqABlwQ+MaxJsPcSVshzABObmCLvkMu2+MDG21
	JP4sW7J6O0kaQ8E/7n9xkhVFHMAc7lv4=
X-Gm-Gg: ASbGncuOCWPRQE4Vo98cNwNPve4yczx1qpoNqhH6OAk+ak5DuEoIHC+e777VbqQ5CTt
	gcYiTjue0JEpnMnQk6SSna880V1+Wtg+PpcZuoJDgvgZaKcssy1UbdZHaijsZ8IXlvRhMOpZRx7
	DAKmwkZZqv0o1wE+ttwaobqtAVhXfyjgYbPXvJM9Dk5xIS2PQCCYdJgE79f2Q=
X-Google-Smtp-Source: AGHT+IEQzOG6n0ypj5znZ7us/yKg3gOclsk/RxdLEdbU4GwMnbUQlAjb4bkD/5S5+xgr5FaEbg32tr5OUxH4y9xWc7A=
X-Received: by 2002:a05:6a20:7285:b0:215:e60b:3bcf with SMTP id
 adf61e73a8af0-21facebaec0mr1138913637.30.1749768963859; Thu, 12 Jun 2025
 15:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-5-kpsingh@kernel.org>
In-Reply-To: <20250606232914.317094-5-kpsingh@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 15:55:49 -0700
X-Gm-Features: AX0GCFvDmvbCIuhLi_XdR4f5yoZPh2STVJBY8j1FyidKUz0M03z2SUKKe9qAG8Y
Message-ID: <CAEf4BzaAjO-EGvuHkx3dndKfchiifAdsU0OofuNMo819iprq7w@mail.gmail.com>
Subject: Re: [PATCH 04/12] libbpf: Implement SHA256 internal helper
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> Use AF_ALG sockets to not have libbpf depend on OpenSSL. The helper is
> used for the loader generation code to embed the metadata hash in the
> loader program and also by the bpf_map__make_exclusive API to calculate
> the hash of the program the map is exclusive to.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c          | 57 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h |  9 ++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e9c641a2fb20..475038d04cb4 100644
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
> @@ -14161,3 +14164,57 @@ void bpf_object__destroy_skeleton(struct bpf_obj=
ect_skeleton *s)
>         free(s->progs);
>         free(s);
>  }
> +
> +int libbpf_sha256(const void *data, size_t data_size, void *sha_out)

naming convention nit: in libbpf sources we usually use _sz suffix for size

> +{
> +       int sock_fd =3D -1;
> +       int op_fd =3D -1;
> +       int err =3D 0;
> +

nit: unnecessary empty line, please keep all variable decls in one
contiguous block

> +       struct sockaddr_alg sa =3D {
> +               .salg_family =3D AF_ALG,
> +               .salg_type   =3D "hash",
> +               .salg_name   =3D "sha256"
> +       };
> +
> +       if (!data || !sha_out)
> +               return -EINVAL;

this is internal API, no need for this (and we don't really check for
NULL for mandatory arguments even in public APIs), so let's just drop
this check

if anything, I'd probably require passing sha_out_sz and validate that
it's equal to SHA256_DIGEST_LENGTH to prevent silent corruptions

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
> +               goto out_sock;
> +       }
> +
> +       op_fd =3D accept(sock_fd, NULL, 0);
> +       if (op_fd < 0) {
> +               err =3D -errno;
> +               pr_warn("failed to accept from AF_ALG socket for SHA256: =
%s\n", errstr(err));
> +               goto out_sock;
> +       }
> +
> +       if (write(op_fd, data, data_size) !=3D data_size) {
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
> +       close(op_fd);
> +out_sock:
> +       close(sock_fd);

nit: given you init fds to -1, you can simplify out* jumping to just
single out: clause with if (fd >=3D 0) close(fd); sequence

> +       return libbpf_err(err);
> +}
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 477a3b3389a0..79c6c0dac878 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -736,4 +736,13 @@ int elf_resolve_pattern_offsets(const char *binary_p=
ath, const char *pattern,
>
>  int probe_fd(int fd);
>
> +#ifndef SHA256_DIGEST_LENGTH
> +#define SHA256_DIGEST_LENGTH 32
> +#endif
> +
> +#ifndef SHA256_DWORD_SIZE
> +#define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
> +#endif

do we really need ifndef guarding these?...


> +
> +int libbpf_sha256(const void *data, size_t data_size, void *sha_out);
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> --
> 2.43.0
>

