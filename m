Return-Path: <bpf+bounces-39162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221B996FCFB
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4B81C22510
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E6156872;
	Fri,  6 Sep 2024 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmRbYZUT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49D158210
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656595; cv=none; b=ZF7qYaCZv+EoE5fgu/TJi+Aa0q8x7Z1dUthK30nBAhJGzU+UMULlvYFxWItjpOKLpVZIP66V41KCfM1mIW/ew4cyTJ5nQL3L5LNPE14gLmUtFLgZKlcHeIeuefwkmoZOKymUivtlLyHQ9AlIpwp2S89Pr19ovXyOHHMW+qGdYCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656595; c=relaxed/simple;
	bh=IOMGCP1DsD66Kpq7GI1XGvhnPqZD7erfV1TBpYm5tuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n105PF8XA/2ltC7lCDyZAkzf+6kzDLU/GPizMgnzmGpWOQI6g7Ti3cs/ylsVv1bZJiI8Z9FuzdWgSWDAI46bAs4GFWv9MeOe9oK2gKBP32ikhYv37UjuzfYdpNH0J7HGESK/zAKjLrNtNtFq8BSJgtL1CVLecpszZ38FmDj6SUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmRbYZUT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso1800288a91.3
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 14:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725656593; x=1726261393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3dtVitYiUmC3HTrK3XaAnFLbrtl4bbbhWHq4k/XNnQ=;
        b=SmRbYZUTjJCY4uP5nbc1yEyWN2SgGEIxQ0U1CeeUN2F4cICSahJG705PyHMIydw7jd
         DPVRIYQcg42Rggf93uKEIUinXPI5pdW4cwYD3Z67sUViaWOSZvmEYc1OMEEDrCgZQI7U
         /QLkc4dHOTCVFf9P5TvdSm5LW7hzZ8mkb62be32dim9FF1AWOmmNtr1H2zmzyo4WjJrh
         ArBAos4NMccTqu+Avt9M3N5xMciWD1cVx5Sw31bn6/RW7MWy11cJV2bMEG4OfJtSDtwT
         F9xYVLj9XyPwD2R/YVlZxNaPQWEeBK4hPyXT1b9YRWHFElSxVAQdH4od7xG76nlLOiem
         IVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725656593; x=1726261393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3dtVitYiUmC3HTrK3XaAnFLbrtl4bbbhWHq4k/XNnQ=;
        b=jrQ4vjKmB2uwozoRtOK74zGczqUaUdC08jAYp/Dt5WeouAlCTrg6nOTwPR45/gPTav
         FywGA2+BEx+bZLoeZFc5Wp0uWxeK+O7vF4wOc5EzkXkgSFvTyKw4d4WUbKZUTYcTfbG+
         qb8xIstL+iaaYFndQ43U1Bm5avaWY+GDhST4171/KuNA/X1Ujk6JX0DdXXVAitXEt+yn
         EeGWhwBdoijs1qkEcKNBnQ4stgLvUH8ORzcthVlhCTk9yPAp+nJ3VnP6RcEtVqM6yf16
         y1DgwR1ANV4k662VuG4yrQql8Gx2T5eUvkYOHuLCEBK84k/IqZ86qud5373JVi57yWRv
         AW/A==
X-Gm-Message-State: AOJu0YwzsZVIBFF19r0DVtlKMOfMq37Ip2a2p8STZV4fGH8QGU1GdLIv
	nPN5C54h6fAHOt/iDMMd9ipN1W5ubPaeOxCVlPzG5ljC8vDEKiwdK93mMFONrH0wBJ140ZGUoWN
	YiJ26105aEVITkszy2WVyxi912GoH8g==
X-Google-Smtp-Source: AGHT+IGs+s4ZZFWjCpRP3oCL597M4QeiGWy3OOc3y2ZGyPCoQH8LY5J0y7MK3D0qC34MDsVKun5B30+Tle3YuKHkJxU=
X-Received: by 2002:a17:90a:f188:b0:2d8:6f66:1ebf with SMTP id
 98e67ed59e1d1-2dad501b555mr4773301a91.20.1725656593240; Fri, 06 Sep 2024
 14:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906135608.26477-1-daniel@iogearbox.net> <20240906135608.26477-2-daniel@iogearbox.net>
In-Reply-To: <20240906135608.26477-2-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:03:00 -0700
Message-ID: <CAEf4BzYXW-O1vip2azoUty13QDj0Hv80p38RLRNiHf9wwz=vNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Remove truncation test in bpf_strtol
 and bpf_strtoul helpers
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, shung-hsi.yu@suse.com, andrii@kernel.org, 
	ast@kernel.org, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> Both bpf_strtol() and bpf_strtoul() helpers passed a temporary "long long=
"
> respectively "unsigned long long" to __bpf_strtoll() / __bpf_strtoull().
>
> Later, the result was checked for truncation via _res !=3D ({unsigned,} l=
ong)_res
> as the destination buffer for the BPF helpers was of type {unsigned,} lon=
g
> which is 32bit on 32bit architectures.
>
> Given the latter was a bug in the helper signatures where the destination=
 buffer
> got adjusted to {s,u}64, the truncation check can now be removed.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  v3 -> v4:
>  - added patch
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  kernel/bpf/helpers.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 0cf42be52890..5404bb964d83 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -526,8 +526,6 @@ BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf=
_len, u64, flags,
>         err =3D __bpf_strtoll(buf, buf_len, flags, &_res);
>         if (err < 0)
>                 return err;
> -       if (_res !=3D (long)_res)
> -               return -ERANGE;
>         *res =3D _res;
>         return err;
>  }
> @@ -554,8 +552,6 @@ BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, bu=
f_len, u64, flags,
>                 return err;
>         if (is_negative)
>                 return -EINVAL;
> -       if (_res !=3D (unsigned long)_res)
> -               return -ERANGE;
>         *res =3D _res;
>         return err;
>  }
> --
> 2.43.0
>

