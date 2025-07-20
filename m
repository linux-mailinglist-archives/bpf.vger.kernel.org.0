Return-Path: <bpf+bounces-63813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA4FB0B33C
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 04:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799E41899EB5
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 02:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B28186295;
	Sun, 20 Jul 2025 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6+HLAYG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E921F92E
	for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752980103; cv=none; b=eizi1SD8yR2/p4YtdXF3TvIZQtFlBmaRlnbE0kjMUcHJ4MA7ejwrwayVlKkn437/mOaUzt93BhmVXIS7pUatTkm1PETdmJ4T3WbkkA80+KdtUGe71eV/kdDbIrU6vPamS/LfugR9DVamYu/tLU+3IgF/+UCeOZ9O+9HrDhlPtmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752980103; c=relaxed/simple;
	bh=HsqlUK9IcawsXFGZJn5QHWBgxU/P+xsKtXzIPnS25TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Td5O6+yvGIuqV1gow3VgrIGuacyv/ltjqdlT4pkBmjLmZZLlHDNZGdJ5xCA/7iS689Y5NwQFhCtwfaN6MnSyUK90gORxrPlWOsrHMSq/9jB3xxk1MZj/Ys4YkIH8IQol9VRoO6ciD6+7DvCspVjDQIjOf7Za9v1AI2HX1BV9Oos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6+HLAYG; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70478ba562aso45580156d6.1
        for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 19:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752980101; x=1753584901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX11vKBCysocgHYMHohidSw+dzLEB1lgHwI3wsOdYSo=;
        b=N6+HLAYGB2cv+4Tc/StqyQWEtzjgf9E9W9dQBL3bThYBh0YnI4KV2t4MfnlzUlhqUW
         p4djtB36q2mzAmx2d5r9IuJ0AFkAiJ8PHmJIXS2/ikRI8JViarCbOtnF4I1F7PLjAfhy
         glc43H9c9FjlWmEsso2iWDzLiZa86LcEMR6O9uavi/aKTsxW2UlZDJmKGhRc6YGN800x
         TE9GjxJQ5oXF+1dP5YIyXW//RbHn8F0dmrj8nYeHWQ02+WEY5x1+D3d/GhWrRre/eqeF
         QgVDbigWr+82i5GId0Ojb7K4lmsqa+GRzyrt3RevSPgsudRauRaw1I0DAskbws1R9KBj
         Pwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752980101; x=1753584901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zX11vKBCysocgHYMHohidSw+dzLEB1lgHwI3wsOdYSo=;
        b=CVD+BaYsCD9EDYNk0yMlUgoHvbN84YToQgeqjEKcUGV6Oa1STt/h1Dmr4MIAR0K7tA
         p83F9PGsUlFnJQ6Ss2I5rQh4zVmq0yZ2hkTFOVLrMGVGqIXcZdcCJOLHn9MoMtHogsXN
         C2SCaXxyOFmhTFC5pd6JD/xcqwdaOHfvRoUwjWfM9UFlLyO6agVEoDDyIKmuItJbuay+
         0gtKmP9J99tFCyI4BwizHynEvhJ3uHyV9PHye+T5ky+gTM5NA+34IxKoae8kqZ849Exm
         +ow8HRoZi1Z5nXYP73NWgApFtMewlr16VcADMd//SCH7Y4F+kW1+8dM/IwqRj4fAZEPL
         Dljg==
X-Forwarded-Encrypted: i=1; AJvYcCWPC+rFPtIy6lp1i8E36JsD4WqJTdOyL3ZvWB4Mg5F5/eYUlPHwr8IkrCsPSzOBYsc+4tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/AUSYYfYDo6OJElv8dcG2dc9ULgkAB//jqkjzmsrLApVk7b3N
	bQ4tbhUOdTgQMJXzj4Q+DZnlfpfUzbiPsHUoafjulvIy4OqCerIe18LireHjI8P0qkYuI9Oqzdt
	vTmQFe6k2RjW3EUXNX+ixAsi2R5pGhB4=
X-Gm-Gg: ASbGncsA8oZhrzHJZHLURJQrEpt/GS36qRoQJk7f7BYAfP3hLZSWXLJ21xDjIdR3gMu
	kTdY9jJGLgbKULcjunBGUR2MNXmn5HNdMthPTSqwcStHfFYJqQsrwMIo+RAwCwTz2JGHdS85IRv
	GOO+tOEmTqfkDD0uXJ3NJO7EL/OWSnOVF0dtxTcBIjHk8V9rcyRBYz0v9E9/XYtr5pw59AbV90I
	wOzGNPh
X-Google-Smtp-Source: AGHT+IEqkxzgL3EifIuDK9+PCSK5zzRyf16sBt79/kqd17Yc5iGkL2o8zWNznA2b4zWQHRCwfFIU60yjNfcoa1HjMuQ=
X-Received: by 2002:a05:6214:8112:b0:705:1833:b445 with SMTP id
 6a1803df08f44-70518341985mr75698986d6.4.1752980101076; Sat, 19 Jul 2025
 19:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608073516.22415-1-laoar.shao@gmail.com> <e14b70a8-e49b-47e2-ad0c-f60c81363d3d@gmail.com>
In-Reply-To: <e14b70a8-e49b-47e2-ad0c-f60c81363d3d@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 20 Jul 2025 10:54:25 +0800
X-Gm-Features: Ac12FXyER6L12_yClzX9RR80E5woyEpL84py-f44N5D49vf9tZtBvezTgzP_yEo
Message-ID: <CALOAHbDYHqsTDO1sxtcW=7iOwjxcP=oNpNswTv=B6_JmsHWtsg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 12:35=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 08/06/2025 08:35, Yafang Shao wrote:
> > Background
> > ----------
> >
> > We have consistently configured THP to "never" on our production server=
s
> > due to past incidents caused by its behavior:
> >
> > - Increased memory consumption
> >   THP significantly raises overall memory usage.
> >
> > - Latency spikes
> >   Random latency spikes occur due to more frequent memory compaction
> >   activity triggered by THP.
> >
> > - Lack of Fine-Grained Control
> >   THP tuning knobs are globally configured, making them unsuitable for
> >   containerized environments. When different workloads run on the same
> >   host, enabling THP globally (without per-workload control) can cause
> >   unpredictable behavior.
> >
> > Due to these issues, system administrators remain hesitant to switch to
> > "madvise" or "always" modes=E2=80=94unless finer-grained control over T=
HP
> > behavior is implemented.
> >
>
> Would this solution work and be carried over in fork+exec? As that is som=
ething
> which is very common. How would that look like?

The current implementation doesn't handle the fork+exec case properly.
I've developed an updated version that addresses this issue, though I
haven't submitted it for review yet.

In the new version:
khugepaged_fork() will verify process eligibility before entering
__khugepaged_enter()
If a parent process loses THP allocation privileges:
1. its child processes will skip __khugepaged_enter()
2. it will be removed from the khugepaged mm_slot.
3. the MMF_VM_HUGEPAGE will be cleared

--=20
Regards
Yafang

