Return-Path: <bpf+bounces-54231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B351A65BD7
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 19:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2159B189EE1C
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9731C07DA;
	Mon, 17 Mar 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maG4Q5Lo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF801A23B5;
	Mon, 17 Mar 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234472; cv=none; b=pi+WdBjTSTovhqjxGe3kTvMePgS5YXfjbKoyQ2pK3DbPurvLVOORTBv9H40F/B62/hSTX0OD2cZaPx1EMqdpr2pSIPb1MtOuWoOHBPF8AW6B/SXXzr+nPi3OOTvgUEYFlYtq7ezc/IuAkeJGyjpBlrhTz4ETiAgZFXbDqWNfT/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234472; c=relaxed/simple;
	bh=D/tQAhGx4a38AohS9mabh3Siz4Q4F54hqSjV5YApjdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smNlKMDLhpiw+Lmb1B2hlvNF24sQMucSTxnAp9TVVkhJT7jO99z08CyftfabLaDRy3e3QGpVPfNvtwaOHI0+il0fADteQuLz4ACrlopgonKa5Tu5hcsUWOdU6Qh8MkzwB5KsAJrdJx1uWirG557oMajV+BDE6zHejx1G2sEz/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maG4Q5Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE4CC4AF09;
	Mon, 17 Mar 2025 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742234472;
	bh=D/tQAhGx4a38AohS9mabh3Siz4Q4F54hqSjV5YApjdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=maG4Q5LoQO4ciimV0I2qmwPvN56NYSlv6zt9t1y9rOqfmt8Ki2LSjoBnsme/AbNS0
	 fycMFP5fFMNkSpQ7iQPKKvQj3DTG9bT6IS/huFAwU0pIPhd7bxQvWKEdf9MmWwC4yT
	 CBBs3uVzCOyNMu43eJr9ktK4jLYcxUDkR/FgmPe0IykcezVfKN9c78kzbb4kSIhwNY
	 s8FnxIbv2kYd9PY2jUW6SZc+hsxPxQG8N3P4xKYjRMUciZzrWNkONutoUR8VEzc8s0
	 QG9HQHnp931kaUCn9U8Qg2RrOQRu8bvc3C0FgwzLiXjSw0EYir6tdoQomWzb3oZCHX
	 44m1xb6ne66WQ==
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85dd470597fso79019739f.2;
        Mon, 17 Mar 2025 11:01:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWonuol15wHSJftG1Npe0XgnQS5QVtHAMAsAwLLoWr9soUYzBdyEWuXhqDb2LATCDe5187D+ZG6gpryl21Q@vger.kernel.org, AJvYcCXPw82pmkCV078adOZmc32D8mbTg7t+2vBFmeePF5iezSF2oH4+iSdCigR3yzDOITPJfqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrXzdhEVjqZtcb3gQNVDQ7SXHfGFT+BQ74fwYbDgdKdmCbJlr
	55D6K4JyDZboxHmlWnRZIBy9P3VDnxWPjLf2DwB4AO5RrSodYOhy+xXL9QszLyj6M7M4sjk3gR3
	iRHPs0tp8TOp1alpt+m3hg8Rm2YE=
X-Google-Smtp-Source: AGHT+IHmnkfn2U4DUW/AbQbGNRiqIh1ki0f1wenIseE4WF0+na31qB0B/1THoJw7M09s27J9XxuY79V3bsgFRNC+AX4=
X-Received: by 2002:a92:c246:0:b0:3d4:3ab3:5574 with SMTP id
 e9e14a558f8ab-3d4839feb6emr145283935ab.3.1742234471579; Mon, 17 Mar 2025
 11:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317155147.2933972-1-chen.dylane@linux.dev>
In-Reply-To: <20250317155147.2933972-1-chen.dylane@linux.dev>
From: Song Liu <song@kernel.org>
Date: Mon, 17 Mar 2025 11:01:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7T_QAo9JODteXXhoq2UagaBE3NrUqGvPMdv6qV-K-Q9g@mail.gmail.com>
X-Gm-Features: AQ5f1JpeQ8zPiIBi6y2UvMu89CERRg6O8_OB1cN7YFktVFVKetW5S2iWAQsC_OY
Message-ID: <CAPhsuW7T_QAo9JODteXXhoq2UagaBE3NrUqGvPMdv6qV-K-Q9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Define bpf_token_show_fdinfo with CONFIG_PROC_FS
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, brauner@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 8:52=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Protect bpf_token_show_fdinfo with CONFIG_PROC_FS check, otherwise
> it will compile error if CONFIG_PROC_FS is not set.

On bpt-next/master, I don't see compile error with

CONFIG_BPF_SYSCALL=3Dy
...
# CONFIG_PROC_FS is not set

Are you testing with a different tree/branch?

Thanks,
Song

>
> Fixes: 35f96de04127 ("bpf: Introduce BPF token object")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/token.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> index 26057aa13..4396eefde 100644
> --- a/kernel/bpf/token.c
> +++ b/kernel/bpf/token.c
> @@ -105,7 +105,9 @@ static const struct inode_operations bpf_token_iops =
=3D { };
>
>  static const struct file_operations bpf_token_fops =3D {
>         .release        =3D bpf_token_release,
> +#ifdef CONFIG_PROC_FS
>         .show_fdinfo    =3D bpf_token_show_fdinfo,
> +#endif
>  };
>
>  int bpf_token_create(union bpf_attr *attr)
> --
> 2.43.0
>
>

