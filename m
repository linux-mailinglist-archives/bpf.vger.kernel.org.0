Return-Path: <bpf+bounces-20684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37656841B06
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 05:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8B6287365
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 04:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C277227469;
	Tue, 30 Jan 2024 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0hyPm3S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8111381A0;
	Tue, 30 Jan 2024 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706589222; cv=none; b=SPb2SAT0eK06XGN0a9Iz/t0VJ0td5I41WCMwAUpYFqMlpxCBMacVMKWs650gcz6YAH37CAlWWRz4+eS5OpAsLpVAGW2ABmtgoCApET1cg30N18TzzcxrStDCJKw4O4Awth5mr6WELZ8rSPCOue4Ln9HwKqVH+PR+BMLvLj4NGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706589222; c=relaxed/simple;
	bh=4xmj1Hzdic6MWvBh9li3zVR1n9IHgEuXj6F7wiqCG7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY1PNlmjdpzCV+QTD/l06Y3OilcPk8NJgZfL4/8QUmDIsq9JaSLhJHSGZed67Z4qJL33mSLaKKC4+BZU6bNWOZdmdtq5BeJAOhVoUCgSqlfZdY5cRDy46iukJQvWm5zL5B+dHeeeQ/UFgsc43+PUiuv4Xg2QIyzsEwIeoAuP9CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0hyPm3S; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28bec6ae0ffso1569970a91.3;
        Mon, 29 Jan 2024 20:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706589220; x=1707194020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMba2ef821AcCXVEXD0yPszqO5r9yHPKaxWiCBpxFI8=;
        b=B0hyPm3SPXPLULhIHiiK8Fqn7xvEV3QNCLmhaVLQM1zvnwAYrPDUNMNa33jxP9Xkry
         5Bx5Qqu8UX7BuqkFPhsaj2ItQp7kMbx1pTuexSYvAE4Sc9t0oh/RvD0Lz7/ce5jEsbkf
         OiOL+5gBqQYJmmqXFT9N96/P4+F6HwmhtcOFQo4LxHN3o3rFSRTr5gfaORwPBcUcHMVG
         WH1Nfe17264GoIX+uopFvNc7rBUSioDbgOzbFF7uebZ5CQZBQj1zxYhDj+9HrnzOwY6M
         tMCYGJZLCE5/s2wG3TVVWFmW3n/QY4HSHv+IHOKC/lqtz7j2FGjK3DHnseB7rikuMZrE
         d8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706589220; x=1707194020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMba2ef821AcCXVEXD0yPszqO5r9yHPKaxWiCBpxFI8=;
        b=aBNC9HMLdInC2OgpOKPGAOXiWmM1/YDlVVAuyh01ZA/RZkWKc5pim3jAfd4c325u1T
         SKTLBsRzk1Y9YyfNTTI+7IpLjvC7eDIE2X7zUP44PvjncV/subCjXuHptsfjBx/EitOp
         fOyZRsL4LZBZlYRRqutqIh7/tsrQfiyQKwzYshrOFiX6wixvry70EPzb4QFDOS9s2Lv0
         wrRRvCTUn/LizAZfFCFl9/aMNcepA2DWen7yrHcZqj2kVV7SgoOHKQIZ/3dQbbQNTEeT
         kJuHbgjp29iyDET0xsM7N7FeYrlE5Bx/EnJJ1evoORMEPLOOQ2Lw3hiDkz9HJcuXBusA
         qNsg==
X-Gm-Message-State: AOJu0YwrvLfhbMeHn3d51wue7Y68y7aSC/ZftrNGminsRu3ZTsFAsJeK
	IUqXZBUkdrSzhdT6qRRnLfVCNCx8hIZIwrzKoN4hYH+KlUEHrhXRhzS5YHTToL5MGYMNHjmud9Y
	evVC9WqC9JyGc4zbqF709DEwloV6xqJno
X-Google-Smtp-Source: AGHT+IEuAkRbFTB/NqonEi3Vokyw0yaIut1T1G44ypP8VLnKHxz1T5+tEBgGlb+qr0JAhmZVhn1OPBTzyctGCtZXm+8=
X-Received: by 2002:a17:90a:398d:b0:294:96d1:a665 with SMTP id
 z13-20020a17090a398d00b0029496d1a665mr3366893pjb.22.1706589219939; Mon, 29
 Jan 2024 20:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <373d86f4c26c0ebf5046b6627c8988fa75ea7a1d.1706492080.git.dxu@dxuuu.xyz>
In-Reply-To: <373d86f4c26c0ebf5046b6627c8988fa75ea7a1d.1706492080.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jan 2024 20:33:28 -0800
Message-ID: <CAEf4BzYr7dTuozxD72iuBr0yott7hKxB9SMb5nZe7Gr2mrrv2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Support dumping kfunc prototypes from BTF
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: quentin@isovalent.com, daniel@iogearbox.net, ast@kernel.org, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, olsajiri@gmail.com, 
	alan.maguire@oracle.com, memxor@gmail.com, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 5:35=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This patch enables dumping kfunc prototypes from bpftool. This is useful
> b/c with this patch, end users will no longer have to manually define
> kfunc prototypes. For the kernel tree, this also means we can drop
> kfunc prototypes from:
>
>         tools/testing/selftests/bpf/bpf_kfuncs.h
>         tools/testing/selftests/bpf/bpf_experimental.h
>
> Example usage:
>
>         $ make PAHOLE=3D/home/dxu/dev/pahole/build/pahole -j30 vmlinux
>
>         $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | =
rg "__ksym;" | head -3
>         extern void cgroup_rstat_updated(struct cgroup * cgrp, int cpu) _=
_ksym;
>         extern void cgroup_rstat_flush(struct cgroup * cgrp) __ksym;
>         extern struct bpf_key * bpf_lookup_user_key(u32 serial, u64 flags=
) __ksym;
>

All kfuncs have to be declared __weak, otherwise it will be impossible
to feature-detect them in BPF code

> Note that this patch is only effective after enabling pahole [0]
> and kernel [1] changes are merged.
>
> [0]: https://lore.kernel.org/bpf/0f25134ec999e368478c4ca993b3b729c2a03383=
.1706491733.git.dxu@dxuuu.xyz/
> [1]: https://lore.kernel.org/bpf/cover.1706491398.git.dxu@dxuuu.xyz/
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/bpf/bpftool/btf.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..9ab26ed12733 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -20,6 +20,8 @@
>  #include "json_writer.h"
>  #include "main.h"
>
> +#define KFUNC_DECL_TAG         "bpf_kfunc"
> +
>  static const char * const btf_kind_str[NR_BTF_KINDS] =3D {
>         [BTF_KIND_UNKN]         =3D "UNKNOWN",
>         [BTF_KIND_INT]          =3D "INT",
> @@ -454,6 +456,28 @@ static int dump_btf_raw(const struct btf *btf,
>         return 0;
>  }
>
> +static void dump_btf_kfuncs(const struct btf *btf)
> +{
> +       int cnt =3D btf__type_cnt(btf);
> +       int i;
> +
> +       for (i =3D 1; i < cnt; i++) {
> +               const struct btf_type *t =3D btf__type_by_id(btf, i);
> +               char kfunc_sig[1024];
> +               const char *name;
> +
> +               if (!btf_is_decl_tag(t))
> +                       continue;
> +
> +               name =3D btf__name_by_offset(btf, t->name_off);
> +               if (strncmp(name, KFUNC_DECL_TAG, sizeof(KFUNC_DECL_TAG))=
)
> +                       continue;
> +
> +               btf_dumper_type_only(btf, t->type, kfunc_sig, sizeof(kfun=
c_sig));
> +               printf("extern %s __ksym;\n\n", kfunc_sig);
> +       }
> +}
> +
>  static void __printf(2, 0) btf_dump_printf(void *ctx,
>                                            const char *fmt, va_list args)
>  {
> @@ -476,6 +500,9 @@ static int dump_btf_c(const struct btf *btf,
>         printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
>         printf("#pragma clang attribute push (__attribute__((preserve_acc=
ess_index)), apply_to =3D record)\n");
>         printf("#endif\n\n");
> +       printf("#ifndef __ksym\n");
> +       printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
> +       printf("#endif\n\n");
>
>         if (root_type_cnt) {
>                 for (i =3D 0; i < root_type_cnt; i++) {
> @@ -491,6 +518,8 @@ static int dump_btf_c(const struct btf *btf,
>                         if (err)
>                                 goto done;
>                 }
> +
> +               dump_btf_kfuncs(btf);
>         }
>
>         printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
> --
> 2.42.1
>

