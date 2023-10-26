Return-Path: <bpf+bounces-13338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C587D86C1
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB33B21251
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9081381D0;
	Thu, 26 Oct 2023 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iat3Jsen"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F9381DB
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 16:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F29C433CC
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 16:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698337874;
	bh=MR6uo36irm2/5W2wXyCS7Z1aqxbyIpZUkw7S7Q9yXy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iat3Jsen/P3WqMU3XVj0CibPwiry9CphKQZHQT4pu+JDFrMXSgbXWG+SaTwcjPa95
	 SnRupkMPbN0Lg/FTlW3C2HdaArBvqeDvODLlVloO6D+e/wR/BE47N7Vny7nFNpRm8U
	 rHpQ21gTndi6i680v5LX88dieWs5tU/qQ2hnRQBfhC9QOBlg8pa/u5G8ew5tEDO7P2
	 ce7lvh8t6b3BAQ+Gh8LLIMCBUaQxf5IHP7ivO9JA0aOocaTUzEbDGUKKNJrm83DCSI
	 Src243RGE+1sfq95IAzUUjn5krBCgus5cDJWq/YtE4L8WKNe+3TfAE9SGiHPRaYzj2
	 USy1P/yA36KDw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-508126afb9bso1553248e87.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:31:14 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8Dz8f+iijPWRkPuG5Lz16ewGy8fxiE7fx7JnO1py8s3RiMWmA
	4+ZKg38JUearN+dtpfqMW27jeJOnpxxxrNQci7A=
X-Google-Smtp-Source: AGHT+IFtbBnE2VMgHuWwJRPp7yHjyoGF8j6gAw0JUX7MhjDUMEEWqig5zLGLxDzXAiopKnq5TCjEhszgBRGcKKnafYU=
X-Received: by 2002:a05:6512:20cd:b0:507:a04e:3207 with SMTP id
 u13-20020a05651220cd00b00507a04e3207mr11954717lfr.6.1698337872878; Thu, 26
 Oct 2023 09:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-3-jolsa@kernel.org>
In-Reply-To: <20231025202420.390702-3-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 26 Oct 2023 09:31:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7oOpsBhc=quoyzNgBFONdv=o67hHnieY1_kPyrZfLsQg@mail.gmail.com>
Message-ID: <CAPhsuW7oOpsBhc=quoyzNgBFONdv=o67hHnieY1_kPyrZfLsQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Store ref_ctr_offsets values in
 bpf_uprobe array
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 1:24=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We will need to return ref_ctr_offsets values through link_info
> interface in following change, so we need to keep them around.
>
> Storing ref_ctr_offsets values directly into bpf_uprobe array.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

with one nitpick below.

> ---
>  kernel/trace/bpf_trace.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index df697c74d519..843b3846d3f8 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3031,6 +3031,7 @@ struct bpf_uprobe_multi_link;
>  struct bpf_uprobe {
>         struct bpf_uprobe_multi_link *link;
>         loff_t offset;
> +       unsigned long ref_ctr_offset;

nit: s/unsigned long/loff_t/ ?

>         u64 cookie;
>         struct uprobe_consumer consumer;
>  };

