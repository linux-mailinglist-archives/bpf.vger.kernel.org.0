Return-Path: <bpf+bounces-9439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158B7797B3C
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F482815EF
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E813FEE;
	Thu,  7 Sep 2023 18:10:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C85134DD
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80E8C433C8
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694110201;
	bh=S9qHvUmlvrwpkESI1WHnjQjsbJyjVQZrTCoM4+k5ubU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X6x95PMOxTEcAHDkuDNcT5HPEQdbe12axCL5P9ptRuNyHDHi8l7fmMYWhpRNUJLVa
	 itFjT7+QR/9CBb7hoU8wjnpNRNDf/qLHvVu36T0IsKeCV6bmoBwxOTuzfPCNDO9ycp
	 FSNQWbg6wMVRW0e+8aw2AWSZND+iOAqbBnhNMB3l77Ts6kX2GA5MMU38ZVAzRV4hih
	 LmVODFGb2gmKEpkIW2lT1bLU1hBmj0mHWZd9kICYfbqe8Vt9q06naz8CPIB9l7Dh9Q
	 M0qw7tuVAp2+nQq1NCkS+O1TTmv+xP1yJsQ2RFfbHNnxcQ82gAttNOiADOebCFJ1Av
	 1F77JVB5T70VQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-500b66f8b27so2138639e87.3
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 11:10:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YwlpiIzu8ID5dwCuFlfa8Kz7+OKLZDH9xvri9Sz2N6kPze08A+o
	lWV3p5gD0LWq+QkEp6WRXERDxRla2PC5nLeeqaQ=
X-Google-Smtp-Source: AGHT+IG24o4fwWgd9N1669+uuUaw68igk1kz1M0586xUkgqrtC5AF+lGol17Kn5TB9Fm9yTrUujM/WDugjiJxAzjQcA=
X-Received: by 2002:a19:8c01:0:b0:500:c3d1:4d60 with SMTP id
 o1-20020a198c01000000b00500c3d14d60mr139313lfd.24.1694110199775; Thu, 07 Sep
 2023 11:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-2-jolsa@kernel.org>
In-Reply-To: <20230907071311.254313-2-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 7 Sep 2023 11:09:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4eAYsHzu7DFzK1=X-NBCN9c-XZRfLfPKQ4vB4a4G=L7g@mail.gmail.com>
Message-ID: <CAPhsuW4eAYsHzu7DFzK1=X-NBCN9c-XZRfLfPKQ4vB4a4G=L7g@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/9] bpf: Count stats for kprobe_multi programs
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 7, 2023 at 12:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
nit: The subject doesn't state "missed stats".
>
> Adding support to gather missed stats for kprobe_multi
> programs due to bpf_prog_active protection.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Other than that

Reviewed-and-tested-by: Song Liu <song@kernel.org>

> ---
>  kernel/trace/bpf_trace.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a7264b2c17ad..279a3d370812 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2710,6 +2710,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_=
link *link,
>         int err;
>
>         if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1)) {
> +               bpf_prog_inc_misses_counter(link->link.prog);
>                 err =3D 0;
>                 goto out;
>         }
> --
> 2.41.0
>
>

