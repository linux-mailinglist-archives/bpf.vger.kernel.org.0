Return-Path: <bpf+bounces-64832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397FAB1761B
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 20:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80053B4631
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5CD2C3278;
	Thu, 31 Jul 2025 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="aQcOYSSU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1340262FF5
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753986475; cv=none; b=TJOESFMH0i0sRYh1t9naRBuPcVRgFamFr5F81yOZtM6IvyPxPQp9xh+Gsnzfot+PzcXpLGJ54ydEAUg4fqlzVaIpiKKpr5DnrvdEUQb4puTbKibTddpO2dhPaObUQplw8Y+XXgvbkGj51v10DSL+fnuALHpj9bH66PYYsXO72V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753986475; c=relaxed/simple;
	bh=mkul41ig5MZ/oO1QqF4ezjSqut/qfYnZNsFzskZW5Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkIyx/r7UQL0RRKVWkUzGhFZ7f6gQZEXJ7k0xc1D2iutP/R6q/EMqOum3VQQ/eCJRICNsjpi9984fkptXS43GZXl52WQPYSEI5pOEaTo4dC1LhlvTNwEbUKpFzynNQnxGVU2HJRN/dJDynr7f9rSQUrm/JHi2cE+hB7CnZ9gFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=aQcOYSSU; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71b52d6d1e3so12643487b3.1
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1753986472; x=1754591272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOejpcVoAEyaqEbZ37G6mLmP8K1nuiYpF+txrVxaF+c=;
        b=aQcOYSSUgqIbdi/eppUqL/U/mB2sJbkCy4fJGJn2pC3J3vWT9WMTzYLP3Mz6jBMxUc
         exPSX4RWRvlKhgEI2qzvLSVHBeduD7M3FJM7Jp2KpB5+2/iGHQ93FeJCp+ZTxgXfzTdE
         oW5jnf9cuOp08kfzMlf/c4YMEAUO/S1c03uqvvUpUp0WtNI+N/LQyUuvWTNp1PwoqAoh
         nXE83MCy68jwpAGF21hxzY9iY592W6xHtY2jK9EQJyr9f95DweYBPg/Z7CvNqtW+lBxV
         C+S9V348ihLWP3uWFvmz+KBr/iqLL+tPb3r3xU2ZFWwMZMko277Wevzo0gyC1QH++7bc
         Bfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753986472; x=1754591272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOejpcVoAEyaqEbZ37G6mLmP8K1nuiYpF+txrVxaF+c=;
        b=YcGY3SdO6xmfAz4Yp3hBJmLQZ8qqhNpIh6SHoRbvVnYyejNSnuI4OfUWXRJV+9BKrD
         qF/66sxBUnHt27ZcBj4MaARsV5ggEJwfDYj2ftrUkjzlSEeLa6qQaOA+ExhPAO9cvRmC
         TjCdS8EYirngT6sdKkR2ZL+ssLSX+iq0Wj3/raChuPOsW3AcLjZ7kI6WCd1dBxuiIptA
         NWdjdrj4bsv61/Ca0dNh6NFw8htDmUm7HR4s0PaVlXMIhfyzPT3OIfUEyemQ2rqk+N3g
         0E7KMCU69tOY1V99Z5albXPqFs9evejeCpTpwHAeGVViAV3lzpjBybh0dHQcXrr3Zr+g
         VOBw==
X-Gm-Message-State: AOJu0YwNkeVSH0adSFRIqbL/wWFGzxcSGJ/rGhCjxq1aYQmHH5NwClVx
	tJkvnfaT9PYaXPfC8xTlwFeJ0ruo8W2IBNM8RCg8Tldn8Hf0E6g4ih0f7SiWuDgliwxJ1S3wN/6
	ZC+JX+0u8hrW4rmmOZnQEeezmk2ZcBUPZ7p7xfUToDw==
X-Gm-Gg: ASbGnct1hFRq77Tc9MjF4IV1jaiO3+MsfkN4Ggvu/mNxpY1afBp2i1Z6jkiKkg25kRl
	koBLTCnOPStOgwP34ILBprGdkECPtuQlF2JYHaClBCq8LUi8/zbnTkCowF9Ic1M+kWI8QmM3NDQ
	Rv8h20UgmDQl9H5cYpAqOVm0Ft+YdhJL0vNG2pmTdzZzdXVXs/YxfhfXeIeZW8ddzDbZ50irB0j
	xiPi3FH
X-Google-Smtp-Source: AGHT+IHS7Ge0ZKzHwi0IjgT3RBWaUFXtT4trLOqBEHWG7mq96jLInsZOWuST9tHzqvvn4HhKMbEMVCLZoIQBtVOTq0c=
X-Received: by 2002:a05:690c:4d89:b0:71a:34bb:4277 with SMTP id
 00721157ae682-71a4659a89cmr107529047b3.18.1753986472359; Thu, 31 Jul 2025
 11:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730185903.3574598-1-ameryhung@gmail.com> <20250730185903.3574598-5-ameryhung@gmail.com>
In-Reply-To: <20250730185903.3574598-5-ameryhung@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Thu, 31 Jul 2025 14:27:41 -0400
X-Gm-Features: Ac12FXzXnFl7ODSKMd0hZhDMevfFixQMXjNimv-fJJm5Jw0hr3MvluHBtDoDM3Q
Message-ID: <CABFh=a4LqeMTfcT2+K_aHBUEfL=rHLrhn3hnDoror_pZVBhhDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/4] selftests/bpf: Test concurrent task local
 data key creation
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 2:59=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Test thread-safety of tld_create_key(). Since tld_create_key() does
> not rely on locks but memory barriers and atomic operations to protect
> the shared metadata, the thread-safety of the function is non-trivial.
> Make sure concurrent tld_key_create(), both valid and invalid, can not
> race and corrupt metatada, which may leads to TLDs not being thread-
> specific or duplicate TLDs with the same name.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>


> ---
>  .../bpf/prog_tests/test_task_local_data.c     | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.=
c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> index 2e77d3fa2534..3b5cd2cd89c7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> @@ -185,8 +185,113 @@ static void test_task_local_data_basic(void)
>         test_task_local_data__destroy(skel);
>  }
>
> +#define TEST_RACE_THREAD_NUM (TLD_MAX_DATA_CNT - 3)
> +
> +void *test_task_local_data_race_thread(void *arg)
> +{
> +       int err =3D 0, id =3D (intptr_t)arg;
> +       char key_name[32];
> +       tld_key_t key;
> +
> +       key =3D tld_create_key("value_not_exist", TLD_PAGE_SIZE + 1);
> +       if (tld_key_err_or_zero(key) !=3D -E2BIG) {
> +               err =3D 1;
> +               goto out;
> +       }
> +
> +       /* Only one thread will succeed in creating value1 */
> +       key =3D tld_create_key("value1", sizeof(int));
> +       if (!tld_key_is_err(key))
> +               tld_keys[1] =3D key;
> +
> +       /* Only one thread will succeed in creating value2 */
> +       key =3D tld_create_key("value2", sizeof(struct test_tld_struct));
> +       if (!tld_key_is_err(key))
> +               tld_keys[2] =3D key;
> +
> +       snprintf(key_name, 32, "thread_%d", id);
> +       tld_keys[id] =3D tld_create_key(key_name, sizeof(int));
> +       if (tld_key_is_err(tld_keys[id]))
> +               err =3D 2;
> +out:
> +       return (void *)(intptr_t)err;
> +}
> +
> +static void test_task_local_data_race(void)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts);
> +       pthread_t thread[TEST_RACE_THREAD_NUM];
> +       struct test_task_local_data *skel;
> +       int fd, i, j, err, *data;
> +       void *ret =3D NULL;
> +
> +       skel =3D test_task_local_data__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +               return;
> +
> +       tld_keys =3D calloc(TLD_MAX_DATA_CNT, sizeof(tld_key_t));
> +       if (!ASSERT_OK_PTR(tld_keys, "calloc tld_keys"))
> +               goto out;
> +
> +       fd =3D bpf_map__fd(skel->maps.tld_data_map);
> +
> +       ASSERT_FALSE(tld_key_is_err(value0_key), "TLD_DEFINE_KEY");
> +       tld_keys[0] =3D value0_key;
> +
> +       for (j =3D 0; j < 100; j++) {
> +               reset_tld();
> +
> +               for (i =3D 0; i < TEST_RACE_THREAD_NUM; i++) {
> +                       /*
> +                        * Try to make tld_create_key() race with each ot=
her. Call
> +                        * tld_create_key(), both valid and invalid, from=
 different threads.
> +                        */
> +                       err =3D pthread_create(&thread[i], NULL, test_tas=
k_local_data_race_thread,
> +                                            (void *)(intptr_t)(i + 3));
> +                       if (CHECK_FAIL(err))
> +                               break;
> +               }
> +
> +               /* Wait for all tld_create_key() to return */
> +               for (i =3D 0; i < TEST_RACE_THREAD_NUM; i++) {
> +                       pthread_join(thread[i], &ret);
> +                       if (CHECK_FAIL(ret))
> +                               break;
> +               }
> +
> +               /* Write a unique number to each TLD */
> +               for (i =3D 0; i < TLD_MAX_DATA_CNT; i++) {
> +                       data =3D tld_get_data(fd, tld_keys[i]);
> +                       if (CHECK_FAIL(!data))
> +                               break;
> +                       *data =3D i;
> +               }
> +
> +               /* Read TLDs and check the value to see if any address co=
llides with another */
> +               for (i =3D 0; i < TLD_MAX_DATA_CNT; i++) {
> +                       data =3D tld_get_data(fd, tld_keys[i]);
> +                       if (CHECK_FAIL(*data !=3D i))
> +                               break;
> +               }
> +
> +               /* Run task_main to make sure no invalid TLDs are added *=
/
> +               err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->prog=
s.task_main), &opts);
> +               ASSERT_OK(err, "run task_main");
> +               ASSERT_OK(opts.retval, "task_main retval");
> +       }
> +out:
> +       if (tld_keys) {
> +               free(tld_keys);
> +               tld_keys =3D NULL;
> +       }
> +       tld_free();
> +       test_task_local_data__destroy(skel);
> +}
> +
>  void test_task_local_data(void)
>  {
>         if (test__start_subtest("task_local_data_basic"))
>                 test_task_local_data_basic();
> +       if (test__start_subtest("task_local_data_race"))
> +               test_task_local_data_race();
>  }
> --
> 2.47.3
>

