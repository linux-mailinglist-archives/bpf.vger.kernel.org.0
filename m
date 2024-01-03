Return-Path: <bpf+bounces-18905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CEF8235E4
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853BC1C240DF
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220D1CF9C;
	Wed,  3 Jan 2024 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtFgqfHq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9C1CF92;
	Wed,  3 Jan 2024 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-556c60c3f9aso1320732a12.3;
        Wed, 03 Jan 2024 11:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704311487; x=1704916287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImXWekjANIxIOH7V6JRHO3do1hNhg4w7k9oJ9w7rJMI=;
        b=TtFgqfHqFwd8XC93pl0LIbnUqfXwtktE5ozCnj8DO1MxGNfTExurxJJeXbBBUNu4Z5
         JMRj14Jh0xQEPnikspxk5l66MyEjgDZtBHvoVcH1+brHKC2QkBeRfgUYuL+ffVZNT5hf
         s3C/iIF8ULpehPY/l/0XvpziKuGVOChGBgRJEI+StbERAe2/yor3TMBZRf5XblxPnnvI
         0PI7n6dK0GrvFzLQkJ+03kvu6517o/Gb6jDD+OE36ZbxnvHz8BmoJ/SEbeH/AYK6AEWi
         zq7NTzb//MnHgCzvlOe/o/4bUJM7hlhNmju2qZE/jxVxnENWZGgq1UcSyAXdtm/JWTe3
         5Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311487; x=1704916287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImXWekjANIxIOH7V6JRHO3do1hNhg4w7k9oJ9w7rJMI=;
        b=j3xswJmlgNgg53h5sjN3lQRN/vWuJzk/NccsyX5qe7JRpQGQeH6qOgP0qfPFs6+wM+
         j2BImcXlcL14KibmaUff+505Unh6KW+vTJcTQ05wNHRBZqUpVeFtbwQUt30f53cC2EZ5
         hiJRiLRne90S6k4YHnv1IVgDd/GMTrQLJag+iEEUXUeV1dvt1bLKVPd0Vn1jC49zDq80
         G7SzQnQpxZF2Stv43eD/rGlshuQx7MZxbWvOjMGDy4OgFE/XUOHaRbJkNp6xOF2iM5us
         V83FkWRXmEze2JmGqSU6+FGY5CDccd6OCkPmenDlG6QRsYADL3QkXoiYbiId+qUEmVJA
         edAA==
X-Gm-Message-State: AOJu0YwFHBwT9t1nQGj8i6oUTn9ITRw5m6NO75Vvf/J87EPKB6kFduD4
	xUnKOlDC/fUrv2FNnCWtEQJke0w84EvP8XSfKL3fUau0
X-Google-Smtp-Source: AGHT+IGDLY9eSL4TE2NIgNb8FaQWNJ4HX4f7ourWeRr0EgSXzmt+2f4SWiH/b+ycHzssjwZPT8OrWbT295okGz9RFqg=
X-Received: by 2002:a50:cd16:0:b0:554:1171:4495 with SMTP id
 z22-20020a50cd16000000b0055411714495mr13049212edi.23.1704311486757; Wed, 03
 Jan 2024 11:51:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103153307.553838-1-brho@google.com> <20240103153307.553838-3-brho@google.com>
In-Reply-To: <20240103153307.553838-3-brho@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 11:51:13 -0800
Message-ID: <CAEf4BzbKT3LbHQSFwpAfoJuhyGy2NpHk7A6ivkFiutN_jnKHYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add inline assembly helpers
 to access array elements
To: Barret Rhoden <brho@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 7:33=E2=80=AFAM Barret Rhoden <brho@google.com> wrot=
e:
>
> When accessing an array, even if you insert your own bounds check,
> sometimes the compiler will remove the check, or modify it such that the
> verifier no longer knows your access is within bounds.
>
> The compiler is even free to make a copy of a register, check the copy,
> and use the original to access the array.  The verifier knows the *copy*
> is within bounds, but not the original register!
>
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  .../bpf/prog_tests/test_array_elem.c          | 112 ++++++++++
>  .../selftests/bpf/progs/array_elem_test.c     | 195 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |  43 ++++
>  4 files changed, 351 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_array_ele=
m.c
>  create mode 100644 tools/testing/selftests/bpf/progs/array_elem_test.c
>

I'm curious how bpf_cmp_likely/bpf_cmp_unlikely (just applied to
bpf-next) compares to this?


> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 617ae55c3bb5..651d4663cc78 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -34,7 +34,7 @@ LIBELF_CFLAGS :=3D $(shell $(PKG_CONFIG) libelf --cflag=
s 2>/dev/null)
>  LIBELF_LIBS    :=3D $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || e=
cho -lelf)
>
>  CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic                                   =
 \
> -         -Wall -Werror                                                 \
> +         -dicks -Wall -Werror                                          \

what does this magic argument do? )

>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
>           -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_array_elem.c b/t=
ools/testing/selftests/bpf/prog_tests/test_array_elem.c
> new file mode 100644
> index 000000000000..c953636f07c9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_array_elem.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Google LLC. */
> +#include <test_progs.h>
> +#include "array_elem_test.skel.h"
> +
> +#define NR_MAP_ELEMS 100
> +
> +/*
> + * Helper to load and run a program.
> + * Call must define skel, map_elems, and bss_elems.
> + * Destroy the skel when you're done.
> + */
> +#define load_and_run(PROG) ({

does this have to be a macro? Can you write it as a function?
                                    \
> +       int err;                                                        \
> +       skel =3D array_elem_test__open();                                =
 \
> +       if (!ASSERT_OK_PTR(skel, "array_elem_test open"))               \
> +               return;                                                 \
> +       bpf_program__set_autoload(skel->progs.x_ ## PROG, true);        \
> +       err =3D array_elem_test__load(skel);                             =
 \
> +       if (!ASSERT_EQ(err, 0, "array_elem_test load")) {               \
> +               array_elem_test__destroy(skel);                         \
> +               return;                                                 \
> +       }                                                               \
> +       err =3D array_elem_test__attach(skel);                           =
 \
> +       if (!ASSERT_EQ(err, 0, "array_elem_test attach")) {             \
> +               array_elem_test__destroy(skel);                         \
> +               return;                                                 \
> +       }                                                               \
> +       for (int i =3D 0; i < NR_MAP_ELEMS; i++)                         =
 \
> +               skel->bss->lookup_indexes[i] =3D i;                      =
 \
> +       map_elems =3D bpf_map__mmap(skel->maps.arraymap);                =
 \
> +       ASSERT_OK_PTR(map_elems, "mmap");                               \
> +       bss_elems =3D skel->bss->bss_elems;                              =
 \
> +       skel->bss->target_pid =3D getpid();                              =
 \
> +       usleep(1);                                                      \
> +})
> +


[...]

