Return-Path: <bpf+bounces-19288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5F829015
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 23:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F99D1C2492A
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 22:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FEB3E469;
	Tue,  9 Jan 2024 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUiVXn8j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70FC3DB90
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 22:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75318C433F1
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704840795;
	bh=Bzwsk50gsK38THRAR86kQ68A+Y6GFz5F6SUqJdA5OY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mUiVXn8juaEVl5UbYHjQ3hnm84NZ+FPaVgvURj97FUb5MbS7fGCIPUTDyW7Z5Q9G4
	 l1EBD6Bg2vysPrXS9aFRL9UeElp48kbfnlGpSKeJHZpw5FKMAziS1Pwd2MO7vXUdZr
	 bK/XTb5vftaBGYW3/JH07kr6763zxiF5YH/jG2fHj0U0iDwRkNHKBxITY4NyCLedhj
	 Bt1Zjltuwx8bpu3ZCoLy/fxPMRP9Hs0JahJsddfWd3THHSN3QG8yCGXQPjRV4YvpRu
	 j9kiMNizfD6QxnN/jVYpRcXKuCduw825JPDxrdsgJDXSTRq5QnMBHjn40/Pr1oJ0aK
	 cRZFEMrg/2Yeg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50ec948ad31so1956120e87.2
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 14:53:15 -0800 (PST)
X-Gm-Message-State: AOJu0YzHgZ6I3qIMyzy3g8e9Rzvzb50r+Nt3j+qBa0L+SyJfJvVN5QhN
	ncDYovFXP5CZ5Q8dR+sGJkNehIb18kEUTKV4TLo=
X-Google-Smtp-Source: AGHT+IFc5ocObSSaSrj42vIhiqHjLLcUAw6766f+6I3sNLI8Ih1g9kRtow8q4d/MgyHdungp/evihC8ERmD35a4Tk20=
X-Received: by 2002:a05:6512:401a:b0:50e:76e0:a51f with SMTP id
 br26-20020a056512401a00b0050e76e0a51fmr25552lfb.100.1704840793707; Tue, 09
 Jan 2024 14:53:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104223932.1971645-1-andrii@kernel.org>
In-Reply-To: <20240104223932.1971645-1-andrii@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 9 Jan 2024 14:53:02 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4SSAnFz+iJhbr2D+eJ=xBCGWoSNYCJ5N0AXGRN43Xe+A@mail.gmail.com>
Message-ID: <CAPhsuW4SSAnFz+iJhbr2D+eJ=xBCGWoSNYCJ5N0AXGRN43Xe+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: detect testing prog flags support
To: andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 2:39=E2=80=AFPM <andrii@kernel.org> wrote:
>
> From: Andrii Nakryiko <andrii@kernel.org>
>
> Various tests specify extra testing prog_flags when loading BPF
> programs, like BPF_F_TEST_RND_HI32, and more recently also
> BPF_F_TEST_REG_INVARIANTS. While BPF_F_TEST_RND_HI32 is old enough to
> not cause much problem on older kernels, BPF_F_TEST_REG_INVARIANTS is
> very fresh and unconditionally specifying it causes selftests to fail on
> even slightly outdated kernels.
>
> This breaks libbpf CI test against 4.9 and 5.15 kernels, it can break
> some local development (done outside of VM), etc.
>
> To prevent this, and guard against similar problems in the future, do
> runtime detection of supported "testing flags", and only provide those
> that host kernel recognizes.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <song@kernel.org>

With one nit below.

[...]

> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testin=
g/selftests/bpf/testing_helpers.c
> index d2458c1b1671..e1f797c5c501 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -251,6 +251,34 @@ __u32 link_info_prog_id(const struct bpf_link *link,=
 struct bpf_link_info *info)
>  }
>
>  int extra_prog_load_log_flags =3D 0;
> +static int prog_test_flags =3D -1;

nit: Move prog_test_flags to inside testing_prog_flags() as it is not
used by other
functions.

> +
> +int testing_prog_flags(void)
> +{
> +       static int prog_flags[] =3D { BPF_F_TEST_RND_HI32, BPF_F_TEST_REG=
_INVARIANTS };
> +       static struct bpf_insn insns[] =3D {
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       int insn_cnt =3D ARRAY_SIZE(insns), i, fd, flags =3D 0;
> +       LIBBPF_OPTS(bpf_prog_load_opts, opts);
> +
> +       if (prog_test_flags >=3D 0)
> +               return prog_test_flags;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(prog_flags); i++) {
> +               opts.prog_flags =3D prog_flags[i];
> +               fd =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "flag-t=
est", "GPL",
> +                                  insns, insn_cnt, &opts);
> +               if (fd >=3D 0) {
> +                       flags |=3D prog_flags[i];
> +                       close(fd);
> +               }
> +       }
> +
> +       prog_test_flags =3D flags;
> +       return prog_test_flags;
> +}
[...]

