Return-Path: <bpf+bounces-70062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A09BAEA01
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 23:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C2F166CB9
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9412BF000;
	Tue, 30 Sep 2025 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQFBwlg/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026CA221FBA
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759268345; cv=none; b=oL6QqRv+Ur8yw5sRB8JTOvmb2PXjkk3WniwHnIMMTc90oEqYkhzfnZE67ecO+FikqaqOpGkr7pQpw472QU/ofc5GSnXdC+EO+oXXS9cQXQccqOiSaHlISMm31lG/v3UC1UEOeyoiICLhEEl2FKqty8aOUYLHJKi+yvFK8Dt8Y1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759268345; c=relaxed/simple;
	bh=ucon9iZxZ257gpZgMxGc5vjA02SSzR8exqSZ9OJQsJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDAciSmmxuda8l2nyfXbFkFmv3VXFCe3Vsk2r0pNgSUlIgajMaHJv9fYS1qRAnQ7UNu3Qgote7PW2kWgIv5q7EBgxHMpmXc1lYtbjRy556yuyM6Pn1lDitGhmgiDzjKrtII57BNvci1B3bz37AOzEVyHxYBs4CirxMsP3u09SJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQFBwlg/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3352018dfbcso5271353a91.0
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759268343; x=1759873143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pnqsoqdGsC2SD35Ll7lPerM/DhytpQ+Zvki2/kSg+U=;
        b=eQFBwlg/R70Al9lPbyG4ZaQLq/MExXyF0/7/fbTLNf+k0oa+VyxfDxEAH032mKB7dG
         4MpyKR1vm1PwHsXvPk5a0gS4ElMvGKuz/XTr8/Wq6OXQadVvwRiAD0KVPXgFSSw2JE9z
         TNg7FId6FeEpaMhziWBqgi+IM6tlAjKg4UnHbPRCDNRs9l4Con2xTQjXMfXIH+/laavx
         tuyH+MGIoKD2kfchHkiSAKfZ01yg0wDhR0l3Q6c4CLIUoerHiMnQwhUy5AZMqGT2mZNQ
         zEYaem2XPp9/LY+raecTEde4hAhXF6DSq09u1DkX5DGNJkIw4NnPMHGbWxmR+XToGKqk
         WgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759268343; x=1759873143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pnqsoqdGsC2SD35Ll7lPerM/DhytpQ+Zvki2/kSg+U=;
        b=HOXjwNq3zQEGfi/0/st5Bk+qBt0r02GEZayD0fT4GNSHspJeO4DdHOTAWg4oLdS9ap
         rUuSXLnXNezYOw8X60eblfak8TFzQniOq2eBfPxQTCUKumx2lx6P6Ou9FwtowaH38k0t
         PFEvWRGw92ta2OUrIrqp0NL7ytWQh7WuFNWkynS0i23mjba4YcGhuIbgD0P/3s/ox3ox
         UxTBEYLQJAcsRAxjuvot6iP2zOFNlIkQP3bquPun2OySibox3QAB8j6WdJwbjRAq15a5
         Vr6X8FS2d8/DQufaiMmAgan4FuR0QVK67pCttnvnatY0YsQKeFS/DWqzfSnwzqgBYNDT
         DjvQ==
X-Gm-Message-State: AOJu0YxtvUYSOhk/K78SAWaCT44pZkLN9bMQhFdUoLBk+Rn/iwOTVKjT
	9f/7uvFG56PAdE9fulgOmSZ0DCI8ljyxAozuMUERNIza/hCQkh0FIJW/uhhV3K6qLxP+t0Dj44H
	70RvCA4RqZeOs7WnFozLlLHKFcnG8sb/5Eg==
X-Gm-Gg: ASbGncvuRJrj5GuenMyclN004nbjHviVkz1NR73JX5DlOUwwufytI+R/doZZvXe3do8
	hqLHXlocO8qh1+rqWH7PTQS5oHKWUKk/bccQ2Z2hA8/TmX/u2vN4tHNK2h4Jj6otx3o8PBZmsY/
	0qmviFXEBaF9Mfz3VHHJq3lMwfEdDIlQvbq5PKIq+KvF30WK2OS8GBLP6rCjtSXgeV63ZH8b+vp
	IpKud0rifAlozcfJZDED+WVfFNT8aWGZklUSX4/xRW+6lI=
X-Google-Smtp-Source: AGHT+IFrHrrC/SUbA4MjXIfdewCUL2INXci4ahJhER8XE0o09AILGMBcxAd0xYLphaiferyyKpqWgFaJAYYYa3Z9VCs=
X-Received: by 2002:a17:90b:3b92:b0:32e:9da9:3e60 with SMTP id
 98e67ed59e1d1-339a6f58d2emr899171a91.36.1759268343180; Tue, 30 Sep 2025
 14:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930212619.1645410-1-andrii@kernel.org> <20250930212619.1645410-6-andrii@kernel.org>
In-Reply-To: <20250930212619.1645410-6-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Sep 2025 14:38:49 -0700
X-Gm-Features: AS18NWDTTjr-EULRhBCUOcKC17Y6TZkY7JvRWQ3NH0VujMY6GYQ_aqD240YA2yk
Message-ID: <CAEf4BzZcX-H710BYjjRuAcu+ROHN+a+HDZCgGkMa3AZaC5sqpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] libbpf: remove linux/unaligned.h dependency
 for libbpf_sha256()
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 2:26=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> linux/unaligned.h include dependency is causing issues for libbpf's
> Github mirror due to {get,put}_unaligned_be32() usage.
>
> So get rid of it by implementing custom variants of those macros that
> will work both in kernel repo and in Github mirror repo.
>
> Also fix switch from round_up() to roundup(), as the former is not
> available in Github mirror (and is just a subtle more specific variant
> of roundup() anyways).
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf_utils.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.c
> index f8290a0b3aaf..4189504fae75 100644
> --- a/tools/lib/bpf/libbpf_utils.c
> +++ b/tools/lib/bpf/libbpf_utils.c
> @@ -13,7 +13,6 @@
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <linux/kernel.h>
> -#include <linux/unaligned.h>
>
>  #include "libbpf.h"
>  #include "libbpf_internal.h"
> @@ -149,6 +148,14 @@ const char *libbpf_errstr(int err)
>         }
>  }
>
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wpacked"
> +struct __packed_u32 { __u32 __val; } __attribute__((packed));
> +#pragma GCC diagnostic pop
> +
> +#define get_unaligned_be32(p) (((struct __packed_u32 *)(p))->__val)
> +#define put_unaligned_be32(v, p) do { ((struct __packed_u32 *)(p))->__va=
l =3D (v); } while (0)

doh, obviously these miss be32 conversions, will fix in v2. But let's
see if AI catches this.

> +
>  #define SHA256_BLOCK_LENGTH 64
>  #define Ch(x, y, z) (((x) & (y)) ^ (~(x) & (z)))
>  #define Maj(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
> @@ -232,7 +239,7 @@ void libbpf_sha256(const void *data, size_t len, __u8=
 out[SHA256_DIGEST_LENGTH])
>
>         memcpy(final_data, data + len - final_len, final_len);
>         final_data[final_len] =3D 0x80;
> -       final_len =3D round_up(final_len + 9, SHA256_BLOCK_LENGTH);
> +       final_len =3D roundup(final_len + 9, SHA256_BLOCK_LENGTH);
>         memcpy(&final_data[final_len - 8], &bitcount, 8);
>
>         sha256_blocks(state, final_data, final_len / SHA256_BLOCK_LENGTH)=
;
> --
> 2.47.3
>

