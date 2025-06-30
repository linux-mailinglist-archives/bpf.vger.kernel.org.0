Return-Path: <bpf+bounces-61859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF117AEE4DF
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 18:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2DF3AE4D5
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1028FFFB;
	Mon, 30 Jun 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hppVB7JA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B428D8C4;
	Mon, 30 Jun 2025 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301788; cv=none; b=FX944dwgVW65m2MU4ueembSKpJ+2uund+3YeffKxRAj6HJwqDjp/pwXsDLViZhDKVhY1HSBs04Sg8kHc2PLqJ44crccP3rmQkcLQmMKaoYt07/iSMWK7dixViDbzzQdRR+Zob+kyDUzRPWtgdKyqaFVQVj+Bxarxs6t+ClbO+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301788; c=relaxed/simple;
	bh=b81jm690BRGdHTqsodDY7UJkMuUHyFXcBnBMg3AFPok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrb926ClOp3js7YlAYwv4HsmnOGnLv31b3TvNTGiF8wLMR1TDfqFbo6yeRycgHfQoaDWre3NYW9p33Asbd8oE+J10XBlwZ89JDne72y1dLE2arFaBYPR0Cm1j5ZWXQN/ZZBYU/OO+VnNOS3HzmfIVk5P5ojKbj1owMu+WpVK6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hppVB7JA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-710bbd7a9e2so23378197b3.0;
        Mon, 30 Jun 2025 09:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751301784; x=1751906584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB5qgM2aeToiw2WU0eSqtXltuPgJyqlHduN0WzTRcRE=;
        b=hppVB7JAfMIhkxmbLel9t0p72xzEyJ74tDhT1X01gJgs4WQslSAh6J5nyG7renAtwP
         UVif1+IStAmo+UjNnFLFVo+/cSiXE2mPsJtx+OkYfxbnfx6WO2Dh4hcHqQYqr/8XF3pO
         hbadeGuxVxVlyeoC88CLEgcLMpLTxDPz2mmUOd6IPry9pRt5A3fRm0oO9pUDSv6gC6bZ
         uAp36/icXCL9b0lghR2yMEcLuySXwu2YOkYOWSGGBJtGx/CAg9haKH79MKfLAaHgYSL5
         Vi/LVlwuQT2Axbw4h+U8XEbOZg6wGd6/vxyJRx7MZqn85xae6yoKsjJ3Pj+/T74xe5Hn
         HI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301784; x=1751906584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CB5qgM2aeToiw2WU0eSqtXltuPgJyqlHduN0WzTRcRE=;
        b=t3AVGM0iomkNMXDSV6DD89yrBjX7z9NQGYA1aM6BaiAWkC93kp9g+Ig9y0YEpCWHQe
         yAc8xKCmsjtC/umnoRZtOsPV1QiJb0ZVnLadD9xhRsjQ1yN9UbbigF0ZkocDnuZXrNk9
         nhbtXm695vLtfzLCMThA29rohzGO/tNLTT2oMOEJju00woFF3bpXoe/VfHfXM4subdl3
         xfeKQ2b79EkRZ6Gw8Te6LP+ugqRcJzYOpTsgARUGfB9JLLDMBYFr7uNrzG+EMEvVqep2
         xJMGh3N/TnEgSx3AAPn5XXPKK9l4DVDKEHIDjtYXcZinMu+xlG5OyHNEQcPKKQJb1T5L
         NJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9CSPqJgWBhrLv4t2HfUFMm44L1xW3oqljjSs1d+yWMDv8fmzdBTha3QSCukjBifYyzN2VgQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51oFLH9nqyMa9gJhQgd4lPhfi+kuXWUy7MhlT1CrA2JbApp/i
	gmB3XC/BIg6kJZq96axbkofoOOH/nSg/2KS5lB9woSbm1xCYnbGYUvlj5AgGG0zAapHx6kF/lyA
	whq7filBnKIBX9l5jmSrkubpIYgbcK7Ip9g==
X-Gm-Gg: ASbGncvyuuhOqjCcE2/8wD8De+QFF5DBYOE4pa/NkkgkrAWQqpo0JpMm/ZAdaB/dKww
	7cCg6NBf2r/t+VSRUH0ZXhRAaUer9xoBg0P3f4+gfeaMLZoR/vqSw6E6xTMFDEzi8TP+8HVaIvl
	8c6ASeVDqkRGE2rdnGE6ovBKyvNp/sfLdgdzQ1RW7pAYTmXBGRLegY8pnblZg=
X-Google-Smtp-Source: AGHT+IFTC5O41RfR133s6WCPWv2QOIHoT8CCIAgFYFwTd3sQ8M7Vv7r4MkL0vvlC8dczjZ9IFYNFo6NsP7bV+NRXfoo=
X-Received: by 2002:a05:690c:6f87:b0:710:e7e3:ff6 with SMTP id
 00721157ae682-7151714885dmr189047937b3.12.1751301783785; Mon, 30 Jun 2025
 09:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627233958.2602271-1-ameryhung@gmail.com> <20250627233958.2602271-3-ameryhung@gmail.com>
 <aGJz2waYK8mhvB49@krava>
In-Reply-To: <aGJz2waYK8mhvB49@krava>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 30 Jun 2025 09:42:50 -0700
X-Gm-Features: Ac12FXzJOeEJ6Ca9agxeEInVbfR4PjLz6UeViJzWrN3GPtnS7ftYNP6_gCOzJPY
Message-ID: <CAMB2axM1X15QmGHbDBBVkBaQYPzzkaDDFFUZH30T3-HN0nSLEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] selftests/bpf: Test basic task local data operations
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 4:24=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Jun 27, 2025 at 04:39:56PM -0700, Amery Hung wrote:
> > Test basic operations of task local data with valid and invalid
> > tld_create_key().
> >
> > For invalid calls, make sure they return the right error code and check
> > that the TLDs are not inserted by running tld_get_data("
> > value_not_exists") on the bpf side. The call should a null pointer.
> >
> > For valid calls, first make sure the TLDs are created by calling
> > tld_get_data() on the bpf side. The call should return a valid pointer.
> >
> > Finally, verify that the TLDs are indeed task-specific (i.e., their
> > addresses do not overlap) with multiple user threads. This done by
> > writing values unique to each thread, reading them from both user space
> > and bpf, and checking if the value read back matches the value written.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../bpf/prog_tests/test_task_local_data.c     | 191 ++++++++++++++++++
> >  .../bpf/progs/test_task_local_data.c          |  65 ++++++
> >  2 files changed, 256 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_lo=
cal_data.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_d=
ata.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_dat=
a.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> > new file mode 100644
> > index 000000000000..53cdb8466f8e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> > @@ -0,0 +1,191 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <pthread.h>
> > +#include <bpf/btf.h>
> > +#include <test_progs.h>
> > +
> > +struct test_struct {
> > +     __u64 a;
> > +     __u64 b;
> > +     __u64 c;
> > +     __u64 d;
> > +};
>
> hi,
> I can't compile this on my config, bacause of the KGDB_TESTS config
> that defines struct test_struct
>
> progs/test_task_local_data.c:16:8: error: redefinition of 'test_struct'
>    16 | struct test_struct {
>       |        ^
> /home/jolsa/kernel/linux-qemu-1/tools/testing/selftests/bpf/tools/include=
/vmlinux.h:141747:8: note: previous definition is here
>  141747 | struct test_struct {
>
>
> also I have these tests passing localy, but it's failing CI:
>   https://github.com/kernel-patches/bpf/actions/runs/15939264078/job/4496=
4987935
>

Thanks for reporting the error. I will change the test_struct name.

For the CI failure, I will fix it by changing the type of "off" in the
bpf tld_get_data() from int to s64.

Thanks,
Amery

> thanks,
> jirka
>
>
> > +
> > +#define TLD_FREE_DATA_ON_THREAD_EXIT
> > +#define TLD_DYN_DATA_SIZE 4096
> > +#include "task_local_data.h"
> > +
> > +#include "test_task_local_data.skel.h"
> > +
> > +TLD_DEFINE_KEY(value0_key, "value0", sizeof(int));
> > +
> > +/*
> > + * Reset task local data between subtests by clearing metadata. This i=
s safe
> > + * as subtests run sequentially. Users of task local data libraries
> > + * should not do this.
> > + */
> > +static void reset_tld(void)
> > +{
> > +     if (TLD_READ_ONCE(tld_metadata_p)) {
> > +             /* Remove TLDs created by tld_create_key() */
> > +             tld_metadata_p->cnt =3D 1;
> > +             tld_metadata_p->size =3D TLD_DYN_DATA_SIZE;
> > +             memset(&tld_metadata_p->metadata[1], 0,
> > +                    (TLD_MAX_DATA_CNT - 1) * sizeof(struct tld_metadat=
a));
> > +     }
> > +}
> > +
> > +/* Serialize access to bpf program's global variables */
> > +static pthread_mutex_t global_mutex;
> > +
> > +static tld_key_t *tld_keys;
> > +
> > +#define TEST_BASIC_THREAD_NUM TLD_MAX_DATA_CNT
> > +
> > +void *test_task_local_data_basic_thread(void *arg)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, opts);
> > +     struct test_task_local_data *skel =3D (struct test_task_local_dat=
a *)arg;
> > +     int fd, err, tid, *value0, *value1;
> > +     struct test_struct *value2;
> > +
> > +     fd =3D bpf_map__fd(skel->maps.tld_data_map);
> > +
> > +     value0 =3D tld_get_data(fd, value0_key);
> > +     if (!ASSERT_OK_PTR(value0, "tld_get_data"))
> > +             goto out;
> > +
> > +     value1 =3D tld_get_data(fd, tld_keys[0]);
> > +     if (!ASSERT_OK_PTR(value1, "tld_get_data"))
> > +             goto out;
> > +
> > +     value2 =3D tld_get_data(fd, tld_keys[1]);
> > +     if (!ASSERT_OK_PTR(value2, "tld_get_data"))
> > +             goto out;
> > +
> > +     tid =3D gettid();
> > +
> > +     *value0 =3D tid + 0;
> > +     *value1 =3D tid + 1;
> > +     value2->a =3D tid + 2;
> > +     value2->b =3D tid + 3;
> > +     value2->c =3D tid + 4;
> > +     value2->d =3D tid + 5;
> > +
> > +     pthread_mutex_lock(&global_mutex);
> > +     /* Run task_main that read task local data and save to global var=
iables */
> > +     err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_m=
ain), &opts);
> > +     ASSERT_OK(err, "run task_main");
> > +     ASSERT_OK(opts.retval, "task_main retval");
> > +
> > +     ASSERT_EQ(skel->bss->test_value0, tid + 0, "tld_get_data value0")=
;
> > +     ASSERT_EQ(skel->bss->test_value1, tid + 1, "tld_get_data value1")=
;
> > +     ASSERT_EQ(skel->bss->test_value2.a, tid + 2, "tld_get_data value2=
.a");
> > +     ASSERT_EQ(skel->bss->test_value2.b, tid + 3, "tld_get_data value2=
.b");
> > +     ASSERT_EQ(skel->bss->test_value2.c, tid + 4, "tld_get_data value2=
.c");
> > +     ASSERT_EQ(skel->bss->test_value2.d, tid + 5, "tld_get_data value2=
.d");
> > +     pthread_mutex_unlock(&global_mutex);
> > +
> > +     /* Make sure valueX are indeed local to threads */
> > +     ASSERT_EQ(*value0, tid + 0, "value0");
> > +     ASSERT_EQ(*value1, tid + 1, "value1");
> > +     ASSERT_EQ(value2->a, tid + 2, "value2.a");
> > +     ASSERT_EQ(value2->b, tid + 3, "value2.b");
> > +     ASSERT_EQ(value2->c, tid + 4, "value2.c");
> > +     ASSERT_EQ(value2->d, tid + 5, "value2.d");
> > +
> > +     *value0 =3D tid + 5;
> > +     *value1 =3D tid + 4;
> > +     value2->a =3D tid + 3;
> > +     value2->b =3D tid + 2;
> > +     value2->c =3D tid + 1;
> > +     value2->d =3D tid + 0;
> > +
> > +     /* Run task_main again */
> > +     pthread_mutex_lock(&global_mutex);
> > +     err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_m=
ain), &opts);
> > +     ASSERT_OK(err, "run task_main");
> > +     ASSERT_OK(opts.retval, "task_main retval");
> > +
> > +     ASSERT_EQ(skel->bss->test_value0, tid + 5, "tld_get_data value0")=
;
> > +     ASSERT_EQ(skel->bss->test_value1, tid + 4, "tld_get_data value1")=
;
> > +     ASSERT_EQ(skel->bss->test_value2.a, tid + 3, "tld_get_data value2=
.a");
> > +     ASSERT_EQ(skel->bss->test_value2.b, tid + 2, "tld_get_data value2=
.b");
> > +     ASSERT_EQ(skel->bss->test_value2.c, tid + 1, "tld_get_data value2=
.c");
> > +     ASSERT_EQ(skel->bss->test_value2.d, tid + 0, "tld_get_data value2=
.d");
> > +     pthread_mutex_unlock(&global_mutex);
> > +
> > +out:
> > +     pthread_exit(NULL);
> > +}
> > +
> > +static void test_task_local_data_basic(void)
> > +{
> > +     struct test_task_local_data *skel;
> > +     pthread_t thread[TEST_BASIC_THREAD_NUM];
> > +     char dummy_key_name[TLD_NAME_LEN];
> > +     tld_key_t key;
> > +     int i, err;
> > +
> > +     reset_tld();
> > +
> > +     ASSERT_OK(pthread_mutex_init(&global_mutex, NULL), "pthread_mutex=
_init");
> > +
> > +     skel =3D test_task_local_data__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> > +             return;
> > +
> > +     tld_keys =3D calloc(TEST_BASIC_THREAD_NUM, sizeof(tld_key_t));
> > +     if (!ASSERT_OK_PTR(tld_keys, "calloc tld_keys"))
> > +             goto out;
> > +
> > +     ASSERT_FALSE(tld_key_is_err(value0_key), "TLD_DEFINE_KEY");
> > +     tld_keys[0] =3D tld_create_key("value1", sizeof(int));
> > +     ASSERT_FALSE(tld_key_is_err(tld_keys[0]), "tld_create_key");
> > +     tld_keys[1] =3D tld_create_key("value2", sizeof(struct test_struc=
t));
> > +     ASSERT_FALSE(tld_key_is_err(tld_keys[1]), "tld_create_key");
> > +
> > +     /*
> > +      * Shouldn't be able to store data exceed a page. Create a TLD ju=
st big
> > +      * enough to exceed a page. TLDs already created are int value0, =
int
> > +      * value1, and struct test_struct value2.
> > +      */
> > +     key =3D tld_create_key("value_not_exist",
> > +                          TLD_PAGE_SIZE - 2 * sizeof(int) - sizeof(str=
uct test_struct) + 1);
> > +     ASSERT_EQ(tld_key_err_or_zero(key), -E2BIG, "tld_create_key");
> > +
> > +     key =3D tld_create_key("value2", sizeof(struct test_struct));
> > +     ASSERT_EQ(tld_key_err_or_zero(key), -EEXIST, "tld_create_key");
> > +
> > +     /* Shouldn't be able to create the (TLD_MAX_DATA_CNT+1)-th TLD */
> > +     for (i =3D 3; i < TLD_MAX_DATA_CNT; i++) {
> > +             snprintf(dummy_key_name, TLD_NAME_LEN, "dummy_value%d", i=
);
> > +             tld_keys[i] =3D tld_create_key(dummy_key_name, sizeof(int=
));
> > +             ASSERT_FALSE(tld_key_is_err(tld_keys[i]), "tld_create_key=
");
> > +     }
> > +     key =3D tld_create_key("value_not_exist", sizeof(struct test_stru=
ct));
> > +     ASSERT_EQ(tld_key_err_or_zero(key), -ENOSPC, "tld_create_key");
> > +
> > +     /* Access TLDs from multiple threads and check if they are thread=
-specific */
> > +     for (i =3D 0; i < TEST_BASIC_THREAD_NUM; i++) {
> > +             err =3D pthread_create(&thread[i], NULL, test_task_local_=
data_basic_thread, skel);
> > +             if (!ASSERT_OK(err, "pthread_create"))
> > +                     goto out;
> > +     }
> > +
> > +out:
> > +     for (i =3D 0; i < TEST_BASIC_THREAD_NUM; i++)
> > +             pthread_join(thread[i], NULL);
> > +
> > +     if (tld_keys) {
> > +             free(tld_keys);
> > +             tld_keys =3D NULL;
> > +     }
> > +     tld_free();
> > +     test_task_local_data__destroy(skel);
> > +}
> > +
> > +void test_task_local_data(void)
> > +{
> > +     if (test__start_subtest("task_local_data_basic"))
> > +             test_task_local_data_basic();
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_task_local_data.c b=
/tools/testing/selftests/bpf/progs/test_task_local_data.c
> > new file mode 100644
> > index 000000000000..94d1745dd8d4
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_task_local_data.c
> > @@ -0,0 +1,65 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <vmlinux.h>
> > +#include <errno.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +#include "task_local_data.bpf.h"
> > +
> > +struct tld_keys {
> > +     tld_key_t value0;
> > +     tld_key_t value1;
> > +     tld_key_t value2;
> > +     tld_key_t value_not_exist;
> > +};
> > +
> > +struct test_struct {
> > +     unsigned long a;
> > +     unsigned long b;
> > +     unsigned long c;
> > +     unsigned long d;
> > +};
> > +
> > +int test_value0;
> > +int test_value1;
> > +struct test_struct test_value2;
> > +
> > +SEC("syscall")
> > +int task_main(void *ctx)
> > +{
> > +     struct tld_object tld_obj;
> > +     struct test_struct *struct_p;
> > +     struct task_struct *task;
> > +     int err, *int_p;
> > +
> > +     task =3D bpf_get_current_task_btf();
> > +     err =3D tld_object_init(task, &tld_obj);
> > +     if (err)
> > +             return 1;
> > +
> > +     int_p =3D tld_get_data(&tld_obj, value0, "value0", sizeof(int));
> > +     if (int_p)
> > +             test_value0 =3D *int_p;
> > +     else
> > +             return 2;
> > +
> > +     int_p =3D tld_get_data(&tld_obj, value1, "value1", sizeof(int));
> > +     if (int_p)
> > +             test_value1 =3D *int_p;
> > +     else
> > +             return 3;
> > +
> > +     struct_p =3D tld_get_data(&tld_obj, value2, "value2", sizeof(stru=
ct test_struct));
> > +     if (struct_p)
> > +             test_value2 =3D *struct_p;
> > +     else
> > +             return 4;
> > +
> > +     int_p =3D tld_get_data(&tld_obj, value_not_exist, "value_not_exis=
t", sizeof(int));
> > +     if (int_p)
> > +             return 5;
> > +
> > +     return 0;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > --
> > 2.47.1
> >
> >

