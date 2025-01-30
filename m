Return-Path: <bpf+bounces-50081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D23A22741
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B98E3A7105
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1918831;
	Thu, 30 Jan 2025 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek5kk3vQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7B6FBF
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197263; cv=none; b=sHlaVrNw6smZ1X85BAw1KxNR8ecB95e3o+wryZmd+XoRIRfE2Yz+6kH/BUAzcaqe/BqtIRiN8rwtFuxXz/IKxqeeTSk+kHGrKE/FXm2CcRMIB1PJtYySmIPXz/WRCgKu91KavUfywUY4/vEddQpH7kb4/TFhyH82JvCY4vBujzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197263; c=relaxed/simple;
	bh=4M/JgFkwEgjLhu4VHPfL3Kq507jK7aoMFy5/YulilSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuqVNdPwNcu0IWVSCHCHCldXSphv/ADdsriKQ7hC1K76AvcYLIZBvgKj51TBo4s/4g18wjIfNKEDrCnSCYoAASH6cI3cgGF+1jdjBBDHSE9Ge0KKNzo2aiOsEkaC+eDWXZm536LRgh2pbLIQicUw+4hwd+eWZbPwPc6YvhCubV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek5kk3vQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21634338cfdso4855055ad.2
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 16:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738197261; x=1738802061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9u9v8ZRPxfIJGPB3kDLCwFAWSgTmAjU6cM3jFA9OpQ=;
        b=Ek5kk3vQixFyeL/RrGhOO96Sgaw3ZAqmB404SWr8fF8I08Zoq5frwzchRpf809uVwx
         wanNcVg4vzecdrhUqEC9YxiW7tNqrey+rgHQ8CRPZ81hNbB17wK/7nOVAudRYW/x2e6u
         cynVfSxASHevX+XBSmFJSsa9n5YgPajCT66ChlVlUcn6lYuZlM7nrflegc+MU0fQxoT4
         FvUepXoRbhMaep+/3/+0T84Q2qV8X59qAngUbeQQaJHapvdMW+J+3shWjGKsmiVoTAPB
         3BAGLsV5rTDTeJlw/1wP3/GGAtpHnzYtyUgLCGyA+fiGEVFTKbTuqmtE7oHMLhwQBn07
         SLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738197261; x=1738802061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9u9v8ZRPxfIJGPB3kDLCwFAWSgTmAjU6cM3jFA9OpQ=;
        b=nNtueoDSB/2Es9UnsAlEszi47UFTgLwf3b+IbFf5rnKBEdAOMKmpFabjCnvlRIz7Ly
         pwl9V8XPJ7ezLN+HdNzeYDTlHMYtFA5eZ8pRsfWp0i3+QnMJHOL0wVa3TsycPfuZdjeW
         9T2ao0UYxMJreR2/iDDBe66KVE4LXgv7ny80BuhKB1HZKlOmKyjIoZxEfoDMQRXYPWob
         LtsqN6lR5uBr1iSZk9JKXTQYKtbIKL7BOj6IfP18epRLPUpFm5SKNvonE4d2aQmrRWQb
         F4Vnvg4M37AgrlPGX74wyh2U0bNqMOVOwP1l6VhAwR1CW5tP7RudQmIZj2bqw/xdryaL
         n1Dw==
X-Gm-Message-State: AOJu0Yy8p52m5QNwLcVxR24b5ZxZREiCeBQZ1N9rtnWBAxfx8fcXE5UW
	+R0ARb8fOvVlXQ/+wlaTWeLK+6RcELEbc90XK187WDihwPTHozprlm9ROXUCgIK3YlOjNcW7M0Q
	3ncMUheHR6C6ttRzSgPdV0taab1c=
X-Gm-Gg: ASbGncupVwQJf8ilypriYsxIKNxXScn+TVM8NSzq3JUMVS2e0jXIA8Qlj0EymG2orgc
	34c3sExOOmKhd7EYHlUqRFkIbl2Fwr7m5YJgi4gF1E13XepM7flxI8UuV2ijuiPSdy6Qq9YMA8d
	obaNuIahLKreIs
X-Google-Smtp-Source: AGHT+IGSue0riQoaICegnt4/5ggYFs+IT1AC7eYMIFuB3OPdsbuJ/ijIBsXng04M8KedGiHiCnMj3RBB6oPlC3mHTi0=
X-Received: by 2002:a05:6a00:1946:b0:72a:aa0f:c86e with SMTP id
 d2e1a72fcca58-72fd0bda6c1mr7399343b3a.4.1738197260701; Wed, 29 Jan 2025
 16:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127233955.2275804-1-ihor.solodrai@linux.dev> <20250127233955.2275804-4-ihor.solodrai@linux.dev>
In-Reply-To: <20250127233955.2275804-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Jan 2025 16:34:04 -0800
X-Gm-Features: AWEUYZlcfl-8bHLQX5vw8V21QaQehHqfPw4a8ARtGHdYjs65xmDLHDpy3gX7L80
Message-ID: <CAEf4BzZVbRvYsxsn_2R-FLZc530W-kywYsZ+3n9-c+j-HQvaxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] libbpf: check the kflag of type tags in btf_dump
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, 
	jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:40=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> If the kflag is set for a BTF type tag, then the tag represents an
> arbitrary __attribute__. Change btf_dump accordingly.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf_dump.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index a3fc6908f6c9..460c3e57fadb 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1494,7 +1494,10 @@ static void btf_dump_emit_type_chain(struct btf_du=
mp *d,
>                 case BTF_KIND_TYPE_TAG:
>                         btf_dump_emit_mods(d, decls);
>                         name =3D btf_name_of(d, t->name_off);
> -                       btf_dump_printf(d, " __attribute__((btf_type_tag(=
\"%s\")))", name);
> +                       if (btf_kflag(t))
> +                               btf_dump_printf(d, " __attribute__((%s))"=
, name);
> +                       else
> +                               btf_dump_printf(d, " __attribute__((btf_t=
ype_tag(\"%s\")))", name);
>                         break;
>                 case BTF_KIND_ARRAY: {
>                         const struct btf_array *a =3D btf_array(t);
> --
> 2.48.1
>

