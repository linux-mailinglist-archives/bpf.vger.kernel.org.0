Return-Path: <bpf+bounces-77121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5408CCE5E7
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 04:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F2D1302DB64
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF671A9F93;
	Fri, 19 Dec 2025 03:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq84RPXG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD33595B
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766115042; cv=none; b=AcGNWnojlWnEj9SPdOz7W9/5O4/X7AHajF1qi5naYh4TZPaE7jn+xOIH1lHQWhSa8UUUuqFV+gxkGdaEAAjFTZpuxUL1jPJPJMX1oEmElaNsnlFnjQUSvl34H0LcIaKxGg9l+jPkNqbkcIsyQM0vxA3l5ZAKj8ivdFpFqEM3tdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766115042; c=relaxed/simple;
	bh=ma6BWXI0MWMkJ1RrZK6yUvfjTZmxCPGffpFrd1k5abs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oF6apeNfw3vW+G9+l8FRH50EU0yO7rwyiT+XUrj11YPXp1bwc/k3FXrnGkQtFFLP1bcT1yNi3o532c0GJjPBa2/1SLs/7KN7xWP1opr20ZEI76FNFQJaAnEbEwU/mweSZF2WQ/o3iUzinm48hl1RlCfrrbm224znfkNBT8zZSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq84RPXG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so1715865a12.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 19:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766115039; x=1766719839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks1GB7VcUdD5z0C6MSKZ9+LG7T3LeXkbvOofd2PwJYY=;
        b=Dq84RPXGBj/nrdfwTkmP+ae11E6NIb4U5dkJtJOH+y86SQnwF+tQuTwuiDbP/yHksp
         Vs3PHB/b1w5Nxcc7bbCt+0i8hdumfotPsg9bnIhIXgYTXbdFVGVlZjtbus9BLhfPQ9VE
         cGtmnCbOwYQjefceeEmME7LIz25Zebe9CCzw5Ls9CxaF70wirVt8llie1UFReW4/5n0z
         /LlHM2t6MuX//v6Loj/nm2b54wD+A27lRpvOnlym1DLwggkEsdLxPXIa6fRgXKIV0Dib
         eEGTbpEuQWzSGn/Hk3zk6bD4eWID+7++xQzKOEhmyFnEsPXcvhF2LGNS0z5Ek5i3qsy5
         nA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766115039; x=1766719839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ks1GB7VcUdD5z0C6MSKZ9+LG7T3LeXkbvOofd2PwJYY=;
        b=iH90oWFRgH/d44pVVSuysdkzIPcYjIUxF6Km9AP2BaxH6Ar4jzNNQ4r0tlgdGCdvjR
         OPs57gBRjWCvxq8FxRQARJKx3jULiAL5C0T8W+od0jATef4MNASns+lBfKwnxexhzjxl
         hCRBQXkqtMNVsr0KiuirgObABImWQBA3CoEGSdbvgsZL0WZ3L1QAzCW8Uubkkq6kIV0o
         ChiX+VvemrcCK3P2IoZDuZURrso5wlpofsUkk5Rur5JUNkkzu9s8XLlCnlklz/8povL0
         qlmk6H41N/I5Vi6IiQVuopIO0I5gOEQygFUnzc29JSYD8h1ofsBGjkHog0qZaw1UHsVF
         NaXA==
X-Forwarded-Encrypted: i=1; AJvYcCW/cZ2lqC3jUL5pFsM0OcGel+9t5qEuzs7B8otBXWAmNWCy9yclWEPyQ1/bn3KbcGJIQjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwf49HCDe2KfsvNCM5JeHclxn606dLL+OVpSebVoELbdZ02/c
	EGoxWJ6GZBKsS6rH3T+/9qLu+2YA+k3UcI8urJvi7y38aTAu7A3UOzO+eM2q4vd1aTRU4mqmILI
	eZFgvN1Zwh/kT1KqYZNsRq8y/DUwSTqo=
X-Gm-Gg: AY/fxX5+0tPnHaUfXmaMWQ4mhP7dYI4h0g1hGgycDb1Vzm8z4eKHDg1J+n/TFNhjcq0
	kiEGE42uDirxTaoFxjfq6HPLqVgRrmxpYPY/FN1lNDk3zu+z7nmGWMvKz64CaQFUOl8kNj+MqP0
	a1EY45MhpaHeFns1ffmaaveDj1I82agQp5d5WrstwA/GdR8Vhd/O9s0xpKWUi6hUFhVgu3q8W/0
	bgi5HEM3V0YcRaQokQa9nmKnrhBmgPiopapWWgkKwQywoUkuSwQ2Erp4GTacREJetC8+lHkOTF0
	BqML3Nc=
X-Google-Smtp-Source: AGHT+IHsT8fuAMfJ+jF62RVkJWspVN4yxMHGmk5yrPMe3vtE3lodkGL5OOqiFry5F6ffH0gGvD9ZXCVbXJVm8oSVRLs=
X-Received: by 2002:a17:907:6094:b0:b72:8489:7e65 with SMTP id
 a640c23a62f3a-b80370537fdmr144156966b.31.1766115038860; Thu, 18 Dec 2025
 19:30:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-3-dolinux.peng@gmail.com> <CAEf4Bza6dwjDPNoCbgnrEsyaE-xGuxyNoOOsxySWmzuxWZd0Zg@mail.gmail.com>
In-Reply-To: <CAEf4Bza6dwjDPNoCbgnrEsyaE-xGuxyNoOOsxySWmzuxWZd0Zg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 11:30:26 +0800
X-Gm-Features: AQt7F2q-SAO7SxNyQRpaq0QCF90jjidvBtWwsRBFL6jimYj_qrhwM23b4I5QdV4
Message-ID: <CAErzpmu=TfxXxEpCmTt-SoN_ycAeGw9y2vajdFTHPNbNBjemug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 02/13] selftests/bpf: Add test cases for
 btf__permute functionality
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:03=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > This patch introduces test cases for the btf__permute function to ensur=
e
> > it works correctly with both base BTF and split BTF scenarios.
> >
> > The test suite includes:
> > - test_permute_base: Validates permutation on base BTF
> > - test_permute_split: Tests permutation on split BTF
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/btf_permute.c    | 228 ++++++++++++++++++
> >  1 file changed, 228 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.=
c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/too=
ls/testing/selftests/bpf/prog_tests/btf_permute.c
> > new file mode 100644
> > index 000000000000..9aa71cdf984a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
> > @@ -0,0 +1,228 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Xiaomi */
> > +
> > +#include <test_progs.h>
> > +#include <bpf/btf.h>
> > +#include "btf_helpers.h"
> > +
> > +static void permute_base_check(struct btf *btf)
> > +{
> > +       VALIDATE_RAW_BTF(
> > +               btf,
> > +               "[1] STRUCT 's2' size=3D4 vlen=3D1\n"
> > +               "\t'm' type_id=3D4 bits_offset=3D0",
> > +               "[2] FUNC 'f' type_id=3D6 linkage=3Dstatic",
> > +               "[3] PTR '(anon)' type_id=3D4",
> > +               "[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 en=
coding=3DSIGNED",
> > +               "[5] STRUCT 's1' size=3D4 vlen=3D1\n"
> > +               "\t'm' type_id=3D4 bits_offset=3D0",
> > +               "[6] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1\n"
> > +               "\t'p' type_id=3D3");
> > +}
> > +
> > +/* Ensure btf__permute work as expected with base BTF */
> > +static void test_permute_base(void)
> > +{
> > +       struct btf *btf;
> > +       __u32 permute_ids[6];
> > +       int start_id =3D 1;
> > +       int err;
> > +
> > +       btf =3D btf__new_empty();
> > +       if (!ASSERT_OK_PTR(btf, "empty_main_btf"))
> > +               return;
> > +
> > +       btf__add_int(btf, "int", 4, BTF_INT_SIGNED);    /* [1] int */
> > +       btf__add_ptr(btf, 1);                           /* [2] ptr to i=
nt */
> > +       btf__add_struct(btf, "s1", 4);                  /* [3] struct s=
1 { */
> > +       btf__add_field(btf, "m", 1, 0, 0);              /*       int m;=
 */
> > +                                                       /* } */
> > +       btf__add_struct(btf, "s2", 4);                  /* [4] struct s=
2 { */
> > +       btf__add_field(btf, "m", 1, 0, 0);              /*       int m;=
 */
> > +                                                       /* } */
> > +       btf__add_func_proto(btf, 1);                    /* [5] int (*)(=
int *p); */
> > +       btf__add_func_param(btf, "p", 2);
> > +       btf__add_func(btf, "f", BTF_FUNC_STATIC, 5);    /* [6] int f(in=
t *p); */
> > +
> > +       VALIDATE_RAW_BTF(
> > +               btf,
> > +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 en=
coding=3DSIGNED",
> > +               "[2] PTR '(anon)' type_id=3D1",
> > +               "[3] STRUCT 's1' size=3D4 vlen=3D1\n"
> > +               "\t'm' type_id=3D1 bits_offset=3D0",
> > +               "[4] STRUCT 's2' size=3D4 vlen=3D1\n"
> > +               "\t'm' type_id=3D1 bits_offset=3D0",
> > +               "[5] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> > +               "\t'p' type_id=3D2",
> > +               "[6] FUNC 'f' type_id=3D5 linkage=3Dstatic");
> > +
> > +       permute_ids[1 - start_id] =3D 4; /* [1] -> [4] */
> > +       permute_ids[2 - start_id] =3D 3; /* [2] -> [3] */
> > +       permute_ids[3 - start_id] =3D 5; /* [3] -> [5] */
> > +       permute_ids[4 - start_id] =3D 1; /* [4] -> [1] */
> > +       permute_ids[5 - start_id] =3D 6; /* [5] -> [6] */
> > +       permute_ids[6 - start_id] =3D 2; /* [6] -> [2] */
> > +       err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids),=
 NULL);
> > +       if (!ASSERT_OK(err, "btf__permute_base"))
> > +               goto done;
> > +       permute_base_check(btf);
> > +
> > +       /* id_map_cnt is invalid  */
> > +       permute_ids[1 - start_id] =3D 4; /* [1] -> [4] */
> > +       permute_ids[2 - start_id] =3D 3; /* [2] -> [3] */
> > +       permute_ids[3 - start_id] =3D 5; /* [3] -> [5] */
> > +       permute_ids[4 - start_id] =3D 1; /* [4] -> [1] */
> > +       permute_ids[5 - start_id] =3D 6; /* [5] -> [6] */
> > +       permute_ids[6 - start_id] =3D 2; /* [6] -> [2] */
> > +       err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids) =
- 1, NULL);
> > +       if (!ASSERT_ERR(err, "btf__permute_base"))
> > +               goto done;
> > +       /* BTF is not modified */
> > +       permute_base_check(btf);
> > +
> > +       /* Multiple types can not be mapped to the same ID */
> > +       permute_ids[1 - start_id] =3D 4;
> > +       permute_ids[2 - start_id] =3D 4;
> > +       permute_ids[3 - start_id] =3D 5;
> > +       permute_ids[4 - start_id] =3D 1;
> > +       permute_ids[5 - start_id] =3D 6;
> > +       permute_ids[6 - start_id] =3D 2;
> > +       err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids),=
 NULL);
> > +       if (!ASSERT_ERR(err, "btf__permute_base"))
> > +               goto done;
> > +       /* BTF is not modified */
> > +       permute_base_check(btf);
> > +
> > +       /* Type ID must be valid */
> > +       permute_ids[1 - start_id] =3D 4;
> > +       permute_ids[2 - start_id] =3D 3;
> > +       permute_ids[3 - start_id] =3D 5;
> > +       permute_ids[4 - start_id] =3D 1;
> > +       permute_ids[5 - start_id] =3D 7;
> > +       permute_ids[6 - start_id] =3D 2;
>
> please make sure this base BTF test doesn't use start_id, see comment
> on previous patch

Thanks. I will remove it in the next version.

>
> > +       err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids),=
 NULL);
> > +       if (!ASSERT_ERR(err, "btf__permute_base"))
> > +               goto done;
> > +       /* BTF is not modified */
> > +       permute_base_check(btf);
> > +
> > +done:
> > +       btf__free(btf);
> > +}
> > +
> > +static void permute_split_check(struct btf *btf)
> > +{
> > +       VALIDATE_RAW_BTF(
> > +               btf,
> > +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 en=
coding=3DSIGNED",
> > +               "[2] PTR '(anon)' type_id=3D1",
> > +               "[3] STRUCT 's2' size=3D4 vlen=3D1\n"
> > +               "\t'm' type_id=3D1 bits_offset=3D0",
> > +               "[4] FUNC 'f' type_id=3D5 linkage=3Dstatic",
> > +               "[5] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> > +               "\t'p' type_id=3D2",
> > +               "[6] STRUCT 's1' size=3D4 vlen=3D1\n"
> > +               "\t'm' type_id=3D1 bits_offset=3D0");
> > +}
> > +
> > +/* Ensure btf__permute work as expected with split BTF */
> > +static void test_permute_split(void)
> > +{
> > +       struct btf *split_btf =3D NULL, *base_btf =3D NULL;
> > +       __u32 permute_ids[4];
> > +       int err;
> > +       int start_id;
> > +
> > +       base_btf =3D btf__new_empty();
> > +       if (!ASSERT_OK_PTR(base_btf, "empty_main_btf"))
> > +               return;
> > +
> > +       btf__add_int(base_btf, "int", 4, BTF_INT_SIGNED);       /* [1] =
int */
> > +       btf__add_ptr(base_btf, 1);                              /* [2] =
ptr to int */
> > +       VALIDATE_RAW_BTF(
> > +               base_btf,
> > +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 en=
coding=3DSIGNED",
> > +               "[2] PTR '(anon)' type_id=3D1");
> > +       split_btf =3D btf__new_empty_split(base_btf);
> > +       if (!ASSERT_OK_PTR(split_btf, "empty_split_btf"))
> > +               goto cleanup;
> > +       btf__add_struct(split_btf, "s1", 4);                    /* [3] =
struct s1 { */
> > +       btf__add_field(split_btf, "m", 1, 0, 0);                /*   in=
t m; */
> > +                                                               /* } */
> > +       btf__add_struct(split_btf, "s2", 4);                    /* [4] =
struct s2 { */
> > +       btf__add_field(split_btf, "m", 1, 0, 0);                /*   in=
t m; */
> > +                                                               /* } */
> > +       btf__add_func_proto(split_btf, 1);                      /* [5] =
int (*)(int p); */
> > +       btf__add_func_param(split_btf, "p", 2);
> > +       btf__add_func(split_btf, "f", BTF_FUNC_STATIC, 5);      /* [6] =
int f(int *p); */
> > +
> > +       VALIDATE_RAW_BTF(
> > +               split_btf,
> > +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 en=
coding=3DSIGNED",
> > +               "[2] PTR '(anon)' type_id=3D1",
> > +               "[3] STRUCT 's1' size=3D4 vlen=3D1\n"
> > +               "\t'm' type_id=3D1 bits_offset=3D0",
> > +               "[4] STRUCT 's2' size=3D4 vlen=3D1\n"
> > +               "\t'm' type_id=3D1 bits_offset=3D0",
> > +               "[5] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> > +               "\t'p' type_id=3D2",
> > +               "[6] FUNC 'f' type_id=3D5 linkage=3Dstatic");
> > +
> > +       start_id =3D btf__type_cnt(base_btf);
> > +       permute_ids[3 - start_id] =3D 6; /* [3] -> [6] */
> > +       permute_ids[4 - start_id] =3D 3; /* [4] -> [3] */
> > +       permute_ids[5 - start_id] =3D 5; /* [5] -> [5] */
> > +       permute_ids[6 - start_id] =3D 4; /* [6] -> [4] */
> > +       err =3D btf__permute(split_btf, permute_ids, ARRAY_SIZE(permute=
_ids), NULL);
> > +       if (!ASSERT_OK(err, "btf__permute_split"))
> > +               goto cleanup;
> > +       permute_split_check(split_btf);
> > +
> > +       /*
> > +        * For split BTF, id_map_cnt must equal to the number of types
> > +        * added on top of base BTF
> > +        */
> > +       permute_ids[3 - start_id] =3D 4;
> > +       permute_ids[4 - start_id] =3D 3;
> > +       permute_ids[5 - start_id] =3D 5;
> > +       permute_ids[6 - start_id] =3D 6;
> > +       err =3D btf__permute(split_btf, permute_ids, 3, NULL);
> > +       if (!ASSERT_ERR(err, "btf__permute_split"))
> > +               goto cleanup;
> > +       /* BTF is not modified */
> > +       permute_split_check(split_btf);
> > +
> > +       /* Multiple types can not be mapped to the same ID */
> > +       permute_ids[3 - start_id] =3D 4;
> > +       permute_ids[4 - start_id] =3D 3;
> > +       permute_ids[5 - start_id] =3D 3;
> > +       permute_ids[6 - start_id] =3D 6;
> > +       err =3D btf__permute(split_btf, permute_ids, 4, NULL);
> > +       if (!ASSERT_ERR(err, "btf__permute_split"))
> > +               goto cleanup;
> > +       /* BTF is not modified */
> > +       permute_split_check(split_btf);
> > +
> > +       /* Can not map to base ID */
> > +       permute_ids[3 - start_id] =3D 4;
> > +       permute_ids[4 - start_id] =3D 2;
> > +       permute_ids[5 - start_id] =3D 5;
> > +       permute_ids[6 - start_id] =3D 6;
> > +       err =3D btf__permute(split_btf, permute_ids, 4, NULL);
> > +       if (!ASSERT_ERR(err, "btf__permute_split"))
> > +               goto cleanup;
> > +       /* BTF is not modified */
> > +       permute_split_check(split_btf);
> > +
> > +cleanup:
> > +       btf__free(split_btf);
> > +       btf__free(base_btf);
> > +}
> > +
> > +void test_btf_permute(void)
> > +{
> > +       if (test__start_subtest("permute_base"))
> > +               test_permute_base();
> > +       if (test__start_subtest("permute_split"))
> > +               test_permute_split();
> > +}
> > --
> > 2.34.1
> >

