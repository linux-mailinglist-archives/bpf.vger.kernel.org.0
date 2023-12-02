Return-Path: <bpf+bounces-16478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D46801854
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 01:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D2E1B210FB
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 00:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39731F5F3;
	Sat,  2 Dec 2023 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG206pCj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369C7156DD
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 00:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096A1C433C8
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 00:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701475284;
	bh=PSzBP7MLc9Q49fpl0J02arECcyNgazsehz6aXXsXgj4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WG206pCj5f+HIYeBTtwI199VUb+mpJd7rPr1S+30TktcCatjoM8JtUE2PN6zA+uhq
	 WO0h0EAtYijywhzMVV4VLv0M4VpgxFHvYAWI21c6YnnrJqPa+SzGyj/K8ETgOlHVOg
	 oH1iJLzDWBojLETS4CNKYPmYNWwcCp1mduyZ+s8ktdGrNa+ktyldTo9qSkCf/wPB0s
	 CX74LujYIDU72+STaZYgU398zplHU30TaDqO7z+zvfNKbmjDo3eXSIB51bSPbT9cl2
	 xHKAkPrZxcjF55YHlM4pNw4emseet8GHqeBpaprGeKw9u3DGIj0iY97pyqP6b2Eu0P
	 qA/ylzsmmWSxw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50bc8a9503fso3776116e87.3
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 16:01:23 -0800 (PST)
X-Gm-Message-State: AOJu0YxCz4ExUX1Hh6orqIRVeGnwQ/u3fF38AYa6XijvohhNEFyu8cAG
	Q2Tvawqg1dlX0YKMVXOX1XNaI6GKwbom+wKqvh0=
X-Google-Smtp-Source: AGHT+IGwLJPTjIJK3ARqdOiAI7G3+BSPLENGsRSitJle0Fs6/v0gj2PGsaKsOZ0mYgqZlJ+fKEQmb/SNK5NhxY2ptZE=
X-Received: by 2002:a19:a408:0:b0:50b:d764:8817 with SMTP id
 q8-20020a19a408000000b0050bd7648817mr1172033lfc.99.1701475282149; Fri, 01 Dec
 2023 16:01:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201154734.8545-1-9erthalion6@gmail.com>
In-Reply-To: <20231201154734.8545-1-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 1 Dec 2023 16:01:10 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7_DQ5ttrT9AmcXO2__MN+Tman-mgbrJ=TG11r0SfPH-w@mail.gmail.com>
Message-ID: <CAPhsuW7_DQ5ttrT9AmcXO2__MN+Tman-mgbrJ=TG11r0SfPH-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/4] Relax tracing prog recursive attach rules
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 7:51=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.co=
m> wrote:
>
> Currently, it's not allowed to attach an fentry/fexit prog to another
> fentry/fexit. At the same time it's not uncommon to see a tracing
> program with lots of logic in use, and the attachment limitation
> prevents usage of fentry/fexit for performance analysis (e.g. with
> "bpftool prog profile" command) in this case. An example could be
> falcosecurity libs project that uses tp_btf tracing programs for
> offloading certain part of logic into tail-called programs, but the
> use-case is still generic enough -- a tracing program could be
> complicated and heavy enough to warrant its profiling, yet frustratingly
> it's not possible to do so use best tooling for that.
>
> Following the corresponding discussion [1], the reason for that is to
> avoid tracing progs call cycles without introducing more complex
> solutions. But currently it seems impossible to load and attach tracing
> programs in a way that will form such a cycle. Replace "no same type"
> requirement with verification that no more than one level of attachment
> nesting is allowed. In this way only one fentry/fexit program could be
> attached to another fentry/fexit to cover profiling use case, and still
> no cycle could be formed.
>
> The series contains a test for recursive attachment, as well as a fix +
> test for an issue in re-attachment branch of bpf_tracing_prog_attach.
> When preparing the test for the main change set, I've stumbled upon the
> possibility to construct a sequence of events when attach_btf would be
> NULL while computing a trampoline key. It doesn't look like this issue
> is triggered by the main change, because the reproduces doesn't actually
> need to have an fentry attachment chain.

It appears this set breaks test_progs/trace_ext:

https://github.com/kernel-patches/bpf/actions/runs/7062243664/job/192258274=
50

Thanks,
Song

>
> [1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org=
/
>
> Dmitrii Dolgov (3):
>   bpf: Relax tracing prog recursive attach rules
>   selftests/bpf: Add test for recursive attachment of tracing progs
>   selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach
>
> Jiri Olsa (1):
>   bpf: Fix re-attachment branch in bpf_tracing_prog_attach
>
>  include/linux/bpf.h                           |   1 +
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/syscall.c                          |  16 +++
>  kernel/bpf/verifier.c                         |  33 ++---
>  tools/include/uapi/linux/bpf.h                |   1 +
>  .../bpf/prog_tests/recursive_attach.c         | 117 ++++++++++++++++++
>  .../selftests/bpf/progs/fentry_recursive.c    |  19 +++
>  .../bpf/progs/fentry_recursive_target.c       |  31 +++++
>  8 files changed, 205 insertions(+), 14 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_atta=
ch.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_ta=
rget.c
>
>
> base-commit: 40d0eb0259ae77ace3e81d7454d1068c38bc95c2
> --
> 2.41.0
>

