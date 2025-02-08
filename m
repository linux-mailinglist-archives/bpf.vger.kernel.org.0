Return-Path: <bpf+bounces-50831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D95D5A2D2C6
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 02:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3987A3524
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 01:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBAA13AA2A;
	Sat,  8 Feb 2025 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc9jNFyT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4FC8F64;
	Sat,  8 Feb 2025 01:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738979900; cv=none; b=gEpqbuStLtI8XXc72Y01EvGhC5gj/QQKvLAh5Ukx65+7c1qq+BtPdvkHpx8C92Wnmm1aRImggAneAVE7OyuXfirdriT7TegL15Ie0YtvAhdDlQwrE/nfNDU0M8vEGwauuI3Hjeqa9o/ICxr0uP4bmNcSN98WuRC9FE9aqgc2CaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738979900; c=relaxed/simple;
	bh=nWMliomx2baI3+qy7TLQMS5Gw7XaI+beAEQREQbn8n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIGrALVASdzl0+fQnDW0vFcSrZk9cnPQw0ui1urcewBx5W9QI95GZ0B9lbXTJJy6Wnvt/kJOiATuLWIe1sHbucQRWpGoYs1X2roynz9IgTO+B5ePQQFNEJ/ZXi9oFdXxHdexrw7G/a2fXclEIA5iNiOUs1g0FK1Db8WVj/lVYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc9jNFyT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dc6d55ebaso939582f8f.1;
        Fri, 07 Feb 2025 17:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738979896; x=1739584696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1YcpkTOPRywGB38WZqSFXRMZdWBJFK04OWzPaUWZ0U=;
        b=mc9jNFyTZT59tz3I+jTH3e7Zm1CcwO7lkdqJqV9NaWrRTSoa0l9Ol9ePjnXSjES3MA
         4YdKNolZxexSRsNBexPnj9gw1nrDsgSq8um05NYC6Kn1/eoztQrIWBt+3KLlz0RwsHTq
         Fi3lK+GV+jRJ6HpJzN0+R3gkf+CzcgVu1Ct2E7mJZCLlkFTHH+MsQ2OZ2vJAywzUJ8+7
         RwBBa8bkW1muOTbiYbN5I9yYWbZ2E6WXGwhQSDLgJlH5LqZ6jxq0PFas182B94zs6Qvz
         nsAKzvWdMQwhN/1KKHoS6uP6lyCMS9NdnGsNGpi4YR1ahnxVQUHD7mYzCTfNjYOql8UB
         2xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738979896; x=1739584696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1YcpkTOPRywGB38WZqSFXRMZdWBJFK04OWzPaUWZ0U=;
        b=ronDVI7C8mVLgNdn/nFx3iV8lFGpAsiklrip7/BgGOtBP/WtHnmXPVpZzq9Vl5qfnt
         fi1zHK1RsqZkPYlJouQsk8R9WrNSvLoRMi/Yzm9dF/AXNi80mvzKKPxEell34uFjY4Iw
         KK3jOLsSZ176+uCJLFQGxHdXzWUsbxYrp/fQItKH9gF1oum4KwScT5aYzHGEc+QULru1
         ckfe4dwL+CLVroS9+ckjNZEr0gjsS9rCi4CD8YxDulHtHIsQS5pfIYw4JMZDbUNpsyh0
         guX1nZrPJeHQdihE5bNgC2llm+ypnrKrjm72hZR22Y6PBU4oVBqjrh3HOPWDwbrJLZoX
         2d8w==
X-Forwarded-Encrypted: i=1; AJvYcCV1uvhNy52rejn3MzYWyYkss04zzu+z5vF5wF7sGM2uJ92LB3906LsTzFLoEFCoRRpTB9a9CVTOn43RRew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8PSdNdAqlSHmRa6HwxxKLTHvldS8huwEHLD2iFVGO6gKw9Rd
	+6fL2RniMjBvtV+zgZmzZ/U04TFf9mk/BtMiPCrr3TMUp+8FcZtt4IDa3M5h7Wh+mWLeCDzBbF+
	NfEvMQTfuOIZRabTamSlx5TQVaSI=
X-Gm-Gg: ASbGnctQD7Pa1t1ztSJ6WCpXH4K9dJFCu4NZcf3pkfMwwREIkTncgDHJwYw4bZMT6Ig
	TmoQMtMB3ybAOxLUPnrYwqiP8oB3wJE/efXVC0dqSEba0hVYqD0Mit7Joqjvtq0wsZm/2S2pwmZ
	ZZyttECaKP5/bffhzTjXcyG1IZZzWa
X-Google-Smtp-Source: AGHT+IHpQgX94A0FosDyS+sPj+7+y0MjVyp5Vl8pFYoOt0ryrG7ep2EbT2QWb1VNe2LbKYkHGL+NGYYFucNAFeoNlL0=
X-Received: by 2002:a05:6000:1889:b0:38b:f4e6:21aa with SMTP id
 ffacd0b85a97d-38dc99095a5mr3468207f8f.5.1738979896380; Fri, 07 Feb 2025
 17:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-18-memxor@gmail.com>
In-Reply-To: <20250206105435.2159977-18-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Feb 2025 17:58:05 -0800
X-Gm-Features: AWEUYZnChx1s7fxsHJqTe9Us5tAvAetd4ErFLCNbt2tgL6nIpdAsrcoarJ_P1Lw
Message-ID: <CAADnVQJFRgidWdA72Op762HXg9y1s4CJQB_5rmB9iqCNzGEuWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 17/26] rqspinlock: Hardcode cond_acquire loops
 to asm-generic implementation
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:55=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Currently, for rqspinlock usage, the implementation of
> smp_cond_load_acquire (and thus, atomic_cond_read_acquire) are
> susceptible to stalls on arm64, because they do not guarantee that the
> conditional expression will be repeatedly invoked if the address being
> loaded from is not written to by other CPUs. When support for
> event-streams is absent (which unblocks stuck WFE-based loops every
> ~100us), we may end up being stuck forever.
>
> This causes a problem for us, as we need to repeatedly invoke the
> RES_CHECK_TIMEOUT in the spin loop to break out when the timeout
> expires.
>
> Hardcode the implementation to the asm-generic version in rqspinlock.c
> until support for smp_cond_load_acquire_timewait [0] lands upstream.
>
>   [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora=
@oracle.com
>
> Cc: Ankur Arora <ankur.a.arora@oracle.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/locking/rqspinlock.c | 41 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
> index 49b4f3c75a3e..b4cceeecf29c 100644
> --- a/kernel/locking/rqspinlock.c
> +++ b/kernel/locking/rqspinlock.c
> @@ -325,6 +325,41 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t =
*lock, u64 timeout)
>   */
>  static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[_Q_MAX_NODES]);
>
> +/*
> + * Hardcode smp_cond_load_acquire and atomic_cond_read_acquire implement=
ations
> + * to the asm-generic implementation. In rqspinlock code, our conditiona=
l
> + * expression involves checking the value _and_ additionally a timeout. =
However,
> + * on arm64, the WFE-based implementation may never spin again if no sto=
res
> + * occur to the locked byte in the lock word. As such, we may be stuck f=
orever
> + * if event-stream based unblocking is not available on the platform for=
 WFE
> + * spin loops (arch_timer_evtstrm_available).
> + *
> + * Once support for smp_cond_load_acquire_timewait [0] lands, we can dro=
p this
> + * workaround.
> + *
> + * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.aro=
ra@oracle.com
> + */

It's fine as a workaround for now to avoid being blocked
on Ankur's set (which will go via different tree too),
but in v3 pls add an extra patch that demonstrates the final result
with WFE stuff working as designed without amortizing
in RES_CHECK_TIMEOUT() macro.
Guessing RES_CHECK_TIMEOUT will have some ifdef to handle that case?

