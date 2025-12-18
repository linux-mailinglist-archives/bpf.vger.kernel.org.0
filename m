Return-Path: <bpf+bounces-77059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A58CCDE5D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E9F73022A8C
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E29A2F49F6;
	Thu, 18 Dec 2025 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAn1jIwb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D012BD022
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766099030; cv=none; b=JiNTdT82CTB91pjI1PPh9nBCHG3GLCtw0q7SnRYYii+l+DwkoONVCUpnLx0YnbEUp1pGpd7t5tD4vNFRmbzQRoOeSRbxmcSPSlfL4gTc1MZbu764b2JY4kIWidIrJQTGqlHayqPU8yInlzXKokwBR6Ld88J8j8ArM6HR1O0nVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766099030; c=relaxed/simple;
	bh=IpPnmCVR8865mF0ZO22sMZ7b/DHEeudl98cG9j5H+zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIkSesQ1cCg+cXxr6IYsI9lfjYpsMMAU80hXV2NBny4od/RRV53QctUUWWxPFrw9uhjSHBldSfHCBycrGMqOVf6zXcNWNLaYu0pLVDX+Jo5EM2GmpY2gtP317czjadC/XhH0nQPoCfBUe8x1Oun8K49t9fQ0KvSaesyTwO+8KMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAn1jIwb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c3259da34so1153806a91.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 15:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766099028; x=1766703828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92z5ydpmK4R2Zo/ahm72rSzgnvKW7m0sjY1q9ZorObQ=;
        b=OAn1jIwbN04SX/zhStFRQ6Nb8KWwz/mT1thWAd9k4Kqxc6RQKReMOFwHvLwMAUEF1Z
         QWpEYb5tC1l1XZT+jDGkLMZ94k5NXj2NYPgjSeerevhcI3hqtgvvfMV5l2TwXIgPF9QF
         KEdpxSq+6NapIW/CFtpSWQ8tZwjtkdeXyYPz5/2cRK6VItJlYsYxPw1XhMzQ7xS8TZq9
         Me6KwUz78Z2oYD6pVCBquREdG/x69Ep6axPD/msAGf1Mh2VrtCDExbyi43lE5oE+EszG
         23Y2pVMfzll66ycgBC7xcbPcylYLMVmJbk3tYcQMEdhGjRvvZFyvNiskXz7ZqSPpOmpa
         B66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766099028; x=1766703828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92z5ydpmK4R2Zo/ahm72rSzgnvKW7m0sjY1q9ZorObQ=;
        b=AnkHeDaX/GvWrxmXRSXF2NUQL8psrJ8X5pgn9Qk89z/qL18iU3qILjfwRpJlKByn9B
         jKffH/4QTseGM9g0+0+WzTDRUwwrW7Z1ODY6Vh1AB+ZQoUW7WV8Th7NwiI1nln4K1uL0
         hSCL5N8Xm3Q6ZhmAqG0cyyMiAcUYHg5jsxxLNtMg7i7hYB+ERN0dA7l/cbAaZ6UNJsJ2
         aIhCwbuUlr5FGRP2TTRoRidd5aGL82SZBA8n2BojgTDnTyXQaClimeJEZWYLQztFGOmd
         hT9jsF4shzE2Qj3Sk7u+CCAU31o7OT3kXLA4covVzG87rXirAqof+wrkumqp5qBLKu7g
         bzow==
X-Forwarded-Encrypted: i=1; AJvYcCUwrEBEl8BQ7UsHUTuwqjr7SXeD9gbAUA8P0r2bthiZX/yCbiYy2Y1L6Q0oN/qAFnNkYl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRgqGXymgIi2mv5WOBy/7joHXl3P6rQn15z++z+n2f2zeoSRmy
	uFFr8y38A6yTc0qQepHs0ECi74Gv6jKcoXU8V2cskDCREd6UsWkEwGaelwMCU6pFrwHh0tBcebz
	XsZOfwGtA7yxPVaVMZd54ZC985cZmS4E=
X-Gm-Gg: AY/fxX6t5BKv8kfQ4U3jGITQDaeVIXIC6Vylsg2l8J71siXdjHO6xi4HKM8Mj+d/eQO
	q5M1hPfDv6JYygqvz3VSmWL7IXz+OrQIEPhqC0aeTGRi6X4y29f9T0+DYbnaIfl1rpMJv71p4D2
	tItothMjcOkscL438OkG5qv2GNuc8Xte++otrCuT3+gKRX0EXEoT0bGams41s4Vil01qb8F+Rq3
	kH2JI+b5G5Z9cWeL+lHuldEi0Rh7htT24Dt3apaCmv3BQwdMyG5S0aqkNDzEhtAxo0evU/tlKgt
	jLh82K7MogQ=
X-Google-Smtp-Source: AGHT+IEiLDbrDyaP93nr3h+x473+xixMbHU9RZhNQ7ZGyCf5tixP6LWpEmv1cUjWSR2sB9rp0+jVQ+A6xzQrv+a5a80=
X-Received: by 2002:a17:90b:28ce:b0:33b:cfac:d5c6 with SMTP id
 98e67ed59e1d1-34e921d19b6mr626117a91.29.1766099028283; Thu, 18 Dec 2025
 15:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com> <20251218113051.455293-3-dolinux.peng@gmail.com>
In-Reply-To: <20251218113051.455293-3-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 15:03:35 -0800
X-Gm-Features: AQt7F2pj3QroQ8rNY5bHmDa4LEcTlz1N3_AjZzq7OhYZfi8izZ4I5_Ejir7cnsM
Message-ID: <CAEf4Bza6dwjDPNoCbgnrEsyaE-xGuxyNoOOsxySWmzuxWZd0Zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 02/13] selftests/bpf: Add test cases for
 btf__permute functionality
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> This patch introduces test cases for the btf__permute function to ensure
> it works correctly with both base BTF and split BTF scenarios.
>
> The test suite includes:
> - test_permute_base: Validates permutation on base BTF
> - test_permute_split: Tests permutation on split BTF
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/btf_permute.c    | 228 ++++++++++++++++++
>  1 file changed, 228 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools=
/testing/selftests/bpf/prog_tests/btf_permute.c
> new file mode 100644
> index 000000000000..9aa71cdf984a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Xiaomi */
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "btf_helpers.h"
> +
> +static void permute_base_check(struct btf *btf)
> +{
> +       VALIDATE_RAW_BTF(
> +               btf,
> +               "[1] STRUCT 's2' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D4 bits_offset=3D0",
> +               "[2] FUNC 'f' type_id=3D6 linkage=3Dstatic",
> +               "[3] PTR '(anon)' type_id=3D4",
> +               "[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> +               "[5] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D4 bits_offset=3D0",
> +               "[6] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1\n"
> +               "\t'p' type_id=3D3");
> +}
> +
> +/* Ensure btf__permute work as expected with base BTF */
> +static void test_permute_base(void)
> +{
> +       struct btf *btf;
> +       __u32 permute_ids[6];
> +       int start_id =3D 1;
> +       int err;
> +
> +       btf =3D btf__new_empty();
> +       if (!ASSERT_OK_PTR(btf, "empty_main_btf"))
> +               return;
> +
> +       btf__add_int(btf, "int", 4, BTF_INT_SIGNED);    /* [1] int */
> +       btf__add_ptr(btf, 1);                           /* [2] ptr to int=
 */
> +       btf__add_struct(btf, "s1", 4);                  /* [3] struct s1 =
{ */
> +       btf__add_field(btf, "m", 1, 0, 0);              /*       int m; *=
/
> +                                                       /* } */
> +       btf__add_struct(btf, "s2", 4);                  /* [4] struct s2 =
{ */
> +       btf__add_field(btf, "m", 1, 0, 0);              /*       int m; *=
/
> +                                                       /* } */
> +       btf__add_func_proto(btf, 1);                    /* [5] int (*)(in=
t *p); */
> +       btf__add_func_param(btf, "p", 2);
> +       btf__add_func(btf, "f", BTF_FUNC_STATIC, 5);    /* [6] int f(int =
*p); */
> +
> +       VALIDATE_RAW_BTF(
> +               btf,
> +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> +               "[2] PTR '(anon)' type_id=3D1",
> +               "[3] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D1 bits_offset=3D0",
> +               "[4] STRUCT 's2' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D1 bits_offset=3D0",
> +               "[5] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +               "\t'p' type_id=3D2",
> +               "[6] FUNC 'f' type_id=3D5 linkage=3Dstatic");
> +
> +       permute_ids[1 - start_id] =3D 4; /* [1] -> [4] */
> +       permute_ids[2 - start_id] =3D 3; /* [2] -> [3] */
> +       permute_ids[3 - start_id] =3D 5; /* [3] -> [5] */
> +       permute_ids[4 - start_id] =3D 1; /* [4] -> [1] */
> +       permute_ids[5 - start_id] =3D 6; /* [5] -> [6] */
> +       permute_ids[6 - start_id] =3D 2; /* [6] -> [2] */
> +       err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), N=
ULL);
> +       if (!ASSERT_OK(err, "btf__permute_base"))
> +               goto done;
> +       permute_base_check(btf);
> +
> +       /* id_map_cnt is invalid  */
> +       permute_ids[1 - start_id] =3D 4; /* [1] -> [4] */
> +       permute_ids[2 - start_id] =3D 3; /* [2] -> [3] */
> +       permute_ids[3 - start_id] =3D 5; /* [3] -> [5] */
> +       permute_ids[4 - start_id] =3D 1; /* [4] -> [1] */
> +       permute_ids[5 - start_id] =3D 6; /* [5] -> [6] */
> +       permute_ids[6 - start_id] =3D 2; /* [6] -> [2] */
> +       err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids) - =
1, NULL);
> +       if (!ASSERT_ERR(err, "btf__permute_base"))
> +               goto done;
> +       /* BTF is not modified */
> +       permute_base_check(btf);
> +
> +       /* Multiple types can not be mapped to the same ID */
> +       permute_ids[1 - start_id] =3D 4;
> +       permute_ids[2 - start_id] =3D 4;
> +       permute_ids[3 - start_id] =3D 5;
> +       permute_ids[4 - start_id] =3D 1;
> +       permute_ids[5 - start_id] =3D 6;
> +       permute_ids[6 - start_id] =3D 2;
> +       err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), N=
ULL);
> +       if (!ASSERT_ERR(err, "btf__permute_base"))
> +               goto done;
> +       /* BTF is not modified */
> +       permute_base_check(btf);
> +
> +       /* Type ID must be valid */
> +       permute_ids[1 - start_id] =3D 4;
> +       permute_ids[2 - start_id] =3D 3;
> +       permute_ids[3 - start_id] =3D 5;
> +       permute_ids[4 - start_id] =3D 1;
> +       permute_ids[5 - start_id] =3D 7;
> +       permute_ids[6 - start_id] =3D 2;

please make sure this base BTF test doesn't use start_id, see comment
on previous patch

> +       err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), N=
ULL);
> +       if (!ASSERT_ERR(err, "btf__permute_base"))
> +               goto done;
> +       /* BTF is not modified */
> +       permute_base_check(btf);
> +
> +done:
> +       btf__free(btf);
> +}
> +
> +static void permute_split_check(struct btf *btf)
> +{
> +       VALIDATE_RAW_BTF(
> +               btf,
> +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> +               "[2] PTR '(anon)' type_id=3D1",
> +               "[3] STRUCT 's2' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D1 bits_offset=3D0",
> +               "[4] FUNC 'f' type_id=3D5 linkage=3Dstatic",
> +               "[5] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +               "\t'p' type_id=3D2",
> +               "[6] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D1 bits_offset=3D0");
> +}
> +
> +/* Ensure btf__permute work as expected with split BTF */
> +static void test_permute_split(void)
> +{
> +       struct btf *split_btf =3D NULL, *base_btf =3D NULL;
> +       __u32 permute_ids[4];
> +       int err;
> +       int start_id;
> +
> +       base_btf =3D btf__new_empty();
> +       if (!ASSERT_OK_PTR(base_btf, "empty_main_btf"))
> +               return;
> +
> +       btf__add_int(base_btf, "int", 4, BTF_INT_SIGNED);       /* [1] in=
t */
> +       btf__add_ptr(base_btf, 1);                              /* [2] pt=
r to int */
> +       VALIDATE_RAW_BTF(
> +               base_btf,
> +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> +               "[2] PTR '(anon)' type_id=3D1");
> +       split_btf =3D btf__new_empty_split(base_btf);
> +       if (!ASSERT_OK_PTR(split_btf, "empty_split_btf"))
> +               goto cleanup;
> +       btf__add_struct(split_btf, "s1", 4);                    /* [3] st=
ruct s1 { */
> +       btf__add_field(split_btf, "m", 1, 0, 0);                /*   int =
m; */
> +                                                               /* } */
> +       btf__add_struct(split_btf, "s2", 4);                    /* [4] st=
ruct s2 { */
> +       btf__add_field(split_btf, "m", 1, 0, 0);                /*   int =
m; */
> +                                                               /* } */
> +       btf__add_func_proto(split_btf, 1);                      /* [5] in=
t (*)(int p); */
> +       btf__add_func_param(split_btf, "p", 2);
> +       btf__add_func(split_btf, "f", BTF_FUNC_STATIC, 5);      /* [6] in=
t f(int *p); */
> +
> +       VALIDATE_RAW_BTF(
> +               split_btf,
> +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> +               "[2] PTR '(anon)' type_id=3D1",
> +               "[3] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D1 bits_offset=3D0",
> +               "[4] STRUCT 's2' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D1 bits_offset=3D0",
> +               "[5] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +               "\t'p' type_id=3D2",
> +               "[6] FUNC 'f' type_id=3D5 linkage=3Dstatic");
> +
> +       start_id =3D btf__type_cnt(base_btf);
> +       permute_ids[3 - start_id] =3D 6; /* [3] -> [6] */
> +       permute_ids[4 - start_id] =3D 3; /* [4] -> [3] */
> +       permute_ids[5 - start_id] =3D 5; /* [5] -> [5] */
> +       permute_ids[6 - start_id] =3D 4; /* [6] -> [4] */
> +       err =3D btf__permute(split_btf, permute_ids, ARRAY_SIZE(permute_i=
ds), NULL);
> +       if (!ASSERT_OK(err, "btf__permute_split"))
> +               goto cleanup;
> +       permute_split_check(split_btf);
> +
> +       /*
> +        * For split BTF, id_map_cnt must equal to the number of types
> +        * added on top of base BTF
> +        */
> +       permute_ids[3 - start_id] =3D 4;
> +       permute_ids[4 - start_id] =3D 3;
> +       permute_ids[5 - start_id] =3D 5;
> +       permute_ids[6 - start_id] =3D 6;
> +       err =3D btf__permute(split_btf, permute_ids, 3, NULL);
> +       if (!ASSERT_ERR(err, "btf__permute_split"))
> +               goto cleanup;
> +       /* BTF is not modified */
> +       permute_split_check(split_btf);
> +
> +       /* Multiple types can not be mapped to the same ID */
> +       permute_ids[3 - start_id] =3D 4;
> +       permute_ids[4 - start_id] =3D 3;
> +       permute_ids[5 - start_id] =3D 3;
> +       permute_ids[6 - start_id] =3D 6;
> +       err =3D btf__permute(split_btf, permute_ids, 4, NULL);
> +       if (!ASSERT_ERR(err, "btf__permute_split"))
> +               goto cleanup;
> +       /* BTF is not modified */
> +       permute_split_check(split_btf);
> +
> +       /* Can not map to base ID */
> +       permute_ids[3 - start_id] =3D 4;
> +       permute_ids[4 - start_id] =3D 2;
> +       permute_ids[5 - start_id] =3D 5;
> +       permute_ids[6 - start_id] =3D 6;
> +       err =3D btf__permute(split_btf, permute_ids, 4, NULL);
> +       if (!ASSERT_ERR(err, "btf__permute_split"))
> +               goto cleanup;
> +       /* BTF is not modified */
> +       permute_split_check(split_btf);
> +
> +cleanup:
> +       btf__free(split_btf);
> +       btf__free(base_btf);
> +}
> +
> +void test_btf_permute(void)
> +{
> +       if (test__start_subtest("permute_base"))
> +               test_permute_base();
> +       if (test__start_subtest("permute_split"))
> +               test_permute_split();
> +}
> --
> 2.34.1
>

