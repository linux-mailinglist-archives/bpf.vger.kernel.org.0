Return-Path: <bpf+bounces-61961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B3AAEFFAA
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FB216A778
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FB527C162;
	Tue,  1 Jul 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGaaHLIs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021D27935A;
	Tue,  1 Jul 2025 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387117; cv=none; b=HBzRkv32iYY4zxgaeVOwJRB6kO+l8WjUWCR6lTLkVGOihA3FzomhMjuc0k1uM2VrlPt0cbbm8RjwTvXL3guQL6+sjRrt56TJ2wtjpD1j3ZPKt9CcNKihH81s/mjKmU7jTsUssy80b0/tw1hQo7iesbBpfJwIcoRAKQyI5zFrqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387117; c=relaxed/simple;
	bh=5wzV07OONkCcGVSYEmRpzbVKPetUPjrh4BiFdFLy65Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pN0OpyOS48Kj1KGWuHAWXVfye6YrHLw9Aq8ztTiyWSrfUpPbIG+BcST/LHIJM6QZtbNWhEXqkaATnQtw2rW1BVJd8NavKQSKf474LT90grRSYi+/nBX0+E+mzba0lNmtOuqV1z2eZoladzlNoG0eZn2oCNMVs9pGua6MAab69+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGaaHLIs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45363645a8eso41118515e9.1;
        Tue, 01 Jul 2025 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751387114; x=1751991914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wzV07OONkCcGVSYEmRpzbVKPetUPjrh4BiFdFLy65Q=;
        b=RGaaHLIseCOWHPK71dnsnVSEeZPJiUEMFgCX5H/nCRjoFTiYFM3ItTnuPHk5E2vK1Q
         +KSEMw1ORE8Y3sPnGIegXhodOVzBxtBvo48M/QgGyPT26tM5g5RSMpHIDKI1mdORAv00
         vWkhPKongMnVqZacWHUufMxEbcQKaXWcbfuPo40Wa1y3hnBbI8essJ3vrBOnPD+vadeq
         cGS2S5NAoNyc4+nHWJpJjXkcvCzmQFRRZZHtlwBmw2TFS/VjPH5PALJk9R7gaI64Knnb
         qcDmBXn6g95wPIZ4cbaFBFVsNr0LgN/NwsmbpY32I5FXMpznVB2yN+f0n8ezEEfTJP2T
         6Awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387114; x=1751991914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wzV07OONkCcGVSYEmRpzbVKPetUPjrh4BiFdFLy65Q=;
        b=dZXJwhd/dv1QsnLfu07p1tA8P5RImAe/Y9zrGpanUQfcAyDSUQh0W9dMFzoTKo3hLo
         5/xYwtx6xspG1LqsRfIVfBHmYU/zao/ki5eOy0PjV0JQSL97iIfSwxfUMNls0s8yRUtQ
         uQGxl7/2PW4JjxLrwfONfUynGra4GK1b6h1cUrlP48IKhY01+XAIHp72mTH1FclxyA5A
         QujsIvR12O9BuM6b+TwBcSbtw4qrIPXxuYOpSgLwoXA3aXc7Tr/AX3Jt0vn63XNvmdqD
         D4UAe2VxHdv16dTXuLDqfU4AVDZqGZkEKQzvZ4X9w8EF21AVdbHMtUZLHRUj6KDkt1zL
         jeng==
X-Forwarded-Encrypted: i=1; AJvYcCWQJyZsF+zWzumR0zZciX66dvJyAylHvAudfVgKSnbf7/hIkzWqvUQ/SQElMevyCqndwsOzRlOv09OydZJC@vger.kernel.org, AJvYcCX/v4YelcGDZrfDmoEf9w5h8+JM8hLfNk7f8WmeuVsV60/rYlvu2GfM6YhpvEE33WqjcGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vC+5dj5/hBmow8TRsNX0ACwwD7+QwX34ggkig9csrcDaZz/2
	SWds+Dcb/cRG5YuZdad/rZrp7KnXSQBQ70pZAQ2cLRcttSdzdk6sl0qCM/C0BNQGc8XP69s6d76
	SwOZInA3unlT7vrxlWkdg9EfxXAdQ1oA=
X-Gm-Gg: ASbGncvkWszU5Qi3W2KE8ypeuIGpXWH9pQ23xhix4czgbj2uPhXfxWXNZ90rl73PpGn
	hiIJyxfkQWHM6duVz+EEIheIDjC1H5g+4xP0oOxj14a2Ch+KyMfijSeN/tsxQhtidI5WO2RqCq8
	rBxVFUahtiXVRc2cZp3HOe2djVQh1L7yv2848QO9OgABx99EI/X6NPwtH8pUI=
X-Google-Smtp-Source: AGHT+IGrbRuO8nnh6J7e2fn2C9dp4PIQ8S2KOPjswAGJgv02hKqPZh/BsJ/5lrQamHMIxxw8q9iaIkK1Xqmf/umPzGI=
X-Received: by 2002:a05:600c:a11b:b0:453:5d8d:d1b8 with SMTP id
 5b1f17b1804b1-4538ee712f5mr157779215e9.30.1751387113839; Tue, 01 Jul 2025
 09:25:13 -0700 (PDT)
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
 <CAADnVQJgOyBCCySnBkTk-VCsz0dy+ppdGHpggxbtDpBBGhaXVg@mail.gmail.com>
 <CALrw=nFvUwmpjUMYh5iJqjo6SbAO8fZt8pkys7iDjZHfpF2DxQ@mail.gmail.com>
 <CAADnVQLC44+D-FAW=k=iw+RQA057_ohTdwTYePm5PVMY-BEyqw@mail.gmail.com>
 <CAENh_SSduKpUtkW_=L5Gg0PYcgDCpkgX4g+7grm4kxucWmq0Ag@mail.gmail.com>
 <CAADnVQ+_UZ2xUaV-=mb63f+Hy2aVcfC+y9ds1X70tbZhV8W9gw@mail.gmail.com> <CAGis_TUNfUOD3+GdbJn1U33W8wW5pWmASxiMa5e5+5-BqJ-PKw@mail.gmail.com>
In-Reply-To: <CAGis_TUNfUOD3+GdbJn1U33W8wW5pWmASxiMa5e5+5-BqJ-PKw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Jul 2025 09:25:00 -0700
X-Gm-Features: Ac12FXwru2RjEeaSQs6NLU8YH1f68FRveHhLdYSTc7Dp87lT_tm2nHkVaU2Cv1A
Message-ID: <CAADnVQJp-AtrRj_XESbE5TUj6_dGNDwpRWwu2vEHv1HGOb4Fdw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Matt Fleming <mfleming@cloudflare.com>
Cc: Matt Fleming <matt@readmodwrite.com>, Ignat Korchagin <ignat@cloudflare.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 6:28=E2=80=AFAM Matt Fleming <mfleming@cloudflare.c=
om> wrote:
>
> On Fri, 27 Jun 2025 at 20:36, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Good. Now you see my point, right?
> > The cond_resched() doesn't fix the issue.
> > 1hr to free a trie of 100M elements is horrible.
> > Try 100M kmalloc/kfree to see that slab is not the issue.
> > trie_free() algorithm is to blame. It doesn't need to start
> > from the root for every element. Fix the root cause.
>
> It doesn't take an hour to free 100M entries, the table showed it
> takes about a minute (67 or 62 seconds).

yeah. I misread the numbers.

> I never claimed that kmalloc/kfree was at fault. I said that the loop
> in trie_free() has no preemption, and that's a problem with tries with
> millions of entries.
>
> Of course, rewriting the algorithm used in the lpm trie code would
> make this less of an issue. But this would require a major rework.
> It's not as simple as improving trie_free() alone. FWIW I tried using
> a recursive algorithm in trie_free() and the results are slightly
> better, but it still takes multiple seconds to free 10M entries (4.3s)
> and under a minute for 100M (56.7s). To fix this properly it's
> necessary to use more than two children per node to reduce the height
> of the trie.

What is the height of 100m tree ?

What kind of "recursive algo" you have in mind?
Could you try to keep a stack of nodes visited and once leaf is
freed pop a node and continue walking.
Then total height won't be a factor.
The stack would need to be kmalloc-ed, of course,
but still should be faster than walking from the root.

> And in the meantime, anyone who uses maps with millions
> of entries is gonna have the kthread spin in a loop without
> preemption.

Yes, because judging by this thread I don't believe you'll come
back and fix it properly.
I'd rather have this acute pain bothering somebody to fix it
for good instead of papering over.

