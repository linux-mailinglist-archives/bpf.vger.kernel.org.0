Return-Path: <bpf+bounces-20645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7728417AA
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 01:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14731C21A2B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 00:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9941E502;
	Tue, 30 Jan 2024 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmW1djgA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9071E52A;
	Tue, 30 Jan 2024 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575435; cv=none; b=g8/7DvQ4C6tA/VyIMnyya8H0lD/SYDOG5pdKC1zO+b/RfapeSW3v10+j8iYOn8nzUHBd6PAjUw0Q7M5x5l72FpbjTqSPkbQIQGPwbsVsdRtBP0ODh+SyLUt10I/1LgKMphtar2np50yqOxoomM6S4Ri2Z/uJp/NNPBMPyM/UN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575435; c=relaxed/simple;
	bh=LmxdhtptYE4XUcAnnFuCDHVM4yny8+hZkQkeTAfKkGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueVUH1AEAxqYXialHysMzfZCmY1SOZlgeFhIrSkPAPqHZJ9+ik4Gm1omC7/nP6tAyFrrEtlYBHtZUQCn1Td6nM9x0CHdKoJDqAOf4ehuWOG8wIpaZyY+fefidzR5X5nxLw0TJWAgJRQHZYVGtfrWDNx8DWKeT9C5dZun6OzqsnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmW1djgA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ddc2a78829so1314735b3a.3;
        Mon, 29 Jan 2024 16:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706575433; x=1707180233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHeKi/dUeXjtXB5wLkxmt70n9tuYNx+1XqZWsLVWqa0=;
        b=dmW1djgA8m4Wgkj074D29pLyG7UoRJ6Zo+OhYLGSALERGYOnNhETgsLa/ocFZKlide
         /9GEFoaItjM2iIJ+H/1007sZC67Uq2mTJpMp5oXmYAx1vxFl2Msap0UGG51C7Bh6mClB
         mSGBxtlUI9f3cvPm1WKXb5DJ5ZmiXHj/3/PeF6M4ccboPQastK/ZxJwYY14zpDZVz7Zz
         2L9SQNmLaeAlHx5P2e1hpZ/6tLv1csY+lJfVIEQYIRbqY93IiJEqn6S1XIrX3GxGUp7y
         NAiys9yU57OCy9/xFRyWRdKKf4ZZVGRZnhQIFfDhITGlqAlqvEcfBCKejbFkshmw31eS
         UTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706575433; x=1707180233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHeKi/dUeXjtXB5wLkxmt70n9tuYNx+1XqZWsLVWqa0=;
        b=qkMV7cuozgD3L8rCDc5rHXJR16NxrrMY9XcFK/JcQ2u+oWXHnAU1CkpAP5YFNkrt1M
         yqd3o39VliqQJ4s/QQF6hORAciLHKLjONU+Iw9efWpnlg3/rzgqq/MTUgOINz4iPO5fW
         Jr9Zpy0Vj0BRDWxXabHZDJ6qyFle9VbRtebWQ0GR6fL1Z/Yh7raivYM/AXUNNd5JCc0d
         J+CrW3Ut5iiD84cNpZNNx+5gxM3DM7GtUK+Z9FKHfwaiQH0ntvyxRj5GMbxwkX9r9Vkc
         AsAHXh6mM7Zmqkzn4US0MgtMw5R3WKoHD6OgRyNqgoLaYe02XXcNtVcv1lyuuAAmXAld
         0Y8A==
X-Gm-Message-State: AOJu0YxY0DF9HBlI+dIVeL/dVmP/cgtuLd7KuxzWLHUEj2yBvIspmINy
	lHyv4BNz3UAiSJlw9DeL55aTJy3X19+d6uy9Sd9dw27Bx9Tw6X1sVuBhZp1es8y6f+6SniXFNwN
	pGpKihyvdB+hrqtms/+KtMvBRT9g=
X-Google-Smtp-Source: AGHT+IHXmFdb0C8w30TFfeI7tu40TSaGjr1YyuaDtGDqJsV+QW/P6v/Pe/+1iacd4MI7Zn+fG+j8nLLNigjHbgQlkEk=
X-Received: by 2002:aa7:8c13:0:b0:6dd:dd42:bdef with SMTP id
 c19-20020aa78c13000000b006dddd42bdefmr3297835pfd.30.1706575432632; Mon, 29
 Jan 2024 16:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125231840.1647951-1-irogers@google.com>
In-Reply-To: <20240125231840.1647951-1-irogers@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jan 2024 16:43:40 -0800
Message-ID: <CAEf4BzamUW+O35hfj-SctPo0Z-oZk5u-96fvD0cFPDZTwFyiMg@mail.gmail.com>
Subject: Re: [PATCH v3] libbpf: Add some details for BTF parsing failures
To: Ian Rogers <irogers@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:18=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to find
> valid kernel BTF" message makes diagnosing the kernel build issue some
> what cryptic. Add a little more detail with the hope of helping users.
>
> Before:
> ```
> libbpf: failed to find valid kernel BTF
> libbpf: Error loading vmlinux BTF: -3
> ```
>
> After not accessible:
> ```
> libbpf: access to canonical vmlinux (/sys/kernel/btf/vmlinux) to load BTF=
 failed: No such file or directory
> libbpf: was CONFIG_DEBUG_INFO_BTF enabled?
> libbpf: failed to find valid kernel BTF
> libbpf: Error loading vmlinux BTF: -3
> ```
>
> After not readable:
> ```
> libbpf: unable to read canonical vmlinux (/sys/kernel/btf/vmlinux): Permi=
ssion denied
> libbpf: failed to find valid kernel BTF
> libbpf: Error loading vmlinux BTF: -3
> ```
>
> Closes: https://lore.kernel.org/bpf/CAP-5=3DfU+DN_+Y=3DY4gtELUsJxKNDDCOvJ=
zPHvjUVaUoeFAzNnig@mail.gmail.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
>
> ---
> v3. Try to address review comments from Andrii Nakryiko.

I did some further simplifications and clean ups while applying.

I dropped an extra faccessat(R_OK) check for /sys/kernel/btf/vmlinux
and instead if F_OK passes, just go ahead and try to parse
/sys/kernel/btf/vmlinux. If we have no access, we should get -EPERM or
-EACCESS (I didn't check which), otherwise we'll either parse or won't
find any BTF, both are errors. If /sys/kernel/btf/vmlinux exists,
there seems to be little point nowadays to try fallback locations,
kernel clearly is modern enough to generate /sys/kernel/btf/vmlinux,
so we just bail out with error.

Please check the landed commit in bpf-next and let me know if it
doesn't cover your use case properly.

> ---
>  tools/lib/bpf/btf.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ec92b87cae01..45983f42aba9 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4932,10 +4932,9 @@ static int btf_dedup_remap_types(struct btf_dedup =
*d)
>   */
>  struct btf *btf__load_vmlinux_btf(void)
>  {
> +       const char *canonical_vmlinux =3D "/sys/kernel/btf/vmlinux";
> +       /* fall back locations, trying to find vmlinux on disk */
>         const char *locations[] =3D {
> -               /* try canonical vmlinux BTF through sysfs first */
> -               "/sys/kernel/btf/vmlinux",
> -               /* fall back to trying to find vmlinux on disk otherwise =
*/
>                 "/boot/vmlinux-%1$s",
>                 "/lib/modules/%1$s/vmlinux-%1$s",
>                 "/lib/modules/%1$s/build/vmlinux",
> @@ -4946,14 +4945,34 @@ struct btf *btf__load_vmlinux_btf(void)
>         };
>         char path[PATH_MAX + 1];
>         struct utsname buf;
> -       struct btf *btf;
> +       struct btf *btf =3D NULL;
>         int i, err;
>
> -       uname(&buf);
> +       /* is canonical sysfs location accessible? */
> +       err =3D faccessat(AT_FDCWD, canonical_vmlinux, F_OK, AT_EACCESS);
> +       if (err) {
> +               pr_warn("access to canonical vmlinux (%s) to load BTF fai=
led: %s\n",
> +                       canonical_vmlinux, strerror(errno));
> +               pr_warn("was CONFIG_DEBUG_INFO_BTF enabled?\n");
> +       } else {
> +               err =3D faccessat(AT_FDCWD, canonical_vmlinux, R_OK, AT_E=
ACCESS);
> +               if (err) {
> +                       pr_warn("unable to read canonical vmlinux (%s): %=
s\n",
> +                               canonical_vmlinux, strerror(errno));
> +               }
> +       }
> +       if (!err) {
> +               /* load canonical and return any parsing failures */
> +               btf =3D btf__parse(canonical_vmlinux, NULL);
> +               err =3D libbpf_get_error(btf);
> +               pr_debug("loading kernel BTF '%s': %d\n", canonical_vmlin=
ux, err);
> +               return btf;
> +       }
>
> +       /* try fallback locations */
> +       uname(&buf);
>         for (i =3D 0; i < ARRAY_SIZE(locations); i++) {
>                 snprintf(path, PATH_MAX, locations[i], buf.release);
> -
>                 if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
>                         continue;
>
> @@ -4965,9 +4984,9 @@ struct btf *btf__load_vmlinux_btf(void)
>
>                 return btf;
>         }
> -
>         pr_warn("failed to find valid kernel BTF\n");
> -       return libbpf_err_ptr(-ESRCH);
> +       /* return the last error or ESRCH if no fallback locations were f=
ound */
> +       return btf ?: libbpf_err_ptr(-ESRCH);
>  }
>
>  struct btf *libbpf_find_kernel_btf(void) __attribute__((alias("btf__load=
_vmlinux_btf")));
> --
> 2.43.0.429.g432eaa2c6b-goog
>

