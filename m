Return-Path: <bpf+bounces-64548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E78B141B8
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4C07A73DC
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C726463A;
	Mon, 28 Jul 2025 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="NriczTb3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C421D3D6
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725611; cv=none; b=HKtH7galb5MaQANA6b3J8Ky0psQC3S78SVgPzrurS0f5QZfgeL2vyD7UXAJSLDblqnqgq35df5xa2BbMB6YPKJGGiw6HxFuMnfM7fqZgyOJz0ODTRBM6o1XbsAIDmOkTdeb0MCJcku8PiWnyDghjNClg0bsrzY12xCxWl+2goN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725611; c=relaxed/simple;
	bh=iKYYXYU3kztPrvshqIoQqsBr9Q3R9Rjku5p1Xr/11eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7rHhES/Jca2A8KUlpcwDbsW06h4BqjmVaIuTeGi8qEqJlJBLJrUifF+42At6WFQ1OSydTtgV3sVI5SYx+m4i57vLJs/dOYhmJUMSs/SjquACbZWrdAwMTpuJbdUDpSL50H4+gyVSrf5o8fRxa3gYdnXudSQW3EnH+ognyl3y88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=NriczTb3; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-718389fb988so41870417b3.1
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1753725608; x=1754330408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPYhbPyoxtTqfzZvkF/q/aqSvB2qPK5VJT7HARAmoyA=;
        b=NriczTb3ply7dUQir392gfobkXeh6MIRLHZvk7+8OFaImvMZ41OsQqi1zoOnIDU7ei
         wNQAdOjdRLNU9DCgZ2lQLzgIWtc2u5jdYkUOnGF0thQzNgJ7oJrZulXA4sbkUWHnoSlJ
         nlEH5Erhjaz/Tnt0MxPv70/qEs5KUfzTE2kuu6ebx/6b2xfQ83RnazEXZy+FQvsu0bxR
         8+iXLl1jUaqF3rETGdDkWb02jqacdmNonp2gAop6yO4ONH80j0KhA2Nd14i+NhTj91QV
         qbAo86HffFxmvLv67j8GYp0aWkUu8zSPq9nx8/MKvjDDqrLLjWaKLJoVNldsG72R/m0H
         BQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725608; x=1754330408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPYhbPyoxtTqfzZvkF/q/aqSvB2qPK5VJT7HARAmoyA=;
        b=kwSX/N0Ys/dqx1ctUHpy1rzItqHW8ED9kHoRScYSVuKxYsxh45EUrJqgrM/PJw3S6x
         WnkjY1OjbOj/vjWchwGUKA0AkKF2TP6ibnk1HSiNE3gsDRrMsvEGnC7hm7dBlZGOZhS/
         i48F7muQiXsbdY+XtNSri9g9gafrpqP6cN9IR6cR/FPZ6jq1lXYHi1JJTwhbbCbRLw4T
         61ZCPcLpmy+qDpP+fwaHdfhTOnbR+D5wPtXapOnM3f7X4svvJxyCyPU8vNn2gH/KEnvI
         I1kI20cjmmIjMd6FYe1+zdTNJLtWvdQoE6eg6XkQXYKA7OLei2H1NHZ1lR5SCJ50RNzk
         vokA==
X-Gm-Message-State: AOJu0YxhEM3k1SWJwum3r1jlw5p6jpt151DXeRlR2sskncL3qV4uFl/l
	gPlNovBwkw+2ntqpUotVlqK92ZDsOjU4+BSFyql+C2ReU/KItibF8UeucBj5l8ugJmgIOM0jUYI
	y49yknojc0Omtdi5J3y0CAQp/B6Ot07/AtXrxgZC26g==
X-Gm-Gg: ASbGnct6S8ghujYUEy9XHxhNnNOF7UvBRezcJNrjt0mIk9BTIBt+A34v/1Nn7UDUhHD
	NvGA7PvJXCid6VwoWicnmK4LOBbch86CvypMEihLVPQOc7WVCJNozzI3AOkFUi6UZJnZ+bLapsn
	ChoTBoX/qeUoMq0bty6V4OXAd0s6Q+WdcjCl2XukT1e48MrVzuPM1jGmFKI1BFHF3Tk4FNQPGPp
	Nf3QEGxj529qrcF6lY=
X-Google-Smtp-Source: AGHT+IFPQMTCbUXEGoNyCs6Sgj4JWecmHBMzlLFFRut2vE4mH8TAAmDpOQ+7bsQ0M3GoHloxaGBllF8iFenr6u3msSw=
X-Received: by 2002:a05:690c:6f08:b0:71a:3437:af45 with SMTP id
 00721157ae682-71a3437b484mr9121217b3.25.1753725607990; Mon, 28 Jul 2025
 11:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717164842.1848817-1-ameryhung@gmail.com> <20250717164842.1848817-4-ameryhung@gmail.com>
In-Reply-To: <20250717164842.1848817-4-ameryhung@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 28 Jul 2025 13:59:56 -0400
X-Gm-Features: Ac12FXyQuNO7tHXoWijJr4Od2sdtWGv39lNKiLZRs78lxqDqNW1mw0ex6fe6PrI
Message-ID: <CABFh=a75g_EUwEq_3PA+K4O6CPR9HnCq28xU7XY=-VcBknB5DA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: Test concurrent task local
 data key creation
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 12:49=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
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
> index fde4a030ab42..1d3ccb98b5db 100644
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
> 2.47.1
>
>

