Return-Path: <bpf+bounces-59924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E65C1AD0907
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 22:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBF6189EFC1
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 20:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91927215793;
	Fri,  6 Jun 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKyzK8DO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AB202961;
	Fri,  6 Jun 2025 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749241389; cv=none; b=bNOlWsJ03x7P/KQ2VQPcHoCAcM3O9zv/7uTP3Vx16FBtxgSCB2sg+oBTczcKTewzBlKRp7LAEsDe+5JxxGIkWXFfSZRSrYSfENiQse9rxbr2A0Ic5ZoG6I8YNZbcxptKnBR6hfm6A3gduMOdqDBrBVMmmdAWU8X1mvhoIEAA3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749241389; c=relaxed/simple;
	bh=nDiegZWc7QxPGHerpam1Ue4vcVP/T6DHz9YPR1xmVhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHZtZsaukEujGza2tkdskRJ7SxeYUwy62N71sqLPQJ4U5YKFGxJL4juLwXD54VzeTNuvsS3wVIX67Amn3/9B5uXikWdPyjw2UJoUPVgAl8bCd9ELWeAHmc9cQkzm4prxfQrTNwONLAgCGjx7qgXv1WM625N/jo/xDre31K/9rWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKyzK8DO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-231e8553248so26239545ad.1;
        Fri, 06 Jun 2025 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749241387; x=1749846187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTCCTUeTTG7ew0R5pNM6c5gfbUJ/nSL/1xswiZTrzKU=;
        b=QKyzK8DO5BP5Xnpzmlk+BOPX99RTRMk8XxKi3QODPAHme//LAXK+qEcSvrE/q1bhuO
         LYUxpFdThwfI6jwafPU+xQSC2mGJ2i+EFyZicZ5ZEvd7DCdo5wthYPz9VsgEnwgIhl24
         /6SUFVsYwMiXivibXXC0QC75c11WsbmzohWfCjBUNPZWfrjsfNQq0Gw/3fG1uySJjvIS
         kNNv6JFy/AaVAUhDHDHlGNdZzcwjlwps+APGKpyPHYcLvdcHNSFo7vz7mxDysBK4nKiE
         IEWPeNGNkzvb4mi1RDy8jxIAFpz3E1DUeDi8aohBbqoP56h6QXQGPLUUDHI8NwJrsQLl
         lfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749241387; x=1749846187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTCCTUeTTG7ew0R5pNM6c5gfbUJ/nSL/1xswiZTrzKU=;
        b=EDW397xRHThhrMeVmvUHEbJ+s28KLVwC3vxYzl+tROUj8PUaPcno6C82iG+uicutfk
         j/BFi2xMBlvfRY9ui1UqlGjKFPto2w43fajNZukaV/pF+dG9QMhrPuANq37DCB3Ybyst
         JQ4dY/VR/Ue45xWAFLeVKN/YKKTc4WS50vo75LtAyQ4RtjWxBroiYoMOy/j3fpt2zfBp
         imPbyPq0PTkeew5RH3HNte8Gzd8zvk9FOFE7TIsM68OUnnoo4qd0v4Mt0SSLVh5BhYs4
         t13NmJDNBe1X5cKTi+No4Rm4E9aQQAflFPTmWTwWbw/XuGet50k2RI3e8UDgp3l5pVaE
         to0w==
X-Forwarded-Encrypted: i=1; AJvYcCVNA4gLVMm1HnOW+CR3ikhURPhKrw3/zN5K+5B2xjUvXNTkO6eayOzW1u9GFbbo+KOfwOovkFgD4WXBiwGH@vger.kernel.org, AJvYcCXBpRH6qysxknKX0IV3PYVQ3uVfZOMYAdJyDvK8sYy9P7vSc0cI50M1QQ5p8ORRzpSNGuiZxfdp6OGDCxdZL+LUzA==@vger.kernel.org, AJvYcCXkmLR/an1ZxSavSffz9MXRgb8y+SFw2pKamLtE7JSPKsMVVgRuRuXoJNNcc4mGD7CGexo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8c69mlYmxYbOX0txQnLE5sKFPKKiKjFlwLFYMTuCUXnuCRAwx
	JNfj2BKDGELaB/+Csc6t0LNU2tqE6gSt0KYIZD6ND6+1YDxOg4Ccdrw6GXQQe3P3dKlAOFIM1PC
	6ANNZD4DskkogJyE0iOzihqXqYADOWCs=
X-Gm-Gg: ASbGncsecWerHWtpK63ErjFvQj5BIqbkUtfWnv2rgFUFxBQr0jVZ+zKLam27dBx4qfJ
	+CASg5tt3axzK+qAF0gsjxSZa5oGVIaqYP8V6g5hqvTKrZl8HMa9ZuyegY4VShT8eKUlos2M6Lm
	NFWg96XwkVxSUHis5L+8yG2m7Uxu8aEMw=
X-Google-Smtp-Source: AGHT+IEcN3y6nUZfm5SWkKO7cd/uZKIO6wYCAONvneGjgRMRISsIMh1EuvF90Jw9iYqSEuAjitgo9NpwL2k0MB4sywk=
X-Received: by 2002:a17:902:db10:b0:235:91a:2c with SMTP id
 d9443c01a7336-23601d82d3fmr57184385ad.42.1749241386736; Fri, 06 Jun 2025
 13:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEMLU2li1x2bAO4w@x1> <20250606161406.GH8020@e132581.arm.com>
 <CAEf4BzY2UEe9e53Ums=d-mMVgBdc5JnVAboKz1LLmvKRk5O=jA@mail.gmail.com> <aENKD6yUCN9UXves@x1>
In-Reply-To: <aENKD6yUCN9UXves@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Jun 2025 13:22:54 -0700
X-Gm-Features: AX0GCFvJKLjRmeAOzJrfXVX7mPidS077DNLeeKytLj_QuruaL7TOLtFznyTKeCc
Message-ID: <CAEf4Bzaz4usXMNB_ffWDiZhVseCD6EFA+TJGtWMA-K4_cqdfNA@mail.gmail.com>
Subject: Re: BTF loading failing on perf
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Lorenz Bauer <lmb@isovalent.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 1:05=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Fri, Jun 06, 2025 at 09:20:57AM -0700, Andrii Nakryiko wrote:
> > On Fri, Jun 6, 2025 at 9:14=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
> > > On Fri, Jun 06, 2025 at 12:37:55PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > root@number:~# perf trace -e openat --max-events=3D1
> > > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -=
ENODEV
> > > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -=
ENODEV
> > > >      0.000 ( 0.016 ms): ptyxis-agent/4375 openat(dfd: CWD, filename=
: "/proc/6593/cmdline", flags: RDONLY|CLOEXEC) =3D 13
> > > > root@number:~#
> > > >
> > > > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) =3D 258
> > > > mmap(NULL, 6519699, PROT_READ, MAP_PRIVATE, 258, 0) =3D -1 ENODEV (=
No such device)
> > > > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -=
ENODEV
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
> >         fd =3D open(path, O_RDONLY);
> >         if (fd < 0)
> > -               return libbpf_err_ptr(-errno);
> > +               return ERR_PTR(-errno);
> >
> >         if (fstat(fd, &st) < 0) {
> >                 err =3D -errno;
> >                 close(fd);
> > -               return libbpf_err_ptr(err);
> > +               return ERR_PTR(err);
> >         }
> >
> >         data =3D mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> > @@ -1397,7 +1397,7 @@ static struct btf *btf_parse_raw_mmap(const char
> > *path, struct btf *base_btf)
> >         close(fd);
> >
> >         if (data =3D=3D MAP_FAILED)
> > -               return libbpf_err_ptr(err);
> > +               return ERR_PTR(err);
> >
> >         btf =3D btf_new(data, st.st_size, base_btf, true);
> >         if (IS_ERR(btf))
> >
> > libbpf_err_ptr() should be used for user-facing API functions, they
> > return NULL on error and set errno, so checking for IS_ERR() is wrong
> > here.
>
> And the only user of the above function is:
>
>                 btf =3D btf_parse_raw_mmap(sysfs_btf_path, NULL);
>                 if (IS_ERR(btf))
>                         btf =3D btf__parse(sysfs_btf_path, NULL);
>
> That expects ERR_PTR() to then use IS_ERR().
>
> I think this could be automated with something like coccinnele(sp)?
>
> Anyway, I tested the patch above and it seems to fix the issue, so:
>
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>

Just sent a quick fix to not leave this waiting over the weekend.
Thanks for catching and reporting, Arnaldo!

> - Arnaldo
>
>
> > Lorenz, can you please test and send a proper fix ASAP?
> >
> > >
> > > commit a539e2a6d51d1c12d89eec149ccc72ec561639bc
> > > Author: Lorenz Bauer <lmb@isovalent.com>
> > > Date:   Tue May 20 14:01:17 2025 +0100
> > >
> > >     btf: Allow mmap of vmlinux btf
> > >
> > >     User space needs access to kernel BTF for many modern features of=
 BPF.
> > >     Right now each process needs to read the BTF blob either in piece=
s or
> > >     as a whole. Allow mmaping the sysfs file so that processes can di=
rectly
> > >     access the memory allocated for it in the kernel.
> > >
> > >     remap_pfn_range is used instead of vm_insert_page due to aarch64
> > >     compatibility issues.
> > >
> > >     Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> > >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >     Tested-by: Alan Maguire <alan.maguire@oracle.com>
> > >     Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> > >     Link: https://lore.kernel.org/bpf/20250520-vmlinux-mmap-v5-1-e8c9=
41acc414@isovalent.com
> > >
> > > Thanks,
> > > Leo

