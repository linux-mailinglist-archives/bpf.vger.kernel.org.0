Return-Path: <bpf+bounces-9572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC587992D0
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 01:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30281C20D1F
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FDB746E;
	Fri,  8 Sep 2023 23:25:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A401FBF
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 23:25:46 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D92E45
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 16:25:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-502a4f33440so1076991e87.1
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694215542; x=1694820342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgXlhFjH3EBoT8IuUs4Xu08zaFEheH3uGMua63oHp9s=;
        b=oGIFTZ0PnsCb7kAvoWe/0iFMYCXs4huHI8+u0d/xJFhtq2kojWw7bvCjxuKsg/FfQS
         LhutBh+atHSJ8XweOjyEOVnbENJBU4EfjXHX1qKJUA0zpgWZ8up3AtddMXhRb6wixYyv
         QEoFYozPEy3kBodQ/YPCOtp+o/x9EJl6cYr3r4hoERYl597aXdVHqpgb83/ptA7uscHS
         IEFX1pe+YhjdeAqdqVfkLIb0l+m7ZbvOnobvKPHSuhxc0vKoLzKt48/7GqH5m7PHWRAp
         ldAYcvFiJrg21nVWtgittf6uTW/olmf6fgdAWNw1n3vzxzs/rMGYE56o9VG7dRL33d3b
         NYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694215542; x=1694820342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgXlhFjH3EBoT8IuUs4Xu08zaFEheH3uGMua63oHp9s=;
        b=H+Ul5BBB7hLVbHmXEozAvtaRrdcsKe14oC1v9toLKad0pD3DzXYXziigaKaQcMMHe7
         bIaFbYeDAG5+0l7FthZOufM5i7HNnh01qRmcg0o8zq5hbrZd9msXGj/sOuO1wJZEPTpI
         VLQN4ykSAtBBt8YINhXydyIQYrPoKTeoWg+hayjei13DyIoO1dicDWxhE5KurSKgrH5C
         uqpL7eBr7XcdG+X0qNGOgQlMLOC7iZkbpWWoq8YPhSK4dVuRp+2yOvZhdOyIeD1U2rJD
         5ynVhArwnW24unaJHiEQtGKzV9MJmaryZy4r9c2s/zkg2/NM2gw2kG54z3b6MTSv3KO1
         WgJQ==
X-Gm-Message-State: AOJu0Yw/VqBurU83g9wMwPNW1rIHJoQS5V0luixg7wZsaSOA5UI9TQr4
	Y1b0rQqc0Z7rqCT7ilz0k+G8cqBFP+2R9Ku/rCA=
X-Google-Smtp-Source: AGHT+IHBCUKGm0G1uVxSzfF5jTbqYIcRx3FjpyS3xXZ3rg9w2WkeZqDzY82N01LLmTQ6LTX/zYCh1fT8SE4Zm5XHswc=
X-Received: by 2002:a05:6512:3188:b0:500:b63f:4db3 with SMTP id
 i8-20020a056512318800b00500b63f4db3mr3307567lfe.35.1694215542043; Fri, 08 Sep
 2023 16:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-8-jolsa@kernel.org>
In-Reply-To: <20230907071311.254313-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Sep 2023 16:25:30 -0700
Message-ID: <CAEf4BzZwqq73Gj9pr9A52E2fXbm_Pn+oXX7qmTzw8hEuikK3kw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 7/9] selftests/bpf: Add test for missed counts
 of perf event link kprobe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 12:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that puts kprobe on bpf_fentry_test1 that calls
> bpf_kfunc_common_test kfunc, which has also kprobe on.
>
> The latter won't get triggered due to kprobe recursion check
> and kprobe missed counter is incremented.
>
> Acked-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  5 ++
>  .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  2 +
>  .../testing/selftests/bpf/prog_tests/missed.c | 47 +++++++++++++++++++
>  .../selftests/bpf/progs/missed_kprobe.c       | 30 ++++++++++++
>  4 files changed, 84 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/missed.c
>  create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index cefc5dd72573..a5e246f7b202 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -138,6 +138,10 @@ __bpf_kfunc void bpf_iter_testmod_seq_destroy(struct=
 bpf_iter_testmod_seq *it)
>         it->cnt =3D 0;
>  }
>
> +__bpf_kfunc void bpf_kfunc_common_test(void)
> +{
> +}
> +
>  struct bpf_testmod_btf_type_tag_1 {
>         int a;
>  };
> @@ -343,6 +347,7 @@ BTF_SET8_START(bpf_testmod_common_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL=
)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_kfunc_common_test)
>  BTF_SET8_END(bpf_testmod_common_kfunc_ids)
>
>  static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set =3D {
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h =
b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> index f5c5b1375c24..7c664dd61059 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> @@ -104,4 +104,6 @@ void bpf_kfunc_call_test_fail1(struct prog_test_fail1=
 *p);
>  void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p);
>  void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
>  void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
> +
> +void bpf_kfunc_common_test(void) __ksym;
>  #endif /* _BPF_TESTMOD_KFUNC_H */
> diff --git a/tools/testing/selftests/bpf/prog_tests/missed.c b/tools/test=
ing/selftests/bpf/prog_tests/missed.c
> new file mode 100644
> index 000000000000..fc674258c81f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/missed.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "missed_kprobe.skel.h"
> +
> +/*
> + * Putting kprobe on bpf_fentry_test1 that calls bpf_kfunc_common_test
> + * kfunc, which has also kprobe on. The latter won't get triggered due
> + * to kprobe recursion check and kprobe missed counter is incremented.
> + */
> +static void test_missed_perf_kprobe(void)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +       struct bpf_link_info info =3D {};
> +       struct missed_kprobe *skel;
> +       __u32 len =3D sizeof(info);
> +       int err, prog_fd;
> +
> +       skel =3D missed_kprobe__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "missed_kprobe__open_and_load"))
> +               goto cleanup;
> +
> +       err =3D missed_kprobe__attach(skel);
> +       if (!ASSERT_OK(err, "missed_kprobe__attach"))
> +               goto cleanup;
> +
> +       prog_fd =3D bpf_program__fd(skel->progs.trigger);
> +       err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +       ASSERT_OK(err, "test_run");
> +       ASSERT_EQ(topts.retval, 0, "test_run");
> +
> +       err =3D bpf_link_get_info_by_fd(bpf_link__fd(skel->links.test2), =
&info, &len);
> +       if (!ASSERT_OK(err, "bpf_link_get_info_by_fd"))
> +               goto cleanup;
> +
> +       ASSERT_EQ(info.type, BPF_LINK_TYPE_PERF_EVENT, "info.type");
> +       ASSERT_EQ(info.perf_event.type, BPF_PERF_EVENT_KPROBE, "info.perf=
_event.type");
> +       ASSERT_EQ(info.perf_event.kprobe.missed, 1, "info.perf_event.kpro=
be.missed");
> +
> +cleanup:
> +       missed_kprobe__destroy(skel);
> +}
> +
> +void serial_test_missed(void)

why serial? if you check for kprobe.missed >=3D 1, it should be fine
even if some other test calls this testmod kfunc, right?

> +{
> +       if (test__start_subtest("perf_kprobe"))
> +               test_missed_perf_kprobe();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/missed_kprobe.c b/tools/te=
sting/selftests/bpf/progs/missed_kprobe.c
> new file mode 100644
> index 000000000000..7f9ef701f5de
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/missed_kprobe.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod_kfunc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +/*
> + * No tests in here, just to trigger 'bpf_fentry_test*'
> + * through tracing test_run
> + */
> +SEC("fentry/bpf_modify_return_test")
> +int BPF_PROG(trigger)
> +{
> +       return 0;
> +}
> +
> +SEC("kprobe/bpf_fentry_test1")
> +int test1(struct pt_regs *ctx)
> +{
> +       bpf_kfunc_common_test();
> +       return 0;
> +}
> +
> +SEC("kprobe/bpf_kfunc_common_test")
> +int test2(struct pt_regs *ctx)
> +{
> +       return 0;
> +}
> --
> 2.41.0
>

