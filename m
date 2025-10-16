Return-Path: <bpf+bounces-71140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28532BE5138
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C45D1A64D03
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B9323643E;
	Thu, 16 Oct 2025 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zld4JaDO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD22231836
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639874; cv=none; b=nxpTvSt3Cyr0aEdy3VQ634wDVLSR1FKOL3tbsZdYf/janPp18y7IHTQNqogNOuPZDX9Wsj42u4B9uEVyi7pTzwvoqxrlMLYqfA7y8P6Ck9ayseTAEXYMNonXzYlRI8BEYK7lAKIPC+gbPK2zOwBrQvSuytXQuvST3l0TEiB4vWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639874; c=relaxed/simple;
	bh=Ag7E2KJ1sKrd3hDxqTCdLxve6kj9sVsoE64rh2C090k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcmM/z3RZlo0hIYURN3UDqmvqpnmlBWoedaAR8v+OFl3fdFzylMdT/5Sr2rrzUfwPrF5UKsXA0dDw2ZoCtLYTDZS3IVWcvJva006DSZu/x67r2OcVsEXqKdVSXkyEJPWdArdprHYw30Kwh5RE942Gdu8z7BcS73gteIt1MEisaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zld4JaDO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so1109309a91.2
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639871; x=1761244671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5INPj80c0UhEqkKBfhyFW5QKr5h0Ushov5YGvZ0wZq0=;
        b=Zld4JaDOIsl6QYKXr70zahTQtPq+E86bBtKI9x9R8oBGkFnn5+QxmrpUSLLHK1lRfp
         smE5p6cW8n8BjHOniKfybR7aIsT532mMiJxcaJoIsv0QFqkcxKN1LmD5w+wvKB7sQkh1
         oUbeAHz9upX2XrDwnVirtc4HOYmxMg9h0SZCqWoh1uOg3UYbFol+9Oadt9K45ZI07rPD
         kO+oTeMUQ32Ctqd5HaymScGXzjEuVpyQVH9vjQy5YwTajIp+Dz3qEDakepM0DSEfGdo1
         lJbUfd3S8UxQo9FDoykWBAeztsY4H+PSOVBobdbZ9XPCjmWmKBUOBOlDRAuA3w1NOtZs
         kqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639871; x=1761244671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5INPj80c0UhEqkKBfhyFW5QKr5h0Ushov5YGvZ0wZq0=;
        b=JC9XDKkhIexnPH4QlGrzVpHuXVvOQhSrjI7YZzYf/jJ+cLL1uyT1Eaiv9oaFYhJLOh
         qf+YFO3cynCBmkvZWDhF856LTFNJ1Y9mvroB4DWjKu2tkGowJL43mFh5CNCfJA/5UBEk
         fNepfN8vpt8kGZ2D7ZojCYLuDRYNiZ1PygDz3c3kU+mwU2ShrdTrhy01Cs3L6dDIVLyD
         KP1WoHrOBjvhWg6TbKtDmnpm0hd0NluRwa+y+eyD9B4YC2sIs9qajlhijcFQKWfpYZaA
         v4LTHEG4Mk3JjDigLfbCE7m0b+va13BcQoVn1B21/y/WLCEX4qBjS2DM2ylUluJHqdSb
         DOJA==
X-Forwarded-Encrypted: i=1; AJvYcCXGSrxdplLga31qnvKcAFS1HW86PHZQ7F0w4AJxqHZyOsvISVldKCoJ4kbzWvVpdSfLzBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIVVFnG+DkLIjKZInEKMhuEzWVcis9NzCmDaqwsqObqzq12u6
	t1BFFGABY78gGPSWTiYYPU8/C/LZ6+bBV2DmrYEdfKaCRTMtgwn2WpBivU11zSjzSL2oEabhPc+
	/ik/3xyMWDPq90qOgr2a9/w2I8OlT0Do=
X-Gm-Gg: ASbGnctJ/igBToirkZf/1/VlGmwkmHONi7O/PqA+ta2S21NhrLgU5mM0xt97WOvU2LS
	XFkVfqzOFAIr0d1SLaGSIDvHieOySZDL8oMbE/y0BVuotN6MID5TrPoQWsHCryJGOBWg/xYeyUS
	/RuNQr3sjrRdgMxfzKxdCMnDLPsLztaqgFMzSsOaFBZlNG1PObgbw1gFRXz7p+7NbbCNL7hmG1f
	jpq8dnuMP5KujIP+hE0fMwH5ccVter488kj+kgR50jOQZ7cEkqbgtyC94cz1ryXEVKeyWljKxQS
X-Google-Smtp-Source: AGHT+IEy9yCQvMMzXBiBoqh7AfhwljuvXqu1T9Q+Qwuni95M8dvRTpPQ3O1DWsxOOyrbIw8QzvnMLqu9HABnP2pVCiA=
X-Received: by 2002:a17:90b:3fcc:b0:31e:d4e3:4002 with SMTP id
 98e67ed59e1d1-33bcf85ad9amr781068a91.2.1760639871170; Thu, 16 Oct 2025
 11:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com> <20251008173512.731801-14-alan.maguire@oracle.com>
In-Reply-To: <20251008173512.731801-14-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 11:37:36 -0700
X-Gm-Features: AS18NWD3JWIeaUB3pAZX1ePHv4BkmI045D4AzjYhQGG9QbAaTcXXh19XDfFe3Xg
Message-ID: <CAEf4BzYKgyxh_RH9gGbZE6gK6G9ObjbPFKL1+R8C-sRa5yXoaA@mail.gmail.com>
Subject: Re: [RFC bpf-next 13/15] libbpf: add API to load extra BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 10:36=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Add btf__load_btf_extra() function to load extra BTF relative to
> base passed in.  Base can be vmlinux or module BTF.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 8 ++++++++
>  tools/lib/bpf/btf.h      | 1 +
>  tools/lib/bpf/libbpf.map | 1 +
>  3 files changed, 10 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 62d80e8e81bf..028fbb0e03be 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -5783,6 +5783,14 @@ struct btf *btf__load_module_btf(const char *modul=
e_name, struct btf *vmlinux_bt
>         return btf__parse_split(path, vmlinux_btf);
>  }
>
> +struct btf *btf__load_btf_extra(const char *name, struct btf *base)
> +{
> +       char path[80];
> +
> +       snprintf(path, sizeof(path), "/sys/kernel/btf_extra/%s", name);
> +       return btf__parse_split(path, base);
> +}
> +

why do we need a dedicated libbpf API for loading split BTF?..


>  int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn vis=
it, void *ctx)
>  {
>         const struct btf_ext_info *seg;
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 082b010c0228..f8ec3a59fca0 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -138,6 +138,7 @@ LIBBPF_API struct btf *btf__parse_raw_split(const cha=
r *path, struct btf *base_b
>
>  LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
>  LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, str=
uct btf *vmlinux_btf);
> +LIBBPF_API struct btf *btf__load_btf_extra(const char *name, struct btf =
*base);
>
>  LIBBPF_API struct btf *btf__load_from_kernel_by_id(__u32 id);
>  LIBBPF_API struct btf *btf__load_from_kernel_by_id_split(__u32 id, struc=
t btf *base_btf);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 82a0d2ff1176..5f5cf9773205 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -456,4 +456,5 @@ LIBBPF_1.7.0 {
>                 btf__add_loc_proto_param;
>                 btf__add_locsec;
>                 btf__add_locsec_loc;
> +               btf__load_btf_extra;
>  } LIBBPF_1.6.0;
> --
> 2.39.3
>

