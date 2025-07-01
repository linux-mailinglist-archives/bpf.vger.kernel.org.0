Return-Path: <bpf+bounces-62017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34068AF0628
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 00:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D9E1682C1
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E786C283FF6;
	Tue,  1 Jul 2025 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpGoq7zx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F32701BF;
	Tue,  1 Jul 2025 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407368; cv=none; b=H7ed26CIzrW4ST+ttSWzlDShlDxdp7u3jjUgD2aUuWJU+iffOn+MorliFJy2586OG0t3Pg/r87Zi5kt3Ou+pqC2cFvJzJaGK3bjBwBDJaWYAwqs9D6kx2aDEt2liRdQ3K7jiCNKRQ3e3fNZzyBlOMLLBEEFm3Z6Zp3wAonSRmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407368; c=relaxed/simple;
	bh=+EWo1IV1Nxghx5uBib2VgI7eqITXvt6I5GC91/msG0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGz793uGjBs7h85fwBSdp01BgiGeANDCjxoLBW0/fXRNg9i8JxLiPEtBOqX7OfGVFfH1x9U0aXTYHNQtOOS4skuUp7Vkd51KX9B8QzcCdRzTihO+QBzctIwVtxwFIKy5i6OkxaU7hR49t3cFI3ezcGR9+3sMURXk6zh/l1cZZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpGoq7zx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b34a71d9208so2927519a12.3;
        Tue, 01 Jul 2025 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751407366; x=1752012166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipqAfj+VImfOizkjeS1uIf3zYEp2I/r368gzeOpHRCQ=;
        b=QpGoq7zxDTeqz0/ldSIcI0iBWISNbFdo14kvFXN7R8IiSIK6aFfy3iL522S0mLrw0F
         uXYh+vlANjIpC88BcDn5P2CLUMfitEJ6U+3tBDt9wEL9iizbyF4v0hy7CPx3GCLOJkf/
         o9jpv8FliehOauKWArY7olYVOyF7wfZicUolj5xfI8rF8efId/C5uYuhSnlpCsWA9fYn
         r9f/2rb2DEARxrUBAJuVwepqWvUkYYp24AhaYEJkpYvG2Q3HvTP9HuzVrWKv+VCR8lHu
         pgf9mIBCSECaDP6J6f5c1es882up2mkKC1r/Csra6AUq+N+qQt+wySGUa1PapAd1Cm1X
         Vsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751407366; x=1752012166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipqAfj+VImfOizkjeS1uIf3zYEp2I/r368gzeOpHRCQ=;
        b=qcAtqeYpojY7KV4ebWa8TVtztJ0NAshy1PfrURDrALwGTmf3QEMZIXEFtDBMwkFnqV
         pr6G1hSiYVaxHw3t2RX1pFNjHHc6bwwJ58GozZnMRw4pxxphXl/wQRVPFYEoERFceWJF
         PSbAPvezjZpQvQVhcyRsL8/UeRpl5oo5ESO4J9QWq7yCUGeUiugJin4pxPZSg3H+KdQt
         4iisfgZvf2uI3psWQ7m+y2KUbtjSNbBGd9pasjNMGSBCVshOMht0XfpUCIIAzfeknU8y
         69J/Rb6IambexOVZ4WltnaoEz+T1etZ/mkNlTrWGX2DEnA7WUicwWRGt8JHk6zcSClE8
         xUsA==
X-Forwarded-Encrypted: i=1; AJvYcCXfUGEJqIcWvPhiHz9pBRpCCf+OT7rTFzDxmiA/Ls/Fx35ndacYWMky6vcKCJrrZuWfp1FoGDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eAEc4h+T1hluTzaxiSd7Pq96aVfMIRoV2DjvclIO3ZkoADKn
	ZhTm+Z6LvBqj36iIhozlPbnEdDUFh/x6gzL2b9xtoT4D815Wgh3cI4cwVA6NJ0M4r1XKoGCFXD0
	bM937NoMvKzMDvkC9B4P0I8YZ0rmO8MIO6kfZ
X-Gm-Gg: ASbGnctY3OoGIGkyN2zU6VbSKOFS2ZrbOT7slHXsomBkcG6lknmojgstALdNRUfIGEZ
	s/MgNvzMBAp9P7sQt7AzcEj8L6WPMcbJGYtRzPwFLD7J4fNO6oqlQgOsCkEO0m58bWTy2G9vlhG
	KsETkzgGl62029wcRhSKLr2CHNAiVnZ6dZZIvccb3vuY8xWBfyQkjQQK8UTWs=
X-Google-Smtp-Source: AGHT+IHwPffc7qdwnNTGRxJeO4F3cES8PkK8Bn9oH8Y69K5CGEib1I5W1o4b+bq2m29v9YD2rF39P7VKsnrY8OwoMTs=
X-Received: by 2002:a17:90b:268e:b0:312:29e:9ec9 with SMTP id
 98e67ed59e1d1-31a90bed2b5mr780624a91.24.1751407365943; Tue, 01 Jul 2025
 15:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627233958.2602271-1-ameryhung@gmail.com> <20250627233958.2602271-2-ameryhung@gmail.com>
In-Reply-To: <20250627233958.2602271-2-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Jul 2025 15:02:31 -0700
X-Gm-Features: Ac12FXyDrFCeSylAjFka1avw9-wCtzXa9LmACjWQF9zsifZTP4QbOnjua5SsmV8
Message-ID: <CAEf4BzYFdiQX3gz8Nd2T2cGm6NCZPzTVCRh+eh_C2gYd=cEMpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] selftests/bpf: Introduce task local data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:40=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Task local data defines an abstract storage type for storing task-
> specific data (TLD). This patch provides user space and bpf
> implementation as header-only libraries for accessing task local data.
>
> Task local data is a bpf task local storage map with two UPTRs:
> 1) u_tld_metadata, shared by all tasks of the same process, consists of
> the total count of TLDs and an array of metadata of TLDs. A metadata of
> a TLD comprises the size and the name. The name is used to identify a
> specific TLD in bpf 2) u_tld_data points to a task-specific memory region
> for storing TLDs.
>
> Below are the core task local data API:
>
>                      User space                           BPF
> Define TLD    TLD_DEFINE_KEY(), tld_create_key()           -
> Get data           tld_get_data()                    tld_get_data()
>
> A TLD is first defined by the user space with TLD_DEFINE_KEY() or
> tld_create_key(). TLD_DEFINE_KEY() defines a TLD statically and allocates
> just enough memory during initialization. tld_create_key() allows
> creating TLDs on the fly, but has a fix memory budget, TLD_DYN_DATA_SIZE.
> Internally, they all go through the metadata array to check if the TLD ca=
n
> be added. The total TLD size needs to fit into a page (limited by UPTR),
> and no two TLDs can have the same name. It also calculates the offset, th=
e
> next available space in u_tld_data, by summing sizes of TLDs. If the TLD
> can be added, it increases the count using cmpxchg as there may be other
> concurrent tld_create_key(). After a successful cmpxchg, the last
> metadata slot now belongs to the calling thread and will be updated.
> tld_create_key() returns the offset encapsulated as a opaque object key
> to prevent user misuse.
>
> Then, user space can pass the key to tld_get_data() to get a pointer
> to the TLD. The pointer will remain valid for the lifetime of the
> thread.
>
> BPF programs can also locate the TLD by tld_get_data(), but with both
> name and key. The first time tld_get_data() is called, the name will
> be used to lookup the metadata. Then, the key will be saved to a
> task_local_data map, tld_keys_map. Subsequent call to tld_get_data()
> will use the key to quickly locate the data.
>
> User space task local data library uses a light way approach to ensure
> thread safety (i.e., atomic operation + compiler and memory barriers).
> While a metadata is being updated, other threads may also try to read it.
> To prevent them from seeing incomplete data, metadata::size is used to
> signal the completion of the update, where 0 means the update is still
> ongoing. Threads will wait until seeing a non-zero size to read a
> metadata.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../bpf/prog_tests/task_local_data.h          | 397 ++++++++++++++++++
>  .../selftests/bpf/progs/task_local_data.bpf.h | 232 ++++++++++
>  2 files changed, 629 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_dat=
a.h
>  create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.bpf=
.h
>

[...]

> +               /*
> +                * Only one tld_create_key() can increase the current cnt=
 by one and
> +                * takes the latest available slot. Other threads will ch=
eck again if a new
> +                * TLD can still be added, and then compete for the new s=
lot after the
> +                * succeeding thread update the size.
> +                */
> +               if (!atomic_compare_exchange_strong(&tld_metadata_p->cnt,=
 &cnt, cnt + 1))
> +                       goto retry;
> +
> +               strncpy(tld_metadata_p->metadata[i].name, name, TLD_NAME_=
LEN);

from man page:

Warning: If there is no null byte among the first n bytes of src, the
string placed in dest will not be null-terminated.

is that a concern?

> +               atomic_store(&tld_metadata_p->metadata[i].size, size);
> +               return (tld_key_t) {.off =3D (__s16)off};
> +       }
> +
> +       return (tld_key_t) {.off =3D -ENOSPC};

I don't know if C++ compiler will like this, but in C just
`(tld_key_t){-ENOSPC}` should work fine

> +}
> +
> +/**
> + * TLD_DEFINE_KEY() - Defines a TLD and a file-scope key associated with=
 the TLD.
> + *
> + * @name: The name of the TLD
> + * @size: The size of the TLD
> + * @key: The variable name of the key. Cannot exceed TLD_NAME_LEN
> + *
> + * The macro can only be used in file scope.
> + *
> + * A file-scope key of opaque type, tld_key_t, will be declared and init=
ialized before

what's "file-scope"? it looks like a global (not even static)
variable, so you can even reference it from other files with extern,
no?

> + * main() starts. Use tld_key_is_err() or tld_key_err_or_zero() later to=
 check if the key
> + * creation succeeded. Pass the key to tld_get_data() to get a pointer t=
o the TLD.
> + * bpf programs can also fetch the same key by name.
> + *
> + * The total size of TLDs created using TLD_DEFINE_KEY() cannot exceed a=
 page. Just
> + * enough memory will be allocated for each thread on the first call to =
tld_get_data().
> + */

[...]

