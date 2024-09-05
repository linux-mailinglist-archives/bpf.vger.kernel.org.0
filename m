Return-Path: <bpf+bounces-39057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC58E96E357
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 21:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 297A5B25E55
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DEF18FC83;
	Thu,  5 Sep 2024 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKtb+i2/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AE188017
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565181; cv=none; b=G1Ewh1OKPpphQpIZQmTFSA5z1o01FV5lxnJJ05UTlgrh4oORHf0t+73ytvbhZkaPJtCKNwacD+zJRaePo/jxWBN3E7/mVi0snyAlj+0vt0FeorqZeflznD3P4ZTU18RBrVyEkAWQmm2LLlhtLOeNu9Wzn99QrQfwt3M/BSyYmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565181; c=relaxed/simple;
	bh=57xIqJi8EWeXuGEA7oaJtcfp7ZGOZ+8Y3KmlTwmdbiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgbG7zdMIxPkSx1d35H5ug2a7UpuUGOufgqx828lzq8GnTAOS93N8EeYVqHCa8d6qDSj1LDdcNz9Rgb0Lh16q8RWzFp2txe5CzkXKCmiuI8POcR+eZ+YjaOYs/mJrOG3kqlIoELQLYiPUBPeGV840aQa7jPFY3GKXpiPqiFlhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKtb+i2/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8682bb5e79so171899966b.2
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725565178; x=1726169978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MP8GWUJnUtpBCmxA/HKBV7aSIGH1cTqMuimgjbkOys8=;
        b=CKtb+i2/UCVMzTjkmLT3uJx7ilFkLiijvg5wg7lmrgeD6tW3o/mHh19Iv8TFR69U7r
         cN32DRZGbpZM5IP4nBYdznU75VRglXW4qMfOXV+2h7aN7Bt3MI+kUX6AnPaOoqIh3zA/
         csJvcty6f8ne7SSYjnt4Q6xlvSI3ejnc0EBkQD3taCuT8WyZEJRa7I9HjatBEFpvAayM
         Rkeb7ML3PEq2ypkLwUzNI2mk3ebfHlQhq5avubhGL9Q91in2wybneJOmNsc3Q5XRFpeB
         fh/d80gOIbfsGUQfQRvmtgST8LAAlcOp0k2E2zup37hJgt1EU3rxoufOxGncKqciiT6X
         oUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565178; x=1726169978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MP8GWUJnUtpBCmxA/HKBV7aSIGH1cTqMuimgjbkOys8=;
        b=iAmsy8wbD8iMAfCx69/R6tC0VAAwcLiiuu5Fc+GdOsfB73O+hCqGvhZFw60FC+nF+m
         307fBmFmr/tyf/pWv1bFR5nyMxZm2TdRJyNlSqxffWcgoYFP+JE/OOrooY9e0bxb2B2n
         kHsZu4g8OUUj4mdGZvHIyjX4grXaHAq+wFlt3yQhUwrN5JOIgWd5xujoEjagivuYuWiK
         3MGyHkPCUT8Z3pGIDR4z2slQv4yz2d2rcsePMvTxGOn/OxgAbDBuQ9OBAeqBqTtX555K
         dXbPC3qDJS9OX8EnFnBdR/U9GTg1OoJh687+ntvCW6mvlBY6RRyNfk/CQXu/ySorP7be
         ZwKw==
X-Gm-Message-State: AOJu0Yx7St9AXyyXbPMkQLdgC87bCUllcvWUCy0b+KzqSB1yEgaBL8fs
	h5o+i1VUUE363dgFQr8DGJAtkRK9sausV97YGYZ/PnY6JDyG9XrtqhXFRCafQKmxvQ46lWpfnAS
	jsimuppQdkXQ/f35Cuh/oVaxWLTo=
X-Google-Smtp-Source: AGHT+IG8jdVTxgzhE2737RhbW6r6Una6lJh87WhvOiqeD7Gkj2qBGQnXy0NpNk80f9F7ojhUIIESz3pXAquU+HFpQXw=
X-Received: by 2002:a17:907:3207:b0:a8a:7f08:97a6 with SMTP id
 a640c23a62f3a-a8a88601b8bmr9210466b.24.1725565177517; Thu, 05 Sep 2024
 12:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905134813.874-1-daniel@iogearbox.net>
In-Reply-To: <20240905134813.874-1-daniel@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Sep 2024 12:39:26 -0700
Message-ID: <CAADnVQJbqoXHMsC3_67xWXpvX8CjzOoRTTA7h_kZgZNOqNVW5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Fix helper writes to read-only maps
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf <bpf@vger.kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 6:48=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 3956be5d6440..d2c8945e8297 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -539,7 +539,9 @@ const struct bpf_func_proto bpf_strtol_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg2_type      =3D ARG_CONST_SIZE,
>         .arg3_type      =3D ARG_ANYTHING,
> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> +       .arg4_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM |
> +                         MEM_UNINIT | MEM_ALIGNED,
> +       .arg4_size      =3D sizeof(long),
>  };
>
>  BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
> @@ -567,7 +569,9 @@ const struct bpf_func_proto bpf_strtoul_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg2_type      =3D ARG_CONST_SIZE,
>         .arg3_type      =3D ARG_ANYTHING,
> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> +       .arg4_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM |
> +                         MEM_UNINIT | MEM_ALIGNED,
> +       .arg4_size      =3D sizeof(unsigned long),

This is not correct.
ARG_PTR_TO_LONG is bpf-side "long", not kernel side "long".

> -static int int_ptr_type_to_size(enum bpf_arg_type type)
> -{
> -       if (type =3D=3D ARG_PTR_TO_INT)
> -               return sizeof(u32);
> -       else if (type =3D=3D ARG_PTR_TO_LONG)
> -               return sizeof(u64);

as seen here.

BPF_CALL_4(bpf_strto[u]l, ... long *, res)
are buggy.
but they call __bpf_strtoll which takes 'long long' correctly.

The fix for BPF_CALL_4(bpf_strto[u]l and uapi/bpf.h is orthogonal,
but this patch shouldn't make the verifier see it as sizeof(long).

pw-bot: cr

