Return-Path: <bpf+bounces-59876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A15AAD0687
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1420A17B2F6
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF02289E03;
	Fri,  6 Jun 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2WbI4JF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF21DE3C7;
	Fri,  6 Jun 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749226883; cv=none; b=S2lJiVMbOKv6mTtm5WSfTQBgxbxgLF4i0ZUiUqKbXuqpvdB4ekpwWgKPAsOaHBG1ReLOEi4TL/w9Q+QqwKgNs+eFxVk0ukW74yEcPRuMptv47Vdo05pNP5AFvVCVHkR3zLoSWakkwwyffe5zHnmFMv+oPPi7a19JIBX9HhKUhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749226883; c=relaxed/simple;
	bh=SsABznqS+74Ku7nIalgWQ6r5XRamMp7UZkh/psf+9Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDYq6o5CmK9pKW6vv35JBBnTBhpVxDlxErkU0QzzRhFyq+orgWNbXtBtwCHrVSLzuqyEjhs5w7E6CkSOaFsqNM79uzyRlUBUarmL9lzpdMWkNd/N9vVO+HwEFEj8MmNSoPcHahRQL4km+nDpZQ4FnOmLya7QWu61WUhaeyoMvJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2WbI4JF; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60ef6bf2336so1651651eaf.0;
        Fri, 06 Jun 2025 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749226881; x=1749831681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JA6lc95yGfo9qkQDGqCiJRxdLRQP3UK8ri3kJPzAPU=;
        b=N2WbI4JF3w3EA9UJgkWvMFTQ2bVl8oNgttV8Ej4S5RBZIN2vdhkisTGaty8wngUiY4
         LHEeAltvtAHfRb570Y4bo9HG5Th3zs6vGtF+imAzVX9RZZ7XATusrcNJykTz8cbhjR0R
         QzQoyRe0fYHZ4YmMANUUcwX5U+gLdB8Gshd5aNTOIoEqHZwVsoTsaNDZBvXKzewCMyhL
         DY4a4zWiTXxBBXcHCTBPLQtXqwFdxA+1K1AyUURLgjfSl1RuMo8tvuMJGvMcuqq7Myng
         YQoGcGikfsUb8VNy+L+QTP0IhEOmGUqyFxqGsA8iRzrX1d/gfkMv55nQqlVSqeS9HXtq
         NQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749226881; x=1749831681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JA6lc95yGfo9qkQDGqCiJRxdLRQP3UK8ri3kJPzAPU=;
        b=rP1vvip3dblsHW6GkUewKmPhisPDkuBvyVUnI3Pmx9Cn9Re6cvd3xX6PKh4CAbKMld
         h5DqjnC0FT/tJqeYRK/nTCZV0Ld8qwCVtTnn2n9ehEcyvxSuvXxw5Vmv7C7n6iwcmDdD
         nVL97BS+Wt2F4kkOFCPdMsnXhRgaDlYJeY6XBsISGJ74qcPMJBwfYh2m+GflCvLtvR9I
         S1cHr++mKTHN+UpN1ioXFisfGkbFwcW747yHgf3amDKRlTTUWVuXd8xhvggwXa4+nA7v
         jwjPBaPww0YIVDnkX88za7I2GtxKpdlPc+8uuJ64G/DrEnVu4CGySgQZG9x8LgVVcOB8
         q26w==
X-Forwarded-Encrypted: i=1; AJvYcCU5s0Eu5dOlJdViK1kzl2omw3YNa2ZIkhb56osdPKFhNxQ3W3YBMONou3aGodp23bsms2FQaK+MloRBTVyR@vger.kernel.org, AJvYcCUXKAkAtfzXq4yGta0nBRTH7cwYFzVQC9Buih0EDx1jr+mt4Q9lg9RZSvIRN5h6QwWXTlQ=@vger.kernel.org, AJvYcCUqB29CaP9qPybkSFYFcRB+vxCz+H54n30VAKQjCzfON2ZSnz1NNP9F3wnuAHs9764paf4ZBqxGA185m3D02PyUTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcdH2KGDlew4zttOokwb7UrRwh+tVSRrdqPpUhI/P0ECpRLZEl
	lY8BPWHRlJ3F4bsdKBBDDafuAohKMkMrpyvWdPQFY1MFQGCoWpPCZpsu9rlfBd2GQ7ymNa/Ezfj
	RlPfbiLmnDqI1tOx+yH7QrTZ8QIsyamWNrJIt
X-Gm-Gg: ASbGnctweFQIPV66/Ddjum8E0w7JzrJnvqC+MtBnaPAsSYcdtoHWnfH/QI2xlNJFztm
	wIsDbzbzblShzb9PDmZZm4NcKru3VfyAdkXj5uXTo2ZIXgSb/I1ZPxUKUSX8O+rEjc4G7KpCXfR
	8h5Wtn/Cu9SUFLD3WukDcpgFGhfnpQZDLlqOAqDjbBQw==
X-Google-Smtp-Source: AGHT+IGCSqQp15n0QAdFL76AqBOrGxXPE6HwOt3EeXCbeyYM1elDNyrslevOvDrZHELS/En4ToKZPvY/UKYPR7KOVsc=
X-Received: by 2002:a17:90b:2252:b0:311:f684:d3cd with SMTP id
 98e67ed59e1d1-313472fcd3dmr7263430a91.12.1749226869675; Fri, 06 Jun 2025
 09:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEMLU2li1x2bAO4w@x1> <20250606161406.GH8020@e132581.arm.com>
In-Reply-To: <20250606161406.GH8020@e132581.arm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Jun 2025 09:20:57 -0700
X-Gm-Features: AX0GCFuUPtZk0JRK5pyxo55eADkqd6qDCZKEMFWm6cVuCiPqwkVJVPXOPFUNfQc
Message-ID: <CAEf4BzY2UEe9e53Ums=d-mMVgBdc5JnVAboKz1LLmvKRk5O=jA@mail.gmail.com>
Subject: Re: BTF loading failing on perf
To: Leo Yan <leo.yan@arm.com>, Lorenz Bauer <lmb@isovalent.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 9:14=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Arnaldo,
>
> On Fri, Jun 06, 2025 at 12:37:55PM -0300, Arnaldo Carvalho de Melo wrote:
> > root@number:~# perf trace -e openat --max-events=3D1
> > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENOD=
EV
> > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENOD=
EV
> >      0.000 ( 0.016 ms): ptyxis-agent/4375 openat(dfd: CWD, filename: "/=
proc/6593/cmdline", flags: RDONLY|CLOEXEC) =3D 13
> > root@number:~#
> >
> > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) =3D 258
> > mmap(NULL, 6519699, PROT_READ, MAP_PRIVATE, 258, 0) =3D -1 ENODEV (No s=
uch device)
> > libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENOD=
EV
>
> Have you included the commit below in the kernel side?

It doesn't matter, libbpf should silently fallback to non-mmap() way,
and it clearly doesn't.

We need something like this:

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index f1d495dc66bb..37682908cb0f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1384,12 +1384,12 @@ static struct btf *btf_parse_raw_mmap(const
char *path, struct btf *base_btf)

        fd =3D open(path, O_RDONLY);
        if (fd < 0)
-               return libbpf_err_ptr(-errno);
+               return ERR_PTR(-errno);

        if (fstat(fd, &st) < 0) {
                err =3D -errno;
                close(fd);
-               return libbpf_err_ptr(err);
+               return ERR_PTR(err);
        }

        data =3D mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -1397,7 +1397,7 @@ static struct btf *btf_parse_raw_mmap(const char
*path, struct btf *base_btf)
        close(fd);

        if (data =3D=3D MAP_FAILED)
-               return libbpf_err_ptr(err);
+               return ERR_PTR(err);

        btf =3D btf_new(data, st.st_size, base_btf, true);
        if (IS_ERR(btf))

libbpf_err_ptr() should be used for user-facing API functions, they
return NULL on error and set errno, so checking for IS_ERR() is wrong
here.

Lorenz, can you please test and send a proper fix ASAP?

>
> commit a539e2a6d51d1c12d89eec149ccc72ec561639bc
> Author: Lorenz Bauer <lmb@isovalent.com>
> Date:   Tue May 20 14:01:17 2025 +0100
>
>     btf: Allow mmap of vmlinux btf
>
>     User space needs access to kernel BTF for many modern features of BPF=
.
>     Right now each process needs to read the BTF blob either in pieces or
>     as a whole. Allow mmaping the sysfs file so that processes can direct=
ly
>     access the memory allocated for it in the kernel.
>
>     remap_pfn_range is used instead of vm_insert_page due to aarch64
>     compatibility issues.
>
>     Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
>     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>     Tested-by: Alan Maguire <alan.maguire@oracle.com>
>     Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>     Link: https://lore.kernel.org/bpf/20250520-vmlinux-mmap-v5-1-e8c941ac=
c414@isovalent.com
>
> Thanks,
> Leo

