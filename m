Return-Path: <bpf+bounces-75748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC50C934AA
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 937A84E17B0
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B37A2EA177;
	Fri, 28 Nov 2025 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmxK0Qow"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206572DC348
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372311; cv=none; b=AVg1kVzZTfBA6ptXLItmhiMeALkQSTUgUIwMqyBrGA1YhvsR8K00M+zoP6O2laWZ/wixvS/E+sD8q3DmZvSbe+x1+5AZeuNK/Wi4efnLyWgpUVEZkWce+mTDYSgX3HB9nuLuToyDJ8CCXxvqGbJoLfwxoOhWcW9XZD8zLax/vNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372311; c=relaxed/simple;
	bh=V6IGT2D79HJuNztQLm7Fh9vM0R2kykJsTeyidD8Jqdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvZ3cTAURl/hwRDpszdDCvaNGFxeWj9U/xMD0Ow9k6Cy2XOpEa9pQttmoOQsM9khdqbiwHjR3B/NyA305NWqC+VR+0S7clV1cqtGE2IzhflSzwic5HNjNytq0SIfmC7o5rrCAkDB3BH/oG7MgOQHeZJ2P7YcHw2WBFhaf3jHaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmxK0Qow; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42b3108f41fso1496436f8f.3
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764372308; x=1764977108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cJrkyB95D+qvaPknI/YBCWyPAeYVlnueBga5Src5qpY=;
        b=CmxK0QowEpjdFHxBGVZm0hK6XUgROGAXt4W4mHT1BRGsGbpVEot4XLzLev5XlxKsNj
         Xpkc6wspz9/snwtMVX7qNcpW+4cOOArFT+jiUfzDz8pbch8ZbWp0r71AUGbpjVgJYk/T
         SjsSD76uGKAn/xlqcoXLkRxRm+zuxW1AWQ+HbrxyhtgsJsVFFZsiQt8Z+fjlIEryAiUj
         2k+GmLPLnCFCMQfM3m9B5oySjSIJbANmSzESYrupWTUY/+WY0UFlMagBk6wDEH62OXRj
         LkvrIK9A/2/7sS7V8e+ngBqDhHF14UYrN8djkzeOs8/aDlnWQ4iKD8rqyw1M543JZvRM
         6z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764372308; x=1764977108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJrkyB95D+qvaPknI/YBCWyPAeYVlnueBga5Src5qpY=;
        b=QrYpQ9/C7MR4e6mNQTKZv7W1EmCTQgXqcgi+p4hopMnkrs2r3W1wtdV4fD8d3s65RY
         i9CH/qft+nhN7T0WLg1HnPu63dqYJ9Zo9wKCzIKXUC4Ai82TRLOg7lKzfnvAmrex6yNO
         7KO+go0aT3n29eK9187zIush55cs3sTgP5L51LHehAbRZ6w2DkkSXQoetEylsPFME3xP
         JButHmqCLLWPuHr3cHr+EiglVUEA9bi3ibSIPtgGhHVTlGe8YyE7fW0NZM0+4MdXGgOG
         xjQp0d3mxfYRt4rIKh6uc9zEbnFS8/9HcegP26Hj3R0E79RcwGfXtzJupXex+i8eT/E3
         uHWQ==
X-Gm-Message-State: AOJu0YwWr8tCdQnDU4k115BP1yFU/f0bch/1iv6UblcUI33zY60HNa8x
	jERxiOeDXHUI9QZimax4wylybCsVlmIIUlFnMH9VY+zjCZI6AbfeJw0Rp/jLOPXNBbCB8ilwyv5
	OY/paNQeZy3Oadfw3AVLyiOUbbrhdbFHxVVyR
X-Gm-Gg: ASbGncvCkxl9FAcPlcitDpHxWRV1FLsY+Hml4zskT29Mq+GvlIxEdxqVLr3qhRhoEEs
	UgAgtlCLw9JNz7Ckb2JNld7kwRGX0BmznlBuc0jkYPJjUqMQtJsgOg8sIHiSKKBHQgzt3xoJ6TP
	D7B6QeCOjL/Q2CZUw2d2uWoo3nRQ5vOBN5TWUR4sgXC/zpvIz7BzRzVCtIhf/i8sGhOAvHYjlFe
	4GCUVfmNuaSMUC8RAVZeh/UNbJ/lNuFzsUVIvEPsHOfJmhvUVzd0JaEf5JBeZ/9+W5T9h/CTln1
	Kj+5yZCLczyTqtj/FCl+24M/8oxz
X-Google-Smtp-Source: AGHT+IGSWgjLfyyoBPKnvBZ4cYA+AXi9JdMHEu97/oZ+5CNm5cX1VXo8cORmp10VEg9WGjk6V/n+DyQKFcVtQLTqGAY=
X-Received: by 2002:a05:6000:4022:b0:42b:3c8d:1932 with SMTP id
 ffacd0b85a97d-42cc1cbd74bmr30118288f8f.23.1764372307878; Fri, 28 Nov 2025
 15:25:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128231543.890923-1-memxor@gmail.com> <20251128231543.890923-6-memxor@gmail.com>
In-Reply-To: <20251128231543.890923-6-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 29 Nov 2025 00:24:31 +0100
X-Gm-Features: AWmQ_bmkH2Vy8iaayPng8vIumg87mU-LeETVtqgjy16pshJMU2sZ4Lt8YUmwEOw
Message-ID: <CAP01T7667znOM0DB3tv01QA1wFMiqW4PRN6foUGo3hvoDhbtJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/6] rqspinlock: Precede non-head waiter
 queueing with AA check
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>, 
	Jelle van der Beek <jelle@superluminal.eu>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 29 Nov 2025 at 00:15, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> While previous commits sufficiently address the deadlocks, there are
> still scenarios where queueing of waiters in NMIs can exacerbate the
> possibility of timeouts.
>
> Consider the case below:
>
> CPU 0
> <NMI>
> res_spin_lock(A) -> becomes non-head waiter
> </NMI>
> lock owner in CS or pending waiter spinning
>
> CPU 1
> res_spin_lock(A) -> head waiter spinning on owner/pending bits
>
> In such a scenario, the non-head waiter in NMI on CPU 0 will not poll
> for deadlocks or timeout since it will simply queue behind previous
> waiter (head on CPU 1), and also not enter the trylock fallback since
> no rqspinlock queue waiter is active on CPU 0. In such a scenario, the
> transaction initiated by the head waiter on CPU 1 will timeout,
> signalling the NMI and ending the cyclic dependency, but it will cost
> 250 ms of time.
>
> Instead, the NMI on CPU 0 could simply check for the presence of an AA
> deadlock and only proceed with queueing on success. Add such a check
> right before any form of queueing is initiated.
>
> The reason the AA deadlock check is not used in conjunction with
> in_nmi() is that a similar case could occur due to a reentrant path
> in the owner's critical section, and unconditionally checking for AA
> before entering the queueing path avoids expensive timeouts. Non-NMI
> reentrancy only happens at controlled points in the slow path (with
> specific tracepoints which do not impede the forward progress of a
> waiter loop), or in the owner CS, while NMIs can land anywhere.
>
> While this check is only needed for non-head waiter queueing, checking
> whether we are head or not is racy without xchg_tail, and after that
> point, we are already queued, hence for simplicity we must invoke the
> check unconditionally.
>
> Note that a more contrived case could still be constructed by using two
> locks, and interrupting the progress of the respective owners by
> non-head waiters of the other lock, in an ABBA fashion, which would
> still not be covered by the current set of checks and conditions. It
> would still lead to a timeout though, and not a deadlock. An ABBA check
> cannot happen optimistically before the queueing, since it can be racy,
> and needs to be happen continuously during the waiting period, which
> would then require an unlinking step for queued NMI/reentrant waiters.
> This is beyond the scope of this patch.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/rqspinlock.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index e35b06fcf9ee..7d0a3fe96165 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -437,6 +437,17 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
>          * queuing.
>          */
>  queue:
> +       /*
> +        * Do not queue if we're a waiter and someone is attempting this lock on
> +        * the same CPU. In case of NMIs, this prevents long timeouts where we
> +        * interrupt the pending waiter, and the owner, that will eventually
> +        * signal the head of our queue, both of which are logically but not
> +        * physically part of the queue, hence outside the scope of the idx > 0
> +        * check above for the trylock fallback.
> +        */
> +       if (check_deadlock_AA(lock))
> +               return -EDEADLK;

Sigh... I forgot to regenerate patches after rolling in the hunk to fix this.
It should be:
ret = -EDEADLK;
goto err_release_entry;

Resending.


> +
>         lockevent_inc(lock_slowpath);
>         /* Deadlock detection entry already held after failing fast path. */
>         node = this_cpu_ptr(&rqnodes[0].mcs);
> --
> 2.51.0
>

