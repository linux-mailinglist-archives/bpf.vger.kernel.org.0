Return-Path: <bpf+bounces-39314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECEC971966
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 14:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8418B1C23049
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 12:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931B1B78FD;
	Mon,  9 Sep 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCWnd3za"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193A1B3B15
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885359; cv=none; b=SM5J+Ch84Fk5RmASO3zYWXzscWxO/06+7j2MwdJ2/NFXKRbAaDAxvIoL3GUSjqapqOARqanLnqRWYyznoFsXDvi0xA9T2DGuTVcBF5hSEg20eLq2TGxkNkIf13xrk5N8yrNLxJycVUiBFhjTsd0fFkMExW0WdppfanBKkuZe8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885359; c=relaxed/simple;
	bh=MA+HcgDvLW83Ymxu9IsChq33lTehtLFFHUfEU4mQ44Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJCbKPW1tlv+LNPhdABuaISF4roIKZdAz+kNeftnsL95RzAReeDyXkYot7gffa9Civ6aKXgcxC0rvcNTi5y9VlNjMD4jxvLDnzHVrLBk4k+GRAMZATwHEcXYy2umM4UMtiyDy/VIBDWbKTZxov3PDpZ1/VfpArLJEvHa5nfJCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lCWnd3za; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53661d95508so6142e87.1
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725885356; x=1726490156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItkNpbg3b1iQLTwUvcYvCzK1VuBRAi6YVDO131ItVjs=;
        b=lCWnd3zarZv4fjZ72QoKr9Lni7taADtD/ZhigDT/oKQ1fmf99uYTKFtN4nQaXpDi3z
         p+kLijj73kNPgQ16M3HNc1XqgD7m4z+lQqoUeHVQ1bJ+WG0eTl4TDNEjzdPDAwdgc7Hy
         0BN1XnZ9FbsUC8DmQP8xrWLk1dM8pAo1TZT0NoQwX//Zp6YLmkcsjbeP10oOAqzwFSn+
         OJjHQiRTXjpPYftezBK3LSFqGj/KfCeQXN4PxaoqBGqCK08Ten/mqs3a05VoRa8pnvip
         wg7+8DiIuD0hxTleV5fAYziZMQY4EsLeiWC5u1m39W5xTmZTicLnBkYOKQ6IKg0e4jw9
         g1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725885356; x=1726490156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItkNpbg3b1iQLTwUvcYvCzK1VuBRAi6YVDO131ItVjs=;
        b=p3+e6XgY+r5rESs6nWZfjOl0/qR4W2k1xTEDeRjJKmhJ1GhhgQ92S5iglC3snOVV2o
         iw0S9e35IP/1AFfkag4Bh7gq7f3QDXWG/KEGat5vIuipkX8b7K1aZbdMtmBdEG/tLrhD
         tWTC1z6rdOt6DQ4zhj2qEaBTaZj+ozkz7O+PMCdJZzQDajrK07ccxzZEgvrCpqUvmf0t
         CHCFHsedENdt2yA3SEncS1QY2lT8qQCEgMgFefHpT6kAG/SpZ4ejsjoxQBr59I7dNEML
         cmg3tmbbuO86MHa9s4yFioZ7/tfOvwnGG5IUmhAfEcP/Wa4opdkJKAUf98yfLplSxQqi
         4TSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlcP0zYf6H/YfZ0GtGOYQV1MREeC2Rvvd2JRw575K48kCRFyCLdCRG2bCKBWnH5DNqons=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSTzXK6i20K1yuF/bEt2iU7eWnes7sUA06NDPMFZVZiB5J99U
	uTcthkm3KpRXJNJOo3g3hkCE7jvfqy99rdLbPpT4dCpk/Wut33U4FeHKSPO7Yi6nRjqjqd60+qy
	mEfalLQTZ5b0JRGsVYIg1B7yQS9QmszFdDe6P
X-Google-Smtp-Source: AGHT+IGGsTOsKMOzuVujWW/9F9gatm28KzGs7KuJZ0r/H8oFsyXYru+A8pCPf172NNXYDzQoEw6rG6CU7Y501Yf4VYs=
X-Received: by 2002:a05:6512:23aa:b0:536:52dc:291f with SMTP id
 2adb3069b0e04-5365eb6a2f4mr188381e87.1.1725885354776; Mon, 09 Sep 2024
 05:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-2-andrii@kernel.org>
In-Reply-To: <20240906051205.530219-2-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Sep 2024 14:35:17 +0200
Message-ID: <CAG48ez2hAQBj-VnimJBd3M-ioANVTk+ZQXYWD+j9G+ip2K_nfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int s=
eq)
> +{
> +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> +       return seq =3D=3D smp_load_acquire(&mm->mm_lock_seq);
> +}

A load-acquire can't provide "end of locked section" semantics - a
load-acquire is a one-way barrier, you can basically use it for
"acquire lock" semantics but not for "release lock" semantics, because
the CPU will prevent reordering the load with *later* loads but not
with *earlier* loads. So if you do:

mmap_lock_speculation_start()
[locked reads go here]
mmap_lock_speculation_end()

then the CPU is allowed to reorder your instructions like this:

mmap_lock_speculation_start()
mmap_lock_speculation_end()
[locked reads go here]

so the lock is broken.

>  static inline void mmap_write_lock(struct mm_struct *mm)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write(&mm->mmap_lock);
> +       inc_mm_lock_seq(mm);
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }

Similarly, inc_mm_lock_seq(), which does a store-release, can only
provide "release lock" semantics, not "take lock" semantics, because
the CPU can reorder it with later stores; for example, this code:

inc_mm_lock_seq()
[locked stuff goes here]
inc_mm_lock_seq()

can be reordered into this:

[locked stuff goes here]
inc_mm_lock_seq()
inc_mm_lock_seq()

so the lock is broken.

For "taking a lock" with a memory store, or "dropping a lock" with a
memory load, you need heavier memory barriers, see
Documentation/memory-barriers.txt.

