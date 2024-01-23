Return-Path: <bpf+bounces-20113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D17E8399F7
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAFF2848EC
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9A782D8D;
	Tue, 23 Jan 2024 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Izhsrruw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945981207;
	Tue, 23 Jan 2024 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040416; cv=none; b=CpLDO8RERGPKochCmxC4Z61W4L9ymzqXuZxZhO8P2nbJ6InZlx94MuyrsKr76ZzSHuEV05pnJLOPWZLOm4a/9fFNY/51YJuGCZE2o7QvP5OqykARDB8PC0wQ/405CzrKt3OedKJt7RbZ6/wVgYCzoQaWeGewAflhZe1KAnrjX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040416; c=relaxed/simple;
	bh=wW46K2JahqhRKU03msV9qq5C0Se51/VCy1Zx5rMOsJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnpGYg06sJ9u4hFUdO7sSA599yqi3Tur4p8OLzO43cfyZ36xH5YVrXEGYvBhtgph9cuccABp7VtBIRILrAd13ZVzkz5hElSNfIMsSK+JDJ0DDkzk1e8mrikwzfIhoVtZSK5WdjvGXYmtial8T0UY3OiB5JNuhTjgV04Fh79xhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Izhsrruw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dd80d3d419so706591b3a.3;
        Tue, 23 Jan 2024 12:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706040415; x=1706645215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/ygAm/dAvsvevheGo6sbfcERkpvXDy/mrpdBQjBTGE=;
        b=Izhsrruw/BtstDLeBwkc2vRVVpYYFkh3IFtird6yqU8OwkNF0pxgtRmMDuplGaaOsc
         ghQOPzqRvEgPQSHjOcYZxisNfTak+TrmY05zdrcmWtsH37zDMUO3zvi+hAjvSGzJfa8I
         UHuu4irfP7xE1BHvYjCFt3qh+OH/ORUzi7CYUFiyLP4v3VsMq9JtwkeopofyGDFi1rXh
         UFdp17LrCh/HmOfF1f3oos8jXmg1zRoqr8JvqG6ibQQBq34XJs3ThnayJw4rWj3U2B6u
         kqWoOPf6yx7vFC5g5tN2xRxXyMlc3KPXj+vz+xAtgj/6zCbMQb0UgP4C8e6bWW3854lK
         U/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706040415; x=1706645215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/ygAm/dAvsvevheGo6sbfcERkpvXDy/mrpdBQjBTGE=;
        b=l6cs6KsOunymf+m65lmuTyIrn3RzwUISFCz0usp6Bj6WO7NIo5pTk0eQt3khckMzNF
         79Btk7aP7AG6xXGiaszB6q8gX3IaJkvEGIej17ztzLSb9KhQEu1TwVELGxpErWQkw4l6
         TtVdVHUGBbXLz7VbvZUGpILdMCVsT75l+kLSUr4uktq/zS26gK4CyIoaChRliJ2tZYHs
         pnIrWTNrdsle3jCoZxaVOOEvuUT0td0xzi2Z5wQiybzBG207M6bLLdNTsh+MsLkz53Od
         PJ1KaCWJYqCGJvAl2at1M0Xn+3s8SmuxR6s+oFeHX4OaeCLqG+pZNqYpC8BfydzTPdRR
         Bswg==
X-Gm-Message-State: AOJu0Yxpz+Q3iK0jCQaHfLHwRXQmC98S2mY8TvxyT+T/Md5VSpRmZ6UR
	cRhrRk4xybLNii+f90QjydmM/3EYJm2Ghhjbvn5xEV9dItdXtVQKuWLHQmNZbNYEvc/Wua+cqCS
	S8xHVpOuMCxjiigiqSDraRzyWe2w=
X-Google-Smtp-Source: AGHT+IHR6c12R9FRlx8FOYsRoe5jJ/R3x83LBY3RtM3VfhHOIiEN5Vz/B5j3402bc5pvty/nUHR+tw81ZVGLDphzmy0=
X-Received: by 2002:aa7:8e81:0:b0:6d9:8f56:106b with SMTP id
 a1-20020aa78e81000000b006d98f56106bmr6687722pfr.39.1706040414577; Tue, 23 Jan
 2024 12:06:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123195449.1303643-1-irogers@google.com>
In-Reply-To: <20240123195449.1303643-1-irogers@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jan 2024 12:06:42 -0800
Message-ID: <CAEf4BzY04bASavt2LTVBR6kFZb4ebci4Bs+V6rv91xo8OAYHNw@mail.gmail.com>
Subject: Re: [PATCH v1] libbpf: Add some details for BTF parsing failures
To: Ian Rogers <irogers@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 11:54=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to find
> valid kernel BTF" message makes diagnosing the kernel build issue some
> what cryptic. Add a little more detail with the hope of helping users.
>
> Before:
> ```
> libbpf: failed to find valid kernel BTF
> libbpf: Error loading vmlinux BTF: -3
> libbpf: failed to load object 'lock_contention_bpf'
> libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> ```
>
> After no access:
> ```
> libbpf: failed to find a kernel (typically /sys/kernel/btf/vmlinux) for B=
TF data
> libbpf: Error loading vmlinux BTF: -3
> libbpf: failed to load object 'lock_contention_bpf'
> libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> ```
>
> After no BTF:
> ```
> libbpf: failed to find BTF in kernel (was CONFIG_DEBUG_INFO_BTF enabled?)
> libbpf: Error loading vmlinux BTF: -3
> libbpf: failed to load object 'lock_contention_bpf'
> libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
> ```
>
> Closes: https://lore.kernel.org/bpf/CAP-5=3DfU+DN_+Y=3DY4gtELUsJxKNDDCOvJ=
zPHvjUVaUoeFAzNnig@mail.gmail.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/bpf/btf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ee95fd379d4d..505c0fb2d1ed 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4942,6 +4942,7 @@ struct btf *btf__load_vmlinux_btf(void)
>         struct utsname buf;
>         struct btf *btf;
>         int i, err;
> +       bool found_path =3D false;
>
>         uname(&buf);
>
> @@ -4951,6 +4952,7 @@ struct btf *btf__load_vmlinux_btf(void)
>                 if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
>                         continue;
>
> +               found_path =3D true;
>                 btf =3D btf__parse(path, NULL);
>                 err =3D libbpf_get_error(btf);
>                 pr_debug("loading kernel BTF '%s': %d\n", path, err);
> @@ -4960,7 +4962,11 @@ struct btf *btf__load_vmlinux_btf(void)
>                 return btf;
>         }
>
> -       pr_warn("failed to find valid kernel BTF\n");
> +       if (found_path)

wrong condition, should be !found_path (or rather swap below pr_warns)?

> +               pr_warn("failed to find BTF in kernel (was CONFIG_DEBUG_I=
NFO_BTF enabled?)\n");
> +       else
> +               pr_warn("failed to find a kernel (typically /sys/kernel/b=
tf/vmlinux) for BTF data\n");

"find a kernel for BTF data"? a) "kernel for BTF" reads weird and b)
we found it (found_path=3D=3Dtrue), we just failed to load it. So how
about:

  "failed to load kernel BTF data (typically at /sys/kernel/btf/vmlinux)"?

But I'd say we should do a bit better here. If /sys/kernel/btf/vmlinux
is there, we should probably stop and not even try fallback paths. And
so if we fail loading /sys/kernel/btf/vmlinux, then report failure
(probably with error code as well). If we have to fallback, then we
can remember the path we did find, but failed to load, and report that
(instead of wrongly reporting /sys/kernel/btf/vmlinux).


> +
>         return libbpf_err_ptr(-ESRCH);
>  }
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

