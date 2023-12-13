Return-Path: <bpf+bounces-17738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 225D2812377
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27461F21A71
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C925279E0E;
	Wed, 13 Dec 2023 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiA71I0X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5649519A8
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:43:19 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1ef2f5ed01so940994166b.0
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 15:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702510998; x=1703115798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPKll7MG6Jh3baYcNuvlWJ+6JrVCgIVJYLwebGLngEc=;
        b=NiA71I0XcQ5cs42Ke5XmiZVGsfI2TASgSpFKPD4rS1uadl0CfNrbmmNSxe7Z+CGfWv
         ZakpnMZDc1PCl59KMmLYf1r8sGdbbN/69na0rRdKhGrYbqJew7F4CWe81Y7BkXQIjgR8
         HryCXmyoYZH3TjUYEhE5nujdBej+9HkoUF0F9sr2FV4BxBPsD5GPovdu08TawI+ppTd2
         YZ//K+Wn+kO90IS+u1gSxw9X2NU1j/NMnP1E2t7ENvcgAYunUGjhl5SX9LzJhHQNuK0o
         STkl/AusU/yaW1bLJgjbiyGPTDuMKJ7FDkfK2X+Dxt/B7Z5gtnHJVjK+hpQHkaPnPuez
         Hrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510998; x=1703115798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPKll7MG6Jh3baYcNuvlWJ+6JrVCgIVJYLwebGLngEc=;
        b=VG+e8n/dbfh1oQddDIPFDFiGnQOOJLLCYf+w1Y07ZSuixd7MLeLfC/OGsYsjJTrubG
         b8xvKxuOWVgCh8MOySccPIAtPrPoggCl1gKpAKjL25MenPzjZYQa7kxTxJrdFRy+4lU1
         3IEp3kHSai8XcNASju5dtxCSDFtZExdrvZrTb8Ik4KBsMCw2PPo/wxfgyEGRJGjVX8jR
         WH6NrYAkwKnLlz1itgsk2pi0OguKAAcSVS9cLxLrQmhwgMsLHJ2Jb72j+VjnU/gqQHgz
         AWjy2uVR5w+h7tjDe/0j0xpaev2SYa91xZidhVIpdB9B7cwe2IHpoiT4ATWcCUiDKM+0
         km2A==
X-Gm-Message-State: AOJu0YzXcPZB/EFee5kqV3/2VMIYby0u5mSA3T2c3CHVzqkAvMtS/KQT
	7F5W1MkrjI+pCkMFJi46JFX7j8VGNFE8yR4wDJo=
X-Google-Smtp-Source: AGHT+IGcAAxmmHfvu1WqA6WD6OFnCtftuWwsnMU10smABb0Ds6YIwxfteVifm4u1UiqFKseMuSxS49xp9mLHFGjy7xk=
X-Received: by 2002:a17:907:9869:b0:a1b:447d:311c with SMTP id
 ko9-20020a170907986900b00a1b447d311cmr2268495ejc.35.1702510997433; Wed, 13
 Dec 2023 15:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213141234.1210389-1-jolsa@kernel.org>
In-Reply-To: <20231213141234.1210389-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 15:43:04 -0800
Message-ID: <CAEf4BzbfdR+-ZXVvfmbc+Scb9i6SDqDG4C-4RvQE6vq8Pzcqow@mail.gmail.com>
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

offset in UAPI is defined as unsigned, so how can it be negative?

> +                       err =3D -EINVAL;
> +                       goto error_free;
> +               }
> +
>                 uprobes[i].link =3D link;
>
>                 if (flags & BPF_F_UPROBE_MULTI_RETURN)
> --
> 2.43.0
>

