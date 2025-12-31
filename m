Return-Path: <bpf+bounces-77628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD62CEC7A8
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A19F8300DCAA
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B073064B5;
	Wed, 31 Dec 2025 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CklObqs8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BA2857F0
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767206281; cv=none; b=nHzUrucDDnz9cWwhvZg5te8ArQzuXUKxpIL8bKWQ3F51G9qvwXuUhFWWf+NPFR1nS/fill05DKmnyO9gH01Xt6DbtSjol9IL0YFmrY8Yl+r4k5N7ZoKk7j08SX1ivhsWdXoRZBVkMbtUwuMPapN88UsVu3ylCjevnefxdclIWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767206281; c=relaxed/simple;
	bh=0GK0ajNcmX4ZLpifmz7FznUkZoVE8FyqsyB13FkJjLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ckgnC3Ea3bYsZb52ppIOp3UJGBa2mJ6X3v68piXPQ99L+2Q0lTT02lALN/8omvusXow/zBlr4QCfUV6lkgSq2+WOlUDl34KJmEYP+hc9F9g0tecvSIuQ9oEZNGbtY7yHxQe0kBf6QkXKn+KamhnLV4ZndPQ8s9ymg49RUqlL8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CklObqs8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso114628035ad.1
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 10:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767206280; x=1767811080; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tdMMIVnMpSWKZDVfjzl/8xYiev+Ss29iey9QZNOAYfs=;
        b=CklObqs8orVgqrwNwgm7cMNAb+3AuVScqUX/GFKeuV/u1a3k+BQl7547ilQPUy0q+F
         U7l/ughz3XSiDx1ZlNjLEc7lnOJSRasmL7SQDTCSKzWdqomP+jK/5eh3n1A5VqmPwDMU
         HJwiJur3Xa+fvytIbRJPuuMmykxanC0W/Gmad4Zf2ZsQFtubM2LaWirONQPaGzozorge
         aSryV9i/03RKiSJYV0NB3F7QHP/9Ywa1VxC7BK1BySswaDOxRlJ99PaVmZGjKuhrqokJ
         drQJigvIh5r6BKaluUX7b2wXBLETMFSgX1oi4I0InMRhCBCfHpt6ykheqb8FH1HckKPm
         A5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767206280; x=1767811080;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdMMIVnMpSWKZDVfjzl/8xYiev+Ss29iey9QZNOAYfs=;
        b=dwSTTBhTXZDRubrr3KX2KcFdpfzhxQFbhdeRh8EgU6QHU++ONmX211UK29faXNlUST
         G+HugNdfd4hSQelqCKN04Q446x25m1HRHOBpsBwEgWKZit73Db8DGi6CS/agoUBdp4wt
         I1+ogQrCKXAv+Ixma4z2Hjoe/qaa+LB64nSZ+Y24B11l+a+yUsfjY9BKWlxcosvdKw6x
         Z9QTfxo5Jk4vJFGqYRMjzWY4tkIf4BE6HFBKzxbNjRlVko+HYoqwUUPc2LPI2yG+I2Kv
         Ue5mX44vNgX+P91z2IVWmn6oBs5fClsUVBdRScXLNfXBlnDg5qkoNW70W3OsRRiVXWVf
         0SoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX89/x21sb0+UckHV92G+73w3UalmI5c6KQqCIXAdE/Yvg+sQuMUvAfO6oy4oECCamTxJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySHdvh+a24r3PIClx+8+N/0WiHv6Uhz7xFbJagTcrsQUOxFW9U
	uz8o5fOMxzCfkFZV0IexCzKJLygYc1d04zDHPShYK0LVV08X11nnV4y2
X-Gm-Gg: AY/fxX5Eca0534Oa4QmNBzQY5N4F7LiLcEIwAYaJJiF6BUAqBY7u48vr+3FR0PHuah5
	YOx3gyD1989PeKNI1i16l2WbelE6gsZmrUt1aYvmB4qavFWX6zmB8gbxs2Nz4geYB5jJqVQ/Mw1
	eJDj8NJkMS4Fzok/CQGy1WzNLrAGaR/b0dBZjAfvzEdUDAhO6J+EVaMEQy1fB6OnC6FPUSvtI6H
	WOBsFSFRehiH+W6NGJ1psLcgMfkCf2aIgHPwsNds87xTX/rqzuAb0mMR08O9v5aSQBLdYqKteb1
	z/vKQEuNtphErgFVzq8hupGz/i+jEZ74vFoN/97BuOl0lN8FeHIL0t8wmTMgknBEXekHRsh59iL
	2fzHh+LqiV+Dzj/mFqf/C78/cB0eBBxTgKuOKcj246LGpUzDRugFkcRwZY0hvDTjvl2S9jCL258
	B4LOgwde1O/LZgfIftvLM=
X-Google-Smtp-Source: AGHT+IGbxMIg8gcgaKAA8caLQqcGxLbzw8VWpH5fJ64K+7384PQ7lOg2XUxZjk5fJXjBLxRNZnchDA==
X-Received: by 2002:a17:902:d50b:b0:2a0:f47c:cfc with SMTP id d9443c01a7336-2a2f283685amr358506705ad.34.1767206279725;
        Wed, 31 Dec 2025 10:37:59 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c820b8sm328341035ad.23.2025.12.31.10.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 10:37:59 -0800 (PST)
Message-ID: <c1204513fe4da235d6b6b45eca9d0260a31e89ec.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/9] bpf: Make KF_TRUSTED_ARGS the default
 for all kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Wed, 31 Dec 2025 10:37:56 -0800
In-Reply-To: <20251231171118.1174007-2-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
	 <20251231171118.1174007-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 09:08 -0800, Puranjay Mohan wrote:
> Change the verifier to make trusted args the default requirement for
> all kfuncs by removing is_kfunc_trusted_args() assuming it be to always
> return true.
>
> This works because:
> 1. Context pointers (xdp_md, __sk_buff, etc.) are handled through their
>    own KF_ARG_PTR_TO_CTX case label and bypass the trusted check
> 2. Struct_ops callback arguments are already marked as PTR_TRUSTED during
>    initialization and pass is_trusted_reg()
> 3. KF_RCU kfuncs are handled separately via is_kfunc_rcu() checks at
>    call sites (always checked with || alongside is_kfunc_trusted_args)
>
> This simple change makes all kfuncs require trusted args by default
> while maintaining correct behavior for all existing special cases.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Nit: I found two more textual appearances for KF_TRUSTED_ARGS:

  File: fs/bpf_fs_kfuncs.c
  71:65: * used in place of bpf_d_path() whenever possible. It enforces KF_=
TRUSTED_ARGS
  379:47:/* bpf_[set|remove]_dentry_xattr.* hooks have KF_TRUSTED_ARGS and

  File: include/linux/bpf.h
  756:15:  * passed to KF_TRUSTED_ARGS kfuncs or BPF helper functions.

  File: kernel/bpf/verifier.c
  12622:39:        * enforce strict matching for plain KF_TRUSTED_ARGS kfun=
cs by default,

  File: tools/testing/selftests/bpf/progs/cpumask_failure.c
  113:21:  /* NULL passed to KF_TRUSTED_ARGS kfunc. */

>  Documentation/bpf/kfuncs.rst | 35 +++++++++++++++++------------------
>  kernel/bpf/verifier.c        | 14 +++-----------
>  2 files changed, 20 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index e38941370b90..22b5a970078c 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -241,25 +241,23 @@ both are orthogonal to each other.
>  The KF_RELEASE flag is used to indicate that the kfunc releases the poin=
ter
>  passed in to it. There can be only one referenced pointer that can be pa=
ssed
>  in. All copies of the pointer being released are invalidated as a result=
 of
> -invoking kfunc with this flag. KF_RELEASE kfuncs automatically receive t=
he
> -protection afforded by the KF_TRUSTED_ARGS flag described below.
> +invoking kfunc with this flag.
>
> -2.4.4 KF_TRUSTED_ARGS flag
> ---------------------------
> +2.4.4 KF_TRUSTED_ARGS (default behavior)
> +-----------------------------------------

Nit:
I think section should be renamed to 'kfunc parameters' and moved to a
separate section before '2.2 Annotating kfunc parameters'.
Sorry, should have commented about this yesterday.

[...]

