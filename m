Return-Path: <bpf+bounces-75046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C96BC6CC64
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 05:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26BD04EE982
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CEB30C358;
	Wed, 19 Nov 2025 04:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFauJgPM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1B307AC5
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763527893; cv=none; b=ZkZTa+oM1FjFJFp6eBR9Hc3M4wUrVTEnZnuAE30oYtPFI1MoJe2Kz0D3Xzp6vziWXwhA+08VCW0o9JeAZhV9oM+8obQIQa28uIWXGoEhWAquAcb1kLmxj0/oQr847c9n+qF13O2wzoWsBQpQUoEqaDnYdUMJrUP7djp2BgST5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763527893; c=relaxed/simple;
	bh=4b59XX2O6l1eV9O/A8/CSZOTVeILEcjIzj1qJQEbqIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK91Dizg1H9il61RAtouVKRbKYOIS1QH9wIlO8FthdIEhPJOsbviecoV3RvxGER+NHSikWUymW2fbUdGerOwQrKuk9IcoLKC3AH+y7Krd18h6PbDMKYpR7g67LS86aJ8V4Zl5ASKSqlfns/r+JfTXBVaf984om5LveNoLdrNCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFauJgPM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso11707821a12.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 20:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763527889; x=1764132689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH429UakNOgSIbRViyznVNxfQo4fQZGbLL01ovZkDbU=;
        b=hFauJgPMzy220Yg7KvldkAV3fWSS+GU1mB/IFckkQmM4/XHVaXPxOdl5zqALBjfHST
         QTjYlwgUtT8CAnRZDati0vwuE6moXctHHbElPDp6orgEiXhAopQflh1n650RMP6WWCWV
         1HsRHxMIgNlGxywMe80k63nDk9ilnYq1yKqGVffYctZrlo3LysEsuDpq7ucLlXPWWoh6
         4TqnZ7xdne0d/w0WAGBDdq7uYbW8EThDYGVvbMPYV2jauvpyQBGRAs7myVUpwQliK0dh
         4zKcPkiASk+VhcZpC9aAdt47tDpjPSLl/Y1b3gh8NpwqXcJ+kOZS8VGjs75bgP5/hkdX
         jeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763527889; x=1764132689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oH429UakNOgSIbRViyznVNxfQo4fQZGbLL01ovZkDbU=;
        b=Mb5RPS9k75vPT7Y9eohKzT9OPkgluIc7I1U87ZunnnkqOsBcUuspHyJXZstO/gnCBr
         sNSLR61XicHNhsxp8+dWYQrrUltsyA8QwW5/3QPRqvZFsvh3xdLGDrZLF48HDbRZtm3M
         VtYEHIGkdiz9KemuQw0ZrpKA8fhy0DwTU+PAH8oXjzXs7aDKR8ScB3JwixAxXADu0c1u
         Gz/KZJtFvPdgO63HrckIwNGVOLPlnRyaTA7mMngLDVWGKHav1nyMMX3aOudAuF0BZBzB
         fSZaIzcacOBacjGnsuEW2zrRWC48wUK5+QDqF5nA6jz5F2FqIfjcXPLATSJ/HMrp0pSm
         o3pw==
X-Forwarded-Encrypted: i=1; AJvYcCWeLe1o10saghO4LkD3nJQhSTXV9kr10GGsWA1b1gg34xMSydbiAeGe/4+2ifZfgBLPdL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWo8T7WfBDJLh7589T9tDjIhdhnkZTyt/ziM8mJS4rzoZt4SSu
	QO5g/371FdiXZvBZQ0WgYmqtaDgsh/1/g4USpk39aPBjC7hkqsOgB3LVZZM3G2859eVBm9Lmvls
	8p2QzSJ0lZ3Fs0Pb5njzISIxXI7OeXIA=
X-Gm-Gg: ASbGncun4VdxbFWycaDwvWPQXzFSbK6bbzjdwHvlSvEttdCMa2hXdnGOOijyil5ZZN7
	rskrqgabSIcanixUUT70tx+AtBAHGD5P1qmBTQZQAXVeHKG+eYSh3YAOyt2EelWhkDfBxvv+Hc9
	Ks2UvlpvMpazdGvPbOOvYCIWh0r+OiKA1Z/3v/bOjpIiBFNX1fEkyJPDh+bATWSOyOSFaJSLrcJ
	3UqfW+wgTZiGxwa9H336njrwFVIn0ddNQQjl4E1Ip3KdzPqLw9/ecDdIG4tJ9zLyMgApODn
X-Google-Smtp-Source: AGHT+IHZ+EL3t2ci/1+0Ctzz3H29VwiBWRlpUl1GLlAGPvZv30HP5WOqiWw4V19GgCh7KEJSgNiImHHVyJ0Vbyx3ook=
X-Received: by 2002:a17:907:1c96:b0:b73:39c3:b4f with SMTP id
 a640c23a62f3a-b7367be02a8mr1900357966b.50.1763527889111; Tue, 18 Nov 2025
 20:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com> <20251119031531.1817099-3-dolinux.peng@gmail.com>
In-Reply-To: <20251119031531.1817099-3-dolinux.peng@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 19 Nov 2025 12:51:17 +0800
X-Gm-Features: AWmQ_bleDEEwe20MSFwp5Q20M7cj14RqXFyrx9EaupzGmC2gV1eFhBx-f5lAw7E
Message-ID: <CAErzpmszcJFbvHar0hVoxOh40ftJzYVUQP1d=Pff9cuRPGo6jA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 2/7] selftests/bpf: Add test cases for btf__permute functionality
To: ast@kernel.org, andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 11:21=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
>
> From: Donglin Peng <pengdonglin@xiaomi.com>
>
> This patch introduces test cases for the btf__permute function to ensure
> it works correctly with both base BTF and split BTF scenarios.
>
> The test suite includes:
> - test_permute_base: Validates permutation on base BTF
> - test_permute_split: Tests permutation on split BTF
> - test_permute_drop_base: Validates type dropping on base BTF
> - test_permute_drop_split: Tests type dropping on split BTF
> - test_permute_drop_dedup: Tests type dropping and deduping
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
>  .../selftests/bpf/prog_tests/btf_permute.c    | 608 ++++++++++++++++++
>  1 file changed, 608 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools=
/testing/selftests/bpf/prog_tests/btf_permute.c
> new file mode 100644
> index 000000000000..f67bf89519b3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
> @@ -0,0 +1,608 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Xiaomi */
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "btf_helpers.h"
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
> +
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
> +
> +       /*
> +        * For base BTF, id_map_cnt must equal to the number of types
> +        * include VOID type
> +        */

My bad. I will remove those comments.

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
> +
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
> +
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
> +
> +       /* Type ID must be valid */
> +       permute_ids[1 - start_id] =3D 4;
> +       permute_ids[2 - start_id] =3D 3;
> +       permute_ids[3 - start_id] =3D 5;
> +       permute_ids[4 - start_id] =3D 1;
> +       permute_ids[5 - start_id] =3D 7;
> +       permute_ids[6 - start_id] =3D 2;
> +       err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), N=
ULL);
> +       if (!ASSERT_ERR(err, "btf__permute_base"))
> +               goto done;
> +
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
> +
> +done:
> +       btf__free(btf);
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
> +
> +       VALIDATE_RAW_BTF(
> +               split_btf,
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
> +
> +       VALIDATE_RAW_BTF(
> +               split_btf,
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
> +
> +       /* Multiple types can not be mapped to the same ID */
> +       permute_ids[3 - start_id] =3D 4;
> +       permute_ids[4 - start_id] =3D 3;
> +       permute_ids[5 - start_id] =3D 3;
> +       permute_ids[6 - start_id] =3D 6;
> +       err =3D btf__permute(split_btf, permute_ids, 4, NULL);
> +       if (!ASSERT_ERR(err, "btf__permute_split"))
> +               goto cleanup;
> +
> +       VALIDATE_RAW_BTF(
> +               split_btf,
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
> +
> +       /* Can not map to base ID */
> +       permute_ids[3 - start_id] =3D 4;
> +       permute_ids[4 - start_id] =3D 2;
> +       permute_ids[5 - start_id] =3D 5;
> +       permute_ids[6 - start_id] =3D 6;
> +       err =3D btf__permute(split_btf, permute_ids, 4, NULL);
> +       if (!ASSERT_ERR(err, "btf__permute_split"))
> +               goto cleanup;
> +
> +       VALIDATE_RAW_BTF(
> +               split_btf,
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
> +
> +cleanup:
> +       btf__free(split_btf);
> +       btf__free(base_btf);
> +}
> +
> +/* Verify btf__permute function drops types correctly with base_btf */
> +static void test_permute_drop_base(void)
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
> +       /* Drop ID 4 */
> +       permute_ids[1 - start_id] =3D 5; /* [1] -> [5] */
> +       permute_ids[2 - start_id] =3D 1; /* [2] -> [1] */
> +       permute_ids[3 - start_id] =3D 2; /* [3] -> [2] */
> +       permute_ids[4 - start_id] =3D 0; /* Drop [4] */
> +       permute_ids[5 - start_id] =3D 3; /* [5] -> [3] */
> +       permute_ids[6 - start_id] =3D 4; /* [6] -> [4] */
> +       err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), N=
ULL);
> +       if (!ASSERT_OK(err, "btf__permute_drop_base"))
> +               goto done;
> +
> +       VALIDATE_RAW_BTF(
> +               btf,
> +               "[1] PTR '(anon)' type_id=3D5",
> +               "[2] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D5 bits_offset=3D0",
> +               "[3] FUNC_PROTO '(anon)' ret_type_id=3D5 vlen=3D1\n"
> +               "\t'p' type_id=3D1",
> +               "[4] FUNC 'f' type_id=3D3 linkage=3Dstatic",
> +               "[5] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED");
> +
> +       /* Continue dropping */
> +       permute_ids[1 - start_id] =3D 1; /* [1] -> [1] */
> +       permute_ids[2 - start_id] =3D 2; /* [2] -> [2] */
> +       permute_ids[3 - start_id] =3D 3; /* [3] -> [3] */
> +       permute_ids[4 - start_id] =3D 0; /* Drop [4] */
> +       permute_ids[5 - start_id] =3D 4; /* [5] -> [4] */
> +       err =3D btf__permute(btf, permute_ids, 5, NULL);
> +       if (!ASSERT_OK(err, "btf__permute_drop_base_fail"))
> +               goto done;
> +
> +
> +       VALIDATE_RAW_BTF(
> +               btf,
> +               "[1] PTR '(anon)' type_id=3D4",
> +               "[2] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D4 bits_offset=3D0",
> +               "[3] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1\n"
> +               "\t'p' type_id=3D1",
> +               "[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED");
> +
> +       /* Cannot drop the ID referenced by others */
> +       permute_ids[1 - start_id] =3D 2;
> +       permute_ids[2 - start_id] =3D 3;
> +       permute_ids[3 - start_id] =3D 1;
> +       permute_ids[4 - start_id] =3D 0; /* [4] is referenced by others *=
/
> +       err =3D btf__permute(btf, permute_ids, 4, NULL);
> +       if (!ASSERT_ERR(err, "btf__permute_drop_base_fail"))
> +               goto done;
> +
> +       VALIDATE_RAW_BTF(
> +               btf,
> +               "[1] PTR '(anon)' type_id=3D4",
> +               "[2] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D4 bits_offset=3D0",
> +               "[3] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1\n"
> +               "\t'p' type_id=3D1",
> +               "[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED");
> +
> +       /* Drop 2 IDs at once */
> +       permute_ids[1 - start_id] =3D 2; /* [1] -> [2] */
> +       permute_ids[2 - start_id] =3D 0; /* Drop [2] */
> +       permute_ids[3 - start_id] =3D 0; /* Drop [3] */
> +       permute_ids[4 - start_id] =3D 1; /* [4] -> [1] */
> +       err =3D btf__permute(btf, permute_ids, 4, NULL);
> +       if (!ASSERT_OK(err, "btf__permute_drop_base_fail"))
> +               goto done;
> +
> +       VALIDATE_RAW_BTF(
> +               btf,
> +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> +               "[2] PTR '(anon)' type_id=3D1");
> +
> +       /* Drop all IDs */
> +       permute_ids[1 - start_id] =3D 0; /* Drop [1] */
> +       permute_ids[2 - start_id] =3D 0; /* Drop [2] */
> +       err =3D btf__permute(btf, permute_ids, 2, NULL);
> +       if (!ASSERT_OK(err, "btf__permute_drop_base_fail"))
> +               goto done;
> +       if (!ASSERT_EQ(btf__type_cnt(btf), 1, "btf__permute_drop_base all=
"))
> +               goto done;
> +
> +done:
> +       btf__free(btf);
> +}
> +
> +/* Verify btf__permute function drops types correctly with split BTF */
> +static void test_permute_drop_split(void)
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
> +
> +       /* Drop ID 4 */
> +       permute_ids[3 - start_id] =3D 5; /* [3] -> [5] */
> +       permute_ids[4 - start_id] =3D 0; /* Drop [4] */
> +       permute_ids[5 - start_id] =3D 3; /* [5] -> [3] */
> +       permute_ids[6 - start_id] =3D 4; /* [6] -> [4] */
> +       err =3D btf__permute(split_btf, permute_ids, ARRAY_SIZE(permute_i=
ds), NULL);
> +       if (!ASSERT_OK(err, "btf__permute_drop_split"))
> +               goto cleanup;
> +
> +       VALIDATE_RAW_BTF(
> +               split_btf,
> +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> +               "[2] PTR '(anon)' type_id=3D1",
> +               "[3] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +               "\t'p' type_id=3D2",
> +               "[4] FUNC 'f' type_id=3D3 linkage=3Dstatic",
> +               "[5] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D1 bits_offset=3D0");
> +
> +       /* Can not drop the type referenced by others */
> +       permute_ids[3 - start_id] =3D 0; /* [3] is referenced by [4] */
> +       permute_ids[4 - start_id] =3D 4;
> +       permute_ids[5 - start_id] =3D 3;
> +       err =3D btf__permute(split_btf, permute_ids, 3, NULL);
> +       if (!ASSERT_ERR(err, "btf__permute_drop_split"))
> +               goto cleanup;
> +
> +       VALIDATE_RAW_BTF(
> +               split_btf,
> +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> +               "[2] PTR '(anon)' type_id=3D1",
> +               "[3] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +               "\t'p' type_id=3D2",
> +               "[4] FUNC 'f' type_id=3D3 linkage=3Dstatic",
> +               "[5] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D1 bits_offset=3D0");
> +
> +       /* Continue dropping */
> +       permute_ids[3 - start_id] =3D 0; /* Drop [3] */
> +       permute_ids[4 - start_id] =3D 0; /* Drop [4] */
> +       permute_ids[5 - start_id] =3D 3; /* [5] -> [3] */
> +       err =3D btf__permute(split_btf, permute_ids, 3, NULL);
> +       if (!ASSERT_OK(err, "btf__permute_drop_split"))
> +               goto cleanup;
> +
> +       VALIDATE_RAW_BTF(
> +               split_btf,
> +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> +               "[2] PTR '(anon)' type_id=3D1",
> +               "[3] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D1 bits_offset=3D0");
> +
> +       /* Continue dropping */
> +       permute_ids[3 - start_id] =3D 0; /* Drop [3] */
> +       err =3D btf__permute(split_btf, permute_ids, 1, NULL);
> +       if (!ASSERT_OK(err, "btf__permute_drop_split"))
> +               goto cleanup;
> +
> +       VALIDATE_RAW_BTF(
> +               split_btf,
> +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> +               "[2] PTR '(anon)' type_id=3D1");
> +
> +cleanup:
> +       btf__free(split_btf);
> +       btf__free(base_btf);
> +}
> +
> +/* Verify btf__permute then btf__dedup work correctly */
> +static void test_permute_drop_dedup(void)
> +{
> +       struct btf *btf, *new_btf =3D NULL;
> +       const struct btf_header *hdr;
> +       const void *btf_data;
> +       char expect_strs[] =3D "\0int\0s1\0m\0tag1\0tag2\0tag3";
> +       char expect_strs_dedupped[] =3D "\0int\0s1\0m\0tag1";
> +       __u32 permute_ids[5], btf_size;
> +       int start_id =3D 1;
> +       int err;
> +
> +       btf =3D btf__new_empty();
> +       if (!ASSERT_OK_PTR(btf, "empty_main_btf"))
> +               return;
> +
> +       btf__add_int(btf, "int", 4, BTF_INT_SIGNED);    /* [1] int */
> +       btf__add_struct(btf, "s1", 4);                  /* [2] struct s1 =
{ */
> +       btf__add_field(btf, "m", 1, 0, 0);              /*       int m; *=
/
> +                                                       /* } */
> +       btf__add_decl_tag(btf, "tag1", 2, -1);          /* [3] tag -> s1:=
 tag1 */
> +       btf__add_decl_tag(btf, "tag2", 2, 1);           /* [4] tag -> s1/=
m: tag2 */
> +       btf__add_decl_tag(btf, "tag3", 2, 1);           /* [5] tag -> s1/=
m: tag3 */
> +
> +       VALIDATE_RAW_BTF(
> +               btf,
> +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> +               "[2] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D1 bits_offset=3D0",
> +               "[3] DECL_TAG 'tag1' type_id=3D2 component_idx=3D-1",
> +               "[4] DECL_TAG 'tag2' type_id=3D2 component_idx=3D1",
> +               "[5] DECL_TAG 'tag3' type_id=3D2 component_idx=3D1");
> +
> +       btf_data =3D btf__raw_data(btf, &btf_size);
> +       if (!ASSERT_OK_PTR(btf_data, "btf__raw_data"))
> +               goto done;
> +       hdr =3D btf_data;
> +       if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs), "expect_str=
s"))
> +               goto done;
> +
> +       new_btf =3D btf__new(btf_data, btf_size);
> +       if (!ASSERT_OK_PTR(new_btf, "btf__new"))
> +               goto done;
> +
> +       /* Drop 2 IDs result in unreferenced strings */
> +       permute_ids[1 - start_id] =3D 3; /* [1] -> [3] */
> +       permute_ids[2 - start_id] =3D 1; /* [2] -> [1] */
> +       permute_ids[3 - start_id] =3D 2; /* [3] -> [2] */
> +       permute_ids[4 - start_id] =3D 0; /* Drop result in unreferenced "=
tag2" */
> +       permute_ids[5 - start_id] =3D 0; /* Drop result in unreferenced "=
tag3" */
> +       err =3D btf__permute(new_btf, permute_ids, 5, NULL);
> +       if (!ASSERT_OK(err, "btf__permute"))
> +               goto done;
> +
> +       VALIDATE_RAW_BTF(
> +               new_btf,
> +               "[1] STRUCT 's1' size=3D4 vlen=3D1\n"
> +               "\t'm' type_id=3D3 bits_offset=3D0",
> +               "[2] DECL_TAG 'tag1' type_id=3D1 component_idx=3D-1",
> +               "[3] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED");
> +
> +       btf_data =3D btf__raw_data(new_btf, &btf_size);
> +       if (!ASSERT_OK_PTR(btf_data, "btf__raw_data"))
> +               goto done;
> +       hdr =3D btf_data;
> +       if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs), "expect_str=
s"))
> +               goto done;
> +
> +       err =3D btf__dedup(new_btf, NULL);
> +       if (!ASSERT_OK(err, "btf__dedup"))
> +               goto done;
> +
> +       btf_data =3D btf__raw_data(new_btf, &btf_size);
> +       if (!ASSERT_OK_PTR(btf_data, "btf__raw_data"))
> +               goto done;
> +       hdr =3D btf_data;
> +       if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs_dedupped), "e=
xpect_strs_dedupped"))
> +               goto done;
> +
> +done:
> +       btf__free(btf);
> +       btf__free(new_btf);
> +}
> +
> +void test_btf_permute(void)
> +{
> +       if (test__start_subtest("permute_base"))
> +               test_permute_base();
> +       if (test__start_subtest("permute_split"))
> +               test_permute_split();
> +       if (test__start_subtest("permute_drop_base"))
> +               test_permute_drop_base();
> +       if (test__start_subtest("permute_drop_split"))
> +               test_permute_drop_split();
> +       if (test__start_subtest("permute_drop_dedup"))
> +               test_permute_drop_dedup();
> +}
> --
> 2.34.1
>

