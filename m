Return-Path: <bpf+bounces-39520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCC197429A
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD727289B56
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CEF1A3BCA;
	Tue, 10 Sep 2024 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQmLiZPZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FF1C69D
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994175; cv=none; b=fXsDi+9R2XL+rVn/6022huBB+Dxzmvz1Mjmr2Dfix+etBbBMLDO5tc4SMII8W7mC7+4+eSlYPft1UddmJBjKOGXRu8uKv65IUue/QCP7y0HsoYGDf5pDEGAqi/LT67gqr3N5P2AtQhm/BFZxPF2hFFqZ637/QM/TWal1FSZG6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994175; c=relaxed/simple;
	bh=GIM0SEBww3CHyb751X7zloUAQJ94ON5C6idhpZ1JNSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JagMgAok8+DpvbE0ZPcQwtprTE+cl9wvZsj1kPa24heJV3LA8sjKyi+melpfUuC2UAW+BDUrOELwTxXQE/E+BRP7YOG+KL229eTmaDen7GaoQk8PZO/Z1BLT4KBuv4dKy9+9fwimp55mcgyiDx23Nz7KjZaZ/7wBJO/oCRjeatI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQmLiZPZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so4309964a91.0
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725994173; x=1726598973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIDmwJFXxGvqwF8wdkVphg2xSm3JUjmpIKcDQMvnC2M=;
        b=HQmLiZPZAtLB/mYjDAGQgqaWMxWd4WD6H9ZGMpeS5IfcqvwvxeRpGUsvuVUU3NdXJV
         Z8kWyw2ozEd76L8rnTqf8pklZKgQDm8A7lWHM7GJp/2DneS2roDc/EQOJPWUfBWoaTXY
         sPXjpN1UwBOos8e98kNAFmQZcS0NCq5Kgluhfguyfy6OUrpPe3BxuaQpp3oOZ7nf2+aP
         5cqRlgUxcSwADpCUuKCMDPbyfJGjrIAo9m3fu+6K7kFYTlm2yqECWK21ST0w/zNrrEZA
         J6It/eGBfZlqyvSbWi4XVnf9ERiHiFXr71yPEwEwU490rtUXiGz5E1TcAQ0YCfIQ5vkV
         NtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994173; x=1726598973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIDmwJFXxGvqwF8wdkVphg2xSm3JUjmpIKcDQMvnC2M=;
        b=TmdYB5M+2ZAumw0d7NlWC1uAI/BtBVsI4tfVihqQfT31f0WqDwJ7iyjWIXxehwU/Xj
         CzzcBgEOLzpj1CvRRX9bMY2H5b1I6ogMAmUVHm/m4f8vjPdKaNDE4I4dic6BgMQRakTq
         AkimTAciL5KrCYzd0JHWn2zlByaCknnyMzySftaP4PrdIuJMp2pbPZprEXSuH7VWbh/6
         093zmpqBJqWUoLvbv2HPjYXXtKt9FAn+samX1qB4f8WMqQEakODEvYn9jJy3Lbx5q2nQ
         vA2kdleBcfkm6DXSix7Xejf40S7MkQTBpcG+icJYURae5+Nl/kfGA5yKa40irAjuVqcw
         6FsA==
X-Forwarded-Encrypted: i=1; AJvYcCVMu1OozeUoVaCnxpEzf3hN1BtW2xH+9nnso7OWwJ6PVqqN8yc7TbjMkGKS5ZkS2iLHNlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2bsh5aBWxay/Hm1zUrgP8hlqXixNgkp8uVG+XKCy9mIqOfYT5
	BjWelmFGaUDKwW5CJlj+6KkyH1BYxt6gns6CIa74J+MfED7Oz8VRm+2cTd/R4NiB3Hj397H4/37
	ZHjBLTWS+xb9tb4vm5M3wEWxOyYw=
X-Google-Smtp-Source: AGHT+IFFZYlCZ/Hc825WfR0ZGi4AUbOm7mFgmgjO2neJYTY6fYqLGmqIa5CUEClnS5tmTBqGRkv47uF+XUKNv/mFsQQ=
X-Received: by 2002:a17:90a:7087:b0:2cb:5aaf:c12e with SMTP id
 98e67ed59e1d1-2dad50f9fc1mr18247334a91.37.1725994173460; Tue, 10 Sep 2024
 11:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910125336.3056271-1-jolsa@kernel.org>
In-Reply-To: <20240910125336.3056271-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 11:49:18 -0700
Message-ID: <CAEf4BzbAOK0viUgYX-hqQXrzAbEpknDBJ1FXZdhCYSQncTC5dg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix uretprobe.multi.s programs auto attachment
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:53=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> As reported by Andrii we don't currently recognize uretprobe.multi.s
> programs as return probes due to using (wrong) strcmp function.
>
> Using strncmp instead to match uretprobe.multi as prefix.
>
> Tests are passing, because the return program was executed
> as entry program and all counts were incremented properly.
>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Closes: https://lore.kernel.org/bpf/CAEf4BzYpH_2f0eHwQG205Q_4hewbtC9OrVSA=
-_jn6ysz53QbBg@mail.gmail.com/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4f29e06c2641..08e110392516 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11688,7 +11688,7 @@ static int attach_uprobe_multi(const struct bpf_p=
rogram *prog, long cookie, stru
>                 ret =3D 0;
>                 break;
>         case 3:
> -               opts.retprobe =3D strcmp(probe_type, "uretprobe.multi") =
=3D=3D 0;
> +               opts.retprobe =3D strncmp(probe_type, "uretprobe.multi", =
sizeof("uretprobe.multi") - 1) =3D=3D 0;

I replaced this with `opts.retprobe =3D str_has_pfx(probe_type,
"uretprobe.multi");`, less duplication


>                 *link =3D bpf_program__attach_uprobe_multi(prog, -1, bina=
ry_path, func_name, &opts);
>                 ret =3D libbpf_get_error(*link);
>                 break;
> --
> 2.46.0
>

