Return-Path: <bpf+bounces-18816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A9E8224E9
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A57FB216E1
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 22:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0C217722;
	Tue,  2 Jan 2024 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtPcsLPI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE3171CA
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 22:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7958DC433D9
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704235480;
	bh=AMKMeA8GxjQumrCoIcxN1IwyB+ZvMVozj+FkhX3a2jQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OtPcsLPIYAo7SCRuoUdazjqal4ecZ/eB8onW/LB9OYCArWoNXzcSsD4Dyaid/mO5j
	 f/zNmXl8hx53mN3Hi65Q1/CG+4LmP6DaFFQoUUAC73Lgf6vP19dDSTsQOM0ddabi0V
	 tZFUnDWKRkeRaHrrriQm9WulH7/onLQDUTUagJKOs30i/1e+eCg4by1FAFe5tzc/dh
	 XX6PpFANllDfDCyYzz0xspjvktv5GG3Mx67WKFGUJBi3b4m1Gj379475yBYoIXZNga
	 d//auZTB9br7wUr/iggho/8qPIzteCFhotcJsgBVcJ1tvpAQ9TYrwSUN97lf3pzHkV
	 UpGCY612ZVIUQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cca5e7b390so99723691fa.3
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 14:44:40 -0800 (PST)
X-Gm-Message-State: AOJu0Yyaiiq3avZy0rlC6DVf08hCskLO6wU7Aw3rlZx02aqv+IbQbrGS
	17RZIHz2+zKnrtI7B+XD7ZKqSLlIIfGZ+i5Jffs=
X-Google-Smtp-Source: AGHT+IHbfC8/WMPOOsMO0Bx3LNkDeWHyS6/7J1nz2zEuj+dHPHlZWAbavma9Xs2K0kGW5BXpj4LnEPO+AbxvAdVJBaI=
X-Received: by 2002:a05:6512:4d0:b0:50e:9a0d:d402 with SMTP id
 w16-20020a05651204d000b0050e9a0dd402mr1585725lfq.105.1704235478635; Tue, 02
 Jan 2024 14:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222151153.31291-1-9erthalion6@gmail.com> <20231222151153.31291-5-9erthalion6@gmail.com>
In-Reply-To: <20231222151153.31291-5-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Jan 2024 14:44:27 -0800
X-Gmail-Original-Message-ID: <CAPhsuW47m5+7KyAPd+N=rHXs+Jdz2zV6oUhiWdpztD3yhOvf=A@mail.gmail.com>
Message-ID: <CAPhsuW47m5+7KyAPd+N=rHXs+Jdz2zV6oUhiWdpztD3yhOvf=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 4/4] selftests/bpf: Test re-attachment fix
 for bpf_tracing_prog_attach
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:12=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.c=
om> wrote:
>
> Add a test case to verify the fix for "prog->aux->dst_trampoline and
> tgt_prog is NULL" branch in bpf_tracing_prog_attach. The sequence of
> events:
>
> 1. load rawtp program
> 2. load fentry program with rawtp as target_fd
> 3. create tracing link for fentry program with target_fd =3D 0
> 4. repeat 3
>
> Acked-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> Changes in v8:
>     - Cleanup, remove link opts and if condition around assert for the
>       expected error, unneeded parts of the test bpf prog and some
>       indendation improvements.
>
>  .../bpf/prog_tests/recursive_attach.c         | 45 +++++++++++++++++++
>  .../bpf/progs/fentry_recursive_target.c       | 10 +++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/=
tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> index e9e576de6723..124c57e27387 100644
> --- a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> @@ -109,3 +109,48 @@ void test_recursive_fentry(void)
>         if (test__start_subtest("detach"))
>                 test_recursive_fentry_chain(true, true);
>  }
> +
> +/*
> + * Test that a tracing prog reattachment (when we land in
> + * "prog->aux->dst_trampoline and tgt_prog is NULL" branch in
> + * bpf_tracing_prog_attach) does not lead to a crash due to missing atta=
ch_btf
> + */

Please update the comment style:
/* Test that a tracing prog reattachment (when we land in
 * "prog->aux->dst_trampoline and tgt_prog is NULL" branch in
 * bpf_tracing_prog_attach) does not lead to a crash due to missing attach_=
btf
 */

Also for the other comments below.

Thanks,
Song

