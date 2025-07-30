Return-Path: <bpf+bounces-64685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4982B1578F
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 04:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE298189A1CD
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 02:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FF9167DB7;
	Wed, 30 Jul 2025 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA6bwNqj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F812B94
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753842743; cv=none; b=oNk9NiXdXQqabHKbSc+lVn6MZ5E8gmawLhcpRdKUKqT9Tp2kvmGCkZjvGY1YCGGMrCJ5YffRNodGWfszXocb3Z3gVTDI9rVSSS37R0ZDOjxafd6oh5ZyRQkVFOZxSq8BdgfErVF3oIsth5BO5nLgucD2KNkNobyEq6nqNjSwbr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753842743; c=relaxed/simple;
	bh=Uq7dOcZdKQF9rdH4vzWgpv+kMPGHQKBRdHFzYrcPE2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ee5RH/2vOsPFYMZGD+2OJB2ct/8gxpvbwzJyeEK/Y+tcq3auhTIrU1t3TWy7jWndhVl2aPFdDVQTQJJZzK058NHHHP5SHLsYGYaZKh96KzYhucHK2NM7Hlhrfi050u48PXk+wzZwwaXEE4cBfFAv/i6+sFi4gwNT3t0q7DQs5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA6bwNqj; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-704c5464aecso59838586d6.0
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 19:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753842740; x=1754447540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSdrNqk7apN4PoKxo9JFJtvNeGWmBBKLJgsYG8mDMZU=;
        b=gA6bwNqjA2RgrstCHjIhMm0sOl8/kLiBBIpLFovrtipuBuguk72j2DEiOfM2ZZmUli
         KhK40kqQd5SMSk0snUZLe6N9w2F8K8xpOEqKj2d4dOgqoQePHC/HSclPnIxAw+WE5zDn
         lwOljvt61hKfyR9LXn10AcSq9+iXJJKVsJt4oZiOe0iEDEtvDP9hRPI1rMJgZVHw9ZZy
         Q0+dP7ELdg10dANZhnzKHmx0IaDXEmXdbj3VI1uwP92TyX+VHWLZ+uHuAk1orD+SlqKj
         1LZOiYM5IC/r3mnFFjvdOkSE5EgSVF0HuWp7GwlOMjyZL66GGImO/mJgGNWqJ6SJcheB
         iZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753842740; x=1754447540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSdrNqk7apN4PoKxo9JFJtvNeGWmBBKLJgsYG8mDMZU=;
        b=e1rA1cnmPk6wWtCG7RzFnjbZsb4awNKFC8nQ61db6FetxD56rtE3P6HKx9vNb7lY39
         FBUvOhu2DEnCO3/aDLBbopvr8KQgeuQ/HM3jxmtH50gfdFHgh9AoJqWQOlKwJJuhR06g
         En92iXSfPfUzZx5+0maNLsbN07nlxjYeXfMOf5JvhQV0Bxj9TSxE0GOYdz8ylg5miCK3
         17S5xvWp248RJV8+pN6wQtkIMOBpBSZp3GRgAqYiLmNqi6g0+Os4MUyJukT5knLVInrJ
         XOJnezEabZwM8rjrUyScgbwLE7oE2fbx5CKYresygNHjR8YBJesRgLGvGaMf+TdI1K9F
         vlCA==
X-Forwarded-Encrypted: i=1; AJvYcCUjrmR0YGDYbXZ6P+oYYxrbVVel5KO3pAufxek0JeX8b8V2pRJDvZ/zyBu2oaezrcAzyIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQhlV+ffeiLpyEus6/P/4B5awZrmJyaZ4YXSVEfi8QjZ7BtuY
	ICwZzm6ZaXP4OGKvangKtDOcSvAGsxHVqF9TzVuHz226tdlKZUX3oltojTjq/E+pDVEe5bJh7L7
	YfSzhSf38Aa6ocQZfyW6b0vb0ZGl9QLs=
X-Gm-Gg: ASbGncucklpndXTwKSML8vWDWfidlmnVqmEZ8+yEVgV/pimZZN58yv5HSFEdoq0hhO/
	V986bwlpN3M92w27waMLUtL2MpsKKwBXtU0bwJBgwZ7jJJXmGWonro3A0UgNBFWTNSXCd2LC9lx
	nb5TTYFMFlNOvRXNvniQ9CfL7sO+oRteHSCFBaXOzj0tQTO+fJU9Xex+nQcO7Jb56pos0oGrLOk
	vJDHNM=
X-Google-Smtp-Source: AGHT+IHRf5Cl5qaMXk0K+z+ITU7Etj+RVem/klgU5pn92p08+EgcJfhh6TqXxZMHFoSeOhbUtXNZkG6kszlvkafjTqc=
X-Received: by 2002:a05:6214:f28:b0:707:3d2e:10b1 with SMTP id
 6a1803df08f44-70767114bccmr25338816d6.26.1753842740519; Tue, 29 Jul 2025
 19:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729091807.84310-1-laoar.shao@gmail.com> <08D7155B-84F0-4575-B192-96901CFE690A@nvidia.com>
In-Reply-To: <08D7155B-84F0-4575-B192-96901CFE690A@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Jul 2025 10:31:37 +0800
X-Gm-Features: Ac12FXyVY7VxH-PclNWhwOUz4PaSKOLg-dKTL9OWN12oyQL1HTf3H_qW6d5Jd8k
Message-ID: <CALOAHbDRBs8bdXB_LJjx-7gALOCLvmMxFD+c7MbHAiQ3htXawA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/4] mm, bpf: BPF based THP order selection
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, david@redhat.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 11:08=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 29 Jul 2025, at 5:18, Yafang Shao wrote:
>
> > Background
> > ----------
> >
> > Our production servers consistently configure THP to "never" due to
> > historical incidents caused by its behavior. Key issues include:
> > - Increased Memory Consumption
> >   THP significantly raises overall memory usage, reducing available mem=
ory
> >   for workloads.
> >
> > - Latency Spikes
> >   Random latency spikes occur due to frequent memory compaction trigger=
ed
> >   by THP.
> >
> > - Lack of Fine-Grained Control
> >   THP tuning is globally configured, making it unsuitable for container=
ized
> >   environments. When multiple workloads share a host, enabling THP with=
out
> >   per-workload control leads to unpredictable behavior.
> >
> > Due to these issues, administrators avoid switching to madvise or alway=
s
> > modes=E2=80=94unless per-workload THP control is implemented.
> >
> > To address this, we propose BPF-based THP policy for flexible adjustmen=
t.
> > Additionally, as David mentioned [0], this mechanism can also serve as =
a
>
> The link to [0] is missing. :)

I forgot to add it:
https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@redhat.com/

>
> > policy prototyping tool (test policies via BPF before upstreaming them)=
.
> >
> > Proposed Solution
> > -----------------
> >
> > As suggested by David [0], we introduce a new BPF interface:
> >
> > /**
> >  * @get_suggested_order: Get the suggested highest THP order for alloca=
tion
> >  * @mm: mm_struct associated with the THP allocation
> >  * @tva_flags: TVA flags for current context
> >  *             %TVA_IN_PF: Set when in page fault context
> >  *             Other flags: Reserved for future use
> >  * @order: The highest order being considered for this THP allocation.
> >  *         %PUD_ORDER for PUD-mapped allocations
>
> There is no PUD THP yet and the highest THP order is PMD_ORDER. It is bet=
ter
> to remove the line above to avoid confusion.

Thanks for catching that. I=E2=80=99ll remove it.

>
> >  *         %PMD_ORDER for PMD-mapped allocations
> >  *         %PMD_ORDER - 1 for mTHP allocations
> >  *
> >  * Rerurn: Suggested highest THP order to use for allocation. The retur=
ned
> >  * order will never exceed the input @order value.
> >  */
> > int (*get_suggested_order)(struct mm_struct *mm, unsigned long tva_flag=
s, int order);
> >
> > This interface:
> > - Supports both use cases (per-workload tuning + policy prototyping).
> > - Can be extended with BPF helpers (e.g., for memory pressure awareness=
).
>
> IIRC, your initial RFC works at VMA level, but this patch targets mm leve=
l.
> Is mm sufficient for your use case?

Yes, mm is sufficient for our use cases.
We've already deployed a variant of this patchset in our production
environment, and it has been performing well under our workloads.

> Are you planning to extend the
> BFP interface to VMA in the future? Just curious.

Our use cases don=E2=80=99t currently require the VMA.
We can add it later if a clear need arises.

--
Regards

Yafang

