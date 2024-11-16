Return-Path: <bpf+bounces-45030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D579D010A
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 22:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9708CB24269
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2061ADFE4;
	Sat, 16 Nov 2024 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOSuNPVL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C97198841
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793316; cv=none; b=hHy6GCpGHUIIeXVniYuYyqjJJOUo0OOkLAsCGC8Z9EA07J5mq/TeA6Syq7U7MOYjim57/l3PC4ypQlraWRlOSNpYO1Ju2jkiULe1AIdYGqJ6soU0W5gnD0OXCY4Qqg9AtTpI4R4ZEN/7VEoVNkUsqowoTm5ouyLt5CAi/4vxxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793316; c=relaxed/simple;
	bh=+kEYCGmAIPwQOQilNb6t2y8UUcCGRkgBPsSsBRstrps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/pgMV93UaaOVdf+zDSM9AJH3y83eD9F0sFW2smT1cd28NYT/+BM1WW2uQ3A/ITy3XCS5qh5wPuL6o7MhdADkSF/5S5/yLlSnrsYUKYyX4NpSjNEoxyE6V6ZHts2BahFy3IOtoEKiOuNx8DaYwERFCZsQNTomq0Kt5eq3z/PEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOSuNPVL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so26606675e9.1
        for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 13:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731793313; x=1732398113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAM+JMcevy7dk6/RSgQT/r9T8/npnpybDTB2TzL73lc=;
        b=AOSuNPVLoQV3BqrXFf5rsb6N87YOi2Jlny0pEP/fafIYM6wFk4DHicSBDpGxbGdBzi
         ngiW2/rRt7nSFTIoFP7N7OnainHj7PE0mkMDHio/1f8w8xg25yClA/iMT41rtQvOFjD+
         DZQDArtKU6+6NtLveShoJzQC8GBW3UCRBbE7YiL1pBnfAWuv/LfI7CXuYLHzKIRf21Pd
         QIWsl47s7x8M+PbrSYwzqNiy/PQppwxhYTcr4VVvwHdGdAkVz86FqGEI5/2f/RbailuN
         JJX97XYZxMMm2ig5pVDCp1lClOq7f4MWFrq41Ja24L37SvQwf7/yYA3NM/OId/yjQYab
         X9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731793313; x=1732398113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAM+JMcevy7dk6/RSgQT/r9T8/npnpybDTB2TzL73lc=;
        b=ejOPZfEcRFODV7SIyI21nnY7/Hx8AJYQQCbkJ9xyGwdWG+qdVo16y1Dk9it9WYA00Y
         ktsyJIIdOQ1rmeKoSL3Q+mNMMwn6jA29iNKDoyhN+VUb4pKvuI5T5TzGm+kom0hnuupw
         74HNU2mL+x7NHAcEP5kR5z3vudhgHRdDB8DVOGJN8SuS2P0g91+O9jAKnNu6vK5MHC3O
         yMSoxZYDRwqdRk28h6Sxfmb3iJikxnSeCK/cIB9FxRfENNI+hh31lihsB5AqSTsAs75W
         oTm9xPu2/sKq0gohcr0wwRivDLaL7CTRuPszPU4shGsQh+khLe0YbYBCZ9WfrDsIizdL
         fCCg==
X-Gm-Message-State: AOJu0YzPGd4cIXWOFfhwhWXqi/DnjGyKUmTJONUTOb0Bu0GmPb182L3/
	j5cmJWEO2Z3lssxnLmoenjyZ13FsKUfAy0idgmbaES9N3uTHpRUtKXv+ReW4de65lJDZmdsh+8U
	WMu+YZAxEHgn+QbQDPYMpdcIra8E=
X-Google-Smtp-Source: AGHT+IGf6gvN4jEx9YE+20Lv/GedyixsQFvTvgnVK1Sa8wmWxB4twDEATHAbbcPt3p8ZgQ7C8Z7ymWZzsPrWh16AW54=
X-Received: by 2002:a05:600c:4505:b0:431:1868:417f with SMTP id
 5b1f17b1804b1-432df74be9amr71917705e9.17.1731793313022; Sat, 16 Nov 2024
 13:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116014854.55141-1-alexei.starovoitov@gmail.com>
 <20241116194202.GR22801@noisy.programming.kicks-ass.net> <CAADnVQLOyY=Jvibq-hnv6dpXy+hAJFWojyHh7wuEiMn-itMvaw@mail.gmail.com>
 <CAADnVQLA9CkUtcEyjvrTCPZfMWdDXGRzr1O-GD58XM6xjfLTJg@mail.gmail.com>
In-Reply-To: <CAADnVQLA9CkUtcEyjvrTCPZfMWdDXGRzr1O-GD58XM6xjfLTJg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Nov 2024 13:41:41 -0800
Message-ID: <CAADnVQJm64vyeXehTVRbyFqHuuPQWgD-iBYqCChjQE+tHTbKGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Peter Zijlstra <peterz@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 1:34=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 16, 2024 at 1:13=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Nov 16, 2024 at 11:42=E2=80=AFAM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Fri, Nov 15, 2024 at 05:48:53PM -0800, Alexei Starovoitov wrote:
> > > > +static inline struct page *try_alloc_page_noprof(int nid)
> > > > +{
> > > > +     /* If spin_locks are not held and interrupts are enabled, use=
 normal path. */
> > > > +     if (preemptible())
> > > > +             return alloc_pages_node_noprof(nid, GFP_NOWAIT | __GF=
P_ZERO, 0);
> > >
> > > This isn't right for PREEMPT_RT, spinlock_t will be preemptible, but =
you
> > > very much do not want regular allocation calls while inside the
> > > allocator itself for example.
> >
> > I'm aware that spinlocks are preemptible in RT.
> > Here is my understanding of why the above is correct...
> > - preemptible() means that IRQs are not disabled and preempt_count =3D=
=3D 0.
> >
> > - All page alloc operations are protected either by
> > pcp_spin_trylock() or by spin_lock_irqsave(&zone->lock, flags)
> > or both together.
> >
> > - In non-RT spin_lock_irqsave disables IRQs, so preemptible()
> > check guarantees that we're not holding zone->lock.
> > The page alloc logic can hold pcp lock when try_alloc_page() is called,
> > but it's always using pcp_trylock, so it's still ok to call it
> > with GFP_NOWAIT. pcp trylock will fail and zone->lock will proceed
> > to acquire zone->lock.
> >
> > - In RT spin_lock_irqsave doesn't disable IRQs despite its name.
> > It calls rt_spin_lock() which calls rcu_read_lock()
> > which increments preempt_count.
>
> The maze of ifdef-s beat me :(
> It doesn't increment in PREEMPT_RCU.
> Need an additional check then. hmm.

Like:
if (preemptible() && !rcu_preempt_depth())
  return alloc_pages_node_noprof(nid, GFP_NOWAIT | __GFP_ZERO, 0);

Not pretty, but should do.
wdyt?

