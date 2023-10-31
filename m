Return-Path: <bpf+bounces-13677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3037DC628
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FBD6B20E99
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56525DDBF;
	Tue, 31 Oct 2023 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R41/PFOJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E441D535
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:56:40 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2099ADE
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:56:39 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d0252578aso34685996d6.0
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698731791; x=1699336591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPutwxc2ouh1GHJHavtt+jiBGrJCCfv7E2utFChZlp8=;
        b=R41/PFOJuyb3vgN7+7XY4pEofYeFS8WL99oHZQCNo3bshRym9GMg9HiaNob+Rus40h
         XTWm31ullFudI/vkUsXY2gG19VP5/XHxP2QKz7kL8Q7dotiWHdXq45fASDNo9zJALgvR
         K89QpK5okDEkFPxa95U3Mw/6kSvPfbBw2hFKGvn1JCzDf/d2Z/j3hgRTygle9+jgn5yw
         MAV1kvNQlp/p6+6X3frGk4yWTW8qzAsR+PvaSI5R5NKQLOpVdHAZpXSz/VHgR5FNb/5I
         x4OFSKwHJYERAFNlQm0y0aGjnRb/2g4zkPcOgmm6OM318TN+Tsw+TLMuUySOacIMdayj
         m5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698731791; x=1699336591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPutwxc2ouh1GHJHavtt+jiBGrJCCfv7E2utFChZlp8=;
        b=P3N3r10Q3eBg5yy2lQN+G4Mh1fsRvJCdrC3WAC6+7g79Kia3bBKv1EpD7fR66bUYzD
         u/FqBQGprKLujY6QO31n7CFKX/kv/+0H5WV7+v1bpdAJU8n7clbH0M1sl0jFLSpEkzB5
         UuaUADnT3Rzl6HhIzNlDCvMkMGd8BtcGmjclvcN9JjaXoKMff9yEy2j6GEZfZSUmA4x6
         5XSqJ6sZJFlvHimqUf0PlUX7a9sB8efUEfBj8ODNMAbKPgEnoV9B6i8nqvqgcBqLmKkq
         rmeSmq+QqGhBt3Hso5qiqNWw1tgeNonG98rYpwCmcg0ErxIJYC2CDDh0sj4rSG7Z1n+T
         xq4Q==
X-Gm-Message-State: AOJu0YwGEo9619Nzlb8Vqoyld6NuCWRfs/V8VzKrlEWdFzdX4knzE5M+
	P0hTyQzVXK3Cv3c2hl4eeEoF8Nevy9EpG8zjps4=
X-Google-Smtp-Source: AGHT+IHgrj762m6NlF+yO/I5H2nnSkTkmEMkFyr+LnTVkcrxKDZLPUUwHDKjVqSywLnbeKXBySRMMzY1bNp4kgLX+Ds=
X-Received: by 2002:ad4:5baa:0:b0:66d:6869:5e62 with SMTP id
 10-20020ad45baa000000b0066d68695e62mr11704934qvq.46.1698731791158; Mon, 30
 Oct 2023 22:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030210638.2415306-1-davemarchevsky@fb.com>
In-Reply-To: <20231030210638.2415306-1-davemarchevsky@fb.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 31 Oct 2023 13:55:55 +0800
Message-ID: <CALOAHbAUhae1S1XUHNZAkSuOdvjS-ECSuKNoJRLAwtgp85L+dg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next] bpf: Add __bpf_kfunc_{start,end}_defs macros
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 5:07=E2=80=AFAM Dave Marchevsky <davemarchevsky@fb.=
com> wrote:
>
> BPF kfuncs are meant to be called from BPF programs. Accordingly, most
> kfuncs are not called from anywhere in the kernel, which the
> -Wmissing-prototypes warning is unhappy about. We've peppered
> __diag_ignore_all("-Wmissing-prototypes", ... everywhere kfuncs are
> defined in the codebase to suppress this warning.
>
> This patch adds two macros meant to bound one or many kfunc definitions.
> All existing kfunc definitions which use these __diag calls to suppress
> -Wmissing-prototypes are migrated to use the newly-introduced macros.
> A new __diag_ignore_all - for "-Wmissing-declarations" - is added to the
> __bpf_kfunc_start_defs macro based on feedback from Andrii on an earlier
> version of this patch [0] and another recent mailing list thread [1].
>
> In the future we might need to ignore different warnings or do other
> kfunc-specific things. This change will make it easier to make such
> modifications for all kfunc defs.
>
>   [0]: https://lore.kernel.org/bpf/CAEf4BzaE5dRWtK6RPLnjTW-MW9sx9K3Fn6uwq=
CTChK2Dcb1Xig@mail.gmail.com/
>   [1]: https://lore.kernel.org/bpf/ZT+2qCc%2FaXep0%2FLf@krava/
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Jiri Olsa <olsajiri@gmail.com>
> ---
>
> This patch was submitted earlier as part of task_vma
> iter series: https://lore.kernel.org/bpf/20231013204426.1074286-6-davemar=
chevsky@fb.com/
>
> This separate submission addresses Andrii's comments from
> that thread.
>
>  include/linux/btf.h              |  9 +++++++++
>  kernel/bpf/bpf_iter.c            |  6 ++----
>  kernel/bpf/cpumask.c             |  6 ++----
>  kernel/bpf/helpers.c             |  6 ++----
>  kernel/bpf/map_iter.c            |  6 ++----
>  kernel/bpf/task_iter.c           |  6 ++----
>  kernel/trace/bpf_trace.c         |  6 ++----
>  net/bpf/test_run.c               |  7 +++----
>  net/core/filter.c                | 13 ++++---------
>  net/core/xdp.c                   |  6 ++----
>  net/ipv4/fou_bpf.c               |  6 ++----
>  net/netfilter/nf_conntrack_bpf.c |  6 ++----
>  net/netfilter/nf_nat_bpf.c       |  6 ++----
>  net/xfrm/xfrm_interface_bpf.c    |  6 ++----
>  14 files changed, 38 insertions(+), 57 deletions(-)
>

Thanks for your work.

By using a simple grep for "__diag_ignore_all(\"-Wmissing-prototypes",
it appears that the files net/socket.c,
tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c,
kernel/cgroup/rstat.c and Documentation/bpf/kfuncs.rst are missing. It
seems that we should also update them.

--=20
Regards
Yafang

