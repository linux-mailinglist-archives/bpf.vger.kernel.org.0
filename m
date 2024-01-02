Return-Path: <bpf+bounces-18805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B7822268
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 21:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7731EB20EB7
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B3D16405;
	Tue,  2 Jan 2024 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jiypd4aD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842A16400
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 20:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D90C433CC
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 20:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704226003;
	bh=+zP7OM9nvuaZHCV3OMoNEUNXW3wazVC+GL4dlcG2/W0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jiypd4aDrS9pGgQwNG7Foa8xB3YeXSLMwPohL+Kwhso2RcgxHwiFL4Hy1cdCa95X/
	 MjTDOBHN5M0SBVfhXTG/SDO4UltSD+ERCUWE9jqaLIjVEFa7E4plyZVc8ots+ghIXA
	 o6SSSN4k4BcpNKqCtNtuxLeFj0cG00xhzae96Yob22MSeNNxhl2Wkz5ZFvQmCfWr4B
	 bXEzLuSq07R9hC9lfn6WjgMI6PtqGAMzqL1vEfJuG8k+ZKc6I2hn/qJiIwyQT8Gqi5
	 2zvvB/g+8SF2egw4zg++5XL3Ius/BDk1eyEqibhrKoKyq8EB3oGH9cSs3oHUQsEUDV
	 47ZJtRwZ01xVw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e835800adso5854165e87.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 12:06:43 -0800 (PST)
X-Gm-Message-State: AOJu0Yw8XFCgKnrwuAp1QQU9jaNUW2BXC+GpJAIVlsluV0f2gunjKWcB
	GcdwSCRumjquKhTgO5h80/GPN6/4CrSIaxgmnLc=
X-Google-Smtp-Source: AGHT+IHN226sazmANADgzhe7ZBxF4Elmi3yabw0fP5lOaZ7O3aHY6mmzLNd9BxSiUlqckX8ru6dtEp+Z4BSTISUMIuI=
X-Received: by 2002:a05:6512:12d2:b0:50e:9a16:fb with SMTP id
 p18-20020a05651212d200b0050e9a1600fbmr1347987lfg.6.1704226001484; Tue, 02 Jan
 2024 12:06:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222151153.31291-1-9erthalion6@gmail.com> <20231222151153.31291-2-9erthalion6@gmail.com>
In-Reply-To: <20231222151153.31291-2-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Jan 2024 12:06:30 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6ST=8tJEMj_vDm6HbXk1Tt6_D9HtaMmCrFrFeC6X2-Jg@mail.gmail.com>
Message-ID: <CAPhsuW6ST=8tJEMj_vDm6HbXk1Tt6_D9HtaMmCrFrFeC6X2-Jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 1/4] bpf: Relax tracing prog recursive attach rules
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:12=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.c=
om> wrote:
>
> Currently, it's not allowed to attach an fentry/fexit prog to another
> one fentry/fexit. At the same time it's not uncommon to see a tracing
> program with lots of logic in use, and the attachment limitation
> prevents usage of fentry/fexit for performance analysis (e.g. with
> "bpftool prog profile" command) in this case. An example could be
> falcosecurity libs project that uses tp_btf tracing programs.
>
> Following the corresponding discussion [1], the reason for that is to
> avoid tracing progs call cycles without introducing more complex
> solutions. But currently it seems impossible to load and attach tracing
> programs in a way that will form such a cycle. The limitation is coming
> from the fact that attach_prog_fd is specified at the prog load (thus
> making it impossible to attach to a program loaded after it in this
> way), as well as tracing progs not implementing link_detach.
>
> Replace "no same type" requirement with verification that no more than
> one level of attachment nesting is allowed. In this way only one
> fentry/fexit program could be attached to another fentry/fexit to cover
> profiling use case, and still no cycle could be formed. To implement,
> add a new field into bpf_prog_aux to track nested attachment for tracing
> programs.
>
> [1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org=
/
>
> Acked-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

Acked-by: Song Liu <song@kernel.org>

