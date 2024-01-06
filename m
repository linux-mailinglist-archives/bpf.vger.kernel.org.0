Return-Path: <bpf+bounces-19164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD4825EF6
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 09:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BA21F2388F
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F763A8;
	Sat,  6 Jan 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZimhIGQm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4C63DB
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 08:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF14C433CB
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 08:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704531078;
	bh=Nc5jWr/5nwFKIKve0HuxdZZCtUJGzusKWK+jUL3p3i4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZimhIGQmyBE8bZWv9tASaOfTjPNuFUdO1FyHmbLz+QwZt5Fpo1qnotlw8BGbiWrcx
	 hXpWnMVK2G6ITyqxm6TNvTL5U5D61nTNycOEdcR40TSilkDTHy1E58wyhOtLshexXb
	 jn7j8uFCrofN0DJ1VEeZtuhDJgRybwLEdp6HF5CFuS4YyKssqTGZWo6QdBXaqZA5Vw
	 foz4xRl4IC/arsFlVUJLT8sFCaVLjRISDbniDKr0Q4Rh0n5dyn24LRNSgEoeZLoj5l
	 fvM1havSSkUURlWZmNxu8nJzW3+T7Oajovv1T0h7EUk3QirsAb4z8sXUmd3z3h7ILr
	 FTHKt4j/E9rnA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso308586e87.1
        for <bpf@vger.kernel.org>; Sat, 06 Jan 2024 00:51:18 -0800 (PST)
X-Gm-Message-State: AOJu0YzScvN4qmMd4Ct2v0ofv4260of7vQD4VJpx0q3617KevJPTYcnF
	3Fnc6OhLV+8q2Itf7JzWg6GQIB/RRyHQ43DtRMo=
X-Google-Smtp-Source: AGHT+IFca1tPKYFDF6HFrLBQA/9Kx4S7KVyCuBXGxMZC4q1bJ+7slq/LTySr/9yVwDIrI3GjWZmDgEtUWJHXlk3R/Qo=
X-Received: by 2002:a19:f607:0:b0:50e:7041:e6d with SMTP id
 x7-20020a19f607000000b0050e70410e6dmr127134lfe.45.1704531076350; Sat, 06 Jan
 2024 00:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105104819.3916743-1-houtao@huaweicloud.com>
 <CAPhsuW6EFyr-CrsOfsJBgCJzygV7-v52aKvLJgTBzMdoVm8pSw@mail.gmail.com> <95ea0a85-2c3b-33da-d5f0-27089171ce2d@huaweicloud.com>
In-Reply-To: <95ea0a85-2c3b-33da-d5f0-27089171ce2d@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Sat, 6 Jan 2024 00:51:04 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5QH1BxaE5CMesf=d8ncdmzX3ie6YfDBhhNdNWe1nASQg@mail.gmail.com>
Message-ID: <CAPhsuW5QH1BxaE5CMesf=d8ncdmzX3ie6YfDBhhNdNWe1nASQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf: inline bpf_kptr_xchg()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 6:34=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
>
>
> On 1/6/2024 6:53 AM, Song Liu wrote:
> > On Fri, Jan 5, 2024 at 2:47=E2=80=AFAM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Hi,
> >>
> >> The motivation of inlining bpf_kptr_xchg() comes from the performance
> >> profiling of bpf memory allocator benchmark [1]. The benchmark uses
> >> bpf_kptr_xchg() to stash the allocated objects and to pop the stashed
> >> objects for free. After inling bpf_kptr_xchg(), the performance for
> >> object free on 8-CPUs VM increases about 2%~10%. However the performan=
ce
> >> gain comes with costs: both the kasan and kcsan checks on the pointer
> >> will be unavailable. Initially the inline is implemented in do_jit() f=
or
> >> x86-64 directly, but I think it will more portable to implement the
> >> inline in verifier.
> > How much work would it take to enable this on other major architectures=
?
> > AFAICT, most jit compilers already handle BPF_XCHG, so it should be
> > relatively simple?
>
> Yes. I think enabling this inline will be relatively simple. As said in
> patch #1, the inline depends on two conditions:
> 1) atomic_xchg() support on pointer-sized word.
> 2)  the implementation of xchg is the same as atomic_xchg() on
> pointer-sized words.
> For condition 1), I think most major architecture JIT backends have
> support it. So the following work is to check the implementation of xchg
> and atomic_xchg(), to enable the inline and to do more test.

Thanks for the clarification.

> I will try to enable the inline on arm64 first. And will x86-64 + arm64
> be enough for the definition of "major architectures" ? Or Should it
> include riscv, s380, powerpc as well ?

x86_64 + arm64 is "major" enough. :) Maintainers of other JIT engines
can help with other archs.

Thanks,
Song

