Return-Path: <bpf+bounces-15587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FB17F36D4
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35840B213A2
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969875B20D;
	Tue, 21 Nov 2023 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDixGpmk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3523F191
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 11:35:05 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507e85ebf50so7829166e87.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 11:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700595303; x=1701200103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCujqdOyqO6LqGAatE08o7V6PB8cE/BwvgtCj5rQRc8=;
        b=IDixGpmkjNszZqDkdakjvbmMM9hI+JJ7NcxBfTVutuqkq/eMMxUCTscPOY/J4ZjUlV
         RI4MmzYctTx+r46peoXkP9Ogwpwq+JD7NNfFRIE0gu+BRAweV5+qArz1F2vBSIp3FN7o
         DDR73ePhQX0n+0KRD4eKqPenwf9j9Ywr/C7AhjQRLPyDSptYIljkE48RBHwN2nHLMKQX
         6WlYiI5Mm91pZlM+VVAOEFKx8QMVEEDC5N6E8fXd3Slo/PhjZiZ6USV7y7q1NifvUgCf
         Q21Lmnue8Q+QdMtYopfhWh2VJLWSLc1AaSxHmFC41ATFxqNc0xa+TrKWZ8Xv2HiT0P2G
         KrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700595303; x=1701200103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCujqdOyqO6LqGAatE08o7V6PB8cE/BwvgtCj5rQRc8=;
        b=qaqywYxMm6LOMjSs7QTtL1eMhNFqA+8kkF51NpYNzua/08UxUj1IFXemQDb8D1Si0T
         6OQvECKDejY+Bn4AJr1vElGFLwVtqXQfMHnX18nALlMPoxkNBMFqP/HDok6NI5X+1Axz
         M/yjsrW7lP/rbq4wETZmJc1FeP1GIzY++YwaaCalZzTi16jrOrIGmD+gNF/OElQLrg4c
         ly0YX+O/75rm2tszUHgMPkYeLWTErYrEjJ6JKx4OMWPbYevMMiPwVFGARM774vZryKTM
         P6boXO902SvGq2eEIJdVh4Np3q4NMWGItbgd2BmkCoQyaDv2e62cVF55KIlHGGZuIqk+
         XZdg==
X-Gm-Message-State: AOJu0Ywwb0YBwSQens6Th9UHZPvTkAeoCJvQp0XMtui5Su0mZV7y4qbA
	l6Q4cpJMaWeh0R+6YjQNxCRX4GzYqBHyaV0I2SI=
X-Google-Smtp-Source: AGHT+IFwujHtatp/4Ebd9ZTT7xNXfm+newEB18JTJ9ta5np6RPMjbAuWLNRj4iZECyC1C3pXzApMDwumx7RkOYVqafQ=
X-Received: by 2002:ac2:51a7:0:b0:507:b988:7c3c with SMTP id
 f7-20020ac251a7000000b00507b9887c3cmr112411lfk.65.1700595302912; Tue, 21 Nov
 2023 11:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120175925.733167-1-davemarchevsky@fb.com> <20231120175925.733167-3-davemarchevsky@fb.com>
In-Reply-To: <20231120175925.733167-3-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Nov 2023 11:34:51 -0800
Message-ID: <CAEf4BzZFm8j1WmSYsPJ8OYXqVBOZSb7V-ENNhy3POJB=3xKL0Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 2/2] selftests/bpf: Add test exercising
 mmapable task_local_storage
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 9:59=E2=80=AFAM Dave Marchevsky <davemarchevsky@fb.=
com> wrote:
>
> This patch tests mmapable task_local storage functionality added earlier
> in the series. The success tests focus on verifying correctness of the
> various ways of reading from and writing to mmapable task_local storage:
>
>   * Write through mmap'd region should be visible when BPF program
>     makes bpf_task_storage_get call
>   * If BPF program reads-and-incrs the mapval, the new value should be
>     visible when userspace reads from mmap'd region or does
>     map_lookup_elem call
>   * If userspace does map_update_elem call, new value should be visible
>     when userspace reads from mmap'd region or does map_lookup_elem
>     call
>   * After bpf_map_delete_elem, reading from mmap'd region should still
>     succeed, but map_lookup_elem w/o BPF_LOCAL_STORAGE_GET_F_CREATE flag
>     should fail
>   * After bpf_map_delete_elem, creating a new map_val via mmap call
>     should return a different memory region
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  .../bpf/prog_tests/task_local_storage.c       | 177 ++++++++++++++++++
>  .../bpf/progs/task_local_storage__mmap.c      |  59 ++++++
>  .../bpf/progs/task_local_storage__mmap.h      |   7 +
>  .../bpf/progs/task_local_storage__mmap_fail.c |  39 ++++
>  4 files changed, 282 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_=
_mmap.c
>  create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_=
_mmap.h
>  create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_=
_mmap_fail.c
>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/task_local_storage__mmap.c=
 b/tools/testing/selftests/bpf/progs/task_local_storage__mmap.c
> new file mode 100644
> index 000000000000..1c8850c8d189
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_local_storage__mmap.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "task_local_storage__mmap.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_MMAPABLE);
> +       __type(key, int);
> +       __type(value, long);
> +} mmapable SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_MMAPABLE);
> +       __type(key, int);
> +       __type(value, struct two_page_struct);
> +} mmapable_two_pages SEC(".maps");
> +
> +long mmaped_mapval =3D 0;
> +int read_and_incr =3D 0;
> +int create_flag =3D 0;
> +int use_big_mapval =3D 0;
> +
> +SEC("tp_btf/sys_enter")
> +int BPF_PROG(on_enter, struct pt_regs *regs, long id)
> +{
> +       struct two_page_struct *big_mapval;
> +       struct task_struct *task;
> +       long *ptr;
> +

In addition to the note below about idempotency as a desired property,
it might be good to *also* add tid/pid filter here to only execute the
logic for our process?


> +       task =3D bpf_get_current_task_btf();
> +       if (!task)
> +               return 1;
> +
> +       if (use_big_mapval) {
> +               big_mapval =3D bpf_task_storage_get(&mmapable_two_pages, =
task, 0,
> +                                                 create_flag);
> +               if (!big_mapval)
> +                       return 2;
> +               ptr =3D &big_mapval->val;
> +       } else {
> +               ptr =3D bpf_task_storage_get(&mmapable, task, 0, create_f=
lag);
> +       }
> +
> +       if (!ptr)
> +               return 3;
> +
> +       if (read_and_incr)
> +               *ptr =3D *ptr + 1;

this seems fragile, this program is not idempotent, which means any
extra unexpected syscall might cause problem, right?

> +
> +       mmaped_mapval =3D *ptr;
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/task_local_storage__mmap.h=
 b/tools/testing/selftests/bpf/progs/task_local_storage__mmap.h
> new file mode 100644
> index 000000000000..f4a3264142c2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_local_storage__mmap.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +struct two_page_struct {
> +       long val;
> +       char c[4097];
> +};
> diff --git a/tools/testing/selftests/bpf/progs/task_local_storage__mmap_f=
ail.c b/tools/testing/selftests/bpf/progs/task_local_storage__mmap_fail.c
> new file mode 100644
> index 000000000000..f32c5bfe370a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_local_storage__mmap_fail.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_MMAPABLE);
> +       __type(key, int);
> +       __type(value, long);
> +} mmapable SEC(".maps");
> +
> +__failure __msg("invalid access to map value, value_size=3D8 off=3D8 siz=
e=3D8")
> +SEC("tp_btf/sys_enter")

let's keep SEC() first, please move __failure and __msg below it


> +long BPF_PROG(fail_read_past_mapval_end, struct pt_regs *regs, long id)
> +{
> +       struct task_struct *task;
> +       long *ptr;
> +       long res;
> +
> +       task =3D bpf_get_current_task_btf();
> +       if (!task)
> +               return 1;
> +
> +       ptr =3D bpf_task_storage_get(&mmapable, task, 0, 0);
> +       if (!ptr)
> +               return 3;
> +       /* Although mmapable mapval is given an entire page, verifier sho=
uldn't
> +        * allow r/w past end of 'long' type
> +        */
> +       res =3D *(ptr + 1);
> +
> +       return res;
> +}
> --
> 2.34.1
>

