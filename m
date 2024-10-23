Return-Path: <bpf+bounces-42936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A359AD304
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A4D28283F
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F481CF7DF;
	Wed, 23 Oct 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHIC+5zm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931F1B652C;
	Wed, 23 Oct 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705150; cv=none; b=WAfg+v2aqHbP+WmilQPJXw7Tx1xvg50anhgRoFKY3i8GdtaQwJbQfPs+6jEYHqMZgv/ST+WEPW9fjFoGUilmKPIoOQiU+zPdq4CwZ776AleU+0vd9yDGfn8sqsTkTU+FDJvosO6/+T3lu1Ttb8vPsdBRfA/HVurSS8GpU1RMmgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705150; c=relaxed/simple;
	bh=D09xnxmrSjdgS5FrT2I25115nOJgEcySe0O5Fg3OvQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBjcO9XsofRBjtryr3pSLtIPhveboWLe+wx7u+uUq0djgN6mBWMF/qkOfsiGerBv2w//RnVOAt69YTwfPRTm3ymKRUPCb6s+pq91zLs7hb8EP+C0j55gPmlBwrEhcQdTMPNJB4IUA0+nMHpx9eImgX9aFU+eYQ4hIfj3f2TLoMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHIC+5zm; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea9739647bso31882a12.0;
        Wed, 23 Oct 2024 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729705148; x=1730309948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RFNnnB+O0p0aRvheGlQAuqZY0fWkIb7EfMdt4bgYjU=;
        b=fHIC+5zmCtSFK5GilycIQX5Sh/Xol4e8rh5DPQBvRVwFp42bU8XiMLwGZEvrTC6753
         t7dPR2jypCS6eSeIchTno1TF/UZ0/qrQgbnpS04vh422f12HOU6stl9DqDqrdwniOSOB
         5FNIDJpwLkJmfRdnkyul7idmMg7WCSr9OG4MluCzSsHGkrcZ8S3XvitK1Pm1t0tKrTyi
         /tPi4sI/PKojr/rUYA+wY9fiYuBXU2b1QGzoVvS2p3oPU1SNu/u7hYnbXaID1Wyn2eX1
         4LWklzrD2k9fIypAdYzAt5hPSBHo9lwrLhkljxsesMcrH0tyhEeStwCM4mgBrG8AxU2/
         /SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705148; x=1730309948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RFNnnB+O0p0aRvheGlQAuqZY0fWkIb7EfMdt4bgYjU=;
        b=gsY4UoMLrk6sxqxhJlkMb+9sjQLB488Iy2Uv5RfVCUg11dnDidQ3Jr/Fc3eNQFCKvO
         /vDAf2oAh3ricdhWjG/hwLF0PuUir6VTCcjcLcBZsjD3v3EUZlladz2X5NVwwKVXTpCp
         VMgSJlMtyZdThebbrNn5cTDg22PuBLB/ZnjfWzJvA9f/CWiV/lyyjk1TYAlFWn5GWa9i
         GOAaNdsl2sZB+OCGRplm83DbfGJWQKR91/EirpauP1b5j3uh1swRea4WYLNdtm6vb9zd
         6Mn2n2VY1IvXYmjjQedMNrbhVcXB5d4GqCfP1cn6sLSHoaqJZtRbNvjdTdzERN04bCnD
         Lazg==
X-Forwarded-Encrypted: i=1; AJvYcCUJuIJor0+h/ZRrPCeNXkfBb1w5n/9kZzbeVPnYxEntOX+HtwwwyOW8Q4X85XLTGUw0J/B7t6AmQoQn9ileOG9z5g==@vger.kernel.org, AJvYcCVZWnkXaRaSLtZmwXf4VeC0fc0Ywe6NK5h14PK96d0OBdmE8j35Am8Ec260ORgMsA7prUonUeQG1kLOzJlB@vger.kernel.org, AJvYcCWBRAElr9Q2f3RxvpzezpokrG6QxkBn3oZiihWZNSmOWHIsy5QhPGo2Vu7/GUqn1cMoqgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2yIGElI5k8qsd9/627X33yogMRZI4FSk8FwUxG7qHHPglfZ3S
	BcLWL5lY31fO6DHw1yX2qO6rpYs2tHnuycodpiGGGr/uIBSbbg2JuxmpXP4rtpo8O1HoPopK5sY
	5D1QQNLOkU2q79h7mL4+XEW+nqq4=
X-Google-Smtp-Source: AGHT+IEi3chO4cJaxRAniC9KHshTFGfUXN96jvePl/7aNO37ofgEOlQMW+oad4DUIwtadK1f+w1v1UP4u0KBo3qeVKc=
X-Received: by 2002:a05:6a21:178a:b0:1d9:aa7:d6cc with SMTP id
 adf61e73a8af0-1d978b2da18mr4156793637.24.1729705146359; Wed, 23 Oct 2024
 10:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>
In-Reply-To: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 10:38:54 -0700
Message-ID: <CAEf4BzacLW14OmuW1nV4s=cMcSqcrSAO2Y_0XY3jT2efGNfmuw@mail.gmail.com>
Subject: Re: The state of uprobes work and logistics
To: Peter Ziljstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Liao Chang <liaochang1@huawei.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, 7 days has passed, let's see how we are doing here...

On Wed, Oct 16, 2024 at 12:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Hello,
>
> I wanted to provide a bit of a context about and tie together a few
> separate work streams (across a few separate kernel trees) all
> revolving around uprobe improvements, as there are a bunch of them and
> I'm sure it's hard to keep track of all of them. And hopefully I can
> also get Peter and ARM maintainer's input on some specific questions I
> asked below. Thank you in advance!
>
> In short, in the last few months there was a high activity around
> fixing and improving uprobes. All this is the result of increased and
> more varied use of uprobes/uretprobe in production settings. Uprobe
> performance is **very** important, and yes, we do have real use cases
> that go to millions per second uprobe/uretprobe triggering throughput,
> unfortunately. So any small bit of performance and scalability
> improvement is helpful. No, this isn't just some nerdy perf
> optimization work (I've been asked this a few times, so I thought I'd
> emphasize this again).
>
> So, we've already landed a bunch of work, mainly (not an exhaustive list)=
:
>
>   - various clean ups, API improvements, and bug fixes from Oleg
> Nesterov ([0], [1]). This simplified internal APIs and was a
> prerequisite of the rest of the work;
>   - changes to refcounting and RCU-ifying of uprobe lifetime from me
> ([2]). This improved single-threaded performance somewhat, but mainly
> significantly improved scalability in the presence of multiple CPUs
> triggering lots of uprobes;
>   - ARM64-specific optimization of uprobe emulation of NOP instruction
> by Liao Chang ([3]). This change alone gives 2x (!) speed up for a
> USDT tracing use cases *on ARM64* (we already have this optimization
> in x86-64);
>   - there was a bit earlier work by Jiri Olsa ([4]) to add uretprobe()
> syscall, giving +30% speed ups.
>
> And there are a few more outstanding changes:
>
>   - Jiri Olsa's uprobe "session" support ([5]). This is less
> performance focused, but important functionality by itself. But I'm
> calling this out here because the first two patches are pure uprobe
> internal changes, and I believe they should go into tip/perf/core to
> avoid conflicts with the rest of pending uprobe changes.
>
> Peter, do you mind applying those two and creating a stable tag for
> bpf-next to pull? We'll apply the rest of Jiri's series to
> bpf-next/master.

Jiri has reposted patches this time CC'ing Peter, heh :), it would be
great to apply those two patches and get a stable tag. This is
blocking the landing of uprobe sessions in bpf-next and also my
remaining patches will be based on top of Jiri's uprobe changes, most
probably. Peter, please take another look, thank you.

>
>   - Liao Chang's ARM64-specific STP instruction emulation support
> ([6]). This one will give 2x (!) improvement for a common case of
> having STP instruction being a first instruction in traced user
> function (similar to NOP for USDTs).
>
> ARM64 maintainers (cc'ed Catalin, Will, and Mark), can you guys please
> take another look? This one was a bit more controversial, but
> hopefully there is a way to massage it to be acceptable and not
> introduce unnecessary slowdowns (there were some concerns about memory
> ordering/visibility, which hopefully don't apply to uprobe cases).
> It's an important improvement, I'd really appreciate it if we can make
> progress here, thank you!
>

Ping. ARM64 folks, can you please take a look and reply? Thank you.

>   - my speculative VMA-to-uprobe lookup series ([7]). This makes entry
> uprobe scalability scale linearly with the number of CPUs (the
> ultimate goal of uprobe scalability work).
>
> I think it's ready to go in. It has **implicit** dependency on
> Christian Brauner's recent change for FMODE_BACKING, for which he
> provided a stable tag. Peter, do you have any remaining concerns or
> this can be also merged soon?

No changes, still ready to go in. Might need a rebase if Jiri's
patches are applied.

>
>   - another patch set of mine, switching uretprobe fast path to SRCU
> (with timeout) ([8]). This makes return uprobes (uretprobes) linearly
> scalable in the common case (again, the ultimate scalability goal).
>
> I haven't gotten much feedback here, would love to get some objective
> review here. This is an important counterpart to the speculative
> VMA-to-uprobe lookup series. Both are needed in practice.
>

The only thing that has progressed, thank you. I'll apply suggested
state changes, but I intend to postpone delayed_uprobe_lock rework to
a separate follow up patch set. Just a heads up.

>   - patch set dropping unnecessary siglock usage in uprobe by Liao
> Chang ([9]). This one removes yet another lock, for a less common case
> (at least on x86-64) of single-stepped uprobe (where the probed
> instruction can't be emulated).
>
> This one needs a rebase, but it was already acked by Oleg. Liao,
> please prioritize the rebase and send v4 ASAP, so this is not lost.
>

This was rebased and acked by Masami. Seems to be ready to be applied.

>
> As you can see, lots of stuff needs to be landed and most of it is in
> good shape already. I'd love to hear thoughts of relevant people
> called out above, thank you!
>
>
>   [0] https://lore.kernel.org/linux-trace-kernel/20240729134444.GA12293@r=
edhat.com/
>   [1] https://lore.kernel.org/linux-trace-kernel/20240929144201.GA9429@re=
dhat.com/
>   [2] https://lore.kernel.org/linux-trace-kernel/20240903174603.3554182-1=
-andrii@kernel.org/
>   [3] https://lore.kernel.org/linux-trace-kernel/20240909071114.1150053-1=
-liaochang1@huawei.com/
>   [4] https://lore.kernel.org/linux-trace-kernel/20240523121149.575616-1-=
jolsa@kernel.org/
>   [5] https://lore.kernel.org/bpf/20241015091050.3731669-1-jolsa@kernel.o=
rg/
>   [6] https://lore.kernel.org/linux-trace-kernel/20240910060407.1427716-1=
-liaochang1@huawei.com/
>   [7] https://lore.kernel.org/linux-trace-kernel/20241010205644.3831427-1=
-andrii@kernel.org/
>   [8] https://lore.kernel.org/linux-trace-kernel/20241008002556.2332835-1=
-andrii@kernel.org/
>   [9] https://lore.kernel.org/linux-trace-kernel/20240815014629.2685155-1=
-liaochang1@huawei.com/
>
> -- Andrii

