Return-Path: <bpf+bounces-70850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F323BD6D6E
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 02:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6EB54F7784
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 00:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10C3BA45;
	Tue, 14 Oct 2025 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQIKtT7d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD41A26B
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400653; cv=none; b=rGcCqidye+uHar8/h0s3m/B/arHXhOauHMjB3Ar2sElt+3GdKdzWtdxBZmWs/0wxYimGJWcY6uwc0z6X3HfsBH4Dfa9H0WSsAHzfDUbdR2LjafPtvtt4r80sapmBLTXGOeyDCbM2S9zvcX3PZ4SAcUNlCt8dHIUIL9fht7HfsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400653; c=relaxed/simple;
	bh=rA2d9bVJjo4YuKi739QINkb7Ma3Yf6FaXYSxa6GjrGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bny3Yiq8qvUyJCmS4djujy7YrIrlQnGg+Ot4iqp+SGCqROegXrTOzB12XsVMi4VxpbHCCy4URmYkdcG/QD4WD25oVotT1Dl88/lDyvQwaPXeFXmR9P6gp0JVBMIcz+e1Xv5XZNGN+a5tTq7KD67kjMIY9/q6i1MZURvFlRo8t7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQIKtT7d; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-330631e534eso5118153a91.0
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 17:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760400651; x=1761005451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZOjQqYWspp/HWsFJ32kTkX58sFjrhu2i2c4WKU4pdE=;
        b=CQIKtT7dAa2MVvUNJy4uE67XZ0Yj5JtfR6cqgHrTqW8TJc2596FJk3hn20kQMH1b0k
         YdHWed3vwOs+xhro4aGj3usxHXo48drFMeSTKvcee31R2XE8g1ZrmQdH1hSyEQyq7XyI
         xR3BHQ/Cf34chBBsuq+2cnpL7IU3JL8AW+NuG7J+RmwStHuKh/tJcGlTbg0bnWn8W0VN
         vA6FFiRzCwJ5PPWYNllXfOucvhxytjIakkCHgbJ0b+Q8yDLWTmEv0qJdcahves+vHz9/
         oMW2jNp5F2+tBCwnSVTav17mo/xIcJKQcew+4R/F8i9cSyTds4usiVbiIedcS6FrtZRu
         cY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400651; x=1761005451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZOjQqYWspp/HWsFJ32kTkX58sFjrhu2i2c4WKU4pdE=;
        b=MftTQ9IJa/BZhl33e/yXepR2yX/IFK3g3yOrAI+IFXjQdrGpOMdfRuHwWPI1KRxvhy
         X1Di+bDNXvfdxaooQkON3vWcDdbTOIqhMhWBZGycusXd16yfncvFarJaq56ME25Ssaz8
         FePKZ8PWlyFpZD8GcDKkfp02PLZQy3dGXDJTFymeE2NeHlw8BgT0wzfo3hJoulM9QeSL
         2tBKwUjwcCFkFT0BhumLj3SdOxl5pKpNshXVcvvtrn+eX48Nm/l32jptciYK+SsRakMm
         nUxcJdT2QtsP4swYENZMxTSkkmZ4A9WHR5u46rFEoR5kcGKL1dj4WG+XhnV7aHt7j7bb
         snLw==
X-Gm-Message-State: AOJu0YxhU5ZjZj87q7acIwemOTrHR7Ua7hHQXTrcwd8fq+SDfwJ7kbgu
	3TjbCS5sVQsF3dVr7fXWisOdvCGP2itwaONo340Ledml0en2V4T4lBraU9HiybPKxFZxJ9ChDJP
	SuP/UEG2WCXO3Q8Z2XGWKEBiPERLxvL6zlQ==
X-Gm-Gg: ASbGncvgM3Rak3MOzd5lSwSq9lTYdy/6Ts51xLEva3Xo6WUQqV1ZdYRkwbYW2qwhL2x
	mzL8uUF+pdP03RF8Bzny3OXARGxDpT2Dsa+YTjOaRrz7rTRvGBVV6KPr/0DhBXz5S4anY/jWPY6
	vLNQtfhD89EUGJVXmyZrYIcoHuXB6hNmz6I4ViYC7ct2nfznu/hlcULHu9+kC3I+WMDVsMcG4Nz
	s95Au0xwk4IfUshdE2EIaBx8mdzAI7mu0Z59zld+Dd6iLgl17r+
X-Google-Smtp-Source: AGHT+IFMVtm4DQORD65x+mSEaF0Wbm8x1C3+IfKF/VZrQ5FJe/OLKdFv3jg5zNlNisJAuxH6PiLH94VLtZ7J02I+OKw=
X-Received: by 2002:a17:90b:38d0:b0:32b:c5a9:7be9 with SMTP id
 98e67ed59e1d1-33b51386061mr32102891a91.25.1760400651127; Mon, 13 Oct 2025
 17:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <20251010174953.2884682-4-ameryhung@gmail.com>
In-Reply-To: <20251010174953.2884682-4-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 17:10:34 -0700
X-Gm-Features: AS18NWCBjBmsvqqOfpIAnGt_qlRfnmOf_aw91t8tz4WH5QN3GO01-v7dUmombnY
Message-ID: <CAEf4BzaYuX5V65Ty=RXnQeZV_DegNrFTM-dtRQPHdv4i2k0s4A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 3/4] libbpf: Add bpf_struct_ops_associate_prog()
 API
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:50=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> Add low-level wrapper API for BPF_STRUCT_OPS_ASSOCIATE_PROG command in
> bpf() syscall.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/lib/bpf/bpf.c      | 18 ++++++++++++++++++
>  tools/lib/bpf/bpf.h      | 19 +++++++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 38 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 339b19797237..230fc2fa98f9 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1397,3 +1397,21 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream=
_id, void *buf, __u32 buf_len,
>         err =3D sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
>         return libbpf_err_errno(err);
>  }
> +
> +int bpf_struct_ops_associate_prog(int map_fd, int prog_fd,
> +                                 struct bpf_struct_ops_associate_prog_op=
ts *opts)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, struct_ops_a=
ssoc_prog);
> +       union bpf_attr attr;
> +       int err;
> +
> +       if (!OPTS_VALID(opts, bpf_struct_ops_associate_prog_opts))
> +               return libbpf_err(-EINVAL);
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.struct_ops_assoc_prog.map_fd =3D map_fd;
> +       attr.struct_ops_assoc_prog.prog_fd =3D prog_fd;
> +
> +       err =3D sys_bpf(BPF_STRUCT_OPS_ASSOCIATE_PROG, &attr, attr_sz);
> +       return libbpf_err_errno(err);
> +}
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index e983a3e40d61..99fe189ca7c6 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -733,6 +733,25 @@ struct bpf_prog_stream_read_opts {
>  LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *=
buf, __u32 buf_len,
>                                     struct bpf_prog_stream_read_opts *opt=
s);
>
> +struct bpf_struct_ops_associate_prog_opts {
> +       size_t sz;

there will be flags, justifying this struct :)


> +       size_t :0;
> +};
> +#define bpf_struct_ops_associate_prog_opts__last_field sz
> +/**
> + * @brief **bpf_struct_ops_associate_prog** associate a BPF program with=
 a
> + * struct_ops map.
> + *
> + * @param map_fd FD for the struct_ops map to be associated with a BPF p=
rogam
> + * @param prog_fd FD for the BPF program
> + * @param opts optional options, can be NULL
> + *
> + * @return 0 on success; negative error code, otherwise (errno is also s=
et to
> + * the error code)
> + */
> +LIBBPF_API int bpf_struct_ops_associate_prog(int map_fd, int prog_fd,
> +                                            struct bpf_struct_ops_associ=
ate_prog_opts *opts);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 8ed8749907d4..3a156a663210 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
>         global:
>                 bpf_map__set_exclusive_program;
>                 bpf_map__exclusive_program;
> +               bpf_struct_ops_associate_prog;
>  } LIBBPF_1.6.0;
> --
> 2.47.3
>

