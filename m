Return-Path: <bpf+bounces-9823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4134379DC93
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5149280DC1
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606641173D;
	Tue, 12 Sep 2023 23:19:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4D17C2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:19:35 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBDE10F6
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:19:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502153ae36cso9975971e87.3
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694560773; x=1695165573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUfpYsrd9EB/lJJBWYltWcpwe2mGUtNIZ9AtOaq3E/E=;
        b=mOzDnuZJDIOUgdoAtGjFoKg/HWZvIbpaaEAvz8o1lc0U/Yvxn51crCzoKA5dHWW2ru
         7Tbux4yfe+9r+hNM6H6BbZ1ZgkkVnYjel7pmJhFZA9xSjYpVOou877PzbqBqJ9Vkbmxk
         PI19iPFDPRt9F2eT6IHElcMrTlz3rhBqK3uwFlgK+2qsEMg2502jq97OUxM9CZ/o9S4w
         2Xzn4/PmpO8Sm1yOHLzayLVuhyJtLXVyOP/1kcq/jAHCh4bPn5DZxrMrZG0Ln/jRQ+Iu
         XKEB5PddPZ0BMA7nznAe5tJb+LL8PikiYGp5Eu234QuDNsFUzAvuzVFh3CVE7IzS7J74
         tvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694560773; x=1695165573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUfpYsrd9EB/lJJBWYltWcpwe2mGUtNIZ9AtOaq3E/E=;
        b=iIWebyiXIwg8A6jQH+vYcp8dIiWthLd8yUDg3ZsWe3Fw3nllvnjtHwtqSR9kbg2GAC
         HGVfK5w6Lo09YuuDHqij4wYkR7drX52SiHoynPvYyahO4H8G62I2pYSR0bUFwDXhhXGU
         rW9P+G+GTRvJZ+8OTUPeMmInVx/z0UuSG5qqFErhN+NHWek9eZMS/FFs1OyU233oka92
         yVn0i4ewTvJshidbmSitrfnkrh28K3F7lt+OKa/7Hhxc6EwK/pZWj2mhJ9gG9JnHFC53
         D8XC4ZmUou7dEdcivqbxLVlCfSDGUCwskKQk5dE2Ud8laUH5V+jHxAzhe8pP8qZoM/85
         vH2w==
X-Gm-Message-State: AOJu0YyAY8LmmJ+8E7biCNoYDkwNfF5tPrZZuWl0W5/ohi5mrIQDiiu3
	HTmgMuBGq8qXRQuqX3utZpTgPcC4oIPeLlBYYLQ=
X-Google-Smtp-Source: AGHT+IEjOVkCaZPoaHqddnctnQuaqDsJ0CLaxfu7mdSXQ78L0PXaC3x6y3EsbalvGm/UWuiE1pISnlE1WIarZzM/C6k=
X-Received: by 2002:a05:6512:3f15:b0:500:bffa:5b85 with SMTP id
 y21-20020a0565123f1500b00500bffa5b85mr824573lfa.32.1694560772713; Tue, 12 Sep
 2023 16:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911015052.72975-1-hengqi.chen@gmail.com> <20230911015052.72975-4-hengqi.chen@gmail.com>
In-Reply-To: <20230911015052.72975-4-hengqi.chen@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Sep 2023 16:19:20 -0700
Message-ID: <CAEf4BzbCcP4_1sE0NjQTyjxUuLMDv2AvfPZbXJ-x-wOmh1Dt9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for symbol
 versioning for uprobe
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alan.maguire@oracle.com, olsajiri@gmail.com, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 10, 2023 at 6:51=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> This exercises the newly added dynsym symbol versioning logics.
> Now we accept symbols in form of func, func@LIB_VERSION or
> func@@LIB_VERSION.
>
> The test rely on liburandom_read.so. For liburandom_read.so, we have:
>
>     $ nm -D liburandom_read.so
>                      w __cxa_finalize@GLIBC_2.17
>                      w __gmon_start__
>                      w _ITM_deregisterTMCloneTable
>                      w _ITM_registerTMCloneTable
>     0000000000000000 A LIBURANDOM_READ_1.0.0
>     0000000000000000 A LIBURANDOM_READ_2.0.0
>     000000000000081c T urandlib_api@@LIBURANDOM_READ_2.0.0
>     0000000000000814 T urandlib_api@LIBURANDOM_READ_1.0.0
>     0000000000000824 T urandlib_api_sameoffset@LIBURANDOM_READ_1.0.0
>     0000000000000824 T urandlib_api_sameoffset@@LIBURANDOM_READ_2.0.0
>     000000000000082c T urandlib_read_without_sema@@LIBURANDOM_READ_1.0.0
>     00000000000007c4 T urandlib_read_with_sema@@LIBURANDOM_READ_1.0.0
>     0000000000011018 D urandlib_read_with_sema_semaphore@@LIBURANDOM_READ=
_1.0.0
>
> For `urandlib_api`, specifying `urandlib_api` will cause a conflict becau=
se
> there are two symbols named urandlib_api and both are global bind.
> For `urandlib_api_sameoffset`, there are also two symbols in the .so, but
> both are at the same offset and essentially they refer to the same functi=
on
> so no conflict.
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  5 +-
>  .../testing/selftests/bpf/liburandom_read.map | 15 +++
>  .../testing/selftests/bpf/prog_tests/uprobe.c | 95 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_uprobe.c | 61 ++++++++++++
>  tools/testing/selftests/bpf/urandom_read.c    |  9 ++
>  .../testing/selftests/bpf/urandom_read_lib1.c | 41 ++++++++
>  6 files changed, 224 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/liburandom_read.map
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_uprobe.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index caede9b574cb..47365161b6fc 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -196,11 +196,12 @@ endif
>
>  # Filter out -static for liburandom_read.so and its dependent targets so=
 that static builds
>  # do not fail. Static builds leave urandom_read relying on system-wide s=
hared libraries.
> -$(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
> +$(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c li=
burandom_read.map
>         $(call msg,LIB,,$@)
>         $(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS))   \
> -                    $^ $(filter-out -static,$(LDLIBS))      \
> +                    $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>                      -fuse-ld=3D$(LLD) -Wl,-znoseparate-code -Wl,--build-=
id=3Dsha1 \
> +                    -Wl,--version-script=3Dliburandom_read.map \
>                      -fPIC -shared -o $@
>
>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/libu=
random_read.so
> diff --git a/tools/testing/selftests/bpf/liburandom_read.map b/tools/test=
ing/selftests/bpf/liburandom_read.map
> new file mode 100644
> index 000000000000..38a97a419a04
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/liburandom_read.map
> @@ -0,0 +1,15 @@
> +LIBURANDOM_READ_1.0.0 {
> +       global:
> +               urandlib_api;
> +               urandlib_api_sameoffset;
> +               urandlib_read_without_sema;
> +               urandlib_read_with_sema;
> +               urandlib_read_with_sema_semaphore;
> +       local:
> +               *;
> +};
> +
> +LIBURANDOM_READ_2.0.0 {
> +       global:
> +               urandlib_api;
> +} LIBURANDOM_READ_1.0.0;
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe.c b/tools/test=
ing/selftests/bpf/prog_tests/uprobe.c
> new file mode 100644
> index 000000000000..cf3e0e7a64fa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Hengqi Chen */
> +
> +#include <test_progs.h>
> +#include "test_uprobe.skel.h"
> +
> +static FILE *urand_spawn(int *pid)
> +{
> +       FILE *f;
> +
> +       /* urandom_read's stdout is wired into f */
> +       f =3D popen("./urandom_read 1 report-pid", "r");
> +       if (!f)
> +               return NULL;
> +
> +       if (fscanf(f, "%d", pid) !=3D 1) {
> +               pclose(f);
> +               errno =3D EINVAL;
> +               return NULL;
> +       }
> +
> +       return f;
> +}
> +
> +static int urand_trigger(FILE **urand_pipe)
> +{
> +       int exit_code;
> +
> +       /* pclose() waits for child process to exit and returns their exi=
t code */
> +       exit_code =3D pclose(*urand_pipe);
> +       *urand_pipe =3D NULL;
> +
> +       return exit_code;
> +}
> +
> +void test_uprobe(void)
> +{
> +       LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> +       struct test_uprobe *skel;
> +       FILE *urand_pipe =3D NULL;
> +       int urand_pid =3D 0, err;
> +
> +       skel =3D test_uprobe__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       urand_pipe =3D urand_spawn(&urand_pid);
> +       if (!ASSERT_OK_PTR(urand_pipe, "urand_spawn"))
> +               goto cleanup;
> +
> +       skel->bss->my_pid =3D urand_pid;
> +
> +       /* Manual attach uprobe to urandlib_api
> +        * There are two `urandlib_api` symbols in .dynsym section:
> +        *   - urandlib_api@LIBURANDOM_READ_1.0.0
> +        *   - urandlib_api@@LIBURANDOM_READ_2.0.0
> +        * Both are global bind and would cause a conflict if user
> +        * specify the symbol name without a version suffix
> +        */
> +       uprobe_opts.func_name =3D "urandlib_api";
> +       skel->links.test4 =3D bpf_program__attach_uprobe_opts(skel->progs=
.test4,
> +                                                           urand_pid,
> +                                                           "./liburandom=
_read.so",
> +                                                           0 /* offset *=
/,
> +                                                           &uprobe_opts)=
;
> +       if (!ASSERT_ERR_PTR(skel->links.test4, "urandlib_api_attach_confl=
ict"))
> +               goto cleanup;
> +
> +       uprobe_opts.func_name =3D "urandlib_api@LIBURANDOM_READ_1.0.0";
> +       skel->links.test4 =3D bpf_program__attach_uprobe_opts(skel->progs=
.test4,
> +                                                           urand_pid,
> +                                                           "./liburandom=
_read.so",
> +                                                           0 /* offset *=
/,
> +                                                           &uprobe_opts)=
;
> +       if (!ASSERT_OK_PTR(skel->links.test4, "urandlib_api_attach_ok"))
> +               goto cleanup;
> +
> +       /* Auto attach 3 u[ret]probes to urandlib_api_sameoffset */
> +       err =3D test_uprobe__attach(skel);
> +       if (!ASSERT_OK(err, "skel_attach"))
> +               goto cleanup;
> +
> +       /* trigger urandom_read */
> +       ASSERT_OK(urand_trigger(&urand_pipe), "urand_exit_code");
> +
> +       ASSERT_EQ(skel->bss->test1_result, 1, "urandlib_api_sameoffset");
> +       ASSERT_EQ(skel->bss->test2_result, 1, "urandlib_api_sameoffset@v1=
");
> +       ASSERT_EQ(skel->bss->test3_result, 3, "urandlib_api_sameoffset@@v=
2");
> +       ASSERT_EQ(skel->bss->test4_result, 1, "urandlib_api");
> +
> +cleanup:
> +       if (urand_pipe)
> +               pclose(urand_pipe);
> +       test_uprobe__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_uprobe.c b/tools/test=
ing/selftests/bpf/progs/test_uprobe.c
> new file mode 100644
> index 000000000000..896c88a4960d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_uprobe.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Hengqi Chen */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +pid_t my_pid =3D 0;
> +
> +int test1_result =3D 0;
> +int test2_result =3D 0;
> +int test3_result =3D 0;
> +int test4_result =3D 0;
> +
> +SEC("uprobe/./liburandom_read.so:urandlib_api_sameoffset")
> +int BPF_UPROBE(test1)
> +{
> +       pid_t pid =3D bpf_get_current_pid_tgid() >> 32;
> +
> +       if (pid !=3D my_pid)
> +               return 0;
> +
> +       test1_result =3D 1;
> +       return 0;
> +}
> +
> +SEC("uprobe/./liburandom_read.so:urandlib_api_sameoffset@LIBURANDOM_READ=
_1.0.0")
> +int BPF_UPROBE(test2)
> +{
> +       pid_t pid =3D bpf_get_current_pid_tgid() >> 32;
> +
> +       if (pid !=3D my_pid)
> +               return 0;
> +
> +       test2_result =3D 1;
> +       return 0;
> +}
> +
> +SEC("uretprobe/./liburandom_read.so:urandlib_api_sameoffset@@LIBURANDOM_=
READ_2.0.0")
> +int BPF_URETPROBE(test3, int ret)
> +{
> +       pid_t pid =3D bpf_get_current_pid_tgid() >> 32;
> +
> +       if (pid !=3D my_pid)
> +               return 0;
> +
> +       test3_result =3D ret;
> +       return 0;
> +}
> +
> +SEC("uprobe")
> +int BPF_UPROBE(test4)
> +{
> +       pid_t pid =3D bpf_get_current_pid_tgid() >> 32;
> +
> +       if (pid !=3D my_pid)
> +               return 0;
> +
> +       test4_result =3D 1;
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/urandom_read.c b/tools/testing/s=
elftests/bpf/urandom_read.c
> index e92644d0fa75..b28e910a8fbb 100644
> --- a/tools/testing/selftests/bpf/urandom_read.c
> +++ b/tools/testing/selftests/bpf/urandom_read.c
> @@ -21,6 +21,11 @@ void urand_read_without_sema(int iter_num, int iter_cn=
t, int read_sz);
>  void urandlib_read_with_sema(int iter_num, int iter_cnt, int read_sz);
>  void urandlib_read_without_sema(int iter_num, int iter_cnt, int read_sz)=
;
>
> +int urandlib_api(void);
> +__asm__(".symver urandlib_api_old,urandlib_api@LIBURANDOM_READ_1.0.0");

any reason to not use COMPAT_VERSION() macro here?

> +int urandlib_api_old(void);
> +int urandlib_api_sameoffset(void);
> +
>  unsigned short urand_read_with_sema_semaphore SEC(".probes");
>
>  static __attribute__((noinline))
> @@ -83,6 +88,10 @@ int main(int argc, char *argv[])
>
>         urandom_read(fd, count);
>
> +       urandlib_api();
> +       urandlib_api_old();
> +       urandlib_api_sameoffset();
> +
>         close(fd);
>         return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/urandom_read_lib1.c b/tools/test=
ing/selftests/bpf/urandom_read_lib1.c
> index 86186e24b740..403b0735e223 100644
> --- a/tools/testing/selftests/bpf/urandom_read_lib1.c
> +++ b/tools/testing/selftests/bpf/urandom_read_lib1.c
> @@ -11,3 +11,44 @@ void urandlib_read_with_sema(int iter_num, int iter_cn=
t, int read_sz)
>  {
>         STAP_PROBE3(urandlib, read_with_sema, iter_num, iter_cnt, read_sz=
);
>  }
> +
> +/* Symbol versioning is different between static and shared library.
> + * Properly versioned symbols are needed for shared library, but
> + * only the symbol of the new version is needed for static library.
> + * Starting with GNU C 10, use symver attribute instead of .symver assem=
bler
> + * directive, which works better with GCC LTO builds.
> + */
> +#if defined(__GNUC__) && __GNUC__ >=3D 10
> +
> +#define DEFAULT_VERSION(internal_name, api_name, version) \
> +       __attribute__((symver(#api_name "@@" #version)))
> +#define COMPAT_VERSION(internal_name, api_name, version) \
> +       __attribute__((symver(#api_name "@" #version)))
> +
> +#else
> +
> +#define COMPAT_VERSION(internal_name, api_name, version) \
> +       asm(".symver " #internal_name "," #api_name "@" #version);
> +#define DEFAULT_VERSION(internal_name, api_name, version) \
> +       asm(".symver " #internal_name "," #api_name "@@" #version);
> +
> +#endif

maybe let's just use libbpf_internal.h instead of copy/pasting this
barely maintainable piece of magic?

> +
> +COMPAT_VERSION(urandlib_api_v1, urandlib_api, LIBURANDOM_READ_1.0.0)
> +int urandlib_api_v1(void)
> +{
> +       return 1;
> +}
> +
> +DEFAULT_VERSION(urandlib_api_v2, urandlib_api, LIBURANDOM_READ_2.0.0)
> +int urandlib_api_v2(void)
> +{
> +       return 2;
> +}
> +
> +COMPAT_VERSION(urandlib_api_sameoffset, urandlib_api_sameoffset, LIBURAN=
DOM_READ_1.0.0)
> +DEFAULT_VERSION(urandlib_api_sameoffset, urandlib_api_sameoffset, LIBURA=
NDOM_READ_2.0.0)
> +int urandlib_api_sameoffset(void)
> +{
> +       return 3;
> +}
> --
> 2.34.1
>

