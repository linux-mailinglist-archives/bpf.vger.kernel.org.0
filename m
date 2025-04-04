Return-Path: <bpf+bounces-55345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4ECA7C246
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 19:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3FF1B608E0
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F41220F077;
	Fri,  4 Apr 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYhbvNu3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B930101EE
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787168; cv=none; b=OGq6bU8XrYy99+i4YyP6NgE4dLZfWXPDzJdlorQv3PrIVb/2M0lDFYivGm78eC/zWSVPjND9iu9W6Zc4Z3HzkiLgnx4MfrzouzrsKGsqDWnpElJRp/lZyC5nflk4DoVHG94fLAZ5yXgcPMrsWcniRIm+38BaMdV37qMV1rHobo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787168; c=relaxed/simple;
	bh=jrSAu1905NCKUql5l26XKIT0tdjDWCjk+eS5RB2efEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoWF64F9GzPtgMJm7Iu0PwpYJ9TNIy47FLFAywIiOfz/Rof0yVEZ8weiz3cg1gQ/5lq6hEFXmGxHRf7QbQ1sKd4Agu8DWuMjZggVKL0N1af76N2go2FPxIYQiI1DGmYX+WJksjUZQfkFRovzitf04l1LN7WQiXpkzoiTbavkhjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYhbvNu3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223fd89d036so27906495ad.1
        for <bpf@vger.kernel.org>; Fri, 04 Apr 2025 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743787166; x=1744391966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXefj7snqlGg3CUh1c0CK4R18FD5uae4w+/wLht38Ok=;
        b=VYhbvNu3zPo971Wx+LyWaBOb96zcUK1jVumPh+udEmwnCSCjlMHB3Q03fUkQ99h0Gp
         tETQALi29EWUj03Cf+cBlMorpmQLAh3NnAkPCABiA0Dndudnli0Fh3648EjTYjOdXI59
         LyWfVPPjnPmhUI+lIJFAiHa+87DSqXFPbJPElKO8CC0B5RgOKwBnyCHLG5bcvYRio3yz
         DrXKDGNf0aKQSzbvgFk21o+c+qeIgnnBaJqws5qfHF1sWhH4EoOLQrm+hrDe40f/9UCj
         tB9RSYU2NAWo0vkXqpaYobtENWFi96SKPfN72yVSNoSsXECBfwJorXKXRn+rY5QiRoHl
         5JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743787166; x=1744391966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXefj7snqlGg3CUh1c0CK4R18FD5uae4w+/wLht38Ok=;
        b=bIJeMO3GEeqdVuN3FU7jmclIfz4Q91U3LFDDKqbIk1zuiBFAPgsBV0/vdURfETHgxG
         1DGJvjBGT9KMDUcQzOYXiLLW0fhSUxUZa8CYdguq8CESvMvLdLecNojRa8i8h5+HhaL/
         HCfLWPoSkB8XrpUX5D3UGTizrkrnpjh7e6qdcpXmecIqUWZfWr/h1p+rxFRM0aWWjFM1
         Hjl5imrDu+b575SpDzOXuCH3tu8WPIXLUnOHKuA8SQJRL6SmW3jGZJcLEFLSw0zG0Hkx
         +DEVwZBQ8mtWErSaEmrgQMHuwlcfbeObwk1MuHHVaujIhjrZJDlc7Qh9V7tJxGSeW+Sj
         CPkw==
X-Gm-Message-State: AOJu0YySVOAd0fMIXid3CNPoM2KUN7z628mzVjVo9PUgxoKsXDXTjPLe
	vkveGBZGOFAdtHVkPp7O7mS9sJFrrtXXCaEyFQozF4hLt0elPlrzbBytP64JfzNFanPOTmJNgou
	7g3prZZFVCQikFQqhIR/H93ZjSlU=
X-Gm-Gg: ASbGncv0jX02O8vAcUh4YusVLRQVlFUFywsJKYAyJVHJ+izfutK2VuurT1k7qT/4cQ7
	/0C3slYtALwrLaHZ0QmLmXW0hCTV1B40MowAOmNuVNGShQ6NwrozUtjtUlm5WiI0g+mvGx0jGhL
	X4WdzcpOiPyje8KDfgdLhn3jGq3B3qW27Hlar1mFra/w==
X-Google-Smtp-Source: AGHT+IGW0jd1scy3aP/8jTjK6oeASG0gdsumnwYEyKN7cRSLlGHSakHnttd1F64qYqZdBBsVxRwt8mpRHCxinj7zQOg=
X-Received: by 2002:a17:903:2407:b0:224:93e:b5d7 with SMTP id
 d9443c01a7336-22a8a0a3601mr62795195ad.34.1743787166501; Fri, 04 Apr 2025
 10:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403222809.90634-1-mykyta.yatsenko5@gmail.com> <20250403222809.90634-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250403222809.90634-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Apr 2025 10:19:13 -0700
X-Gm-Features: AQ5f1JrzR9r4tpfjSv3TTSCmiNeWqT3f_6iY7eAQhsDWKQdcYrXGgeGVm3P_LE8
Message-ID: <CAEf4BzZKn-J=e0d0dSU-08XniQiYbgd=LAVNkTMXuDqALNqOhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: add BTF.ext line/func info
 getter tests
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 3:28=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add selftests checking that line and func info retrieved by newly added
> libbpf APIs are the same as returned by kernel via bpf_prog_get_info_by_f=
d.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../selftests/bpf/prog_tests/test_btf_ext.c   | 69 +++++++++++++++++++
>  .../selftests/bpf/progs/test_btf_ext.c        | 26 +++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_btf_ext.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c b/tool=
s/testing/selftests/bpf/prog_tests/test_btf_ext.c
> new file mode 100644
> index 000000000000..76d3eb520982
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms Inc. */
> +#include <test_progs.h>
> +#include "test_btf_ext.skel.h"
> +#include "btf_helpers.h"
> +
> +static void subtest_line_func_info(void)
> +{
> +       struct test_btf_ext *skel;
> +       struct bpf_prog_info info;
> +       struct bpf_line_info line_info[128], *libbpf_line_info;
> +       struct bpf_func_info func_info[128], *libbpf_func_info;
> +       __u32 info_len =3D sizeof(info), libbbpf_line_info_cnt, libbbpf_f=
unc_info_cnt;
> +       int err, fd;
> +
> +       skel =3D test_btf_ext__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +               return;
> +
> +       fd =3D bpf_program__fd(skel->progs.global_func);
> +
> +       memset(&info, 0, sizeof(info));
> +       info.line_info =3D ptr_to_u64(&line_info);
> +       info.nr_line_info =3D sizeof(line_info);
> +       info.line_info_rec_size =3D sizeof(*line_info);
> +       err =3D bpf_prog_get_info_by_fd(fd, &info, &info_len);
> +       if (!ASSERT_OK(err, "prog_line_info"))
> +               goto out;
> +
> +       libbpf_line_info =3D bpf_program__line_info(skel->progs.global_fu=
nc);
> +       libbbpf_line_info_cnt =3D bpf_program__line_info_cnt(skel->progs.=
global_func);
> +
> +       memset(&info, 0, sizeof(info));
> +       info.func_info =3D ptr_to_u64(&func_info);
> +       info.nr_func_info =3D sizeof(func_info);
> +       info.func_info_rec_size =3D sizeof(*func_info);
> +       err =3D bpf_prog_get_info_by_fd(fd, &info, &info_len);
> +       if (!ASSERT_OK(err, "prog_func_info"))
> +               goto out;
> +
> +       libbpf_func_info =3D bpf_program__func_info(skel->progs.global_fu=
nc);
> +       libbbpf_func_info_cnt =3D bpf_program__func_info_cnt(skel->progs.=
global_func);
> +
> +       if (!ASSERT_OK_PTR(libbpf_line_info, "bpf_program__line_info"))
> +               goto out;
> +       if (!ASSERT_EQ(libbbpf_line_info_cnt, info.nr_line_info, "line_in=
fo_cnt"))
> +               goto out;
> +       if (!ASSERT_OK_PTR(libbpf_func_info, "bpf_program__func_info"))
> +               goto out;
> +       if (!ASSERT_EQ(libbbpf_func_info_cnt, info.nr_func_info, "func_in=
fo_cnt"))
> +               goto out;
> +       /* Skip checks on s390x as it seems to be adding some preamble to=
 function entry point
> +        * shifting instruction offsets by 1 byte
> +        */
> +#if !defined(__TARGET_ARCH_s390) && !defined (__s390x__)
> +       ASSERT_MEMEQ(libbpf_line_info, line_info, libbbpf_line_info_cnt *=
 sizeof(*line_info),
> +                    "line_info");
> +       ASSERT_MEMEQ(libbpf_func_info, func_info, libbbpf_func_info_cnt *=
 sizeof(*func_info),
> +                    "func_info");
> +#endif
> +out:
> +       test_btf_ext__destroy(skel);
> +}
> +
> +void test_btf_ext(void)
> +{
> +       if (test__start_subtest("line_func_info"))
> +               subtest_line_func_info();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_btf_ext.c b/tools/tes=
ting/selftests/bpf/progs/test_btf_ext.c
> new file mode 100644
> index 000000000000..e4efcf823f6b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_btf_ext.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Meta Platforms Inc. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +__noinline static void f0(void)
> +{
> +       __u8 a =3D 1;

ok, so this will generate

       0:       b4 01 00 00 01 00 00 00 w1 =3D 0x1
       1:       73 1a ff ff 00 00 00 00 *(u8 *)(r10 - 0x1) =3D w1

And on s390x (and a bunch of other architectures), verifier will
inject extra special zero-extension instruction after `w1 =3D 0x1`,
which shifts all the instruction indices. You can look at how
bpf_jit_needs_zext() is defined and used in verifier.c, if you are
curious for details.

But given the purpose of the test is to make sure that libbpf gives us
full and correct information, all that zext business is a distraction
and we should just avoid all this.

So, let's just use full __u64 variables here and be done with this
(meaning, no s390x exceptions, just simple BPF code that doesn't get
enhanced or transformed by the verifier).

pw-bot: cr

> +       __u8 b =3D 2;
> +       __u8 c =3D 3;
> +
> +       __sink(a);
> +       __sink(b);
> +       __sink(c);
> +}
> +
> +SEC("xdp")
> +int global_func(struct xdp_md *xdp)
> +{
> +       f0();
> +       return XDP_DROP;
> +}
> --
> 2.49.0
>

