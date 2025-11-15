Return-Path: <bpf+bounces-74653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A3BC60BD5
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 22:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9B27352521
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 21:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF64B227EA7;
	Sat, 15 Nov 2025 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="afic3ffD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235C191F84
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763243567; cv=none; b=teui6Wt3FH2N7uIn7s9NnL37bFLoFWns/a3tmWEbhd6l3xvw9fiH+3TEy11ppFhTU7iRTKdtNu24TOvKBN+lJDbxCbksVnltGIHGPrS7s59JInVAbMyoSdTWWtTXCCQ8IJd1yJtflE957ZcziQYvLGLnPtvUAVn9Vutw7cjzBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763243567; c=relaxed/simple;
	bh=mIluQKuI9QcHTuY1pKp+97R5QZSbOJGJbV30Svb1Nrg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hHmCG4dnXSBJ6ohNlZzcqdmv3QPkO/6JGSajx6BdyBvDL5ctvuPpUWe4zGCbOQ+Dg/g+rG7IfGqIPYK+lqP2UNJ7rjA6j3J8aNOVGtaooE53pwscmqvoAm5ipl9IL55wAOtq54vYW8XWLgmKjNahJN/PSfbrUdstCdFBAy8118Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=afic3ffD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3434700be69so4033707a91.1
        for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 13:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1763243563; x=1763848363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ybTPG0YSbnfeX+Q1nV82KfmrVATnCbE8ejANDtaXn4=;
        b=afic3ffDq1kjIdztmbtatNYdfb2dcnVMKKANByOwQT+Rr6QRuSXu5uqIcezRnfrgq7
         fJej/sFa40AWuHQe/E/SBBJS/cx+0Sl7ESa3p6QZ534kz2adBEr2CrT/54xgOUl5758k
         G6W/leTXfij+K5s3WUL1CIxnU18xXwhhyXUFqzDRGLtURZE9dOzmjkKClJ2rEf2x9Xdv
         4orfIvMPgn6nkgGxe4I9lJf6wreM6c4QN72/NILJ2TR8GrdycF2PgKaUncs8pKKcUgDX
         moIzvL7zqoS8y1xj7+SSp8uH9kbzoA9eLKt/Imn3f4GBlAIvmJfsJx6rj1kmrzJhbAOh
         B34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763243563; x=1763848363;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ybTPG0YSbnfeX+Q1nV82KfmrVATnCbE8ejANDtaXn4=;
        b=KvzcEBIf5GJyp/mUrfTjuTQJTTuJ91xtTEEn372iDRyKIPe+J4VnKVoyUitxoGVloL
         7tx1M5MOOAxVDDMXUVZU+kDMtlx59tmSRb/yrjUg2n9xYEWI09twvLZZL4FIpBXnW7Fw
         WJy35wopmPxZ1OInSoQ2RpWSOiItZ1PiN3pk9zvy4zDSkN+iEj0KoHT8P66umjv0FevR
         c3FbcYy3RQ9Lj/GMapCDGqDMEV+dWVPlFmShQ9BZKfSkzdreL2YUsgN0JKH/Xk0oxnrJ
         a2Zfa4qixMeZ+RbufxA+pupVHEZBz0+uE6Aru64ngoThDQc+/iTWQrFHM6AOLyLfHFLX
         PVvw==
X-Forwarded-Encrypted: i=1; AJvYcCVE8IyJ3Em8KWDKaXYRNZEylpC1H2oh/0SX/HlNN9YxGaA5wxjfnKfRL5GX7wqi6zhcoks=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4NwctYFb/iWbTjMVZpeU7n0NAuDBPN7LjTCYkSn9dhxiU4V1
	NBOp3NtG4MXjU6a7gj4Ji/4uSOVo2GEC4CBuakyf9qgpm7Mn9aYpLbLkbfbYVUkjBJ0zRHlE2Kx
	25k1PJeMpNo4fmRT7hn+nMJ6yRDtd/TEO7XrCOuOd/g==
X-Gm-Gg: ASbGncvgXGcH8gHxXCUQPfZ584yi8bbreV+H0VHd+Lb/ewwZ7vBDphHNmCwamrU7VfB
	xyj7mR1XLBEx3GmxLr66be18Gi4Y1o3q8Xa/6zPz9CVG+5Bu1QkoxTHlylFqMAJNTrU79WT4Z/+
	Rn48QcbQd1r0nbF0yKvbscRL4fyDWS0nezqstvF9sBkyTwVMqlGpt+I3rXZehFUTe0RHuAAImqt
	VEH8ApPqPGm99Sd4Au7FxwNxemO5vA3bJarCwLh+QnrWmH1SsLgoXQkaGzn4NL1RFDfluD5siBT
	oP/GEPQ=
X-Google-Smtp-Source: AGHT+IFM+n/cOR0LYoeT0ZeiDvqbj2J/FKDatVXBc9sPfqgJ9maBm5eMJM+Et+TzLWwaBQYEprj8eZ9t3ao9zfKi0wM=
X-Received: by 2002:a17:90b:2b8b:b0:339:ec9c:b275 with SMTP id
 98e67ed59e1d1-343f9d921b5mr8655720a91.6.1763243562879; Sat, 15 Nov 2025
 13:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Sat, 15 Nov 2025 22:52:31 +0100
X-Gm-Features: AWmQ_bnS84oHfc3XBRbc8xiSsI-OwJ2jK0SpBarcYbyxzdewnq9GL5SVcrolgsI
Message-ID: <CAH6OuBTjG+N=+GGwcpOUbeDN563oz4iVcU3rbse68egp9wj9_A@mail.gmail.com>
Subject: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	andrii.nakryiko@gmail.com, olsajiri@gmail.com, bpf <bpf@vger.kernel.org>
Cc: Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We're developing an eBPF-based sampling CPU profiler, and we've been
investigating a bug that causes periodic, brief system freezes on
Fedora 43. We've tracked this down to commit a650d38 ("bpf: Convert
ringbuf map to rqspinlock") [1], which was introduced to fix a
deadlock reported by syzbot [2].

We've reduced the repro to the following eBPF code:

struct {
    __uint(type, BPF_MAP_TYPE_RINGBUF);
    __uint(max_entries, 512 * 1024 * 1024);
} ringBuffer SEC(".maps");

SEC("tp_btf/sched_switch")
int cswitch(struct bpf_raw_tracepoint_args* inContext)
{
    struct CSwitchEvent* event = bpf_ringbuf_reserve(&ringBuffer,
sizeof(struct CSwitchEvent), 0);
    if (event == NULL)
        return 1;

    bpf_ringbuf_submit(event, 0);
    return 0;
}

SEC("perf_event")
int sample(struct bpf_perf_event_data* inContext)
{
    struct SampleEvent* event = bpf_ringbuf_reserve(&ringBuffer,
sizeof(struct SampleEvent), 0);
    if (event == NULL)
        return 1;

    bpf_ringbuf_submit(event, 0);
    return 0;
}

We have two tracepoints: one attached to sched_switch to collect
context switch events (to record off-cpu time), and one attached to
perf_event to collect sample events (to record on-cpu time). They do
nothing but reserve some space in a ringbuf map and submit. The sample
tracepoint is configured in user space (via perf) to sample at a
relatively high frequency (8 kHz). Running this eBPF program on a
kernel that contains the mentioned commit (kernel 6.15 or newer) will
result in system freezes. The freezes have been measured to be 250ms+.

The freeze is caused by the perf sample NMI happening while the
cswitch program is running, which can lead to a recursive lock. The
sequence of events that leads to the recursive lock (and thus freeze)
is as follows:

1) The cswitch tracepoint runs
2) The cswitch tracepoint calls bpf_ringbuf_reserve()
3) bpf_ringbuf_reserve() enters the spinlock via raw_res_spin_lock_irqsave()
4) While the cswitch tracepoint is in the spinlock, a sample NMI
happens on the same CPU. This interrupts the cswitch tracepoint with
the spinlock still held.
5) The sample tracepoint runs
6) The sample tracepoint also calls bpf_ringbuf_reserve(), which
attempts to acquire the spinlock too
7) => recursive lock

Looking at raw_res_spin_lock_irqsave(), in this situation, it will
enter the contended path in resilient_queued_spin_lock_slowpath()
since the cswitch tracepoint is holding the lock. Under contention,
the rqspinlock slow path will wait for a maximum amount of time for
the current owner of the lock to release the lock. For example:

/*
 * We're pending, wait for the owner to go away.
 */
if (val & _Q_LOCKED_MASK) {
    RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
    res_smp_cond_load_acquire(&lock->locked, !VAL ||
RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
}

Note, in particular, RES_DEF_TIMEOUT, which is defined as NSEC_PER_SEC
/ 4, which perfectly matches the 250ms+ freezes we're seeing. In this
situation, the owner of the lock will never release due to the
recursive lock, so the perf interrupt waits for the full 250ms. It
then fails to acquire the lock, which causes the bpf_ringbuf_reserve()
to fail, which eventually allows the cswitch tracepoint to continue
running, which unfreezes the system.

While the system freeze is most likely specific to the interaction
between sched_switch and the perf sample NMI in this case, the general
issue is that having a perf_event tracepoint that triggers on the
sampling NMI can run into this recursive lock if there is *any* other
tracepoint that makes use of the same ringbuf. Even without the
freeze, having perf NMIs take 250ms+ is probably not great.

I'm not sure what the best fix is, however. Prior to a650d38,
bpf_ringbuf_reserve() acquired the spinlock like so:

if (in_nmi()) {
    if (!raw_spin_trylock_irqsave(&rb->spinlock, flags))
        return NULL;
} else {
    raw_spin_lock_irqsave(&rb->spinlock, flags);
}

So there used to be special case handling for the NMI context, though
I'm not sure if that was there for this exact situation. Furthermore,
from [2], the switch to rqspinlock was made to fix *another* recursive
lock situation. Just switching back to the previous code would regress
that fix.

One option could be to add a similar trylock() version of rqspinlock,
and then add the in_nmi() check in  bpf_ringbuf_reserve() back, though
I'm not sure how feasible that is. It could essentially be the same as
the current raw_res_spin_lock_irqsave(), except with a 0 timeout (i.e.
return immediately).

It's worth noting that while a650d38 indeed fixes the deadlock
reported by syzbot, it does mean that in situations that would
previously deadlock, you'll now always hit a 250ms stall instead.
That's better than deadlocking entirely, but it does feel wasteful.

We've worked around this on our side by guarding against recursion in
our tracepoints (i.e., ensuring the sample tracepoint can never run at
the same time as another tracepoint on the same CPU), so this is not a
blocker for us anymore. But it was very hard to track this issue down,
and the cause is quite surprising, so it would be good to see this
fixed properly for future users.

Any thoughts would be appreciated!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a650d38915c194b87616a0747a339b20958d17db
[2] https://lore.kernel.org/all/0000000000004aa700061379547e@google.com/

Cheers,
Ritesh

