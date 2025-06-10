Return-Path: <bpf+bounces-60254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F2AD4683
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4D13A590E
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 23:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998652D543E;
	Tue, 10 Jun 2025 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8z+Nu7R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7CC2D5425;
	Tue, 10 Jun 2025 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749597141; cv=none; b=WLEPEjrvwOx8gvyAwwnQs5sAUnK9gMIDebr3scd9eh1mAXDhkWEBF252oEzebud5CXha4O9vO1NzTwR884nbXFrtw9SNWoCkkdap2eatQMROzovndgIni6ai3WoPokln/uG/hX0SDmEyodeQmP2iyf8P0ROPybr4amXIZ9xl7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749597141; c=relaxed/simple;
	bh=Cgr6g1oZeLgTJ/nFiurFjue4inCF6/bg0YK1nblxsck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZbVWkJPLQSkrtknjisV8PIRZOEOcfMghlhpRY+4W1paaF2VgCQmgDfWklxH5IwwztUpNCU5QcPPR4vM087EITWruRsyC5Y1DhXlapBbqgTX4G1p5TwksVq9oeyB/SjqWnI/Gk/cgpFqD4qw076C5iw4lcQGCLztuAnjn3hlI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8z+Nu7R; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so3232849a12.1;
        Tue, 10 Jun 2025 16:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749597138; x=1750201938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N416KmhiAsrTKHEjQsCFVuF2rSd5ohyVuu5qR9gElC8=;
        b=M8z+Nu7RI2NyJVcY6dtSCvagWpi5x50Grufa8JVnlFA5cl4u9wnWVALVghOmoOg9MZ
         xR1VFA9ObZOsoOXUO91MR7z6vLUj0APDvfqZX11mv+hWSxAD/1BzGXW68vQE2Sa+ejEf
         y6hjBLwhi/TeO72kR8vCINc+SlHRNA8cMRbhRg3Kk5A5cW+4Y4BjNkfw4ozNu8cEXJvT
         Rsxp6RiKobPdJmm7HX4M3eKw+NGUw1uWzA6I4oECIGT5RhtIICQ4VjN+AiNTgTU7TEPX
         ImGxT1ipUFIytYeb96MK9+onlB/DqnMOzMunw72YBYNf7XT06Raw6yB7nmqRyiHMOE+F
         AApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749597138; x=1750201938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N416KmhiAsrTKHEjQsCFVuF2rSd5ohyVuu5qR9gElC8=;
        b=wg4onNFGRjz/k8SozQD9YSCETwp2KBv2wI6y2sJVLwCahcVRZb3py6WTts0hBPoapN
         U1rZUCD5lOrM+ZDEUOVnaR2KIlXfR2L3hlXkFVLJjFgsHTLTQvmh93a1KIn5BojbNlyv
         Rx1MVpisZ1kyJf4XQQcTxLttLYgJvG3MI02uJ+v5r3mxoZSj24sq5SeaJ/p284Wxejh0
         UNg+UwpTqllMVKUjgsDlUIsMle2sYxPARZy38SUqaUjpXQY9t2Rx5ER8OpVMVo7qcAtU
         Yjgm96tbcz1q9PYBnJEhHpcvcTP2Y6kcbVobdZYJBmYVPYr8NdOljMSAkGNA5YGqWG2w
         M/dA==
X-Forwarded-Encrypted: i=1; AJvYcCU6wSIaghEvwCkZuEvbMhLaWMtAF0ZwT6RWJ8H7/8uESiNKUfTz8S9zciNyQ4l0MD2Dukg=@vger.kernel.org, AJvYcCUd7tIVpo8/5zcCl7xKr5QuaUJHyC/dMB2I1igLJFVrh7rQsLNMbE60deTNBNTTOwJAUes1+Xe9FGqVQkPp@vger.kernel.org, AJvYcCXKep2V0K+mOPTlVsPzup3gBNCpTHeOA78FSWkW6yoN72TakZ25FS9LlVaZaD9o15P07nmTXNwXQS43/t0a/HExpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5hHBqCZ9U5mExcmR9qLPTeBCS29Ayil9UhUm75OrnJZ57OrR/
	8zW67igfmvjYJsEnSkkxVEDDNPw3ZO6PvQRlzxJeZC/d7UNrj+oBd6rVV5CTjM4AraKjXn+yYKO
	USR3kALU0MViafd6c47N8wSd9QYXBzK4=
X-Gm-Gg: ASbGncvIeV+W1hqfGrL8vOVv+VDoGtpVujT075tk3WlbQ4eb2rJsOXPEkKPNYSqSoRf
	HolhagOth/cW8NrwMoB0ihg0ZP1b8f7Vmd0dv8pa0g8mHIg90qohLi92kTSoCeD78N/zBsp3GgZ
	uyyGupE+Y8SR+UJO5x60uJuFTKTqrw642m3m1s3bP/ywYjVB7VG1U7zEWHZvU=
X-Google-Smtp-Source: AGHT+IFq3fbzeXau6KGVIJtcrQOTlKY9Y0JrE+63DNpYFFIGXLiZV3sIGC3Hj8bwsoVB3ec2DwG2nhcbofLhqPf2sVw=
X-Received: by 2002:a17:90b:4a50:b0:311:fc8b:31b5 with SMTP id
 98e67ed59e1d1-313af126d5cmr1912808a91.14.1749597137820; Tue, 10 Jun 2025
 16:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEMLU2li1x2bAO4w@x1> <20250606161406.GH8020@e132581.arm.com>
 <CAEf4BzY2UEe9e53Ums=d-mMVgBdc5JnVAboKz1LLmvKRk5O=jA@mail.gmail.com>
 <aENKD6yUCN9UXves@x1> <aEiVRcpvllECCrwS@x1>
In-Reply-To: <aEiVRcpvllECCrwS@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Jun 2025 16:12:04 -0700
X-Gm-Features: AX0GCFsBcVgUaq-xOEj1Q0X-xDwaS2cMceqSMMUu_tOQ7TRtUaE4X13tMuK9V6g
Message-ID: <CAEf4BzaedhaWKJdfkj=UPA+fBq_8h9Z=_tN4FK=jvdHzeQ3NYA@mail.gmail.com>
Subject: Re: BTF loading failing on perf
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Lorenz Bauer <lmb@isovalent.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 1:27=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Jun 06, 2025 at 05:05:35PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jun 06, 2025 at 09:20:57AM -0700, Andrii Nakryiko wrote:
> > > On Fri, Jun 6, 2025 at 9:14=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrot=
e:
> > > > On Fri, Jun 06, 2025 at 12:37:55PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > root@number:~# perf trace -e openat --max-events=3D1
> > > > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux':=
 -ENODEV
> > > > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux':=
 -ENODEV
> > > > >      0.000 ( 0.016 ms): ptyxis-agent/4375 openat(dfd: CWD, filena=
me: "/proc/6593/cmdline", flags: RDONLY|CLOEXEC) =3D 13
> > > > > root@number:~#
> > > > >
> > > > > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) =3D 258
> > > > > mmap(NULL, 6519699, PROT_READ, MAP_PRIVATE, 258, 0) =3D -1 ENODEV=
 (No such device)
> > > > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux':=
 -ENODEV
> > > >
> > > > Have you included the commit below in the kernel side?
> > >
> > > It doesn't matter, libbpf should silently fallback to non-mmap() way,
> >
> > Right, it has to work with older kernels, etc.
> >
> > > and it clearly doesn't.
> >
> > > We need something like this:
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -1384,12 +1384,12 @@ static struct btf *btf_parse_raw_mmap(const
> > > char *path, struct btf *base_btf)
> > >
> > >         fd =3D open(path, O_RDONLY);
> > >         if (fd < 0)
> > > -               return libbpf_err_ptr(-errno);
> > > +               return ERR_PTR(-errno);
> > >
> > >         if (fstat(fd, &st) < 0) {
> > >                 err =3D -errno;
> > >                 close(fd);
> > > -               return libbpf_err_ptr(err);
> > > +               return ERR_PTR(err);
> > >         }
> > >
> > >         data =3D mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0=
);
> > > @@ -1397,7 +1397,7 @@ static struct btf *btf_parse_raw_mmap(const cha=
r
> > > *path, struct btf *base_btf)
> > >         close(fd);
> > >
> > >         if (data =3D=3D MAP_FAILED)
> > > -               return libbpf_err_ptr(err);
> > > +               return ERR_PTR(err);
> > >
> > >         btf =3D btf_new(data, st.st_size, base_btf, true);
> > >         if (IS_ERR(btf))
> > >
> > > libbpf_err_ptr() should be used for user-facing API functions, they
> > > return NULL on error and set errno, so checking for IS_ERR() is wrong
> > > here.
> >
> > And the only user of the above function is:
> >
> >                 btf =3D btf_parse_raw_mmap(sysfs_btf_path, NULL);
> >                 if (IS_ERR(btf))
> >                         btf =3D btf__parse(sysfs_btf_path, NULL);
> >
> > That expects ERR_PTR() to then use IS_ERR().
> >
> > I think this could be automated with something like coccinnele(sp)?
>
> > Anyway, I tested the patch above and it seems to fix the issue, so:
>
> > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Was this fixed/merged?

yes, this was applied to bpf tree (not bpf-next)

>
> - Arnaldo

