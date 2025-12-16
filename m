Return-Path: <bpf+bounces-76756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49500CC507C
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45C52302B7B6
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AB127CB35;
	Tue, 16 Dec 2025 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOt3qf6q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A622FDEC
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914348; cv=none; b=p4NOKAFQPr5g87iWHchEz6EfAvJr5ggeQW+iBU20HtrSdAqXhAU97Iu5xlp9vzJAAbcEGiAypfH7pkOjcX4V0BNtCe6luJlUqUCFu9wrcm9lpJh14x8HoM3yaZpKZPUyFtIR+P0JO78IaJOZfKoeZWr1YZH4nBGKUtj3L62RWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914348; c=relaxed/simple;
	bh=42A4TIoY7PKMAuZQeM0hYxIsFHJ6coPSBkItaPXkk/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zgx4ZnqOT5pLAuSBMdOF8/gYNmOo1Nm5EYPUtBgToDNiad9hhJXrY0lTT02foqJw8lvTDe2v3fG314Qo7bhbY0tTW9fj8G+jdy0gFmUIpTWf+1MlhuHcg+QrAB39O34Z2DPorlkrcQA4jQbABu6X8qeihBGQZCModLmChXq2qZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOt3qf6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8093BC19425
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765914346;
	bh=42A4TIoY7PKMAuZQeM0hYxIsFHJ6coPSBkItaPXkk/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mOt3qf6qANc2Z0ISk7ROIJ6cgDM9UekzAcIP+S2369Zq0SpnoYN2/cfkkcr1M5Web
	 oJFKlK1aJg28vs7ze8KDjuo4zMYUBXLT6LAvpG7sIQN+wgNpFoAFp2woDr9lB30xCo
	 j5CtxgpZZetXisCmlzmZUaHwmiAdTiMgA1pYviNYr2oxj8Sj/hLVBsaqm7Ws6+JsC1
	 NHUTBg6xUEcX/3qIStLgbw8zZDsGuErF6n+Ckgv7uluFsKK8gW5OC5A5ujM6b6i6oJ
	 YIxyPIj1NDgoHWW+KeIHGhZf6ipcESr0/bTPyXVeA83cYABt51ww8F9V58caiYqFDR
	 wPrXb8/YlQTTw==
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4edb6e678ddso68577361cf.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:45:46 -0800 (PST)
X-Gm-Message-State: AOJu0YxSWafKihHxv7u04yHsLhMqA1FYJ0h9IdDp4U+wxWXwm0um/bio
	BYlbMQQNcy7T/VVzmKJWqn9DYWbHLtnOJMBcvMHH2uwxR4q9qnRzBjctUc5NgOq/WyPN7AeL4S3
	WYtMAWimcqg4btfD4Fj4VUUha8g25iss=
X-Google-Smtp-Source: AGHT+IEPSzqZAhMoK9mZ4eDBk3w+zrYF6HBepOW1VUObPbnMWfKYo88VLpGCjcY7/froK5mcgOR/N/l9PsEsv0Xuqd4=
X-Received: by 2002:a05:622a:65c2:b0:4f1:de1c:dfa8 with SMTP id
 d75a77b69052e-4f1de1ce03dmr141290611cf.19.1765914345609; Tue, 16 Dec 2025
 11:45:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216133000.3690723-1-mattbobrowski@google.com>
In-Reply-To: <20251216133000.3690723-1-mattbobrowski@google.com>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Dec 2025 04:45:34 +0900
X-Gmail-Original-Message-ID: <CAPhsuW7cnX6G+YJf-W=RizoZf75286H9vmgh98VGe=kEhh6NMQ@mail.gmail.com>
X-Gm-Features: AQt7F2raoT3ZIqgS7kyZjeZD-33L7ZnOUyRsSYX1oQQOyZydbcvxdPclhxlmY3o
Message-ID: <CAPhsuW7cnX6G+YJf-W=RizoZf75286H9vmgh98VGe=kEhh6NMQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: annotate file argument as __nullable
 in bpf_lsm_mmap_file
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 5:30=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
[...]
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 232cbc97434d..79cf22860a99 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -42,7 +42,17 @@ endif
>  ifeq ($(CONFIG_BPF_JIT),y)
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_struct_ops.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D cpumask.o
> -obj-${CONFIG_BPF_LSM} +=3D bpf_lsm.o
> +# bpf_lsm_proto.o must precede bpf_lsm.o. The current pahole logic
> +# deduplicates function prototypes within
> +# btf_encoder__add_saved_func() by keeping the first instance seen. We
> +# need the function prototype(s) in bpf_lsm_proto.o to take precedence
> +# over those within bpf_lsm.o. Having bpf_lsm_proto.o precede
> +# bpf_lsm.o ensures its DWARF CU is processed early, forcing the
> +# generated BTF to contain the overrides.
> +#
> +# Notably, this is a temporary workaround whilst the deduplication
> +# semantics within pahole are revisited accordingly.

This is quite tricky, but I can confirm we need bpf_lsm_proto.o first.

Acked-by: Song Liu <song@kernel.org>

> +obj-${CONFIG_BPF_LSM} +=3D bpf_lsm_proto.o bpf_lsm.o
>  endif
>  ifneq ($(CONFIG_CRYPTO),)
>  obj-$(CONFIG_BPF_SYSCALL) +=3D crypto.o
[...]

