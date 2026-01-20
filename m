Return-Path: <bpf+bounces-79538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F58ED3BD56
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 940D23009285
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C5A257821;
	Tue, 20 Jan 2026 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g65HKPzY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15421607A4
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874325; cv=none; b=AFoMLzrYgWyqX/cKzVIRcj+0dxbgTfXFVrC3K5NYhH33r+WQ+ucB89LBZLn4fvxW0BymvKyQxNGN1q9RkYbKoU3hj61UvaSp49h9mx7CdCQ7JNqqkQygrPLYNnFS+Gz5qDuelCKhlkSbAjF4su3aEi7WrMD7XOVJt42gCVweU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874325; c=relaxed/simple;
	bh=h1bzrV3t+W8hh2TRR/gZqlbk4hfM8u7QilZdJ5qMIjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=feUhntY+f5JbNUs4T+IYvvUpsitvyyVNFEuOVSD5PN5afN8QxvD2CItF+pTKFjIlW6qlf8SSRuAwBg4bv0CRuk33mhQArlW8CJ2r6irSmqEGEUfZUnhByURMeMQYAiLEDv7Flt8hf0PJYyNZc58Px2bFajOfiDC8jxJorY2i66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g65HKPzY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-502acd495feso35783881cf.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874323; x=1769479123; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C5BHzdBy9bZIqFc6VCkjIoouQALwj1cU2ODrGGe4Wds=;
        b=g65HKPzYoU51m3fuxzKdYG8ztEvI0WH07NnXxT0yXluaEnzxegwCC3Qr7ARPC0ePgT
         4diHMT0A5U11fEGBVxjLTC164j2LA1GOAHw4W7ueOVCrfBPTzFq4eXQChTCQD7BYg3/0
         glS/VL0ioKyy9WznebplCQYe0A1kKXH0LneIzzx/dPhtJCH/S8DxkYIIpNkwTRl5v9wb
         OvhPy+jK0jTaZYFK9CaXy/BMPq183XzQqxVyxsqrvw5toF4cmVMNjkpmCVnxnluLQkow
         kfMQ2Qy/UbeVtSTtnULrTXRqh+QvCvC/qfcY/V+DR9O0IYm0mBOfvgEgKDH2p5bhjt1G
         9t+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874323; x=1769479123;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5BHzdBy9bZIqFc6VCkjIoouQALwj1cU2ODrGGe4Wds=;
        b=Y1qsBYUGjfclY4ho1tpdWYg+JHS7xItcU1JgRnJbra6LYEQA5QF5jlPkSYbn4OZNZj
         ZVSLfAo25PQdGpb73ww1M6YKtc1ukRQHkDWx7iLhrDkb1HoeDTCOWo7+LUvxREASEcuR
         zwPItAaugOlg3ZDUgz4nds2Ney8sRDpTbojbtjzfoxxwCWH50CTumEuhbHBGd12Vwc8m
         UNE4j60GHp8JswRFWT+cFACZdiS3th5KQ0AE9tkhx0SAi/7HOVchEhtUgWOQxso4J/YM
         Rx3Lem7D+oEQAQHqhsyxg/q8hDPtTGluo+ibORRgvYsNJuw/LWXhCx3sEm4EK38tX2Ex
         QmlA==
X-Forwarded-Encrypted: i=1; AJvYcCXR4qY8VnZ9tw4aqfsxZ/iuEYX6ShYhWj6BVxvxv/0W3UZivN9BxfEdS+HTqU7PxT4LaPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybm8gkP5C6hJq3SrQO3vwCkzBQLiaEeoYscUzQVYZxU1OIDHnc
	CrOCO/XCAFOCo+IceMmyokiQSDf4UAxRa+CpnPSi9a5Ojr6iUOdYUq7D
X-Gm-Gg: AY/fxX75AVnfM6B2L5OMwKHj5QdhRa0+omQ8bldHVVK5HP+eySMLvLsMIfcXXJLPPlF
	wzUFYU+9yQctZURaw5rFpyaIZFuJlHRbR9KM8n+E8Nky0Kgv1AkZQ0uNvKQ/H5LgM+sjXp72Upv
	Z9pAjQ8F6ysATwk9c8aSJxRIvl8ZadchH3BDs6bTrg3CFLKm3FXbOubNyM50IhlozPpuES7+35k
	3fnvKGB1yhVnV3lTBKzmnC0uKIfJwo9FNFl8E5aSruyL3D9Z2ujFchQhKTpYBQyi+sAHNCL1ATf
	xHB6WtCut38b/ZVQuLJmw4oOb2kJPgzIl0u+xfo//LeQKYfkxcnUBIHy0NEiw8yjZxT62Zu6qa8
	iPjQt5VtszPhWEBF/t8fpt9wYDFVRs6zaytSQ6BaL/0+uYO42iaqPIqaxHvpw4WQ8bSmw1fSk+X
	A5Ee/xWPQ+gnNH0Iu5TizFnWVLy2YiPD5D/X/fQMSS/TsjdHleFUc2cJINzsWjjmW1YQ==
X-Received: by 2002:a05:7300:6c89:b0:2ae:4f61:892e with SMTP id 5a478bee46e88-2b6b4eaddf6mr9036820eec.36.1768868006151;
        Mon, 19 Jan 2026 16:13:26 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm14832564eec.9.2026.01.19.16.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 16:13:25 -0800 (PST)
Message-ID: <c404446ab6d344338592dfa44f5a7e1b95492564.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/13] resolve_btfids: Introduce
 finalize_btf() step
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 16:13:23 -0800
In-Reply-To: <20260116201700.864797-5-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> Since recently [1][2] resolve_btfids executes final adjustments to the
> kernel/module BTF before it's embedded into the target binary.
>=20
> To keep the implementation simple, a clear and stable "pipeline" of
> how BTF data flows through resolve_btfids would be helpful. Some BTF
> modifications may change the ids of the types, so it is important to
> maintain correct order of operations with respect to .BTF_ids
> resolution too.
>=20
> This patch refactors the BTF handling to establish the following
> sequence:
>   - load target ELF sections
>   - load .BTF_ids symbols
>     - this will be a dependency of btf2btf transformations in
>       subsequent patches
>   - load BTF and its base as is
>   - (*) btf2btf transformations will happen here
>   - finalize_btf(), introduced in this patch
>     - does distill base and sort BTF
>   - resolve and patch .BTF_ids
>=20
> This approach helps to avoid fixups in .BTF_ids data in case the ids
> change at any point of BTF processing, because symbol resolution
> happens on the finalized, ready to dump, BTF data.
>=20
> This also gives flexibility in BTF transformations, because they will
> happen on BTF that is not distilled and/or sorted yet, allowing to
> freely add, remove and modify BTF types.
>=20
> [1] https://lore.kernel.org/bpf/20251219181321.1283664-1-ihor.solodrai@li=
nux.dev/
> [2] https://lore.kernel.org/bpf/20260109130003.3313716-1-dolinux.peng@gma=
il.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -1099,12 +1116,22 @@ int main(int argc, const char **argv)
>  	if (obj.efile.idlist_shndx =3D=3D -1 ||
>  	    obj.efile.symbols_shndx =3D=3D -1) {
>  		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols resol=
ution\n");
> -		goto dump_btf;
> +		resolve_btfids =3D false;
>  	}
> =20
> -	if (symbols_collect(&obj))
> +	if (resolve_btfids)
> +		if (symbols_collect(&obj))
> +			goto out;

Nit: check obj.efile.idlist_shndx and obj.efile.symbols_shndx inside symbol=
s_collect()?
     To avoid resolve_btfids flag and the `goto dump_btf;` below.

> +
> +	if (load_btf(&obj))
>  		goto out;
> =20
> +	if (finalize_btf(&obj))
> +		goto out;
> +
> +	if (!resolve_btfids)
> +		goto dump_btf;
> +
>  	if (symbols_resolve(&obj))
>  		goto out;
> =20

