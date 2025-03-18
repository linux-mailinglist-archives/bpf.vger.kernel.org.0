Return-Path: <bpf+bounces-54254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B043A665B8
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 02:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE563B583F
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 01:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819081991BF;
	Tue, 18 Mar 2025 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAuBmH4J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0088BEC
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262320; cv=none; b=qaVoXKyMoz21wr1LXEkIT58hvI6TtdDikrGDPHYB/LhhQxU2yosZjrLu3KjW6ZpBp5T1tmxxl0098PsOMknu0CyuFvEscOFH7URNP7UPlJscuK+9Ha3bLDSv3iBoBK5zsULXyhiFqNu8aMav44ADsr2Gd6WyOcJW9ODza3irlww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262320; c=relaxed/simple;
	bh=U7mvEbACQWfNnWOUFjsjq1LqacGJnnWMNafn6hwFAKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbiDjfGmly46RG8jrUqNZuB0RQMIylqisGP460Mt0sluNTkQiMfYWnk79GARKLC4aFZxb46G6LuUkRl0VSFUMsJBJjKQggYYWRQDTrw8Z536qnFTQsVwnRLsIU5hC4N1/sXD5H6niKJizbNrbYMcJtJQrxED0k7cORh0xY+/Gro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAuBmH4J; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so3954a12.0
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 18:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742262316; x=1742867116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YgdIFV4sG6SH0GVYOW0HiNyV0ubLDRbt7ADU8qpbsw8=;
        b=VAuBmH4JezZWsPxPzjpQt+vDgCkeUEbUdjocLNkEwpRm9umbhw0Gr69f47RzRMjDYL
         Ktc2skQ+8jkiHQLj4JwlLnbQqn69sseRl2c8o0IUdPehwAo8yA7y518y6sDasKiJMdWM
         wZrx5Mul6qXK9Sq5RZNU4js5TlTiBEbnEG+h2Wa7iPiWBKcRflJ+ZXlPU0hbs07eF7V4
         NOmnPxVsWXlpS2csS55SLuOedXjVxx39Ifb15Is716ZVKZzGIGKcLVzWV54X95UAcqjg
         Zry0opec6BTMbhiNviSOisd5pC1LdRYBgEr4wm8s8xeNxdaNzMDgE2AD6KDQqUbxh37K
         epUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262316; x=1742867116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgdIFV4sG6SH0GVYOW0HiNyV0ubLDRbt7ADU8qpbsw8=;
        b=Tw89DehfyxJ8BebRs70riVpjItUOTIAzxA8sYiMHkhc+GD3HbShsuno0lBq8Gy1/WC
         sxLlLIu+gf2xBdkec0SIlQLTzjCigIfZ2OyF69V6kf6PCaunhJTQ2aVi32cRGY8jEyWS
         cA3ZXkU33NOzzEBsNkv7M5hiflLLBPhjbdq70wLgM9T+yqFYcoeTysiBXh3OP0ZbAltE
         EBDXUCdt+3c4ifaLgSIJcL3HLdA0U7KVWOhyTTkuS5PY8X9IRdeXuRVZdI1ZWnwekEE7
         4L/fHHDzl1Jd9VNbm3vkSTlogV8y8rh9zv4H18iguMXfdzvQt2Vs4JzA6/auQjbeLsRV
         B9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVsIp5KeQy1KcKGRwa9ynMboYggu1cnpi3f6RyGSRTpn9mJQ3bUz6jhWEGdXBFdV5oL8+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXeQkzH1PXV/gH7KZMFZwPR0EG0+YXIxoQ/eo3U8JhOK089Tg
	NfkD70XYbyPKy6iJ5+ZHu89ngTCz6ac0zVsmI0l8VMk5z81dHiZvFz0eDnzsrcyD1w1BLVo4r7Q
	e0nW23v7M+Lw5T6s/95fdD341Ym4IYzVpWEAX2IPWZUacrWLStA==
X-Gm-Gg: ASbGncumh7yzZfyekUF6EOac+IUhac8mZQepxR5CY7fzBeSZMOQc1CJR/9d8vZENyrB
	SYcjxu9ChizJ+PpBlAiimlJ7vpGTfHW6BChWWZIWFD+2lfbTTNMpL3Z73+kTIRjxU1crKnfgsKN
	HZlEu9fcORNLYheMwdNFYx3gmoaHrB29M9quuFmm3DFcJwEdf4lwY2S7df+Q==
X-Google-Smtp-Source: AGHT+IGIKF9C56oZgR3Vqx6gTcDZGhKYfZxNS7plqZggvcE8HJgHEISKgh0AL40DhRZd7Uqy/27J0JikD0BWnah3nqI=
X-Received: by 2002:a50:ab14:0:b0:5e5:ba42:80a9 with SMTP id
 4fb4d7f45d1cf-5eb3c17c749mr8490a12.1.1742262316327; Mon, 17 Mar 2025 18:45:16
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com> <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
In-Reply-To: <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Mon, 17 Mar 2025 18:45:05 -0700
X-Gm-Features: AQ5f1JpVcGk-4TnScyrF5rHW_MUqdIBX8wfCTRehX58l2pafJKIgmoFlsbfXTts
Message-ID: <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket iterators
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

Hi Martin,

Thanks a lot for taking a look.

> The batch should have a snapshot of the bucket. Practically, it should not have
> the "repeating" or "missing" a sk issue as long as seq->stop() is not called in
> the middle of the iteration of that batch.
>
> I think this guarantee is enough for the bpf_sock_destroy() and the
> bpf_setsockopt() use case if the bpf prog ends up not seq_write()-ing anything.

Yeah, I realized shortly after sending this out that in the case that
you're purely using the iterator to call bpf_sock_destroy() or
bpf_setsockopt() without any seq_write()s, you would likely never have
to process a bucket in multiple "chunks". Possibly a poor example on
my part :). Although, I have a possibly dumb question even in this
case. Focusing in on just bpf_iter_udp_batch for a second,

>    if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
>        resized = true;
>        /* After allocating a larger batch, retry one more time to grab
>         * the whole bucket.
>         */
>        goto again;
>    }

Barring the possibility that bpf_iter_udp_realloc_batch() fails to
grab more memory (should this basically never happen?), this should
ensure that we always grab the full contents of the bucket on the
second go around. However, the spin lock on hslot2->lock is released
before doing this. Would it not be more accurate to hold onto the lock
until after the second attempt, so we know the size isn't changing
between the time where we release the lock and the time when we
reacquire it post-batch-resize. The bucket size would have to grow by
more than 1.5x for the new size to be insufficient, so I may be
splitting hairs here, but just something I noticed.

But yeah, iterators that also print/dump are the main concern.

> One thought is to avoid seq->stop() which will require to do batching again next
> time, in particular, when the user has provided large buf to read() to ensure it
> is large enough for one bucket. May be we can return whatever seq->buf has to
> the userspace whenever a bucket/batch is done. This will have perf tradeoff
> though and not sure how the userspace can optin.

Hmmm, not sure if I understand here. As you say below, don't we have
to use stop to deref the sk between reads?

> Another random thought is in seq->stop (bpf_iter_{tcp,udp}_seq_stop). It has to
> release the sk refcnt because we don't know when will the userspace come back to
> read(). Will it be useful if it stores the cookies of the sk(s) that have not
> yet seq->show?

Keeping track of all the cookies we've seen or haven't seen in the
current bucket would indeed allow us to avoid skipping any we haven't
seen or repeating those we have on subsequent reads. I had considered
something like this, but had initially avoided it, since I didn't want
to dynamically allocate (and reallocate) additional memory to keep
track of cookies. I also wasn't sure if this would be acceptable
performance-wise, and of course the allocation can fail in which case
you're back to square one. Although, I may be imagining a different
implementation than you. In fact, this line of thinking led me to the
approach proposed in the RFC which basically tries to
accurately/efficiently track everything that's already seen without
remembering all the cookies or allocating any additional buffers. This
might make a good alternative if the concerns I listed aren't a big
deal.

Thanks!

-Jordan

