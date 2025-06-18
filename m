Return-Path: <bpf+bounces-60946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB7ADF034
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE981899CCF
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194A43214;
	Wed, 18 Jun 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brdIY/DW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3C2ED85A;
	Wed, 18 Jun 2025 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258252; cv=none; b=LFFBkOcxi7vitNW9w/oBM8DAa/WtmvxVK0XjK4cRl+BvfE/7b5zktk6LRK9kImA9T45qpX47soC1bFs5IfzwCNziM+yqPp95smb4XqD5B7cwUcdTIdVW+zJNunL/Lu8PMLJG58noSmUEx6h3YnAd003GefX1GeWXTFUupjBbAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258252; c=relaxed/simple;
	bh=9HaC2NQTM7GTNJbd33+8vU8wC2Lh0yO+Z0sFSNhpIhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBHv8Dus9vWUcVboaecBt8e1ydtLQJnVebZyTd6vYaksyWxYwZ1qlev6v6Lb9OdAevcmbsnxLj4GljASxsFUtQM3iIx10k411qzxk6CWgvOebFso4vb6MJIvlpYkbd5hmCzcxmIwv1yAkVVKCnHwU+esENeDV7kzjhQ7aFfH8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brdIY/DW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so8000145e9.1;
        Wed, 18 Jun 2025 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750258249; x=1750863049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HaC2NQTM7GTNJbd33+8vU8wC2Lh0yO+Z0sFSNhpIhI=;
        b=brdIY/DW9Ub0AA9v+JsRbCzGCrVkTaEmuT5TUX5qyOJToMFDiJEu8lWospfw49BOtg
         IQS7ngMBU03nSBKdf14Wb/4ggHJFS1Uh2hKo4xAwnL3roRFXELF0YQ4otXcEcB+FpsS3
         zFtceXCApFrhdyN/Q9pzYbhq5uIuY2fZG8zxSJOarnMao9DLSdIXl3I0HC5JlAKe9JSP
         tOKxz0fCzCtQ/4m/tbeqzQy/nwZYhxyliFm8wHjdHe7EKyDiQB09MRBbNJHy9jw8QuYF
         NPPf9myCc0gqGdtrUN2I8Dp0T1x9V26Hvw+04Rbny1HvPINpmsdwZ61s+Ti561cGbGSx
         mf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750258249; x=1750863049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HaC2NQTM7GTNJbd33+8vU8wC2Lh0yO+Z0sFSNhpIhI=;
        b=I/9SbkjYTAnbo2qqU4IHLfNuZ9Lglsoo6MdZXsnFkjidzge2w1DdqRNBwZam3aV1yV
         RDnaJz0h6rp3z7zz/0dYypGpKkNp7vISImFcmYyyZClJt5XjVHYi6d9T/f66Xk6eigTb
         zuJlqIRH6EsTANiwFFnf+o+X5TD2vLThfFxGTkkNHZDvoXkmvdM6SxnhlSeEeCcGv2V+
         /ZRj/fPyxfzvyfzIU4HgGPyC7xhw7b9O0hXBWajbqpL8J+kQmDjpsNlKfWxUTPFNaO0O
         V75Kb7UT4kxzbflLXL6ZXa6IEYElC+PuJpoteJNpozMoVnfXxtugUwult++EqZ6AyuXc
         Oa2g==
X-Forwarded-Encrypted: i=1; AJvYcCUj9QbW9jL87tNkRA5DzopfFISWP+ByUKZa/ANpP5jacchR0loTD4CB6L0W3Vzn9VxvUCc=@vger.kernel.org, AJvYcCVlDAY5b3QpTWFzbrqDt6ERRyayhn7ZwMdnyQdC3qgLcw4m3zR83CfpatMciPlc4tynypZldkEMkr2sMpBr@vger.kernel.org
X-Gm-Message-State: AOJu0YwYShtuGkU6jQDZQtbSxmqPeqq5dyRHwLPvNziYt3+wBgRbF69M
	r2kkOQlp56xz4pgt2+Q8cJKjayMAGh1BHbd/BbJkDbwOuC+OIbOVspjumJYnID5Y7dEOdSgvYTd
	906ScqLYMfsdOPARaVoIJgoJRYeHxZJk=
X-Gm-Gg: ASbGnctJ8ZUTJqIuhoYUfTAyIaRczPqLYDM+pBzxdVprATjKWp0EAsMWVp8fqXh5GC3
	y1CoR24y/Oi85jXKb79Fbovq3vICNtJu1+v2eCtIcawvOuEjMXWUNc3UNZFSxKKxQgJJ44aYo71
	m67blC/NefSa8Y+HZ8XkMYbi7zK+d11rw0aJiJjNBuyX/ItwUsx2qHTHZsWLNjSpU76MJBTb5/
X-Google-Smtp-Source: AGHT+IFoPZ0DAlnH34Pa6n3MttNWFK7c0HXdjpa4JHfhHwi/OEjHcpriuqUIfeqMsgjdw+xh9YvN7blgShmDwgfPKYo=
X-Received: by 2002:a05:600c:8287:b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-453599a109dmr29795215e9.15.1750258248845; Wed, 18 Jun 2025
 07:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095532.47020-1-matt@readmodwrite.com> <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
 <CAENh_SQPLHC8pswTRoqh0bQR84HHQmnO3bM07UQa1Xu9uY_3WA@mail.gmail.com>
 <CAADnVQ+QyPqi7XJ2p=S9FVDbOxMXvVPU859n+2ApuRQv5T2S5w@mail.gmail.com>
 <CAENh_SQgZ5yVpshKRhiezhGMDAMvgV7SmwD_8u++mACE33oNrg@mail.gmail.com>
 <CAADnVQJgOyBCCySnBkTk-VCsz0dy+ppdGHpggxbtDpBBGhaXVg@mail.gmail.com> <CALrw=nFvUwmpjUMYh5iJqjo6SbAO8fZt8pkys7iDjZHfpF2DxQ@mail.gmail.com>
In-Reply-To: <CALrw=nFvUwmpjUMYh5iJqjo6SbAO8fZt8pkys7iDjZHfpF2DxQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 07:50:37 -0700
X-Gm-Features: Ac12FXwobw6UXl7yYxUqScon6Dyrzab3N1zaSVWH6cugusbksfKMWLjtdWBXyYM
Message-ID: <CAADnVQLC44+D-FAW=k=iw+RQA057_ohTdwTYePm5PVMY-BEyqw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Matt Fleming <matt@readmodwrite.com>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Matt Fleming <mfleming@cloudflare.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 7:27=E2=80=AFAM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> On Wed, Jun 18, 2025 at 3:01=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jun 18, 2025 at 5:29=E2=80=AFAM Matt Fleming <matt@readmodwrite=
.com> wrote:
> > >
> > > On Tue, Jun 17, 2025 at 4:55=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Jun 17, 2025 at 2:43=E2=80=AFAM Matt Fleming <matt@readmodw=
rite.com> wrote:
> > > > >
> > > >
> > > > > soft lockup - CPU#41 stuck for 76s
> > > >
> > > > How many elements are in the trie that it takes 76 seconds??
> > >
> > > We run our maps with potentially millions of entries, so it's the siz=
e
> > > of the map plus the fact that kfree() does more work with KASAN that
> > > triggers this for us.
> > >
> > > > I feel the issue is different.
> > > > It seems the trie_free() algorithm doesn't scale.
> > > > Pls share a full reproducer.
> > >
> > > Yes, the scalability of the algorithm is also an issue. Jesper (CC'd)
> > > had some thoughts on this.
> > >
> > > But regardless, it seems like a bad idea to have an unbounded loop
> > > inside the kernel that processes user-controlled data.
> >
> > 1M kfree should still be very fast even with kasan, lockdep, etc.
> > 76 seconds is an algorithm problem. Address the root cause.
>
> What if later we have 1G? 100G? Apart from the root cause we still
> have "scalability concerns" unless we can somehow reimplement this as
> O(1)

Do your homework pls.
Set max_entries to 100G and report back.
Then set max_entries to 1G _with_ cond_rescehd() hack and report back.

