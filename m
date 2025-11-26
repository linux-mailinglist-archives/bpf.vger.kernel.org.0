Return-Path: <bpf+bounces-75531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C248CC87DC3
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 03:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97B554E65E9
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 02:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7627423ABBD;
	Wed, 26 Nov 2025 02:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id6AJ6Tg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC4800
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125184; cv=none; b=e9R4XYcmbKR1mfuexQjCezGMGylM48ZAeR44budKYRgCtto4Ro09jv0shPEW9UdoqjNoQxJyK85EJe5bkH9XLW5+qdzOcMKgnbB2bL++7kLs7NKrYhDu3KHu4fG5t6XS8j6MgyrJfzFQPFWQdUrlZuwPwMrilgiLI1DpD7ukuUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125184; c=relaxed/simple;
	bh=Dk5VHypHWccCMB+mZv0+tX6fa0D/hhBcJaHRsM1yU8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aw89qWXWnWz8ecTmJGGCP4fV0KZwOjzP6ZtG8vWYzUgA5PCUdyYDzumYKEn6emBT+V1pgxqzTxS7nmwYag3QzOWyouZ9clIrlXRGmYIlZyVCkNHUhpzkyglILbEoQHqejWeLOXrTspi5MBGsWnimH1zVHOxkFjXPzHAlikwZjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id6AJ6Tg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779a637712so37933345e9.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 18:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764125180; x=1764729980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxnYGQ4ZU8DFsUeROQ3f1oN698nCx5R0ZweVP5rcMI0=;
        b=id6AJ6Tgrz126VfBLjGNLiawEO2uxEhVWJPjLcMcI/zA/IpxtRPrcMkr2p9EmLzPYU
         TOfIHWj+Blno6XNTaX4keIwwPD6EAa+TWF80XDBbO+ioEzUcTSauOUwoj0iKyJxURRJd
         iKt3ctcFrRDtPivMs50P4QM4+qt33Lnf7omooD24f9iDSe9l5Aw00f+83h7FFRUBI5X7
         qn51m8ELvNfGzNACr0QkmXnH5RlRtZK91kwZpEj4bd/GZ5ztJhMNNQT2q3d1U+MfMsjq
         3hHOdzUkyYCp9jFQPL/mee4XFq30mOpNsgUJu5mslgHalWWyxLQksPiQqHkN1Nbcx3xu
         1oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764125180; x=1764729980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YxnYGQ4ZU8DFsUeROQ3f1oN698nCx5R0ZweVP5rcMI0=;
        b=NK2PtBQXOhgr5Rrdg9Kr2iJ/XHo7i6y8KLdQhbTmxIgW7X4+Fp5JMBkizlCTzDz7UH
         Pw0hu4Yoyx2DiNJnTlCFAFLxsbKXxT0wltFppkaSv0FlQVpoFK56Vgp8gl0A9nhOYDN7
         jN52xOKiXQCfnjPZSV4O1so7UE6iJ5PtrEvQpjXEwpe8BjnPu4ti2bDa1EITP0lNga3g
         TFTAvTsOx9RsQ9rMG2sWx9WSjBqlsHWoKjGodKPWyKj1JNv9oYcTOfqZK5LVrn/51u1R
         pKB2DPHgirdB0Rfy49RMgilv9F1toRYby3upM1aJ8GndcxketXTMuqjubhMSVR8EnOxu
         Plmg==
X-Gm-Message-State: AOJu0YxZvLv03KryjsMOmBRXpTcLe2BK+Ij0wK60kOkOMIn16k6Se7wk
	7COiQWphARAmkS6t4890zNeUDIM+SNzpMt6gTF5NNgIcqeIsc2ieXzfoSxj5L28Q11zSDAUtyp4
	xML/DwBhAKJkSqdD7NAmUD80w54CMK2IGZ0pI
X-Gm-Gg: ASbGncvfXJwD6JTsPw+tRBsFIoH9E8aFjCh37Uky0hm/5PDYAelDQvl/qd35Ye7JXoz
	cj8tdH1qRZEcAGQNCO/sCh0SG3Bjb8vIhSLMKvnNqKbZkxQDrAPB+6Qn+M8pN0meYvjyginVCrJ
	07sSpvNZt9VXIAXucJ24GD41EAL1GCySFakRvg7Bzawxetj+McPxZmssdntDhee69MVKsjfp/vH
	eAFaBsad57GeMFkEP0sTSsshob/ctP4OXz7OslF08rXbMj57I0gU+NPSuMnfZljblZ9fRKgRrkm
	AYKsng3fcAihwX2cVEyOwWXpsuUu
X-Google-Smtp-Source: AGHT+IEY8R9vf2dBWN+fUqv61oHpjR3ktd+1W3DjLLm94MzBDnGLgv6/80CHy/izOyw1YISZXEbkriGvAuUw9q8anko=
X-Received: by 2002:a05:600c:8b16:b0:477:94e3:8a96 with SMTP id
 5b1f17b1804b1-477c01b512cmr139532805e9.20.1764125179835; Tue, 25 Nov 2025
 18:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125203253.3287019-1-memxor@gmail.com>
In-Reply-To: <20251125203253.3287019-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Nov 2025 18:46:08 -0800
X-Gm-Features: AWmQ_bmv3iTP_hwIOShXFqZXBYXTubkidmsHiMC9-JxUYn-iM3V4BkkuZrJfugc
Message-ID: <CAADnVQ+HV+p6P8eLFz8Nsp2=apE8KYGAxTY3LJ0vQoy3AV42uw@mail.gmail.com>
Subject: Re: [PATCH bpf v1] rqspinlock: Enclose lock/unlock within lock entry acquisitions
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>, Jelle van der Beek <jelle@superluminal.eu>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 12:33=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> We currently have a tiny window between the fast-path cmpxchg and the
> grabbing of the lock entry where an NMI could land, attempt the same
> lock that was just acquired, and end up timing out. This is not ideal.
> Instead, move the lock entry acquisition from the fast path to before
> the cmpxchg, and remove the grabbing of the lock entry in the slow path,
> assuming it was already taken by the fast path.
>
> There is a similar case when unlocking the lock. If the NMI lands
> between the WRITE_ONCE and smp_store_release, it is possible that we end
> up in a situation where the NMI fails to diagnose the AA condition,
> leading to a timeout.
>
> The TAS fallback is invoked directly without being preceded by the
> typical fast path, therefore we must continue to grab the deadlock
> detection entry in that case.
>
> Note the changes to the comments in release_held_lock_entry and
> res_spin_unlock. They talk about prevention of the following scenario,
> which is introduced by this commit, and was avoided by placing
> smp_store_release after WRITE_ONCE (the case before this commit):
>
> grab entry A
> lock A
> grab entry B
> lock B
> unlock B
>    smp_store_release(B->locked, 0)
>                                                         grab entry B
>                                                         lock B
>                                                         grab entry A
>                                                         lock A
>                                                         ! <detect ABBA>
>    WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL)
>
> If the store release were placed after the WRITE_ONCE, the other CPU
> would not observe B in the table of the CPU unlocking the lock B.

I think the above should be reworded. It sounds like an excuse instead
of explaining why it's done this way. I would say it like:

This patch changes order to: smp_store_relase(); WRITE_ONCE()
to avoid missing detection of AA deadlock in case of:
... new diagram...

The reverse order: WRITE_ONCE(); smp_store_release() was there
to prevent misdiagnosing ABBA in the following scenario...
... your diagram...
but CPUs are actually participating in ABBA deadlock, so it wasn't
exactly a misdiagnosis.

> Avoiding this while it was convenient was a prudent choice, but since it
> leads to missed diagnosis of AA deadlocks in case of NMIs, it does not
> make sense to keep such ordering any further. Moreover, while this
> particular schedule is a misdiagnosis, the CPUs are obviously
> participating in an ABBA deadlock otherwise, and are only lucky to avoid
> an error before due to the aforementioned race.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Fixes tag is missing.

> ---
>  include/asm-generic/rqspinlock.h | 66 ++++++++++++++++++--------------
>  kernel/bpf/rqspinlock.c          | 15 +++-----
>  2 files changed, 43 insertions(+), 38 deletions(-)
>
> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspi=
nlock.h
> index 6d4244d643df..2da3f1391914 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -129,8 +129,8 @@ static __always_inline void release_held_lock_entry(v=
oid)
>          * <error> for lock B
>          * release_held_lock_entry
>          *
> -        * try_cmpxchg_acquire for lock A
>          * grab_held_lock_entry
> +        * try_cmpxchg_acquire for lock A
>          *
>          * Lack of any ordering means reordering may occur such that dec,=
 inc
>          * are done before entry is overwritten. This permits a remote lo=
ck
> @@ -139,13 +139,8 @@ static __always_inline void release_held_lock_entry(=
void)
>          * CPU holds a lock it is attempting to acquire, leading to false=
 ABBA
>          * diagnosis).
>          *
> -        * In case of unlock, we will always do a release on the lock wor=
d after
> -        * releasing the entry, ensuring that other CPUs cannot hold the =
lock
> -        * (and make conclusions about deadlocks) until the entry has bee=
n
> -        * cleared on the local CPU, preventing any anomalies. Reordering=
 is
> -        * still possible there, but a remote CPU cannot observe a lock i=
n our
> -        * table which it is already holding, since visibility entails ou=
r
> -        * release store for the said lock has not retired.
> +        * The case of unlock is treated differently due to NMI reentranc=
y, see
> +        * comments in res_spin_unlock.
>          *
>          * In theory we don't have a problem if the dec and WRITE_ONCE ab=
ove get
>          * reordered with each other, we either notice an empty NULL entr=
y on
> @@ -175,10 +170,16 @@ static __always_inline int res_spin_lock(rqspinlock=
_t *lock)
>  {
>         int val =3D 0;
>
> -       if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED=
_VAL))) {
> -               grab_held_lock_entry(lock);
> +       /*
> +        * Grab the deadlock detection entry before doing the cmpxchg, so=
 that
> +        * reentrancy due to NMIs between the succeeding cmpxchg and crea=
tion of
> +        * held lock entry can correctly detect an acquisition attempt in=
 the
> +        * interrupted context.

I would add AA diagram here to the comment as well.

> +        */
> +       grab_held_lock_entry(lock);
> +
> +       if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED=
_VAL)))
>                 return 0;
> -       }
>         return resilient_queued_spin_lock_slowpath(lock, val);
>  }
>
> @@ -192,28 +193,35 @@ static __always_inline void res_spin_unlock(rqspinl=
ock_t *lock)
>  {
>         struct rqspinlock_held *rqh =3D this_cpu_ptr(&rqspinlock_held_loc=
ks);
>
> -       if (unlikely(rqh->cnt > RES_NR_HELD))
> -               goto unlock;
> -       WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
> -unlock:
>         /*
> -        * Release barrier, ensures correct ordering. See release_held_lo=
ck_entry
> -        * for details.  Perform release store instead of queued_spin_unl=
ock,
> -        * since we use this function for test-and-set fallback as well. =
When we
> -        * have CONFIG_QUEUED_SPINLOCKS=3Dn, we clear the full 4-byte loc=
kword.
> +        * Release barrier, ensures correct ordering. Perform release sto=
re
> +        * instead of queued_spin_unlock, since we use this function for =
the TAS
> +        * fallback as well. When we have CONFIG_QUEUED_SPINLOCKS=3Dn, we=
 clear
> +        * the full 4-byte lockword.
> +        */
> +       smp_store_release(&lock->locked, 0);
> +       if (likely(rqh->cnt <=3D RES_NR_HELD))
> +               WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
> +       /*
> +        * Unlike release_held_lock_entry, we do the lock word release be=
fore
> +        * rewriting the entry back to NULL, and place no ordering betwee=
n the
> +        * WRITE_ONCE and dec, and possible reordering with grabbing an e=
ntry.

The above is quite misleading.
"Unlike release_held_lock_entry" applies to the 2nd part of the sentence
"possible reordering" and doesn't apply at all to "lock word release".
There is no lock word release in release_held_lock_entry().

> +        *
> +        * This opens up a window where another CPU could acquire this lo=
ck, and
> +        * then observe it in our table on the current CPU, leading to po=
ssible
> +        * misdiagnosis of ABBA when we get reordered with a
> +        * grab_held_lock_entry's writes (see the case described in
> +        * release_held_lock_entry comments).

Just drop this part. "Misdiagnosis of ABBA" is not quite correct.
As you said CPUs are participating in ABBA, so it's real ABBA.
The commit log description is enough.

>          *
> -        * Like release_held_lock_entry, we can do the release before the=
 dec.
> -        * We simply care about not seeing the 'lock' in our table from a=
 remote
> -        * CPU once the lock has been released, which doesn't rely on the=
 dec.
> +        * This could be avoided if we did the smp_store_release right be=
fore
> +        * the dec, ensuring that the remote CPU could only acquire this =
lock
> +        * and never observe this lock in our table.

Another unnecessary comment. Let's not reflect over old code.
The comment should describe what the code does. For history there is git.

>          *
> -        * Unlike smp_wmb(), release is not a two way fence, hence it is
> -        * possible for a inc to move up and reorder with our clearing of=
 the
> -        * entry. This isn't a problem however, as for a misdiagnosis of =
ABBA,
> -        * the remote CPU needs to hold this lock, which won't be release=
d until
> -        * the store below is done, which would ensure the entry is overw=
ritten
> -        * to NULL, etc.
> +        * However, that opens up a window where reentrant NMIs on this s=
ame
> +        * CPU could have their AA heuristics fail to fire if they land b=
etween
> +        * the WRITE_ONCE and unlock release store, which would result in=
 a
> +        * timeout.
>          */
> -       smp_store_release(&lock->locked, 0);
>         this_cpu_dec(rqspinlock_held_locks.cnt);
>  }
>
> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 3cc23d79a9fc..878d641719da 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -275,6 +275,10 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t =
*lock)
>         int val, ret =3D 0;
>
>         RES_INIT_TIMEOUT(ts);
> +       /*
> +        * The fast path is not invoked for the TAS fallback, so we must =
grab
> +        * the deadlock detection entry here.
> +        */
>         grab_held_lock_entry(lock);
>
>         /*
> @@ -397,10 +401,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(r=
qspinlock_t *lock, u32 val)
>                 goto queue;
>         }
>
> -       /*
> -        * Grab an entry in the held locks array, to enable deadlock dete=
ction.
> -        */
> -       grab_held_lock_entry(lock);
> +       /* Deadlock detection entry already held after failing fast path.=
 */
>
>         /*
>          * We're pending, wait for the owner to go away.
> @@ -448,11 +449,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(r=
qspinlock_t *lock, u32 val)
>          */
>  queue:
>         lockevent_inc(lock_slowpath);
> -       /*
> -        * Grab deadlock detection entry for the queue path.
> -        */
> -       grab_held_lock_entry(lock);
> -
> +       /* Deadlock detection entry already held after failing fast path.=
 */

Overall all makes sense to me, but I thought the patch will fix
these messages from stress test:

[   12.636716] INFO: NMI handler (perf_event_nmi_handler) took too
long to run: 12.473 msecs
[   12.785373] INFO: NMI handler (perf_event_nmi_handler) took too
long to run: 261.095 msecs
[   21.455161]    >=3D 251ms: total 5 (normal 0, nmi 5)

but the stats seem to be the same before and after the patch
when I played with the patch in bpf-next.

I suspect there is more here to discover.
Since we're running out of time, bpf-next is fine for respin.

pw-bot: cr

