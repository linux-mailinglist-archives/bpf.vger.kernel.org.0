Return-Path: <bpf+bounces-21090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6CC847BF4
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34801B25F5B
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415083A1A;
	Fri,  2 Feb 2024 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYP16Swe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7583A07
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911397; cv=none; b=EiuFETIHCJbIL8UdjJpR1h4/6sRSX7XZgFS4pMAuGqEBcQBE1wl85RIPcMCJgp+9ABuGT4lasR7b9ad3VDNRRhAaYgsWmbr5Zbf4BcBXBgF4upA0MYwLJWI+Jtk7J1IWzonhqnw2cGRuVVq+rgDOErQSlgQGvdlc4gvwaihTpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911397; c=relaxed/simple;
	bh=YvrZO7TfEMLlUk4mcsxYwOnMjjK03A9o/ORZkFXOSnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1R4cLzUpBvo5/b9aElMgfvRKb1lzP7YZYMyCbgww5DrdjuPw0znC2sRvv8H7IduQh5kN36rUfpx7IKDjtWTUuP8Xb9tbYEk4cJDMvLZXMTNaRO4gPbFcEdnTWBN2PS3iEB+zNMPyeqCPNKyatz/6gjJpJNQwIAD4eT75bd77uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYP16Swe; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8bc1caf00so2348579a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911395; x=1707516195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DAi/i/03jrCWdF+7Ky3atUhIZMEpNGdYulFhhNdUXk=;
        b=XYP16Swe2bhCWvrsAQooTl0JdszBX3VdveNdEzYAwakjvGIRSpEfogrI176O/IKC0r
         BlhxqzXfeZf5G/a/FVbLy099DshPaNUN/iJtYu4aYatXk1rTDfWCBJHBbM9FgfE3JCfq
         Y8lOQdpnubTDxbr/J+RNKjSjJ3TB8gNbF6tCU2WHbdD/k15Chf+d3XQ3oVzhiY4g+shT
         B+JbnXL+qCxsmvur8gGVpAubEp1vTfyhQY7RcvyTUpxakbtjhOvJT7APuaMu5fsFR8BC
         0NJjIoD4AUgaS4mLjg5Bf9gxVns4GoebtKq97ALe1XcsmvQ0wutynSH/TiDgdPbqS3V3
         ppvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911395; x=1707516195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DAi/i/03jrCWdF+7Ky3atUhIZMEpNGdYulFhhNdUXk=;
        b=uHYppCdHok6o+z3wf5+3fUmzX+A7UvgjubSfr6Ssk+3YRr0luwK9UXlWzSUq94geXk
         M83CwIi0TFOmFV4ZUH/TsRzU9Om/6X9B/NGDIaZcjHzKhk3lqOdfmsK21SHk4hYdpAqZ
         9Nmhf+iKSZIWZpAHpP94GErvebqmTM2i4L+JydmW7EaNafRwZ3Ui/m+v0nbV/HFSyRRL
         DI+yDACwf30myaPLZZXs7Zih/Avp7ps3K+uOjhrinaYS6frGpz68MTh9YONnlCqWENSp
         v0/XjbgytLxmFlhsWC4aAk332UeBSKI1dmu3sKm2edqJJWVxdTgH9AxZ3iXmif5E/0fP
         BVlw==
X-Gm-Message-State: AOJu0Yw3qc04W2i9xFanD8/0RHrzDpf7QobpO5JbCAdkstHcCaNFr5q4
	h4YMm3lTk08/DpX+5LT9DHAZeaxgfWMSH7z5UWoNmTnpxi4HFp+1x4sF1X9PTn9246C+QnZyqP+
	AW+1QKyAtiWLGmbzWk6KNzHsycNo=
X-Google-Smtp-Source: AGHT+IGhawRXESGBvei9MystwndxouKsf3qo+tTAbBXq7ZMe2PU1/Jo4kYdQM3khV6Wq/hEcWEj1nKAGu5IvKMnx4vM=
X-Received: by 2002:a05:6a20:1aaa:b0:19c:8963:fa9f with SMTP id
 ci42-20020a056a201aaa00b0019c8963fa9fmr6406932pzb.52.1706911395640; Fri, 02
 Feb 2024 14:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131145454.86990-1-laoar.shao@gmail.com> <20240131145454.86990-4-laoar.shao@gmail.com>
In-Reply-To: <20240131145454.86990-4-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Feb 2024 14:03:02 -0800
Message-ID: <CAEf4BzaHhqHbcrKQi+wcyompknwkFWmRhchVmOzC+orRqj6otQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/4] selftests/bpf: Fix error checking for cpumask_success__load()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, void@manifault.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 6:57=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> We should verify the return value of cpumask_success__load().
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: David Vernet <void@manifault.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>



>  tools/testing/selftests/bpf/prog_tests/cpumask.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/tes=
ting/selftests/bpf/prog_tests/cpumask.c
> index c2e886399e3c..ecf89df78109 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
> @@ -27,7 +27,7 @@ static void verify_success(const char *prog_name)
>         struct bpf_program *prog;
>         struct bpf_link *link =3D NULL;
>         pid_t child_pid;
> -       int status;
> +       int status, err;
>
>         skel =3D cpumask_success__open();
>         if (!ASSERT_OK_PTR(skel, "cpumask_success__open"))
> @@ -36,8 +36,8 @@ static void verify_success(const char *prog_name)
>         skel->bss->pid =3D getpid();
>         skel->bss->nr_cpus =3D libbpf_num_possible_cpus();
>
> -       cpumask_success__load(skel);
> -       if (!ASSERT_OK_PTR(skel, "cpumask_success__load"))
> +       err =3D cpumask_success__load(skel);
> +       if (!ASSERT_OK(err, "cpumask_success__load"))
>                 goto cleanup;
>
>         prog =3D bpf_object__find_program_by_name(skel->obj, prog_name);
> --
> 2.39.1
>

