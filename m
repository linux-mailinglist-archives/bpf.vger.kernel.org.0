Return-Path: <bpf+bounces-75259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B12C7BD08
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 22:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71E1A4ED7F7
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 21:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12632FF155;
	Fri, 21 Nov 2025 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP2uRQcc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B72FA0E9
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763762080; cv=none; b=YGRScGCGHB5T7tynGIzCY+/o2e/5355zS0q1MwK1W9wV36q93hplL1qx//mM65owIhzQuWzQLzB88YRxgReDuqXWp2yJ92myl61eOAJFRz9p1/NAZ9QDHtVMCRpfEjlHuw5M4dRVty+H8VIvw4HIpN6YsMKf0I7cssLiZaeXWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763762080; c=relaxed/simple;
	bh=kxc2ghZkIeKuja4o7j8KUlCiA7Mek4elgg/CODc+eP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDTsqyV0wtcYWVLxNm9jwJlF7jUA65LqK8nYtPijZnOot/+6CcJxBzHcIPlE4Uy/KJ2JSGCrpcm5ujjwoaZhx04EB3hPED+W5QA3Wi90x/jmFGWbk9mwi+H8G66hbTwtRy98vING2ohgJTblQZYYLUJrgYQJC/73PDbFava8pIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP2uRQcc; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787e84ceaf7so27967647b3.2
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 13:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763762077; x=1764366877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKDKywxsPMgX4FVe6JHQ8TSPWLHfYapoOHUuWm/LY3M=;
        b=SP2uRQccH+g9xA61zNVDnCaIMzho/v9gE5nhsQywafYLct65mPVaZbX9L9jXUqYSvj
         j2+eVz9Oc2pI7/2Js/BSUfpDLl7x/GyNxsMSxob8nR18XAza4cfM2q2+GUUpOI35uZdF
         Pc0JNeCoRzwUmz3wGKHfdcoc/KBKHCseSGhJazcyVQwQcoHr//25rEie4TI5P5ce1+ao
         n8m3UslaO60ktFcXMYrCu9pCTjbzY1OMrAQl6QHt5SRR6AIYsaKy1TyelYT/FIX8vQZk
         3CNwhM0FHtdrRAWujOTLyJNOIZa+BxN5iVRELvdd9Od+KHSX8am2I8vOXlFk/9PvBTKJ
         kkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763762077; x=1764366877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KKDKywxsPMgX4FVe6JHQ8TSPWLHfYapoOHUuWm/LY3M=;
        b=WCaURIj2lcoEQyQuGRvYPRMloC5Zhdvk5i6GxzD7JXYtig+QXAuBUwHHMVIoOpBMyh
         YEmWQSbrsR3UwnuJ4bgg53Tn5tG5A/0Uy1nacRmGVGj/4DWCPvL2M4N9E+2oN1lHKFjk
         JLxBDcnUhB7CnvsCLKBnyVQX4QEe+NEwpg6aXsc9z6JqDtYMTss3OOdClTD5sYOcLKJ7
         6wdyvvfASTqxYOVcAyR9xXxQ5Hy3k9j+tSIV7BUs/YxsdrhfOuyjb4OIZVwPJd3vCZjQ
         HusM5ANaF3Qlm9yesJroaGBQpT3UWKSlEyOARNhhbAg6ImgFQ3RTNbkAG71GcsLnpjL9
         uw7A==
X-Gm-Message-State: AOJu0YzpkwROaNAKUk8xJNfgk+LherEnenFc41obAqQUsClB8lAq2u7I
	XHGY1nMPtnOya91ar39TRgNqO2KBJUw2t+DgOTkmDzXe3+naRLPx2IRhP4x4EElBcexcfTi0bKh
	8QaTJVZe7qxXFLuw5wwGIMuVMHU7RINM=
X-Gm-Gg: ASbGnctVayhD2RcwWwL/9Trh6tRtu0cYnzBQF2JVW21eTts0tYSmNwpWAuGBwW6T4+u
	Ea9oKLRmC1OO1QCvALc/hrUmopC+EU1bhhypqzjN9BjrDPKRPRXM7In0YYYQZIATdCkfzy2H7/v
	pwQS9ePoANTm+B/s6xt9pmEKUSxV8D2YxvxQe3xmvaRyPjrx1hDT+Q49hk3MY57qm049RXrsUMc
	QppYtRv797+A1mOJ0SS9/bHZ2pTSqxMeOcWxo4iyIzDNcTg6jsprhir0l7ZYtFDxIXBlF8=
X-Google-Smtp-Source: AGHT+IFv8lSM7z8+IQSXiRGzjcYlE3VnU8KftfivOThFbyGoAg73pBoXP9yS3Z6IfL30svn9r049Mnf49GZI6lzp1ws=
X-Received: by 2002:a05:690c:4904:b0:788:1a92:4fec with SMTP id
 00721157ae682-78a8b54837fmr28535427b3.69.1763762077432; Fri, 21 Nov 2025
 13:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121205724.2934650-1-ameryhung@gmail.com> <e7c311bb305d985c1a9ea19aef3fcd4094c7e03c600dfba9fc83438b285f5946@mail.kernel.org>
In-Reply-To: <e7c311bb305d985c1a9ea19aef3fcd4094c7e03c600dfba9fc83438b285f5946@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 21 Nov 2025 13:54:26 -0800
X-Gm-Features: AWmQ_bncgu_q28NvI6KNCOpod1s-6Ivi2vGsnyRvzUR7pkN4pd0u0iyEnKtfxiw
Message-ID: <CAMB2axOLh_sJL3FnPFPWr+s3dTjwGn4y+63vfbC3abT8+z2h-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] rqspinlock: Annotate rqspinlock lock
 acquiring functions with __must_check
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	david.laight.linux@gmail.com, dave@stgolabs.net, paulmck@kernel.org, 
	josh@joshtriplett.org, kernel-team@meta.com, ast@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 1:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqs=
pinlock.h
> > index 6d4244d64..855c09435 100644
> > --- a/include/asm-generic/rqspinlock.h
> > +++ b/include/asm-generic/rqspinlock.h
>
> [ ... ]
>
> > @@ -171,7 +171,7 @@ static __always_inline void release_held_lock_entry=
(void)
> >   * * -EDEADLK        - Lock acquisition failed because of AA/ABBA dead=
lock.
> >   * * -ETIMEDOUT - Lock acquisition failed because of timeout.
> >   */
> > -static __always_inline int res_spin_lock(rqspinlock_t *lock)
> > +static __always_inline __must_check int res_spin_lock(rqspinlock_t *lo=
ck)
> >  {
> >       int val =3D 0;
> >
> > @@ -223,27 +223,36 @@ static __always_inline void res_spin_unlock(rqspi=
nlock_t *lock)
> >  #define raw_res_spin_lock_init(lock) ({ *(lock) =3D (rqspinlock_t){0};=
 })
> >  #endif
> >
> > -#define raw_res_spin_lock(lock)                    \
> > -     ({                                         \
> > -             int __ret;                         \
> > -             preempt_disable();                 \
> > -             __ret =3D res_spin_lock(lock);       \
> > -             if (__ret)                         \
> > -                     preempt_enable();          \
> > -             __ret;                             \
> > -     })
> > +static __always_inline __must_check int raw_res_spin_lock(rqspinlock_t=
 *lock)
> > +{
> > +     int ret;
> > +
> > +     preempt_disable();
> > +     ret =3D res_spin_lock(lock);
> > +     if (ret)
> > +             preempt_enable();
> > +
> > +     return ret;
> > +}
> >
> >  #define raw_res_spin_unlock(lock) ({ res_spin_unlock(lock); preempt_en=
able(); })
> >
> > -#define raw_res_spin_lock_irqsave(lock, flags)    \
> > -     ({                                        \
> > -             int __ret;                        \
> > -             local_irq_save(flags);            \
> > -             __ret =3D raw_res_spin_lock(lock);  \
> > -             if (__ret)                        \
> > -                     local_irq_restore(flags); \
> > -             __ret;                            \
> > -     })
> > +static __always_inline __must_check int
> > +__raw_res_spin_lock_irqsave(rqspinlock_t *lock, unsigned long *flags)
> > +{
> > +     unsigned long __flags;
> > +     int ret;
> > +
> > +     local_irq_save(__flags);
> > +     ret =3D raw_res_spin_lock(lock);
> > +     if (ret)
> > +             local_irq_restore(__flags);
> > +
> > +     *flags =3D __flags;
> > +     return ret;
> > +}
> > +
> > +#define raw_res_spin_lock_irqsave(lock, flags) __raw_res_spin_lock_irq=
save(lock, &flags)
>
> The __must_check annotations will cause compiler warnings in
> kernel/locking/locktorture.c where torture_raw_res_spin_write_lock()
> and torture_raw_res_spin_write_lock_irq() ignore lock acquisition
> failures.

This should be fine. I compiled with gcc and clang and they all seem
to not propagate the check more than one level.

>
> When raw_res_spin_lock() returns an error (deadlock or timeout), the
> torture test functions still return 0 to indicate success. The torture
> framework then calls the unlock functions, but the lock was never
> acquired. In res_spin_unlock(), this causes an out-of-bounds array
> access when computing locks[cnt - 1] with cnt=3D0, potentially corrupting
> per-CPU memory.
>
> Should the torture test handle lock acquisition failures, or use
> different lock types that cannot fail?
>

Deadlock should not happen in this case, but for the correctness of
the code I can send another patch to address it if people find that
necessary.

Perhaps something like this:

@@ -931,7 +931,11 @@ static int lock_torture_writer(void *arg)
                if (!skip_main_lock) {
                        if (acq_writer_lim > 0)
                                j =3D jiffies;
-                       cxt.cur_ops->writelock(tid);
+                       err =3D cxt.cur_ops->writelock(tid);
+                       if (WARN_ON_ONCE(err)) {
+                               lwsp->n_lock_fail++;
+                               goto nested_unlock;
+                       }
                        if (WARN_ON_ONCE(lock_is_write_held))
                                lwsp->n_lock_fail++;
                        lock_is_write_held =3D true;
@@ -951,6 +955,7 @@ static int lock_torture_writer(void *arg)
                        WRITE_ONCE(last_lock_release, jiffies);
                        cxt.cur_ops->writeunlock(tid);
                }
+nested_unlock:
                if (cxt.cur_ops->nested_unlock)
                        cxt.cur_ops->nested_unlock(tid, lockset_mask);

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/195835=
58278

