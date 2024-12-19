Return-Path: <bpf+bounces-47293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6399F71D8
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 02:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C101B16958B
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 01:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2328B4500E;
	Thu, 19 Dec 2024 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKfb5OlJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9FF9CB
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572399; cv=none; b=AuM7+py6J5h6+r3VWyt7t/ZERoKEiGnnzYdHXtlDW2bTuW0Mx3V6IZRsZRIi3s949Kr8XxsUfQhdzKCEVf2J8ZNFA2S57IYZbBjkzPG/H1cgRZIlMqHkvdqh6F4Pk+vJQ7fhXq1J6RY1Q7aFV6J3JdvejUPWAw7zodwTbEaQwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572399; c=relaxed/simple;
	bh=kofRsHpczc2z0NBl3qTzW651rG6Z8dK+5jhzyxHZ2rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8nUlUsAW53ElYxwpPCIkujDAWzPBZAvO10So+NWod/kpNtnmr1n49aTIJDtOHATr7DZ+0OEIMxoFRqfQPXpXFCzPUksczcNN/eExSqoTiuuOYaFZsUGZWUb8Boz3pWjp1/mV7EKsy8ewtszpiHpbF/Sr1cJE2lWX3ARwIR5FdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKfb5OlJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4363ae65100so2874745e9.0
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 17:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734572396; x=1735177196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIanLcOq3Af40GkznAxirIMQvdcHNchns+zH2x9+x8o=;
        b=XKfb5OlJcEco7TfpDr5yCQdn6q6SnsB6DCCKrTaBfO4BcnJODS2B9Wpk7Gb7Y7L/yW
         qQ962mCD5tKKafYTE4kyEoqZLfNHePvPiafKRvNufhpUHX481wnnGRkbGZoQKLmX71pL
         t6/oW73IAhmwA9+gXyS9TY5/ZT3B3m4XjmF9soYcKSDdNbiEDnFb3BLnhMGzDr4HXKCW
         GytkX3z8nb0eweoccjr7TUaUBF00/FzpRV+AC/M6n6yeUsUyHXJdB+SNYpb/rDlZAnbn
         HO5M0AZOP7VLszeOIZfLpqumcuwBg6rON9paGnd1ep5O1GA65VALddrwnVbA7wscnAbd
         QAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572396; x=1735177196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIanLcOq3Af40GkznAxirIMQvdcHNchns+zH2x9+x8o=;
        b=mUAdBBiJZlEC94D2AMu33yxbOrGUcgy5E6qPZaZNB+E8xJwJQ8BJYTGsdpLTLj+RJp
         4LCfjb1+si65CU0EXVFGL5WEX9DURYJYNJPK0YBGkPi5TssLTHrLZo5d6+s1i+5vkkZk
         Sekj3YkX0SP9CKiwj36FYUZ9VdX0lnSucSU+3lDMEz8cOuEsZw3HUgCDpQuHHvV3S2gP
         crvdf4zxc8UeZMqGQz370w5tIviS5sCKkdvbFcWsIsUWjmHm8XJ5JPYWPGsIaeP7q5jX
         OKQzrbdbGaVhXPzLpxRQhhVi3QL15apBWKwgpVDkvV2RSEnyLEC8pjQd9an5NV8aoIp9
         R6ww==
X-Gm-Message-State: AOJu0YxN2wrofZ/R8fEkvGwXCOENfnImtJ36kPpsuUGjUg388fdpo7lF
	qwhhJKoEURCPoM8S15ZLDict8FxBA/ochWiXEhxyhUBHDusdKSuANxZ+3HBxRxilqTt9/dE8ZeC
	efRYor0MbTIawv4hk20yGCpM5bvQ=
X-Gm-Gg: ASbGnctlJypr0M2gVgmMOHXAa5YwPP31B16Uxd13vPFILfa+6RitO0X8gs9st65apAo
	aCky3MhiK71iFEVTq/R2ZFIrrgi1Ie0YEXyfckQ==
X-Google-Smtp-Source: AGHT+IF3dFfOO0TIrtwz8TCYiBRhZ+KUwMcUZ3/P0P3t4/C80fOfJRLBqabY0cJnZEDL3JVXFZuBL1D82TnQ23Qzb20=
X-Received: by 2002:a5d:47af:0:b0:385:e394:37ed with SMTP id
 ffacd0b85a97d-38a19b050bbmr1503603f8f.18.1734572396140; Wed, 18 Dec 2024
 17:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-2-alexei.starovoitov@gmail.com> <wupsauixn4cqn63dvgbrxuwaupslmwgxsffiwmfilu5fnkutj4@55v65liewmfn>
In-Reply-To: <wupsauixn4cqn63dvgbrxuwaupslmwgxsffiwmfilu5fnkutj4@55v65liewmfn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Dec 2024 17:39:45 -0800
Message-ID: <CAADnVQKURB1wsGWE17k_ui9mfREXd8FoTw0PXkCGgT3STH072g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, 
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 4:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Dec 17, 2024 at 07:07:14PM -0800, alexei.starovoitov@gmail.com wr=
ote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> [...]
> > +
> > +struct page *try_alloc_pages_noprof(int nid, unsigned int order)
> > +{
> > +     gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_ZERO |
> > +                       __GFP_NOMEMALLOC | __GFP_TRYLOCK;
>
> I think the above needs a comment to be more clear. Basically why zero,
> nomemalloc and no warn? Otherwise this looks good. I don't have a strong
> opinion on __GFP_TRYLOCK and maybe just ALLOC_TRYLOCK would be good
> enough.

__GFP_NOWARN is what bpf uses almost everywhere. There is never a reason
to warn. Also warn means printk() which is unsafe from various places.
Cannot really use printk_deferred_enter() either. The running ctx is unknow=
n.

__GFP_ZERO is to make sure that call to kmsan_alloc_page() is safe
and it's necessary for bpf anyway.

Initially __GFP_NOMEMALLOC was added to avoid ALLOC_HIGHATOMIC paths
when __alloc_pages_slowpath() was still there in try_alloc_pages().
Later the slowpath was removed, but I left __GFP_NOMEMALLOC
as a self-explanatory statement that try_alloc_pages()
doesn't want to deplete reserves.

I'll add a comment in the next version.

