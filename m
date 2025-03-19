Return-Path: <bpf+bounces-54359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD41A6834D
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 03:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE4A19C68F1
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 02:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1592E24E4C3;
	Wed, 19 Mar 2025 02:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5VTP6pH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129BAD2F;
	Wed, 19 Mar 2025 02:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352426; cv=none; b=egoHkG4oZBWq0LpYzls4rs0y+GP/f+2+dBL6R1d5ZkvJ8M0fnmrKsGlridFNLac1UZMU4jJU0661fBfqnI683Tj9vSMepOH6set8OS/XWyG4ps7MVlM9WYDOAqwB3Huq0cHW36CjWjx3LCc7j3Z+xHGkD/jMxZer1u8/Mkn0nnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352426; c=relaxed/simple;
	bh=Dn3PWelJFddmp3s83Ht4bxxUTBHLl1iUXwTZRYpRWiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dk9ABRgKWxE54dXUV7psATLqTA/Sa5UAWshmuxz1GHVFOHl3SnYxzQNjLcDfVpmMfkync004OsG+SCj1Pyc2scN/b/oHPJqzR1MY3b1Ft3Xdne06eFRop6QeT9EuSUqNs8t9saxEonztibAYZrGeEQRcrWkQL+5gQ3TJ3HrOt7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5VTP6pH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso29143755e9.0;
        Tue, 18 Mar 2025 19:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742352423; x=1742957223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNwRjgTV5vyjSkK1YIBebLoMJzNTyzSDJ2Cwgi8wBxA=;
        b=M5VTP6pHbzhXijA6lBHfmeJ7unhrvniUrpOn5jEmbkGU5CpGY6B/c2/XX6zjysXQob
         AtfQ/H/1UqGzVB7sqzwJY5znLKTTH7JMRFrYfVZOyzpanIu4qo3mBSuTiOVs1hBtfaZL
         EUB+fSVYUkzuZJ+OkcVWOgyYkL0o83ymEnk7QED7lE31mICr5MXIpuqywALA6EjKuPlL
         +YhP6Hi/UM7+Ulqjipqp/QtkZEjhNmivR1LAYgGeGcNewIakrxEoZWfQ6TRrrAo7Ey8s
         SeL9D2IOPyoByL/tyWszsZcFlVvX0oeF7LAyqJt+A+B38zUbVhgYsLNg6JLXc0FWtG3Z
         yOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742352423; x=1742957223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNwRjgTV5vyjSkK1YIBebLoMJzNTyzSDJ2Cwgi8wBxA=;
        b=Hv9WY1qkTv1z3RpzzLJvnyUaewWR4OmzcpCHVwrZJdFlOqGpttux1DWYZBT06p6Uu4
         UI1ijJMeQQ1Kvxmhfpvfc1VZnMy2j9UrWD2An7DNMFrqkbIM2knqs2GRovjQe/lSqnCV
         4oGkuWJTi3KGUqTODAOulOH30Wzz6b48B5a1cwYTY6lw93J+cHZppLlGr8o8vJQgdloO
         tn4wGpFt9eLQBThktRm9oKmnFRAcd7fTzxu/atHyEryfpbQu2mCotnhyxtIdvvb+fBzD
         X5kTK2vbpusxDumr49DJwTJD/+AzwemlPyIFQ9z8IPI3nqaZ6LrUn8yj+ZCn89V9LE77
         /Lsw==
X-Forwarded-Encrypted: i=1; AJvYcCVlZ7Q2c8Xm9ZhdX4r/wtPXE04x3ds+m004MFOL0XUB62uLm1b7h7bSf6np0YPGRDLfxnM=@vger.kernel.org, AJvYcCVwQ0exN2p8IGVcoPhqLHsBNjPcNDjGyKhAklCo1OrzLT7P1JawLwKdMO/qcQPQHGdlTaA4cjBY@vger.kernel.org, AJvYcCXII6ztW8Jt7vTpSsZF8oNyQKynpgQ7KxRtCFulN7COtAIzomAoGpxmOGzUE6Wa+hSDptzTi2fCnu/C48iM@vger.kernel.org, AJvYcCXqUf6H7/4MyLgJz1NpNh9dL9hwHN+iTh7fSarOFf8JVH4V0Fk4Gqpg9ZTjRqctg7aeMmtsGcM5bYLghw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSEJR0AE2Qbt/shLNJLSAc/Yd1gxYTYCL/0RP+EQSbwnqOMl0b
	yW4YyzFhU62V28NLGjv/M9Ou/+6gdrLFIvl/24qB/kUqNM8uDQs24v1z71NnpRyNV0xZCIDckiv
	YcA7++G11KxELGfbtX9eNDgjdySUytO5z
X-Gm-Gg: ASbGnctvbBUinsiC2jOQ4rCTS3WbDYfhZa9Xp5GD3VIrcxk7mMiE3SOtSRhTAGAQfSf
	ijYZJLCKumLjT4gIiHGSi8DkwD+mptOE6oVgV4cvTSlRYLsqFXqmKyDn9vCHd9vgI1N2pQkx8iM
	W8s4sZ1K9u0H1zsx13yv5Ds0WXwiIWRPy3gRmZ933QyMyuDTa9p9wH
X-Google-Smtp-Source: AGHT+IE6MFlMuJtugrViJVg66D6og8DYJPY2VbtA0lQZ4r7b8uYfAxYuEvDGrs357PIC6nGVQardy/0Uda7JcMYyTAs=
X-Received: by 2002:a5d:5982:0:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-399739c1524mr816039f8f.14.1742352423079;
 Tue, 18 Mar 2025 19:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au>
In-Reply-To: <20250319133309.6fce6404@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Mar 2025 19:46:52 -0700
X-Gm-Features: AQ5f1JqdE91XzIdfoDPQyyQUyj5uA6okIPHz4NL_DcBD8mOsI7c3nyOiy4dAGww
Message-ID: <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Uros Bizjak <ubizjak@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:33=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the bpf-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> In file included from include/asm-generic/percpu.h:7,
>                  from arch/x86/include/asm/percpu.h:630,
>                  from arch/x86/include/asm/preempt.h:6,
>                  from include/linux/preempt.h:79,
>                  from include/linux/smp.h:116,
>                  from kernel/locking/qspinlock.c:16:
> kernel/locking/qspinlock.h: In function 'decode_tail':
> include/linux/percpu-defs.h:219:45: error: initialization from pointer to=
 non-enclosed address space
>   219 |         const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))=
NULL;    \
>       |                                             ^
> include/linux/percpu-defs.h:237:9: note: in expansion of macro '__verify_=
pcpu_ptr'
>   237 |         __verify_pcpu_ptr(ptr);                                  =
       \
>       |         ^~~~~~~~~~~~~~~~~
> kernel/locking/qspinlock.h:67:16: note: in expansion of macro 'per_cpu_pt=
r'
>    67 |         return per_cpu_ptr(&qnodes[idx].mcs, cpu);
>       |                ^~~~~~~~~~~
> include/linux/percpu-defs.h:219:45: note: expected 'const __seg_gs void *=
' but pointer is of type 'struct mcs_spinlock *'
>   219 |         const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))=
NULL;    \
>       |                                             ^
> include/linux/percpu-defs.h:237:9: note: in expansion of macro '__verify_=
pcpu_ptr'
>   237 |         __verify_pcpu_ptr(ptr);                                  =
       \
>       |         ^~~~~~~~~~~~~~~~~
> kernel/locking/qspinlock.h:67:16: note: in expansion of macro 'per_cpu_pt=
r'
>    67 |         return per_cpu_ptr(&qnodes[idx].mcs, cpu);
>       |                ^~~~~~~~~~~
> kernel/locking/qspinlock.c: In function 'native_queued_spin_lock_slowpath=
':
> kernel/locking/qspinlock.c:285:41: error: passing argument 2 of 'decode_t=
ail' from pointer to non-enclosed address space
>   285 |                 prev =3D decode_tail(old, qnodes);
>       |                                         ^~~~~~
> In file included from kernel/locking/qspinlock.c:30:
> kernel/locking/qspinlock.h:62:79: note: expected 'struct qnode *' but arg=
ument is of type '__seg_gs struct qnode *'
>    62 | static inline __pure struct mcs_spinlock *decode_tail(u32 tail, s=
truct qnode *qnodes)
>       |                                                                 ~=
~~~~~~~~~~~~~^~~~~~
> In file included from kernel/locking/qspinlock.c:401:
> kernel/locking/qspinlock.c: In function '__pv_queued_spin_lock_slowpath':
> kernel/locking/qspinlock.c:285:41: error: passing argument 2 of 'decode_t=
ail' from pointer to non-enclosed address space
>   285 |                 prev =3D decode_tail(old, qnodes);
>       |                                         ^~~~~~
> kernel/locking/qspinlock.h:62:79: note: expected 'struct qnode *' but arg=
ument is of type '__seg_gs struct qnode *'
>    62 | static inline __pure struct mcs_spinlock *decode_tail(u32 tail, s=
truct qnode *qnodes)
>       |                                                                 ~=
~~~~~~~~~~~~~^~~~~~
>
> Caused by the resilient-queued-spin-lock branch of the bpf-next tree
> interacting with the "Enable strict percpu address space checks" series
> form the mm-stable tree.

Do you mean this set:
https://lore.kernel.org/all/20250127160709.80604-1-ubizjak@gmail.com/

>
> I don't know why this happens, but reverting that branch inf the bpf-next
> tree makes the failure go away, so I have done that for today.

Kumar,

pls take a look.

