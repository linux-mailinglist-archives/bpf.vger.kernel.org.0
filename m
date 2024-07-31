Return-Path: <bpf+bounces-36108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1500894241F
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 03:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F901F2304E
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943FF8F5E;
	Wed, 31 Jul 2024 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJd42Ik1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805554C80
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722388785; cv=none; b=REr7iILN0E6N4kNDNl5vakwRYzSwHUD7cS/Taexu0HYUHKBvbE7Ee69yZn3VJscFpAhWsNSTnrj3vbYDNSL3IeixiT3bjO/gVHYC7JIJmcFPh0l/O4w9XEk9qAHgzrnS4oplmwrb5fGSBpmgNbuX8rJr0P77wu5CG7eIsWJQ8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722388785; c=relaxed/simple;
	bh=K1Rl9zFKNMVL9U+1qhqgCjz33KVGNnym9uqCrqK2HKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhT45EqTDks8zxf6VJ8tggYIhZfNoSriPn0h2iBu70Iu72oEvObbNWePY9NODDMBq64x4mZaUHkQlTO22vaa7//RJ0Fmzj6nqvkY2MNHxoTeE2F3B1RLYNUhC6HIUnNdXH4Q4ss7GMbG/DFj7IopksnkUT4jjhHPDPhrm1SqdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJd42Ik1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281abc64dfso26024155e9.3
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 18:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722388782; x=1722993582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKGhROCx3OEsTrCHK9IvbJ1Fe1XEE+spPWsK4HO23VU=;
        b=kJd42Ik1ENJbQ+QHwtW98I69FycYQTZvOgKb/wXtxPOjE1AAw/VAN1OViaqJLNhKN/
         LdSEDldvq3E5uX55aBUzZZFTnj+SnKdcI78DYsi1bvTteu92D6kYIOTufKKqRdCBweIQ
         XXPNcB7uxX1xQ3whZpHhNMmwYXsW93uNzPctyrODdZHTFCcTIcxs9lDeKwxAUTK1DH/c
         iC0ysdez34pDz80CFtHMYpM3oWLtv9bHkcMPzgzL1ibMZDip71iCYThX9f1J7Cun+DlM
         LQpRZ7z+0/AXjZDXwQsqUnbehSANsCQ1lOO6jxNpoKWOgMpxH6E7e3NcL8huI7efPCGW
         olUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722388782; x=1722993582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKGhROCx3OEsTrCHK9IvbJ1Fe1XEE+spPWsK4HO23VU=;
        b=IBlxN8JP6OcS+EYov699Mja2sSYqDbVQCu8Ivaj0Rx85evzzvHoirCGWRnEEika5Rd
         bA4otN+5H79+Su22KYaTJh97pgkyaX8zWSmtwaydJKaMbizhf8fG1EPTwVH8Cp+MrxIj
         /Tk9fY2Euod1frPQ3cjuntj9v2TZQNqF2K4SF68O7bgYCkFI8E0N9f6WqqzVa9W1BJsq
         RGuR5vDTh9kHfpPnXrts8mqGWHVOFvQYvGBgyM8BWytKirFRF0Yb9ZknsDD2wzb6cc7x
         CmTZ82QVecrLdbVKV1fYb9H2m2gDvgZ8odeGWIpYILrGqNH6y7XZmbTWe9NxNetqgo+H
         20aA==
X-Forwarded-Encrypted: i=1; AJvYcCWZhTd/tErAs3a8d1IwUeeex5bYcxvnFvb5zhKTzsZTi4jZ8cGPhIFPYRYgF4LgdFP/gL6zXUvRUYnssQtqzuCZywhZ
X-Gm-Message-State: AOJu0YyCN+6PgJCjFQxE9nusvRpoPvz6HjGzogVynRd+bSIctshH/GDu
	dIToGXAr0wK0kgKg7cdUe242PucZWqYLp2bOvUPHxR+YdL1QklBgjDzgIsesbNZcGxJffTt/kjo
	5VbPg7T4kw9arZfljakzDQUfbh/Y=
X-Google-Smtp-Source: AGHT+IEE+0q0mK+mjv/Rh5tRF+0UaPQpKojEwybqp/hcVv2pRDVfV5RS2eD7pxcr0X9wH/PYxA3EIu+r/iS0mIr2sJY=
X-Received: by 2002:adf:fe51:0:b0:366:ec2c:8646 with SMTP id
 ffacd0b85a97d-36b5d0acf13mr8067393f8f.43.1722388781609; Tue, 30 Jul 2024
 18:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729183246.4110549-1-yepeilin@google.com> <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev>
In-Reply-To: <24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Jul 2024 18:19:30 -0700
Message-ID: <CAADnVQLLjPe3cnb7RSqHHVAP=4W1mbwTz1OFKq51=TR0utyaJQ@mail.gmail.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Peilin Ye <yepeilin@google.com>, "Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, David Vernet <dvernet@meta.com>, 
	Dave Marchevsky <davemarchevsky@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:14=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> > This sounds like a compiler bug.
> >
> > Yonghong, Jose,
> > do you know what compilers do for other backends?
> > Is it allowed to convert sycn_fetch_add into sync_add when fetch part i=
s unused?
>
> This behavior is introduced by the following llvm commit:
> https://github.com/llvm/llvm-project/commit/286daafd65129228e08a1d07aa4ca=
74488615744
>
> Specifically the following commit message:
>
> =3D=3D=3D=3D=3D=3D=3D
> Similar to xadd, atomic xadd, xor and xxor (atomic_<op>)
> instructions are added for atomic operations which do not
> have return values. LLVM will check the return value for
> __sync_fetch_and_{add,and,or,xor}.
> If the return value is used, instructions atomic_fetch_<op>
> will be used. Otherwise, atomic_<op> instructions will be used.

So it's a bpf backend bug. Great. That's fixable.
Would have been much harder if this transformation was performed
by the middle end.

> =3D=3D=3D=3D=3D=3D
>
> Basically, if no return value, __sync_fetch_and_add() will use
> xadd insn. The decision is made at that time to maintain backward compati=
bility.
> For one example, in bcc
>    https://github.com/iovisor/bcc/blob/master/src/cc/export/helpers.h#L14=
44
> we have
>    #define lock_xadd(ptr, val) ((void)__sync_fetch_and_add(ptr, val))
>
> Should we use atomic_fetch_*() always regardless of whether the return
> val is used or not? Probably, it should still work. Not sure what gcc
> does for this case.

Right. We did it for backward compat. Older llvm was
completely wrong to generate xadd for __sync_fetch_and_add.
That was my hack from 10 years ago when xadd was all we had.
So we fixed that old llvm bug, but introduced another with all
good intentions.
Since proper atomic insns were introduced 3 years ago we should
remove this backward compat feature/bug from llvm.
The only breakage is for kernels older than 5.12.
I think that's an acceptable risk.

