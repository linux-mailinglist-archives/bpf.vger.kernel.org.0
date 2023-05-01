Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54A86F3B19
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 01:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjEAXzm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 19:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjEAXzf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 19:55:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432B0EE
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 16:55:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f109b1808so621617066b.1
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 16:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682985332; x=1685577332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4sA8V3HV5t+JumfczrXk/HUfmun/GoRjK0uGrPtDl4=;
        b=DSARGhJeZBbtOylEfmxHptxzzIV114Ihr3/S/VKlMPILkgilydbge3Zi93wtUnxkUU
         ypc7GlgUt090RADsgk5+ork8LmUQnDNjgBO326FZ2p1jB4qBRLbRKx0lOfgPpqulltlX
         9plQSyJbnDLdo4VJXHvrb4TEgB421kqf77SZWS30AckOyrLzVaMBUZP9SHndIqPRx7M+
         dT2zlSdOMNbu31/78XAw8Wj2EddLeV9TBGJqG+pv0TcivAwTr27Hwz62WI+tC5WVvLg1
         76yFttPHiruGmo6tykZ4sffxpXAjwV93nL5/N8zL9G1oegVqPMO5GRm30J8wx5MLb+vt
         OPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682985332; x=1685577332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4sA8V3HV5t+JumfczrXk/HUfmun/GoRjK0uGrPtDl4=;
        b=Q5Cjb+lPvIJgnJtjWK931cj4PuVrAfzGx1RX/jtlMcx1+deG8SIDTpRnrEvTVwh5Pv
         flz2RWQCpoLDbNLjcss4NGFCt5lzMjFYtP1QfDtWH8BhY5uRGVXH04Yyn8qjH4b9huZF
         VGqGRG+ZZ8SzSqzspWi5M/GyA7/6rddMCrEAVyopTe1Za0YfTfhBFeGleP2Pg1OipJ8l
         EqTYcVJb4NbNOp4VpbjN2PZFJ9GPP678mb993bG/E97cDqYWiIF1yTsJWPqbXYvvVMPU
         qRWIOHJrSvyTM2MjnioczKTPyg+TL1EDJBYxtKxObfaqcTUZ3Mv5MgqQ1yrJ2FGhh2ra
         LbLQ==
X-Gm-Message-State: AC+VfDy7xXxp++s8w2r+2qcxBwDcg4SPoAJ2UcaKfF+VXX2By8kOB4Ur
        9f8R9+Mms4Evhq89VUrx6UtjFiCWCD9y2o39O/o=
X-Google-Smtp-Source: ACHHUZ5FtL0koAv8AKOnMvLmiiF/QbgznjvqGzIOpW5ODZPXZs/PrWCRS2IKNQRE3nuBuOOmN5XukwM9zYmCXaFfsYg=
X-Received: by 2002:a17:906:dac1:b0:961:8fcd:53c7 with SMTP id
 xi1-20020a170906dac100b009618fcd53c7mr4505683ejb.54.1682985331620; Mon, 01
 May 2023 16:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230428222754.183432-1-inwardvessel@gmail.com> <20230428222754.183432-3-inwardvessel@gmail.com>
In-Reply-To: <20230428222754.183432-3-inwardvessel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 May 2023 16:55:19 -0700
Message-ID: <CAEf4BzYAF4QdWtYWDLzdNT56b9=Vm_3FKVHqxDifuPUHbTFTCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] libbpf: selftests for resizing datasec maps
To:     JP Kobryn <inwardvessel@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 28, 2023 at 3:28=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> This patch adds test coverage for resizing datasec maps. There are two
> tests which run a bpf program that sums the elements in the datasec array=
.
> After the datasec array is resized, each elements is assigned a value of =
1
> so that the sum will be equal to the length of the array. Assertions are
> done to verify this. The first test attempts to resize to an aligned
> length while the second attempts to resize to a mis-aligned length where
> rounding up is expected to occur. The third test attempts to resize maps
> that do not meet the necessary criteria and assertions are done to confir=
m
> error codes are returned.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  .../bpf/prog_tests/global_map_resize.c        | 187 ++++++++++++++++++
>  .../bpf/progs/test_global_map_resize.c        |  33 ++++
>  2 files changed, 220 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/global_map_res=
ize.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_map_res=
ize.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_map_resize.c b=
/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
> new file mode 100644
> index 000000000000..f38df37664a7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <errno.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +
> +#include "test_global_map_resize.skel.h"
> +#include "test_progs.h"
> +
> +static void run_program(void)
> +{
> +       (void)syscall(__NR_getpid);
> +}
> +
> +static int setup(struct test_global_map_resize **skel)
> +{
> +       if (!skel)
> +               return -1;
> +
> +       *skel =3D test_global_map_resize__open();
> +       if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
> +               return -1;
> +
> +       (*skel)->rodata->pid =3D getpid();
> +

this simple logic is also so common in lots of tests, that it doesn't
make sense to have dedicated setup() routine for that (just more
jumping around the code to know what's going on). Please inline in
respective callers.

> +       return 0;
> +}
> +
> +static void teardown(struct test_global_map_resize **skel)
> +{
> +       if (skel && *skel)
> +               test_global_map_resize__destroy(*skel);


skeleton's destroy handles NULL, so this whole teardown() is not
necessary, just call destroy() directly in respective functions

> +}
> +
> +static int resize_test(struct test_global_map_resize *skel,
> +               __u32 element_sz, __u32 desired_sz)
> +{
> +       int ret =3D 0;
> +       struct bpf_map *map;
> +       __u32 initial_sz, actual_sz;
> +       size_t nr_elements;
> +       int *initial_val;
> +       size_t initial_val_sz;
> +
> +       map =3D skel->maps.data_my_array;
> +
> +       initial_sz =3D bpf_map__value_size(map);
> +       ASSERT_EQ(initial_sz, element_sz, "initial size");
> +
> +       /* round up desired size to align with element size */
> +       desired_sz =3D roundup(desired_sz, element_sz);
> +       ret =3D bpf_map__set_value_size(map, desired_sz);
> +       if (!ASSERT_OK(ret, "bpf_map__set_value_size"))
> +               return ret;
> +
> +       /* refresh map pointer to avoid invalidation issues */
> +       map =3D skel->maps.data_my_array;
> +
> +       actual_sz =3D bpf_map__value_size(map);
> +       ASSERT_EQ(actual_sz, desired_sz, "resize");
> +
> +       /* set the expected number of elements based on the resized array=
 */
> +       nr_elements =3D roundup(actual_sz, element_sz) / element_sz;
> +       skel->rodata->n =3D nr_elements;
> +
> +       /* create array for initial map value */
> +       initial_val_sz =3D element_sz * nr_elements;
> +       initial_val =3D malloc(initial_val_sz);
> +       if (!ASSERT_OK_PTR(initial_val, "malloc initial_val")) {
> +               ret =3D -ENOMEM;
> +
> +               goto cleanup;
> +       }
> +
> +       /* fill array with ones */
> +       for (int i =3D 0; i < nr_elements; ++i)
> +               initial_val[i] =3D 1;
> +
> +       /* set initial value */
> +       ASSERT_EQ(initial_val_sz, actual_sz, "initial value size");
> +
> +       ret =3D bpf_map__set_initial_value(map, initial_val, initial_val_=
sz);
> +       if (!ASSERT_OK(ret, "bpf_map__set_initial_val"))
> +               goto cleanup;


it would be good to demonstrate that it's still possible to use BPF
skeleton to initialize everything, you'll just need to reassign
pointer:

skel->data_my_array =3D bpf_map__initial_value(skel->maps.data_my_array, &n=
ew_sz);
skel->data_my_array.my_var[i] =3D 123;

can you please add this case as well?

> +
> +       ret =3D test_global_map_resize__load(skel);
> +       if (!ASSERT_OK(ret, "test_global_map_resize__load"))
> +               goto cleanup;
> +
> +       ret =3D test_global_map_resize__attach(skel);
> +       if (!ASSERT_OK(ret, "test_global_map_resize__attach"))
> +               goto cleanup;
> +
> +       /* run the bpf program which will sum the contents of the array *=
/
> +       run_program();
> +
> +       if (!ASSERT_EQ(skel->bss->sum, nr_elements, "sum"))
> +               goto cleanup;
> +
> +cleanup:
> +       if (initial_val)
> +               free(initial_val);
> +
> +       return ret;
> +}
> +
> +static void global_map_resize_aligned_subtest(void)
> +{
> +       struct test_global_map_resize *skel;
> +       const __u32 element_sz =3D (__u32)sizeof(int);
> +       const __u32 desired_sz =3D (__u32)sysconf(_SC_PAGE_SIZE) * 2;
> +
> +       /* preliminary check that desired_sz aligns with element_sz */
> +       if (!ASSERT_EQ(desired_sz % element_sz, 0, "alignment"))
> +               return;
> +
> +       if (setup(&skel))
> +               goto teardown;
> +
> +       if (resize_test(skel, element_sz, desired_sz))
> +               goto teardown;
> +
> +teardown:
> +       teardown(&skel);
> +}
> +
> +static void global_map_resize_roundup_subtest(void)
> +{
> +       struct test_global_map_resize *skel;
> +       const __u32 element_sz =3D (__u32)sizeof(int);
> +       /* set desired size a fraction of element size beyond an aligned =
size */
> +       const __u32 desired_sz =3D (__u32)sysconf(_SC_PAGE_SIZE) * 2 + el=
ement_sz / 2;
> +
> +       /* preliminary check that desired_sz does NOT align with element_=
sz */
> +       if (!ASSERT_NEQ(desired_sz % element_sz, 0, "alignment"))
> +               return;
> +
> +       if (setup(&skel))
> +               goto teardown;
> +
> +       if (resize_test(skel, element_sz, desired_sz))
> +               goto teardown;
> +
> +teardown:
> +       teardown(&skel);
> +}
> +
> +static void global_map_resize_invalid_subtest(void)
> +{
> +       int err;
> +       struct test_global_map_resize *skel;
> +       struct bpf_map *map;
> +       const __u32 desired_sz =3D 8192;
> +
> +       if (setup(&skel))
> +               goto teardown;
> +
> +       /* attempt to resize a global datasec map which is an array
> +        * BUT is with a var in same datasec
> +        */
> +       map =3D skel->maps.data_my_array_and_var;
> +       err =3D bpf_map__set_value_size(map, desired_sz);
> +       if (!ASSERT_EQ(err, -EINVAL, "bpf_map__set_value_size"))
> +               goto teardown;
> +
> +       /* attempt to resize a global datasec map which is NOT an array *=
/
> +       map =3D skel->maps.data_my_non_array;
> +       err =3D bpf_map__set_value_size(map, desired_sz);
> +       if (!ASSERT_EQ(err, -EINVAL, "bpf_map__set_value_size"))
> +               goto teardown;
> +
> +teardown:
> +       teardown(&skel);
> +}
> +
> +void test_global_map_resize(void)
> +{
> +       if (test__start_subtest("global_map_resize_aligned"))
> +               global_map_resize_aligned_subtest();
> +
> +       if (test__start_subtest("global_map_resize_roundup"))
> +               global_map_resize_roundup_subtest();
> +
> +       if (test__start_subtest("global_map_resize_invalid"))
> +               global_map_resize_invalid_subtest();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_global_map_resize.c b=
/tools/testing/selftests/bpf/progs/test_global_map_resize.c
> new file mode 100644
> index 000000000000..cffbba1b6020
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +const volatile pid_t pid;
> +const volatile size_t n;
> +
> +int my_array[1] SEC(".data.my_array");
> +
> +int my_array_with_neighbor[1] SEC(".data.my_array_and_var");
> +int my_var_with_neighbor SEC(".data.my_array_and_var");
> +
> +int my_non_array SEC(".data.my_non_array");
> +
> +int sum =3D 0;
> +
> +SEC("tp/syscalls/sys_enter_getpid")
> +int array_sum(void *ctx)
> +{
> +       if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
> +               return 0;
> +
> +       sum =3D 0;
> +
> +       for (size_t i =3D 0; i < n; ++i)
> +               sum +=3D my_array[i];
> +
> +       return 0;
> +}
> --
> 2.40.0
>
