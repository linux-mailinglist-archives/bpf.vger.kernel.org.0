Return-Path: <bpf+bounces-64546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B717B1415E
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 19:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAAE541442
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 17:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3553821C166;
	Mon, 28 Jul 2025 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="kPvtrtm5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4B2E3717
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724805; cv=none; b=eaMW/qGaW8odChBjKqSGSw/eaosdwUJheAXqDDosPlhpbc87X3xWpiVC0xF0KrFdnyfYwqdSiuAjsitL1sd1YSGHnIY/PvsqPhNwbPgA4CA57N2N/y/o+OImbmL/Zjnyi0QDg/gd46h+e3arr80boy/YJHJ+p3Zb8z3JzlTGIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724805; c=relaxed/simple;
	bh=G8m6x/njqLJB6f50MSyooofevCGhQ5BHLyCM95fVbkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pr5KmdzyQypxhfDWPvtO6EMCGWuL6EC2CtiUAdVkbfHPBbyPUoT4kpPS6AIlb5qqZ0Y62JX/rrTc+iamhB3GkvzXD8ORmdPLi8DwC8I0Gz1vFcew44itUmtSWC8SSXAyhTEiVHdwHc4I+syWgWxirmXGVjhTGvj9FtXqOWJCsmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=kPvtrtm5; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71a1df028b1so12147847b3.1
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1753724802; x=1754329602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STgXJYEYt4gwSriXEsADj5KWRYvl6r936ozi+VicdNo=;
        b=kPvtrtm5aRY/4snYCwFCa6NTZeMC+wT3RR21Q6zhdYwTKIAf5I/ngq1T3+CkZKaj03
         PRs4JAqsgzeYWKiL9yGqlLIqVSNtRDel+dJvt0NjxU79Ju6OwaFEyb3ikKqWbXSCCmUM
         F/o74NKBX3ujXBr55K2iVzbWOj8dK25gKPgj8kKDNlHRAnfv0P7WtAr2VD0mwsk4baXk
         AhX4ap+0za7BEpbMzITPro/Fct8FSlfYDAWPZUsz/a9Izw1Bz5/vfQ03PVaXj11p5z91
         RzhpZD3YfzbYK/Jkxx0Wed9K2ywXu1Cw5dTao25+IFe0MVGbHYpfbhmljFjCMP/i24mY
         IC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753724802; x=1754329602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STgXJYEYt4gwSriXEsADj5KWRYvl6r936ozi+VicdNo=;
        b=lXPxmLkEVlxqt7CAIRMFbTEo75RJE7PzVKzxy+dqpMICRTv/EvvIkjjocMGG0dzGZE
         xmAFvGkdvXDO6kPNJAKNnPtk8SfT+TZxDGN2Z+qSd8FuVWlh8MVMt/6PtQexSgvo2j5s
         V2Wh06PFqkLOM2Pj1DFETmjMId5lsrEqrEjFyDQ7MqzkMehWGNrM0ZGIqVXKeg7qC5Ip
         TBy9gHP6rh8kA7KXUdHl1mb6Xf/qsJOpn7+cvjRj4XuzOTycfUcS2/OOKNlX4yiDbIf3
         0diVdclKF2HvtYKJuJJAOUlIXa7twNWtbODoROQLbqp2wv8gMi82Dh7wa82HLKQkZWlF
         C9aA==
X-Gm-Message-State: AOJu0YziUKj41a6O1LKTtl2bxDiRHXF5BrtQfpYl70CK3RKO1J0EzMxb
	xqwcleNfsNl0fNg54W/WjMypFLukFqRGTE3+6WqHGhpyOosXdq/iIyTzLKv9OedENuPlbQ5VSEL
	Frhwgh13VMHtJdWhkPeO+PykeD8+8xlxck6ZfipjXZg==
X-Gm-Gg: ASbGncsXycexX3CxMM9WaMa7kDAAFSLwigOA83CQhVK8M9wYGs4IPHSGH1DdaI1lCu/
	ghjI1YQ/w2u+Xhaj/XB7X3lN2aF3XXOOlPyZQ4nxl5TOgd02F5FmQe4TqbQg9irknOQyYXSJp/3
	R2fCHveLFnrz35e/53XkpVQal3ntQVtBBTN9eoRrZpG6VrCDXtXqwTQw6QVm4njQEDvhUflrJt1
	IbBfWK/sxpD8eSKMdY=
X-Google-Smtp-Source: AGHT+IF5+XHSbPKkgJwJ6pVMBYVgYYYJi8NeHdAEMcQoNLg1AGPeSA2IPLnx0NLewL7/myxOolMzVbq1/uVOVxIm1ho=
X-Received: by 2002:a05:690c:498e:b0:71a:3101:e74c with SMTP id
 00721157ae682-71a3101ea99mr25331717b3.39.1753724802499; Mon, 28 Jul 2025
 10:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717164842.1848817-1-ameryhung@gmail.com> <20250717164842.1848817-3-ameryhung@gmail.com>
In-Reply-To: <20250717164842.1848817-3-ameryhung@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 28 Jul 2025 13:46:31 -0400
X-Gm-Features: Ac12FXyiYI9FqEB-YPNqiHtvqjlTTmeiIOD2QM-XrFFhaPcrOQhvGx4Q67uCdfM
Message-ID: <CABFh=a7u=B7VpVJFmZibh1yZ84XgYj2D_Ou7s1a=mH6_=8SKRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/3] selftests/bpf: Test basic task local data operations
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 12:49=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> Test basic operations of task local data with valid and invalid
> tld_create_key().
>
> For invalid calls, make sure they return the right error code and check
> that the TLDs are not inserted by running tld_get_data("
> value_not_exists") on the bpf side. The call should a null pointer.
>
> For valid calls, first make sure the TLDs are created by calling
> tld_get_data() on the bpf side. The call should return a valid pointer.
>
> Finally, verify that the TLDs are indeed task-specific (i.e., their
> addresses do not overlap) with multiple user threads. This done by
> writing values unique to each thread, reading them from both user space
> and bpf, and checking if the value read back matches the value written.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../bpf/prog_tests/test_task_local_data.c     | 192 ++++++++++++++++++
>  .../bpf/progs/test_task_local_data.c          |  65 ++++++
>  2 files changed, 257 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_loca=
l_data.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_dat=
a.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.=
c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> new file mode 100644
> index 000000000000..fde4a030ab42
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <pthread.h>
> +#include <bpf/btf.h>
> +#include <test_progs.h>
> +
> +#define TLD_FREE_DATA_ON_THREAD_EXIT
> +#define TLD_DYN_DATA_SIZE 4096
> +#include "task_local_data.h"
> +
> +struct test_tld_struct {
> +       __u64 a;
> +       __u64 b;
> +       __u64 c;
> +       __u64 d;
> +};
> +
> +#include "test_task_local_data.skel.h"
> +
> +TLD_DEFINE_KEY(value0_key, "value0", sizeof(int));
> +
> +/*
> + * Reset task local data between subtests by clearing metadata other
> + * than the statically defined value0. This is safe as subtests run
> + * sequentially. Users of task local data library should not touch
> + * library internal.
> + */
> +static void reset_tld(void)
> +{
> +       if (TLD_READ_ONCE(tld_metadata_p)) {
> +               /* Remove TLDs created by tld_create_key() */
> +               tld_metadata_p->cnt =3D 1;
> +               tld_metadata_p->size =3D TLD_DYN_DATA_SIZE;
> +               memset(&tld_metadata_p->metadata[1], 0,
> +                      (TLD_MAX_DATA_CNT - 1) * sizeof(struct tld_metadat=
a));
> +       }
> +}
> +
> +/* Serialize access to bpf program's global variables */
> +static pthread_mutex_t global_mutex;
> +
> +static tld_key_t *tld_keys;
> +
> +#define TEST_BASIC_THREAD_NUM 32
> +
> +void *test_task_local_data_basic_thread(void *arg)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts);
> +       struct test_task_local_data *skel =3D (struct test_task_local_dat=
a *)arg;
> +       int fd, err, tid, *value0, *value1;
> +       struct test_tld_struct *value2;
> +
> +       fd =3D bpf_map__fd(skel->maps.tld_data_map);
> +
> +       value0 =3D tld_get_data(fd, value0_key);
> +       if (!ASSERT_OK_PTR(value0, "tld_get_data"))
> +               goto out;
> +
> +       value1 =3D tld_get_data(fd, tld_keys[1]);
> +       if (!ASSERT_OK_PTR(value1, "tld_get_data"))
> +               goto out;
> +
> +       value2 =3D tld_get_data(fd, tld_keys[2]);
> +       if (!ASSERT_OK_PTR(value2, "tld_get_data"))
> +               goto out;
> +
> +       tid =3D gettid();
> +
> +       *value0 =3D tid + 0;
> +       *value1 =3D tid + 1;
> +       value2->a =3D tid + 2;
> +       value2->b =3D tid + 3;
> +       value2->c =3D tid + 4;
> +       value2->d =3D tid + 5;
> +
> +       pthread_mutex_lock(&global_mutex);
> +       /* Run task_main that read task local data and save to global var=
iables */
> +       err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_m=
ain), &opts);
> +       ASSERT_OK(err, "run task_main");
> +       ASSERT_OK(opts.retval, "task_main retval");
> +
> +       ASSERT_EQ(skel->bss->test_value0, tid + 0, "tld_get_data value0")=
;
> +       ASSERT_EQ(skel->bss->test_value1, tid + 1, "tld_get_data value1")=
;
> +       ASSERT_EQ(skel->bss->test_value2.a, tid + 2, "tld_get_data value2=
.a");
> +       ASSERT_EQ(skel->bss->test_value2.b, tid + 3, "tld_get_data value2=
.b");
> +       ASSERT_EQ(skel->bss->test_value2.c, tid + 4, "tld_get_data value2=
.c");
> +       ASSERT_EQ(skel->bss->test_value2.d, tid + 5, "tld_get_data value2=
.d");
> +       pthread_mutex_unlock(&global_mutex);
> +
> +       /* Make sure valueX are indeed local to threads */
> +       ASSERT_EQ(*value0, tid + 0, "value0");
> +       ASSERT_EQ(*value1, tid + 1, "value1");
> +       ASSERT_EQ(value2->a, tid + 2, "value2.a");
> +       ASSERT_EQ(value2->b, tid + 3, "value2.b");
> +       ASSERT_EQ(value2->c, tid + 4, "value2.c");
> +       ASSERT_EQ(value2->d, tid + 5, "value2.d");
> +
> +       *value0 =3D tid + 5;
> +       *value1 =3D tid + 4;
> +       value2->a =3D tid + 3;
> +       value2->b =3D tid + 2;
> +       value2->c =3D tid + 1;
> +       value2->d =3D tid + 0;
> +
> +       /* Run task_main again */
> +       pthread_mutex_lock(&global_mutex);
> +       err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_m=
ain), &opts);
> +       ASSERT_OK(err, "run task_main");
> +       ASSERT_OK(opts.retval, "task_main retval");
> +
> +       ASSERT_EQ(skel->bss->test_value0, tid + 5, "tld_get_data value0")=
;
> +       ASSERT_EQ(skel->bss->test_value1, tid + 4, "tld_get_data value1")=
;
> +       ASSERT_EQ(skel->bss->test_value2.a, tid + 3, "tld_get_data value2=
.a");
> +       ASSERT_EQ(skel->bss->test_value2.b, tid + 2, "tld_get_data value2=
.b");
> +       ASSERT_EQ(skel->bss->test_value2.c, tid + 1, "tld_get_data value2=
.c");
> +       ASSERT_EQ(skel->bss->test_value2.d, tid + 0, "tld_get_data value2=
.d");
> +       pthread_mutex_unlock(&global_mutex);
> +
> +out:
> +       pthread_exit(NULL);
> +}
> +
> +static void test_task_local_data_basic(void)
> +{
> +       struct test_task_local_data *skel;
> +       pthread_t thread[TEST_BASIC_THREAD_NUM];
> +       char dummy_key_name[TLD_NAME_LEN];
> +       tld_key_t key;
> +       int i, err;
> +
> +       reset_tld();
> +
> +       ASSERT_OK(pthread_mutex_init(&global_mutex, NULL), "pthread_mutex=
_init");
> +
> +       skel =3D test_task_local_data__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +               return;
> +
> +       tld_keys =3D calloc(TLD_MAX_DATA_CNT, sizeof(tld_key_t));
> +       if (!ASSERT_OK_PTR(tld_keys, "calloc tld_keys"))
> +               goto out;
> +
> +       ASSERT_FALSE(tld_key_is_err(value0_key), "TLD_DEFINE_KEY");
> +       tld_keys[1] =3D tld_create_key("value1", sizeof(int));
> +       ASSERT_FALSE(tld_key_is_err(tld_keys[1]), "tld_create_key");
> +       tld_keys[2] =3D tld_create_key("value2", sizeof(struct test_tld_s=
truct));
> +       ASSERT_FALSE(tld_key_is_err(tld_keys[2]), "tld_create_key");
> +
> +       /*
> +        * Shouldn't be able to store data exceed a page. Create a TLD ju=
st big
> +        * enough to exceed a page. TLDs already created are int value0, =
int
> +        * value1, and struct test_tld_struct value2.
> +        */
> +       key =3D tld_create_key("value_not_exist",
> +                            TLD_PAGE_SIZE - 2 * sizeof(int) - sizeof(str=
uct test_tld_struct) + 1);
> +       ASSERT_EQ(tld_key_err_or_zero(key), -E2BIG, "tld_create_key");
> +
> +       key =3D tld_create_key("value2", sizeof(struct test_tld_struct));
> +       ASSERT_EQ(tld_key_err_or_zero(key), -EEXIST, "tld_create_key");
> +
> +       /* Shouldn't be able to create the (TLD_MAX_DATA_CNT+1)-th TLD */
> +       for (i =3D 3; i < TLD_MAX_DATA_CNT; i++) {
> +               snprintf(dummy_key_name, TLD_NAME_LEN, "dummy_value%d", i=
);
> +               tld_keys[i] =3D tld_create_key(dummy_key_name, sizeof(int=
));
> +               ASSERT_FALSE(tld_key_is_err(tld_keys[i]), "tld_create_key=
");
> +       }
> +       key =3D tld_create_key("value_not_exist", sizeof(struct test_tld_=
struct));
> +       ASSERT_EQ(tld_key_err_or_zero(key), -ENOSPC, "tld_create_key");
> +
> +       /* Access TLDs from multiple threads and check if they are thread=
-specific */
> +       for (i =3D 0; i < TEST_BASIC_THREAD_NUM; i++) {
> +               err =3D pthread_create(&thread[i], NULL, test_task_local_=
data_basic_thread, skel);
> +               if (!ASSERT_OK(err, "pthread_create"))
> +                       goto out;
> +       }
> +
> +out:
> +       for (i =3D 0; i < TEST_BASIC_THREAD_NUM; i++)
> +               pthread_join(thread[i], NULL);
> +
> +       if (tld_keys) {
> +               free(tld_keys);
> +               tld_keys =3D NULL;
> +       }
> +       tld_free();
> +       test_task_local_data__destroy(skel);
> +}
> +
> +void test_task_local_data(void)
> +{
> +       if (test__start_subtest("task_local_data_basic"))
> +               test_task_local_data_basic();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_task_local_data.c b/t=
ools/testing/selftests/bpf/progs/test_task_local_data.c
> new file mode 100644
> index 000000000000..fffafc013044
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_task_local_data.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#include "task_local_data.bpf.h"
> +
> +struct tld_keys {
> +       tld_key_t value0;
> +       tld_key_t value1;
> +       tld_key_t value2;
> +       tld_key_t value_not_exist;
> +};
> +
> +struct test_tld_struct {
> +       __u64 a;
> +       __u64 b;
> +       __u64 c;
> +       __u64 d;
> +};
> +
> +int test_value0;
> +int test_value1;
> +struct test_tld_struct test_value2;
> +
> +SEC("syscall")
> +int task_main(void *ctx)
> +{
> +       struct tld_object tld_obj;
> +       struct test_tld_struct *struct_p;
> +       struct task_struct *task;
> +       int err, *int_p;
> +
> +       task =3D bpf_get_current_task_btf();
> +       err =3D tld_object_init(task, &tld_obj);
> +       if (err)
> +               return 1;
> +
> +       int_p =3D tld_get_data(&tld_obj, value0, "value0", sizeof(int));
> +       if (int_p)
> +               test_value0 =3D *int_p;
> +       else
> +               return 2;
> +
> +       int_p =3D tld_get_data(&tld_obj, value1, "value1", sizeof(int));
> +       if (int_p)
> +               test_value1 =3D *int_p;
> +       else
> +               return 3;
> +
> +       struct_p =3D tld_get_data(&tld_obj, value2, "value2", sizeof(stru=
ct test_tld_struct));
> +       if (struct_p)
> +               test_value2 =3D *struct_p;
> +       else
> +               return 4;
> +
> +       int_p =3D tld_get_data(&tld_obj, value_not_exist, "value_not_exis=
t", sizeof(int));
> +       if (int_p)
> +               return 5;
> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.47.1
>
>

