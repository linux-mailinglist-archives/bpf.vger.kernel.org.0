Return-Path: <bpf+bounces-50079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6145FA2273F
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8D73A7078
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD04610B;
	Thu, 30 Jan 2025 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWvBd05n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E88F58
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197252; cv=none; b=rG90mPIj2Ryu1ptVNc1crq5tSnjqqWyZLeKhiPiXnWiwYj//uqFY7VeLVSlYUuj7zRTfH3a/5i8XYXhZg8MDh3eLkEgNJgPBT1Qx89eh49eDNc3pUVYmiywVhHMXKV1xLl5PzcMKCDsEzLmT9HM5+rwDUQvR/u4pQZ1D8VxTBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197252; c=relaxed/simple;
	bh=U4ygiHar5IxtichHcbCXQkxbtwp655w0TaUJ5iU2uwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rx/q6xl9BzdeyveCK2D7V06ySNnad2nX8dJ/W6a5kEDHomCCmUsAIpxkuFa2oJxMV3BH9FcoPXk4riY7GDEKhw8SL2t8Vr6O0aQg9S8SKNrKJLZqJG5WfWLzuow6KJZPk5LH3j8EX/FRIYk178hao1kFSbeATqgXBl6Bfi4OYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWvBd05n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21ddab8800bso2790015ad.3
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 16:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738197249; x=1738802049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlV2yGP77P8DlEioCL2NeWT9SqkjpPsGE+IahQwRX3k=;
        b=XWvBd05nRoyKGHQ//EbsfdSiRzSnFdu3bXggW36aiC04cWRP3jZM8GKgXWHIwP3B/d
         rpxxS3W/5noApQj9mJMjWQRU8CZXkm7IX6g1O57RZXuKtcyntqO9+YtpaN9RO8fdvXrU
         /9EtlIvQ7Gp9w5/TZ5NfMl0pWpsj9vSc8AneZxYNE83Dk5edlrpH9DV6u6OX/mJ7yFJ8
         s7Zc7oRa7rvsQQsjo7c0YoGcj5g00mgOwrRs/UTasbWJRm+GHr9flN4/79ofA8Y0cQrh
         wIodH8szfQGhKGhXzxB8GjVmS+BL88vBWhL4mlusf2mlxC37CRvLKhv/NlpMRgn9UnRO
         pcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738197249; x=1738802049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlV2yGP77P8DlEioCL2NeWT9SqkjpPsGE+IahQwRX3k=;
        b=P+Pdl76Ixc+P4WO+mvJwGi0FssJ9VuI6bBu5BFU2ue5MiWo5ScjjkRIQVLLt8zAMVj
         mWS+TcF/X0vNdgprEc+zMc0SiM1iMyuxUoHv5WauM2w8pS2DAUTebBQf2y1G4XJWtONb
         xbMiN8w39/WlKomqtiAYbCowioMarycqSNPWI2N1PWvAo3k1TCLLisOxgv1nzOShtMVE
         Vu5hMFiR2GvtstRK5CmijiF9F4A/yVFN8zQAkKdeq14f+GeeO6auEvbVxa67R1PRjkUB
         0e9A4opLr3NbZoQIvO7VfYW0zpoem8XT4jlEgsfjxv+W+6rB/6tCVoJ2GMQn6kocRcSA
         C5Ew==
X-Gm-Message-State: AOJu0Yx3R12JWvlfshSilG8pAnScaT5OfvNaYNCsIvMxWVzOW0fDlgtX
	CGiR98L5DQh0/HC8TFeAtETbOb8ilvkKz1sdmbwWEJDXwosRpJJG1WDrjT9N6mrg8LRxozNVtzf
	z+bP6bNj3kQ5crl9OP+qcmGR+Ioc=
X-Gm-Gg: ASbGncsJLiqoosVLtL3b8gkjodRQQTFkUw/sRKTGOl5VtMkFUn4hyCQIGRETcYw/Kkz
	m+r/BN67+gO+tKpTwamlMsO5kzKyVm0+tHxIzOkGI1q09gx6knkCJPV++JzDQjzVFmbTuqliwTu
	S/myCgTXnIiX//
X-Google-Smtp-Source: AGHT+IHIOoA22Oj6HHcOzPiSVqyNKAavOcdiB1guG/CeZqr9SKiwDOtY88bgxw2i+CsKTFdDEpEyGvmbI+OPNDD3RPw=
X-Received: by 2002:a05:6a21:68b:b0:1e0:d632:b9e0 with SMTP id
 adf61e73a8af0-1ed7a5f8eddmr9435957637.13.1738197249349; Wed, 29 Jan 2025
 16:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127233955.2275804-1-ihor.solodrai@linux.dev> <20250127233955.2275804-2-ihor.solodrai@linux.dev>
In-Reply-To: <20250127233955.2275804-2-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Jan 2025 16:33:54 -0800
X-Gm-Features: AWEUYZle4VTn-ULHto5RF6CUOjUGrfgkDblzpfpkJRCcyoBoB12KU9cvxryTLLQ
Message-ID: <CAEf4BzZb7jTSiYqUGze8eL1iZ32zp3C0shz_Q-9uqOM408ATvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] libbpf: introduce kflag for type_tags and
 decl_tags in BTF
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, 
	jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:40=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Add the following functions to libbpf API:
>   * btf__add_type_attr()
>   * btf__add_decl_attr()
>
> These functions allow to add to BTF the type tags and decl tags with
> info->kflag set to 1. The kflag indicates that the tag directly
> encodes an __attribute__ and not a normal tag.
>
> See Documentation/bpf/btf.rst changes in the subsequent patch for
> details on the semantics.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 86 +++++++++++++++++++++++++++++-----------
>  tools/lib/bpf/btf.h      |  3 ++
>  tools/lib/bpf/libbpf.map |  2 +
>  3 files changed, 68 insertions(+), 23 deletions(-)

[...]

LGTM, but still messed up whitespaces, see below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

pw-bot: cr

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 47ee8f6ac489..4392451d634b 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -227,6 +227,7 @@ LIBBPF_API int btf__add_volatile(struct btf *btf, int=
 ref_type_id);
>  LIBBPF_API int btf__add_const(struct btf *btf, int ref_type_id);
>  LIBBPF_API int btf__add_restrict(struct btf *btf, int ref_type_id);
>  LIBBPF_API int btf__add_type_tag(struct btf *btf, const char *value, int=
 ref_type_id);
> +LIBBPF_API int btf__add_type_attr(struct btf *btf, const char *value, in=
t ref_type_id);
>
>  /* func and func_proto construction APIs */
>  LIBBPF_API int btf__add_func(struct btf *btf, const char *name,
> @@ -243,6 +244,8 @@ LIBBPF_API int btf__add_datasec_var_info(struct btf *=
btf, int var_type_id,
>  /* tag construction API */
>  LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int=
 ref_type_id,
>                             int component_idx);
> +LIBBPF_API int btf__add_decl_attr(struct btf *btf, const char *value, in=
t ref_type_id,
> +                                 int component_idx);
>
>  struct btf_dedup_opts {
>         size_t sz;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index a8b2936a1646..8616e10b3c1b 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -436,4 +436,6 @@ LIBBPF_1.6.0 {
>                 bpf_linker__add_buf;
>                 bpf_linker__add_fd;
>                 bpf_linker__new_fd;
> +                btf__add_decl_attr;
> +                btf__add_type_attr;

spaces here

>  } LIBBPF_1.5.0;


> --
> 2.48.1
>

