Return-Path: <bpf+bounces-18904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182958235DD
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AB9287546
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860B1CF94;
	Wed,  3 Jan 2024 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5Qah4xI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27981CF8C
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D93FC433C8
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704311286;
	bh=4aRYBGVm36a285Igd90yLlVqhFNcqers/lJiGyXExU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J5Qah4xIwl5bc3qwMmlpgDe2u8CZHyEp2PpW/zZKN0mIde3D0+4iZ83oM0RXp1Xlh
	 7Nv5Oe1aRqaraTFcEvbG1mmH5ZlcEtx7sjzUHk9/ZmCOU77gRmFV/v5btM/c/mlqQl
	 RVzkQ5nAMIe8KVI10YybvBcMG2SDbznP7uhvOZtNKm8LjcN3Gnsa3f/HYiANgfwQxI
	 KRa45X13fbyFc7BteWPaOwXaDHTi02lIFsexXGmBU7mv9/V8qAnmm8HvxC4ZMO27iN
	 wpTmMNh34f1U3Nu4mt47bbJj1efG2UwWreEWPtbALpc84JJqp6P9E0j0DeiOY9ZgJp
	 rgYdArVPXyvdQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso502243e87.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 11:48:06 -0800 (PST)
X-Gm-Message-State: AOJu0YyUq60m8szXc5YVHdhxfF/4Ml5Pc+T/oBp5i2KkE+AmUIKVl3kV
	+38xHjTwKnnNmHliSY40j4YlCMQDfRasFd8h3sw=
X-Google-Smtp-Source: AGHT+IHyU0zn80AVqiNjymdcF/0PKdV7m2BzR8MK7RvXXiDEap+xAewUJldWs7a/W9JSandYUs9kNNdMPiAnTuQClck=
X-Received: by 2002:a19:8c4e:0:b0:50e:34e3:abab with SMTP id
 i14-20020a198c4e000000b0050e34e3ababmr7521955lfj.18.1704311284731; Wed, 03
 Jan 2024 11:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103190559.14750-1-9erthalion6@gmail.com> <20240103190559.14750-5-9erthalion6@gmail.com>
In-Reply-To: <20240103190559.14750-5-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 3 Jan 2024 11:47:53 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5EZxnoEGwt8o-B2JyRHz=wRzTNN6N_swRqBuXFkod2vQ@mail.gmail.com>
Message-ID: <CAPhsuW5EZxnoEGwt8o-B2JyRHz=wRzTNN6N_swRqBuXFkod2vQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 4/4] selftests/bpf: Test re-attachment fix
 for bpf_tracing_prog_attach
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:06=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.c=
om> wrote:
>
[...]
> diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c =
b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> index 6e0b5c716f8e..51af8426da3a 100644
> --- a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> +++ b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> @@ -15,3 +15,13 @@ int BPF_PROG(test1, int a)
>  {
>         return 0;
>  }
> +
> +/*
> + * Dummy bpf prog for testing attach_btf presence when attaching an fent=
ry
> + * program.
> + */

Comment style.

> +SEC("raw_tp/sys_enter")
> +int BPF_PROG(fentry_target, struct pt_regs *regs, long id)
> +{
> +       return 0;
> +}
> --
> 2.41.0
>
>

