Return-Path: <bpf+bounces-45296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E979D4159
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 18:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC4CB36FE2
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0890218660C;
	Wed, 20 Nov 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpTvxnFG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663B19E82A;
	Wed, 20 Nov 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123408; cv=none; b=PR627+tWdJ7+2BE6NOCmzI5+cQu25915nGlgiSWkiEWmxbGxcYoh3Ljl+VGvYT+gQ+R6AmE75C+mhFyC656DMWPVX5xL2HIr56RTeDPCF3K4zfKufr6isTXDfD44gBxv0rsEkDJhrcs45PeTSZMJ+WOYGjGT0UhMZ4uRCE5WbK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123408; c=relaxed/simple;
	bh=WPjlW3G22oxYPA//YNtFl/VzA6ErTKX/duX9P/vcjeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkNRMnBB1ZCj5AEEMUU9lE0tP/3cwcsOx81/oE1HEdTYWkS93mcyKlIdRj8bzwbYwNWevpKVIqL5d/jttWzesMGaAhCvcOH3FeI42hChCz6ghzYP1PL11w5mA+nZttMOeta3jQlpmiJV7LCPbJbIg1Y+6iInTqJZRmZBorKBTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpTvxnFG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e3d523a24dso44315a91.0;
        Wed, 20 Nov 2024 09:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732123406; x=1732728206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFHW1yuZZLm+TyLZbm5x3CLYzm52WpF6KpYXZUZOuxg=;
        b=NpTvxnFGsFCRFNVHvS1T5mTGGXsbw37/vwD/l58ABPGJC3jicsos0/ITUVxkPn1mUG
         SYeT8q6ug3xWaV6zDbQQ4uRK7sWt21XsRQKUpUiWK7KftWkrKn5OYQT1+1maaTAzkqbR
         yRI6tqMBKMi/WLALGJr7AFzgwgs1crU7T44dvCE5Utdcc5gCbC1529GBntHQYf6Hyx1x
         hkmIQ3rSs4RbG8rW2WuHsD730oNgrk15fMdRED+C8Gfepy0I0KXt6Luerx+A0Z3pjHe8
         MsJrWWITjyBXnW+blkPWaLc6UGm88C9RW5j9zlGwRXI6GqilDIuSxhvEDxQ4wtzfe9WR
         q6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732123406; x=1732728206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFHW1yuZZLm+TyLZbm5x3CLYzm52WpF6KpYXZUZOuxg=;
        b=bGbyP0NVuDjvIRnjCHz2HDCSejvKo6xzitzsNHu8bZAZPS56INFGBfZbXdz+er7RLN
         6FZStf5WIuT0ZkbYru05VQl/hQ4uF94WTmkfQZiYGctIYiGGNh/QMx8IA2viqW39IKTD
         eMKFtHMK9Z/+MSA3bt0jXQvY77GrHEAC+tm/+YVuZsMO3drRPNdullpboyScanthrGKO
         oqO7l35zUGhkgNfk3AcJzUYmacRsX1Ev7LLJj0oV008gzcVjjYNxVkfgHUAcwD4fFR26
         GEogBmWjgTSuBc6l0YvvxVht8jjuI0eU2wvx6l1qd5Czy6ILKLap9duL7wlhawNVzioY
         6jAw==
X-Forwarded-Encrypted: i=1; AJvYcCUHruPJIJFRXLTHDgGrhbj06glDeNWtzM+yNw0TwJD8ANg4sa4U1Ga+Y89MdyalsBo+TGKFHSHovk+IHLMq@vger.kernel.org, AJvYcCUnU7R6WrJNRCBbz2NfF2t93ZSYMKmNxRWDCAiJtdqI3qa/V+VvBMcGo05QCPibqe9SuVXqMuqFc4I2DnO5owN5keY5@vger.kernel.org, AJvYcCXMKmQXsNEC7YxkexhYLVEf1ZuHfo/PPqw28wa9MlL5YicL8SAxxBkAR585xZ56GwMnH5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwuqinuMjCSdS5fs2DB2OcxviFIvrnZmIeKMgQyb/MhecX2TqI
	U/mM1x9vl11mGIcu51TxgrexHtTpH2inz0otuLbE5wwwSRtplNDvYCbjsTLjqN+wJFhuJa+DaWj
	GUE6wYqrnx2YlvR+qlXuXByhGgf4=
X-Google-Smtp-Source: AGHT+IHmU99QzKqQHpCseY8baqlMhIw/oJlWpRrEPSQmFS/0a2TRodl3EStY/QfZqpeLzWRchDtrlaIkbPnx9yZ9EXY=
X-Received: by 2002:a17:90b:4a4a:b0:2ea:853b:2761 with SMTP id
 98e67ed59e1d1-2eaca7e6a5fmr4440543a91.37.1732123406448; Wed, 20 Nov 2024
 09:23:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <CAEf4BzYPajbgyvcvm7z1EiPgkee1D1r=a8gaqxzd7k13gh9Uzw@mail.gmail.com>
 <CAEf4Bza=pwrZvd+3dz-a7eiAQMk9rwBDO1Kk_iwXSCM70CAARw@mail.gmail.com>
 <CAEf4BzbiZT5mZrQp3EDY688PzAnLV5DrqGQdx6Pzo6oGZ2KCXQ@mail.gmail.com> <20241120154323.GA24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241120154323.GA24774@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Nov 2024 09:23:14 -0800
Message-ID: <CAEf4BzaVCg6LcqT8i60ZpZ6Qz3+xMMp_HY1ao4-UtARTPMb=Lg@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 0/4] uprobes,mm: speculative lockless
 VMA-to-uprobe lookup
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, vbabka@suse.cz, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	david@redhat.com, arnd@arndb.de, richard.weiyang@gmail.com, 
	zhangpeng.00@bytedance.com, linmiaohe@huawei.com, viro@zeniv.linux.org.uk, 
	hca@linux.ibm.com, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 7:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Nov 20, 2024 at 07:40:15AM -0800, Andrii Nakryiko wrote:
> > Linus,
> >
> > I'm not sure what's going on here, this patch set seems to be in some
> > sort of "ignore list" on Peter's side with no indication on its
> > destiny.
>
> *sigh* it is not, but my inbox is like drinking from a firehose :/

Yet, you had time to look at and reply to much more recent patch sets
(e.g., [0] and [1], which landed 5 and 3 days ago).

And to be clear, your reviews and input there is appreciated, but
there has to be some wider timeliness and fairness here. This
particular patch set has been ready for a month, it's not that much
time to apply patches. Liao's patch set is even more stale. And for
the latter one I did give you a ping as well ([2]), just in case it
slipped through the cracks. That wasn't enough, unfortunately.

I'm not going to advise you on handling emails out of respect, sorry.
I'm sure you can figure it out. But if you feel overloaded and
overwhelmed, consider not *gaining* more responsibilities, like what
happened with the uprobe subsystem ([2]). Work can be shared,
delegated, and, sometimes, maybe just be "let go" and trust others to
do the right thing.

  [0] https://lore.kernel.org/bpf/20241116194202.GR22801@noisy.programming.=
kicks-ass.net/
  [1] https://lore.kernel.org/bpf/20241119111809.GB2328@noisy.programming.k=
icks-ass.net/
  [2] https://lore.kernel.org/linux-trace-kernel/CAEf4BzY-0Eu27jyT_s2kRO1Uu=
UPOkE9_SRrBOqu2gJfmxsv+3A@mail.gmail.com/
  [3] https://lore.kernel.org/all/172074397710.247544.17045299807723238107.=
stgit@devnote2/

