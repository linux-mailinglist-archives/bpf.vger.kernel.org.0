Return-Path: <bpf+bounces-28216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC528B669D
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A1228424A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35E194C86;
	Mon, 29 Apr 2024 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUeNFlUL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65485945
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434186; cv=none; b=sydSiftbnjzyz50dczZZS+lIVxWgrFgMyCRGZBJJw5yDRpzabSNGYyxPVbSiGoQ3E+QkjaS8XWC2iGSDGfV+xkVQXujOPJcof82tKViV6hwHheFKpxROwH/D8D7aYx8PJwX9WDk2jWoJblXmZ/E3GBj17VuwDPs//yM43Cyk+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434186; c=relaxed/simple;
	bh=JeSupmUqqyJRtNtTz6ou1KK3TLRjLapdBDyrnZ93Isg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfCNDTEAYWQ3sSGPEJpdM+td0dKo+B1XXmzjFhMmmQhtvmSqOSpGZMWAKEE4SX1DEAsp1F76JOX8ykh9D2gQCUlUyIibuUS+j5ZsMTUel/Tqu/f992V3AUphXf53kTdMl9CHbiEuqKjrrw/snawKbhjQqhRexi/wKWMAU8BzXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUeNFlUL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so3432430a91.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714434185; x=1715038985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrLfUvxj5ECKg60KD5z89uCrsYx2SbqzeH8ReTjjQIM=;
        b=ZUeNFlULvfKYSCZNOwEYuXLlQUL1bejGr2XSJgd6UVovuAVY2KWCtSGTPH9DtGSool
         SMwoga2txSBb56q402XC1gOpNv1zrckmKWqiSEF3f3LrksBJoKat5pUYQWT8WD0R6v4p
         Wehtp2fwOEEzDxn+Nv4jU5OfzvrIUPJv0O50zMiZEdDCDvEiGm+o058OcL9/7CBfSSSL
         pVzXFiS4UXR/KDThZHuLqOokmfkUecgiN7LFYw7CfisxPCgYE9L9qDBhjtf32V6mnEt5
         Dpwd6Pb4RaE2BRxlpGkNGC9DVt+WjeyrsAQssQMS21Ri6LHTgJUb52aRxGBOXcMZLXG8
         /n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434185; x=1715038985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrLfUvxj5ECKg60KD5z89uCrsYx2SbqzeH8ReTjjQIM=;
        b=YFvfmWVTrgGFH5nEuVX/NVKa4I3jrWiT62ue6DLYiGosPQkLNR+9T0MgKz3pdlBsTo
         JScu+txNKDACvEG/5uo9KU9steODB+zahAEFnV82L3275qQy5AZSQxQF4FkKBm+G+HVC
         Ce89Hvk4ry1jcSEV0SVDmCuZEuj68WhqTUX7NhfJ0Iu768sTqGtLfsVnOS5ii80gr6LR
         4se5gouDS3CGzHPst2huTJmQ72J+ZT0BrhVZhJHey6mXsz6sWL9WT3575Tbn/VSrV/8i
         IFzVGw0GdzPXWRgKp/mxi7NkVm6ZXJGufr2A0FyuWrffDGfEDFWrbXDbvXy5Lkfgro/4
         bvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe2kdsnL1lk2+dAVkJeX+O1fXieMxZ5FbcLCPmxdTUm2AXL6YEXfgx2Q5gj4424YBifA8bc7gPEwUT3p61y78KWiQB
X-Gm-Message-State: AOJu0YzQGlK+R8ItkOSB2UvmRSnCI2zKHorqBm5iJvT007oPKWph5JQ0
	IjJGblB/wRS1vFZdsCVGQvuJ/dppaAKtJMOTFY7L+KSFuy2zHXteJMvDy5hWY6k3fuNnRyShRxA
	Mckl30gIRiL4Mrwb+m3+QUmrN05I=
X-Google-Smtp-Source: AGHT+IHkN+V0MEwH27WAkX8h5RQ/1QEl940ngsIkqnKWEmu14hClUxA5YQ+BE+c00JYc/4ydnreTDsq6CxYIlsfGGxI=
X-Received: by 2002:a17:90a:c254:b0:2b2:88f7:1f7e with SMTP id
 d20-20020a17090ac25400b002b288f71f7emr293603pjx.4.1714434184693; Mon, 29 Apr
 2024 16:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com> <20240424154806.3417662-6-alan.maguire@oracle.com>
In-Reply-To: <20240424154806.3417662-6-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 16:42:52 -0700
Message-ID: <CAEf4BzYKAtSvtR+uUt60SCZ7FaN3uCpsXGoEZ+QXV71R3JDZEA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/13] bpftool: support displaying raw split
 BTF using base BTF section as base
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:49=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> If no base BTF can be found, fall back to checking for the .BTF.base
> section and use it to display split BTF.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/btf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..2e8bd2c9f0a3 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -631,6 +631,15 @@ static int do_dump(int argc, char **argv)
>                         base =3D get_vmlinux_btf_from_sysfs();
>
>                 btf =3D btf__parse_split(*argv, base ?: base_btf);
> +               /* Finally check for presence of base BTF section */
> +               if (!btf && !base && !base_btf) {
> +                       LIBBPF_OPTS(btf_parse_opts, optp);
> +
> +                       optp.btf_sec =3D BTF_BASE_ELF_SEC;

you can do this declaratively:

LIBBPF_OPTS(btf_parse_opts, optp, .btf_sec =3D BTF_BASE_ELF_SEC);


> +                       base_btf =3D btf__parse_opts(*argv, &optp);
> +                       if (base_btf)
> +                               btf =3D btf__parse_split(*argv, base_btf)=
;
> +               }
>                 if (!btf) {
>                         err =3D -errno;
>                         p_err("failed to load BTF from %s: %s",
> --
> 2.31.1
>

