Return-Path: <bpf+bounces-20277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AE883B490
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 23:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF598284418
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 22:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ADE135413;
	Wed, 24 Jan 2024 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHr+bIxM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C61350DA
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134642; cv=none; b=RWYol0b+VkqJXGbSre12/7M27TDxTcM3w1g9P6iPxgRsF2ETfBXpmgftq3h+5dPbMo3URvhCw8qFmXXvoTrQSc3dKC/6yR5aVFgkl6OmnF8c4qPY/+LmmGMdkoI8dHanorxfwaDRS9jAhjqBdlkb/yqRVbNg2GMV2YxIslwi2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134642; c=relaxed/simple;
	bh=ThH2IdJ0J6AlTFmKnnsbaOwHg8UYyfjgQunttqBkL/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgWvNr+BTZZe1WEoQmCbE8jHF1YsMLLr6tAt44DhelP1aUl9i7SwtcFm6fChdk9UkXq4Fm3x9e7h2c3kkbLf3LnSGlz6xPQNbQa9SYScTX5FV1JeKCbZBAo36gVxyFDNmeJAKGpntcs9/dHCP4TQcbc8qnhELxLQ5lqiRQASXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHr+bIxM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3394ca0c874so1109536f8f.2
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 14:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706134638; x=1706739438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFODCKoOHVjDcR4X9FWvJ9XBAe3+l5FAVeeBuiJEVtk=;
        b=MHr+bIxM9MRNkyeOKU1And7HqfS68EQXY7evI2svVYLBwmrf8XZN9N2Xo7cTEzDFt2
         +p4NHpTgyKsrqa9nKMyHAPHGd2rmGQiOVekQzTSDpurP9BznfOvXRoI39igatqob2pjA
         yKt33OEAymxot/3c+wvQqEVMcXiFI5b81X6jkLmtDT/4SQqtXh85WR8kDRqD8qxGJqoj
         V8CJDoJ8uUrQb6UCN/u7GsfJhE7Iyrn0AcX2SA/hO/frwVCSe7NYWGQNPvfeMwb2Ih7+
         /knQ3Ss8MB1fxmx9JgD/4xiprGttyn68obHvfwJMIyl6qvD26GzkCy5w5RJkC23P0Fgq
         Q0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706134638; x=1706739438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFODCKoOHVjDcR4X9FWvJ9XBAe3+l5FAVeeBuiJEVtk=;
        b=TYztLUR2Y04ghVuR3wa6I6LrvyA3p1c0tlSS7rD7c17e/flRa3Hjv3G88DodfGZf2f
         YFZ1D8GOzxbzcAI1PXyXgHoGjMAuEARgL9iunQHL+y5a5+Y9TvJMBslLyyvIJNfBsCO7
         YyOBdhyPTOcaMzU7exo9eA8USIuaZDezoF03dDaabOO7a5bOWIeuOc7GLcahrdV9d74E
         xS2bVOeVZH/vn4OQaMbeMkOVSS2kyXWNvpGYRNt6av72yznD+IYAejTpyGCD6KVnHGrH
         9r+5jYqQ8ktfPqRgbnjkUH4ZwTaAXJ5p+5MyAaKtN5DUNUxFN2hgMwZ29oeIuj2Y6UIv
         R7OA==
X-Gm-Message-State: AOJu0YwwHPBeJF+ryYjnDGNzun9TX72/LQSUUcgb8saCAUb2VabhLHiN
	Q89FF3xe2ZAwT7xfhACHuSURmcqnaaGxSuh3PZpmFDdCBLvfmyshWthNBFXvqWiYTq9y/KPBYgw
	XEobwkV33LaT1ypj+aQrpSVc7Jvg=
X-Google-Smtp-Source: AGHT+IFbXG3M4AcaXMnB7nxUWsH0HIXleO+vwS1/Kl8460boI9BalwwRa2mnQRb5OXIsovTd/IZ969qqv9EHtrS7CNE=
X-Received: by 2002:a5d:58d0:0:b0:337:c555:18b5 with SMTP id
 o16-20020a5d58d0000000b00337c55518b5mr927300wrf.115.1706134638329; Wed, 24
 Jan 2024 14:17:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124195519.2136101-1-martin.lau@linux.dev>
In-Reply-To: <20240124195519.2136101-1-martin.lau@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Jan 2024 14:17:06 -0800
Message-ID: <CAADnVQ+tt-MvFd8Hoggph-_0OTAjBRODbiROimjfC04-7JJDXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Stop setting -1 to value_type_btf_obj_fd
 which breaks backward compatibility
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@meta.com>, Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:55=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Passing -1 in value_type_btf_obj_fd to the kernel will break backward
> compatibility. This patch fixes it by using 0 as the default.
>
> Cc: Kui-Feng Lee <thinker.li@gmail.com>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Fixes: 9e926acda0c2 ("libbpf: Find correct module BTFs for struct_ops map=
s and progs.")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  tools/lib/bpf/bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 3a35472a17c5..b133acfe08fb 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -192,7 +192,7 @@ int bpf_map_create(enum bpf_map_type map_type,
>         attr.btf_key_type_id =3D OPTS_GET(opts, btf_key_type_id, 0);
>         attr.btf_value_type_id =3D OPTS_GET(opts, btf_value_type_id, 0);
>         attr.btf_vmlinux_value_type_id =3D OPTS_GET(opts, btf_vmlinux_val=
ue_type_id, 0);
> -       attr.value_type_btf_obj_fd =3D OPTS_GET(opts, value_type_btf_obj_=
fd, -1);
> +       attr.value_type_btf_obj_fd =3D OPTS_GET(opts, value_type_btf_obj_=
fd, 0);

imo the commit log is too vague why it's ok to set this field to zero
when it's not specified in opts.
It took me some time to go through the kernel and libbpf bits to see
that there is a BPF_F_VTYPE_BTF_OBJ_FD flag that gates the use of
value_type_btf_obj_fd and fd=3D0 is not special.
Please improve commit log and respin.

Thanks

