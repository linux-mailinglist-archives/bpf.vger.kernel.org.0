Return-Path: <bpf+bounces-57049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547E3AA4F17
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDEF9C2493
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4730D1553AB;
	Wed, 30 Apr 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJVz/jwo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF419AD90
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024584; cv=none; b=dPIIXsRtJIctLCz74t8Zfz6t5/5gTx2BOlHGqxJjX9v5ZU/6e6wanhSDWQGB3e+WMKXfiOoDG+aOmXkAG247btEteLyXOsDMHsb33/yJyZKzp78SsOXjJqKji1MwrcvvP/s6q1YgEqDXNEYKA+r4Ed8L7c5BJrqu5mtYQsz1ALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024584; c=relaxed/simple;
	bh=daFXZxHPznViVE59eA0badf4GZiehSG/OJ2Z1rp6h4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nRE5dXSwratnyV+BiQq6mmjr8bdLUyazpuhPLfr5IeqKKk3M+wrmpcBVqKnTGKSg7JOzfVLV/dDUK/w17OBI/19TyQUWp8C+yMSn7BhzKvLaRnPITidlbkJXgTYMxeXxGwGLLKfG7XM5dmOtBb/ulO0sJ3z+Mtvd9QrG4S/Ozdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJVz/jwo; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f05acc13so101623416d6.2
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746024582; x=1746629382; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU4NKfHxJMeuIlQdXd/A4s7t9wkDKo3v5r7gsWNIVic=;
        b=mJVz/jwozh/4hWQjz76FVbKXZ8nZUjszhHRhz32WU+AfgkoRN7gNhA/VcIowk2Mogp
         BW2//XGYp+w0Q0Z1i0YiZFD4pcN5EKiPEYmFDf2S6207wLQtYZg9jHDwF8R6gpBxCwP4
         4LZmgpqATiJyW3p2YDtOPICUbM0u9zYehn+cTUzgN/7XvodHYetkmhxtFaZvrcWNDwso
         iqG7nJUr3/4khLq6fB4mvdUZ4v1+la3f7qmkN6b9Elxmsy5hqncxAI5UElVMFnO26/Ln
         kBqN/aiCm9sXlTLbEYwYiJM9/EManpgF0JupN0I6s0XpuvGORWCLFa0yfqTLIIUrDuDX
         6EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746024582; x=1746629382;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cU4NKfHxJMeuIlQdXd/A4s7t9wkDKo3v5r7gsWNIVic=;
        b=uSuMnGXsGpxDOKldR2LrWX+fGmUS5F+mZIlWm2VMnA2uXbLL7Kc/HK4omczUgc1Ukk
         LyibgfU1bHhlHHfqYh+YBRqZLm1sPk98R8CHbiWnqKnu+wojoAPZZ59yasxlUwf7sS8w
         NFwiKNexRN3+oxjb++j+1djGT2HvQr8/R9HHBeVlSpJ+1vyWFCcv+V+BNzGdkX3cHRh/
         v/2MT53ycbKmFTHDp+zQWN5w1dGQX5Qi4YVnq/mNyowQl2ZmNlFMirpPKyIpmI7G03aV
         vKEu7xFRAiTmB9GpoEtNZiwOOx6WpGj3zekHf8JKuImCqH3itUjmbRKX4Y4KbD2IkFuZ
         Dmhw==
X-Forwarded-Encrypted: i=1; AJvYcCWA3Xstf0j4VJ96kFznNi6hZepx7ct0jiYWxOoJpzXeeGqEDs9dDeM9s7tNe9KHDvFeqOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAYg8gKdDQoexgGbmMGRk4wQH4LB9lgP5rl5BRwyZGbA3jvz7r
	2pFpf/x8Sq0XqEWg6RJMzP7guZS+KJ5TSCxqhtEr3V1bESkyOywQO6MfkWBFL1O3heUjAKbe+ga
	WXBkT040lTialefg9rgDLBfFi9gc=
X-Gm-Gg: ASbGnct8CWXz29LyL/yMfuPT1tZluYD5xPxP9Ct3hnHyQSPHgj5vzyMUj1gTKpqRE+w
	naGItiMYi1pAD7F/43VfUSQcStfGgDFtxQi4kna+wWCp0JrcUUtPyrQCtc+7vCVwb4RHAcVeF+f
	4dlzPjKyYllOy10gYMNADI3a4=
X-Google-Smtp-Source: AGHT+IEFfOtXbhuo2KYEJrXOXA67a49pK/Py7Js2hhpEacw1tYE3Sy9iX9hFS4Mf3q0iInSN4YAnZM4MrrvTqazyL4w=
X-Received: by 2002:a05:6214:2584:b0:6e8:fb92:dffa with SMTP id
 6a1803df08f44-6f4fe081236mr42855706d6.25.1746024581871; Wed, 30 Apr 2025
 07:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com> <rp3izx7uzdwzn2n4z37yaeqff7xkmz2xbshlqmgy2d5ucuzpeo@wfel6273tlg6>
In-Reply-To: <rp3izx7uzdwzn2n4z37yaeqff7xkmz2xbshlqmgy2d5ucuzpeo@wfel6273tlg6>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Apr 2025 22:49:05 +0800
X-Gm-Features: ATxdqUGSU4uUxIRl1XfcIDPquyr7Fb_J78ZWdDle-9uGuj6DAH62-ubcyPORadA
Message-ID: <CALOAHbDWusEwZ-sBRwcDC3CJQdfQGeLZetuSGxUphj7=8o2M1A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 10:40=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Yafang Shao <laoar.shao@gmail.com> [250429 22:34]:
> > On Tue, Apr 29, 2025 at 11:09=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> > >
> > > Hi Yafang,
> > >
> > > We recently added a new THP entry in MAINTAINERS file[1], do you mind=
 ccing
> > > people there in your next version? (I added them here)
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/=
MAINTAINERS?h=3Dmm-everything#n15589
> >
> > Thanks for your reminder.
> > I will add the maintainers and reviewers in the next version.
> >
> > >
> > > On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
> > > > In our container environment, we aim to enable THP selectively=E2=
=80=94allowing
> > > > specific services to use it while restricting others. This approach=
 is
> > > > driven by the following considerations:
> > > >
> > > > 1. Memory Fragmentation
> > > >    THP can lead to increased memory fragmentation, so we want to li=
mit its
> > > >    use across services.
> > > > 2. Performance Impact
> > > >    Some services see no benefit from THP, making its usage unnecess=
ary.
> > > > 3. Performance Gains
> > > >    Certain workloads, such as machine learning services, experience
> > > >    significant performance improvements with THP, so we enable it f=
or them
> > > >    specifically.
> > > >
> > > > Since multiple services run on a single host in a containerized env=
ironment,
> > > > enabling THP globally is not ideal. Previously, we set THP to madvi=
se,
> > > > allowing selected services to opt in via MADV_HUGEPAGE. However, th=
is
> > > > approach had limitation:
> > > >
> > > > - Some services inadvertently used madvise(MADV_HUGEPAGE) through
> > > >   third-party libraries, bypassing our restrictions.
> > >
> > > Basically, you want more precise control of THP enablement and the
> > > ability of overriding madvise() from userspace.
> > >
> > > In terms of overriding madvise(), do you have any concrete example of
> > > these third-party libraries? madvise() users are supposed to know wha=
t
> > > they are doing, so I wonder why they are causing trouble in your
> > > environment.
> >
> > To my knowledge, jemalloc [0] supports THP.
> > Applications using jemalloc typically rely on its default
> > configurations rather than explicitly enabling or disabling THP. If
> > the system is configured with THP=3Dmadvise, these applications may
> > automatically leverage THP where appropriate
>
> Isn't jemalloc THP aware and can be configured to always, never, or
> "default to the system setting" use THP for both metadata and
> allocations? It seems like this is an example of a thrid party library
> that knows what it is doing in regards to THP. [1]

Thanks for your explanation.

>
> If jemalloc is not following its own settings then it is an issue in
> jemalloc and not a reason for a kernel change.

We don=E2=80=99t change the kernel to accommodate specific userspace
settings=E2=80=94we change it only when it benefits users more broadly.

By the way, this patchset isn=E2=80=99t intended to address that issue. If
it=E2=80=99s causing confusion about the problem this patchset is trying to
solve, I=E2=80=99ll remove that part from the commit log in the next versio=
n.

>
> If you are relying on the default configuration of jemalloc and it
> doesn't work as you expect, then maybe try the thp settings?
>
> >
> > [0]. https://github.com/jemalloc/jemalloc
>
> ...
>
> Thanks,
> Liam
>
> [1]. https://jemalloc.net/jemalloc.3.html



--=20
Regards
Yafang

