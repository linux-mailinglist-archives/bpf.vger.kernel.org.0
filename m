Return-Path: <bpf+bounces-40699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F098C451
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429501C218D2
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31331CBE89;
	Tue,  1 Oct 2024 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn4zt/iv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09C1C9EBB;
	Tue,  1 Oct 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803105; cv=none; b=KizDcbm+gg1FzNJdW64hQKe1s5q+fNdGuDpVQl3/O6MD1H17S5gM1sgQFGZdgfsxjmFoju4yamoXeOOE+R9LcsKUoXLAzV7uD4dPURsqGt3cu2X7ETpiIyx3MkEufW85sJjK3F9nKR02TKfIacGpsqHlvdiUXiGaGYUfNiANl/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803105; c=relaxed/simple;
	bh=u392b6zwWHRNtTo4tUu43ZG66h4E/eMrB7URovJKTPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4gQUKqEtyDtajQqYY6tOfveRr21lxh5esjdrdlzOby6dUQ5iys4kA1/mEiC02WxxYmXOAJxZ0dafyiTDX1c9rWNesmGLIrcFTfrklwum6SRFVUZd7XD15jLVyWCpPPq4KgwIDjg/AhtbMVxyxVKreieDhvK1Mj9l7NO2IDcMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn4zt/iv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e09fe0a878so3911738a91.1;
        Tue, 01 Oct 2024 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727803103; x=1728407903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dbI2cc12fnrzl8uqqbNkvjuJQk9qSVh9Gz3lanrPxE=;
        b=Zn4zt/ivi0EHb2fcL4z/Yoxellh7u7Xq7ob4M/bj6IhIYfxv+aqxhaDNZI4e3UBNAY
         WyUrhSISncW01oYCkydUDrQ6h5WUj4LF/hat50p2gIUk9a2lmQ7i9Qbbk+gNpOPx8oWW
         b3hjyK7WzmJJgoThmpwLhznowe1BIsuJ8JX0X68z7U90gCT2tNxk6wnuf0VmCZCSgqvC
         ciFdv8FHSe9/iE8NCISxr9lmXLYIfkWst8tbPNG5YYqDNDKo7iR6/a4ZYIck22WxaG+O
         IMSI7gUHye6uAUos54dKnuLxYlMuQYYGwjTGdxVuZu0dn9o9XKM9ZN5RVjZV6tQcRFUf
         9BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803103; x=1728407903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dbI2cc12fnrzl8uqqbNkvjuJQk9qSVh9Gz3lanrPxE=;
        b=hmTyksSPubSsmS4GThgn99Mtjtf5IhVN1CSkvlCsx/zx9WyqyQQPoNHJG85lpRvX9F
         onbNxm6VK1HfQi5LUhGoqNu7BxxGJbja+E8dDAfFo+A9pFRqV0cXqkxHdnYxlH4UV+s5
         F9BDAUoYZZ8xIEoB5lxOnvn6z9vo9yJMCIgjw9m1sIAVNI6QbuPcR3vzaFuSlJGV8CQc
         xjCXs/fmHAmpxFGn/iGJW3PQRZQjdU//IBnIOHhTkIC5tkMEnWvTCcxCnM/ULzAHq+HN
         f/eVrps+Rfx/ciTgSAW/FgpIbTdJ7ANLsiRehwwczQLEKWU+4mqJzjyXTCEdSlYz53WX
         kgxw==
X-Forwarded-Encrypted: i=1; AJvYcCV2vA7gz4uO4fGHQyymv/qr43tSCoqjNH/8ZXNFLGNoeXuBwGpNWfl647gTu0o3QD4FcZdyGJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISD3yoH3yv/JkBAG4GeI1XfqaEM7VYtpNOc2N9P3lXOOsCx+j
	Pz+Px6EZE+kV2V33Fuxm0XfrGmSVYktF9WFgJV1WaqrZamzUCa4aS3BKValxI001P75jhxym5Ai
	CGnv43zi4K9kfdC/hgLSdPN5UoXw=
X-Google-Smtp-Source: AGHT+IF+VAuSYzy8pqewUk/dpJO4SB6eg3JPBfuRwtNZwUiYRNVWz2Wa5ZW2febdtDelhMgjpj4MYbwR/fyNfyRHICw=
X-Received: by 2002:a17:90b:1d8d:b0:2e0:a4ce:108c with SMTP id
 98e67ed59e1d1-2e1849d2734mr369172a91.40.1727803103357; Tue, 01 Oct 2024
 10:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-libbpf-dup-extern-funcs-v3-0-42f7774efbf3@hack3r.moe> <20241001-libbpf-dup-extern-funcs-v3-1-42f7774efbf3@hack3r.moe>
In-Reply-To: <20241001-libbpf-dup-extern-funcs-v3-1-42f7774efbf3@hack3r.moe>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 10:18:11 -0700
Message-ID: <CAEf4BzYmS8i-O6fV=no0h6ej-5mC3_87CAUFny_Dbad4HL7PgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] libbpf: do not resolve size on duplicate FUNCs
To: i@hack3r.moe
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 8:55=E2=80=AFPM Eric Long via B4 Relay
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
>  tools/lib/bpf/linker.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 81dbbdd79a7c65a4b048b85e1dba99cb5f7cb56b..ff249ba0ab067526e82d91481=
d21ec88a2732b4f 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -2451,6 +2451,10 @@ static int linker_append_btf(struct bpf_linker *li=
nker, struct src_obj *obj)
>                         if (glob_sym && glob_sym->var_idx >=3D 0) {
>                                 __s64 sz;
>
> +                               /* FUNCs don't have size, nothing to upda=
te */
> +                               if (btf_is_func(t) || btf_is_func_proto(t=
))

no, it should be *just* btf_is_func(), because that's what extern ksym
is producing. FUNC then points to FUNC_PROTO. So this is still a
sloppy check.

pw-bot: cr

> +                                       continue;
> +
>                                 dst_var =3D &dst_sec->sec_vars[glob_sym->=
var_idx];
>                                 /* Because underlying BTF type might have
>                                  * changed, so might its size have change=
d, so
>
> --
> 2.46.2
>
>

