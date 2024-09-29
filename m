Return-Path: <bpf+bounces-40503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D398964B
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 18:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5B2284C9A
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA6617D341;
	Sun, 29 Sep 2024 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZmb5rjd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF82F2F;
	Sun, 29 Sep 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727627569; cv=none; b=BGxCNJHku9OqquuVHl4KLYmGXW98NrurF3NBNmaIOJSvy+yIgkmKfO8aKuVKtrCpVsUD6hr1uSnDGTV5UQS2sAD/4PGBzVnrLxtbJEsE86Qr0nNb4a3tLH52ehXjWpnKcSGofErZ3cF23ivpXO2BrbbnPOpjloCv0LCAcOqcQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727627569; c=relaxed/simple;
	bh=x2tWXhhfoYEwR7wyOGb4wPQwzoNw09d1+OIlfWwnRKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHmKLQfO+gj00oVcLh8G9uNdgRaw2SIbUc/9SxldECnwvxQ5cUcd1Ry/o/OfRwM3bBq/UshPE/H0HsHpoBJKxUC3rRqBjj8MEAcZZprKv0arNdtATjWR+q9uEEK0yhDQ0c8WhS6A7C8/fsh6rVnkawc+x1l8vWP1lCbN8wjKM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZmb5rjd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cc846fbc4so2559036f8f.2;
        Sun, 29 Sep 2024 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727627566; x=1728232366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dxHMAzVOWTbjEg0BO/ZeghpvvXEvPvLVh0DM6tLxH0=;
        b=EZmb5rjd5Np/g4JME9R2cgDKsQIvDKrg/oLbV/PoTFDPPMuUBZL7AQLl+ovHs2lIVA
         QhrIfuD2Zn4gVVekBhs6bBPeqZzyEFvQ5ugH4NNP27HAFqwa8LJGuj9i8GQY7JThA0+W
         TZphJpmQ826yCJsqSE4DvKL7HBphIfk/fubwjaClGbNLacqOvGiUuzLZy5HJDls5Bswv
         1C4I2zP0FL0Y3pBU2cGPOvxbXOAtQFDtaOge+TaRCQa1XOxLimfgb9c3SgxVdPCGjtSI
         JJrohlN0QuZLLFk6PuxkyEg9hYl1nkhgfp5Q+t5maIlLsXlpEJOyYYlGZfWKZxTsynG7
         xuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727627566; x=1728232366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dxHMAzVOWTbjEg0BO/ZeghpvvXEvPvLVh0DM6tLxH0=;
        b=tbzMVBIVpkrFppxgRojjNuiP37sEMadDgoQrVAmXdOGF3gDkLjZlIMNCmxuaXuUjQD
         J2uZUsZwpvkhUCxDOYgihz8ADon9C8KT1LzGIyNk2PdyDy8ZDXfDByZS1OSb5Kb76AQo
         am+kwI5hZ9qjrPYLWbF05PMvY6EM8ysnxGrQaC/pLl+i89VOaqCCdLruAOo4fshgJbR/
         uRUc9NZNUJrM/F+cQvjHFrafcLW9XyUswqSDTSG8WlXsKIjLHH7Cm1UuGQv18gvCd0Ba
         HhfT2XGifARlJzU7h4iwPM21SDOT00MvXUg6UhLINqI5NsHl8cN88Kj+iP8EHsd0Rn7p
         SmDg==
X-Forwarded-Encrypted: i=1; AJvYcCVp9aVfJo+LgcSVCorGqwAWGNuYKL+leEDkzRof7V4pDdPsG+3K1SB5bcEpuNq4R4edr4UanUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pGCAs2Ux/YT4aAm/MBRlCKuQx8VXdUCQuiHr6p5ugD5nAsAh
	bfuZrlhczs5MLSV7qbSIbZwsYWOfzg1mQw1iwCAESRb+HpcZJq8RmnkvseQYIt86A5PW0/jW5y6
	UAlfWCkWQp3am3ZwE73T1WllX5xGrUtGp
X-Google-Smtp-Source: AGHT+IGLGL1i3us/pjUJQAa3cYhma8+dwH1YtTQm5K6RlM6dnNx+ZMCRchLbHC9NbrEbsLHIHLtwpzEU6ulcN3zOpSA=
X-Received: by 2002:a5d:4e0e:0:b0:368:3731:1613 with SMTP id
 ffacd0b85a97d-37cd5a9eaddmr5597797f8f.13.1727627566307; Sun, 29 Sep 2024
 09:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe> <20240929-libbpf-dup-extern-funcs-v2-1-0cc81de3f79f@hack3r.moe>
In-Reply-To: <20240929-libbpf-dup-extern-funcs-v2-1-0cc81de3f79f@hack3r.moe>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 09:32:34 -0700
Message-ID: <CAADnVQLdmmvJRyf+br=CtJaDw6PowqKGTXb3z-q7LpbYiYFpHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: do not resolve size on duplicate FUNCs
To: i@hack3r.moe
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 2:31=E2=80=AFAM Eric Long via B4 Relay
<devnull+i.hack3r.moe@kernel.org> wrote:
>
> From: Eric Long <i@hack3r.moe>
>
> FUNCs do not have sizes, thus currently btf__resolve_size will fail
> with -EINVAL. Add conditions so that we only update size when the BTF
> object is not function or function prototype.
>
> Signed-off-by: Eric Long <i@hack3r.moe>
> ---
>  tools/lib/bpf/linker.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 81dbbdd79a7c65a4b048b85e1dba99cb5f7cb56b..cffb388fa40ef054c2661b836=
3120f8a4d3c3784 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -2452,17 +2452,20 @@ static int linker_append_btf(struct bpf_linker *l=
inker, struct src_obj *obj)
>                                 __s64 sz;
>
>                                 dst_var =3D &dst_sec->sec_vars[glob_sym->=
var_idx];
> -                               /* Because underlying BTF type might have
> -                                * changed, so might its size have change=
d, so
> -                                * re-calculate and update it in sec_var.
> -                                */
> -                               sz =3D btf__resolve_size(linker->btf, glo=
b_sym->underlying_btf_id);
> -                               if (sz < 0) {
> -                                       pr_warn("global '%s': failed to r=
esolve size of underlying type: %d\n",
> -                                               name, (int)sz);
> -                                       return -EINVAL;
> +                               t =3D btf__type_by_id(linker->btf, glob_s=
ym->underlying_btf_id);
> +                               if (btf_kind(t) !=3D BTF_KIND_FUNC && btf=
_kind(t) !=3D BTF_KIND_FUNC_PROTO) {
> +                                       /* Because underlying BTF type mi=
ght have
> +                                        * changed, so might its size hav=
e changed, so
> +                                        * re-calculate and update it in =
sec_var.
> +                                        */
> +                                       sz =3D btf__resolve_size(linker->=
btf, glob_sym->underlying_btf_id);
> +                                       if (sz < 0) {
> +                                               pr_warn("global '%s': fai=
led to resolve size of underlying type: %d\n",
> +                                                       name, (int)sz);
> +                                               return -EINVAL;
> +                                       }
> +                                       dst_var->size =3D sz;

Looks like a hack to me.

In the test you're using:
void *bpf_cast_to_kern_ctx(void *obj) __ksym;

but __weak is missing.
Is that the reason you're hitting this issue?

