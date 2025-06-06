Return-Path: <bpf+bounces-59922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24FAD08E5
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 22:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902453B20CD
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9359217F29;
	Fri,  6 Jun 2025 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI4Xj6H6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224D4683;
	Fri,  6 Jun 2025 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240341; cv=none; b=gf/NRJZmQ5yt1T8IvOrGygJ9VaDRF2Kx5iuEQlSyk/ZSn381W9R8QQLRQX+Nh2nufMxC6cqXBFE+Yerd3IEKKaF9A5/I6ea/uW5BmiNxY4+YYC2khG0cu6RyAobtHuKl+OVkR5ypU36Zp30Dz0HqReAytcy2ZDaryh6D6wXQJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240341; c=relaxed/simple;
	bh=FQ3fjcNpzvQ9V7CwjG1kiv01ToImRNUpU3/LKa/6tzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbBRiJDu39W7zEgDjZg9Oj/lTdr17ELnGow9yriLzlYN2Zu7eAk8WB2vC4Qosd6wHyfj5ykofBJYJZE1a8Ui7BSa20c38mte0bQ6GSQhcuPKS4X2Cul/Hn4te8pGMW7Hm1HBzbmMSEyzay92UwjHnqslFafSjyWTEqfzWklCGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI4Xj6H6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EA7C4CEEB;
	Fri,  6 Jun 2025 20:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749240338;
	bh=FQ3fjcNpzvQ9V7CwjG1kiv01ToImRNUpU3/LKa/6tzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kI4Xj6H6vyFs3nwqcsRnkHaRVaA3RP22CWj6F7Bz8yEbdYW+EJp2I6TJQEnzHcjXZ
	 /nh0dMm0RHZyB/IPuxuf4sO/YxCH/kctVW1SidV1cwEE1rL4gu4d2mQtzFe2B2qGLF
	 KIrevHInSuy7dRslQoTSIJHSaxeBBCzjioptnv+SkG9tmLT6yylKr0/kbZIN+n+m+Z
	 Xq8wf0qJ2OLER+g9Ztw5CScZMsufY0rBsKDPcLb5319mjtLVdxmNcZhqN9gC8VEcGH
	 msNWBlpXo8buD5ca+vuol8H1MDqHc9YsW48/D8Qup7aI9HL5LgTxOK75Mzkz8yYN95
	 0gSXk3LhdH8bQ==
Date: Fri, 6 Jun 2025 17:05:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Leo Yan <leo.yan@arm.com>, Lorenz Bauer <lmb@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: BTF loading failing on perf
Message-ID: <aENKD6yUCN9UXves@x1>
References: <aEMLU2li1x2bAO4w@x1>
 <20250606161406.GH8020@e132581.arm.com>
 <CAEf4BzY2UEe9e53Ums=d-mMVgBdc5JnVAboKz1LLmvKRk5O=jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY2UEe9e53Ums=d-mMVgBdc5JnVAboKz1LLmvKRk5O=jA@mail.gmail.com>

On Fri, Jun 06, 2025 at 09:20:57AM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 6, 2025 at 9:14 AM Leo Yan <leo.yan@arm.com> wrote:
> > On Fri, Jun 06, 2025 at 12:37:55PM -0300, Arnaldo Carvalho de Melo wrote:
> > > root@number:~# perf trace -e openat --max-events=1
> > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
> > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
> > >      0.000 ( 0.016 ms): ptyxis-agent/4375 openat(dfd: CWD, filename: "/proc/6593/cmdline", flags: RDONLY|CLOEXEC) = 13
> > > root@number:~#
> > >
> > > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 258
> > > mmap(NULL, 6519699, PROT_READ, MAP_PRIVATE, 258, 0) = -1 ENODEV (No such device)
> > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
> >
> > Have you included the commit below in the kernel side?
> 
> It doesn't matter, libbpf should silently fallback to non-mmap() way,

Right, it has to work with older kernels, etc.

> and it clearly doesn't.

> We need something like this:
> +++ b/tools/lib/bpf/btf.c
> @@ -1384,12 +1384,12 @@ static struct btf *btf_parse_raw_mmap(const
> char *path, struct btf *base_btf)
> 
>         fd = open(path, O_RDONLY);
>         if (fd < 0)
> -               return libbpf_err_ptr(-errno);
> +               return ERR_PTR(-errno);
> 
>         if (fstat(fd, &st) < 0) {
>                 err = -errno;
>                 close(fd);
> -               return libbpf_err_ptr(err);
> +               return ERR_PTR(err);
>         }
> 
>         data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> @@ -1397,7 +1397,7 @@ static struct btf *btf_parse_raw_mmap(const char
> *path, struct btf *base_btf)
>         close(fd);
> 
>         if (data == MAP_FAILED)
> -               return libbpf_err_ptr(err);
> +               return ERR_PTR(err);
> 
>         btf = btf_new(data, st.st_size, base_btf, true);
>         if (IS_ERR(btf))
> 
> libbpf_err_ptr() should be used for user-facing API functions, they
> return NULL on error and set errno, so checking for IS_ERR() is wrong
> here.

And the only user of the above function is:

                btf = btf_parse_raw_mmap(sysfs_btf_path, NULL);
                if (IS_ERR(btf))
                        btf = btf__parse(sysfs_btf_path, NULL);

That expects ERR_PTR() to then use IS_ERR().

I think this could be automated with something like coccinnele(sp)?

Anyway, I tested the patch above and it seems to fix the issue, so:

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

 
> Lorenz, can you please test and send a proper fix ASAP?
> 
> >
> > commit a539e2a6d51d1c12d89eec149ccc72ec561639bc
> > Author: Lorenz Bauer <lmb@isovalent.com>
> > Date:   Tue May 20 14:01:17 2025 +0100
> >
> >     btf: Allow mmap of vmlinux btf
> >
> >     User space needs access to kernel BTF for many modern features of BPF.
> >     Right now each process needs to read the BTF blob either in pieces or
> >     as a whole. Allow mmaping the sysfs file so that processes can directly
> >     access the memory allocated for it in the kernel.
> >
> >     remap_pfn_range is used instead of vm_insert_page due to aarch64
> >     compatibility issues.
> >
> >     Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >     Tested-by: Alan Maguire <alan.maguire@oracle.com>
> >     Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> >     Link: https://lore.kernel.org/bpf/20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com
> >
> > Thanks,
> > Leo

