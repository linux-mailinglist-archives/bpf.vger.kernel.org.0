Return-Path: <bpf+bounces-51104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FE8A302A1
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 05:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54900165E9A
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 04:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947AF1D90CD;
	Tue, 11 Feb 2025 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9Uhky7d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF601D7E26;
	Tue, 11 Feb 2025 04:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739249771; cv=none; b=HbNjCbISlVQfvbKlSy65Z/8pEVbQiYe/KfN9Nx8vyBq+am+hS/9QBRBMEl6p9w9crN0j21wnhpCD07iC1LSARqXB/xRq/yhaiqSffaXq6F7kXDgeo+qOxu0yYbbpyOd4i+jP2I+JFo6ca4zvXV0J94dJ+Kz+y1FcVVpxxMwfigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739249771; c=relaxed/simple;
	bh=Dd8pJU4mAkz8oOTBw+33Ba9v2QIfFz/TQnaizVzJwyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WR4OzGU5ZIAbd0lFkh2llyZTZS5GHIW2Z9HcdPlsLm52UlrF1rLZxKzWiRBMW6t6xBkUVAyXWhuj2Pj4xcn+8dLuNpW1doz1WcrUT5crt7EsjuiTWvYnYNu8pExogTfG9f9seb2Nk6NqXePgB991dfHkQipfJRVyeiDUoOzwqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9Uhky7d; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436281c8a38so33476675e9.3;
        Mon, 10 Feb 2025 20:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739249768; x=1739854568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvlqG2mdUySN91b26Hc4Mi8+p6b99eBWTzCbfUz6Rb0=;
        b=j9Uhky7dAVu9rHGTiRy6s0XgQ1wTh5aW5ypBvjovFl6mQt+nvrTo6KMrECVPuK98ka
         VZkH6EK/SIfXkklBy7o5NLa9K34tkgVcsPuw5yzd6rza5XT6UpYaG2lEVAqaR5fU7Awg
         dC1rapn/witJEkXCZ3NqKKlGnq3tvFn4Z3IjTbX0MsALMCQzIPF7DdO+bQ+YvH7DNoSP
         A0UofhaUkDlIbho/mww3c1I9jLVgPWHD7XHDhfPdPYBHrMHPDrZtKQVWghQmbmWKvSDX
         7+YwOiVK8gs2eLqR3zeJje/WX9uevjOfG2mQV3k6WASkBYa3cze1UM9KcRCT0epa8l8T
         Tuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739249768; x=1739854568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvlqG2mdUySN91b26Hc4Mi8+p6b99eBWTzCbfUz6Rb0=;
        b=jdFkxiSodNFEaZ2tYS9Yb9qArN9hSQ1IFDIbir/Yzz5aQ5cqfRuUaHlVNgNwgniFP6
         br2cZhJhCMkf+1U0Lza4plAKuyfncbv1amBE0uHEE9galdjWUVVyIHQNXDyFO6aZENzE
         YW07c55wiJYHlUeDHvnE5Fn5y/q79XrWh+n1iCHFcCBcpcFLNEtjR/aoysuGZnKoCUiB
         TqQT00D/SbDP4fOBP/pkqrcm0nkR6KphTPAV4X1ZWAMB6Gj5G4VHa2BtmziXE1wr0tjc
         xUP26oFpKKlRXOERu8JsU8jdA6gPDmvC3zo+Fep8O3fXdFnaUrpupybMTVDyGdw9F6wj
         WzRA==
X-Forwarded-Encrypted: i=1; AJvYcCUOJlEFdFNhjQRaEeFqoc2BiNRc71HxX18yaUEluvMUTUcNV3/pfLn44Ktl/39SK+0UE5E=@vger.kernel.org, AJvYcCVWi2HG7IDTMlvJL8e+NO7brtL1Uk3fHTFdDr8/qmmDymGJXep+wHabhV8pjBx2Hac9Oxj/S2qiY68Nw87i@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73cirIG5XMrfA2eVhabJ2X5tlkYIXoy020upZFbR6VokoL2uH
	iGxwH450dS44hnX/rYhy4b9loEa7hnOLqhQHb6F1sY5zH/wP2XXCUGVDJsWobU8mAaXbg8bC/0x
	9QbwkmYuNSaAh9jquI1N0Jnj2120=
X-Gm-Gg: ASbGncsEPrMn/meeE9Ojxs8ScBMQIVd5YH8QMRK9jJbp8ZGSkopaBN9aXGzWjHqmyaA
	naolh/CSxl3MhmnB1ubl75jeVFR+rVCO8OOn7Q4vxRV0pj4ay9KxmhcPktF1iMDpuPbqOeSTNVe
	PMwhsT5sYypKGq0MGqUwdERm3fatcY
X-Google-Smtp-Source: AGHT+IHVPH3y5XcET08qxG5mfIoe0bM1mbFDx4OVs43sslrkWwEXHC/aB8TK7KhECghuwskKJMQ5E/+WP1m+09AjE1g=
X-Received: by 2002:a05:600c:1e02:b0:434:9e1d:7626 with SMTP id
 5b1f17b1804b1-439249c02e2mr103937525e9.25.1739249767385; Mon, 10 Feb 2025
 20:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-8-memxor@gmail.com>
 <20250210095607.GH10324@noisy.programming.kicks-ass.net>
In-Reply-To: <20250210095607.GH10324@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Feb 2025 20:55:56 -0800
X-Gm-Features: AWEUYZm_Ui-VlaR__Qfx0UBZP1wEkQULBhyDCk20ZqOu4LAS3ChHbdZQZd4xhLk
Message-ID: <CAADnVQKefT6iQVQ66QTCeRCMs_am4cC3pBt1Ym1fxfeeQVDDWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/26] rqspinlock: Add support for timeouts
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Barret Rhoden <brho@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, 
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 1:56=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Feb 06, 2025 at 02:54:15AM -0800, Kumar Kartikeya Dwivedi wrote:
> > @@ -68,6 +71,44 @@
> >
> >  #include "mcs_spinlock.h"
> >
> > +struct rqspinlock_timeout {
> > +     u64 timeout_end;
> > +     u64 duration;
> > +     u16 spin;
> > +};
> > +
> > +static noinline int check_timeout(struct rqspinlock_timeout *ts)
> > +{
> > +     u64 time =3D ktime_get_mono_fast_ns();
>
> This is only sane if you have a TSC clocksource. If you ever manage to
> hit the HPET fallback, you're *really* sad.

ktime_get_mono_fast_ns() is the best NMI safe time source we're aware of.
perf, rcu, even hardlockup detector are using it.
The clock source can drop to hpet on buggy hw and everything is indeed
sad in that case, but not like we have a choice.
Note that the timeout detection is the last resort.
The logic goes through AA and ABBA detection first.
So timeout means that the locking dependency is quite complex.
Periodically checking "are we spinning too long" via
ktime_get_mono_fast_ns() is what lets us abort the lock.
Maybe I'm missing the concern.
Should we use
__arch_get_hw_counter(VDSO_CLOCKMODE_TSC, NULL) instead ?

