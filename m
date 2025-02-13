Return-Path: <bpf+bounces-51372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD75A337DF
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 07:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C076188AF1D
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41E3207A11;
	Thu, 13 Feb 2025 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/TB9BCi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674F182B4;
	Thu, 13 Feb 2025 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427686; cv=none; b=KWQHg1iSQf69NLVwR8Gy58idFSuTjUAJr9TIbTslpLK1KggfxOnVnhsFHMSwZIvtSeDaqgj6cmLE5KG0JMD2P/CqZgJ6qv1VSstD1+U4wtMGKtLB+MYx8GsEO2xIAQ1OHj183ovappwY4HK/r84MxiTM/cY+TqDMDuuFH/Zi8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427686; c=relaxed/simple;
	bh=f9cyDb93TE0/0D+Ql0u6NLa6G5/L6znrZIx9uJ6XbWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBh4yLoRwt1t+Qo/gMYt/H4LzBmNxznd13+TWa/i6PbSFTeSbVLQpbjDJAyOm5wiabWYZZFWgLPIiOBq0mQHk0EMEQG9O7F33TF1UOT9W8j4Z3gc6KQhb5xIkQqhxES0twI9UnOdH7hRKVHKVDtJI/0xcL80wHqUEadYlrKfMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/TB9BCi; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5de6e26d4e4so871629a12.1;
        Wed, 12 Feb 2025 22:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739427683; x=1740032483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f9cyDb93TE0/0D+Ql0u6NLa6G5/L6znrZIx9uJ6XbWo=;
        b=T/TB9BCiISUsV0cwAqFH8E45XougohMYX/nrh/zFVley6N9zpEbZbck2yIclb0xI8v
         /I3M0781lan8jokG09YQfLiGxuthUa6tzsZR2PedTzqvR7+aeVNC3e8CJBrDSjSU/RZv
         S0DauOytbkVHQ4vTs5yJ1Nx2RTATfzk/bE0+y6jezkd+D4oBaF9NQC9pHdubLbeGFelS
         GAXh58oBFeTEcWXapp1vHKoEYrhUV3hru2DASIRbME+zTq/HgWHLJk5Oo72saYs2uSoz
         VwLjpn36sbqhv1nVs8xuspUbOaFuVtKvZj2GusLHoalMtX+d7yL6Y5mtGgyQusxi6+Wo
         QUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739427683; x=1740032483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9cyDb93TE0/0D+Ql0u6NLa6G5/L6znrZIx9uJ6XbWo=;
        b=pq//x6gJ0ndUjsb18raLg3fTBuLOSIF7aJDuNxd90jZRzU0UZn/GZsFxETcOZ1Lnqk
         vKiRAZrAVE3VLqNKi9buO1YbFNWRMkbzCEfomxa9vZGPOXveZze5BoXiyuPnmkjkuJH9
         y/l3ssjKZHASAK93XDpFivpYzJdh1w9d4sQnK4NIPoNHFHsyQ5T/M1BmZ3fJXSQ7QIr/
         zl+akxMBA7pjpF3cThLpa71g9q5seUumPUrxL9CF1yKRtpixJK3zce2ZskSgDO3Pu2V8
         HmsRLeYPWtVmvEX2ZMq2r/O3uTmO5YpKmbu2fM/OcfG48EddhhfXgSmflGXPJDcsXR1a
         mUrA==
X-Forwarded-Encrypted: i=1; AJvYcCXNp2iEaO14NAsLwEYkCvmpVcmvFaYYACMoz50ZZxmbdMzjfaQxkndmasfQaPnaUmzb2IuigkMqWjAfzBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb14AHKwOnry9KF2I70L33WfTAMDBdFmDMw/eYPrcPcRDZoP6M
	In6he/6mCw9rUVnOnzrl30/mkiKVZugT06Ew6avlb88g66U7cRzpjfS1Hv9cjzPDb3Up55XFm5+
	jSXmM+DgsjuCajYA8IrgJr51rvSM=
X-Gm-Gg: ASbGncsSMJ+vQgr9GkaKUpScJd9Vfidult6ThZgsfJoQKRKtvT4Dbuil6qaGUfEdMor
	7fjd/mxafs2jPfNfLiuhWPOHLhMHWx+T6GDVonNOy56YUSda3dA2H9x4yQYAIiM2209VDryzJ+g
	==
X-Google-Smtp-Source: AGHT+IHrm5By/28fx7ySfNVi+JhpEMb9EuxiDvYOgbwjenRd2MLUXZ43hSkCiR1DLOCGk5FM46gnlv7cC9iyM6xN20A=
X-Received: by 2002:a05:6402:51d1:b0:5de:6038:7572 with SMTP id
 4fb4d7f45d1cf-5deadd935demr5083640a12.10.1739427682686; Wed, 12 Feb 2025
 22:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-10-memxor@gmail.com>
 <20250210101730.GI10324@noisy.programming.kicks-ass.net>
In-Reply-To: <20250210101730.GI10324@noisy.programming.kicks-ass.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 13 Feb 2025 07:20:46 +0100
X-Gm-Features: AWEUYZlCllGUxdyfURvBU-PhlFqaVJ1z2l67g6FO-tnFM3hCsuO7r-OHUZ-QUsA
Message-ID: <CAP01T74hRYCkrqz4JKqXH7ya0ykBfX4_6611q-TO52o1TZsfjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/26] rqspinlock: Protect waiters in queue
 from stalls
To: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barret Rhoden <brho@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, linux-arm-kernel@lists.infradead.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 11:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 06, 2025 at 02:54:17AM -0800, Kumar Kartikeya Dwivedi wrote:
> > Implement the wait queue cleanup algorithm for rqspinlock. There are
> > three forms of waiters in the original queued spin lock algorithm. The
> > first is the waiter which acquires the pending bit and spins on the lock
> > word without forming a wait queue. The second is the head waiter that is
> > the first waiter heading the wait queue. The third form is of all the
> > non-head waiters queued behind the head, waiting to be signalled through
> > their MCS node to overtake the responsibility of the head.
> >
> > In this commit, we are concerned with the second and third kind. First,
> > we augment the waiting loop of the head of the wait queue with a
> > timeout. When this timeout happens, all waiters part of the wait queue
> > will abort their lock acquisition attempts.
>
> Why? Why terminate the whole wait-queue?
>
> I *think* I understand, but it would be good to spell out. Also, in the
> comment.

Ack. The main reason is that we eschew per-waiter timeouts with one
applied at the head of the wait queue.
This allows everyone to break out faster once we've seen the owner /
pending waiter not responding for the timeout duration from the head.
Secondly, it avoids complicated synchronization, because when not
leaving in FIFO order, prev's next pointer needs to be fixed up etc.

Let me know if this explanation differs from your understanding.

