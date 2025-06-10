Return-Path: <bpf+bounces-60236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E9AD43B5
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 22:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4116E3A5DC9
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF7826563F;
	Tue, 10 Jun 2025 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHpIE1Mk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF4519A2A3;
	Tue, 10 Jun 2025 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587273; cv=none; b=pZiAEy+TyGKnltuIfyIsuBeyJet5IrQjeW3jwynopE0hleP+7JBpA7u1AuKdFxhGPe63lkNAeBQViQ5BbADRCkpCr415g6OIUlKfcZ8tIO8mcARIXVCmcIid6gy+pFvwNo3AiLktY3BBIemYTG7HYmkAmStpoWGK9wX2MMi8zSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587273; c=relaxed/simple;
	bh=OBATaljqe7OlYBaQ2tb4RndzBirGurBJZMppglRXGGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3TqTfD8g015KYwe1Z9i6L1V6JsUU+ai8d9979WJP3LpNaUCNbmmfkz4kRSBOl6oP0VkV5fxC43OSmy5UJwaatkcD3NEm0Xxtb5YeNINeyUqt5qeuX3+dfumwFolm4SPs9c1NqVOTMu+HqbPjECm/5TjUgA6F3ZSpAljQuX6ISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHpIE1Mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E42C4CEED;
	Tue, 10 Jun 2025 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749587272;
	bh=OBATaljqe7OlYBaQ2tb4RndzBirGurBJZMppglRXGGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHpIE1Mk2XFWtAhR2CZ3B92HfI5Xb1WfDD2LLtaNuGA2gDcEz+/49tknOmQ4ICiqA
	 S3+R3umZXhrkfJD7x0ULtfERbdIZafUEniZlHr77xpBGEdOFKs+QVsylY9ClTXcNsW
	 OBjaZX9NrWV70sZVLoqYMmjNaoqIVot+BbjlAyBuIuwqxo/iTS2QULxcBE+XJnclFe
	 hiDY5Mxk3kwfNXdHv93LbyR77MH3Abd4vYwhnevfWttnh9ClTkb8biGHPoGHv+rlLf
	 U9x0vQMKaTiPyaix3NG8+mFTdagugpJCKe8W2/VZkVFqx8z1DbOJD2SYPH/BqzDvJc
	 3UJsr0zz7hUjQ==
Date: Tue, 10 Jun 2025 17:27:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Leo Yan <leo.yan@arm.com>, Lorenz Bauer <lmb@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: BTF loading failing on perf
Message-ID: <aEiVRcpvllECCrwS@x1>
References: <aEMLU2li1x2bAO4w@x1>
 <20250606161406.GH8020@e132581.arm.com>
 <CAEf4BzY2UEe9e53Ums=d-mMVgBdc5JnVAboKz1LLmvKRk5O=jA@mail.gmail.com>
 <aENKD6yUCN9UXves@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aENKD6yUCN9UXves@x1>

On Fri, Jun 06, 2025 at 05:05:35PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jun 06, 2025 at 09:20:57AM -0700, Andrii Nakryiko wrote:
> > On Fri, Jun 6, 2025 at 9:14 AM Leo Yan <leo.yan@arm.com> wrote:
> > > On Fri, Jun 06, 2025 at 12:37:55PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > root@number:~# perf trace -e openat --max-events=1
> > > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
> > > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
> > > >      0.000 ( 0.016 ms): ptyxis-agent/4375 openat(dfd: CWD, filename: "/proc/6593/cmdline", flags: RDONLY|CLOEXEC) = 13
> > > > root@number:~#
> > > >
> > > > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 258
> > > > mmap(NULL, 6519699, PROT_READ, MAP_PRIVATE, 258, 0) = -1 ENODEV (No such device)
> > > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
> > >
> > > Have you included the commit below in the kernel side?
> > 
> > It doesn't matter, libbpf should silently fallback to non-mmap() way,
> 
> Right, it has to work with older kernels, etc.
> 
> > and it clearly doesn't.
> 
> > We need something like this:
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1384,12 +1384,12 @@ static struct btf *btf_parse_raw_mmap(const
> > char *path, struct btf *base_btf)
> > 
> >         fd = open(path, O_RDONLY);
> >         if (fd < 0)
> > -               return libbpf_err_ptr(-errno);
> > +               return ERR_PTR(-errno);
> > 
> >         if (fstat(fd, &st) < 0) {
> >                 err = -errno;
> >                 close(fd);
> > -               return libbpf_err_ptr(err);
> > +               return ERR_PTR(err);
> >         }
> > 
> >         data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> > @@ -1397,7 +1397,7 @@ static struct btf *btf_parse_raw_mmap(const char
> > *path, struct btf *base_btf)
> >         close(fd);
> > 
> >         if (data == MAP_FAILED)
> > -               return libbpf_err_ptr(err);
> > +               return ERR_PTR(err);
> > 
> >         btf = btf_new(data, st.st_size, base_btf, true);
> >         if (IS_ERR(btf))
> > 
> > libbpf_err_ptr() should be used for user-facing API functions, they
> > return NULL on error and set errno, so checking for IS_ERR() is wrong
> > here.
> 
> And the only user of the above function is:
> 
>                 btf = btf_parse_raw_mmap(sysfs_btf_path, NULL);
>                 if (IS_ERR(btf))
>                         btf = btf__parse(sysfs_btf_path, NULL);
> 
> That expects ERR_PTR() to then use IS_ERR().
> 
> I think this could be automated with something like coccinnele(sp)?
 
> Anyway, I tested the patch above and it seems to fix the issue, so:
 
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Was this fixed/merged?

- Arnaldo

