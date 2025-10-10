Return-Path: <bpf+bounces-70754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2B1BCE076
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 19:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B07324F1050
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7591E8320;
	Fri, 10 Oct 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApmIybJ/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A636B
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115697; cv=none; b=UdxWj3jVIfgW1G7s0t6QfM4W84OQxGuVw8+iJyi1Su5tzOjtj+pcg5DrtVnJClZRp3iVBDl+8o5AJuzJQyznYwD/7ui6izKfwGHiQh8v3YSxajpSi45b3N9pejUM7uiWM6NbHAMLgwpubJvgWUaC/xtRtHDx3oAuhFUvSDO5jdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115697; c=relaxed/simple;
	bh=48eKEkeKR367pXYUL9iSGv02+s89dxT9qzKSWbJ2c6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KncC++4dXly0xuDIM8pJ7oXt8i81wbx1JCTtemYJYqLmETeuTNiOesTgxWVdgegT99chn58qEPhySROM8j8PAJ8maDS1fEhDgK/NLHlK6pUeaI1tENeDKwGvqhPCMOQnyCbu505M5uM3rCEUE903/+pUCaIQKjMc9myNoIoCe0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApmIybJ/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3306d93e562so2409635a91.1
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760115695; x=1760720495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/iGR+jjVRKHk8xKxxa4a9yEFIfy0KuUVg38iEUzBio=;
        b=ApmIybJ/Olv+c732jj9GOz3BX3L8zOD7uOvcv5KNxm/HKcLL2mCaUlqUXCh2NkouxY
         czD95sVTf+jHWI4/RlhKl9DskzWIM71WuF9UW+0VGUf0JPxyCbYLRtyAFZFyUIQBW9pw
         z1psEMrCO8fu8MIbnrc+pFFIB4nhngVFMTdMY+KOEbTI/T9PNdx6KgGSugQ0L/srGStd
         h3UCr7mjRZWYzmIykg8rLsgFwjEU1pYGJgQsNz3YXuxA+z6ACnfaRXJJaIv7cTkRrO99
         Huk0scNcm6Qgxo0idCfLjqH90VDhfTbkUSNZG4W+ddveJtG7NWoeDZBnAhCmsZohVsHX
         Y++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760115695; x=1760720495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/iGR+jjVRKHk8xKxxa4a9yEFIfy0KuUVg38iEUzBio=;
        b=snerIEl+0YFuHQe8ZJxWRWA4hSvDpdmcNA8TXtDSNS5SckLnPSrKixE2z2YHNRPXPd
         qz15JuHIkfyaAwfDF9SSGUTBLCbWqojmBz1PpVAJz88Xk13njgRgFmtgWZyzAossSX0R
         /HmBjovWPFoMCq1ANwi4T0I8QM92fQsmioX9LQVyF2lgezRICZwl7KDCuAkU0cb0Vg5Z
         0r58MJlvl0Ws41K7amRM4U0RQzFjE28j02rxyRJs7Z18UnH//GaH86IG8ytADBQPIte5
         Th1j+y6b6WZ5o5dk54jn0dfcbGDtgKWV1SM5drvNpv3e0AkqeuAT/ExCQgdu8KiYPV5V
         C6oQ==
X-Gm-Message-State: AOJu0Yz/yr6NpfjzM4BsXTK51tBilH10O5STD9p+vpexBADbixbxMJEl
	FmpUBabTeVuMKp9prHyWk3aXk4j4zqA9daDQQUtvYXIGSI893lzdNdQ3tE4L8etLeIFBaB9IKv4
	uYhzW8/ZA+7/rfHs2U7BcQLPr/FH+8RY=
X-Gm-Gg: ASbGncuS/7eSnbuKeZD+vM3euX5Z+YsdyUVVxB9veI0J0vcUCl2vuN0SENyPqszAX4N
	Q9/5JjFikaMdec+cBJ1CURe/zT4XcF3T8xUrf8h5BSkvryOmLP8lhTUPoCAXjAXTozrQ/2wBfrj
	EaLY3HWpkFJWbxmK7hObkA2GxIIX/yvnl653HuZ6xOJCUFaAn3kn2YhdarCLqnm6Q+2KyPG4wRn
	TT6PnEwjR41X9YO9dyrw+qk72rC2C6z+EhJ7uSQEJOh/UDRqUmR
X-Google-Smtp-Source: AGHT+IE0+COEEJJf6epdqRivJgzQzS5UaBS0ndCEdLk47mS+OW/7FwZh9tAcnJMKp+lRGIuj5PGUta2C62+jPwlh9JA=
X-Received: by 2002:a17:90b:350e:b0:329:ca48:7090 with SMTP id
 98e67ed59e1d1-33b513ebc36mr15654748a91.37.1760115694320; Fri, 10 Oct 2025
 10:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007220349.3852807-1-memxor@gmail.com> <20251007220349.3852807-4-memxor@gmail.com>
In-Reply-To: <20251007220349.3852807-4-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Oct 2025 10:01:19 -0700
X-Gm-Features: AS18NWB_ykIgwsB9spo6nW3JAArFmKkYIoCfYkKhoGSIo6AIPKXoCQn-NCSDqjg
Message-ID: <CAEf4Bzbe9f7VD-6NqMjfismR0dSEUCEoqo6jOZXEDis-f9zQpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add tests for async cb context
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:03=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Add tests to verify that async callback's sleepable attribute is
> correctly determined by the callback type, not the arming program's
> context, reflecting its true execution context.
>
> Introduce verifier_async_cb_context.c with tests for all three async
> callback primitives: bpf_timer, bpf_wq, and bpf_task_work. Each
> primitive is tested when armed from both sleepable (lsm.s/file_open) and
> non-sleepable (fentry) programs.
>
> Test coverage:
> - bpf_timer callbacks: Verify they are never sleepable, even when armed
>   from sleepable programs. Both tests should fail when attempting to use
>   sleepable helper bpf_copy_from_user() in the callback.
>
> - bpf_wq callbacks: Verify they are always sleepable, even when armed
>   from non-sleepable programs. Both tests should succeed when using
>   sleepable helpers in the callback.
>
> - bpf_task_work callbacks: Verify they are always sleepable, even when
>   armed from non-sleepable programs. Both tests should succeed when
>   using sleepable helpers in the callback.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../bpf/progs/verifier_async_cb_context.c     | 181 ++++++++++++++++++
>  2 files changed, 183 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_async_cb_c=
ontext.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 28e81161e6fc..c0e8ffdaa484 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -7,6 +7,7 @@
>  #include "verifier_arena.skel.h"
>  #include "verifier_arena_large.skel.h"
>  #include "verifier_array_access.skel.h"
> +#include "verifier_async_cb_context.skel.h"
>  #include "verifier_basic_stack.skel.h"
>  #include "verifier_bitfield_write.skel.h"
>  #include "verifier_bounds.skel.h"
> @@ -280,6 +281,7 @@ void test_verifier_array_access(void)
>                       verifier_array_access__elf_bytes,
>                       init_array_access_maps);
>  }
> +void test_verifier_async_cb_context(void)    { RUN(verifier_async_cb_con=
text); }
>
>  static int init_value_ptr_arith_maps(struct bpf_object *obj)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.=
c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> new file mode 100644
> index 000000000000..96ff6749168b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +/* Timer tests */
> +
> +struct timer_elem {
> +       struct bpf_timer t;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, int);
> +       __type(value, struct timer_elem);
> +} timer_map SEC(".maps");
> +
> +static int timer_cb(void *map, int *key, struct bpf_timer *timer)
> +{
> +       u32 data;
> +       /* Timer callbacks are never sleepable, even from non-sleepable p=
rograms */
> +       bpf_copy_from_user(&data, sizeof(data), NULL);
> +       return 0;
> +}
> +
> +SEC("fentry/bpf_fentry_test1")
> +__failure __msg("helper call might sleep in a non-sleepable prog")
> +int timer_non_sleepable_prog(void *ctx)
> +{
> +       struct timer_elem *val;
> +       int key =3D 0;
> +
> +       val =3D bpf_map_lookup_elem(&timer_map, &key);
> +       if (!val)
> +               return 0;
> +
> +       bpf_timer_init(&val->t, &timer_map, 0);
> +       bpf_timer_set_callback(&val->t, timer_cb);
> +       return 0;
> +}
> +
> +SEC("lsm.s/file_open")
> +__failure __msg("helper call might sleep in a non-sleepable prog")
> +int timer_sleepable_prog(void *ctx)
> +{
> +       struct timer_elem *val;
> +       int key =3D 0;
> +
> +       val =3D bpf_map_lookup_elem(&timer_map, &key);
> +       if (!val)
> +               return 0;
> +
> +       bpf_timer_init(&val->t, &timer_map, 0);
> +       bpf_timer_set_callback(&val->t, timer_cb);
> +       return 0;
> +}

can you please also add (as a follow up is fine) this case:

static noinline int mixed_mode_subprog(void)
{
    /* use one of is_storage_get_function() helpers here */
}

static int timer_cb(void *map, int *key, struct bpf_timer *timer)
{
    mixed_mode_subprog();
    return 0;
}

SEC("lsm.s/file_open") /* sleepable entry program */
int sleepable(void *ctx) {
    ...
    bpf_timer_set_callback(&val->t, timer_cb);

    /* !!! important to call it here */
    mixed_mode_subprog();
}

Idea being that we have a subprog that is called in both sleepable and
non-sleepable modes. It should be rejected.

Let's do the same the other way, when the entry program is
non-sleepable but an async callback is sleepable, ok?


Note also that noinline part is important, we need to make sure it
doesn't get inline anywhere. If necessary, we can do __weak __hidden
to make this happen.

[...]

