Return-Path: <bpf+bounces-51166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D7FA312D2
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 18:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304DE3A1341
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC68262D1F;
	Tue, 11 Feb 2025 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tow8y5Qe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B52505A8
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294620; cv=none; b=AzfLdZHMUSwdwD/+3vhLXYUcL/Av+7bvFyIUkit14pYVLNyOTXL5RcwkC9EDLXLrqr8qwcybMEScaIxG+xvduzUHgL+9TruQzYjAWTv+wTprrPZGIb7xcES/O0ReeNDqNB+m9nwqQuP292ue5rPKts6B7LggAzNfRZIGtrOHNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294620; c=relaxed/simple;
	bh=9+eL+nIt4iCtFIgP9YQ2UO9+R8rTw4qseu4S8nex/aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8ULoxTChxfL3596trUANWLnVTdC7r6vjRoplVi3m32Bjq6jWT2FXuzdFOZKZEQsprpw8ha3pLnRXCbMxqJGrn0HMcd0dPPyxiGlKHbjUOXsPmVnvmYgSC1eaihl3gqHwOFQ6HPas7d4caVb0SR+QwRuxZ2qgu/lvsrjr1piEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tow8y5Qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972E0C4CEDD
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739294619;
	bh=9+eL+nIt4iCtFIgP9YQ2UO9+R8rTw4qseu4S8nex/aI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tow8y5QeOW9Xj1wY6lUUvS42OGwo0Re6kflVqnG+dyWYLZQ0RSu9RSry6Yr0rDtbW
	 V18mse+nTIzOfbzGC+tXhvV5OfaDuVcf7+0OtMGPTx7pxiToEdFWrWeggTp7I0ci/i
	 FN/rHO5X5+Qx4DSE1CuV+RqNUkyk1c+xSPtGlY4nGTcrMBVzzGsiT7CmksavHTdgj/
	 uWW3xNZyD2DzVBxht28757hdae1jOO3uGmrN47JaLP/PSf1mOJgMakpW/VEe45eqlf
	 vnCVf3wrIl4jsuWhqktHR1vTVr/7DEYGGlePJP0awYE/99B0S+bsEG/zShmnfk23nJ
	 SiuHjOqfHvYJA==
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-855309015fdso54513739f.1
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 09:23:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyXeL70o0z9c+YTDTDmjbsti4h2ZdtCwcUf/y9EryC3ebulTP/x3a09xhjMDoNawrBaQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Vr6HfQ2RD9LihJNnfBv66M/Yi1qpdUQhPlpMCFRa+aF95h1i
	SCE5XMbXU+tgO3JeUiBHMx6wB7OP0oWMoazgwKphGnIusno4Du4I8XnXe8l+BakblDF37+x7CW+
	OAE2CiACDBj+Qzl0gUU8OS3G6r7g=
X-Google-Smtp-Source: AGHT+IH02AiUlIH0FJ84jc4HQqeV+sA+og4AktRF8yPa6QdnF8WweJsilU8eud43mU5AZP1+IDvRPOIny0F8hRllYsQ=
X-Received: by 2002:a92:c54c:0:b0:3d0:4e2b:9bbb with SMTP id
 e9e14a558f8ab-3d17c006af6mr2046225ab.21.1739294619038; Tue, 11 Feb 2025
 09:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211023359.1570-1-laoar.shao@gmail.com> <20250211023359.1570-4-laoar.shao@gmail.com>
In-Reply-To: <20250211023359.1570-4-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Feb 2025 09:23:28 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6bbbmQFpEX_xHTb9PDq+Xf_p0FH62NwzN6PcPKzi0MrA@mail.gmail.com>
X-Gm-Features: AWEUYZkZkAjrlCyBWGbauNKc422-OTqQcvKTpQwrWZSXuUtNcqt0ELE81hB-zEA
Message-ID: <CAPhsuW6bbbmQFpEX_xHTb9PDq+Xf_p0FH62NwzN6PcPKzi0MrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add selftest for attaching
 fexit to __noreturn functions
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, jpoimboe@kernel.org, 
	peterz@infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 6:34=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> The reuslt:
>
>   $ tools/testing/selftests/bpf/test_progs --name=3Dfexit_noreturns
>   #99      fexit_noreturns:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/fexit_noreturns.c      | 13 +++++++++++++
>  tools/testing/selftests/bpf/progs/fexit_noreturns.c | 13 +++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturn=
s.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c b/t=
ools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
> new file mode 100644
> index 000000000000..588362275ed7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "fexit_noreturns.skel.h"
> +
> +void test_fexit_noreturns(void)
> +{
> +       struct fexit_noreturns *fexit_skel;
> +
> +       fexit_skel =3D fexit_noreturns__open_and_load();
> +       ASSERT_NULL(fexit_skel, "fexit_load");
> +       ASSERT_EQ(errno, EINVAL, "can't load fexit_noreturns");
> +}
> diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tools/=
testing/selftests/bpf/progs/fexit_noreturns.c
> new file mode 100644
> index 000000000000..003aafe2b896
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +SEC("fexit/do_exit")

We can add:

__failure __msg(<verifier log added in 2/3>)

here.
> +int BPF_PROG(noreturns)
> +{
> +       return 0;
> +}
> --
> 2.43.5
>

Then, test_fexit_noreturns above can simply be:

void test_fexit_noreturns(void)
{
        RUN_TESTS(fexit_noreturns);
}

Thanks,
Song

