Return-Path: <bpf+bounces-77068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 667E8CCE064
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69DC7301AD09
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6792032D;
	Fri, 19 Dec 2025 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdn+tpwd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1AE523A
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766102749; cv=none; b=m//oqlA+noyepNe+LzpCgx2sCvXG03BTusqHmtKIO6sV42ynxmGQv632jDMDEaEtMPBujmJ0YzI9wY67NbqRncbs8iXj35M+tPxRCLY/VshUHYZoYbyA65z14jWPaNS/CAZ/xkrX8lP2zhcbymSSjVZuDHypSWbevd+BxQscRfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766102749; c=relaxed/simple;
	bh=7e1vZyGQMuTT5uv1lpI8xln9/7+ij9IarZjOk/ONZZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUSiSJmUgO78ld6x6ZWLEFeH8H97rNUXZPUoIHbv/e76M6sDYOAVoEcXDH4spUVB3CjnEgo2iZlFlkGlvpn0pLbL5Til2kDFiFPoshZuu756bCKvaWzu/ju/L7mWMb1lratgJg0AMKYUA3KKRzrJ2ETsVCdDiuox1JSL3lzJQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdn+tpwd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so982763b3a.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 16:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766102748; x=1766707548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0H+kZG4aYLbMeqvwBudJh+nQGi57/VsogdCfKqaKsM=;
        b=Zdn+tpwdiyFGbapm6BhVV2OBbjnil4+tgYhhmxC85SrO1mxmu1u0/Cw3F3EbjPLVqW
         JdtteetSD8KdXod5HPC/Cq0D6313hhzyT0qU+J0+Jpig+sb3M6LcsNO+bt8gXMX7FqLz
         0LVp5iio26yc3JxvuD4ILOk0ZpNefsGcOV9V7FHgjDZr6093ekpEv3iYv0z5uw5ZtEHv
         ssRpO/g51TBUbpkXbgYXDIUDmf8pSZRYUA4ztPAno8xdLQovFI+M+VDoumVSwA6VL47R
         jZjdDpb2XhrPxLwqcPh2NN6ow5Y6ES9HpQH1yrgPLwR1ORNDaCkk3piss6zJ/ZR/lwh4
         BpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766102748; x=1766707548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0H+kZG4aYLbMeqvwBudJh+nQGi57/VsogdCfKqaKsM=;
        b=hNnjHtNY2pOA0PpoaJcV3bxuVGmnrABzSMm30d9ciAvPtqHkWuv+3g6u1xESYrqevG
         c7bpRzGQ1lByjQ+rDooUHGyNwroZP6LJJU9rVFqmktAn07fwp25TuklY7d6RogLwTzo8
         IkPSjlZO74dVP7GoFFaofdBJTOmOwxqSObEFz3Sy3ihUJGUxFCoHwv5C3I4TZYf9RF45
         BQepUxP8oVU7+GkciW2m6xI0PnRK5J/lcocIH8RfHlBvLynfjpFFosYMXEPtM6lI1/oW
         ZnaeoySyKwQyRLXkgKsheGDiMXRv0kTGjlGRkR0FDGXd1xg/83QIs0ng6OqyMBjWIqyE
         8Pzw==
X-Forwarded-Encrypted: i=1; AJvYcCUb1kfHlova2dOweqjOMZSuJzZdn/F0GACaRibNvNdMmC01nW7trmoysTWUt46bnorP34o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIWJKhLsFnzTC8YtXlzNjWZ3Zngrh0npE2BEuxmhRujc/ukIw
	cAn6M79yuVP25q7wES2rGJUvaanpeNKRcO6P7JXKAjrOKRIGpbdBRWaqr8eD5SQ4ThgV3I4oQdg
	X9jRMrX/8VcVWKqeM9BcJ+iCCsQd7UC4=
X-Gm-Gg: AY/fxX69Rtyt2CPjogWXMbAr89TVhfxAVaeQ6EQ4auSU+ajj6nmpI1884bPElG83ymJ
	7DJeg0uV/K5vL44l444SZr+3I8DmyDdSTWpaBrOZAuhl+gTHTK6tUi3d+Yq+llF8pWCO/inBIH5
	1dYmdGIPeOccuZ/w8F8MQuirdE5ro1AUSMTsVzg7MBoTp32G6+teh9SxCszPxTpoQybwKxBsMtv
	a3DYeJI/0cJd7CCs9iSg5J1nwbGFOZLIECnKIyDVB1JUkr7+5kG3MX61SRlmLr6vivvxDv9fisb
	isEQ4tCDpM0=
X-Google-Smtp-Source: AGHT+IFj5p7qyGof3WGEwD/NhG1sWoB14HNhDV8AKFt3WVtgydSFApVALGd3gAZz7tjclAg2gTC1p3FTBlH5CnmQzMY=
X-Received: by 2002:a05:6a20:7f99:b0:366:14b2:31c with SMTP id
 adf61e73a8af0-376aa6eae1amr1014655637.79.1766102747755; Thu, 18 Dec 2025
 16:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com> <20251218113051.455293-12-dolinux.peng@gmail.com>
In-Reply-To: <20251218113051.455293-12-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 16:05:34 -0800
X-Gm-Features: AQt7F2oLFbkSrrPhPzIsJdWTcGmBWCdmel0ORtiTPjEDWLoChiHtK6EgBdS1880
Message-ID: <CAEf4BzZGz1k4ma4hYL-nR_e5QQxuzM3Y+VxZNWe_YupeQMj0-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 11/13] libbpf: Add btf_is_sorted and
 btf_sorted_start_id helpers to refactor the code
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
> Introduce two new helper functions to clarify the code and no
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
>  tools/lib/bpf/btf.c             | 14 ++++++++++++--
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>

It just adds more functions to jump to and check what it's doing. I
don't think this adds much value, just drop this patch


> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b5b0898d033d..571b72bd90b5 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -626,6 +626,16 @@ const struct btf *btf__base_btf(const struct btf *bt=
f)
>         return btf->base_btf;
>  }
>
> +int btf_sorted_start_id(const struct btf *btf)
> +{
> +       return btf->sorted_start_id;
> +}
> +
> +bool btf_is_sorted(const struct btf *btf)
> +{
> +       return btf->sorted_start_id > 0;
> +}
> +
>  /* internal helper returning non-const pointer to a type */
>  struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id)
>  {
> @@ -976,11 +986,11 @@ static __s32 btf_find_by_name_kind(const struct btf=
 *btf, int start_id,
>         if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=3D=
 0)
>                 return 0;
>
> -       if (btf->sorted_start_id > 0 && type_name[0]) {
> +       if (btf_is_sorted(btf) && type_name[0]) {
>                 __s32 end_id =3D btf__type_cnt(btf) - 1;
>
>                 /* skip anonymous types */
> -               start_id =3D max(start_id, btf->sorted_start_id);
> +               start_id =3D max(start_id, btf_sorted_start_id(btf));
>                 idx =3D btf_find_by_name_bsearch(btf, type_name, start_id=
, end_id);
>                 if (unlikely(idx < 0))
>                         return libbpf_err(-ENOENT);
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index fc59b21b51b5..95e6848396b4 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -250,6 +250,8 @@ const struct btf_type *skip_mods_and_typedefs(const s=
truct btf *btf, __u32 id, _
>  const struct btf_header *btf_header(const struct btf *btf);
>  void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
>  int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id=
_map);
> +int btf_sorted_start_id(const struct btf *btf);
> +bool btf_is_sorted(const struct btf *btf);
>
>  static inline enum btf_func_linkage btf_func_linkage(const struct btf_ty=
pe *t)
>  {
> --
> 2.34.1
>

