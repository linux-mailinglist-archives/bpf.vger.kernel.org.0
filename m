Return-Path: <bpf+bounces-1958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B4724E8E
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 23:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E60E1C20A0B
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 21:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C592A9D8;
	Tue,  6 Jun 2023 21:14:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55780FBED
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 21:14:00 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1FE171D;
	Tue,  6 Jun 2023 14:13:57 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1b084620dso62340831fa.0;
        Tue, 06 Jun 2023 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686086035; x=1688678035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v/+JewlbvMwwMc1ycVR+mwpSgdsrXWL+bpwcE9vDvg=;
        b=DPlbdfIN7e2OWR0sKf1pGmByINVOEu4Es+iyeYoNN4g58s2sjf3yWTEWP2L3j9V6hP
         VWPztbqp8yzz134l1zha3Pq3+ZmAGWqU7uW7CPwflJRbQzHM9Fu2++JeluP1DX+VKjNP
         0K1EkHa+SdSYFhRu/FBNTwTySkfH2igxjTKhNTJ9eJJWylbRiAcnC6oN+drQkXbCg9OI
         gORnfUo1GwpUsAFzj6Giqni/0dT8XtZYCvuX95/vTW9AmXq742fEW+yVFgecE5C5CvWe
         Be1/NNFy4JIj1Xv8HLASR7+J+EDVgpT4wPOgrHzNeAuvUaLa8KPwf9ACOhHsmsEgPUh5
         DksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686086035; x=1688678035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v/+JewlbvMwwMc1ycVR+mwpSgdsrXWL+bpwcE9vDvg=;
        b=ZJmoSwXS+SY3MJ/82obH6O2SETEiA0bNz3aCusBVx9VF/Y7wU3DKipJn6BHmJ6zBi4
         NikkMkaQ48dFgZ96ZVFsbqL0j4kNxb98RGihKJvWA4rsPQ9AJy24T7mGQA4MNanD8wbZ
         ZNgy+Fa0Z2MkS3oLVfhmugJ+srUA88MDavtZULPZZCF0vULH5BuuNr8sLMe/BYS3GlBP
         Oa6zL77194owmfJmbDSVRF6rMNwjv7GyDJvugaBhbpqutc45+lSrXVvpkd4hCbkEVTJt
         UlBrU9s1C1yX8wic7pMRnsd91Vhr+oFpwungTpZuWmwhprg4u2j1vPwG8Jepv4imE2Ej
         0aVw==
X-Gm-Message-State: AC+VfDzDufCk8Y0r/wp5qCFj69oz9PwlpZt0zdV2pogfsn1Pih/zpaKU
	k1BU51DzaQq6JFZk48caRZX/MkXk6m5JrXJmR9U=
X-Google-Smtp-Source: ACHHUZ4RrZ2jDtswLKaCj0fnZki2hZnq2/SjkuulDzrwAzt5AQ0csm9Szqg88Qbd1JMq0WDm3oSIw+qG0oM/7FZ2L8g=
X-Received: by 2002:a2e:9258:0:b0:2ac:dd01:e169 with SMTP id
 v24-20020a2e9258000000b002acdd01e169mr1370999ljg.40.1686086035161; Tue, 06
 Jun 2023 14:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606035310.4026145-1-houtao@huaweicloud.com> <20230606035310.4026145-3-houtao@huaweicloud.com>
In-Reply-To: <20230606035310.4026145-3-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jun 2023 14:13:44 -0700
Message-ID: <CAADnVQJZc6iJiZ+axjXGKMSJa0ims9vYUc4vYQ7bdnOqgz5QfA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v4 2/3] selftests/bpf: Add benchmark for bpf
 memory allocator
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 5, 2023 at 8:20=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> +static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long =
*value)
> +{
> +       char buf[32];
> +       int fd;
> +
> +       fd =3D openat(ctx.fd, name, O_RDONLY);
> +       if (fd < 0) {
> +               fprintf(stderr, "no %s\n", name);
> +               *value =3D 0;
> +               return;
> +       }
> +
> +       buf[sizeof(buf) - 1] =3D 0;
> +       read(fd, buf, sizeof(buf) - 1);

Please BPF CI. It's complaining about:

benchs/bench_htab_mem.c: In function =E2=80=98htab_mem_read_mem_cgrp_file=
=E2=80=99:
benchs/bench_htab_mem.c:290:2: error: ignoring return value of =E2=80=98rea=
d=E2=80=99,
declared with attribute warn_unused_result [-Werror=3Dunused-result]
290 | read(fd, buf, sizeof(buf) - 1);
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


> +       *value =3D strtoull(buf, NULL, 0);
> +
> +       close(fd);
> +}
> +
> +static void htab_mem_measure(struct bench_res *res)
> +{
> +       res->hits =3D atomic_swap(&ctx.skel->bss->loop_cnt, 0);

This is missing:
res->hits /=3D env.producer_cnt;

Doubling the number of producers should double the perf metric.
Like -p 4 should be half the speed of -p 8.
In an ideal situation, of course.
Without this normalization -p 1 vs -p 2 numbers are meaningless.
Runs with different numbers of producers cannot be compared.

