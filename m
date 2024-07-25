Return-Path: <bpf+bounces-35588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B7193B9BA
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 02:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9686F28390B
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8801B80C;
	Thu, 25 Jul 2024 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9jYYzGU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA204405;
	Thu, 25 Jul 2024 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721866334; cv=none; b=Pk2IGGiDVk1pMOjO0txCAmYwZtQxgdLRSAEtg/3ih/AuXU5o7/OhjSEXc28IJMwTeU9vrOGrr64uQnk++/yQigRFsRKB8n8NSO9W9dUVdQoG+LqK3wz78F7YoQo730LtBS1ln7UzhfJoYH81FSm92U6NbR3B4d2AiLhmLtKthlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721866334; c=relaxed/simple;
	bh=HTwUjj5cEtKI6N5t1fd2B2Qf1fdN61H+kPYHrtgbOEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flZQHAa2Kn8uLwBslpd8PX0tL6KYiLJFMcON+bF0NbtjlN1cjqNORZcS62u3v502EtPMoMWxAVJYm32YAJIchyN7OeFQN1j9gajFmKkIkP+27eSIrfvwZ4JVrDtFhGE7mQUkWD3RczdQCrU/80gcKpByBp/ChFcVIXZtVGfjCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9jYYzGU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cdadce1a57so289877a91.2;
        Wed, 24 Jul 2024 17:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721866332; x=1722471132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVBP87MN9e38ZX22I138pr2gWwOeumRDkqSQQxg61Ew=;
        b=L9jYYzGU5yvbNtga71UNVxTjB0QqYXadd9VJhk6wr0xqz8Qsvh4xVj2svm3n18X6Qc
         yRRn0kCiPljWUNdQWG6PiDo/MChsevLYVJYRAjI/5Eh4y3iR8T5QrgHVU7rDG6zgx6EG
         2vqrbSHmF4CteDdxLkHwRMQzWCAgjit+4cH83k0mczqgi8dP3X1Q5ShV7K6ZN6njZstp
         D18va1O6qEYaz/TCvT5Zu4qZJxD++0ab27qBBY03se8+M8E/lWXk4ZuxaTaM1rEjqRN8
         3jyp30pnMCZhere7w7pqqfcL1QKS+gDD0fN9WgUw3KZi+mv0ghkRomoKxHveTcxmVZFc
         YnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721866332; x=1722471132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVBP87MN9e38ZX22I138pr2gWwOeumRDkqSQQxg61Ew=;
        b=BkP5YVLKix+XYRl6WlLLlMQMTingJIA5tOyP2mSvdCSWNQ66Lo/dyNqXxDU0q11NzL
         QrU2ZYsd9ukXYUSA8uWRbZeD1UgPd0uh4Fvo9e10d11l/TNZvbpbm9wtxgowGEY+dsm+
         BNfBENzHbbAqZGn22ROqo96wDSFe+Kw+JgDsUKNiAr1hEgFmBPTaLEwWB8OQFssIBB0V
         aENB3NkZc/luTW1x/MfX/74GAYJY6gVVZ2hvMXoI6OeLP2V4VBLHuKgMc4emRi9lhASQ
         Z+OFqFR28raNi8GxrS5OH6jsqdsLGi2ammKWGcVoo8lhG2UT51/2P3HAK3PWq/GY+VUX
         oJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6i0UTmPPF8Cqaki+Sf/d0U9XDX61u54JLShukSsW3O5C2w8GYPWQTo0uy0RUEqeCKK3Mm7ilHhaNu2oAe9BEroDS7Gm3X8v2Cvbv
X-Gm-Message-State: AOJu0Yy/GNef+9DWvY8TVg4vF5SvaQ26nkxNyhLNkjpHJuEbrZA8xMcn
	R7qFCHrEEnPwcR2SbGLz8zPWfX+4pngDlyGUmwtV+6zN5b0CS3uENagOCaeNkJNW/OnbkRQ8EdB
	AtsJ1GmwU2B31xkv8/vY3Ixgdk08=
X-Google-Smtp-Source: AGHT+IEHWzmDLF1EtSN193rAdplLXWInaEm0IE9RfHXtrWNxaJ4tBLiZUAp6iX5h2nQHbAMhiE1NGWy3xIPlalKhsYg=
X-Received: by 2002:a17:90b:3142:b0:2ca:f33b:9f26 with SMTP id
 98e67ed59e1d1-2cf238cc949mr1266468a91.28.1721866332062; Wed, 24 Jul 2024
 17:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724171459.281234-1-void@manifault.com> <20240724171459.281234-2-void@manifault.com>
In-Reply-To: <20240724171459.281234-2-void@manifault.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jul 2024 17:12:00 -0700
Message-ID: <CAEf4BzY6cc5L7_Yj3XvyCSZGxL=-Vb0g3drFRcsxDd9UB0QC9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for resizing data
 map with struct_ops
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:15=E2=80=AFAM David Vernet <void@manifault.com> =
wrote:
>
> Tests that if you resize a map after opening a skel, that it doesn't
> cause a UAF which causes a struct_ops map to fail to be able to load.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  .../bpf/prog_tests/struct_ops_resize.c        | 30 +++++++++++++++++++
>  .../selftests/bpf/progs/struct_ops_resize.c   | 24 +++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_res=
ize.c
>  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_resize.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_resize.c b=
/tools/testing/selftests/bpf/prog_tests/struct_ops_resize.c
> new file mode 100644
> index 000000000000..7584f91c2bd1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_resize.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "struct_ops_resize.skel.h"
> +
> +static void resize_datasec(void)
> +{
> +       struct struct_ops_resize *skel;
> +       int err;
> +
> +       skel =3D struct_ops_resize__open();
> +       if (!ASSERT_OK_PTR(skel, "struct_ops_resize__open"))
> +               return;
> +
> +       err  =3D bpf_map__set_value_size(skel->maps.data_resizable, 1 << =
15);
> +       if (!ASSERT_OK(err, "bpf_map__set_value_size"))
> +               goto cleanup;
> +
> +       err =3D struct_ops_resize__load(skel);
> +       ASSERT_OK(err, "struct_ops_resize__load");
> +
> +cleanup:
> +       struct_ops_resize__destroy(skel);
> +}
> +
> +void test_struct_ops_resize(void)
> +{
> +       if (test__start_subtest("resize_datasec"))
> +               resize_datasec();

It seems a bit unnecessary to add an entire new test with a subtest
just for this. Would you mind adding this testing logic into the
already existing prog_tests/global_map_resize.c set of cases?

I've applied patch #1, as it's obviously correct, so I didn't want to
delay the fix. Thanks!

> +}
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_resize.c b/tool=
s/testing/selftests/bpf/progs/struct_ops_resize.c
> new file mode 100644
> index 000000000000..d0b235f4bbaa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_resize.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +char resizable[1] SEC(".data.resizable");
> +
> +SEC("struct_ops/test_1")
> +int BPF_PROG(test_1)
> +{
> +       return 0;
> +}
> +
> +struct bpf_testmod_ops {
> +       int (*test_1)(void);
> +};
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod =3D {
> +       .test_1 =3D (void *)test_1
> +};
> --
> 2.45.2
>

