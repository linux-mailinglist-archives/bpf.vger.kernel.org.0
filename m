Return-Path: <bpf+bounces-68134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D81B534F0
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B456C3B962D
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12C1337682;
	Thu, 11 Sep 2025 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2DLzVTt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA7322A3B
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599948; cv=none; b=mVN0q+AVhCVqL7qWrYb/0VlIunHRwLU+H3L4NrG8tA0lRBkJ+38zYLokmYqmMpLcEZf/pKQoGs5gCGAqPmTS2oV7vhJhmrh4UboXExda3cFONx3UumNiIxnmJK8wfSLUYvdU/zBdziMDvtLVNhJO2LJTm16v7XBnRl3kKkVFPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599948; c=relaxed/simple;
	bh=Y6jdpOzTYCPY+xBTrLzlUqZTNrR9e/Ezk0V1BcMmG54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SE/R2iuFCjV6J2msYP741u1WA+Jf2SNimYJb369VQ/RvEYI6xGwIcGer0Xj5dyJ5RQhvlI25SeEC4WzQmyJnhLKk//I7cE2i/ud5HRmm2A+y89yYeGalfedUCgGqfAQDmkzvglUm0xrhRDMrVNEQyCtwfy8twPb7zhE+476z5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2DLzVTt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47052620a6so1272947a12.1
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757599946; x=1758204746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnK+sGVRCQPyhEIEiPx/kXd9FvmqimIMv6VdNI6b4+s=;
        b=h2DLzVTtHG6AZsSa2tWx0sy6KYJL7hWWnVHu7+nASBkbR7n3ux84uyxn9SKtfc7B9q
         HxA24EUWXt3xVUE8/4h3E1trHxmzUmV3MegOzke8QRrgmdDFR0aETLcPJaEnyJGu4+Jy
         x0fBnZUpGOyLWVw+WSspawFaMqESeWPbbeKjHNurWdpyU2vrWMWnAx4itzQWEdkSuDK8
         t3HIQaXcCUwaO9xDUtfzXOw7koMNAcSmx4+VOMveWn/CMooGQAutBevHe99MCraKK7Xx
         hcF/QIAkc9FIyH6Ec8S93/gWeTA4ul5x1piUNcv2PQ4vZ1MKWW22/mejff6Qcl1rCnHH
         r5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599946; x=1758204746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnK+sGVRCQPyhEIEiPx/kXd9FvmqimIMv6VdNI6b4+s=;
        b=TDR4H1le6c64M+5VExUXmh4y6NXPkBvxOeiQE+oAPmhH5jo9uvLSTt7qE8hr69rQLC
         gGUeFcFP7s7WYN3e3/v01B/NGFLrsSab+qzlCtVY1mnM4iLXGB/t2JrzUDuKUNYwb0z7
         FmtKHnch8HW5VaPETUQQjYbprwyzSXeOOZffogkg5Iq45Jh1j50JSJmPbjwp08/qbSEK
         lmK3NA8LpyCdgMNyOlFSVYo3/mr5iyp9PAcVL/MqnImtWAtM9uHEzEOljflAqBhpXKnN
         hl7dmw87XUtsWzu8eLBd7IXf1F4gJUjEej9gE+u1sQd+LnIMNkulCGF4M930iDm+C43j
         5d/w==
X-Forwarded-Encrypted: i=1; AJvYcCXemmGfXEx9G1R62uvmkfx3EdDvYflrRB6S3yr+7fF4IOEJGGu6EJH0+rM2S8K+afEmPR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyST20tJsmhIej7wq5kg+CNnGsvrm4/ds4UyrxtNBrLZz+0vStY
	22wV9NNJElJM+xZIJS2Y/GPNGWFg+CiiSDuS/77stZLJorFgIDO32ksz8kZQjTyaEbfBRyM1t5O
	CG+wh7Po+10ZCcrOosgGCDj5qEFZOLH4LMg==
X-Gm-Gg: ASbGncvIxG9UHGNi6Ut2wrMoT3ZRmuJBarQC2EvsFNuuaO9VPdpLG3Gcbnv8rpGgD3/
	xWx5Zji+JvbtZ93qdmMthDIqqARpdwwCYmA2O/yuTf6MMLnl/UslG4QJHZewaXpJGJO5Vr1jkzL
	5MsKnG+ib8xpsMMWt+86NTfNQ/ntmbllA1SqncA0K5nJbF5dGLtqW5PTYSCjYnXZPMzGT2H36T0
	mbWS897X+tCM83XuayYadk=
X-Google-Smtp-Source: AGHT+IFEHseIAslA+Avkdg5ri/n63NV/dQd7iX76fBjb+YcYmMVupLnNfutw0uRPIR8rk2z6YjPlzz4mSONWWuXqQo8=
X-Received: by 2002:a17:90b:2884:b0:327:8813:c37e with SMTP id
 98e67ed59e1d1-32dd1d4d05emr3655281a91.5.1757599946016; Thu, 11 Sep 2025
 07:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911073300.463685-1-alan.maguire@oracle.com>
In-Reply-To: <20250911073300.463685-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 11 Sep 2025 10:12:11 -0400
X-Gm-Features: Ac12FXz-edxHSM1oEX9ixCbLuhrdiYS_dWPFY4BeEzaAnJH3Emjj-oH5-G9hpyw
Message-ID: <CAEf4BzZ6+BgDQANDjU2BEwOj6oGf+GuvCN+3UmD7BYRh96K31A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: more open-coded gettid syscall cleanup
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, brauner@kernel.org, 
	bboscaccy@linux.microsoft.com, ameryhung@gmail.com, emil@etsalapatis.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 3:33=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> commit 0e2fb011a0ba ("selftests/bpf: Clean up open-coded gettid syscall i=
nvocations")
>
> addressed the issue that older libc may not have a gettid()
> function call wrapper for the associated syscall.  A few more
> instances have crept into tests, use sys_gettid() instead.

we can poison gettid() to avoid this in the future?

>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/testing/selftests/bpf/network_helpers.c                 | 2 +-
>  tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c         | 2 +-
>  tools/testing/selftests/bpf/prog_tests/kernel_flag.c          | 2 +-
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h      | 2 +-
>  tools/testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
> index 72b5c174ab3b..cdf7b6641444 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -457,7 +457,7 @@ int append_tid(char *str, size_t sz)
>         if (end + 8 > sz)
>                 return -1;
>
> -       sprintf(&str[end], "%07d", gettid());
> +       sprintf(&str[end], "%07ld", sys_gettid());
>         str[end + 7] =3D '\0';
>
>         return 0;
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c b/tool=
s/testing/selftests/bpf/prog_tests/cgroup_xattr.c
> index e0dd966e4a3e..5ad904e9d15d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
> @@ -44,7 +44,7 @@ static void test_read_cgroup_xattr(void)
>         if (!ASSERT_OK_PTR(skel, "read_cgroupfs_xattr__open_and_load"))
>                 goto out;
>
> -       skel->bss->target_pid =3D gettid();
> +       skel->bss->target_pid =3D sys_gettid();
>
>         if (!ASSERT_OK(read_cgroupfs_xattr__attach(skel), "read_cgroupfs_=
xattr__attach"))
>                 goto out;
> diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/tools=
/testing/selftests/bpf/prog_tests/kernel_flag.c
> index a133354ac9bc..97b00c7efe94 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
> @@ -16,7 +16,7 @@ void test_kernel_flag(void)
>         if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel"))
>                 return;
>
> -       lsm_skel->bss->monitored_tid =3D gettid();
> +       lsm_skel->bss->monitored_tid =3D sys_gettid();
>
>         ret =3D test_kernel_flag__attach(lsm_skel);
>         if (!ASSERT_OK(ret, "test_kernel_flag__attach"))
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
> index a408d10c3688..2de38776a2d4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -158,7 +158,7 @@ static int __tld_init_data_p(int map_fd)
>         void *data_alloc =3D NULL;
>         int err, tid_fd =3D -1;
>
> -       tid_fd =3D syscall(SYS_pidfd_open, gettid(), O_EXCL);
> +       tid_fd =3D syscall(SYS_pidfd_open, sys_gettid(), O_EXCL);
>         if (tid_fd < 0) {
>                 err =3D -errno;
>                 goto out;
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.=
c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> index 3b5cd2cd89c7..9fd6306b455c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> @@ -63,7 +63,7 @@ void *test_task_local_data_basic_thread(void *arg)
>         if (!ASSERT_OK_PTR(value2, "tld_get_data"))
>                 goto out;
>
> -       tid =3D gettid();
> +       tid =3D sys_gettid();
>
>         *value0 =3D tid + 0;
>         *value1 =3D tid + 1;
> --
> 2.31.1
>

