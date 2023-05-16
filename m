Return-Path: <bpf+bounces-674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE69970595C
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 23:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A643228132E
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CED271F3;
	Tue, 16 May 2023 21:18:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AEC290EA
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:18:16 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1935E5FD6
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:18:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso26680341a12.2
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684271892; x=1686863892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGnGmJRNXYU65zIbpvcv3zkVMV3Zy7jv09mSfPQxp0I=;
        b=g1brHj10FXNQXSiMaqt5NsQFVNU9qoebJ1vUylAUwkIBzCP0nlaoJIOTsBtaymrhRK
         fvPO9bPt4jSlWnpgaTE5P5X/DKp1XTcDcnFKh/LDiw5MxY6bSRxPZY5ag0awBzvVDXml
         sgmQ4e5CcUuxWIvPxrtMgcI04GI/L1VSMPJvtcoMgdaCM5Jk1pTRcpG0IT1DbqUxDIzI
         +yvmqx0/bKAT5vBvGPWqDbhfKoRcrwHIKNsad765qW64TIzFkvVagpyTNX15DVJThBho
         fCKPMU0TAoaFlm8qv9UduBnLO/OcrJdDAGibHN4lHgaazjtLbjf72JItJtXpTm2yx/jL
         LdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271892; x=1686863892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGnGmJRNXYU65zIbpvcv3zkVMV3Zy7jv09mSfPQxp0I=;
        b=j+l6zi1Huqs/DyeUzpvH///2AF+UV2XdqOSm6mlZL1jyCvgKWXj4EWivlWS3+TRc5H
         kl8J5u8h1PIG3LAV00ql5ozb7+v1K6a307jYP8eM+Mlivj1tXDT28f8bfFye/CQzTtLf
         pqqliu1LurhLlitBRIUAZ4OwemSXG9ZbzDBAS3Vwsa22SKl6OA21JGcFNuAvJ6GHe70w
         GM562+wUfZNZ9hgewvxfjEVuEUb4qnRJP3iQFl1kRull0KSUdRJu8Gq2U3fX7f83S2od
         SfgCNtuNExOYQwZXvg6jRMUMV5OmU9w7zATV7v9w4TKLTDyzQ2WIIxmVKG4Llcd/Q+yZ
         /Zeg==
X-Gm-Message-State: AC+VfDz+BxycATkkgAXkg7EuAgJCIYLlnc7UI0800C6TaCTauvwKBjog
	ZULw2SgCu1FKeq66nNrk8Qr//VygI9X/U5DgmRo=
X-Google-Smtp-Source: ACHHUZ6UsM1/nmcQbnOPxdsb8vuv7jZs9MRf52bARcrdv3ljU3S1CoEc+3UP3SJiV5sG6pwY9LWN2yn6WUsFQxexiJs=
X-Received: by 2002:a17:907:6e93:b0:962:582d:89bf with SMTP id
 sh19-20020a1709076e9300b00962582d89bfmr41951928ejc.55.1684271892265; Tue, 16
 May 2023 14:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230510223342.12886-1-inwardvessel@gmail.com> <20230510223342.12886-3-inwardvessel@gmail.com>
In-Reply-To: <20230510223342.12886-3-inwardvessel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 14:18:00 -0700
Message-ID: <CAEf4BzZn08FVATrGUFSgRAOjyrufY_HTUZ06bKCG4Rk6O-=-4A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] libbpf: selftests for resizing datasec maps
To: JP Kobryn <inwardvessel@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 3:33=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> This patch adds test coverage for resizing datasec maps. The first two
> subtests resize the bss and custom data sections. In both cases, an
> initial array (of length one) has its element set to one. After resizing
> the rest of the array is filled with ones as well. A BPF program is then
> run to sum the respective arrays and back on the userspace side the sum
> is checked to be equal to the number of elements.
> The third subtest attempts to perform resizing under conditions that
> will result in either the resize failing or the BTF info being dropped.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  .../bpf/prog_tests/global_map_resize.c        | 236 ++++++++++++++++++
>  .../bpf/progs/test_global_map_resize.c        |  58 +++++
>  2 files changed, 294 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/global_map_res=
ize.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_map_res=
ize.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_map_resize.c b=
/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
> new file mode 100644
> index 000000000000..58961789d0b3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +#include <errno.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +
> +#include "test_global_map_resize.skel.h"
> +#include "test_progs.h"
> +
> +static void run_prog_bss_array_sum(void)
> +{
> +       (void)syscall(__NR_getpid);
> +}
> +
> +static void run_prog_data_array_sum(void)
> +{
> +       (void)syscall(__NR_getuid);
> +}
> +
> +static void global_map_resize_bss_subtest(void)
> +{
> +       int err;
> +       struct test_global_map_resize *skel;
> +       struct bpf_map *map;
> +       const __u32 desired_sz =3D sizeof(skel->bss->sum) + (__u32)syscon=
f(_SC_PAGE_SIZE) * 2;
> +       size_t array_len, actual_sz;
> +
> +       skel =3D test_global_map_resize__open();
> +       if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
> +               goto teardown;
> +
> +       /* set some initial value before resizing.
> +        * it is expected this non-zero value will be preserved
> +        * while resizing.
> +        */
> +       skel->bss->array[0] =3D 1;
> +
> +       /* resize map value and verify the new size */
> +       map =3D skel->maps.bss;
> +       err =3D bpf_map__set_value_size(map, desired_sz);
> +       if (!ASSERT_OK(err, "bpf_map__set_value_size"))
> +               goto teardown;
> +       if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "resize"))
> +               goto teardown;
> +
> +       /* set the expected number of elements based on the resized array=
 */
> +       array_len =3D (desired_sz - sizeof(skel->bss->sum)) /
> +               (__u32)sizeof(skel->bss->array[0]);

(__u32) cast is not necessary, overly pedantic here :) same above for
desired_sz initialization


> +       if (!ASSERT_GT(array_len, 1, "array_len"))
> +               goto teardown;
> +
> +       skel->bss =3D
> +               (struct test_global_map_resize__bss *)bpf_map__initial_va=
lue(
> +                               skel->maps.bss, &actual_sz);

another unnecessary cast making the code ugly, please drop the casting part

> +       if (!ASSERT_OK_PTR(skel->bss, "bpf_map__initial_value (ptr)"))
> +               goto teardown;
> +       if (!ASSERT_EQ(actual_sz, desired_sz, "bpf_map__initial_value (si=
ze)"))
> +               goto teardown;
> +
> +       /* fill the newly resized array with ones,
> +        * skipping the first element which was previously set
> +        */
> +       for (int i =3D 1; i < array_len; i++)
> +               skel->bss->array[i] =3D 1;
> +
> +       /* set global const values before loading */
> +       skel->rodata->pid =3D getpid();
> +       skel->rodata->bss_array_len =3D array_len;
> +       skel->rodata->data_array_len =3D 1;
> +
> +       err =3D test_global_map_resize__load(skel);
> +       if (!ASSERT_OK(err, "test_global_map_resize__load"))
> +               goto teardown;
> +       err =3D test_global_map_resize__attach(skel);
> +       if (!ASSERT_OK(err, "test_global_map_resize__attach"))
> +               goto teardown;
> +
> +       /* run the bpf program which will sum the contents of the array.
> +        * since the array was filled with ones,verify the sum equals arr=
ay_len
> +        */
> +       run_prog_bss_array_sum();
> +       if (!ASSERT_EQ(skel->bss->sum, array_len, "sum"))
> +               goto teardown;
> +
> +teardown:
> +       test_global_map_resize__destroy(skel);
> +}
> +
> +static void global_map_resize_data_subtest(void)
> +{
> +       int err;
> +       struct test_global_map_resize *skel;
> +       struct bpf_map *map;
> +       const __u32 desired_sz =3D (__u32)sysconf(_SC_PAGE_SIZE) * 2;
> +       size_t array_len, actual_sz;
> +
> +       skel =3D test_global_map_resize__open();
> +       if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
> +               goto teardown;
> +
> +       /* set some initial value before resizing.
> +        * it is expected this non-zero value will be preserved
> +        * while resizing.
> +        */
> +       skel->data_custom->my_array[0] =3D 1;
> +
> +       /* resize map value and verify the new size */
> +       map =3D skel->maps.data_custom;
> +       err =3D bpf_map__set_value_size(map, desired_sz);
> +       if (!ASSERT_OK(err, "bpf_map__set_value_size"))
> +               goto teardown;
> +       if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "resize"))
> +               goto teardown;
> +
> +       /* set the expected number of elements based on the resized array=
 */
> +       array_len =3D (desired_sz - sizeof(skel->bss->sum)) /
> +               (__u32)sizeof(skel->data_custom->my_array[0]);
> +       if (!ASSERT_GT(array_len, 1, "array_len"))
> +               goto teardown;
> +
> +       skel->data_custom =3D
> +               (struct test_global_map_resize__data_custom *)bpf_map__in=
itial_value(
> +                               skel->maps.data_custom, &actual_sz);

all the same points about pedantic and unnecessary casts, please simplify

> +       if (!ASSERT_OK_PTR(skel->data_custom, "bpf_map__initial_value (pt=
r)"))
> +               goto teardown;
> +       if (!ASSERT_EQ(actual_sz, desired_sz, "bpf_map__initial_value (si=
ze)"))
> +               goto teardown;
> +
> +       /* fill the newly resized array with ones,
> +        * skipping the first element which was previously set
> +        */
> +       for (int i =3D 1; i < array_len; i++)
> +               skel->data_custom->my_array[i] =3D 1;
> +
> +       /* set global const values before loading */
> +       skel->rodata->pid =3D getpid();
> +       skel->rodata->bss_array_len =3D 1;
> +       skel->rodata->data_array_len =3D array_len;
> +
> +       err =3D test_global_map_resize__load(skel);
> +       if (!ASSERT_OK(err, "test_global_map_resize__load"))
> +               goto teardown;
> +       err =3D test_global_map_resize__attach(skel);
> +       if (!ASSERT_OK(err, "test_global_map_resize__attach"))
> +               goto teardown;
> +
> +       /* run the bpf program which will sum the contents of the array.
> +        * since the array was filled with ones,verify the sum equals arr=
ay_len
> +        */
> +       run_prog_data_array_sum();
> +       if (!ASSERT_EQ(skel->bss->sum, array_len, "sum"))
> +               goto teardown;
> +
> +teardown:
> +       test_global_map_resize__destroy(skel);
> +}
> +
> +static void global_map_resize_invalid_subtest(void)
> +{
> +       int err;
> +       struct test_global_map_resize *skel;
> +       struct bpf_map *map;
> +       __u32 element_sz, desired_sz;
> +
> +       skel =3D test_global_map_resize__open();
> +       if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
> +               return;
> +
> +        /* attempt to resize a global datasec map to size
> +         * which does NOT align with array
> +         */

indentation seems off, please double check

> +       map =3D skel->maps.data_custom;
> +       if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, ".data.custom=
 initial btf"))
> +               goto teardown;
> +       /* set desired size a fraction of element size beyond an aligned =
size */
> +       element_sz =3D (__u32)sizeof(skel->data_custom->my_array[0]);
> +       desired_sz =3D element_sz + element_sz / 2;
> +       /* confirm desired size does NOT align with array */
> +       if (!ASSERT_NEQ(desired_sz % element_sz, 0, "my_array alignment")=
)
> +               goto teardown;
> +       err =3D bpf_map__set_value_size(map, desired_sz);
> +       /* confirm resize is OK but BTF info is dropped */
> +       if (!ASSERT_OK(err, ".data.custom bpf_map__set_value_size") ||
> +               !ASSERT_EQ(bpf_map__btf_key_type_id(map), 0, ".data.custo=
m drop btf key") ||
> +               !ASSERT_EQ(bpf_map__btf_value_type_id(map), 0, ".data.cus=
tom drop btf val"))
> +               goto teardown;
> +
> +       /* attempt to resize a global datasec map
> +        * whose only var is NOT an array
> +        */
> +       map =3D skel->maps.data_non_array;
> +       if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, ".data.non_ar=
ray initial btf"))
> +               goto teardown;
> +       /* set desired size to arbitrary value */
> +       desired_sz =3D 1024;
> +       err =3D bpf_map__set_value_size(map, desired_sz);
> +       /* confirm resize is OK but BTF info is dropped */
> +       if (!ASSERT_OK(err, ".data.non_array bpf_map__set_value_size") ||
> +               !ASSERT_EQ(bpf_map__btf_key_type_id(map), 0, ".data.non_a=
rray drop btf key") ||
> +               !ASSERT_EQ(bpf_map__btf_value_type_id(map), 0, ".data.non=
_array drop btf val"))
> +               goto teardown;
> +
> +       /* attempt to resize a global datasec map
> +        * whose last var is NOT an array
> +        */
> +       map =3D skel->maps.data_array_not_last;
> +       if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, ".data.array_=
not_last initial btf"))
> +               goto teardown;
> +       /* set desired size to a multiple of element size */
> +       element_sz =3D (__u32)sizeof(skel->data_array_not_last->my_array_=
first[0]);
> +       desired_sz =3D element_sz * 8;
> +       /* confirm desired size aligns with array */
> +       if (!ASSERT_EQ(desired_sz % element_sz, 0, "my_array_first alignm=
ent"))
> +               goto teardown;
> +       err =3D bpf_map__set_value_size(map, desired_sz);
> +       /* confirm resize is OK but BTF info is dropped */
> +       if (!ASSERT_OK(err, ".data.array_not_last bpf_map__set_value_size=
") ||
> +               !ASSERT_EQ(bpf_map__btf_key_type_id(map), 0, ".data.array=
_not_last drop btf key") ||
> +               !ASSERT_EQ(bpf_map__btf_value_type_id(map), 0, ".data.arr=
ay_not_last drop btf val"))
> +               goto teardown;
> +
> +teardown:
> +       test_global_map_resize__destroy(skel);
> +}
> +
> +void test_global_map_resize(void)
> +{
> +       if (test__start_subtest("global_map_resize_bss"))
> +               global_map_resize_bss_subtest();
> +
> +       if (test__start_subtest("global_map_resize_data"))
> +               global_map_resize_data_subtest();
> +
> +       if (test__start_subtest("global_map_resize_invalid"))
> +               global_map_resize_invalid_subtest();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_global_map_resize.c b=
/tools/testing/selftests/bpf/progs/test_global_map_resize.c
> new file mode 100644
> index 000000000000..2588f2384246
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +/* rodata section */
> +const volatile pid_t pid;
> +const volatile size_t bss_array_len;
> +const volatile size_t data_array_len;
> +
> +/* bss section */
> +int sum =3D 0;
> +int array[1];
> +
> +/* custom data secton */

typo: section

> +int my_array[1] SEC(".data.custom");
> +
> +/* custom data section which should NOT be resizable,
> + * since it contains a single var which is not an array
> + */
> +int my_int SEC(".data.non_array");
> +
> +/* custom data section which should NOT be resizable,
> + * since its last var is not an array
> + */
> +int my_array_first[1] SEC(".data.array_not_last");
> +int my_int_last SEC(".data.array_not_last");
> +
> +SEC("tp/syscalls/sys_enter_getpid")
> +int bss_array_sum(void *ctx)
> +{
> +       if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
> +               return 0;
> +
> +       sum =3D 0;
> +
> +       for (size_t i =3D 0; i < bss_array_len; ++i)
> +               sum +=3D array[i];
> +
> +       return 0;
> +}
> +
> +SEC("tp/syscalls/sys_enter_getuid")
> +int data_array_sum(void *ctx)
> +{
> +       if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
> +               return 0;
> +
> +       sum =3D 0;
> +
> +       for (size_t i =3D 0; i < data_array_len; ++i)
> +               sum +=3D my_array[i];
> +
> +       return 0;
> +}
> --
> 2.40.0
>

