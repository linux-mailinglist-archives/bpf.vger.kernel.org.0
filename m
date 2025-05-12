Return-Path: <bpf+bounces-58031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8842AB3E03
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A0E1886CD5
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9772522BA;
	Mon, 12 May 2025 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq3fTPeL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281B1C84DE
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068394; cv=none; b=tItpGzherviKLEIVcwPD2QgTwTb3z+8CGaZlXXwlShYS3sWbCMeMQFuXcnyd3TQBk3KtXdJ4qiCQVD5ESB/oYvECmiwZBj4iC046a7ErtxqW7NMmet0UuF1F30ug1IkuABL1mZfU6iLiUrgOvIFLllO/28MgZf6poiT3X6jUd8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068394; c=relaxed/simple;
	bh=kLJLt7lRaEN17+miqQE71xDYWbLzElUM6uqPwQ6PUdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYctFzCHI0u9PimVLpbecPlXmNqGdVX13SPS9uUF7tjrIW6Gw9GuyqsGt9HfcE1fDi/Q01m2GSZD6skPZXBRT8Yd5+XfoR1bX/rx5NlRzZJkDA/1c/lA0I2EBedGOFSv4BA69ma5S9DKS5Exozs47JFUY9vp05Gu3kMg6yK6wMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq3fTPeL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a1fa0d8884so2016637f8f.3
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747068390; x=1747673190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX6B+3os2H1hrlDtdqIsj8ZH39Q6D7xnbdhYaLSgq6Y=;
        b=aq3fTPeLu3mnhm3cBbHrDdPAdZg6vF20Yb3CvYUcyz0iIR0zwTdCt57i+06SKNKT9M
         x81G4FCLF+pQkpYiGNiFMRJpxG9D/7Nuo9ryngnkcHDIFDC/Li94c7Qe4PeRpzs2Sgsi
         z9Oop0R7Yl6JYgRzDeGcvdA5MYyRZJxuHBlh/TJ46zsGpFghq2L1NRk6nNuj3U1vjZz3
         8mjhDsxUtMS5Qxwhv8tdbzHHUcNxRSe5ViIaS+GthsuXP2At9HMy0HucGTJF2jYtgAbK
         QZWSU8cWhQPHE9svdPY92AlPa35cqqOcrNi3WFCUKNwxhOzvN0KwIQGmDtDbeSnYp03f
         juVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747068390; x=1747673190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oX6B+3os2H1hrlDtdqIsj8ZH39Q6D7xnbdhYaLSgq6Y=;
        b=hH8lA6UxS5TeHLGAqlCNkjGqiw+5yKDSoHu7XI6sYLqwjJRFrHzwtsN1FL46tuCYxQ
         WWdA0iLkfE1gelRfJEbj41HuG6R6dqCSfkI8+cmY3etAldCcov1xFXhUXf1YL5DZVdtx
         tD4oQJI+/bT7ZllMmjulekLK1F7+wFCLu1voO0w12O0oeoKyZ3WXujNRs0wsuic79wQ3
         QVmqrXNWEOM0n5R6C7Cb1VZyEqsBWOIsBFWf6JbJYqw9TWKzFTHkXRjaCuvuBHtkiZpo
         RqWeVDuz4/un931jEniVg2ghU0V0lMRW8ZHEYn+8ncJU1JFzTbKBNlLWtsQWbn4xpWUq
         5rPg==
X-Gm-Message-State: AOJu0YyaNZwWjgsb1HKBG/yGcmO6yRp9f9IVYn6aOttgTeNu8snOmpw4
	k5d2K4Unj1htXo24HxKZ3XJLMsNBHnrukxon6bsoEI0b6N+u6vfYCj/jt4JaDRti8cEEbTd9Zj3
	Iz7BN+Jv3FtVtRkYEyaKd5n18v80=
X-Gm-Gg: ASbGncuAEm71jb/himPHu3AD9R5xcx+pcHdfjSaJn1vRoX9bLIdpGZw8y/zZ+8Xn7hb
	8LUtf8nsFwLrr5izkNbrEoCxCPzifSB7x0awqFy0Loe6WGALRLGuyqMi+I9KZz18gdan1NjIDRs
	PVvLqKJJx9IxK589RSKY8muKfy3Po6EujW83c3AROroKkUOyih
X-Google-Smtp-Source: AGHT+IFM5nT873/utvA++/Y7NVoK0iS7GvPOeDGmqobCWQ8UTq0xILkGccvcH0VKOkoa1yWs0+PYeRg87TlNXsB7lro=
X-Received: by 2002:a05:6000:290f:b0:39a:c9c1:5453 with SMTP id
 ffacd0b85a97d-3a1f64b5e7amr10997886f8f.49.1747068389443; Mon, 12 May 2025
 09:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-3-alexei.starovoitov@gmail.com> <20250512132654.4MCqyeG6@linutronix.de>
In-Reply-To: <20250512132654.4MCqyeG6@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 09:46:18 -0700
X-Gm-Features: AX0GCFvMkQZi7JNk52ueFN8_-In0Mlpxv3ktsW4FzqyRjYnhPo4dZRQqyYc1Eto
Message-ID: <CAADnVQ+38d58osQYze6Sqy8HJ_piQoEspNfr47pSwFxQi1m4sQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] locking/local_lock: Expose dep_map in local_trylock_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 6:26=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-04-30 20:27:14 [-0700], Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > lockdep_is_held() macro assumes that "struct lockdep_map dep_map;"
> > is a top level field of any lock that participates in LOCKDEP.
> > Make it so for local_trylock_t.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/local_lock_internal.h | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/local_lock_internal.h b/include/linux/local_=
lock_internal.h
> > index bf2bf40d7b18..29df45f95843 100644
> > --- a/include/linux/local_lock_internal.h
> > +++ b/include/linux/local_lock_internal.h
> > @@ -17,7 +17,10 @@ typedef struct {
> >
> >  /* local_trylock() and local_trylock_irqsave() only work with local_tr=
ylock_t */
> >  typedef struct {
> > -     local_lock_t    llock;
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +     struct lockdep_map      dep_map;
> > +     struct task_struct      *owner;
> > +#endif
> >       u8              acquired;
> >  } local_trylock_t;
>
> So this trick should make it work. I am not sure it is worth it. It
> would avoid the cast down the road=E2=80=A6
>
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lo=
ck_internal.h
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -17,10 +17,17 @@ typedef struct {
>
>  /* local_trylock() and local_trylock_irqsave() only work with local_tryl=
ock_t */
>  typedef struct {
> +       union   {
> +               local_lock_t            llock;
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> -       struct lockdep_map      dep_map;
> -       struct task_struct      *owner;
> +# define LOCK_PAD_SIZE (offsetof(local_lock_t, dep_map))
> +               struct {
> +                       u8 __padding[LOCK_PAD_SIZE];
> +                       struct lockdep_map      dep_map;
> +               };
> +#undef LOCK_PAD_SIZE

I don't like it. It obfuscates the layout.

