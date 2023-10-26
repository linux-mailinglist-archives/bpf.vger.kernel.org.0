Return-Path: <bpf+bounces-13337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB477D86BE
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D483128207C
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7B0381CE;
	Thu, 26 Oct 2023 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep3Tco+L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E023241FF
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 16:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF49C433CA
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698337787;
	bh=AZQ9N+sSqnSmrzZFsAG4I5Ci8DRKaQ7c27rN0nFy+6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ep3Tco+LCE6+Ud4w3z/PvGoVqeh2cWitx5eFNkN34P/8fLNq/jO9oYQ+iiX+WbDLX
	 q2U7c0NR0hNVGCYZideiuXLF2NuGLfxCjloYVwAkc+1u2dDm04wiYzI8ZyUxnNYlk9
	 bLwp5re/qun9hYLciDKeDVnsEvRqWCRPLbrdE29o8FqTY0vO8y78JJob1fNlm7b9Ja
	 c+OFT+8jRySttdOzx1im+9BcO3li2X6tI/Tz36XkK3FZjr/3G4OUUL8GUICirmvUQD
	 OWolezYZiQEjmK22OdesgVNk3S6PW1pNmuPZ9uZV2tfePFEYBDTGJ6JsbFDJ2fo14x
	 rIPZgyTqZ98jA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5079f9675c6so1697272e87.2
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:29:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YycN8U2aw86oErqWPv2uAj1b8eTX56vpqLew508k8NhHOQoFHph
	ZS7yuF+XY5uCvBDft6UFU4j+jmJSvF7p4xBJBPk=
X-Google-Smtp-Source: AGHT+IHavvFyteArnCMNglKk0Wdu3KB9/gDGgfq0W4pMrxgZp7FxD+YU84yROLGhv3TRkNY3VCjgJyhB3A7+k/H6gvs=
X-Received: by 2002:a05:6512:159b:b0:508:1aa7:dffa with SMTP id
 bp27-20020a056512159b00b005081aa7dffamr4529589lfb.18.1698337785765; Thu, 26
 Oct 2023 09:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-2-jolsa@kernel.org>
In-Reply-To: <20231025202420.390702-2-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 26 Oct 2023 09:29:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5rF1C4AbUi42R+okVnA-fhvWTXVJSkTSvem0KzTWWSEQ@mail.gmail.com>
Message-ID: <CAPhsuW5rF1C4AbUi42R+okVnA-fhvWTXVJSkTSvem0KzTWWSEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] libbpf: Add st_type argument to
 elf_resolve_syms_offsets function
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
> We need to get offsets for static variables in following changes,
> so making elf_resolve_syms_offsets to take st_type value as argument
> and passing it to elf_sym_iter_new.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

