Return-Path: <bpf+bounces-19404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACFA82B9BB
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 03:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF811C241FC
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CD71399;
	Fri, 12 Jan 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aomc1Sn5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48740111A;
	Fri, 12 Jan 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e55c885d7so28990325e9.0;
        Thu, 11 Jan 2024 18:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705027858; x=1705632658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wLJgHA1yHVJtATF1kOrd3qmsfubT+FP3vvLjG87SY4=;
        b=Aomc1Sn53OD8QBiT2wHCk826iH8LHI75iPKYwdfk8INs4q9JmLayVR97+ynN6jYhlJ
         HGpOiEPgxoqglUKmoV228qXI9I1wX+TDj+TO3elBK2PkbZLM1V7T6sS3x6n7fsFxuBYB
         lYaAPhPO6HaC69eHVrvaJO2gIe/rgiQuolsN/O3MLYAStg6VGtMDFP6G9sFpXyjgxVB3
         FDRsA5EnxU22Gc9EpFDFPn3t/MqULsZ08cb1QQQfFTvU73BcRi92bA431sVOecaJ4+qE
         VvEGLNyB1v3fZa3gkkooWAGRz0B8eMAS/TFoITGh1pMUcjyNZxdupQhiK+yeFaOhoINx
         kS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705027858; x=1705632658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wLJgHA1yHVJtATF1kOrd3qmsfubT+FP3vvLjG87SY4=;
        b=GDOndK4g9diVX8kzzCzbHqO5jWf5CtwGfTmZI/vD2hGCgf7fK7wiZDQ1fWAkGAihBd
         +PkUonRI3K1+PqUdAkyEL8PJBv9DpHfB7VibZkL927CI8/CuJcXJUkkznpDN9y4f6k7S
         avg4PZ+KW0A8uZNWb6z+nC+jEjdG0wSsVSFDVOI4ibjQ7EiON7teJ4GYNU42nVQTWG0p
         AnHf2qXqMcYc1tBfTVQ2rUU3vByde6jyUSQw6Tb+c0M58OUikNzgpPXs4PNOOMyszxQx
         JethhaSzz3908gG8OgNfJoYkCp0svWNL903x+HkTSZYYGDHaBgihM/yocv2WiWEj1uB2
         CCIw==
X-Gm-Message-State: AOJu0YyBYqXSCV2ijd9r0T9ljHL68RJZtR6kcAWSpwZQatiyJ8hXWimb
	lzAc26Olwbog2ucNZg1I8ZPI3E0/YhodnY4OhCs=
X-Google-Smtp-Source: AGHT+IGBREOMAAm5a+zqCzWlKmEGUKLj01kQmx3If1CkgCa02Ju7xr1WwRnpnCC5pT8zH4bKsNFTIsDxX871+CAbpH4=
X-Received: by 2002:a05:600c:2256:b0:40e:4395:bc4a with SMTP id
 a22-20020a05600c225600b0040e4395bc4amr375568wmm.67.1705027858023; Thu, 11 Jan
 2024 18:50:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110010009.1210237-1-brho@google.com>
In-Reply-To: <20240110010009.1210237-1-brho@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Jan 2024 18:50:46 -0800
Message-ID: <CAADnVQLFCw3jrF_ufVHP3wrVpdAgzY1T3EbkCCHZYaEqu_=DUA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: add inline assembly helpers to
 access array elements
To: Barret Rhoden <brho@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Jiri Olsa <olsajiri@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 5:00=E2=80=AFPM Barret Rhoden <brho@google.com> wrot=
e:
>
> When accessing an array, even if you insert your own bounds check,
> sometimes the compiler will remove the check.  bpf_cmp() will force the
> compiler to do the check.
>
> However, the compiler is free to make a copy of a register, check the cop=
y,
> and use the original to access the array.  The verifier knows the *copy*
> is within bounds, but not the original register!
>
> Although I couldn't recreate the "bounds check a copy of a register",
> the test below managed to get the compiler to spill a register to the
> stack, then bounds-check the register, and later reread the register -
> sans bounds check.
>
> By performing the bounds check and the indexing in assembly, we ensure
> the register used to index the array was bounds checked.
>
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
> v2: https://lore.kernel.org/bpf/20240103185403.610641-1-brho@google.com
>
> Changes since v2:
> - added a test prog that should load, but fails to verify for me (Debian
>   clang version 16.0.6 (16)).  these tests might be brittle and start
>   successfully verifying for other compiler versions.
> - removed the mmap-an-arraymap patch
> - removed macros and added some "test fixture" code
> - used RUN_TESTS for the __failure cases
>
>
>  .../bpf/prog_tests/test_array_elem.c          | 167 ++++++++++++
>  .../selftests/bpf/progs/array_elem_test.c     | 256 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |  43 +++
>  3 files changed, 466 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_array_ele=
m.c
>  create mode 100644 tools/testing/selftests/bpf/progs/array_elem_test.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_array_elem.c b/t=
ools/testing/selftests/bpf/prog_tests/test_array_elem.c
> new file mode 100644
> index 000000000000..93e8f03fdeac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_array_elem.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Google LLC. */
> +#include <test_progs.h>
> +#include "array_elem_test.skel.h"
> +
> +#include <sys/mman.h>
> +
> +#define NR_MAP_ELEMS 100
> +
> +static size_t map_mmap_sz(struct bpf_map *map)
> +{
> +       size_t mmap_sz;
> +
> +       mmap_sz =3D (size_t)roundup(bpf_map__value_size(map), 8) *
> +               bpf_map__max_entries(map);
> +       mmap_sz =3D roundup(mmap_sz, sysconf(_SC_PAGE_SIZE));
> +
> +       return mmap_sz;
> +}
> +
> +static void *map_mmap(struct bpf_map *map)
> +{
> +       return mmap(NULL, map_mmap_sz(map), PROT_READ | PROT_WRITE, MAP_S=
HARED,
> +                   bpf_map__fd(map), 0);
> +}
> +
> +static void map_munmap(struct bpf_map *map, void *addr)
> +{
> +       munmap(addr, map_mmap_sz(map));
> +}
> +
> +struct arr_elem_fixture {
> +       struct array_elem_test *skel;
> +       int *map_elems;
> +};
> +
> +static void setup_fixture(struct arr_elem_fixture *tf, size_t prog_off)
> +{
> +       struct array_elem_test *skel;
> +       struct bpf_program *prog;
> +       int err;
> +
> +       skel =3D array_elem_test__open();
> +       if (!ASSERT_OK_PTR(skel, "array_elem_test open"))
> +               return;
> +
> +       /*
> +        * Our caller doesn't know the addr of the program until the skel=
eton is
> +        * opened.  But the offset to the pointer is statically known.
> +        */
> +       prog =3D *(struct bpf_program**)((__u8*)skel + prog_off);
> +       bpf_program__set_autoload(prog, true);
> +
> +       err =3D array_elem_test__load(skel);
> +       if (!ASSERT_EQ(err, 0, "array_elem_test load")) {
> +               array_elem_test__destroy(skel);
> +               return;
> +       }
> +
> +       err =3D array_elem_test__attach(skel);
> +       if (!ASSERT_EQ(err, 0, "array_elem_test attach")) {
> +               array_elem_test__destroy(skel);
> +               return;
> +       }
> +
> +       for (int i =3D 0; i < NR_MAP_ELEMS; i++) {
> +               skel->bss->lookup_indexes[i] =3D i;
> +               err =3D bpf_map_update_elem(bpf_map__fd(skel->maps.lookup=
_again),
> +                                         &i, &i, BPF_ANY);
> +               ASSERT_EQ(err, 0, "array_elem_test set lookup_again");
> +       }
> +
> +       tf->map_elems =3D map_mmap(skel->maps.arraymap);
> +       ASSERT_OK_PTR(tf->map_elems, "mmap");
> +
> +       tf->skel =3D skel;
> +}
> +
> +static void run_test(struct arr_elem_fixture *tf)
> +{
> +       tf->skel->bss->target_pid =3D getpid();
> +       usleep(1);
> +}
> +
> +static void destroy_fixture(struct arr_elem_fixture *tf)
> +{
> +       map_munmap(tf->skel->maps.arraymap, tf->map_elems);
> +       array_elem_test__destroy(tf->skel);
> +}
> +
> +static void test_access_single(void)
> +{
> +       struct arr_elem_fixture tf[1];
> +
> +       setup_fixture(tf, offsetof(struct array_elem_test,
> +                                  progs.access_single));
> +       run_test(tf);
> +
> +       ASSERT_EQ(tf->map_elems[0], 1337, "array_elem map value not writt=
en");
> +
> +       destroy_fixture(tf);
> +}
> +
> +static void test_access_all(void)
> +{
> +       struct arr_elem_fixture tf[1];
> +
> +       setup_fixture(tf, offsetof(struct array_elem_test,
> +                                  progs.access_all));
> +       run_test(tf);
> +
> +       for (int i =3D 0; i < NR_MAP_ELEMS; i++)
> +               ASSERT_EQ(tf->map_elems[i], i,
> +                         "array_elem map value not written");
> +
> +       destroy_fixture(tf);
> +}
> +
> +static void test_oob_access(void)
> +{
> +       struct arr_elem_fixture tf[1];
> +
> +       setup_fixture(tf, offsetof(struct array_elem_test,
> +                                  progs.oob_access));
> +       run_test(tf);
> +
> +       for (int i =3D 0; i < NR_MAP_ELEMS; i++)
> +               ASSERT_EQ(tf->map_elems[i], 0,
> +                         "array_elem map value was written");
> +
> +       destroy_fixture(tf);
> +}
> +
> +static void test_infer_size(void)
> +{
> +       struct arr_elem_fixture tf[1];
> +
> +       setup_fixture(tf, offsetof(struct array_elem_test,
> +                                  progs.infer_size));
> +       run_test(tf);
> +
> +       for (int i =3D 0; i < NR_MAP_ELEMS; i++)
> +               ASSERT_EQ(tf->map_elems[i], i,
> +                         "array_elem map value not written");
> +
> +       destroy_fixture(tf);
> +}
> +
> +void test_test_array_elem(void)
> +{
> +       if (test__start_subtest("real_access_single"))
> +               test_access_single();
> +       if (test__start_subtest("real_access_all"))
> +               test_access_all();
> +       if (test__start_subtest("real_oob_access"))
> +               test_oob_access();
> +       if (test__start_subtest("real_infer_size"))
> +               test_infer_size();
> +
> +       /*
> +        * RUN_TESTS() will load the *bad* tests, marked with
> +        * __failure, and ensure they fail to load.  It will also load th=
e
> +        * *good* tests, which we already tested, so you'll see some test=
s twice
> +        * in the output.
> +        */
> +       RUN_TESTS(array_elem_test);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/array_elem_test.c b/tools/=
testing/selftests/bpf/progs/array_elem_test.c
> new file mode 100644
> index 000000000000..9cd90a3623e5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/array_elem_test.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Google LLC. */
> +
> +#include <vmlinux.h>
> +#include <stdbool.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int target_pid =3D 0;
> +
> +#define NR_MAP_ELEMS 100
> +
> +/*
> + * We want to test valid accesses into an array, but we also need to foo=
l the
> + * verifier.  If we just do for (i =3D 0; i < 100; i++), the verifier kn=
ows the
> + * value of i and can tell we're inside the array.
> + *
> + * This "lookup" array is just the values 0, 1, 2..., such that
> + * lookup_indexes[i] =3D=3D i.  (set by userspace).  But the verifier do=
esn't know
> + * that.
> + */
> +unsigned int lookup_indexes[NR_MAP_ELEMS];
> +
> +/*
> + * This second lookup array also has the values 0, 1, 2.  The extra laye=
r of
> + * lookups seems to make the compiler work a little harder, and more lik=
ely to
> + * spill to the stack.
> + */
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, NR_MAP_ELEMS);
> +       __type(key, u32);
> +       __type(value, u32);
> +       __uint(map_flags, BPF_F_MMAPABLE);
> +} lookup_again SEC(".maps");
> +
> +struct map_array {
> +       int elems[NR_MAP_ELEMS];
> +};
> +
> +/*
> + * This is an ARRAY_MAP of a single struct, and that struct is an array =
of
> + * elements.  Userspace can mmap the map as if it was just a basic array=
 of
> + * elements.  Though if you make an ARRAY_MAP where the *values* are int=
s, don't
> + * forget that bpf map elements are rounded up to 8 bytes.
> + *
> + * Once you get the pointer to the base of the inner array, you can acce=
ss all
> + * of the elements without another bpf_map_lookup_elem(), which is usefu=
l if you
> + * are operating on multiple elements while holding a spinlock.
> + */
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, u32);
> +       __type(value, struct map_array);
> +       __uint(map_flags, BPF_F_MMAPABLE);
> +} arraymap SEC(".maps");
> +
> +static struct map_array *get_map_array(void)
> +{
> +       int zero =3D 0;
> +
> +       return bpf_map_lookup_elem(&arraymap, &zero);
> +}
> +
> +static int *get_map_elems(void)
> +{
> +       struct map_array *arr =3D get_map_array();
> +
> +       if (!arr)
> +               return NULL;
> +       return arr->elems;
> +}
> +
> +/*
> + * This is convoluted enough that the compiler may spill a register (r1)=
 before
> + * bounds checking it.
> + */
> +static void bad_set_elem(unsigned int which, int val)
> +{
> +       u32 idx_1;
> +       u32 *idx_2p;
> +       int *map_elems;
> +
> +       if (which >=3D NR_MAP_ELEMS)
> +               return;
> +
> +       idx_1 =3D lookup_indexes[which];
> +       idx_2p =3D bpf_map_lookup_elem(&lookup_again, &idx_1);
> +       if (!idx_2p)
> +               return;
> +
> +       /*
> +        * reuse idx_1, which is often r1.  if you use a new variable, e.=
g.
> +        * idx_3 =3D *idx_2p, the compiler will pick a non-caller save re=
gister
> +        * (e.g. r6), and won't spill it to the stack.
> +        */
> +       idx_1 =3D *idx_2p;
> +
> +       /*
> +        * Whether we use bpf_cmp or a normal comparison, r1 might get sp=
illed
> +        * to the stack, *then* checked against NR_MAP_ELEMS.  The verifi=
er will
> +        * know r1's bounds, but since the check happened after the spill=
, it
> +        * doesn't know about the stack variable's bounds.
> +        */
> +       if (bpf_cmp_unlikely(idx_1, >=3D, NR_MAP_ELEMS))
> +               return;
> +
> +       /*
> +        * This does a bpf_map_lookup_elem(), which is a function call, w=
hich
> +        * necessitates spilling r1.
> +        */
> +       map_elems =3D get_map_elems();
> +       if (map_elems)
> +               map_elems[idx_1] =3D val;
> +}
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +__failure
> +__msg("R0 unbounded memory access, make sure to bounds check any such ac=
cess")
> +int bad_access_single(void *ctx)
> +{
> +       bad_set_elem(0, 1337);
> +       return 0;
> +}
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +__failure
> +__msg("R0 unbounded memory access, make sure to bounds check any such ac=
cess")
> +int bad_access_all(void *ctx)
> +{
> +       for (int i =3D 0; i < NR_MAP_ELEMS; i++)
> +               bad_set_elem(i, i);
> +       return 0;
> +}
> +
> +/*
> + * Both lookup_indexes and lookup_again are identity maps, i.e. f(x) =3D=
 x (within
> + * bounds), so ultimately we're setting map_elems[which] =3D val.
> + */
> +static void good_set_elem(unsigned int which, int val)
> +{
> +       u32 idx_1;
> +       u32 *idx_2p;
> +       int *map_elems, *x;
> +
> +       if (which >=3D NR_MAP_ELEMS)
> +               return;
> +       idx_1 =3D lookup_indexes[which];
> +       idx_2p =3D bpf_map_lookup_elem(&lookup_again, &idx_1);
> +
> +       if (!idx_2p)
> +               return;
> +
> +       idx_1 =3D *idx_2p;
> +
> +       map_elems =3D get_map_elems();
> +       x =3D bpf_array_elem(map_elems, NR_MAP_ELEMS, idx_1);
> +       if (x)
> +               *x =3D val;
> +}
> +
> +/*
> + * Test accessing a single element in the array with a convoluted lookup=
.
> + */
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int access_single(void *ctx)
> +{
> +       if ((bpf_get_current_pid_tgid() >> 32) !=3D target_pid)
> +               return 0;
> +
> +       good_set_elem(0, 1337);
> +
> +       return 0;
> +}
> +
> +/*
> + * Test that we can access all elements, and that we are accessing the e=
lement
> + * we think we are accessing.
> + */
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int access_all(void *ctx)
> +{
> +       if ((bpf_get_current_pid_tgid() >> 32) !=3D target_pid)
> +               return 0;
> +
> +       for (int i =3D 0; i < NR_MAP_ELEMS; i++)
> +               good_set_elem(i, i);
> +
> +       return 0;
> +}
> +
> +/*
> + * Helper for various OOB tests.  An out-of-bound access should be handl=
ed like
> + * a lookup failure.  Specifically, the verifier should ensure we do not=
 access
> + * outside the array.  Userspace will check that we didn't access somewh=
ere
> + * inside the array.
> + */
> +static void set_elem_to_1(long idx)
> +{
> +       int *map_elems =3D get_map_elems();
> +       int *x;
> +
> +       x =3D bpf_array_elem(map_elems, NR_MAP_ELEMS, idx);
> +       if (x)
> +               *x =3D 1;
> +}
> +
> +/*
> + * Test various out-of-bounds accesses.
> + */
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int oob_access(void *ctx)
> +{
> +       if ((bpf_get_current_pid_tgid() >> 32) !=3D target_pid)
> +               return 0;
> +
> +       set_elem_to_1(NR_MAP_ELEMS + 5);
> +       set_elem_to_1(NR_MAP_ELEMS);
> +       set_elem_to_1(-1);
> +       set_elem_to_1(~0UL);
> +
> +       return 0;
> +}
> +
> +/*
> + * Test that we can use the ARRAY_SIZE-style helper with an array in a m=
ap.
> + *
> + * Note that you cannot infer the size of the array from just a pointer;=
 you
> + * have to use the actual elems[100].  i.e. this will fail and should fa=
il to
> + * compile (-Wsizeof-pointer-div):
> + *
> + *     int *map_elems =3D get_map_elems();
> + *     x =3D bpf_array_sz_elem(map_elems, lookup_indexes[i]);
> + */
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int infer_size(void *ctx)
> +{
> +       struct map_array *arr =3D get_map_array();
> +       int *x;
> +
> +       if ((bpf_get_current_pid_tgid() >> 32) !=3D target_pid)
> +               return 0;
> +
> +       for (int i =3D 0; i < NR_MAP_ELEMS; i++) {
> +               x =3D bpf_array_sz_elem(arr->elems, lookup_indexes[i]);
> +               if (x)
> +                       *x =3D i;
> +       }
> +
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index 2fd59970c43a..002bab44cde2 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -135,4 +135,47 @@
>  /* make it look to compiler like value is read and written */
>  #define __sink(expr) asm volatile("" : "+g"(expr))
>
> +/*
> + * Access an array element within a bound, such that the verifier knows =
the
> + * access is safe.
> + *
> + * This macro asm is the equivalent of:
> + *
> + *     if (!arr)
> + *             return NULL;
> + *     if (idx >=3D arr_sz)
> + *             return NULL;
> + *     return &arr[idx];
> + *
> + * The index (___idx below) needs to be a u64, at least for certain vers=
ions of
> + * the BPF ISA, since there aren't u32 conditional jumps.
> + */
> +#define bpf_array_elem(arr, arr_sz, idx) ({                            \
> +       typeof(&(arr)[0]) ___arr =3D arr;                                =
 \
> +       __u64 ___idx =3D idx;                                            =
 \
> +       if (___arr) {                                                   \
> +               asm volatile("if %[__idx] >=3D %[__bound] goto 1f;       =
 \
> +                             %[__idx] *=3D %[__size];            \
> +                             %[__arr] +=3D %[__idx];             \
> +                             goto 2f;                          \
> +                             1:;                               \
> +                             %[__arr] =3D 0;                     \
> +                             2:                                \
> +                             "                                         \
> +                            : [__arr]"+r"(___arr), [__idx]"+r"(___idx) \
> +                            : [__bound]"r"((arr_sz)),                  \
> +                              [__size]"i"(sizeof(typeof((arr)[0])))    \
> +                            : "cc");                                   \
> +       }                                                               \
> +       ___arr;                                                         \
> +})

It's good to have this test, but please
move this macro from bpf_misc.h to progs/array_elem_test.c itself.

I think once we fix the verifier deficiencies we won't be
encouraging such macro use, but it's good to have such test anyway.

