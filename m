Return-Path: <bpf+bounces-54865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14C1A74F3B
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68B37A66E4
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE3F1DDC01;
	Fri, 28 Mar 2025 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKqHeQZp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54A1805E;
	Fri, 28 Mar 2025 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183022; cv=none; b=AW9ANWTa0DvlDUbAOozPQ2ovA32bC71b6Fm/bVrP79S8okA4nxBOMFjnMlwjuvm09yyDiYhILZ7ZmZ/5EAMAToHn0DQFY79jZaPrMH4KT3B01JsnvKEthsvPYmWgXSc8H+kifnFr2AEmHQDK4MjEXPoZi6jMx4qWP8s7ZsVhUGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183022; c=relaxed/simple;
	bh=z20pel7C7+0xMyYLJjMDWioYxcZAfnI7PYYWRH2L8cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaztHxbdzUtl1aIpMWLQ7r/hHl/EKgz3xszpJLSI/6F+wZWy5UxWZo29jkCVb31cyLcvwdKOZM9zVNBLeVnEhj9L95B97OD3pXRWeLWIX2UzofWb9Y8fWpXzy6Apq9q2Mo+HZ+u/vGUWd0oxASePvkT2QvqaF+j49O9cuSAw6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKqHeQZp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2241053582dso12920485ad.1;
        Fri, 28 Mar 2025 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743183021; x=1743787821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iNf6SusQ7ycxiE1l6dDv55kSzktCd+VfmpkFTZGtTI=;
        b=mKqHeQZpYIvMTQ6wzmr3pd1OYCGeaJ/Kt7mEcYbvoPvGtRWFWvYNwA0wvfpsX8365v
         pah3gx54Yu/P43sK/J+S28Bk04J2Q7jfgRs5W38vnBMXtSplqA4ohzlh25c/V/4u86VS
         IulWSqNYKs7xgdldKtiXymDKrZtFh62kqz+QMP9M8ba3ViYj4ARCFlaZuMx2Wa9f8Y+9
         781VlhBG6AcxEg0jbcUs+rmTMcc7Dg/uza8oEHKgU8isnL+vgdYw8BX907Ctkd5+ebXM
         UtWN0/HTy5OIlNXPYmxNHhpfatmJg+vNAMcM+oO0yZ8SnLwLI2mmX+c6j8PsAGm+7hoG
         tvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743183021; x=1743787821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iNf6SusQ7ycxiE1l6dDv55kSzktCd+VfmpkFTZGtTI=;
        b=hkqCQc8TW6DivwpmO+yU6+PoCeWQbKTOaVMm0MXiKo9E2MsKizsxSu5jiBvR72Q05j
         mnb4UKw/MuM/qgizeCef8wrjJMwahuAeJp3hst6L0/buDImoayU+nss90YmzZ1vkVorr
         rKMlsu/AHbKmqOhRKF3NMXoZfMA7X5TONmW712CX3hpEqwYwodz7BdTCNfg8/bkYYWTM
         hos48swD0ZO1s4Q5l1hRPYuiyg9mmGT8Dvce84MpPzLuwjL/wpLB9nO9KzQ2RQgOozcq
         euCghiJat9yKKWdbJuwsPHwtmN+EeUu9wtVhDjV2wma2ngSgbe0v8F7el3RcksaNgH7F
         7/EA==
X-Forwarded-Encrypted: i=1; AJvYcCVn7R0PLMouAlyQTtcI/8Moq5HS/OIecT4v/m0UmjyznlQoAGoc67pbHPffPD5oJ5D0hDTbNf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuF/HFjBt6uIfD6DguSCht7FQpVQfmNKYeYRHre23IxN537Sae
	j9asv8B0NcmqZuYgYa257twYJLlJYeKwTYJLcs62ZkXErk5Vy0wU/K6yMgUGpSIm/PdQcyMAbEQ
	mUw9Q1uWX9kQTqheZNFKZQoD7T3w=
X-Gm-Gg: ASbGncusIynk22FXblU0aq8bCoD2A2driBT7r9kjGOdY6iNM9AkYHIAx9tmH3G/NAyI
	y0eJVOk2jbTQRSLYeHFKYt5m7fycuXvd9XANK6oDt9S5/PLAUMINYj05fRsGJX75JNiZ3xf0i3z
	ZnBvZ9zu3sH0g4V3LjDdgkI8Uz6wy9QtqtfQ8CsMJVGg==
X-Google-Smtp-Source: AGHT+IEDZVBHvU0tLRVaRd+IzxEpN2n179mU980NoAxz+pEXenWN4f65L+KdFUKYh6ms+7B/rMZQ6mG5F7trTZc74Zw=
X-Received: by 2002:a05:6a00:3991:b0:736:ab1d:7ed5 with SMTP id
 d2e1a72fcca58-7398000b471mr35597b3a.0.1743183020452; Fri, 28 Mar 2025
 10:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327185528.1740787-1-song@kernel.org>
In-Reply-To: <20250327185528.1740787-1-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Mar 2025 10:30:08 -0700
X-Gm-Features: AQ5f1JpzIGYvlsOUaw5KE5lgafOOExNLnBUhWyBy2lN8rUb_dRN2EuR_5AcNnNg
Message-ID: <CAEf4BzagkTArcqnvqgu7kNq31QFsATM36OGPLs4-GFOo0TDxsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix tests after change in struct file
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kernel-team@meta.com, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 11:55=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> Change in struct file [1] moves f_ref to the 3rd cache line. This makes
> deferencing file pointer as a 8-byte variable invalid, because
> btf_struct_walk() will walk into f_lock, which is 4-byte long.
>
> Fix the selftests to deference the file pointer as a 4-byte variable.
>
> [1] commit e249056c91a2 ("fs: place f_ref to 3rd cache line in struct
>                           file to resolve false sharing")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  tools/testing/selftests/bpf/progs/test_module_attach.c    | 2 +-
>  tools/testing/selftests/bpf/progs/test_subprogs_extable.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/too=
ls/testing/selftests/bpf/progs/test_module_attach.c
> index fb07f5773888..7f3c233943b3 100644
> --- a/tools/testing/selftests/bpf/progs/test_module_attach.c
> +++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
> @@ -117,7 +117,7 @@ int BPF_PROG(handle_fexit_ret, int arg, struct file *=
ret)
>
>         bpf_probe_read_kernel(&buf, 8, ret);
>         bpf_probe_read_kernel(&buf, 8, (char *)ret + 256);
> -       *(volatile long long *)ret;
> +       *(volatile int *)ret;

we already have `*(volatile int *)&ret->f_mode;` below, do we really
need this int casting case?.. Maybe instead of guessing the size of
file's first field, let's just remove `*(volatile long long *)ret;`
altogether?

>         *(volatile int *)&ret->f_mode;
>         return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c b/=
tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> index e2a21fbd4e44..dcac69f5928a 100644
> --- a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> +++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> @@ -21,7 +21,7 @@ static __u64 test_cb(struct bpf_map *map, __u32 *key, _=
_u64 *val, void *data)
>  SEC("fexit/bpf_testmod_return_ptr")
>  int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
>  {
> -       *(volatile long *)ret;
> +       *(volatile int *)ret;
>         *(volatile int *)&ret->f_mode;
>         bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
>         triggered++;
> @@ -31,7 +31,7 @@ int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct=
 file *ret)
>  SEC("fexit/bpf_testmod_return_ptr")
>  int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file *ret)
>  {
> -       *(volatile long *)ret;
> +       *(volatile int *)ret;
>         *(volatile int *)&ret->f_mode;
>         bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
>         triggered++;
> @@ -41,7 +41,7 @@ int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struc=
t file *ret)
>  SEC("fexit/bpf_testmod_return_ptr")
>  int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file *ret)
>  {
> -       *(volatile long *)ret;
> +       *(volatile int *)ret;
>         *(volatile int *)&ret->f_mode;
>         bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
>         triggered++;
> --
> 2.47.1
>

