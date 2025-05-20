Return-Path: <bpf+bounces-58529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C337ABD060
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3623A7E8D
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 07:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088225D54F;
	Tue, 20 May 2025 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdrMi1E8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224AA1C84C0
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725946; cv=none; b=WcaptC/TfdrO2MumiTOz4C0uFMqhQhVyuiMC47fFh2JL6LIc20pXxUJp1jNnoKXBr/Y77tNqIyqvoyvkkv1cYeV0K6K9ERR6DocHbL5C/XvT2pGxpZhboFY7jJ9ZV1wZgpcaDwVD8wcbFNUYLhNOzbcCk7bjf/YQHrAJlcueV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725946; c=relaxed/simple;
	bh=yzTerXv2eaE4nJPoN63LeBueYell4vWL8owTn+lcaIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMbSfxvOfhGFqfhbsnaYNRCGSHUHJqwnXLptj2rhGyQJF9uWboq7GQNPci/zpYRi1pSJf5UTmXMdIwvT9/BAwzGD6yIG7ci4py+UCOujwGyJodOAouhm3qOAA5sNx888l7nBu9fjKVQfIrV9pfgwjcpqFDdhb+ZSIj9galXrMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdrMi1E8; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f8cb6b3340so44112246d6.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747725944; x=1748330744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hObiR3OS0YcfNiy0nnBYeGVqefSTZY0x1eGYXc1HwuQ=;
        b=QdrMi1E8uU+F0NucgqtpGrKumGZc0fWXD0P4PLLpNogyl8kE2RdbhVce1SYYydZxRf
         jF3Hu4+UcSSPRo1A43KjimvVZmfPEHwlDtrh/XPJPzfdcBbMRnPoGCR5jM58oEzRRgvt
         Ahq5oqHy1GhHsQgYcgvovUk9NipoYvkRUqwMqzdf5JMWEbYOVyGeIUOd5UyAVhBd7ckE
         OpCbzuDD4fir8jyPTCyJq6HvLxzvXsEab5/2pB2D3BYgWvfs2FQ7/jriOKxnCYsJU0T8
         vqRZkc4DCA0juw+0Y76ClvpMuZpWBz3Rrc3am4oM/g1ln++dOmh/CpMfMYHieFGbkP53
         zePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747725944; x=1748330744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hObiR3OS0YcfNiy0nnBYeGVqefSTZY0x1eGYXc1HwuQ=;
        b=s8rynl57PJcjUKkhv77suxjF0NdWBOquqLCPLm6rLf201XxF1HV22tQexR1fQedfhM
         ++DGNZhoCiXffacKTEnN+zZvaZ4VM3qxuy7NOMnI3Jv8zd+ooQydJpssrrEJBZ14p1aa
         JR0ilGUB6M487b3aw7T7jkfBfR0eMBZuir3Hx8VQ/WOuSK4u13O0UfmGaTYWMaRtx6mr
         spNZPuDAmvzUdHTERCaMXyHEP+V+mSLU8yXchyoQnG0UsAj9GYYgdInv+Hrsv5Xm9INK
         F6/tuR6iCnmb8glaZMnmDrx7KNSupK5PS/ogMaJHFIjfZw37Sax0DgD3krUafkthxH5P
         BylA==
X-Forwarded-Encrypted: i=1; AJvYcCVth3Uz1iqa5onOw9QSmlXxtuGL2rFGToUegSOBYAHElbVhrMRPC8VOToVNHlQPP51bAqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeAFHWE2K873G9ofiGcWQDc2IdQ8Z/c6fcSk7CCrYVcgRTf/Np
	3fjcHeWFPk2uN/VR8HuTDBcSCwuiXg5l0H5Q6yuyK41RMm3sDLWPayCRHc27hDuKe5ifY1zVCHr
	O64n9fll9XqB4LFAUNgU+0xm1W7M1xpY=
X-Gm-Gg: ASbGncsr0mpy77jXCIqMnAq6hty/HeOfNxV2e5/bqQ46viylbyMNG3fyw1o6eOkdCA9
	A6xYKgmig5NiD92+/eYusOCc/I/cquFWjqC/2w3R3i7h4HnN+eNdpqZ80pXjRTHvI0OzDuZUKt8
	QVp5Oi3HGmgWXITJ4gNhx7TIxobVvxz8Cx8A==
X-Google-Smtp-Source: AGHT+IGK8HunlVifTt49FjbjG3L8jmHKgxpHhfFG6f5CcOb2w/xPPfAA1rx/ee5dIXEH56cDqFYpFNk+JEw0DjrOmjc=
X-Received: by 2002:a05:6214:260e:b0:6e8:f470:2b11 with SMTP id
 6a1803df08f44-6f8b2c95b78mr271524316d6.23.1747725943836; Tue, 20 May 2025
 00:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
In-Reply-To: <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 20 May 2025 15:25:07 +0800
X-Gm-Features: AX0GCFvZIuvlTgJImXf7EfQpV_z2hERe_3ttyhvibb45f9-8iHsF2EUD8BCjsME
Message-ID: <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Nico Pache <npache@redhat.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 2:52=E2=80=AFPM Nico Pache <npache@redhat.com> wrot=
e:
>
> On Tue, May 20, 2025 at 12:06=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > Background
> > ----------
> >
> > At my current employer, PDD, we have consistently configured THP to "ne=
ver"
> > on our production servers due to past incidents caused by its behavior:
> >
> > - Increased memory consumption
> >   THP significantly raises overall memory usage.
> >
> > - Latency spikes
> >   Random latency spikes occur due to more frequent memory compaction
> >   activity triggered by THP.
> >
> > These issues have made sysadmins hesitant to switch to "madvise" or
> > "always" modes.
> >
> > New Motivation
> > --------------
> >
> > We have now identified that certain AI workloads achieve substantial
> > performance gains with THP enabled. However, we=E2=80=99ve also verifie=
d that some
> > workloads see little to no benefit=E2=80=94or are even negatively impac=
ted=E2=80=94by THP.
> >
> > In our Kubernetes environment, we deploy mixed workloads on a single se=
rver
> > to maximize resource utilization. Our goal is to selectively enable THP=
 for
> > services that benefit from it while keeping it disabled for others. Thi=
s
> > approach allows us to incrementally enable THP for additional services =
and
> > assess how to make it more viable in production.
> >
> > Proposed Solution
> > -----------------
> >
> > For this use case, Johannes suggested introducing a dedicated mode [0].=
 In
> > this new mode, we could implement BPF-based THP adjustment for fine-gra=
ined
> > control over tasks or cgroups. If no BPF program is attached, THP remai=
ns
> > in "never" mode. This solution elegantly meets our needs while avoiding=
 the
> > complexity of managing BPF alongside other THP modes.
> >
> > A selftest example demonstrates how to enable THP for the current task
> > while keeping it disabled for others.
> >
> > Alternative Proposals
> > ---------------------
> >
> > - Gutierrez=E2=80=99s cgroup-based approach [1]
> >   - Proposed adding a new cgroup file to control THP policy.
> >   - However, as Johannes noted, cgroups are designed for hierarchical
> >     resource allocation, not arbitrary policy settings [2].
> >
> > - Usama=E2=80=99s per-task THP proposal based on prctl() [3]:
> >   - Enabling THP per task via prctl().
> >   - As David pointed out, neither madvise() nor prctl() works in "never=
"
> >     mode [4], making this solution insufficient for our needs.
> Hi Yafang Shao,
>
> I believe you would have to invert your logic and disable the
> processes you dont want using THPs, and have THP=3D"madvise"|"always". I
> have yet to look over Usama's solution in detail but I believe this is
> possible based on his cover letter.
>
> I also have an alternative solution proposed here!
> https://lore.kernel.org/lkml/20250515033857.132535-1-npache@redhat.com/
>
> It's different in the sense it doesn't give you granular control per
> process, cgroup, or BPF programmability, but it "may" suit your needs
> by taming the THP waste and removing the latency spikes of PF time THP
> compactions/allocations.

Thank you for developing this feature. I'll review it carefully.

The challenge we face is that our system administration team doesn't
permit enabling THP globally in production by setting it to "madvise"
or "always". As a result, we can only experiment with your feature on
our test servers at this stage.

Therefore, our immediate priority isn't THP optimization, but rather
finding a way to safely enable THP in production first. The kernel
team needs a solution that addresses this fundamental deployment
hurdle before we can consider performance improvements.

--=20
Regards
Yafang

