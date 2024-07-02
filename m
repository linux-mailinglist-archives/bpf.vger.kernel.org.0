Return-Path: <bpf+bounces-33657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD65B9246BB
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 19:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C681C22574
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D07F1C0DEA;
	Tue,  2 Jul 2024 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFk/hmMP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F8B3D978;
	Tue,  2 Jul 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942915; cv=none; b=fzLwm8wGxWEFmZW6+UQTHYicjueFPUQOZUhEdyuwu+aiz4dC8CTPwwmE4i1frrTCs37wVPLBX65/obKlcSHWoHgxneidcvn4KayyvPdpMp2NOTkmga2nO1yKh87NwvmJpePltD3nXkg/L0KDF5pEvevXlLOJnmGTSpLmDyqJ9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942915; c=relaxed/simple;
	bh=iJj0B3U/0pjf215N8OBs/Q3aRcHcE8ptvosk66c8d4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Er4Sf6diFYY3YzOEfG8YE5qmd7TECIVNk7CqXtYnbWmJyZ+8WCj/LVz/zL/oIqrJSCfC4UVkIl95quqVwP2vL9ufaXuOD9GHxjXZX2gylaQ74d06LRV8gQTXPmPtTiby/QMlzujL8dhFpX7GF4osmCtoHoboSkSQ3Yjd3fWjBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFk/hmMP; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2653844a12.2;
        Tue, 02 Jul 2024 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719942913; x=1720547713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjC8lenj3aM6c3tOO0oafhzKAhFdqsGyS+BootkNsPg=;
        b=fFk/hmMPv2gAer611FXmutH09/uvfOudu8BRjbdHiaWNxKMw26KbrnueJu4QsTA8Yw
         HXYt90O+ZjbUc00wTHXzhG5SLXAU2Ljz9C8XxSpDkEKWWFV+BOaFmyoJoUnWq62Cm4J3
         6sxherAu9PeFV2BjCBslqoujceiUgDzP0+trME4kocrzjinwx6xlaMQlngbCH2NJS1I2
         zsIpO+3gVOzxFwsxVF1yZj81mFHwxrTA+kaqNQxgd+CFYRpClGFN1NtofEQF9hkc7BAD
         02TtHvFRs/0wBPh6oiwvEl7rOKN1x2lNdm+0hycH8S+kaXvfU/bdfosLi9ZkzdVfEjWM
         nduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719942913; x=1720547713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjC8lenj3aM6c3tOO0oafhzKAhFdqsGyS+BootkNsPg=;
        b=N6kphGQma9rHlIqYOxuW5P9l/xHnqeP6/EmyE5kNWgZt2FqB9SP9XIfwN7MIVw24xm
         /LuR3+Fm2kvuNaVGNDTNKA963s+YyiRyLOmiHPT8vwDNNprXvjilUDQktogVd8Fo6YL9
         MgV0Xrc6Bu5nGbcEz+EDL2Yd2S2l3cu+yZDny8+2+3+XGj5m8aPoHCL25hcCDxcc0OCa
         3auW+8VX+1Y1lTzVi31u4ajMQDsQCeAFXrbc/kL6/VYdTf7QoR3l7i88x+rJ+P0Q0sqv
         qmY8/07VypGRButzwv/eWrz/g4cj/apYrzEqJemVwDB99KcP8KKvpdlaUv9nUq9UwgOn
         1eAg==
X-Forwarded-Encrypted: i=1; AJvYcCVj2n2BtRJqOr8oNIfJPyd1NHI+Do+6LJPlzcNov1N486kF9x+nf9wimE1xFHOSarIDkxJs5Q57fx3o5WVNuDsQewRyaZmjMDSYNveMjgIcF7zN0is+sMAspr5RFrdBgY9Aij1HPP2S
X-Gm-Message-State: AOJu0YyaJs8Kges72Us37Sw67mqEmyfABlRakxwMHn89a9qTmfquIzeb
	qxpYYpyE9+ZUHoFWTzAPENhDBmeYce5aPPnktXsRl1nbvCErDBJ4niZZVN8Xz1khUl8V5DBHR9q
	7tC/aCUmP5Cp/0A5G6eDjJVC4Egg=
X-Google-Smtp-Source: AGHT+IF+MyNT4Qjcuv7g5ZoayEUQELh/nH29g8rIyb3fY91dLV2UesFPnVDHLmqi3imPrq8dEUPVo8xJrCWHndzIkr8=
X-Received: by 2002:a05:6a20:1584:b0:1bd:23cc:a3a5 with SMTP id
 adf61e73a8af0-1bef61e7a47mr9435286637.48.1719942911252; Tue, 02 Jul 2024
 10:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240701223935.3783951-5-andrii@kernel.org>
 <20240702102254.GF11386@noisy.programming.kicks-ass.net>
In-Reply-To: <20240702102254.GF11386@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 10:54:58 -0700
Message-ID: <CAEf4BzamZDamrZ7YtAiujeHC-_zdVLWu7XNDtnUxYbBCK-VWjQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime management
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 3:23=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Jul 01, 2024 at 03:39:27PM -0700, Andrii Nakryiko wrote:
>
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 23449a8c5e7e..560cf1ca512a 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -53,9 +53,10 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
> >
> >  struct uprobe {
> >       struct rb_node          rb_node;        /* node in the rb tree */
> > -     refcount_t              ref;
> > +     atomic64_t              ref;            /* see UPROBE_REFCNT_GET =
below */
> >       struct rw_semaphore     register_rwsem;
> >       struct rw_semaphore     consumer_rwsem;
> > +     struct rcu_head         rcu;
> >       struct list_head        pending_list;
> >       struct uprobe_consumer  *consumers;
> >       struct inode            *inode;         /* Also hold a ref to ino=
de */
> > @@ -587,15 +588,138 @@ set_orig_insn(struct arch_uprobe *auprobe, struc=
t mm_struct *mm, unsigned long v
> >                       *(uprobe_opcode_t *)&auprobe->insn);
> >  }
> >
> > -static struct uprobe *get_uprobe(struct uprobe *uprobe)
> > +/*
> > + * Uprobe's 64-bit refcount is actually two independent counters co-lo=
cated in
> > + * a single u64 value:
> > + *   - lower 32 bits are just a normal refcount with is increment and
> > + *   decremented on get and put, respectively, just like normal refcou=
nt
> > + *   would;
> > + *   - upper 32 bits are a tag (or epoch, if you will), which is alway=
s
> > + *   incremented by one, no matter whether get or put operation is don=
e.
> > + *
> > + * This upper counter is meant to distinguish between:
> > + *   - one CPU dropping refcnt from 1 -> 0 and proceeding with "destru=
ction",
> > + *   - while another CPU continuing further meanwhile with 0 -> 1 -> 0=
 refcnt
> > + *   sequence, also proceeding to "destruction".
> > + *
> > + * In both cases refcount drops to zero, but in one case it will have =
epoch N,
> > + * while the second drop to zero will have a different epoch N + 2, al=
lowing
> > + * first destructor to bail out because epoch changed between refcount=
 going
> > + * to zero and put_uprobe() taking uprobes_treelock (under which overa=
ll
> > + * 64-bit refcount is double-checked, see put_uprobe() for details).
> > + *
> > + * Lower 32-bit counter is not meant to over overflow, while it's expe=
cted
>
> So refcount_t very explicitly handles both overflow and underflow and
> screams bloody murder if they happen. Your thing does not..
>

Correct, because I considered that to be practically impossible to
overflow this refcount. The main source of refcounts are uretprobes
that are holding uprobe references. We limit the depth of supported
recursion to 64, so you'd need 30+ millions of threads all hitting the
same uprobe/uretprobe to overflow this. I guess in theory it could
happen (not sure if we have some limits on total number of threads in
the system and if they can be bumped to over 30mln), but it just
seemed out of realm of practical possibility.

Having said that, I can add similar checks that refcount_t does in
refcount_add and do what refcount_warn_saturate does as well.

> > + * that upper 32-bit counter will overflow occasionally. Note, though,=
 that we
> > + * can't allow upper 32-bit counter to "bleed over" into lower 32-bit =
counter,
> > + * so whenever epoch counter gets highest bit set to 1, __get_uprobe()=
 and
> > + * put_uprobe() will attempt to clear upper bit with cmpxchg(). This m=
akes
> > + * epoch effectively a 31-bit counter with highest bit used as a flag =
to
> > + * perform a fix-up. This ensures epoch and refcnt parts do not "inter=
fere".
> > + *
> > + * UPROBE_REFCNT_GET constant is chosen such that it will *increment b=
oth*
> > + * epoch and refcnt parts atomically with one atomic_add().
> > + * UPROBE_REFCNT_PUT is chosen such that it will *decrement* refcnt pa=
rt and
> > + * *increment* epoch part.
> > + */
> > +#define UPROBE_REFCNT_GET ((1LL << 32) + 1LL) /* 0x0000000100000001LL =
*/
> > +#define UPROBE_REFCNT_PUT ((1LL << 32) - 1LL) /* 0x00000000ffffffffLL =
*/
> > +
> > +/*
> > + * Caller has to make sure that:
> > + *   a) either uprobe's refcnt is positive before this call;
> > + *   b) or uprobes_treelock is held (doesn't matter if for read or wri=
te),
> > + *      preventing uprobe's destructor from removing it from uprobes_t=
ree.
> > + *
> > + * In the latter case, uprobe's destructor will "resurrect" uprobe ins=
tance if
> > + * it detects that its refcount went back to being positive again inbe=
tween it
> > + * dropping to zero at some point and (potentially delayed) destructor
> > + * callback actually running.
> > + */
> > +static struct uprobe *__get_uprobe(struct uprobe *uprobe)
> >  {
> > -     refcount_inc(&uprobe->ref);
> > +     s64 v;
> > +
> > +     v =3D atomic64_add_return(UPROBE_REFCNT_GET, &uprobe->ref);
>
> Distinct lack of u32 overflow testing here..
>
> > +
> > +     /*
> > +      * If the highest bit is set, we need to clear it. If cmpxchg() f=
ails,
> > +      * we don't retry because there is another CPU that just managed =
to
> > +      * update refcnt and will attempt the same "fix up". Eventually o=
ne of
> > +      * them will succeed to clear highset bit.
> > +      */
> > +     if (unlikely(v < 0))
> > +             (void)atomic64_cmpxchg(&uprobe->ref, v, v & ~(1ULL << 63)=
);
> > +
> >       return uprobe;
> >  }
>
> >  static void put_uprobe(struct uprobe *uprobe)
> >  {
> > -     if (refcount_dec_and_test(&uprobe->ref)) {
> > +     s64 v;
> > +
> > +     /*
> > +      * here uprobe instance is guaranteed to be alive, so we use Task=
s
> > +      * Trace RCU to guarantee that uprobe won't be freed from under u=
s, if
>
> What's wrong with normal RCU?
>

will reply in another thread to keep things focused

> > +      * we end up being a losing "destructor" inside uprobe_treelock'e=
d
> > +      * section double-checking uprobe->ref value below.
> > +      * Note call_rcu_tasks_trace() + uprobe_free_rcu below.
> > +      */
> > +     rcu_read_lock_trace();
> > +
> > +     v =3D atomic64_add_return(UPROBE_REFCNT_PUT, &uprobe->ref);
>
> No underflow handling... because nobody ever had a double put bug.
>

ack, see above, will add checks and special saturation value.

[...]

