Return-Path: <bpf+bounces-49120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9753AA1443B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 22:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DCA16B9D8
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C68E230D15;
	Thu, 16 Jan 2025 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYY0ccsZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADC214901B;
	Thu, 16 Jan 2025 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064388; cv=none; b=meDi9jITt9RDkQF9NXXx5VzORSC6fM+n0OQCfFcc4RaCba0yrsiArCvZj6UIktBsnT3wu2v5qAVVHJVTX9IGZ79aF35RMP+mrb/PpI3WjvNyhVCS/WCv1BZhrxsmHIOowO4JoWSpKVBfp9LLUhBJreCzXXUxLrWypLvN0lCaNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064388; c=relaxed/simple;
	bh=SeHloezTbjW9bMEcH6+wOXPQRnWfjBtao5z2WKIOkyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jh0zyNKCQE6n5Po0oNbbNZL/ayU+f4sguQdeow400ilu1+UwcrVLqKOevLsLnOHQmXkKR5JFYR0HLKA+Eqh121b22wXiJnf24hwLhLIRcN3NkA/ypeUZs2pG5xkDrNjWm2OIliz8DCAGp77QDoZMU5++nqxRYM6yfBI2waL8Wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYY0ccsZ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso2535218a91.0;
        Thu, 16 Jan 2025 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737064385; x=1737669185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=017FVHUck5ginlKCizisWOMpwe2VanxZqNYmJxNRnBs=;
        b=EYY0ccsZhi0ASc4FVARZM+OsbKiQ+ACmNMCSov6jkkdgGw5hZHgT7w8zkA6ElYlJY2
         fkVsMn6gXT365RHhvuXh/SoSDPg7gl0my0/4b1oLkR5U1IMnXuub22GvclpG4BF83uz/
         cndw1qXle+V31hAVeSyWShhWxXsYJw1jPNLlvUdLdDAv3UeXRRm6SzNyd31WWAla0Zxu
         3k85CNzMEzaxrOayQraKpsNBixzxlBzWk+D/34yEcMwRJGeOTYVQhHUMtmM6YmgkTpmn
         FCRl7OlA3O0yVaD9es5bAx2MJpi4qid6S0vMd/5dsC2D7YZI+uilHF37Xi1qgUvlE98G
         27FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737064385; x=1737669185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=017FVHUck5ginlKCizisWOMpwe2VanxZqNYmJxNRnBs=;
        b=nCs+FhUUA90uZlGqo4dQFIML5G59U+I5OawgVvyaAgn2JbTARkfVAIBinP0pVisifE
         J7JJVudFKKdeaGat+LS/HThZUTlBA5y7RLuL+a+k8vzo7qywzP705AOKvHxye3MfXo4/
         sfGAtZJYtaFbf9Yiigh31Tw4EcH4LUqCzri+ApP3C8cBKrq+kq4uBXZjjeFjLfpK3lF8
         DMQBYxwZZXmm4aeV6+pb8eVj4bCDX4S/2ilID+QjDSrTkG83f1Govt/Fmd5CxcbZe3pr
         Lh8NkTG9nrbynPXX0TOh/3pe8MiAnfFT+/iCgXpbTHg0FyNdjJZ6vCaVrnFq5B51IzuR
         tULQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd/U5j/VCNU4e+Y2ZaY85avXR+q6gtKFp1GW1j9/sggWdH1WazFM7X8Y5EqQtflFAe6gw=@vger.kernel.org, AJvYcCXxyckAcayERkfw4D8oSffiUX1wRWskEP+3i9K7foqLQUZim4gMUCrFM5kOgAjpV3vBvDVIk7phNhattR1e@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6B4Rbhbl6FFf0ZebReFjS5B2hKSMsi81wA/S45EjiV8hQGRpS
	fhk780Bwm1N/cOq+pdZDx841/aLSvkqe3bGlWclD5Pxv9ulPXn9Tm4MG7ZjzVuVbfrfwFskpH5Y
	kpfPWLiVKFeXaSHSMB6LojZqqD+Y=
X-Gm-Gg: ASbGncsIxlztePi6dk3TF4UJ+SgCGIAXeyzzBwwvHWmqIoERikeSdU472mIxECspNHf
	XfYKwRj/Zp0XNTsfsEJiCDkZflHKhWmzO9Eql
X-Google-Smtp-Source: AGHT+IFn44jMsvilB4KQUBvKoPmOgaj1RRoIahQAPACYLdMmJg5YM4y0yHw/0S52zLmeKoWcsU4rqtJ45UjSoXlEFtk=
X-Received: by 2002:a17:90b:540b:b0:2f2:8bdd:cd8b with SMTP id
 98e67ed59e1d1-2f782d972a2mr236595a91.29.1737064385409; Thu, 16 Jan 2025
 13:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop> <20250116202112.3783327-13-paulmck@kernel.org>
In-Reply-To: <20250116202112.3783327-13-paulmck@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Jan 2025 13:52:53 -0800
X-Gm-Features: AbW1kvabDox9PCVx6AHjkvCdcRWgAfizwaFVeav2bX57aX62gx2zmP9oYAMThxQ
Message-ID: <CAEf4BzYqAVuX1nP20qVaY8_CnDom699vzAjm7ZLaMx+oz8vceQ@mail.gmail.com>
Subject: Re: [PATCH rcu 13/17] srcu: Add SRCU-fast readers
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 12:21=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> This commit adds srcu_read_{,un}lock_fast(), which is similar
> to srcu_read_{,un}lock_lite(), but avoids the array-indexing and
> pointer-following overhead.  On a microbenchmark featuring tight
> loops around empty readers, this results in about a 20% speedup
> compared to RCU Tasks Trace on my x86 laptop.
>
> Please note that SRCU-fast has drawbacks compared to RCU Tasks
> Trace, including:
>
> o       Lack of CPU stall warnings.
> o       SRCU-fast readers permitted only where rcu_is_watching().
> o       A pointer-sized return value from srcu_read_lock_fast() must
>         be passed to the corresponding srcu_read_unlock_fast().
> o       In the absence of readers, a synchronize_srcu() having _fast()
>         readers will incur the latency of at least two normal RCU grace
>         periods.
> o       RCU Tasks Trace priority boosting could be easily added.
>         Boosting SRCU readers is more difficult.
>
> SRCU-fast also has a drawback compared to SRCU-lite, namely that the
> return value from srcu_read_lock_fast()-fast is a 64-bit pointer and
> that from srcu_read_lock_lite() is only a 32-bit int.
>
> [ paulmck: Apply feedback from Akira Yokosawa. ]
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <bpf@vger.kernel.org>
> ---
>  include/linux/srcu.h     | 47 ++++++++++++++++++++++++++++++++++++++--
>  include/linux/srcutiny.h | 22 +++++++++++++++++++
>  include/linux/srcutree.h | 38 ++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 2bd0e24e9b554..63bddc3014238 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -47,9 +47,10 @@ int init_srcu_struct(struct srcu_struct *ssp);
>  #define SRCU_READ_FLAVOR_NORMAL        0x1             // srcu_read_lock=
().
>  #define SRCU_READ_FLAVOR_NMI   0x2             // srcu_read_lock_nmisafe=
().
>  #define SRCU_READ_FLAVOR_LITE  0x4             // srcu_read_lock_lite().
> +#define SRCU_READ_FLAVOR_FAST  0x8             // srcu_read_lock_fast().
>  #define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAV=
OR_NMI | \
> -                               SRCU_READ_FLAVOR_LITE) // All of the abov=
e.
> -#define SRCU_READ_FLAVOR_SLOWGP        SRCU_READ_FLAVOR_LITE
> +                               SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_=
FAST) // All of the above.
> +#define SRCU_READ_FLAVOR_SLOWGP        (SRCU_READ_FLAVOR_LITE | SRCU_REA=
D_FLAVOR_FAST)
>                                                 // Flavors requiring sync=
hronize_rcu()
>                                                 // instead of smp_mb().
>  void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp=
);
> @@ -253,6 +254,33 @@ static inline int srcu_read_lock(struct srcu_struct =
*ssp) __acquires(ssp)
>         return retval;
>  }
>
> +/**
> + * srcu_read_lock_fast - register a new reader for an SRCU-protected str=
ucture.
> + * @ssp: srcu_struct in which to register the new reader.
> + *
> + * Enter an SRCU read-side critical section, but for a light-weight
> + * smp_mb()-free reader.  See srcu_read_lock() for more information.
> + *
> + * If srcu_read_lock_fast() is ever used on an srcu_struct structure,
> + * then none of the other flavors may be used, whether before, during,
> + * or after.  Note that grace-period auto-expediting is disabled for _fa=
st
> + * srcu_struct structures because auto-expedited grace periods invoke
> + * synchronize_rcu_expedited(), IPIs and all.
> + *
> + * Note that srcu_read_lock_fast() can be invoked only from those contex=
ts
> + * where RCU is watching, that is, from contexts where it would be legal
> + * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
> + */
> +static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_=
struct *ssp) __acquires(ssp)
> +{
> +       struct srcu_ctr __percpu *retval;
> +
> +       srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
> +       retval =3D __srcu_read_lock_fast(ssp);
> +       rcu_try_lock_acquire(&ssp->dep_map);
> +       return retval;
> +}
> +
>  /**
>   * srcu_read_lock_lite - register a new reader for an SRCU-protected str=
ucture.
>   * @ssp: srcu_struct in which to register the new reader.
> @@ -356,6 +384,21 @@ static inline void srcu_read_unlock(struct srcu_stru=
ct *ssp, int idx)
>         __srcu_read_unlock(ssp, idx);
>  }
>
> +/**
> + * srcu_read_unlock_fast - unregister a old reader from an SRCU-protecte=
d structure.
> + * @ssp: srcu_struct in which to unregister the old reader.
> + * @scp: return value from corresponding srcu_read_lock_fast().
> + *
> + * Exit a light-weight SRCU read-side critical section.
> + */
> +static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct=
 srcu_ctr __percpu *scp)
> +       __releases(ssp)
> +{
> +       srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
> +       srcu_lock_release(&ssp->dep_map);
> +       __srcu_read_unlock_fast(ssp, scp);
> +}
> +
>  /**
>   * srcu_read_unlock_lite - unregister a old reader from an SRCU-protecte=
d structure.
>   * @ssp: srcu_struct in which to unregister the old reader.
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index 07a0c4489ea2f..380260317d98b 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -71,6 +71,28 @@ static inline int __srcu_read_lock(struct srcu_struct =
*ssp)
>         return idx;
>  }
>
> +struct srcu_ctr;
> +
> +static inline bool __srcu_ptr_to_ctr(struct srcu_struct *ssp, struct src=
u_ctr __percpu *scpp)
> +{
> +       return (int)(intptr_t)(struct srcu_ctr __force __kernel *)scpp;
> +}
> +
> +static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_st=
ruct *ssp, int idx)
> +{
> +       return (struct srcu_ctr __percpu *)(intptr_t)idx;
> +}
> +
> +static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct src=
u_struct *ssp)
> +{
> +       return __srcu_ctr_to_ptr(ssp, __srcu_read_lock(ssp));
> +}
> +
> +static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, stru=
ct srcu_ctr __percpu *scp)
> +{
> +       __srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
> +}
> +
>  #define __srcu_read_lock_lite __srcu_read_lock
>  #define __srcu_read_unlock_lite __srcu_read_unlock
>
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index ef3065c0cadcd..bdc467efce3a2 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -226,6 +226,44 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_t=
o_ptr(struct srcu_struct *ss
>         return &ssp->sda->srcu_ctrs[idx];
>  }
>
> +/*
> + * Counts the new reader in the appropriate per-CPU element of the
> + * srcu_struct.  Returns a pointer that must be passed to the matching
> + * srcu_read_unlock_fast().
> + *
> + * Note that this_cpu_inc() is an RCU read-side critical section either
> + * because it disables interrupts, because it is a single instruction,
> + * or because it is a read-modify-write atomic operation, depending on
> + * the whims of the architecture.
> + */
> +static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct src=
u_struct *ssp)
> +{
> +       struct srcu_ctr __percpu *scp =3D READ_ONCE(ssp->srcu_ctrp);
> +
> +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_r=
ead_lock_fast().");
> +       this_cpu_inc(scp->srcu_locks.counter); /* Y */
> +       barrier(); /* Avoid leaking the critical section. */
> +       return scp;
> +}
> +
> +/*
> + * Removes the count for the old reader from the appropriate
> + * per-CPU element of the srcu_struct.  Note that this may well be a
> + * different CPU than that which was incremented by the corresponding
> + * srcu_read_lock_fast(), but it must be within the same task.

hm... why the "same task" restriction? With uretprobes we take
srcu_read_lock under a traced task, but we can "release" this lock
from timer interrupt, which could be in the context of any task.

> + *
> + * Note that this_cpu_inc() is an RCU read-side critical section either
> + * because it disables interrupts, because it is a single instruction,
> + * or because it is a read-modify-write atomic operation, depending on
> + * the whims of the architecture.
> + */
> +static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, stru=
ct srcu_ctr __percpu *scp)
> +{
> +       barrier();  /* Avoid leaking the critical section. */
> +       this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
> +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_r=
ead_unlock_fast().");
> +}
> +
>  /*
>   * Counts the new reader in the appropriate per-CPU element of the
>   * srcu_struct.  Returns an index that must be passed to the matching
> --
> 2.40.1
>

