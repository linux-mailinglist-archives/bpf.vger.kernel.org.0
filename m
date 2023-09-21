Return-Path: <bpf+bounces-10584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1136E7A9C06
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7DD282589
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA018C1D;
	Thu, 21 Sep 2023 18:52:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7FD171D4
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 18:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBA0C433C9
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695322350;
	bh=fFUaRY0xAvpLynDUXSz4L44M+M/nnu5s9QaNTJZOl10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GTbQ/0xGu/C2L83YPSK4T+YojAiJ6TReNnKj4YhOJU8x08DGvMS1X90/xAUVeJb4T
	 hygqsuhYFzQhSSr/L6CMEXCkaPsZy2Ax4N/dBkZEFKE7H234FMWJ/11EgVES4JJImj
	 LOFZjOlYqwcoliZc32fM0oGnKBOO0UMHx0+3vMGhDfCJaXhcw/YH9BziftL9R/+BK/
	 o4Jl2D3mQ8c2jMbBz9mFxzcdIWy0URYDAGc7TyzcC6gQuCSTJOWtyHdfZ2RXCxbGpR
	 1vfPshZ+SLDnetnEJ6/v9y5HR+AExt1VVuGX2H9nBSMOFr9AHq40tFmCb5guw7+g0k
	 y8F1FFI3hGEJw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c00df105f8so22465401fa.2
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 11:52:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YxXgymSrvR8wtCB2nRolIjmr9kfBfGFdUEyeGcgWu4qWMCtiQAE
	mb28Ru/wsOZj98uL2USsZYh89QMtklSyhzNumA8=
X-Google-Smtp-Source: AGHT+IFNJMgoSHDNY/nsauh5wZeVV5whkXzwfTg8lJ5RRxiVsgNkA0bjWHrXud2N/amMcmdzMkqT/EXfee1f7NSFv2w=
X-Received: by 2002:a2e:3a06:0:b0:2bf:ff17:8122 with SMTP id
 h6-20020a2e3a06000000b002bfff178122mr5089591lja.17.1695322349081; Thu, 21 Sep
 2023 11:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920213145.1941596-1-jolsa@kernel.org> <20230920213145.1941596-3-jolsa@kernel.org>
In-Reply-To: <20230920213145.1941596-3-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 21 Sep 2023 11:52:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5fn=zaayBL2R1D+rKkO5AWuPmwp1WydGkKcCD7QO6U2w@mail.gmail.com>
Message-ID: <CAPhsuW5fn=zaayBL2R1D+rKkO5AWuPmwp1WydGkKcCD7QO6U2w@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 2/9] bpf: Add missed value to kprobe_multi link info
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 2:32=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add missed value to kprobe_multi link info to hold the stats of missed
> kprobe_multi probe.
>
> The missed counter gets incremented when fprobe fails the recursion
> check or there's no rethook available for return probe. In either
> case the attached bpf program is not executed.
>
> Acked-by: Hou Tao <houtao1@huawei.com>
> Reviewed-and-tested-by: Song Liu <song@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

This does not make bpf_link_info bigger. So if we use newer user space
on older kernel, the user space cannot tell whether missed =3D=3D 0 or the
kernel doesn't support "missed". Right?

Thanks,
Song

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

