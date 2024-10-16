Return-Path: <bpf+bounces-42230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E3C9A12B3
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 21:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29D01F23E78
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82044215F5B;
	Wed, 16 Oct 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLtq5enn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E92144D6;
	Wed, 16 Oct 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107336; cv=none; b=JesjPsRE5y4JoJk0j1WjzMJ0Vs5rNncZni3wzIQMI2GOy1ZvpldCjDx4GDg08QUPkMA+n3a0TikqUqML0JCmUzeFpXc6kBhmZ9dW7LUFlbRjm9dohRoQnQuspIDGNALeoePgksLKnZU3yZwyKrxcnnyo5X0EcKDoYAkMHNUYtQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107336; c=relaxed/simple;
	bh=NNrE3qOWb+EtP1SO1axezSvQxQFBxRZOewvdPogIiNY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cgOfup+EwBPQmnRArmfTfZKjWE/D3N5HOwWvaUKRxLv3Td7Z10J0++qacDPc1H2aIO2iI7Rnn7yt7cqx/gJzZ92zUdp99iz7s3nu7jnmJmQC6O9ofDLDy5OP69vna/Xp5aGyx0wWPRQXo9WCCj6OokbF0KX/HvZXzqrPQ2eDdBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLtq5enn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e5130832aso118005b3a.0;
        Wed, 16 Oct 2024 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729107334; x=1729712134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=COadM9mdsklFEqY/AYc1kTUqOtiuxLFYkQWjQblcUb8=;
        b=HLtq5enn+P7wkznoglSsUZSekjpbt17gufFZdVQ9s7qT+aXeQZ3MeSr8xY+yTLEZpX
         U4wzUYwV8oeqqGa9TjiKAaxQUuliyTYY1bu/V41jvEm04a3AbsRYtzvpwMbUeC3W54bB
         ABY71juL3H1fFfN9C5IY80DJOZOtCwhQ+NT+1l324/acgP++8PWTfAHNAVo4rpsz95WX
         S/vI5wmwV0o05dWku3EBC6JxMihyAxwErdGuz5vQavXVEUDDK+0kUX7AXYIeGxxSFyal
         V4SatUVc5zQTmD1ORstit0X08/BSVLYO6tvzBprMP6TbYEwnyGI5prBIGHxy9b6UU7LR
         pvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729107334; x=1729712134;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COadM9mdsklFEqY/AYc1kTUqOtiuxLFYkQWjQblcUb8=;
        b=V9jU8WqZTakG7hEKTio8q5LfTthTExlMq7HPlg5g0oVhsYzE9l2PEuCrF8vM41zuh/
         JaMjffM3E3nvM7lTkLt3zupb23FZCjDYHF1aUEMa5RLVzUNEHzEN8PgCnFqcFAC10sYU
         iJw/43cvQsl7W7ZhqlIH/dS3384yzL9fHOFwrHv/0PABE9Waw6WX5pkDJOi04pBRhMjU
         6bNGDvQZl6n/0Ioln/2eAQIHjl+vZwTZyPFKViUA4W0YC4n9HnIK4e/8u2wSn2R95QvQ
         vpl+LpYLW4GAgX7P+WsUftnbqXY+pzOEsq+18uWtjNBSRTmUD3/8vqVABY4gB70uqnKA
         UJQw==
X-Forwarded-Encrypted: i=1; AJvYcCUM7/p+rcfmCEQ46Fm3+SUs82OKzvl7QPqwuyhftNOHW5qAQrqGy3WK9STPzDh5hraohTbJwwKiOAt6ES3eilrd6g==@vger.kernel.org, AJvYcCWztfmMYTj6nYdXME8svb730k3z1m2g8UDoZuo/CkPJcIqyyk8HgWoFLXoTv383pcwKrwo=@vger.kernel.org, AJvYcCXu5QuclPf2rw/n3Y94GVw0xQWLEwhq6LRbO2GTVflsCQFRNW4xYhxK/+T/kq1xlBac8RO/mbeLhuwObA3t@vger.kernel.org
X-Gm-Message-State: AOJu0YyLig/mAq3CLW6/k1PxdMaCGvKzFmatimIF9GLvDM/078TSv+6E
	OoKekkkGEXHJIezZof0bvpS5dXfyICfAY+kI0FeJxnpf40huLAb07S2BPIr9DrpHU4y3G0kcJGM
	JLhpbMG1M5kIc9UZkWPguf1Ohv8k=
X-Google-Smtp-Source: AGHT+IFoR2J8QArYG4GdvA2ZTWym2yAF0bf4yapmxEQIyk6yGf8CBIPNs9eBCYoDoGXIUYd1KvkSmPfdgVyJgfl2iMU=
X-Received: by 2002:a05:6a00:2e11:b0:71e:6ed:9108 with SMTP id
 d2e1a72fcca58-71e4c13db67mr24548702b3a.2.1729107333688; Wed, 16 Oct 2024
 12:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Oct 2024 12:35:21 -0700
Message-ID: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>
Subject: The state of uprobes work and logistics
To: Peter Ziljstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Liao Chang <liaochang1@huawei.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I wanted to provide a bit of a context about and tie together a few
separate work streams (across a few separate kernel trees) all
revolving around uprobe improvements, as there are a bunch of them and
I'm sure it's hard to keep track of all of them. And hopefully I can
also get Peter and ARM maintainer's input on some specific questions I
asked below. Thank you in advance!

In short, in the last few months there was a high activity around
fixing and improving uprobes. All this is the result of increased and
more varied use of uprobes/uretprobe in production settings. Uprobe
performance is **very** important, and yes, we do have real use cases
that go to millions per second uprobe/uretprobe triggering throughput,
unfortunately. So any small bit of performance and scalability
improvement is helpful. No, this isn't just some nerdy perf
optimization work (I've been asked this a few times, so I thought I'd
emphasize this again).

So, we've already landed a bunch of work, mainly (not an exhaustive list):

  - various clean ups, API improvements, and bug fixes from Oleg
Nesterov ([0], [1]). This simplified internal APIs and was a
prerequisite of the rest of the work;
  - changes to refcounting and RCU-ifying of uprobe lifetime from me
([2]). This improved single-threaded performance somewhat, but mainly
significantly improved scalability in the presence of multiple CPUs
triggering lots of uprobes;
  - ARM64-specific optimization of uprobe emulation of NOP instruction
by Liao Chang ([3]). This change alone gives 2x (!) speed up for a
USDT tracing use cases *on ARM64* (we already have this optimization
in x86-64);
  - there was a bit earlier work by Jiri Olsa ([4]) to add uretprobe()
syscall, giving +30% speed ups.

And there are a few more outstanding changes:

  - Jiri Olsa's uprobe "session" support ([5]). This is less
performance focused, but important functionality by itself. But I'm
calling this out here because the first two patches are pure uprobe
internal changes, and I believe they should go into tip/perf/core to
avoid conflicts with the rest of pending uprobe changes.

Peter, do you mind applying those two and creating a stable tag for
bpf-next to pull? We'll apply the rest of Jiri's series to
bpf-next/master.

  - Liao Chang's ARM64-specific STP instruction emulation support
([6]). This one will give 2x (!) improvement for a common case of
having STP instruction being a first instruction in traced user
function (similar to NOP for USDTs).

ARM64 maintainers (cc'ed Catalin, Will, and Mark), can you guys please
take another look? This one was a bit more controversial, but
hopefully there is a way to massage it to be acceptable and not
introduce unnecessary slowdowns (there were some concerns about memory
ordering/visibility, which hopefully don't apply to uprobe cases).
It's an important improvement, I'd really appreciate it if we can make
progress here, thank you!

  - my speculative VMA-to-uprobe lookup series ([7]). This makes entry
uprobe scalability scale linearly with the number of CPUs (the
ultimate goal of uprobe scalability work).

I think it's ready to go in. It has **implicit** dependency on
Christian Brauner's recent change for FMODE_BACKING, for which he
provided a stable tag. Peter, do you have any remaining concerns or
this can be also merged soon?

  - another patch set of mine, switching uretprobe fast path to SRCU
(with timeout) ([8]). This makes return uprobes (uretprobes) linearly
scalable in the common case (again, the ultimate scalability goal).

I haven't gotten much feedback here, would love to get some objective
review here. This is an important counterpart to the speculative
VMA-to-uprobe lookup series. Both are needed in practice.

  - patch set dropping unnecessary siglock usage in uprobe by Liao
Chang ([9]). This one removes yet another lock, for a less common case
(at least on x86-64) of single-stepped uprobe (where the probed
instruction can't be emulated).

This one needs a rebase, but it was already acked by Oleg. Liao,
please prioritize the rebase and send v4 ASAP, so this is not lost.


As you can see, lots of stuff needs to be landed and most of it is in
good shape already. I'd love to hear thoughts of relevant people
called out above, thank you!


  [0] https://lore.kernel.org/linux-trace-kernel/20240729134444.GA12293@redhat.com/
  [1] https://lore.kernel.org/linux-trace-kernel/20240929144201.GA9429@redhat.com/
  [2] https://lore.kernel.org/linux-trace-kernel/20240903174603.3554182-1-andrii@kernel.org/
  [3] https://lore.kernel.org/linux-trace-kernel/20240909071114.1150053-1-liaochang1@huawei.com/
  [4] https://lore.kernel.org/linux-trace-kernel/20240523121149.575616-1-jolsa@kernel.org/
  [5] https://lore.kernel.org/bpf/20241015091050.3731669-1-jolsa@kernel.org/
  [6] https://lore.kernel.org/linux-trace-kernel/20240910060407.1427716-1-liaochang1@huawei.com/
  [7] https://lore.kernel.org/linux-trace-kernel/20241010205644.3831427-1-andrii@kernel.org/
  [8] https://lore.kernel.org/linux-trace-kernel/20241008002556.2332835-1-andrii@kernel.org/
  [9] https://lore.kernel.org/linux-trace-kernel/20240815014629.2685155-1-liaochang1@huawei.com/

-- Andrii

