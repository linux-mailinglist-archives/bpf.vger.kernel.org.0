Return-Path: <bpf+bounces-33319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E30191B4AC
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 03:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631B7B21890
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E411711;
	Fri, 28 Jun 2024 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIrcrPjQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630922139A7;
	Fri, 28 Jun 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719538469; cv=none; b=anoz0F2In0Ld5rpVMs/VC9XAMZqPcyFxYS9HtNsUqJ8gsL2WXS1YfIeDbDEOk11nlqOmjReVSeak7/h6RENisJ1W6dtJHuyqZ3OLqtdGMAB9kvBkHdO9Bb0f7WHxoalKt9OViOjOnT1zTtALovflY/7b7GY4oNy7x+7945GIOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719538469; c=relaxed/simple;
	bh=t0INylUNf2k0kJwVKbtRu+K6PLesJ41tzUOSeafL+Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UP8T5NF10BKW0Youl34CCwu5TIqE0oN0JOCGZl91AmXzBABwqJEQ77KNkAKfqxAfrFADd6iERV6Tum3vgXvhdqJgRtdd1SsK9EiWGoLSqV5SEpCbGU5FH5JWI+mOTt69iabKFmj4hXf7aBkWupdUv4cu4Ww+wQ1TqbI/jqCN8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIrcrPjQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3627ef1fc07so42619f8f.3;
        Thu, 27 Jun 2024 18:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719538466; x=1720143266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnvbgBjmT2j00SWL77w/wmw1cd/5GofeGMuapdrdl3U=;
        b=cIrcrPjQfm2cwR8huJ9O+N45w9iBdY53TIwQ298IM+e5A4JBgckpx4LuLI85ynNLc3
         +TRqEoPF/kvoEJzye8tzYd4hiuTek1AjbOj7nDU6CGFp7P/Fgf5N5ywMDmz8bwfCYs56
         z4oyWDIQ/qg60jqjEWCSBSwZRNrqhJus/WgbFcz5OH7JJC1dOyn95AhAWZkxtgipKWQP
         ewlz829bUR/jMBAERsPI2Yb6Lhz8J0x4Rkz+WuuNQtubLESzmok3KhJV/NWR55HJcYXo
         wtMS3o4tO0Bti/fTrVCsbIEByxywKL/M2ziCWfsfhOqlnAAht9fMb5zhDHd43xUK/sJr
         hcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719538466; x=1720143266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnvbgBjmT2j00SWL77w/wmw1cd/5GofeGMuapdrdl3U=;
        b=cXSdK12NDbX5dMnG+OhY6ZbzylIONUd+kxwn5gJPnz5ezcO/SMzCUKBKCT1cZejyo1
         qW8iqCNPoX08C4G7ad4eltF2EA29q8OCufFeKTVFsipnuvT6fUN9PToSpO2QS/32wg6K
         EH3X442+xegi1FnqENrXXGyYoSso9Y9RZvkk6I4HUczhXffBEhgemZdMCah+/aKvz46T
         6RpbMzbJRX9nz0WV+h/vD84g3lkSiEU7o3XHlhiqLNpq+/HVqWCHgkKrXYjbOV+Qsesc
         y33IFfgyRZjvVJVawfqQRtQGdeUSnxALjfBr5NYs5cgJ5cNwg7dlloCL8M4ongKx2WCS
         G4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUynNu4IwsNlKVLQqjaZvGVtH6pHVm4j8tY8xqVbci35Sv2OimJq057epPRFWz3C2oYWGS3U+IoDed6Fpc9uDJNbcSGa6gC515WwWDkZ/QG7rZgTQzdrCZ0mj4rI5XF+fJc
X-Gm-Message-State: AOJu0Yxs/rt+khY8uiy4Uk9vIXkoh3t70bTHn7gcKtGxhlc0RWasZPMh
	JeGYkxL0guNGp1gNbqf/rshPLwOHvHVH3i+F79FPI5nWuFdJlb3iFYOcd1t+etQhmerdeD0toK5
	viR9ZHaN2GQd+5Pp2jXbevklClHJgdcO7
X-Google-Smtp-Source: AGHT+IGW6vS18JQdvcuaosTgfTX2kjePBtN2gY5E87HIqzc7Nd3vlLCPrXvCcCx3k5gUpKoFtlMzJgl6D/aonoEMyaI=
X-Received: by 2002:a05:6000:459a:b0:363:7bbf:efcc with SMTP id
 ffacd0b85a97d-366e96bef86mr8625498f8f.62.1719538465465; Thu, 27 Jun 2024
 18:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zn4BupVa65CVayqQ@slm.duckdns.org> <Zn4Cw4FDTmvXnhaf@slm.duckdns.org>
In-Reply-To: <Zn4Cw4FDTmvXnhaf@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jun 2024 18:34:14 -0700
Message-ID: <CAADnVQJym9sDF1xo1hw3NCn9XVPJzC1RfqtS4m2yY+YMOZEJYA@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.11 2/2] sched_ext: Implement scx_bpf_consume_task()
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 5:24=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Implement scx_bpf_consume_task() which allows consuming arbitrary tasks o=
n
> the DSQ in any order while iterating in the dispatch path.
>
> scx_qmap is updated to implement periodic dumping of the shared DSQ and a
> rather silly prioritization mechanism to demonstrate the use of DSQ
> iteration and selective consumption.
>
> Note that it does a bit of nastry dance to pass in the pointer to the
> iterator to __scx_bpf_consume_task(). This is to work around the current
> limitation in the BPF verifier where it doesn't allow the memory area use=
d
> for an iterator to be passed into kfuncs. This may be too nasty and might
> require a different approach.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: bpf@vger.kernel.org
> ---
> Hello, again.
>
> (continuing from the previous patch) so, the problem is that I need to
> distinguish the tasks which have left a queue and then get requeued while=
 an
> iteration is in progress. The iterator itself already does this - it
> remembers a sequence number when iteration starts and ignores tasks which
> are queued afterwards.
>
> As a task can get removed and requeued anytime, I need
> scx_bpf_consume_task() to do the same testing, so I want to pass in the
> iterator pointer into scx_bpf_consume_task() so that it can read the
> sequence number stored in the iterator. However, BPF doesn't allow this, =
so
> I'm doing the weird self pointer probe read thing, to obtain it, which is
> quite nasty.
>
> What do you think?
>
> Thanks.
>
>  kernel/sched/ext.c                       |   89 ++++++++++++++++++++++++=
+++++--
>  tools/sched_ext/include/scx/common.bpf.h |   16 +++++
>  tools/sched_ext/scx_qmap.bpf.c           |   34 ++++++++++-
>  tools/sched_ext/scx_qmap.c               |   14 +++-
>  4 files changed, 142 insertions(+), 11 deletions(-)
>
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1122,6 +1122,12 @@ enum scx_dsq_iter_flags {
>  };
>
>  struct bpf_iter_scx_dsq_kern {
> +       /*
> +        * Must be the first field. Used to work around BPF restriction a=
nd pass
> +        * in the iterator pointer to scx_bpf_consume_task().
> +        */
> +       struct bpf_iter_scx_dsq_kern    *self;
> +
>         struct scx_dsq_node             cursor;
>         struct scx_dispatch_q           *dsq;
>         u32                             dsq_seq;
> @@ -1518,7 +1524,7 @@ static void dispatch_enqueue(struct scx_
>         p->scx.dsq_seq =3D dsq->seq;
>
>         dsq_mod_nr(dsq, 1);
> -       p->scx.dsq =3D dsq;
> +       WRITE_ONCE(p->scx.dsq, dsq);
>
>         /*
>          * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on th=
e
> @@ -1611,7 +1617,7 @@ static void dispatch_dequeue(struct rq *
>                 WARN_ON_ONCE(task_linked_on_dsq(p));
>                 p->scx.holding_cpu =3D -1;
>         }
> -       p->scx.dsq =3D NULL;
> +       WRITE_ONCE(p->scx.dsq, NULL);
>
>         if (!is_local)
>                 raw_spin_unlock(&dsq->lock);
> @@ -2107,7 +2113,7 @@ static void consume_local_task(struct rq
>         list_add_tail(&p->scx.dsq_node.list, &rq->scx.local_dsq.list);
>         dsq_mod_nr(dsq, -1);
>         dsq_mod_nr(&rq->scx.local_dsq, 1);
> -       p->scx.dsq =3D &rq->scx.local_dsq;
> +       WRITE_ONCE(p->scx.dsq, &rq->scx.local_dsq);
>         raw_spin_unlock(&dsq->lock);
>  }
>
> @@ -5585,12 +5591,88 @@ __bpf_kfunc bool scx_bpf_consume(u64 dsq
>         }
>  }
>
> +/**
> + * __scx_bpf_consume_task - Transfer a task from DSQ iteration to the lo=
cal DSQ
> + * @it: DSQ iterator in progress
> + * @p: task to consume
> + *
> + * Transfer @p which is on the DSQ currently iterated by @it to the curr=
ent
> + * CPU's local DSQ. For the transfer to be successful, @p must still be =
on the
> + * DSQ and have been queued before the DSQ iteration started. This funct=
ion
> + * doesn't care whether @p was obtained from the DSQ iteration. @p just =
has to
> + * be on the DSQ and have been queued before the iteration started.
> + *
> + * Returns %true if @p has been consumed, %false if @p had already been =
consumed
> + * or dequeued.
> + */
> +__bpf_kfunc bool __scx_bpf_consume_task(unsigned long it, struct task_st=
ruct *p)
> +{
> +       struct bpf_iter_scx_dsq_kern *kit =3D (void *)it;
> +       struct scx_dispatch_q *dsq, *kit_dsq;
> +       struct scx_dsp_ctx *dspc =3D this_cpu_ptr(scx_dsp_ctx);
> +       struct rq *task_rq;
> +       u64 kit_dsq_seq;
> +
> +       /* can't trust @kit, carefully fetch the values we need */
> +       if (get_kernel_nofault(kit_dsq, &kit->dsq) ||
> +           get_kernel_nofault(kit_dsq_seq, &kit->dsq_seq)) {
> +               scx_ops_error("invalid @it 0x%lx", it);
> +               return false;
> +       }

With scx_bpf_consume_task() it's only a compile time protection from bugs.
Since kfunc doesn't dereference any field in kit_dsq it won't crash
immediately, but let's figure out how to make it work properly.

Since kit_dsq and kit_dsq_seq are pretty much anything in this implementati=
on
can they be passed as two scalars instead ?
I guess not, since tricking dsq !=3D kit_dsq and
time_after64(..,kit_dsq_seq) can lead to real issues ?

Can some of it be mitigated by passing dsq into kfunc that
was used to init the iter ?
Then kfunc will read dsq->seq from it instead of kit->dsq_seq ?

> +
> +       /*
> +        * @kit can't be trusted and we can only get the DSQ from @p. As =
we
> +        * don't know @p's rq is locked, use READ_ONCE() to access the fi=
eld.
> +        * Derefing is safe as DSQs are RCU protected.
> +        */
> +       dsq =3D READ_ONCE(p->scx.dsq);
> +
> +       if (unlikely(!dsq || dsq !=3D kit_dsq))
> +               return false;
> +
> +       if (unlikely(dsq->id =3D=3D SCX_DSQ_LOCAL)) {
> +               scx_ops_error("local DSQ not allowed");
> +               return false;
> +       }
> +
> +       if (!scx_kf_allowed(SCX_KF_DISPATCH))
> +               return false;
> +
> +       flush_dispatch_buf(dspc->rq, dspc->rf);
> +
> +       raw_spin_lock(&dsq->lock);
> +
> +       /*
> +        * Did someone else get to it? @p could have already left $dsq, g=
ot
> +        * re-enqueud, or be in the process of being consumed by someone =
else.
> +        */
> +       if (unlikely(p->scx.dsq !=3D dsq ||
> +                    time_after64(p->scx.dsq_seq, kit_dsq_seq) ||

In the previous patch you do:
(s32)(p->scx.dsq_seq - kit->dsq_seq) > 0
and here
time_after64().
Close enough, but 32 vs 64 and equality difference?

> +                    p->scx.holding_cpu >=3D 0))
> +               goto out_unlock;
> +
> +       task_rq =3D task_rq(p);
> +
> +       if (dspc->rq =3D=3D task_rq) {
> +               consume_local_task(dspc->rq, dsq, p);
> +               return true;
> +       }
> +
> +       if (task_can_run_on_remote_rq(p, dspc->rq))
> +               return consume_remote_task(dspc->rq, dspc->rf, dsq, p, ta=
sk_rq);
> +
> +out_unlock:
> +       raw_spin_unlock(&dsq->lock);
> +       return false;
> +}
> +
>  __bpf_kfunc_end_defs();

