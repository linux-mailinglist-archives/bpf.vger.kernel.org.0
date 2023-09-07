Return-Path: <bpf+bounces-9441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A17797B61
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAEC28178F
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACCE13FFC;
	Thu,  7 Sep 2023 18:15:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BA134DD
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3814C433C8
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694110527;
	bh=ikVVY0Qmcl8D+Kd5HPtsc8TYmrQ86qfLtp4u0Nbj5fQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XDxKFnwWseqE8VIv3Eoa3lJLx6F/EkSfJaAC0twHHHZDUlsmrB/ZuiKBJNZstvdy/
	 tcHSLpff29XGPM9mj90EJSbmTy0T5Q3j2OZrjx3kMQFlZRlShhlVjpgy9VMMpmvMov
	 0ahVAMEx6F+MxNhNGSeNYr0cGfpXxjM4pjw268Dy5k2RS0sf5kUg2IA/uHtQK54TCb
	 YgQTU+6Tio2AhDQbXV/ZjUd54j4o0aZbA8IFG+w46hehsfEYqfJdv7wJjITpEn6Mq6
	 Gb5lS8183FSmxxadw1jtf7aEGvioRUZ6QBT678tnphl3iUb52elrCVv4YaPVUHyiVl
	 h5smR3SaYAAEQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so20763511fa.3
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 11:15:27 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzk5brNhkk0Cbot/XobXucjX9/+K8zXyCsdIUoRjWSXPK793VxN
	CvOWIBovVuIe0GrSTlXH5xI43iv6ZNQYTrw/DGo=
X-Google-Smtp-Source: AGHT+IGZGeqTvKXFlKsqxuT5fWWIG29pdtUHU7sWxlrzzFIKPRqFm2vTz9aPd1GTfqioUBjnQwva8MVRfDjhaEXPrXQ=
X-Received: by 2002:a2e:880d:0:b0:2bc:b557:cee9 with SMTP id
 x13-20020a2e880d000000b002bcb557cee9mr21305ljh.43.1694110525631; Thu, 07 Sep
 2023 11:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-3-jolsa@kernel.org>
In-Reply-To: <20230907071311.254313-3-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 7 Sep 2023 11:15:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4xw6bGeGNHU-ixgFcb8Zd8Tyh3xgNaSmS7xHe6_xVPCA@mail.gmail.com>
Message-ID: <CAPhsuW4xw6bGeGNHU-ixgFcb8Zd8Tyh3xgNaSmS7xHe6_xVPCA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 2/9] bpf: Add missed value to kprobe_multi link info
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 7, 2023 at 12:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add missed value to kprobe_multi link info to hold the stats of missed
> kprobe_multi probe.
>
> The missed counter gets incremented when fprobe fails the recursion
> check or there's no rethook available for return probe. In either
> case the attached bpf program is not executed.
>
> Acked-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-and-tested-by: Song Liu <song@kernel.org>

> ---
>  include/uapi/linux/bpf.h       | 1 +
>  kernel/trace/bpf_trace.c       | 1 +
>  tools/include/uapi/linux/bpf.h | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 73b155e52204..e5216420ec73 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6530,6 +6530,7 @@ struct bpf_link_info {
>                         __aligned_u64 addrs;
>                         __u32 count; /* in/out: kprobe_multi function cou=
nt */
>                         __u32 flags;
> +                       __u64 missed;
>                 } kprobe_multi;
>                 struct {
>                         __u32 type; /* enum bpf_perf_event_type */
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 279a3d370812..aec52938c703 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2614,6 +2614,7 @@ static int bpf_kprobe_multi_link_fill_link_info(con=
st struct bpf_link *link,
>         kmulti_link =3D container_of(link, struct bpf_kprobe_multi_link, =
link);
>         info->kprobe_multi.count =3D kmulti_link->cnt;
>         info->kprobe_multi.flags =3D kmulti_link->flags;
> +       info->kprobe_multi.missed =3D kmulti_link->fp.nmissed;
>
>         if (!uaddrs)
>                 return 0;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 73b155e52204..e5216420ec73 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6530,6 +6530,7 @@ struct bpf_link_info {
>                         __aligned_u64 addrs;
>                         __u32 count; /* in/out: kprobe_multi function cou=
nt */
>                         __u32 flags;
> +                       __u64 missed;
>                 } kprobe_multi;
>                 struct {
>                         __u32 type; /* enum bpf_perf_event_type */
> --
> 2.41.0
>
>

