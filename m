Return-Path: <bpf+bounces-53283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69209A4F55A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 04:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86182188C615
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953531624EB;
	Wed,  5 Mar 2025 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLzEGAuG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DEF41A8F;
	Wed,  5 Mar 2025 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145187; cv=none; b=D9JDcpQDYzc32wuoRWUslxFdhbaWUG47/fe7kozLLE467lMVdji7WNPXFQFVLb2er1KbCWA/tX9d+r3YF9D9MlbVZRpmi6Nqb8oSbpUq1XoQ+dGhpvKVikSztRS3zIaSqJACHpY1r4MhRvJdNoxx6hw58ugC21LlHRTBnm97q5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145187; c=relaxed/simple;
	bh=mHtkAZ4vLe3KUwCdyIh3cqKytMRkKRIQ55rcWBYcONo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yqtc+qLhZ91fv11ftJMzoTD1XgxyBxJ84zMIXCfgO33ZSdCmfGfI9k7+HVXSnV7vMbMSMme5M4lVDPHK2CRCT9xNgAsFByEK6xDlaMyKZ1XEJdKZntWyQIdhB+D3JPs07eZaQNbxx2h7DP+CnyUztEiJE9YY1a6YZFZFM+zODJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLzEGAuG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so42928415e9.0;
        Tue, 04 Mar 2025 19:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741145183; x=1741749983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VretaU5v/1hLOHdXy1ltl2QWR/a5vZVhU8PtvFmcdBs=;
        b=WLzEGAuGA91mVUcyJNVVuwUOU3Z6mO17847LN94LGJ7303hm4HI5XUY89ZR4q2SyP+
         VNdrSRp4wRnugwq1MygAYJZRX10AVh3HYZr+cfBGYFp/KCzbu2uGePTzpDriyTez0H4i
         aaCss+Nz0uBODCeuE/sk0I+M0FkTKmJiqvQjUfRcFncO6VIGSYDOQD41o7fRu8Vbzk9V
         ChodrjbMMFy/0PEg7vxWo6qR7qT/5JimQms9KEQ7X0RdMfjo/2rlhHlpSo1nzwUAnvKt
         bB+LlGYH9cqAjhoxQv+2akdUgfkvvjWe9A+QFKtHQgSQVnFT8avL0amnHkYd6QIx4viQ
         j/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741145183; x=1741749983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VretaU5v/1hLOHdXy1ltl2QWR/a5vZVhU8PtvFmcdBs=;
        b=QWgTqpam5LxDA1YHPYFixZEEpidU9BCDobybDLBrUvi2d+naiduSwCHHViKXobhv8u
         cXa8CHFYZrhzxgqws9A3PinBlTmh2r6JP6xunUYX3QG64MwFA1JdX7Ac+1GXNOiOLYwR
         aWVf+1hNRah8Yrv9FLE5WXfKKPHCXhJNzTfkBRSUSqbGii1D6KqfJSoqaujSBpAaeD5x
         L86x7Ys43Uf8nezAzyh+me0a+IjYjBg9x/elOb3YtzSSGu+wdDcnucGtVVtTuDvJjKFk
         Tp6rtIWdC8/NFLVqHmEmZkNcAHvsxpAn0361SSy4VbqUDlnr/k4csL0Po8FHmI5FR1nB
         cN0A==
X-Forwarded-Encrypted: i=1; AJvYcCUADUSbDf9lCmPzjrbguHv5rM47cVREbwHXy3FQU3JqAPbxitONYxnQ2soSYqWArUQU2jA=@vger.kernel.org, AJvYcCUkYwNmllbv+0zDQNPxXezAJYDlqKXHagyL1FJ2PSrtXiyyRCpgHL2VRVYqqANI9ehYYpESWafE4cQb8yUH@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRBs/GlMVGXQpBmUHlNivz6xawD/3cTaaeVGrwe53nHAzciw7
	Sl+DWRAe6kvPUhyQf7QPpMIc1pLh0dqhK3ScfBrEg0v6mfIV3ZZFxsad3G74c4lu8sy+s721hlc
	/5X+IcA64E73LF8QsZmKeCL3CAu8=
X-Gm-Gg: ASbGncsU2Thg6D/juggslYjFAn0N4ayxqj5kulYYnRk9zBV+iqijZLt7E1w7PqgAHIQ
	Y6rW5Gu/MYowlhpjb5fXI33b1RisZstO/Y9UfXbaQtfhbjVFPOI5S/txpB3+ruAqMdmRj2ePUHp
	nwbUy0/b+mGdudshuOBfRirdXIBsMMo3VzBdkS9MURog==
X-Google-Smtp-Source: AGHT+IGzIMM7zQQRVkBbsNXSeTx6I8p3O2hYNgu0XDTLHu0kIfXx9/HT2hCa4nZS4sHy1z+ltogZRtDVFBUrzn8DqIU=
X-Received: by 2002:a05:6000:1a8e:b0:391:136c:1346 with SMTP id
 ffacd0b85a97d-3911f74bdfbmr773726f8f.19.1741145183408; Tue, 04 Mar 2025
 19:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250210093840.GE10324@noisy.programming.kicks-ass.net>
 <20250210104931.GE31462@noisy.programming.kicks-ass.net> <CAADnVQ+3wu0WB2pXs4cccxfkbTb3TK8Z+act5egytiON+qN9tA@mail.gmail.com>
 <20250211104352.GC29593@noisy.programming.kicks-ass.net> <CAADnVQJ=81PE19JWeNjq6aNOy+GM-wo6n7WU9StX1b6kevqCUw@mail.gmail.com>
 <20250213095918.GB28068@noisy.programming.kicks-ass.net> <CAADnVQJJbi-52mP6BivyAudWSk95f1mgGQXWnjD-H37b7_AtLw@mail.gmail.com>
 <20250304104648.GD11590@noisy.programming.kicks-ass.net>
In-Reply-To: <20250304104648.GD11590@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Mar 2025 19:26:12 -0800
X-Gm-Features: AQ5f1Jqc1OcxFdpHXxviILWN5ATrQ8sjCyiJy-0TOJ3kpk8iy_sBSEBkr25uumA
Message-ID: <CAADnVQ+hR6WB9=WVP73uxhetAZMTugcT2z_N=89qhjFJPoWT=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/26] Resilient Queued Spin Lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, 
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 2:46=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
>
> Anyway; the situation I was thinking of was something along the lines
> of: you need data from 2 buckets, so you need to lock 2 buckets, but
> since hash-table, there is no sane order, so you need a 3rd lock to
> impose order.

Not quite. This is a typical request to allow locking two buckets
and solution to that is run-time lock address check.

> > q1 =3D bpf_map_lookup_elem(&vqueue, &key1);
> > q2 =3D bpf_map_lookup_elem(&vqueue, &key2);
> >
> > both will point to two different locks,
> > and since the key is dynamic there is no way to know
> > the order of q1->lock vs q2->lock.
>
> I still feel like I'm missing things, but while they are two dynamic
> locks, they are both locks of vqueue object. What lockdep does is
> classify locks by initialization site (by default). Same can be done
> here, classify per dynamic object.
>
> So verifier can know the above is invalid. Both locks are same class, so
> treat as A-A order (trivial case is where q1 and q2 are in fact the same
> object since the keys hash the same).

Sounds like you're saying that the verifier should reject
the case when two locks of the same class like q1->lock and q2->lock
need to be taken ?
But that is one of the use cases where people requested to allow
multiple locks.
The typical solution to this is to order locks by addresses at runtime.
And nf_conntrack_double_lock() in net/netfilter/nf_conntrack_core.c
does exactly that.

if (lock1 < lock2) {
  spin_lock(lock1);spin_lock(lock2);
} else {
  spin_lock(lock2);spin_lock(lock1);
}

> Now, going back to 3rd lock, if instead you write it like:
>
>   bpf_spin_lock(&glock);
>   q1 =3D bpf_map_lookup_elem(&vqueue, &key1);
>   q2 =3D bpf_map_lookup_elem(&vqueue, &key2);
>   ...
>   bpf_spin_unlock(&glock);
>
> then (assuming q1 !=3D q2) things are fine, since glock will serialize
> everybody taking two vqueue locks.
>
> And the above program snippet seems to imply maps are global state, so

Not quite. Some maps are global, but there are dynamic maps too.
That's what map-in-map is for.

> you can keep lock graph of maps, such that:
>
>   bpf_map_lookup_elem(&map-A, &key-A);
>   bpf_map_lookup_elem(&map-B, &key-B);
>
> vs
>
>   bpf_map_lookup_elem(&map-B, &key-B);
>   bpf_map_lookup_elem(&map-A, &key-A);
>
> trips AB-BA

If everything was static and _keys_ known statically too, then yes,
such analysis by the verifier would be possible.
But both maps and keys are dynamic.

Note, to make sure that the above example doesn't confuse people,
bpf_map_lookup_elem() lookup itself is completely lockless.
So nothing wrong with the above sequence as written.
Only when:
q1 =3D bpf_map_lookup_elem(&map-A, &key-A);
q2 =3D bpf_map_lookup_elem(&map-B, &key-B);
if (bpf_res_spin_lock(&q1->lock))
if (bpf_res_spin_lock(&q2->lock))

the deadlocks become a possibility.
Both maps and keys are only known at run-time.
So locking logic has to do run-time checks too.

> I am not at all sure how res_spin_lock is helping with the q1,q2 thing.
> That will trivially result in lock cycles.

Right and AA or ABBA will be instantly detected at run-time.

> And you said any program that would trigger deadlock is invalid.
> Therefore the q1,q2 example from above is still invalid and
> res_spin_lock has not helped.

res_spin_lock will do its job and will prevent a deadlock.
As we explained earlier such a program will be marked as broken
and will be detached/stopped by the bpf infra.
Also we're talking root privileges.
None of this is allowed in unpriv.

> > Just to make it clear... there is a patch 18:
> >
> >  F: kernel/bpf/
> >  F: kernel/trace/bpf_trace.c
> >  F: lib/buildid.c
> > +F: arch/*/include/asm/rqspinlock.h
> > +F: include/asm-generic/rqspinlock.h
> > +F: kernel/locking/rqspinlock.c
> >  F: lib/test_bpf.c
> >  F: net/bpf/
> >
> > that adds maintainer entries to BPF scope.
> >
> > We're not asking locking experts to maintain this new res_spin_lock.
> > It's not a generic kernel infra.
> > It will only be used by bpf infra and by bpf progs.
> > We will maintain it and we will fix whatever bugs
> > we introduce.
>
> While that is appreciated, the whole kernel is subject to the worst case
> behaviour of this thing. As such, I feel I need to care.

Not sure why you're trying to relitigate the years worth of
discussions around locks in the bpf community.
Static analysis of 2+ locks by the verifier is impossible.
Full lock graph cycle detection lockdep-style is too slow in run-time.
Hence res_spin_lock with AA, ABBA, and timeout as a last resort
is our solution to real reported bugs.

This res_spin_lock patchset fixes the following syzbot reports:

https://lore.kernel.org/bpf/675302fd.050a0220.2477f.0004.GAE@google.com
https://lore.kernel.org/bpf/000000000000b3e63e061eed3f6b@google.com
https://lore.kernel.org/bpf/CAPPBnEa1_pZ6W24+WwtcNFvTUHTHO7KUmzEbOcMqxp+m2o=
15qQ@mail.gmail.com
https://lore.kernel.org/bpf/CAPPBnEYm+9zduStsZaDnq93q1jPLqO-PiKX9jy0MuL8LCX=
mCrQ@mail.gmail.com
https://lore.kernel.org/lkml/000000000000adb08b061413919e@google.com

It fixes the real issues.
Some of them have hacky workarounds, some are not fixed yet.

More syzbot reports will be fixed in follow ups when we
adopt res_spin_lock in other parts of bpf infra.

Note, all of the above syzbot reports are _not_ using direct
locks inside the bpf programs. All of them hit proper kernel
spin_locks inside bpf infra (like inside map implementations and such).
The verifier cannot do anything. syzbot generated programs
are trivial. They do one bpf_map_update_elem() call or similar.
It's a combination of attaching to tricky tracepoints
like trace_contention_begin or deep inside bpf infra.
We already have these workarounds:
CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
CFLAGS_REMOVE_queue_stack_maps.o =3D $(CC_FLAGS_FTRACE)
CFLAGS_REMOVE_lpm_trie.o =3D $(CC_FLAGS_FTRACE)
CFLAGS_REMOVE_ringbuf.o =3D $(CC_FLAGS_FTRACE)
to prevent recursion anywhere in these files,
but it's helping only so much.

So please take a look at patches 1-18 and help us make
sure we implemented AA, ABBA, timeout logic without obvious bugs.
I think we did, but extra review would be great.

Thanks!

