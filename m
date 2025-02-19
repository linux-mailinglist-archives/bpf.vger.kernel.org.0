Return-Path: <bpf+bounces-51885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC78A3AE85
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4F23A9B72
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B9F188938;
	Wed, 19 Feb 2025 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHVEaEJX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA62B9AA
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926900; cv=none; b=rykNESrqLTQeAr6HfToR+CFdSyMhASjtqiu7gIsGS8Bwe6yzVadA6cTuE+Xh5tl9c7EFCPtsEq5Xw504Dj2hlFiyI4Zfax+kfVJfI9+4HJ98TCYuTiDQKMyhQGZ4K8c5GwupsH7KU+l4dX8ikt0KbHBxriPtxMLOLowvW1/rIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926900; c=relaxed/simple;
	bh=Kh8N9VSNTE63jwnQ9bF6OtgXnCKpUriHaDJhg2kBdks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kuffUcVQZVu4m1TpFX6imMFCWi1y2DKiI5du9+81z/p9Z/fbl5zwsrGlbKs4hZNBgjB06Xr3SZ7vDQXkd6ISm29PO1hV1YA+hwv8fGZQkw5GhHln9Kij60FXutOSbjL3g9VkvL9jvSS+JL4W2okFMM6yprqQm3v26R9afJZZDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHVEaEJX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2211cd4463cso58137665ad.2
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 17:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739926898; x=1740531698; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0xzLTL/wHBr59JTIgX9tc5f+7ZtM2IBf3+QiMlP7KBw=;
        b=nHVEaEJX2q+YSHnaDWlGAiIA5UbNzKyHKNoDVaJgrs3/wLk7Pw31MUW1w4b87TADLn
         3Gnu5BVQykHgrW9yOt49/LI16u9lAZ2XGVjWsKc3NEy/PUufAa0XGyY1BZkJ6jrHqgH+
         rYNJccTgNne5CvxuAaqsDJ1Br6fUPQjDse4QyqJve5DMjaBZLbNlH29rm9K6C/yvx3vY
         jX7Wr2fJqVRMbDS5nFsfj/afGy+zuSqhVTDw2mCuUy5zfqHMlkanKnvY0fDQ5sj2XiKv
         ex8zakB3uO1CdQwyG8UY4/UbG6zADImdzWj+9DaOzD7tVwes6RM5dIzz2y4rG+UFBZ/v
         OSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739926898; x=1740531698;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xzLTL/wHBr59JTIgX9tc5f+7ZtM2IBf3+QiMlP7KBw=;
        b=KItReNh+gZBU9j1Vvh2B4i4PwrmUHi5Gmo58BKcXEViExnnA42ap5E0L4OEZnaGoDF
         sxojH3OWEyEqgh6xV1PSqz4EM2BJxkbciigEpaxAe8Q5qS0z7wwDnG00CPyP8Uy3D/Tl
         quyEpR+/CLSjR+/vQUDJfxiI90c4DFU8d/4CuxvGs+/VV2ce9XOuMgRh5HFd0sIIBZpm
         5f19omhrftiHF3VEQw3a+J5tFSE33h5CgXVfpPDiJ+lAZ7qGNHIPu5BBtDrjjTEL+OEr
         7OLP74JV6hQLUveJeZlO5zHE55UBR6XXUC03yrUuglRlbiIlHoFoe1rBKukD6ysHRoEm
         asrw==
X-Forwarded-Encrypted: i=1; AJvYcCUyTElkpJTEo59gpWuSp9h7E9+v2e1CDWqeBcRz7I+QXqgOo1U3iMgQjZXKptVCl7u+plY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRqgY6gmbAAu05w9daIFvZcsobZ5zcFzzSpZgdTxrbrZuFn0s
	P+7fOHnC9sCySLnNv1gTqkhGSk/8uKNKEBoUAsWtav8bwhlMCjgS
X-Gm-Gg: ASbGncu4EHRCmS9FQcAGJ4e78OR9jWNMFzrknB6cj0uj2GeUDONEAsYppVNFAiC1EiU
	ipsX5QX0WZTDmTJWcxxMRUjo6zi8EGbT8t9gQFB5ZxXxiiuanQlECW6otQvidSGukINdyKbrP+8
	GRblnHMuZmCM9EKkZwxkc7W6sYLkzZyeWltQYDS9VkSbhSFXpU0d1khdU4AWJfAskU72jKNw8DK
	fJI4AH5nbFo/4W0pMtJUx091h1A/UtCnucXroZm6tf48c3zw5XrcndqAofgFJ3m5UFpSWlRKKzs
	sZMFxt3i8pQJ
X-Google-Smtp-Source: AGHT+IEVXxeBNaOLHvd+/jWTzquW8UX8/99dPVK7Stc7wJ9C4xljZjMANO5SMGE3LNhAvVFGvrX49A==
X-Received: by 2002:a17:902:f706:b0:220:c94f:eb28 with SMTP id d9443c01a7336-2210406ae23mr227356525ad.27.1739926897678;
        Tue, 18 Feb 2025 17:01:37 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fcb844c60asm115506a91.0.2025.02.18.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 17:01:37 -0800 (PST)
Message-ID: <26e5634a565e9b1e31813e12df9db670b590e93b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf/helpers: introduce bpf_dynptr_copy
 kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 18 Feb 2025 17:01:32 -0800
In-Reply-To: <20250218190027.135888-3-mykyta.yatsenko5@gmail.com>
References: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
	 <20250218190027.135888-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 19:00 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Introducing bpf_dynptr_copy kfunc allowing copying data from one dynptr t=
o
> another. This functionality is useful in scenarios such as capturing XDP
> data to a ring buffer.
> The implementation consists of 4 branches:
>   * A fast branch for contiguous buffer capacity in both source and
> destination dynptrs
>   * 3 branches utilizing __bpf_dynptr_read and __bpf_dynptr_write to copy
> data to/from non-contiguous buffer
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/helpers.c  | 37 +++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c |  3 +++
>  2 files changed, 40 insertions(+)
>=20
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2833558c3009..ac5fbdfc504d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2770,6 +2770,42 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_=
dynptr *p,
>  	return 0;
>  }

Nit: it would be nice to have a docstring here, as for other dynptr functio=
ns.

> +__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
> +				struct bpf_dynptr *src_ptr, u32 src_off, u32 size)

[...]

> @@ -3174,6 +3210,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> +BTF_ID_FLAGS(func, bpf_dynptr_copy)
>  #ifdef CONFIG_NET
>  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>  #endif
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e7bc74171c99..3c567bfcc582 100644

Nit: There is no need to add bpf_dynptr_copy to special kfuncs list.
     This list is maintained to get BTF ids of several kfuncs w/o lookup,
     like so: 'special_kfunc_list[KF_bpf_dynptr_slice]'.
     Which is useful when writing custom semantic rules for such functions.
     There are no special rules for bpf_dynptr_copy, hence entry in the
     special_kfunc_list is not needed.

> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11781,6 +11781,7 @@ enum special_kfunc_type {
>  	KF_bpf_dynptr_slice,
>  	KF_bpf_dynptr_slice_rdwr,
>  	KF_bpf_dynptr_clone,
> +	KF_bpf_dynptr_copy,
>  	KF_bpf_percpu_obj_new_impl,
>  	KF_bpf_percpu_obj_drop_impl,
>  	KF_bpf_throw,
> @@ -11819,6 +11820,7 @@ BTF_ID(func, bpf_dynptr_from_xdp)
>  BTF_ID(func, bpf_dynptr_slice)
>  BTF_ID(func, bpf_dynptr_slice_rdwr)
>  BTF_ID(func, bpf_dynptr_clone)
> +BTF_ID(func, bpf_dynptr_copy)
>  BTF_ID(func, bpf_percpu_obj_new_impl)
>  BTF_ID(func, bpf_percpu_obj_drop_impl)
>  BTF_ID(func, bpf_throw)
> @@ -11857,6 +11859,7 @@ BTF_ID_UNUSED
>  BTF_ID(func, bpf_dynptr_slice)
>  BTF_ID(func, bpf_dynptr_slice_rdwr)
>  BTF_ID(func, bpf_dynptr_clone)
> +BTF_ID(func, bpf_dynptr_copy)
>  BTF_ID(func, bpf_percpu_obj_new_impl)
>  BTF_ID(func, bpf_percpu_obj_drop_impl)
>  BTF_ID(func, bpf_throw)



