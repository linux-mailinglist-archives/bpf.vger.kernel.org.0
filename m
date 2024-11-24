Return-Path: <bpf+bounces-45546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74F19D7807
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 20:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5656C1630C9
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 19:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B79157E9F;
	Sun, 24 Nov 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bigX6Htv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC93F9D2
	for <bpf@vger.kernel.org>; Sun, 24 Nov 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732478230; cv=none; b=MVyrQhhaiUaR5Im7mdN23QTAGDiFclLY1VYrBq0XVkFqeQE7WFR+qIUCFRrGFroq5UIqK0y0v9Y5g3NNX5iGduqoiuPfG7xW55b2e0bOgeqZQ7mXQxVnb3mGzhJnLC17VTQY6KVAPmQyvJI8CErwZLMVla61//i4Tqd2yabqTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732478230; c=relaxed/simple;
	bh=OcNnfOETQ9CK3MaYLJJ9ZxKWUCVW7lfZvl2yfrAIWII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtjU0VHieES+CyrHnxC8xFk4qGbesHozN8mBNAhdxm9QJDYaYxXMT6zyJn0wWDlU7IfIl3sIr56MdgB5Xy/Ah+Opr8PdFKBY8rBXcP+WfWUp4uVvWpDy4krg3OIJ4CzkyfjPOBJVNdska7Wa6bCTkjGxWGOKxGJsEvxFV2pnDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bigX6Htv; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4668caacfb2so77611cf.0
        for <bpf@vger.kernel.org>; Sun, 24 Nov 2024 11:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732478228; x=1733083028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydgtc14DZFpEcBW19X27uxPsYRsPBfImUkfn8msMgnw=;
        b=bigX6HtvT9fuCWuWZ83Jx0Fg+7XOhz6PShXKo3XZNKAfm/JDYKy/mPjTBdpJMw2Glo
         XZFSph4FUfuVs/Rz+xwpd1QjNhG/7LHYFhGoC/qT0DeEzIHwefhOS5hw5R/1SzZVwcdK
         JOSRpyogg9ilDV6P4U03r6pXq9f6z3Ps45X0cH02jnjCZwQQMCZ3Oiu9nrHCBixQGjob
         kDRgfkwkUkJ7UhtNSg9T3xjkyWzOIdKbZr/4fODJD0Uz0Yzv2DIZcQJFKBpoiAYObFqq
         66qVIpAV9PH1h0MjGyEJEcYDY1euSb7sjZXfxMVcD6nRF/Sk4UlWJmqHfR0UOavOQNsK
         mQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732478228; x=1733083028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydgtc14DZFpEcBW19X27uxPsYRsPBfImUkfn8msMgnw=;
        b=Ra7SF0bNcU/Uv46BTgrevXMTodEz7/btQp3YVYeg89wxLqhxRf/ecQf01uWbrLG9g9
         RjSde9WFM5MTrqxlu/RzZAagJYKHndnnJYnTIp4jBa3yVGaM652jEjLGE8ax9d8WJtPg
         lwRgV1p6YzRoF+v93Qj4JFtXxHDX+fXf7Fol1EnUjpH/3qkXkc60Jm/rXU5wHAesjgDY
         kpSPSPB1z+YaoQ+AAyOSPePe/R/zwbUWMpVXpDzeVu7e9aVbNbxinPCOToNu9rds7KzP
         YvNPA9WkppoZFmNdYen2XyJRbWJQMtwon5WsXNe3CDawGPppbFsaH8WzHtiA3auEUORg
         sOIA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ86vTLf2BkMcNiW2sSVnGDW+hEC0u+7YvBHmMSGh/MK/6+6jrqPxfBVgI0BliFEn9UaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7hWzvYKUF4V/yuEhq3IjcJFaiZAZndCS3YLX7FbD5S3if32A
	ybjR9NetoNvEUT80mRSKUxzhlXRNL916deoI2W/E0QcTtD0c0U/LlrLBDR597Doh9Ls9JFc3Udf
	rLtVTRYc91vHNtuuvBgK0xgvJe1Lj/mPuigXe
X-Gm-Gg: ASbGncsc08FZraaBwwtqWJjI/a65csFxwKkfPw3ZumcixQaM+rOG9KRlMsNDky8id4b
	hc3mkyLlkAkoQnpiMkNQ2ekeV+2msQDEutKctzHcWJw2HKXHgIhVZQO3m923T2g==
X-Google-Smtp-Source: AGHT+IEA0e8lCBFPAtVyOffPIrAlSanvsYtSOuzXTjPA1NcAopy48+uF2AbLjCTIrBPX0rYRUwiU7jwTUnp1FXB3rug=
X-Received: by 2002:ac8:660f:0:b0:466:861a:f633 with SMTP id
 d75a77b69052e-466861af6a1mr1683291cf.5.1732478227528; Sun, 24 Nov 2024
 11:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122035922.3321100-1-andrii@kernel.org> <20241122110737.GP24774@noisy.programming.kicks-ass.net>
 <CAJuCfpFvHwjMDdFGjCfg+fta2=Ccif7XReTH6TpC+V+PZ1JmAQ@mail.gmail.com>
 <CAJuCfpFy27B3B=4QvATTzaM44Ferf1scbt0JCdrCdj2gzo52+A@mail.gmail.com> <20241123203543.GC20633@noisy.programming.kicks-ass.net>
In-Reply-To: <20241123203543.GC20633@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 24 Nov 2024 11:56:56 -0800
Message-ID: <CAJuCfpGM7rX6EBLSpjY-go1N-mbc_ObgjeggTLgE4rOR4mXDDA@mail.gmail.com>
Subject: Re: [PATCH v5 tip/perf/core 0/2] uprobes: speculative lockless
 VMA-to-uprobe lookup
To: akpm@linux-foundation.org, Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mingo@kernel.org, torvalds@linux-foundation.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, david@redhat.com, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 12:35=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Nov 22, 2024 at 09:48:11AM -0800, Suren Baghdasaryan wrote:
> > On Fri, Nov 22, 2024 at 7:04=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Fri, Nov 22, 2024 at 3:07=E2=80=AFAM Peter Zijlstra <peterz@infrad=
ead.org> wrote:
> > > >
> > > > On Thu, Nov 21, 2024 at 07:59:20PM -0800, Andrii Nakryiko wrote:
> > > >
> > > > > Andrii Nakryiko (2):
> > > > >   uprobes: simplify find_active_uprobe_rcu() VMA checks
> > > > >   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolu=
tion
> > > >
> > > > Thanks, assuming Suren is okay with me carrying his patches through=
 tip,
> > > > I'll make this land in tip/perf/core after -rc1.
> > >
> > > No objections from me. Thanks!
> >
> > I just fixed a build issue in one of my patches for an odd config, so
> > please use the latest version of the patchset from here:
> > https://lore.kernel.org/all/20241122174416.1367052-1-surenb@google.com/
>
> updated, thanks!

Hi Andrew,
I just noticed that patches from an old version of my patchset are
present in mm-unstable, more specifically these two:

fb23aacd2a14 "mm: convert mm_lock_seq to a proper seqcount"
549aeb99ccf1 "mm: introduce mmap_lock_speculation_{begin|end}"

Peter will be merging the latest version into tip/perf/core, so this
will cause a conflict at some point.
It should be easy to update them in mm-unstable to the latest version
[1]. I was able to revert the old ones and apply the new ones without
any merge conflict. If possible, please update them instead of
dropping them from mm-unstable. Some patches I'm preparing to post
have dependencies on this patchset.
Thanks,
Suren.

[1] https://lore.kernel.org/all/20241122174416.1367052-1-surenb@google.com/

