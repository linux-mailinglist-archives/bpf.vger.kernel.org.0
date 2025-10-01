Return-Path: <bpf+bounces-70111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C55BB1313
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 17:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 095097A62D3
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB992820D5;
	Wed,  1 Oct 2025 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjrQM2AZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC91459FA
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334205; cv=none; b=kanxM6L6P3rsowL/w5shEEHy8sPiue6g35KY2feuTnpTtnjMcg7qISYzdYOpff+1k9f+JGpH9ZubmvQ8gwvzlmLOrhUHVjkZMKqODOOvXMPCE5W8ctz9guQF6g2HipheBLKcIHBtnKxStjMFnPi1VMKKsqIGuePTdnqhQThEkz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334205; c=relaxed/simple;
	bh=5ZPYbpGyZDIdfh51iVa9VRlQsRuSu4CKGpHVvUHwSZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvUcyiFqZ8O/fs9V8gh9kRtaK6Dznv/HeABAt0dgq+OqA5wtsNmibgWGjNHsI77wTKzJzoXwRb9gkImS/LI2kRf0MPkzjRpXpgZPvLQ5SSQ4ToI/VsxK7bC2YcqhXC5SIIn38ZmhJU5UuT/+6v+Bn1JDPcPXZkBTyN127QE4ENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjrQM2AZ; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6366d48d8ccso109050a12.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759334202; x=1759939002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OpsmXWhjZqaaQQGfLidiX2hFFk5yX6xF3Tyq2LqOQMI=;
        b=HjrQM2AZPFGG33zIIKQjlCSN6oL+SQS1wBy3xl7nCz/PPzpiyBXgvgc83DuKBJERxo
         Ht0Kd0NPCUjBQ5zbgZMme9zvFDnI7LxC8kzAyyZj3y5ZYrHORaGEvUeE5bc400LY633W
         9djbelojTB3XWUkNg3ckX38x4NHUnF954wYYQgz0Jlvj4g9c8uW6uqtTNhKWdtiPVIB/
         4XosTdC88noAanBam8VVrMsq+HaxUseo0SPnaufLy2o4RnuXDkMU9mjId+UO+WNk09RC
         pePgQKK68VEqwh20qBd4uXQTLgDJKZRzpE/VdkoR67gXZ05wcLNI/ujzpO6Qaf+V5rl0
         STeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334203; x=1759939003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpsmXWhjZqaaQQGfLidiX2hFFk5yX6xF3Tyq2LqOQMI=;
        b=PcQpNFAVtIYmPifIiIKC0Mx5C88VEZS3cWajVNHd2k0YPYzcqMCRnkjNGUa1zJsV9D
         b1lZD2RwO0cjkhv5lF+CdTjdEHi5fzuiKgMiOUA14wdceriu74r2Nopw5VVgfXb1oG1a
         2JrP/9acUZYEw+C8WZjkIG7Dy5rC2Cbe3yU9cqQEfiQr7wWHrkF7RQqe34zjdMLEnN2Y
         0RBJsKTwWA9//HSJ7K7uSgszZlL5/T4VDWKyIWMad7d6o1enfMxRuMBXulnz9vRWzktR
         Fyn/I1EJzsCl5Aj5Dz+TBla8ouHt7Nrv4pnUKLmEIbrqgo3h2PmN60k3+TLYf/2qUrrV
         toFg==
X-Gm-Message-State: AOJu0Yz7GVQKiPSDZwT0GTax5j+UD7hbCmOE97FIdnWav/p9dOQhXz13
	7m5pvVWeDbB2sDUAQzwgXVo7nMJ0zdJrLpi5eNYBKSGIkNcdI+CKi4t9S9ZDonOD8g/oEDJkwf0
	u/GwIf8LQYMzMaDsLpYMjl76X63KbvG8=
X-Gm-Gg: ASbGncue8JNc1Ym5C/E50fGNjLq12ikQ48i9gxTOOW22bNrpICVQhnaV+q7us88csQS
	irP8jR1NIZ3b6hLvNhuCCh0eltjXlScouI9TPJeV72jjviJDRA2anMYFMmR0uiX7cnMf+XqsGxy
	DlqkP+Z1/gXr86QaqZqoT+X+C27CL0UkaFlvDEEh0fABhF1xJnbM1gUAIfMDujykWNrXV46x3PA
	/Y+dIf3mM/jQ0TzKWzvmzLLX1DDieaeyior9/k/euzIeI4Fd1HWNkhZPip+m4Qm/g==
X-Google-Smtp-Source: AGHT+IHq/fbJ6OALEFQEB+yg/VFRtObMf7FNC7SoaHVATLgkI1G/LJRG4BCT7j4SV6cLKjz9jbLWzjvtcj6YA7uZnAk=
X-Received: by 2002:a05:6402:4313:b0:634:4eff:586a with SMTP id
 4fb4d7f45d1cf-63678bb8a96mr4530982a12.11.1759334202332; Wed, 01 Oct 2025
 08:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930022354.16248-1-sidchintamaneni@gmail.com>
In-Reply-To: <20250930022354.16248-1-sidchintamaneni@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 1 Oct 2025 17:56:06 +0200
X-Gm-Features: AS18NWAsIJhj22V4ojaJmbRT-2a8SwzUF5r5X7u6E0-0pr0am5EovlrYB9yVqAA
Message-ID: <CAP01T74CxRZEXQfySVda0JsQDA1dszB514bOZatG5d0SVmKaZw@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf: Add deadlock check at the entry of slowpath
 for quick exit
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, rjsu26@gmail.com, 
	miloc@vt.edu
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Sept 2025 at 04:24, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> A single deadlock check at the start of slowpath function
> enables quick deadlock detection. This additional check don't
> create any overhead because same check happens in both pending
> and queuing cases during contention. Also cleaned up the unused
> function args in check_deadlock* functions.

What's the motivation? Are you trying to address the bug that the
recent in_nmi() fix tried to work around?
Note that I'm working on a proper fix; just doing deadlock detection
on entry into non-head waiter slow path is not sufficient,
as the table updates for held locks is racy and can populate a
deadlock-signalling combination right after our check, so it needs to
happen repeatedly.

>
> I've checked the resilient spinlocks cover letter for benchmarks
> to run but I couldn't figure out the link to run those benchmarks.
> Can you point me to those benchmarks so that I can run that with
> this change?

All benchmark scripts are here: https://github.com/kkdwivedi/rqspinlock
But they can also be run manually. I ran will-it-scale and locktorture
back then.
The description of which locks contend for various cases
(openN_threads, lockN_threads) is in the CNA paper. [0]

  [0]: https://arxiv.org/pdf/1810.05600

>
> Fixes: a8fcf2a ("locking: Copy out qspinlock.c to kernel/bpf/rqspinlock.c")
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  kernel/bpf/rqspinlock.c | 45 ++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index a00561b1d3e5..6ec4e97a73a2 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -89,15 +89,14 @@ struct rqspinlock_timeout {
>  DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
>  EXPORT_SYMBOL_GPL(rqspinlock_held_locks);
>
> -static bool is_lock_released(rqspinlock_t *lock, u32 mask, struct rqspinlock_timeout *ts)
> +static bool is_lock_released(rqspinlock_t *lock, u32 mask)
>  {
>         if (!(atomic_read_acquire(&lock->val) & (mask)))
>                 return true;
>         return false;
>  }
>
> -static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
> -                                     struct rqspinlock_timeout *ts)
> +static noinline int check_deadlock_AA(rqspinlock_t *lock)
>  {
>         struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
>         int cnt = min(RES_NR_HELD, rqh->cnt);
> @@ -118,8 +117,7 @@ static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
>   * more locks, which reduce to ABBA). This is not exhaustive, and we rely on
>   * timeouts as the final line of defense.
>   */
> -static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
> -                                       struct rqspinlock_timeout *ts)
> +static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
>  {
>         struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
>         int rqh_cnt = min(RES_NR_HELD, rqh->cnt);
> @@ -142,7 +140,7 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
>                  * Let's ensure to break out of this loop if the lock is available for
>                  * us to potentially acquire.
>                  */
> -               if (is_lock_released(lock, mask, ts))
> +               if (is_lock_released(lock, mask))
>                         return 0;
>
>                 /*
> @@ -198,15 +196,14 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
>         return 0;
>  }
>
> -static noinline int check_deadlock(rqspinlock_t *lock, u32 mask,
> -                                  struct rqspinlock_timeout *ts)
> +static noinline int check_deadlock(rqspinlock_t *lock, u32 mask)
>  {
>         int ret;
>
> -       ret = check_deadlock_AA(lock, mask, ts);
> +       ret = check_deadlock_AA(lock);
>         if (ret)
>                 return ret;
> -       ret = check_deadlock_ABBA(lock, mask, ts);
> +       ret = check_deadlock_ABBA(lock, mask);
>         if (ret)
>                 return ret;
>
> @@ -234,7 +231,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
>          */
>         if (prev + NSEC_PER_MSEC < time) {
>                 ts->cur = time;
> -               return check_deadlock(lock, mask, ts);
> +               return check_deadlock(lock, mask);

This removal of unused arguments still looks useful, please send it as
a separate clean up.

>         }
>
>         return 0;
> @@ -350,7 +347,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
>         struct mcs_spinlock *prev, *next, *node;
>         struct rqspinlock_timeout ts;
>         int idx, ret = 0;
> -       u32 old, tail;
> +       u32 old, tail, mask = _Q_LOCKED_MASK;
>
>         BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
>
> @@ -359,6 +356,21 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
>
>         RES_INIT_TIMEOUT(ts);
>
> +       /*
> +        * Grab an entry in the held locks array, to enable deadlock detection
> +        */
> +       grab_held_lock_entry(lock);
> +
> +       if (val & _Q_PENDING_VAL)
> +               mask = _Q_LOCKED_PENDING_MASK;
> +
> +       /*
> +        * Do a deadlock check on the entry of the slowpath
> +        */
> +       ret = check_deadlock(lock, mask);
> +       if (ret)
> +               goto err_release_entry;

As I explained above, this won't be sufficient. Imagine that there is
an ABBA case and we have A over B here,
but B over A hasn't had its A populated in the other CPU's table right
at this moment. Once you do the checks
here and conclude there isn't a deadlock, the write can go through,
and then you'd probably end up in a deadlock again.

Regardless, I think in general, it is not a good idea to add more
overhead to the slow path to detect rare cases such as deadlocks.
For correct code, they will never occur in practice, so all of this
quick detection cost is simply overhead that slows everyone down.
The ABBA checks are pretty expensive on big machines since the
complexity is O(N).

If you have time, please review patches that I plan to send improving
all of this for non-head waiters later on.
I will add you to the Cc list.

Thanks

>
>  [...]
>

