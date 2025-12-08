Return-Path: <bpf+bounces-76269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B10CAC461
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 08:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30A133091CF0
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 07:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7B3328622;
	Mon,  8 Dec 2025 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ16nYiC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD291DD9AD
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175807; cv=none; b=PEm7ZfFW/UP9YSl0634AFb2uMPhTS4HiEWXCTyL6o5nhZwMLJQ8OkTsw04oPzjpi8BYTmn4MtWNWQmvrZQ/xK53Pi9hetfYD6F4urHIVXgMN0/SKG32f4W/CfS5wfQmhn5c46qNC8uvkz8senHC3tZcmnmCu6BSF7NTKPtIDaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175807; c=relaxed/simple;
	bh=7nI0kj+r/m+DZxMViQiOAqeBo2Bk+I1qpmQ0vFircWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umwMS9miFVsJgfa8ziJaTo4OCNxepI5Ab2XV2hhUIeF+ZNuR+IVJWOBJKVDLhp9IehfF6r77nGACuZAJSGv+vOIC+bMqbTTcGPaPoxJYSD1u2WMPBxHT2TMB7F45Cy7gLzs0qEQkkp1eDaj8oXatMPQpc85Kj7ENUXSyBBtNgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJ16nYiC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so7013072a12.2
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175802; x=1765780602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmWZ2m8YfJ9h1sEZs8NBBK2ZBwbEmpam3RIoj5kTq4Q=;
        b=iJ16nYiCEE4RufT6Ts5WhqQbA23x34bA1NwEDAg9mGkMnDndlUi+Ytdh+IqCQR2CT6
         eaOfnn40ckWxqmr4JaVUlh8sBHsvV7IjM/i/hzUbfLHvroUl7CoHEcjDl46BmoBaAGTh
         BO+ghL3pUA4cDeKQO4ZzplEQBPPwSmMiQJJoLM/ccYO047YkEkuTyQFxQpKimzgCKIMq
         4wIw4+wpr8dGBebXApJgqYPDpdRYZHKLEGFDU+OuL0OOmz69rawrN3kBy5qpfE9IYp0o
         W+2KwxCc2T2tCStpWG3F40PR4hqi9yjU/uWixVoo+wNqVMRUglHcp2yd5bPqd9sB6Jpv
         fRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175802; x=1765780602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cmWZ2m8YfJ9h1sEZs8NBBK2ZBwbEmpam3RIoj5kTq4Q=;
        b=O8EIklGNid8glmUCj2diSkGm/D2xsJZXAfrhwdHV/5ncEOlz1yUDcJB3uZVgxFtE6q
         MfJy4iXrl/EVQwXHQKl0+Szcf97rLi5eVMBFvgjD2hBGYkGEWxdhxg6nU665gugE9eNw
         YskmLUkquvwkJPfbJb/+ImcqX+laR1MA8oD0b248+XBeQNqQIn6OatuzF2FBheTYLxYi
         AiWi3t2LPqpUj/oJHebWqnMkXfBAVK/F484atsPikcaLv4WNKeeLI781ryRAwes6PoJu
         jCf2JxirgdX8p0Con8ryx40R55mG06X2pz7wtopU50/6EZXqyrvKNg2CpM97aiBgQOxC
         UX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSftG+E24Et7BDJKfXfGBGduqj3Z9eYEMBDIkl60SP/Qhtgu323yOJScDi2DhH0ndEUKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtxB5wb9HATTG2tOKQX6oBdCpZwIrrmu+sss/ZuK2Cz2BdCc/b
	po+gc9glETLmEwO4xnVN1gU934lZiN/wzcZ1L61F3hKo9eoHxAjUech0kb0fgq+vD/zAdC5xa/W
	zsZxIRFthTopV/fLmHIPvf9drP6G1PKw=
X-Gm-Gg: ASbGncvgmcmMpAINrlu8PAALIv/UKSqspVnzZbExhdTfQVP0YZPgFVv+uqcdxCpR9u/
	7EZB2OY4KBjJwtO8o5mQZosh72h88RYptXMwDSXSixb83ncIKikRKMbb7wSDm7YmbGLARnPmqtX
	TRulpLLVfOkF06yIkTxXxavZ16m51WM5IHjzFkjVntC4GFOMNYA7fVlATQIR+E1lE65KoZFHhpQ
	m0m+r8KhFmdnhywXkpfU9lcjvzeWvuw6HWUFzEl68+URE7bOkQrjpI5tuqIsVuCTMZgVmvp
X-Google-Smtp-Source: AGHT+IETaDQhImp6PhoEDbUPoBpOwvBgNHjb/jjufN+LnTjZ/gwFVgbHOmQ+amV6W1xya98KEMbOFKwjG8A9BXTkHFM=
X-Received: by 2002:a17:907:3fa3:b0:b77:2269:8df0 with SMTP id
 a640c23a62f3a-b7a2433111cmr711716466b.28.1765175801435; Sun, 07 Dec 2025
 22:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com> <20251208062353.1702672-9-dolinux.peng@gmail.com>
In-Reply-To: <20251208062353.1702672-9-dolinux.peng@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 8 Dec 2025 14:36:29 +0800
X-Gm-Features: AQt7F2o7nvWdqAK-sglvpfFmHdNsd1m62q7FbNJp6EmfuAxg51XABopAqzhKmxc
Message-ID: <CAErzpmsmwS+TUwxDX12R8BbU4=rf=EjVZLXYwbOTjJx_3dOrew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 08/10] bpf: Skip anonymous types in type
 lookup for performance
To: ast@kernel.org, andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 2:24=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Currently, vmlinux and kernel module BTFs are unconditionally
> sorted during the build phase, with named types placed at the
> end. Thus, anonymous types should be skipped when starting the
> search. In my vmlinux BTF, the number of anonymous types is
> 61,747, which means the loop count can be reduced by 61,747.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  include/linux/btf.h   |  1 +
>  kernel/bpf/btf.c      | 15 ++++++++++-----
>  kernel/bpf/verifier.c |  7 +------
>  3 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index f06976ffb63f..2d28f2b22ae5 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -220,6 +220,7 @@ bool btf_is_module(const struct btf *btf);
>  bool btf_is_vmlinux(const struct btf *btf);
>  struct module *btf_try_get_module(const struct btf *btf);
>  u32 btf_nr_types(const struct btf *btf);
> +u32 btf_sorted_start_id(const struct btf *btf);
>  struct btf *btf_base_btf(const struct btf *btf);
>  bool btf_type_is_i32(const struct btf_type *t);
>  bool btf_type_is_i64(const struct btf_type *t);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 925cb524f3a8..5f4f51b0acf4 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -550,6 +550,11 @@ u32 btf_nr_types(const struct btf *btf)
>         return total;
>  }
>
> +u32 btf_sorted_start_id(const struct btf *btf)
> +{
> +       return btf->sorted_start_id ?: (btf->start_id ?: 1);
> +}
> +
>  /*
>   * Assuming that types are sorted by name in ascending order.
>   */
> @@ -3540,9 +3545,9 @@ const char *btf_find_decl_tag_value(const struct bt=
f *btf, const struct btf_type
>  {
>         const char *value =3D NULL;
>         const struct btf_type *t;
> -       int len, id;
> +       int len, id =3D btf->sorted_start_id > 0 ? btf->sorted_start_id -=
 1 : 0;
>
> -       id =3D btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, 0);
> +       id =3D btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, id);

Sorry, we should pass the sorted_start_id of the base BTF.

>         if (id < 0)
>                 return ERR_PTR(id);
>
> @@ -7859,7 +7864,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
>          */
>         for (i =3D 0; i < nargs; i++) {
>                 u32 tags =3D 0;
> -               int id =3D 0;
> +               int id =3D btf->sorted_start_id > 0 ? btf->sorted_start_i=
d - 1 : 0;

Ditto.

>
>                 /* 'arg:<tag>' decl_tag takes precedence over derivation =
of
>                  * register type from BTF type itself
> @@ -9340,7 +9345,7 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 l=
ocal_type_id)
>         }
>
>         /* Attempt to find target candidates in vmlinux BTF first */
> -       cands =3D bpf_core_add_cands(cands, main_btf, 1);
> +       cands =3D bpf_core_add_cands(cands, main_btf, main_btf->sorted_st=
art_id);

Invoke btf_sorted_start_id.

>         if (IS_ERR(cands))
>                 return ERR_CAST(cands);
>
> @@ -9372,7 +9377,7 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 l=
ocal_type_id)
>                  */
>                 btf_get(mod_btf);
>                 spin_unlock_bh(&btf_idr_lock);
> -               cands =3D bpf_core_add_cands(cands, mod_btf, btf_nr_types=
(main_btf));
> +               cands =3D bpf_core_add_cands(cands, mod_btf, mod_btf->sor=
ted_start_id);
>                 btf_put(mod_btf);
>                 if (IS_ERR(cands))
>                         return ERR_CAST(cands);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f0ca69f888fa..2ae87075db6a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20655,12 +20655,7 @@ static int find_btf_percpu_datasec(struct btf *b=
tf)
>          * types to look at only module's own BTF types.
>          */
>         n =3D btf_nr_types(btf);
> -       if (btf_is_module(btf))
> -               i =3D btf_nr_types(btf_vmlinux);
> -       else
> -               i =3D 1;
> -
> -       for(; i < n; i++) {
> +       for (i =3D btf_sorted_start_id(btf); i < n; i++) {
>                 t =3D btf_type_by_id(btf, i);
>                 if (BTF_INFO_KIND(t->info) !=3D BTF_KIND_DATASEC)
>                         continue;
> --
> 2.34.1
>

