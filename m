Return-Path: <bpf+bounces-9448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395BE797C6E
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F4628171C
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6CD14006;
	Thu,  7 Sep 2023 18:55:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9E411CA8
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2927AC433CD
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694112942;
	bh=1SEXiuszeOT08dDE5c6w28AtCxBo9HnCHPQcaewCYjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZzWQkPLB9Sc8QvnjWDTx4WODdlsNnD+hGdWaHc4878YKUK84BL4amO5ATIPxeGl5H
	 +gD4h6s1n73rGXUcBz7bwNn9KlhcvgoVM5hYAeLrM6hxot2C5sOnxAXcS2Cj1czy5D
	 XAoGGoHiCzP+nzmsFEcPnymhzSd2u1YEOSg6gKmGmARBTFfh2b3PA4y5yQoxjL7i70
	 ygwa1l4+owr8Cl8oEj/0j3kbYk3pIdEHtAowtWxo7fxcjF7lVVqF69hJK4FhkzvpZS
	 CUvV1Q4OcmgxQZBp0t4jswHy575uEMFZaEemlFQzGiWEtdviX3TSCpIsZdnar770Tw
	 FUBEia9LOwPpQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b974031aeaso23431741fa.0
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 11:55:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YzCxV4CLJzdO6O48ow7gi9hMNPRSEduJM6EBjWipwTWJQDPZu/h
	eklNSUPDCkvlP7f1Ty3gXA3Eq17flukpnRpSWwY=
X-Google-Smtp-Source: AGHT+IE9pC4rmhSZNqCBW47rpfUAjjSkjMVYiLPQpuO4Syh41H4/W692LiZMKxQ0OoBjtUhSKKNEUyiA++/NR6fdzJI=
X-Received: by 2002:ac2:58c9:0:b0:500:d9db:dc0a with SMTP id
 u9-20020ac258c9000000b00500d9dbdc0amr169584lfo.65.1694112940095; Thu, 07 Sep
 2023 11:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-9-jolsa@kernel.org>
In-Reply-To: <20230907071311.254313-9-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 7 Sep 2023 11:55:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5uG9rAdnUCnMUy6EJhh8xU+2ARe-_bQApSD9_XekNvFg@mail.gmail.com>
Message-ID: <CAPhsuW5uG9rAdnUCnMUy6EJhh8xU+2ARe-_bQApSD9_XekNvFg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 8/9] selftests/bpf: Add test for recursion
 counts of perf event link kprobe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 7, 2023 at 12:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding selftest that puts kprobe.multi on bpf_fentry_test1 that
> calls bpf_kfunc_common_test kfunc which has 3 perf event kprobes
> and 1 kprobe.multi attached.
>
> Because fprobe (kprobe.multi attach layear) does not have strict
> recursion check the kprobe's bpf_prog_active check is hit for test2-5.
>
> Disabling this test for arm64, because there's no fprobe support yet.
>
> Acked-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-and-tested-by: Song Liu <song@kernel.org>

With on nitpick below.

> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
>  .../testing/selftests/bpf/prog_tests/missed.c | 51 +++++++++++++++++++
>  .../bpf/progs/missed_kprobe_recursion.c       | 48 +++++++++++++++++
>  3 files changed, 100 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe_recur=
sion.c
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing=
/selftests/bpf/DENYLIST.aarch64
> index 7f768d335698..3f2187c049db 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -15,3 +15,4 @@ fexit_test/fexit_many_args                       # fexi=
t_many_args:FAIL:fexit_ma
>  fill_link_info/kprobe_multi_link_info            # bpf_program__attach_k=
probe_multi_opts unexpected error: -95
>  fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_k=
probe_multi_opts unexpected error: -95
>  fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_k=
probe_multi_opts unexpected error: -95
> +missed/kprobe_recursion                          # missed_kprobe_recursi=
on__attach unexpected error: -95 (errno 95)
> diff --git a/tools/testing/selftests/bpf/prog_tests/missed.c b/tools/test=
ing/selftests/bpf/prog_tests/missed.c
> index fc674258c81f..f10dc9232b3f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/missed.c
> +++ b/tools/testing/selftests/bpf/prog_tests/missed.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
>  #include "missed_kprobe.skel.h"
> +#include "missed_kprobe_recursion.skel.h"
>
>  /*
>   * Putting kprobe on bpf_fentry_test1 that calls bpf_kfunc_common_test
> @@ -40,8 +41,58 @@ static void test_missed_perf_kprobe(void)
>         missed_kprobe__destroy(skel);
>  }
>
> +static __u64 get_count(int fd)

nit: Probably rename it as get_missed_count() or get_missed().

> +{
> +       struct bpf_prog_info info =3D {};
> +       __u32 len =3D sizeof(info);
> +       int err;
> +
> +       err =3D bpf_prog_get_info_by_fd(fd, &info, &len);
> +       if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
> +               return (__u64) -1;
> +       return info.recursion_misses;
> +}
[...]

