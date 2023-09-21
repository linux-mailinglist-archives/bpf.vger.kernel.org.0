Return-Path: <bpf+bounces-10508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17B87A9072
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 03:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461C6B207D3
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6415A2;
	Thu, 21 Sep 2023 01:28:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717780F
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 01:28:33 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93333A1
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso40452666b.3
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695259710; x=1695864510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Xhv9A6pLj4afsIshfPJ5itfoc/iyUfML1TrqZPBRxo=;
        b=L50JRdMpMS22SDLugQcUNmrVkKR4UQQHUmAjxt4Qyiy92hzO/csb0bGXA5+i4BRzwp
         89KnjEiSFyeTTrHBV6a27AOEDr+9Bzu7R9fVF+NIAtvJ5jMUxEYEvthGg7JaXRiudP8S
         GDeCnNq0z05t2Yv6nHCzpFSJAG+NngyfcPMA595UmgVRKhaWoafNkwBRPsEItkDuV8Tz
         471Vwq8x5WyUUWa4vv5mrjOAehdSJ/EAKRckmzOHazMy63Yr/5+EZU1FjAYidIGLFJR/
         FliTSV7Oaq0kqbsBpmBU59Xk1E/1NCq449HVwJ1e6QAlcwdYRA3eyksSRglxTaBb7foR
         7ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695259710; x=1695864510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Xhv9A6pLj4afsIshfPJ5itfoc/iyUfML1TrqZPBRxo=;
        b=sghnmp6HK4hXGP/aiOEk3VanrwS7toblot5y20pWiAW0KKWL+0skNxnR1WqIHzw6ES
         W3vA3qGFFRNiIuCo48tjxunQA8y2RQuxT/AR63CUrOdzNr1+yqv3KyKeMP1Y7I+n2wxy
         TW6xucJuPGa/K4FqhnIY5xzgTbf4sriCnSSISu3JxcuJa30o3QrBM3JrHZ9c9qKbW0Iz
         WVJ1r/lnFT255SNPw9Bx6FjzLMUOTTbDALJEAShjpTq32ZeOYL9kj1CkdJwIWfApsswQ
         N3D0Ovh8xddLvXkrr3sLxi3/cIV2tBifQi1yHGv15c+LhS/H4uXENFnoU4GHjOmNhY4I
         KaDg==
X-Gm-Message-State: AOJu0YyKSQSDRj2f8OiR0PDaSysexUFB3kP0360V7P88QLrE3FnC8Bsu
	Fzry92VQjUJbQy483I2hlPVtvW/MdCzKbT1uidk=
X-Google-Smtp-Source: AGHT+IH61eAhSX/w7ozhnf/bQlMefeju8SNmHkXVDwWpKh4pUfI/16452ase3hhQKYhvCU8LoC/353L4nIlJBEOKltw=
X-Received: by 2002:a17:906:220f:b0:9ad:7e21:2ce with SMTP id
 s15-20020a170906220f00b009ad7e2102cemr3547984ejs.1.1695259709869; Wed, 20 Sep
 2023 18:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914231123.193901-1-martin.kelly@crowdstrike.com> <20230914231123.193901-5-martin.kelly@crowdstrike.com>
In-Reply-To: <20230914231123.193901-5-martin.kelly@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Sep 2023 18:28:18 -0700
Message-ID: <CAEf4BzZwFsVMT2JmD5rDnm1D2BrCUvfnjPEikEB14qk2PgiRpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/14] selftests/bpf: add tests for ring_buffer__ring
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 4:12=E2=80=AFPM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> Add tests for the new API ring_buffer__ring.
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>  .../selftests/bpf/prog_tests/ringbuf_multi.c     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/too=
ls/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> index 1455911d9fcb..f0729ffaf030 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> @@ -42,6 +42,8 @@ void test_ringbuf_multi(void)
>  {
>         struct test_ringbuf_multi *skel;
>         struct ring_buffer *ringbuf =3D NULL;
> +       struct ring *ring_old;
> +       struct ring *ring;
>         int err;
>         int page_size =3D getpagesize();
>         int proto_fd =3D -1;
> @@ -84,11 +86,25 @@ void test_ringbuf_multi(void)
>         if (CHECK(!ringbuf, "ringbuf_create", "failed to create ringbuf\n=
"))
>                 goto cleanup;
>
> +       /* verify ring_buffer__ring returns expected results */
> +       ring =3D ring_buffer__ring(ringbuf, 0);
> +       if (CHECK(ring =3D=3D NULL, "ringbuf_ring", "valid index returnin=
g NULL\n"))
> +               goto cleanup;
> +       ring_old =3D ring;
> +       ring =3D ring_buffer__ring(ringbuf, 1);
> +       if (CHECK(ring !=3D NULL, "ringbuf_ring", "invalid index not reje=
cted\n"))
> +               goto cleanup;
> +

we don't use CHECK() for new code, please use ASSERT_OK_PTR() and
ASSERT_ERR_PTR here

>         err =3D ring_buffer__add(ringbuf, bpf_map__fd(skel->maps.ringbuf2=
),
>                               process_sample, (void *)(long)2);
>         if (CHECK(err, "ringbuf_add", "failed to add another ring\n"))
>                 goto cleanup;
>
> +       /* verify adding a new ring didn't invalidate our older pointer *=
/
> +       ring =3D ring_buffer__ring(ringbuf, 0);
> +       if (CHECK(ring !=3D ring_old, "ringbuf_ring", "old ring invalidat=
ed\n"))

and ASSERT_EQ() here


> +               goto cleanup;
> +
>         err =3D test_ringbuf_multi__attach(skel);
>         if (CHECK(err, "skel_attach", "skeleton attachment failed: %d\n",=
 err))
>                 goto cleanup;
> --
> 2.34.1
>

