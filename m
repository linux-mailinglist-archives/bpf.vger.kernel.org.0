Return-Path: <bpf+bounces-45657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFCB9D9EEC
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 22:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363D1B24719
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB111DF99F;
	Tue, 26 Nov 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmXwpQd2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102D1DEFC2;
	Tue, 26 Nov 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657060; cv=none; b=AodbcehptoGAWp4S2/xf0jrPRhhuI2lKWkKELOLcjQcCvHjFt/WvmXpEts6vlgP1ccRB9aBNYekg0gKq9T2pHJGvQb6lHvxu7p84N2gUJYnsyu8lK3FvG2t84rCl6OUDhu4Nb6RN15Hvd7nI0zlB6zL9egD4n5svR3TVy9qp8aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657060; c=relaxed/simple;
	bh=Edaq0YV7KCobl0pdRamgzeOa/dTyNw3+ki5UWqeHEQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LM3AUbgl9yboA5u95AhrHLzwlLZnPhxqEqS4pXAnLOqMRIXFjylMDE1c2Rq5vlj9CFOLM7AGjOrx8YuKmn00/JtKtAIxVKM8u/GgjwnD9AKv3fOBFPkYusTkVv4i1Dq2HiRm94d0ruANhu6mD72iHtJewwHOQJQZZlbeSyPEvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmXwpQd2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21260209c68so1317495ad.0;
        Tue, 26 Nov 2024 13:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732657058; x=1733261858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVUE01ZRI/rfSEVGvignn3JqcJ39zeoDSJpc7F20e9k=;
        b=YmXwpQd2f+L452i4TTWkwRYR6x6Jl44ZL2i104riWQhrAlzOxSMolvY0+wblKIIheu
         cHUF0mwnFK+DK439kyjLun1aof1+bamwITU5tKANAophzp0NkKMB8RKEDI2wix8Tk3dp
         PPrT3oazw4LQghxlKKkrSuayjEc8bdEF4HMQ6jVvkKcYcC6JOSjKKwZFVaVB00b04Jnq
         5PkcUsd/OgPmMo+8+BnsL5LXccBTpEDchsMQuu+U4Hx03zvpj1pe4sb6XD+oPZDFulBH
         bxJQy5/n7E7UWzWxxYwNNupAF8MfNOaLVc1pxFpQu/Ko0jTYc8oZHlHYzRD2TUoGg67w
         mSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657058; x=1733261858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVUE01ZRI/rfSEVGvignn3JqcJ39zeoDSJpc7F20e9k=;
        b=AX/dGwrWYDP1JROkr0oHe85LscitvBEiXtZVfzSGReADB/w96kKdVio5K7YP9LotNC
         J1Rr/uFz+fYbmVeqHyy+z/nuVIz5o2tripCzPJIlIqX6tjSihCf3w2yoDyhe8kcBWTah
         8iuqvc+64rJHp9iWcTNgN3GYXDpT4QQwNCNEHMu89f7YEicAtlSDrAakX2TtznMcyKHh
         wEvtXQTkrR5ivIiEz7soxWUDxBUw2Dxv7eTHys49gpd0mZMMTYa6xQQDR9F2pmUMHYXr
         9Qcpg4avqb9RybKgZPJ0laNbe1jWQ9h9NeaTsbH4wdDaX1jiBB1z9DHQqbUMyoF34a7K
         c2dw==
X-Forwarded-Encrypted: i=1; AJvYcCXbBBZt4u0QrNm5ghQ3tO620JVIJyMiyF/M01f5mP7NH8DAUBEUzXyeQO6uGvZfeuA4Pbw=@vger.kernel.org, AJvYcCXyO4jPvokt+MCvd4mpRHzguq0Ey05L3bgB6/jpOG+1rNC2vlBrlYlznUHUiAi1BjJcWm9PcPHVGZU1y7EH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YhAIekjFOLZlyNWnP1JYnRtClyRFGjI/PAXjIyGNxqCtgGvs
	y6ZVxPqQKTDpwU7pK7q8P7ibsXKjB00YyNhlSSLVOYixcdnp/3O+F3X+FO3kh2jzA05TZMSah9t
	P0hnYls/itu3U72KTiQAGWpZZkqQ=
X-Gm-Gg: ASbGncvVEo7tQYcY6wAIACjppyniu30lM7CUyR/gLGLiRu5xVPKpa7EuwbE60LUt0cc
	6zFAyIS7d4iklJFe865GwVz3kziXpFZlor5CGsMVjdctvMTE=
X-Google-Smtp-Source: AGHT+IGKRiBb5wAaSZsfoPYNFd0wWAnY+KOIaIANYcNA5TIyK8E3wnl6J5EnzkJxdTO579y4i6CEma+IcXiU2kFrN0I=
X-Received: by 2002:a17:90b:17c9:b0:2ea:45d3:a73a with SMTP id
 98e67ed59e1d1-2edebf3ea41mr7344995a91.16.1732657058233; Tue, 26 Nov 2024
 13:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-sysfs-const-bin_attr-bpf-v1-1-823aea399b53@weissschuh.net>
In-Reply-To: <20241122-sysfs-const-bin_attr-bpf-v1-1-823aea399b53@weissschuh.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 13:37:26 -0800
Message-ID: <CAEf4BzbNs=MVNDztRW_76f8aQkm44ykiibqGa2REThWM4dVa_g@mail.gmail.com>
Subject: Re: [PATCH] btf: Use BIN_ATTR_SIMPLE_RO() to define vmlinux attribute
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:57=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> The usage of the macro allows to remove the custom handler function,
> saving some memory. Additionally the code is easier to read.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Something similar can be done to btf_module_read() in kernel/bpf/btf.c.
> But doing it here and now would lead to some conflicts with some other
> sysfs refactorings I'm doing. It will be part of a future series.
> ---
>  kernel/bpf/sysfs_btf.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>

Nice, let's simplify. But why change the name to generic "vmlinux" if
it's actually btf_vmlinux? Can we keep the original btf-specific name?

pw-bot: cr

> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> index fedb54c94cdb830a4890d33677dcc5a6e236c13f..a24381f933d0b80b11116d054=
63c35e9fa66acb1 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c
> @@ -12,34 +12,23 @@
>  extern char __start_BTF[];
>  extern char __stop_BTF[];
>
> -static ssize_t
> -btf_vmlinux_read(struct file *file, struct kobject *kobj,
> -                struct bin_attribute *bin_attr,
> -                char *buf, loff_t off, size_t len)
> -{
> -       memcpy(buf, __start_BTF + off, len);
> -       return len;
> -}
> -
> -static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init =3D {
> -       .attr =3D { .name =3D "vmlinux", .mode =3D 0444, },
> -       .read =3D btf_vmlinux_read,
> -};
> +static __ro_after_init BIN_ATTR_SIMPLE_RO(vmlinux);
>
>  struct kobject *btf_kobj;
>
>  static int __init btf_vmlinux_init(void)
>  {
> -       bin_attr_btf_vmlinux.size =3D __stop_BTF - __start_BTF;
> +       bin_attr_vmlinux.private =3D __start_BTF;
> +       bin_attr_vmlinux.size =3D __stop_BTF - __start_BTF;
>
> -       if (bin_attr_btf_vmlinux.size =3D=3D 0)
> +       if (bin_attr_vmlinux.size =3D=3D 0)
>                 return 0;
>
>         btf_kobj =3D kobject_create_and_add("btf", kernel_kobj);
>         if (!btf_kobj)
>                 return -ENOMEM;
>
> -       return sysfs_create_bin_file(btf_kobj, &bin_attr_btf_vmlinux);
> +       return sysfs_create_bin_file(btf_kobj, &bin_attr_vmlinux);
>  }
>
>  subsys_initcall(btf_vmlinux_init);
>
> ---
> base-commit: 28eb75e178d389d325f1666e422bc13bbbb9804c
> change-id: 20241122-sysfs-const-bin_attr-bpf-737286bb9f27
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>

