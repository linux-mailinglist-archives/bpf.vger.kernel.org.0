Return-Path: <bpf+bounces-44532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB29C438A
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 18:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214C3282CAC
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C41A7264;
	Mon, 11 Nov 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAVqm8/f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC0F1A4E77;
	Mon, 11 Nov 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345991; cv=none; b=MBgvgF0D6t1vnVc90Z48RqfiYJ+jtm0SoPnsygm4KNKcD6x4GKioHvxNvAK+bWWfNLyeoeVAydb/nQUzUGgu3A1++HstNGV7ofAMzYrs9mONCQuqh/WCJBxtwvP5bU7Zz1Qj1CkLj4VvBjUoVTKHi9UXQ9/wAHjfZiHtyipzYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345991; c=relaxed/simple;
	bh=Y7vWffxa7tt+oBwbv+U0Tu5Col7n9dUxGa2pP40+/HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cieKNRMp17xWqA6p3oWkxDkrlYPkPsPJNZTeobADWZor10xH1bTPlrLWasotPOKrcEmruN+2aar9iGKss2RxY+SJxthdGwmUSt8WHNmkoxhu1yGRnfVI/vIGGsDKOg+OQy082/oAvEVQVtl20gJ2dJntHL5iyVsIfi8PxLYeQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAVqm8/f; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f45ab88e7fso877686a12.1;
        Mon, 11 Nov 2024 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731345989; x=1731950789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=446kiMyz10bq8FieaREKKmn4/b2mNECd8raHOngAG/s=;
        b=FAVqm8/fpRfNHSS8w/SkiXyn9k1abjH1yiwqL3KBHGzKvRlcx4eOpZoUBq/sE9dkIC
         DkaLP152S3hDTSytLL+AJ+/gkaYvOrC+AEZMSCbR6HwefSm5fHGKtiWGkuFfpjKlNw0+
         NUORNnzTWAEGh4ANlR06b1ol6i8qrPX/pXZXVuSoWXd2VQjQBWZdUBw+277wI7vIqQd7
         9PgKknbWYJYF5etndUAmdA2i0IEsL7+pzQzUF18f9smOo1uMrB7Vke6fMRqVd2hpJIce
         Mj0Fq70hynkcmCu4NlagYuB1OWmBlIye3DBIRQCSPpjZxb+1v7B7iVCUuSF+XE2ZwXBy
         uumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345989; x=1731950789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=446kiMyz10bq8FieaREKKmn4/b2mNECd8raHOngAG/s=;
        b=kQ+7cHD25Oa3X3guAv78VTIB0or5MNw8OK7vZmOgMfsHgLpDEU0CPMlx3aQERQP76U
         mSxz5TLeBatUHajIXU3rCvWemr9K6usOPDM7zRauJlYKqWGtv3MRhxKjsXZ6S6sKma01
         /2JVS5LGu4pfS5Anzyp7dnBK7Dgtn/tQgMKxRLlRwk7kZpH9xJ21RZei7whNIIIQ3jIR
         fMRbG2fTQgM1kLI4l9tIPUJI7sgdgLblhk21bIy0bSBh+6Riv27Fh8E5glrQCl4K2GRR
         UW4HiIgzU+FqKoBiyiDN3vyOBggk6OToDJGKH3Cf5UbXOLR4VJLkPQA90WQDn7jH0KrR
         XstA==
X-Forwarded-Encrypted: i=1; AJvYcCUFZnUIVIL2aev+5qnta++GzYs8iEu81BuCeMdKTHjrlcpyPm13SPnW/ubYbRKyAsB9Lik=@vger.kernel.org, AJvYcCWJhHdhlJIIpUmET86HYIqeQ+yn6Eyd9ibEC1nO6wT+7BjgRJAh7j4yJ10yx2EONb+DAY1nWtMrJXsLZ4YN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9ng/XQuEyle3nxL7/JlRVX5l4/UhbEqamFFKhMi/nL4ChP/u
	8jEbJxbXZdUq2pF4MJsWRnm3gMx6mWn3bTDlZKYjJ2f08RIKIomTVwtIE0jVnmGqfsnctK3j3c0
	yQfSeeHDXqX43an6SCYmlRSJHVNXJ5g==
X-Google-Smtp-Source: AGHT+IHYut3+sEt3XzJfDiHtcSZtT9/Ehm9MZiVZDPX1nQCusxzbEs5rW24mOSm82XpfMduwn3JOTnvHCYtdPw0Ys3E=
X-Received: by 2002:a17:90b:2b45:b0:2e2:b64e:f4f7 with SMTP id
 98e67ed59e1d1-2e9b177fc67mr17790610a91.29.1731345989175; Mon, 11 Nov 2024
 09:26:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <CAEf4BzYPajbgyvcvm7z1EiPgkee1D1r=a8gaqxzd7k13gh9Uzw@mail.gmail.com>
In-Reply-To: <CAEf4BzYPajbgyvcvm7z1EiPgkee1D1r=a8gaqxzd7k13gh9Uzw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Nov 2024 09:26:17 -0800
Message-ID: <CAEf4Bza=pwrZvd+3dz-a7eiAQMk9rwBDO1Kk_iwXSCM70CAARw@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 0/4] uprobes,mm: speculative lockless
 VMA-to-uprobe lookup
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, mjguzik@gmail.com, brauner@kernel.org, 
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	david@redhat.com, arnd@arndb.de, richard.weiyang@gmail.com, 
	zhangpeng.00@bytedance.com, linmiaohe@huawei.com, viro@zeniv.linux.org.uk, 
	hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 6:01=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Oct 27, 2024 at 6:09=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > Implement speculative (lockless) resolution of VMA to inode to uprobe,
> > bypassing the need to take mmap_lock for reads, if possible. First two =
patches
> > by Suren adds mm_struct helpers that help detect whether mm_struct was
> > changed, which is used by uprobe logic to validate that speculative res=
ults
> > can be trusted after all the lookup logic results in a valid uprobe ins=
tance.
> >
> > Patch #3 is a simplification to uprobe VMA flag checking, suggested by =
Oleg.
> >
> > And, finally, patch #4 is the speculative VMA-to-uprobe resolution logi=
c
> > itself, and is the focal point of this patch set. It makes entry uprobe=
s in
> > common case scale very well with number of CPUs, as we avoid any lockin=
g or
> > cache line bouncing between CPUs. See corresponding patch for details a=
nd
> > benchmarking results.
> >
> > Note, this patch set assumes that FMODE_BACKING files were switched to =
have
> > SLAB_TYPE_SAFE_BY_RCU semantics, which was recently done by Christian B=
rauner
> > in [0]. This change can be pulled into perf/core through stable
> > tags/vfs-6.13.for-bpf.file tag from [1].
> >
> >   [0] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commi=
t/?h=3Dvfs-6.13.for-bpf.file&id=3D8b1bc2590af61129b82a189e9dc7c2804c34400e
> >   [1] git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> >
> > v3->v4:
> > - rebased and dropped data_race(), given mm_struct uses real seqcount (=
Peter);
> > v2->v3:
> > - dropped kfree_rcu() patch (Christian);
> > - added data_race() annotations for fields of vma and vma->vm_file whic=
h could
> >   be modified during speculative lookup (Oleg);
> > - fixed int->long problem in stubs for mmap_lock_speculation_{start,end=
}(),
> >   caught by Kernel test robot;
> > v1->v2:
> > - adjusted vma_end_write_all() comment to point out it should never be =
called
> >   manually now, but I wasn't sure how ACQUIRE/RELEASE comments should b=
e
> >   reworded (previously requested by Jann), so I'd appreciate some help =
there
> >   (Jann);
> > - int -> long change for mm_lock_seq, as agreed at LPC2024 (Jann, Suren=
, Liam);
> > - kfree_rcu_mightsleep() for FMODE_BACKING (Suren, Christian);
> > - vm_flags simplification in find_active_uprobe_rcu() and
> >   find_active_uprobe_speculative() (Oleg);
> > - guard(rcu)() simplified find_active_uprobe_speculative() implementati=
on.
> >
> > Andrii Nakryiko (2):
> >   uprobes: simplify find_active_uprobe_rcu() VMA checks
> >   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution
> >
> > Suren Baghdasaryan (2):
> >   mm: Convert mm_lock_seq to a proper seqcount
> >   mm: Introduce mmap_lock_speculation_{begin|end}
> >
> >  include/linux/mm.h               | 12 ++---
> >  include/linux/mm_types.h         |  7 ++-
> >  include/linux/mmap_lock.h        | 87 ++++++++++++++++++++++++--------
> >  kernel/events/uprobes.c          | 47 ++++++++++++++++-
> >  kernel/fork.c                    |  5 +-
> >  mm/init-mm.c                     |  2 +-
> >  tools/testing/vma/vma.c          |  4 +-
> >  tools/testing/vma/vma_internal.h |  4 +-
> >  8 files changed, 129 insertions(+), 39 deletions(-)
> >
> > --
> > 2.43.5
> >
>
> Hi!
>
> What's the status of this patch set? Are there any blockers for it to
> be applied to perf/core? MM folks are OK with landing the first two
> patches in perf/core, so hopefully we should be good to go?

Another week, another ping. Peter, what can I do to make this land? MM
parts are clearly ok with Andrew Morton, uprobe-side logic didn't
change (modulo inconsequential data_race() back and forth) since at
least August, was approved by Oleg, and seems to be very stable in
testing. I think it's time to let me forget about this patch set and
make actual use of it in production, please.

