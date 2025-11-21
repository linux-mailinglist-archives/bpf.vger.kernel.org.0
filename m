Return-Path: <bpf+bounces-75232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF3C7A18C
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 15:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D1B922DF8F
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29C72609FD;
	Fri, 21 Nov 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jwm7HLNw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C025B69F
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734653; cv=none; b=pF9U1MS40zqXoUiUIJ5mQs8go49nQDti6hAsxtYh6c3tF4R4wyruhbTDZQLksV+5vR3xf0/SjIIiQACyWOUPn13v+2MXyQV0HuOYgD9TkM55lNK55q77kyeOR9sMMLZIFpg3OoEQErfoSu1JjX8uWo7lQoUxItPFCXbuAeQfQRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734653; c=relaxed/simple;
	bh=rV7uWTRt/ArCvRhejH9MjMoH2xzOwO0XcbWF+W437D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YY+zH/DNajU6wdcHT4CGYJKoCzSrX1AOQ3bmnCW7241gMjgZEKptR1RdKUMZin4JYRPB9gQOFd7DyqP1xVLhwOX715wqBI2lJ3IwQ5LLax9BynXwmcXjK4oC/BpT9rpkOnaUDEGUZZI3tgbpu7PO0OkJLhFRUVYzyTp1IKoHN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jwm7HLNw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b737c6c13e1so383486566b.3
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 06:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763734650; x=1764339450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59+Ce6rqpm0Wp4JjZLuYF5F6qw92Ja8b/NH4Eex4X+0=;
        b=Jwm7HLNw/TZ2kofxICu4QfarlvIcDcQUfLocpxBxpH8QcSzaIVchTflr3c4hKCHXGw
         m2AfqFaCy85XjJXoiwkcJrhlOQ1iJ7UjzUZmDZRwwaSR3PBt8YavHBV3SGl6yhyw1gq3
         9XOcCBRstIVl56I7KqQDoRVd96nYiSBD0qHvHY+pkfEwLfPmmuj/7lHs/O8HRHtRPZEw
         ihpJFIauiJMGkvWF0pX2JUei/GZSBCxbrQCDQjNeA7JdNCjFZX+ewmeuSXW/QQ7G4+49
         khanWRDDaZXSnGJFmAuKxciERMr3YQSWHZWeByBDOkTckIEzXO6bIgv6waTh6rUYfaQU
         Xd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734650; x=1764339450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=59+Ce6rqpm0Wp4JjZLuYF5F6qw92Ja8b/NH4Eex4X+0=;
        b=bEsNP7y43tlqXBBFLHIdX/d23MH+noyBBTKzolZCqc5cIO0RimwYLy98IMggqD9lTY
         MpfnrxQF9isudYNLfZ5ADmxiNHvGnHw1+ja1M7mjXULPuJCZA37kfnnQYmA/Fi/05WlB
         +mP/YFsbSgOnilUdizlJXQjsGtLRe0zkeK2jDGNWP/XVUwobJbQhPWPmWU65Ac01N6Qe
         U30V3cEan00Bao7OPMqWhqY8O0flPF5Ah4ddhv1uy04bMKbZdmMuoalHwh6CYgTTJxBn
         4/77zrfoOD86d8sQuTtv3W/DbvUjhWXZ6UwBRLbBVHo/jrSeb398MMWzG5jYnxecloI1
         Kqzg==
X-Forwarded-Encrypted: i=1; AJvYcCXcllGdK4dH/Akm2AaAh5gATlClHltfNSGKyIrUQb3IlVVzobNqqGKNmqDGkQZsI/kOJTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQB4ybch/BtIbLghgnd3RisbdnhWdfmRzTSTfH+Lt3Ph9B7SiQ
	LUFJ1Wq/dDhwFlT5KUrKAGNc5Wb7WVynz+cO2wDmFvyexfGTIf3r+xCbCcP3c6tg1qfSaSDJU27
	BxMBXdmLvBsWws4ViY3kDhTm7CJ7rnT8=
X-Gm-Gg: ASbGncvIIsGJNwBF8M9yCbipfXGtwWlOb62Jwz3TgtqAS+OC3krwv6OdK0VGPJeTNsD
	xMOfDiLhNSOrPDBKTgOIqhVuY/RTgtEzR0Nc3fuIuw9BpLi1ENURVxPjAVgVZmyxctYsr89DVN6
	5X7gFQDKSrxE3jiVWZb5X4+mDfNKQw865U+wsdFbeJ2MeyBKCAH3VSvHgRKH5HY9w8k/05kPpg1
	A2LdIBwgTPv25yeif7lN46eHskvzcuzqhkFriYWA/O2UN1CAsJLkGRKHLfU/lxVsST8Xo7n
X-Google-Smtp-Source: AGHT+IEAwHYIM5tAdEbJchmaGAxRBLYXQCwF+N0+Z/Mf/6JQ65sn9almQZEkUIzylIZaOEcVMeKMHnoGUpyEW3fWRqY=
X-Received: by 2002:a17:907:d92:b0:b73:3a:c49d with SMTP id
 a640c23a62f3a-b7671880a8emr216362866b.52.1763734649557; Fri, 21 Nov 2025
 06:17:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-3-dolinux.peng@gmail.com> <fdeda8c6ec282fae793799bf5546d7e3b0578e1a.camel@gmail.com>
In-Reply-To: <fdeda8c6ec282fae793799bf5546d7e3b0578e1a.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 21 Nov 2025 22:17:17 +0800
X-Gm-Features: AWmQ_blBqhLPQcuR_kOQj-q-R_TKlfGU-RH-1iOPNnNwNUoxMPxylvn7_7BNoc4
Message-ID: <CAErzpmv5UuUG_xzs8fS1JOsii8EoxWeu3L2UFL2JUYoBCyhSig@mail.gmail.com>
Subject: Re: [RFC PATCH v7 2/7] selftests/bpf: Add test cases for btf__permute functionality
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 7:39=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-11-19 at 11:15 +0800, Donglin Peng wrote:
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/too=
ls/testing/selftests/bpf/prog_tests/btf_permute.c
> > new file mode 100644
> > index 000000000000..f67bf89519b3
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
> > @@ -0,0 +1,608 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Xiaomi */
> > +
> > +#include <test_progs.h>
> > +#include <bpf/btf.h>
> > +#include "btf_helpers.h"
> > +
> > +/* Ensure btf__permute work as expected with base BTF */
> > +static void test_permute_base(void)
> > +{
> > +     struct btf *btf;
> > +     __u32 permute_ids[6];
> > +     int start_id =3D 1;
> > +     int err;
> > +
> > +     btf =3D btf__new_empty();
> > +     if (!ASSERT_OK_PTR(btf, "empty_main_btf"))
> > +             return;
> > +
> > +     btf__add_int(btf, "int", 4, BTF_INT_SIGNED);    /* [1] int */
> > +     btf__add_ptr(btf, 1);                           /* [2] ptr to int=
 */
> > +     btf__add_struct(btf, "s1", 4);                  /* [3] struct s1 =
{ */
> > +     btf__add_field(btf, "m", 1, 0, 0);              /*       int m; *=
/
> > +                                                     /* } */
> > +     btf__add_struct(btf, "s2", 4);                  /* [4] struct s2 =
{ */
> > +     btf__add_field(btf, "m", 1, 0, 0);              /*       int m; *=
/
> > +                                                     /* } */
> > +     btf__add_func_proto(btf, 1);                    /* [5] int (*)(in=
t *p); */
> > +     btf__add_func_param(btf, "p", 2);
> > +     btf__add_func(btf, "f", BTF_FUNC_STATIC, 5);    /* [6] int f(int =
*p); */
> > +
> > +     VALIDATE_RAW_BTF(
> > +             btf,
> > +             "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> > +             "[2] PTR '(anon)' type_id=3D1",
> > +             "[3] STRUCT 's1' size=3D4 vlen=3D1\n"
> > +             "\t'm' type_id=3D1 bits_offset=3D0",
> > +             "[4] STRUCT 's2' size=3D4 vlen=3D1\n"
> > +             "\t'm' type_id=3D1 bits_offset=3D0",
> > +             "[5] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> > +             "\t'p' type_id=3D2",
> > +             "[6] FUNC 'f' type_id=3D5 linkage=3Dstatic");
> > +
> > +     permute_ids[1 - start_id] =3D 4; /* [1] -> [4] */
> > +     permute_ids[2 - start_id] =3D 3; /* [2] -> [3] */
> > +     permute_ids[3 - start_id] =3D 5; /* [3] -> [5] */
> > +     permute_ids[4 - start_id] =3D 1; /* [4] -> [1] */
> > +     permute_ids[5 - start_id] =3D 6; /* [5] -> [6] */
> > +     permute_ids[6 - start_id] =3D 2; /* [6] -> [2] */
> > +     err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), N=
ULL);
> > +     if (!ASSERT_OK(err, "btf__permute_base"))
> > +             goto done;
> > +
> > +     VALIDATE_RAW_BTF(
> > +             btf,
> > +             "[1] STRUCT 's2' size=3D4 vlen=3D1\n"
> > +             "\t'm' type_id=3D4 bits_offset=3D0",
> > +             "[2] FUNC 'f' type_id=3D6 linkage=3Dstatic",
> > +             "[3] PTR '(anon)' type_id=3D4",
> > +             "[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> > +             "[5] STRUCT 's1' size=3D4 vlen=3D1\n"
> > +             "\t'm' type_id=3D4 bits_offset=3D0",
> > +             "[6] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1\n"
> > +             "\t'p' type_id=3D3");
> > +
> > +     /*
> > +      * For base BTF, id_map_cnt must equal to the number of types
> > +      * include VOID type
> > +      */
> > +     permute_ids[1 - start_id] =3D 4; /* [1] -> [4] */
> > +     permute_ids[2 - start_id] =3D 3; /* [2] -> [3] */
> > +     permute_ids[3 - start_id] =3D 5; /* [3] -> [5] */
> > +     permute_ids[4 - start_id] =3D 1; /* [4] -> [1] */
> > +     permute_ids[5 - start_id] =3D 6; /* [5] -> [6] */
> > +     permute_ids[6 - start_id] =3D 2; /* [6] -> [2] */
> > +     err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids) - =
1, NULL);
> > +     if (!ASSERT_ERR(err, "btf__permute_base"))
> > +             goto done;
> > +
> > +     VALIDATE_RAW_BTF(
> > +             btf,
> > +             "[1] STRUCT 's2' size=3D4 vlen=3D1\n"
> > +             "\t'm' type_id=3D4 bits_offset=3D0",
> > +             "[2] FUNC 'f' type_id=3D6 linkage=3Dstatic",
> > +             "[3] PTR '(anon)' type_id=3D4",
> > +             "[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> > +             "[5] STRUCT 's1' size=3D4 vlen=3D1\n"
> > +             "\t'm' type_id=3D4 bits_offset=3D0",
> > +             "[6] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1\n"
> > +             "\t'p' type_id=3D3");
> > +
> > +     /* Multiple types can not be mapped to the same ID */
> > +     permute_ids[1 - start_id] =3D 4;
> > +     permute_ids[2 - start_id] =3D 4;
> > +     permute_ids[3 - start_id] =3D 5;
> > +     permute_ids[4 - start_id] =3D 1;
> > +     permute_ids[5 - start_id] =3D 6;
> > +     permute_ids[6 - start_id] =3D 2;
> > +     err =3D btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), N=
ULL);
> > +     if (!ASSERT_ERR(err, "btf__permute_base"))
> > +             goto done;
>
> Nit: Maybe extract the VALIDATE_RAW_BTF as a function, so that it is
>      not repeated? Otherwise it is a bit harder to tell that you are
>      checking for BTF to be intact if error is returned.
>      Same for the test_permute_split() case.

Thanks, I will make it more clear.

>
> > +
> > +     VALIDATE_RAW_BTF(
> > +             btf,
> > +             "[1] STRUCT 's2' size=3D4 vlen=3D1\n"
> > +             "\t'm' type_id=3D4 bits_offset=3D0",
> > +             "[2] FUNC 'f' type_id=3D6 linkage=3Dstatic",
> > +             "[3] PTR '(anon)' type_id=3D4",
> > +             "[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> > +             "[5] STRUCT 's1' size=3D4 vlen=3D1\n"
> > +             "\t'm' type_id=3D4 bits_offset=3D0",
> > +             "[6] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1\n"
> > +             "\t'p' type_id=3D3");
>
> [...]

