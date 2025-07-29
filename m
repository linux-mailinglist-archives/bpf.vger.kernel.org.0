Return-Path: <bpf+bounces-64669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5489DB152D4
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DB13A431A
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE2C23A9AE;
	Tue, 29 Jul 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSquYvmz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B271322DA0C;
	Tue, 29 Jul 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813744; cv=none; b=puCl0ADejg4EBOYBRegFB/WdK/2pVTq8dXOvDoZDtbhwfLrXNe326HqEWBN5BHe+iaVeUN983xLg4I5ytcPnzkr0njGN7sRWL1IJSWT424b40ZZqZCGqfNhMRuHmv6wAP0ok5JDbKAOd3sRY85phsN35/xE8aHIp55wEQzLPUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813744; c=relaxed/simple;
	bh=ncjNqPuPLZVAnAtB+vplK7E7TsfLfKU+QOppOiBzXlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1QMSLQ+TsbHXf+yalMLHS04eFsWlNHr26aZxTSW67ce7oL6jE8d+dzHZ/vF/gSd6Ogd898Q91FXA4rgsUdJ09qQXFl6+JEEnf3MwsDk/i76gAyMW6+yIuCe2NivifY/gVuVNgyy6fu0SCZ/Vuu/b+xQ7Vk8nt/6JARD95zqY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSquYvmz; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71a4742d81aso2134477b3.2;
        Tue, 29 Jul 2025 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813741; x=1754418541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO3LxJDRPcHqqVPBxktzU6xoRl90LUTMrbnnuWkT+tY=;
        b=ZSquYvmzO5NuI/9aw/MjFkeqXVVRKV578pXfZTcagRgezJNMsDKnEXdOSlLUvG+uPA
         66magazxtxYzRfMqUJnV6T1oij+S9yFDPqaFAf5KklldEJw1YWz/k1JkSxc6NND2cpAa
         GNwuZWRNKMqLqLiTpp+6DJ28lBFzmCHp1u9eiL1hYQn6VkpNbYo7aGViafIt5NKf4oHZ
         r5CIUAzbISt6igEOBihUamKtRZrjP3Y0vmVra8rS0e7YTkEcZIIWfOGjr6zIoADayTmY
         /KGFrzHOYoCpbqvrc2X1VTPW5yzyf+q2OFvJ7lHE/X+laUTTBSd4sfxB+Su5Ik1e6K2W
         EuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813741; x=1754418541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO3LxJDRPcHqqVPBxktzU6xoRl90LUTMrbnnuWkT+tY=;
        b=xDEP7bVRq2c7qvMC9/lTkIm0W7fGQiP8DTi8Y9WT4IhZ87sD70QTjnStExwHZDLo9N
         hrQu7EEHrp80qwNo9kIikERSrSztPBwYOb7CwIgCyFPIcgf2DkjcADg1J0eAdelHRMpO
         CzSFQGLzI2t+MrOcXnxL7kD0Q/HtcS8vIS4O0XlD7TO1mE7oToYhxsVzVe9t/wK6Zt7G
         rSAK4sGr70B9WthbTRo7lORd2UL8Lm7ff5n4YsCJck6icuMPmyFJwsZ0wIuD50jy86ce
         98T4QdyikqWf/Gy5tM/VPm4v2N6VYSvEnU14j3E0ZQA5GFlCarjl556yIyoHDTtEPb0/
         g7wg==
X-Gm-Message-State: AOJu0Yy8hYEIbdSVBlaa/5X7sqmOjwXfLnjdG2ecImWhLoO7Zl1HHSv/
	Nv3je57x38ije0ZODGuaQsWZtj1spW0CjCozIqhopGoKmmbmErygPAkXAHrv7vyn5C00VZAYGEy
	dN3gbND7SlZif5BZT1xVP9zbHvNxLKcyZh5qo
X-Gm-Gg: ASbGncsa3ztKwTZ+nT/SpESTcV4FpyGiOOap4noFCUW0ZOHyByRCf9ZZYkOz6YZla+y
	wzTJW4bYYXSFbiMJhcFhvap49WcVekOVddkAsJQZaGHyVxhXN5q6HJXUXLXFfuNt5jaVfnFG6QN
	158YWud42jTX0+7uHq9G4rT8DHe/rFlQUMAngX7UOVuA5Iav5OlSa15IlyBKh6YKlv0r4hcqO13
	XHAGC/xCeEFlsQhfHP84w==
X-Google-Smtp-Source: AGHT+IHk8OvEke9NAdg8W6bb3YsxldGS8KBz88RBGmm1X7lzFinvUMwPZQoXYJBRZiG2NFgoPBwcXjmxVPLIgfusPDg=
X-Received: by 2002:a05:690c:688e:b0:71a:1b78:a335 with SMTP id
 00721157ae682-71a46a3972fmr10967457b3.42.1753813741148; Tue, 29 Jul 2025
 11:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729182550.185356-1-ameryhung@gmail.com>
In-Reply-To: <20250729182550.185356-1-ameryhung@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 29 Jul 2025 11:28:48 -0700
X-Gm-Features: Ac12FXxT33n24YNEEZQEm0Ls1Rgk60lpjyMpWbol_WU0jsJjLp3j0F1iYYOeeeo
Message-ID: <CAMB2axM2qgsstBc+efRN4CU0V1-dMa7DemPkTHZ1Fhdku7o2HQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 00/11] Remove task and cgroup local
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kpsingh@kernel.org, 
	martin.lau@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The title is "Remove task and cgroup local storage percpu counters"

On Tue, Jul 29, 2025 at 11:25=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> * Motivation *
>
> The goal of this patchset is to make bpf syscalls and helpers updating
> task and cgroup local storage more robust by removing percpu counters
> in them. Task local storage and cgroup storage each employs a percpu
> counter to prevent deadlock caused by recursion. Since the underlying
> bpf local storage takes spinlocks in various operations, bpf programs
> running recursively may try to take a spinlock which is already taken.
> For example, when a tracing bpf program called recursively during
> bpf_task_storage_get(..., F_CREATE) tries to call
> bpf_task_storage_get(..., F_CREATE) again, it will cause AA deadlock
> if the percpu variable is not in place.
>
> However, sometimes, the percpu counter may cause bpf syscalls or helpers
> to return errors spuriously, as soon as another threads is also updating
> the local storage or the local storage map. Ideally, the two threads
> could have taken turn to take the locks and perform their jobs
> respectively. However, due to the percpu counter, the syscalls and
> helpers can return -EBUSY even if one of them does not run recursively
> in another one. All it takes for this to happen is if the two threads run
> on the same CPU. This happened when BPF-CI ran the selftest of task local
> data. Since CI runs the test on VM with 2 CPUs, bpf_task_storage_get(...,
> F_CREATE) can easily fail.
>
> The failure mode is not good for users as they need to add retry logic
> in user space or bpf programs to avoid it. Even with retry, there
> is no guaranteed upper bound of the loop for a succeess call. Therefore,
> this patchset seeks to remove the percpu counter and makes the related
> bpf syscalls and helpers more reliable, while still make sure recursion
> deadlock will not happen, with the help of resilient queued spinlock
> (rqspinlock).
>
>
> * Implementation *
>
> To remove the percpu counter without introducing deadlock,
> bpf_local_storage is refactored by changing the locks from raw_spin_lock
> to rqspinlock, which prevents deadlock with deadlock detection and a
> timeout mechanism.
>
> There are two locks in bpf_local_storage due to the ownership model as
> illustrated in the figure below. A map value, which consists of a
> pointer to the map and the data, is a bpf_local_storage_map_data (sdata)
> stored in a bpf_local_storage_elem (selem). A selem belongs to a
> bpf_local_storage and bpf_local_storage_map at the same time.
> bpf_local_storage::lock (lock_storage->lock in short) protects the list
> in a bpf_local_storage and bpf_local_storage_map_bucket::lock (b->lock)
> protects the hash bucket in a bpf_local_storage_map.
>
>
>  task_struct
> =E2=94=8C task1 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90       bpf_local_storage
> =E2=94=82 *bpf_storage =E2=94=82---->=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98<--=
--=E2=94=82 *owner  =E2=94=82         bpf_local_storage_elem
>                      =E2=94=82 *cache[16]        (selem)              sel=
em
>                      =E2=94=82 *smap   =E2=94=82        =E2=94=8C=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>                      =E2=94=82 list    =E2=94=82------->=E2=94=82 snode  =
  =E2=94=82<------->=E2=94=82 snode    =E2=94=82
>                      =E2=94=82 lock    =E2=94=82  =E2=94=8C---->=E2=94=82=
 map_node =E2=94=82<--=E2=94=90 =E2=94=8C-->=E2=94=82 map_node =E2=94=82
>                      =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98  =E2=94=82     =E2=94=82 s=
data =3D  =E2=94=82   =E2=94=82 =E2=94=82   =E2=94=82 sdata =3D  =E2=94=82
>  task_struct                      =E2=94=82     =E2=94=82 {&mapA,} =E2=94=
=82   =E2=94=82 =E2=94=82   =E2=94=82 {&mapB,} =E2=94=82
> =E2=94=8C task2 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90      bpf_local_storage =E2=94=94=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98   =
=E2=94=82 =E2=94=82   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> =E2=94=82 *bpf_storage =E2=94=82---->=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90  =E2=94=82 =
                   =E2=94=82 =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98<--=
--=E2=94=82 *owner  =E2=94=82  =E2=94=82                    =E2=94=82 =E2=
=94=82
>                      =E2=94=82 *cache[16] =E2=94=82      selem         =
=E2=94=82 =E2=94=82    selem
>                      =E2=94=82 *smap   =E2=94=82  =E2=94=82     =E2=94=8C=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90   =E2=94=82 =E2=94=82   =E2=94=8C=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90
>                      =E2=94=82 list    =E2=94=82--=E2=94=82---->=E2=94=82=
 snode    =E2=94=82<--=E2=94=82-=E2=94=82-->=E2=94=82 snode    =E2=94=82
>                      =E2=94=82 lock    =E2=94=82  =E2=94=82 =E2=94=8C-->=
=E2=94=82 map_node =E2=94=82   =E2=94=94-=E2=94=82-->=E2=94=82 map_node =E2=
=94=82
>                      =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98  =E2=94=82 =E2=94=82   =E2=
=94=82 sdata =3D  =E2=94=82     =E2=94=82   =E2=94=82 sdata =3D  =E2=94=82
>  bpf_local_storage_map            =E2=94=82 =E2=94=82   =E2=94=82 {&mapB,=
} =E2=94=82     =E2=94=82   =E2=94=82 {&mapA,} =E2=94=82
>  (smap)                           =E2=94=82 =E2=94=82   =E2=94=94=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> =E2=94=8C mapA =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90                   =E2=94=82 =E2=94=82                    =
=E2=94=82
> =E2=94=82 bpf_map map =E2=94=82      bpf_local_storage_map_bucket        =
=E2=94=82
> =E2=94=82 *buckets    =E2=94=82---->=E2=94=8C b[0] =E2=94=90      =E2=94=
=82 =E2=94=82                    =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98     =E2=94=
=82 list =E2=94=82------=E2=94=98 =E2=94=82                    =E2=94=82
>                     =E2=94=82 lock =E2=94=82        =E2=94=82            =
        =E2=94=82
>                     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98        =E2=94=82                    =E2=94=82
>  smap                 ...           =E2=94=82                    =E2=94=
=82
> =E2=94=8C mapB =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90                     =E2=94=82                    =E2=94=82
> =E2=94=82 bpf_map map =E2=94=82      bpf_local_storage_map_bucket        =
=E2=94=82
> =E2=94=82 *buckets    =E2=94=82---->=E2=94=8C b[0] =E2=94=90        =E2=
=94=82                    =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98     =E2=94=
=82 list =E2=94=82--------=E2=94=98                    =E2=94=82
>                     =E2=94=82 lock =E2=94=82                             =
=E2=94=82
>                     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98                             =E2=94=82
>                     =E2=94=8C b[1] =E2=94=90                             =
=E2=94=82
>                     =E2=94=82 list =E2=94=82-----------------------------=
=E2=94=98
>                     =E2=94=82 lock =E2=94=82
>                     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98
>                       ...
>
>
> The refactoring is divided into three steps.
>
> First, in patch 1-4, local storage helpers that take locks are being
> converted to failable. The functions are changed from returning void to
> returning an int error code with the return value temporarily set to 0.
> In callers where the helpers cannot fail in the middle of an update,
> the helper is open coded. In callers that are not allowed to fail, (i.e.,
> bpf_local_storage_destroy() and bpf_local_storage_map_free(), we make
> sure the functions cannot be called recursively, causing deadlock, and
> assert the return value to be 0.
>
> Then, in patch 5, the locks are changed to rqspinlock, and the error
> returned from raw_res_spin_lock_irqsave() is propogated to the syscalls
> and heleprs.
>
> Finally, in patch 7-8, the percpu counters in task and cgroup local
> storage are removed.
>
> Question:
>
> - In bpf_local_storage_destroy() and bpf_local_storage_map_free(), where
>   it is not allow to fail, I assert that the lock acquisition always
>   succeeds based on the fact that 1) these paths cannot run recursively
>   causing AA deadlock and 2) local_storage->lock and b->lock are always
>   acquired in the same order, but I also notice that rqspinlock has
>   a timeout fallback. Is this assertion an okay thing to do?
>
>
> * Test *
>
> Task and cgroup local storage selftests have already covered deadlock
> caused by recursion. Patch 9 updates the expected result of task local
> storage selftests as task local storage bpf helpers can now run on the
> same CPU as they don't cause deadlock.
>
> * Patch organization *
>
>   E(exposed) L(local storage lock) B(bucket lock)
>   EL    __bpf_local_storage_insert_cache (skip cache update)
>   ELB   bpf_local_storage_destroy (cannot recur)
>   ELB   bpf_local_storage_map_free (cannot recur)
>   ELB   bpf_selem_unlink                  --> Patch 4
>   E B   bpf_selem_link_map                --> Patch 2
>     B   bpf_selem_unlink_map              --> Patch 1
>    L    bpf_selem_unlink_storage          --> Patch 3
>
>   During the refactoring, to make sure all exposed functions
>   handle the error returned by raw_res_spin_lock_irqsave(),
>   __must_check is added locally to catch all callers.
>
>   Patch 1-4
>     Convert local storage helpers to failable, or open-code
>     the helpers
>
>   Patch 5
>     Change local_storage->lock and b->lock from
>     raw_spin_lock to rqspinlock
>
>   Patch 6
>     Remove percpu lock in task local storage and remove
>     bpf_task_storage_{get,delete}_recur()
>
>   Patch 7
>     Remove percpu lock in cgroup local storage
>
>   Patch 8
>     Remove percpu lock in bpf_local_storage
>
>   Patch 9
>     Update task local storage recursion test
>
>   Patch 10
>     Remove task local storage stress test
>
>   Patch 11
>     Update btf_dump to use another percpu variable
>
> ----
>
> Amery Hung (11):
>   bpf: Convert bpf_selem_unlink_map to failable
>   bpf: Convert bpf_selem_link_map to failable
>   bpf: Open code bpf_selem_unlink_storage in bpf_selem_unlink
>   bpf: Convert bpf_selem_unlink to failable
>   bpf: Change local_storage->lock and b->lock to rqspinlock
>   bpf: Remove task local storage percpu counter
>   bpf: Remove cgroup local storage percpu counter
>   bpf: Remove unused percpu counter from bpf_local_storage_map_free
>   selftests/bpf: Update task_local_storage/recursion test
>   selftests/bpf: Remove test_task_storage_map_stress_lookup
>   selftests/bpf: Choose another percpu variable in bpf for btf_dump test
>
>  include/linux/bpf_local_storage.h             |  14 +-
>  kernel/bpf/bpf_cgrp_storage.c                 |  60 +-----
>  kernel/bpf/bpf_inode_storage.c                |   6 +-
>  kernel/bpf/bpf_local_storage.c                | 202 ++++++++++++------
>  kernel/bpf/bpf_task_storage.c                 | 153 ++-----------
>  kernel/bpf/helpers.c                          |   4 -
>  net/core/bpf_sk_storage.c                     |  10 +-
>  .../bpf/map_tests/task_storage_map.c          | 128 -----------
>  .../selftests/bpf/prog_tests/btf_dump.c       |   4 +-
>  .../bpf/prog_tests/task_local_storage.c       |   8 +-
>  .../bpf/progs/read_bpf_task_storage_busy.c    |  38 ----
>  11 files changed, 184 insertions(+), 443 deletions(-)
>  delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_ma=
p.c
>  delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_stora=
ge_busy.c
>
> --
> 2.47.3
>

