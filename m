Return-Path: <bpf+bounces-48143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12FA047F1
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFA118891C8
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760221F4E50;
	Tue,  7 Jan 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIXYOe3j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BBC18B463;
	Tue,  7 Jan 2025 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270098; cv=none; b=oU1VqbZEYmndz+jsbSPBovEdECgB+by7acPbNsys+YB5A/ef1d7ytS06LP7ApkxdBygIWMXFIl5y/mbd/px6Ap1Wz6w2wX32U4/05QersvktsiJEpW8yPH4RD3qt3dxICtZt6eGdwRnrsMlb5gCjs2WXVlxm/CbCzHI+7+uE8c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270098; c=relaxed/simple;
	bh=nOC/2ErxrXJK9+GX1bdNlz08JObtzMI0ZAPS9IVId2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQ6CaqW5mewTqP+1zjPGmFEYgDCOuEYP9Jsmhxa1gEirOTMlUByZGBzOS39yRIBqcCu+Edp/BsHoV9ZYBCWIh6fumyq/dlfJLh2k25OkaLaugbNCfS6dgcbH/A6aKauq4LOa09T/Lj2BJkFyeXnRy30enI/txWeXRGfR5+1xTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIXYOe3j; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-2a383315d96so8279087fac.3;
        Tue, 07 Jan 2025 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736270094; x=1736874894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NQ6FuqwsunfkgopEPOvkQ8pd0WRpRi0eEuLRq8JalM=;
        b=EIXYOe3jNTW6JKvGejotWEaotKbI08VnEcGTXriGjBltEVRz6fXHPlBROXMOo0Tdwi
         QW/vzKG1m4do721VxMHqyHOXSZn47xfo/hzXWPGXiAl4yhfvPy5tVvXzIgS7ug2Ueu3p
         xbE5W3qz07FtrWKFf3wU87ez7l1F+kjqs09Nlt/wspMu500g2PSmZU/HnF0fIxIQFQid
         9K0AKNrJneWQvckfN/4vZNMIOrUKg6YfStAhkO2RZckNZkFnaMcsX5A4coP6zHoTXPr0
         O8oxPNmrZ23OKpKjeuc5BAG1xTuDK/b4luVtBMGbQZsVEIjiAvKVxgl96ZGGAxRBRPm0
         keqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736270094; x=1736874894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NQ6FuqwsunfkgopEPOvkQ8pd0WRpRi0eEuLRq8JalM=;
        b=vh2KjPdcODQqjoBoAOM3kQ80zyW2qkLSVr5D6tFBvu5G2GFPAiKC3aJH3qKcRdwllz
         ZnTcSSi1KVGbdMPbYPJAyAWwYMeLBzKiNz40VO8SCPj3cBdlONXsf/u/9Ol/c4FMpJC2
         dPzAfehN0HlEPJKQLVW81oMNAZKCYAFakfYciv3MdvMFYRPQuMnm7RZaBc//lDF9uGf7
         hiLIF2M4FpDzmQNZ0ll/hHgFN6PysZ2UKa4E4qQdy7qYP/LVkJP/jWPvfLVhuO8ESg9V
         fKa2hmpMqqroBSV9rLcScQ+BhB9XGmGkv3YE6ZDaA+Abvrnyom2IGG9KAixqHJzSjPW4
         TSlA==
X-Forwarded-Encrypted: i=1; AJvYcCXEMEQWHCc0RHzO0+jtFqim6Krt/EnMZoj0kYUFcX7zCGCPOQirzL+JOH+OZw592FXNI5/v7SOtiv/ZXbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGJaoedt3mpqyDsSFw5xyq4T+lYoegIDwpYdbv62sEKQaUbRi
	OY9tCFp5kK0dYyE0ur0bXk1ttcSpNbVMelSzIgnpVhYHkr2ncFtFIkMgB4c6DNFhnT6AtW3ry9b
	wyDROFE3+7ghtCJE2lSw3LED4PbY=
X-Gm-Gg: ASbGncsthP5K9aOfDBrcakJ8G9SPiNQLbUTd/BaObrutVHmCY4T3XUb2Mhr2rb/aCNl
	jfdHR6sa2x5VNUj4cQlakgjvq4XtrzTIy8iid5hKhFpGCjlfAbpC8rVQzOIpFUn/dYbk2/tc=
X-Google-Smtp-Source: AGHT+IGF0tIc9eWsVa+KvFysl2J8Ktwvh1FQ3VbyeBwO4RqYGQHA1SZMFFElTSdCZOBZfR4LgpvYs4zDQtw2y/JS3nc=
X-Received: by 2002:a05:6870:ef84:b0:29e:6ae2:442 with SMTP id
 586e51a60fabf-2a7fb4b9925mr29318264fac.32.1736270094263; Tue, 07 Jan 2025
 09:14:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-9-memxor@gmail.com>
 <20250107145159.GB23315@noisy.programming.kicks-ass.net>
In-Reply-To: <20250107145159.GB23315@noisy.programming.kicks-ass.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 7 Jan 2025 22:44:16 +0530
X-Gm-Features: AbW1kvZQlZeZjKHmMBvBWme3huJSWRssi86aiGRPxwObnAWR63TiF5nxRJUUuAs
Message-ID: <CAP01T74SHdhtshm3iO_=+W4AHNQSZekJVKwaQn-Sr5up2apKhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/22] rqspinlock: Protect pending bit owners
 from stalls
To: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barret Rhoden <brho@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Jan 2025 at 20:22, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 07, 2025 at 05:59:50AM -0800, Kumar Kartikeya Dwivedi wrote:
> > +     if (val & _Q_LOCKED_MASK) {
> > +             RES_RESET_TIMEOUT(ts);
> > +             smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TI=
MEOUT(ts, ret));
> > +     }
>
> Please check how smp_cond_load_acquire() works on ARM64 and then add
> some words on how RES_CHECK_TIMEOUT() is still okay.

Thanks Peter,

The __cmpwait_relaxed bit does indeed look problematic, my
understanding is that the ldxr + wfe sequence can get stuck because we
may not have any updates on the &lock->locked address, and we=E2=80=99ll no=
t
call into RES_CHECK_TIMEOUT since that cond_expr check precedes the
__cmpwait macro.

I realized the sevl is just to not get stuck on the first wfe on
entry, it won=E2=80=99t unblock other CPUs WFE, so things are incorrect as-=
is.
In any case this is all too fragile to rely upon so it should be
fixed.

Do you have suggestions on resolving this? We want to invoke this
macro as part of the waiting loop. We can have a
rqspinlock_smp_cond_load_acquire that maps to no-WFE smp_load_acquire
loop on arm64 and uses the asm-generic version elsewhere.

