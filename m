Return-Path: <bpf+bounces-48590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF8CA09D2A
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5C116AD30
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 21:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC2209671;
	Fri, 10 Jan 2025 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/aqRnpI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400EA1A23B0
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736544383; cv=none; b=fdAu70NeBhcGzwmVkC/0kR84pz1k4434JYEN94DRs1JnFmOYgEyRbbAAe8vyoxmyzNzKdahmjJJme6+W3zULLUcZRvidzGD1HUuSdcI2DzWw13seuUW/DKrE32T9wzVnyGSnpUDgbHzZE7XCq7SnsDs12XDvBuR0JMka6QJS8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736544383; c=relaxed/simple;
	bh=AIaMIjejQx/3FWfgipdbMYYt1tupMxLUM/wyFaInC2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WI+Et5xqW0Vgc9ZAtlF60ZgZz9VeGZrd6Zfoo/g/D1lFDThLVqAVJR4+tdLyvHPoxmTTv0vVYdP93t6breHUl8yAN+GvPeudUos32i+zXdkdh6YnyEwm8o5aneG9X97rYcl/8Uol2HOs2HIQSYNf7EV6QYj9YNdGUz/1wWho0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/aqRnpI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef748105deso3302807a91.1
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 13:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736544380; x=1737149180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvcAMlOXOTkvFaJTQxuoBtjrSeBM5+J65u4qMp34Y5Q=;
        b=g/aqRnpIYivbNOTAssPYy2OYiPhWONAHwebuPZCvOUV72GS+fU0xZT34gaXCjbU2cB
         rUVNp8lRspLGxT2xz76V54MhD2DeMLBzXMfW/CY11035Gg6U1+PAxakbkdt4lu4Uuy/X
         MNoVJVvdbKuMEaXfO9w73OBB7J85ugZEqqsPm+Da3xvVKzyrbZ7YszuLLDi4fpDHrru5
         Ucz6EYXgVGA08GQE0tFG0oPiebhRe7usV0O5HB2pXB74M4yTJ5JoV0I3jf7UL91CO2bJ
         oeHgeD1ZeZtXzXk3YFVO4f54ZO4eF3ozeNo26UllIYDldRtq1JmPIKFhW2L2gcqYtZ/k
         n08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736544380; x=1737149180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvcAMlOXOTkvFaJTQxuoBtjrSeBM5+J65u4qMp34Y5Q=;
        b=byVkCFwHBOCqg1j3RshHs3JxDxv/ovAJKTJ/Uo8/stUQ22cKdcRsIOIqjfshzvWWpj
         JLFMGcjSYsMbcMdGwI81crFtjnsm1YCeHeGbzzgKzKzuPikXju0NvGAnbwCyIt3gY8Bi
         48KjFg3gNrAy93RHZdvujvNHIQizjwUG6VDVfZVJxiRsa5ojzV/i/KiTrHhwhGbUAJZm
         Fud7c+NYB2Rs3xdzxNaMw3fncNU9f3dicJzzqwlPUrWrlaWSzsBlOWV0XXZpTa6iqopH
         NW5DS63sYwXppyZgFaZfh6G0BKiCab4c6OMsoZcFqQCWnLoI2cmG27asp0AR3XnycbaI
         Ii9Q==
X-Gm-Message-State: AOJu0Yx5Yoy9Toq1PLn739dcCeBpEZS5QZEbCeK4IVsXayNNXpHCe/Zf
	tBe/AcA6K96ePdj/esDSvBPvJfOPAimrJp7Gdws1AwYiEiNrylc/VyCorNvFo2oV0Wdsi7ElIis
	CRgLo+OEuNxa6/w9pnKyhaghrsxk=
X-Gm-Gg: ASbGncvtGwWZ4flZ+NUREmWw13g+4I2tlfq/4zLCUKrZ0mG+oHq+FkM3ZBlOoVfCLar
	LxzEOHsucMXlUFz43kM9PRdRdgddjj/GHr3t/2lkoaMzuDsy470lgDg==
X-Google-Smtp-Source: AGHT+IFo3ZXQRjx3ksqDINAwV8Mzx4wsDWKjQyRburFirj7ho36tQbK+rKsPL5tpl5ZRxIqhgpPJdjYjCj+ey1fjPpw=
X-Received: by 2002:a17:90b:3881:b0:2ee:bc1d:f98b with SMTP id
 98e67ed59e1d1-2f548f424bcmr16202675a91.31.1736544380352; Fri, 10 Jan 2025
 13:26:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109174023.3368432-1-yonghong.song@linux.dev>
In-Reply-To: <20250109174023.3368432-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jan 2025 13:26:07 -0800
X-Gm-Features: AbW1kvZFfejZzocpE22rnDoAXbJBlJmn3IT2-IeR3pManv-eN1DBgaWQS4thyTY
Message-ID: <CAEf4Bza5gSXOoNhLaW7jm2tDcdip3R2ZRoP0z_ah7uh+OisBYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: Add unique_match option for multi kprobe
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jordan Rome <linux@jordanrome.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 9:40=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Jordan reported an issue in Meta production environment where func
> try_to_wake_up() is renamed to try_to_wake_up.llvm.<hash>() by clang
> compiler at lto mode. The original 'kprobe/try_to_wake_up' does not
> work any more since try_to_wake_up() does not match the actual func
> name in /proc/kallsyms.
>
> There are a couple of ways to resolve this issue. For example, in
> attach_kprobe(), we could do lookup in /proc/kallsyms so try_to_wake_up()
> can be replaced by try_to_wake_up.llvm.<hach>(). Or we can force users
> to use bpf_program__attach_kprobe() where they need to lookup
> /proc/kallsyms to find out try_to_wake_up.llvm.<hach>(). But these two
> approaches requires extra work by either libbpf or user.
>
> Luckily, suggested by Andrii, multi kprobe already supports wildcard ('*'=
)
> for symbol matching. In the above example, 'try_to_wake_up*' can match
> to try_to_wake_up() or try_to_wake_up.llvm.<hash>() and this allows
> bpf prog works for different kernels as some kernels may have
> try_to_wake_up() and some others may have try_to_wake_up.llvm.<hash>().
>
> The original intention is to kprobe try_to_wake_up() only, so an optional
> field unique_match is added to struct bpf_kprobe_multi_opts. If the
> field is set to true, the number of matched functions must be one.
> Otherwise, the attachment will fail. In the above case, multi kprobe
> with 'try_to_wake_up*' and unique_match preserves user functionality.
>
> Reported-by: Jordan Rome <linux@jordanrome.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c | 13 ++++++++++++-
>  tools/lib/bpf/libbpf.h |  4 +++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> Changelog:
>   v1 -> v2:
>     - Avoid possible memory leak of res.addrs.
>     - Return an error for !pattern && unique_match case.
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 46492cc0927d..a7cc6545ec63 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11534,7 +11534,7 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
>         struct bpf_link *link =3D NULL;
>         const unsigned long *addrs;
>         int err, link_fd, prog_fd;
> -       bool retprobe, session;
> +       bool retprobe, session, unique_match;
>         const __u64 *cookies;
>         const char **syms;
>         size_t cnt;
> @@ -11553,6 +11553,7 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
>         addrs   =3D OPTS_GET(opts, addrs, false);
>         cnt     =3D OPTS_GET(opts, cnt, false);
>         cookies =3D OPTS_GET(opts, cookies, false);
> +       unique_match =3D OPTS_GET(opts, unique_match, false);
>
>         if (!pattern && !addrs && !syms)
>                 return libbpf_err_ptr(-EINVAL);
> @@ -11560,6 +11561,8 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
>                 return libbpf_err_ptr(-EINVAL);
>         if (!pattern && !cnt)
>                 return libbpf_err_ptr(-EINVAL);
> +       if (!pattern && unique_match)
> +               return libbpf_err_ptr(-EINVAL);
>         if (addrs && syms)
>                 return libbpf_err_ptr(-EINVAL);
>
> @@ -11570,6 +11573,14 @@ bpf_program__attach_kprobe_multi_opts(const stru=
ct bpf_program *prog,
>                         err =3D libbpf_available_kallsyms_parse(&res);
>                 if (err)
>                         goto error;
> +
> +               if (unique_match && res.cnt !=3D 1) {
> +                       pr_warn("prog '%s': failed to find a unique match=
, num matches: %lu\n",
> +                               prog->name, res.cnt);

I've added pattern itself into the error message, and also %lu -> %zu
(it's size_t, not long unsigned)


> +                       err =3D -EINVAL;
> +                       goto error;
> +               }
> +
>                 addrs =3D res.addrs;
>                 cnt =3D res.cnt;
>         }
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d45807103565..3020ee45303a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -552,10 +552,12 @@ struct bpf_kprobe_multi_opts {
>         bool retprobe;
>         /* create session kprobes */
>         bool session;
> +       /* enforce unique match */
> +       bool unique_match;
>         size_t :0;
>  };
>
> -#define bpf_kprobe_multi_opts__last_field session
> +#define bpf_kprobe_multi_opts__last_field unique_match
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> --
> 2.43.5
>

