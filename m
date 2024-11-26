Return-Path: <bpf+bounces-45637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E29D9DB9
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74DE2B2A728
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49F61DDC38;
	Tue, 26 Nov 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRf7eYIH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F021DDA0E
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647285; cv=none; b=Iki8zeXUQ1OBwMzgFXwJfR9o9WZsWZbcaDZm2seV4dYRTJnOBm5F3U3fVBjz8jmK3mCW9K8NUwu2Od2p7c9kYATriDWagiJrRzrUfe1H1O0cd7Abikf6l9/Dp5L0HEMBT3NiNp9eukElYW4yTWl7rLJdtz+1zLjMy9KDvYDRISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647285; c=relaxed/simple;
	bh=UMzT8RVf7FAedInYDjrgiuJw5UQz3JcB0Xc4NbaPtPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/wNYVHxVtHgfbEi7zGqVHtOn8C1ZDJxgmrwwl6dZaak/cMJMwiKg0YZVGWfZ0oG51FxhCWrdm29r0r5M19KYRcDmuRKlgPYVNiQd1avjEX8uGgKb0vUL+XUk0LqyxxWu6MRT7CHldorQd6Ks1DnDI69C3rS5qxFNwzhm8t6dYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRf7eYIH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ea4e9e6ef2so4739690a91.1
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 10:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732647283; x=1733252083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+GuYExwT+eS2uVxkt8Aaw/9nWhzQgQNg4GMg2mit9A=;
        b=HRf7eYIH51fTiaTlLaYjym9burMr7Jl6cJ/nf3RmD9ooRf/SVrh4Md31rNZe+eKXC1
         L30E0liIkK7OXRyFqJtCLg90D5H04S7Sn4X/uKLwuNKakQJsxiX4O3JOQR8yRWoZyLH0
         DDE6V6cS8/Yt4NR5yTF3GfefXP3s4IT99edFhqoEbyo1rSYz2qM60O7W+98SKZdAcK8P
         Xjw61zDoaAyrUz0KiAd1kMbC5IZL8KvdEXOeCtF1e7CvEGRRj2yUp6mLOaE1YdmU2iC8
         BksAdsYMx3UKml++rFBQUud/34E4V7rS/Hjxtf7yZw12bVSnkKOiAnoSZdGRIpREFUIp
         N91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732647283; x=1733252083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+GuYExwT+eS2uVxkt8Aaw/9nWhzQgQNg4GMg2mit9A=;
        b=qSENlagMdc8B93//pbdkfVHK988676h3bSqHt/A+cl0yx9x02M6lCBaAReSKgb1R4V
         WII6Ef2rkLBCgruHYJ1cHtHCNwpRMvleIgt84ahWiEzER0kVewA3k6hmC9rjNtdvCtdQ
         NiIPpsFnQW1P467hC+NW5myw7Jk0ILW4EXOg93ejClQ9h4JSi+qL7Jvn8KpiwKjyDYMT
         exSe6W0A5usdzcGNGrPdPRpdXlaO0k8DUvCSDc8gG2yEBkagrSwfFHL2y4n7l0sNSvMl
         UNvpSq1fATq0/IaztOQsOoZm0NOZXsa1hTdJfvVVIOhMqOck4238eAe8ZAReYN8bUMS1
         C9JA==
X-Gm-Message-State: AOJu0YzqoWP7Mf/AG3sxV8UdRJXmjOAC9Eg7A5AXOrdgSke4F3ym7nkS
	JlnZ/O+7WG90Kls2rlg3ZCP/KknJ4qt7PMAKGm57ddkYiM0i1rKUEYqeAthBFoJbyTovRrDycvf
	3eS72BwS61hpK1/pd1lx+uZi+ZDk+FQ==
X-Gm-Gg: ASbGnctVdFNW7gU/wrV58KDSSA80NKxraLaJatM/t1JF3j2aNtN90niyT+9SI+dNB/Y
	SDRWWwcbC1715cIzUckWnY1dSGqgUYlWejqe7tK+ZF/qEK7Q=
X-Google-Smtp-Source: AGHT+IHyTWy2K5L/DdpxSTWdbXF3WRVbQUvTiQMGkO+oEFSot0/lDd8VZo2YGggrR+116Ft+BRDhPmdXZKrjLAxnITQ=
X-Received: by 2002:a17:90b:3c48:b0:2ea:8aac:6ac8 with SMTP id
 98e67ed59e1d1-2ee08eb5df7mr455435a91.13.1732647283192; Tue, 26 Nov 2024
 10:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119101552.505650-1-aspsk@isovalent.com> <20241119101552.505650-5-aspsk@isovalent.com>
In-Reply-To: <20241119101552.505650-5-aspsk@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 10:54:31 -0800
Message-ID: <CAEf4BzbnAT1v5aEdDtvkOC5hf6bqgnZmmjygHd_5j_dnxv1dZw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add tests for fd_array_cnt
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 2:13=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> Add a new set of tests to test the new field in PROG_LOAD-related
> part of bpf_attr: fd_array_cnt.
>
> Add the following test cases:
>
>   * fd_array_cnt/no-fd-array: program is loaded in a normal
>     way, without any fd_array present
>
>   * fd_array_cnt/fd-array-ok: pass two extra non-used maps,
>     check that they're bound to the program
>
>   * fd_array_cnt/fd-array-dup-input: pass a few extra maps,
>     only two of which are unique
>
>   * fd_array_cnt/fd-array-ref-maps-in-array: pass a map in
>     fd_array which is also referenced from within the program
>
>   * fd_array_cnt/fd-array-trash-input: pass array with some trash
>
>   * fd_array_cnt/fd-array-with-holes: pass an array with holes (fd=3D0)
>
>   * fd_array_cnt/fd-array-2big: pass too large array
>
> All the tests above are using the bpf(2) syscall directly,
> no libbpf involved.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  .../selftests/bpf/prog_tests/fd_array.c       | 381 ++++++++++++++++++
>  1 file changed, 381 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tools/te=
sting/selftests/bpf/prog_tests/fd_array.c
> new file mode 100644
> index 000000000000..1b47386e66c3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
> @@ -0,0 +1,381 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +
> +#include <linux/btf.h>
> +#include <sys/syscall.h>
> +#include <bpf/bpf.h>
> +
> +#include "../test_btf.h"
> +
> +static inline int _bpf_map_create(void)
> +{
> +       static union bpf_attr attr =3D {
> +               .map_type =3D BPF_MAP_TYPE_ARRAY,
> +               .key_size =3D 4,
> +               .value_size =3D 8,
> +               .max_entries =3D 1,
> +       };
> +
> +       return syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
> +}

libbpf provides bpf_map_create() API. Please use that (and make sure
it supports the new field as well), don't re-define your own wrappers.

> +
> +static int _btf_create(void)
> +{
> +       struct btf_blob {
> +               struct btf_header btf_hdr;
> +               __u32 types[8];
> +               __u32 str;
> +       } raw_btf =3D {
> +               .btf_hdr =3D {
> +                       .magic =3D BTF_MAGIC,
> +                       .version =3D BTF_VERSION,
> +                       .hdr_len =3D sizeof(struct btf_header),
> +                       .type_len =3D sizeof(raw_btf.types),
> +                       .str_off =3D offsetof(struct btf_blob, str) - off=
setof(struct btf_blob, types),
> +                       .str_len =3D sizeof(raw_btf.str),
> +               },
> +               .types =3D {
> +                       /* long */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),  /=
* [1] */
> +                       /* unsigned long */
> +                       BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),  /* [2] */
> +               },
> +       };
> +       static union bpf_attr attr =3D {
> +               .btf_size =3D sizeof(raw_btf),
> +       };
> +
> +       attr.btf =3D (long)&raw_btf;
> +
> +       return syscall(__NR_bpf, BPF_BTF_LOAD, &attr, sizeof(attr));

ditto, libbpf provides low-level API wrappers for a reason, let's tick to t=
hem

> +}
> +
> +static bool map_exists(__u32 id)
> +{
> +       int fd;
> +
> +       fd =3D bpf_map_get_fd_by_id(id);
> +       if (fd >=3D 0) {
> +               close(fd);
> +               return true;
> +       }
> +       return false;
> +}
> +
> +static inline int bpf_prog_get_map_ids(int prog_fd, __u32 *nr_map_ids, _=
_u32 *map_ids)
> +{
> +       __u32 len =3D sizeof(struct bpf_prog_info);
> +       struct bpf_prog_info info =3D {
> +               .nr_map_ids =3D *nr_map_ids,
> +               .map_ids =3D ptr_to_u64(map_ids),
> +       };
> +       int err;
> +
> +       err =3D bpf_prog_get_info_by_fd(prog_fd, &info, &len);
> +       if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
> +               return -1;
> +
> +       *nr_map_ids =3D info.nr_map_ids;
> +
> +       return 0;
> +}
> +
> +static int __load_test_prog(int map_fd, int *fd_array, int fd_array_cnt)
> +{
> +       /* A trivial program which uses one map */
> +       struct bpf_insn insns[] =3D {
> +               BPF_LD_MAP_FD(BPF_REG_1, map_fd),
> +               BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +               BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +               BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lo=
okup_elem),
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       union bpf_attr attr =3D {
> +               .prog_type =3D BPF_PROG_TYPE_XDP, /* we don't care */
> +               .insns     =3D ptr_to_u64(insns),
> +               .insn_cnt  =3D ARRAY_SIZE(insns),
> +               .license   =3D ptr_to_u64("GPL"),
> +               .fd_array =3D ptr_to_u64(fd_array),
> +               .fd_array_cnt =3D fd_array_cnt,
> +       };
> +
> +       return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));

bpf_prog_load() API

> +}
> +
> +static int load_test_prog(int *fd_array, int fd_array_cnt)
> +{
> +       int map_fd;
> +       int ret;
> +
> +       map_fd =3D _bpf_map_create();
> +       if (!ASSERT_GE(map_fd, 0, "_bpf_map_create"))
> +               return map_fd;
> +
> +       ret =3D __load_test_prog(map_fd, fd_array, fd_array_cnt);
> +       close(map_fd);
> +
> +       /* switch back to returning the actual value */
> +       if (ret < 0)
> +               return -errno;
> +       return ret;
> +}
> +

[...]

