Return-Path: <bpf+bounces-17733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330F68122E5
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4D71F21A3A
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629B877B48;
	Wed, 13 Dec 2023 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rpo55Der"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0877B21
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 23:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FFAC433C7
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 23:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702510520;
	bh=A/WHOM3BpKAIfNySDEiz8bxzZG4nywqYm21Z8b/gVUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rpo55DersCqtRUK/3E8FaJT4qTc9QDcPfNyotly806Up+1yNv6lONT9NIvMvmRVat
	 VhgRgeqHDoUaJb3pqil3ROQTGiWP6LEuKMpkZe0aUHLA9zYKEwN7n/yXifS6pX+lNg
	 egZpnwbSOqz8tFccpFAu/sfjGkRyPuEMb/Ny2dl1LpgKqwAo974kC47qHktpRGBwA5
	 EKxHagVSGRarGIu1J6bgMVLe7X3WEA2M4K5JLVMKQXYTqtmfqJocScPPt9wbWuDG1o
	 bCjsqmvYjqFX7i1M0Sh8PnpcOvJ1dH0FR/daH2ux8xkd/Yc2TmijmIqd9dvaRni/qo
	 6Bj7ZmeI5CTEA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so91432441fa.0
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:35:20 -0800 (PST)
X-Gm-Message-State: AOJu0YxN/FB5Zpu4OyleMBqr96OeJu+JQPI352tcRTja+Y/nDivxBkQf
	tMadrFObkrRBicrTudcUdU+Rd47ugU51XQKmr04=
X-Google-Smtp-Source: AGHT+IFW0qyRGawoYzXgfOrPyXtlj+bgXpHz/iwpBu2a4QLfs5rNQkJjAWMIrIBQT6sUTNXeR0ofK18VmFEOSLN47IE=
X-Received: by 2002:a05:6512:6c5:b0:50b:fe1f:4d23 with SMTP id
 u5-20020a05651206c500b0050bfe1f4d23mr5223757lff.78.1702510518557; Wed, 13 Dec
 2023 15:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213141234.1210389-1-jolsa@kernel.org>
In-Reply-To: <20231213141234.1210389-1-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 13 Dec 2023 15:35:07 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7zwLi-=TAjNYXBG6EPSNdgsoDqeQyoB-3oubUt0GMmSQ@mail.gmail.com>
Message-ID: <CAPhsuW7zwLi-=TAjNYXBG6EPSNdgsoDqeQyoB-3oubUt0GMmSQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/2] bpf: Fail uprobe multi link with negative offset
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 6:12=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently the __uprobe_register will return 0 (success) when called with
> negative offset. The reason is that the call to register_for_each_vma and
> then build_map_info won't return error for negative offset. They just won=
't
> do anything - no matching vma is found so there's no registered breakpoin=
t
> for the uprobe.
>
> I don't think we can change the behaviour of __uprobe_register and fail
> for negative uprobe offset, because apps might depend on that already.
>
> But I think we can still make the change and check for it on bpf multi
> link syscall level.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 774cf476a892..0dbf8d9b3ace 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3397,6 +3397,11 @@ int bpf_uprobe_multi_link_attach(const union bpf_a=
ttr *attr, struct bpf_prog *pr
>                         goto error_free;
>                 }
>
> +               if (uprobes[i].offset < 0) {
> +                       err =3D -EINVAL;
> +                       goto error_free;
> +               }
> +

nit: We have 3 __get_user() here. How about we move __get_user(offset)
to the first
and check offset immediately after it? This will save us a few
__get_user() in the
error path.

Thanks,
Song

>                 uprobes[i].link =3D link;
>
>                 if (flags & BPF_F_UPROBE_MULTI_RETURN)
> --
> 2.43.0
>
>

