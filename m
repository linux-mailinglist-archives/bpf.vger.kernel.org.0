Return-Path: <bpf+bounces-27991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E339C8B4263
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 00:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214491C212A0
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EAD39AC9;
	Fri, 26 Apr 2024 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avswNaTz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAE52C6B7
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172233; cv=none; b=eivZY2NBqxuc7Uhu8AWbeD0/me3OiKXxS5X4cXnf8HkneTOlMtET85Ocy3XB6GjXKGiBmm1V+a8xUn6Y25QesuItH8fp0tK2vVxNgGeX0t/HrqPfyZoWHwOVMtSNbHjFuRtfMLSqtkYOmZWiEN0DZGZ4XF9yTffNPcDrieANM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172233; c=relaxed/simple;
	bh=UxQBoiN0jo1hRStsxwkMGacIdpkvkcsmOO0EyXZ6gfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGzQdpyeQgRGPzxAazaYDkqozIwMG+2KAUVUYYwNT5WHD8SdBTOTTpW/FnPaq+4ilpeOjw2by79OmrfOuNnqcnHaCDtA917DKcCQ1Chwh88x+ro3PkT1njGN/9mnzVGmy4FVFGnMZegjns465sXn+8duRXpHnv7NI3mqQQUoiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avswNaTz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a4b457769eso2284517a91.2
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714172231; x=1714777031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pp9yRCAJPfDIr7OBYdwX6Ivrxz1bQ32WOQmCetR7bIo=;
        b=avswNaTzmcz0ufryNZA3PqZG7ja6zS63Ftph/zf4WUQlkyYLwJnZ4LD6k2cVLi3CTq
         6lZzy+mLPXsAB3PUBGoWrNRppMn6sb+nuc9wlZZ04cFJ87+GCamNuxP8QleDFRMnC4GZ
         TG3CSBovWW1FuEx3t7aI/RBUAwfhuU7ouEvxLiNpPBjOfZYzN4QWleRv8+a3BIK//THv
         G+sMYxsWZmrrjvyNYFowINHVS3MW1fCuzkubbLUmVljs8RkzaUI9uGAEMuUWo7+zZbac
         BXRWvRjEesbltLLi/grnp87DE9l5FeP18lI1ZzvC0o0j3D2327rZZPoDnMq46YHw8h95
         YYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714172231; x=1714777031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pp9yRCAJPfDIr7OBYdwX6Ivrxz1bQ32WOQmCetR7bIo=;
        b=Y1/naz3DmULLW1yQLhJ62O5tMX/WAi1Q9uz7aDJPc4CYpWaQ6XSaosnje21N9GO49L
         Bpx+G4ZHOpKlgMdIVw1Jt66k8Y3iDRC/WV1uYbqLRXNjRmLChs+r5VIpToQbELhE9NpR
         Opo76yrm006ppjS8WeNAsmjFDcEwGdkB16+5Qxrig+BxKbnJhJJZeMIjXxIb9oW2AQjw
         3p1kznEp9nUk8VkI5Jj13WpLyCHEBkog64sxM7NKRPizEb69BpmOaxtKCgwN6d0MPf4P
         5qFyjKA34Hs+4tJ7R6O1/7vKwjfZCo8y4cmSuJ4HksiYxWW35Q1eylTyjS8RKrBzxKul
         8qbg==
X-Forwarded-Encrypted: i=1; AJvYcCW/JjGoTSYXED6Cgiz9CLoGXfaoqVAT7ApGYN3cPshowT6YTZneEoCXz+H/Lsf8DKiQv1AO5hoHsM+uATMnC64yI+Rk
X-Gm-Message-State: AOJu0YxFf2P7w2n7LT4evx48y3slW1mbqS7s2EcMIi4fCyl2pG6oY8V5
	wEYvkBfgO8fmFkWOhrKJf9H8Y5Fi/nKU4+QhgcssMa8IS1/R/238kiDaRcjpKjIrgs8BeGI+FPs
	kC5xFrEXcGYuFK5A/jWL6zUCOvI0=
X-Google-Smtp-Source: AGHT+IHZ2/Jc4u7/+sBtJpEEnnskWfypxWGAdo2DLT7cqrshVsTzq3g6dzDD2bC8WTM7FrAYBmJBPANpWRRKQEaXPFs=
X-Received: by 2002:a17:90a:c585:b0:2a6:9c5f:828e with SMTP id
 l5-20020a17090ac58500b002a69c5f828emr4038519pjt.22.1714172231380; Fri, 26 Apr
 2024 15:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com> <20240424154806.3417662-2-alan.maguire@oracle.com>
In-Reply-To: <20240424154806.3417662-2-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 15:56:57 -0700
Message-ID: <CAEf4BzYnx4J0tn0WPxUiSRZaaj803_qK3+sGVe3rJNndGawOhw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/13] libbpf: add support to btf__add_fwd()
 for ENUM64
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:48=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Forward declaration of BTF_KIND_ENUM64 is added by supporting BTF_FWD_ENU=
M64
> as an enumerated value for btf_fwd_kind; an ENUM64 forward is an 8-byte
> signed enum64 with no values.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 7 ++++++-
>  tools/lib/bpf/btf.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d0840ef599a..44afae098369 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2418,7 +2418,7 @@ int btf__add_enum64_value(struct btf *btf, const ch=
ar *name, __u64 value)
>   * Append new BTF_KIND_FWD type with:
>   *   - *name*, non-empty/non-NULL name;
>   *   - *fwd_kind*, kind of forward declaration, one of BTF_FWD_STRUCT,
> - *     BTF_FWD_UNION, or BTF_FWD_ENUM;
> + *     BTF_FWD_UNION, BTF_FWD_ENUM or BTF_FWD_ENUM64;
>   * Returns:
>   *   - >0, type ID of newly added BTF type;
>   *   - <0, on error.
> @@ -2446,6 +2446,11 @@ int btf__add_fwd(struct btf *btf, const char *name=
, enum btf_fwd_kind fwd_kind)
>                  * values; we also assume a standard 4-byte size for it
>                  */
>                 return btf__add_enum(btf, name, sizeof(int));
> +       case BTF_FWD_ENUM64:
> +               /* enum64 forward is similarly just an enum64 with no enu=
m
> +                * values; assume 8 byte size, signed.
> +                */
> +               return btf__add_enum64(btf, name, sizeof(__u64), true);
>         default:
>                 return libbpf_err(-EINVAL);
>         }
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 8e6880d91c84..47d3e00b25c7 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -194,6 +194,7 @@ enum btf_fwd_kind {
>         BTF_FWD_STRUCT =3D 0,
>         BTF_FWD_UNION =3D 1,
>         BTF_FWD_ENUM =3D 2,
> +       BTF_FWD_ENUM64 =3D 3,

one can argue that having BTF_FWD_ENUM64 isn't necessary if we allow
to use BTF_KIND_ENUM and BTF_KIND_ENUM64 interchangeably (when
resolving such fwd declarations). "Original" enum can record size 8,
so you can have enum64 forwarding with just BTF_KIND_ENUM vlen=3D0
size=3D8? Would that be sufficient?


>  };
>
>  LIBBPF_API int btf__add_fwd(struct btf *btf, const char *name, enum btf_=
fwd_kind fwd_kind);
> --
> 2.31.1
>

