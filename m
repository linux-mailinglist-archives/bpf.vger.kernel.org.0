Return-Path: <bpf+bounces-60097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD20AD28E3
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6D51892E82
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A54223DC9;
	Mon,  9 Jun 2025 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUOkYfhO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3221B9F7;
	Mon,  9 Jun 2025 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505333; cv=none; b=fq1RJlRC5d5I5rMUOFOASB700fUjSCajX+InNi3HZi5tT+FA6b7bcRkCToslc0gTC3jKxBB26lDGEdyzG2jXx5tweF2LGVqPhUotLJBPTyPX2chloM2fU+ZNuV7K9FvrXGWuFWOsXy1G+iZ2Nrklq10ULh0glrxHawaS6NgL3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505333; c=relaxed/simple;
	bh=fEn8/0HkyrXwRON5f0fHHuZFdubbiPUf+RiP9sX5LK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdT+HxTg4dEHhuEvq41rRnRQBdMB3X6wQVTZYYRWHR/AnF9s083jx4hNDKnIrHaRuYwRyt7/CikB+G8CQJjqH48EJ1+2cPC7XviRvYt5rtgl1sU4kZe8uhaVRhfbi2U02NglmMWpgmJzJOHMIxNdQROebd+6tBfxiffGqML1y0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUOkYfhO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4f71831abso4491903f8f.3;
        Mon, 09 Jun 2025 14:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749505330; x=1750110130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCBloPaoNdHC/G5CG18Wcy2IdjGNUbVAE/fYYNOTkFc=;
        b=EUOkYfhODyebtg66UoRIl2NWSPs300GaSwPg2uZYpxfngOz8t1JAGGtpbYgJD8atZu
         37PSPO/nGJtD54Z0xiutjD8QDSSOjbfQA1yv0fp1tSTfDLwBxN2ISnId2n0+ik0TP9i6
         8QPDZi9BKa/yFM9/mXEHEqRd/UcGiI+qZ5ZI6ImBUFQsYqsDdVlykPwGtwNIUA0OoJn5
         uAdZhOcNGwKy4PIOr+/3xhfrBA/FVJeBhf8d9PlHkIxSg9aftjfKtwpL5Gx7pJ/eXdMK
         umaBlx7hdI7mBJgqCJ818lTZWtSvfid3ZGln/GzpOxfhO4LiVoLkfgOkjlHewFdxrYgS
         uMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749505330; x=1750110130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCBloPaoNdHC/G5CG18Wcy2IdjGNUbVAE/fYYNOTkFc=;
        b=waW1IAbapF7DWAYSnePJMi/ok9g4Q+2Jf2wSfsnOG8S4kKZJ+ow9Lk47B9bIluGIKK
         wCi3pKf2NlrqDS9LJ1I5rs/kqlQEQYz1nGkPw5SkqhCWRyW6xevlfZhIJWqNKkzBPRPm
         u8Sognx4w9qwLGlmjZbhhB/3Mvz2XhA7n8Gr788o232n12IBprFHzDvHyPMep+RD4x+R
         S2Q6m/xa9rrFOV/9p/rz6IV88citHrYNEnvX4jrr1svHjLTW7SEOMNNzUdB7RYqP8If7
         qSol//FzHh+UpZd1rLuICSXrRi1I2OhGiwiE9xfXb2pQUulPeJvCXmacQX8AhOarbJFL
         UavQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYwlYqCN7fHCDwfEKGTo8Ik/2MtfLlZB4FAo9o0adfYTTh9gzakI7nlk/Q9R92ttIslRyrS5Wff7hOW4f44oLkXW4Jv2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79ISoge1GiQdGhJrsprdy/QO/vxiZ8CqEqSrAoaAOyhoKhMSe
	9VY3vTMJQdHBfuaF8IZ0fY9pxpnWnhJPyyGt+jT0/DLAppvyG6JQm71zoEbnRDMt2zUXhg8E+YF
	au7fvEyWBkx4bhl+flnVrfOjHtfIHmVU=
X-Gm-Gg: ASbGncsxgjoZQbsPnU1xjrPIMXgQuBVg36fuz4hCD+Ab9PQDxE+CZFuXs0Ay5pWAqTw
	C78x75wvCoeQD+ETxznj6nSwa19L3g2dYEraJlk2qzPaNvF8cEbRASlnv0t5bKGY+wykDRBBUID
	iJBWxCg/bUpU1PXiuxoKKIo8KNVPA/TpRtMQLLS9KirwntXefSf/GR3OVospTKX8LELR72hfL8
X-Google-Smtp-Source: AGHT+IHJ7W1mSPonkcCgJ8Y9Ouao3XkJaGa7oogiMGUCPVQHDYE8TFsoVa2jGWMsfggIfL0S8F/ypwmBOTrhpzw1CFE=
X-Received: by 2002:a05:6000:2c11:b0:3a5:27ba:47d0 with SMTP id
 ffacd0b85a97d-3a531cb25demr12790275f8f.56.1749505330434; Mon, 09 Jun 2025
 14:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-10-kpsingh@kernel.org>
In-Reply-To: <20250606232914.317094-10-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Jun 2025 14:41:59 -0700
X-Gm-Features: AX0GCFupa3mdGz7A-31ns4i6fXFiEq_D54-edp6SfI1Dh9-JLAqTXLnj55HpVo4
Message-ID: <CAADnVQ+oe28FG_FNouBCK3bzOgMDy1QRU2Zru7cEWnKo7nxsxQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] libbpf: Update light skeleton for signing
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> * The metadata map is created with as an exclusive map (with an
> excl_prog_hash) This restricts map access exclusively to the signed
> loader program, preventing tampering by other processes.
>
> * The map is then frozen, making it read-only from userspace.
>
> * BPF_OBJ_GET_INFO_BY_ID instructs the kernel to compute the hash of the
>   metadata map (H') and store it in bpf_map->sha.
>
> * The loader is then loaded with the signature which is then verified by
>   the kernel.
>
> The sekeleton currently uses the session keyring
> (KEY_SPEC_SESSION_KEYRING) by default but this can
> be overridden by the user of the skeleton.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/lib/bpf/skel_internal.h | 57 +++++++++++++++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.=
h
> index 4d5fa079b5d6..25502925ff36 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -13,6 +13,7 @@
>  #include <unistd.h>
>  #include <sys/syscall.h>
>  #include <sys/mman.h>
> +#include <linux/keyctl.h>
>  #include <stdlib.h>
>  #include "bpf.h"
>  #endif
> @@ -64,6 +65,11 @@ struct bpf_load_and_run_opts {
>         __u32 data_sz;
>         __u32 insns_sz;
>         const char *errstr;
> +       void *signature;
> +       __u32 signature_sz;
> +       __u32 keyring_id;
> +       void * excl_prog_hash;
> +       __u32 excl_prog_hash_sz;
>  };
>
>  long kern_sys_bpf(__u32 cmd, void *attr, __u32 attr_size);
> @@ -218,16 +224,21 @@ static inline int skel_closenz(int fd)
>
>  static inline int skel_map_create(enum bpf_map_type map_type,
>                                   const char *map_name,
> +                                 const void *excl_prog_hash,
> +                               __u32 excl_prog_hash_sz,
>                                   __u32 key_size,
>                                   __u32 value_size,
>                                   __u32 max_entries)

A bit odd to insert new args in the middle. Add them to the end.

