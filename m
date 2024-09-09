Return-Path: <bpf+bounces-39304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4259D971523
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 12:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC381C21BC0
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA9B1B3F1B;
	Mon,  9 Sep 2024 10:18:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11A176FDF;
	Mon,  9 Sep 2024 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877092; cv=none; b=V49j2ZYf/dfIiXrz1zrBO8rDs4AEkCraDY1KrWkbw3EK8Zzu5K/36H2xoky3A1dMRlL/rjJ0iEsKP+TfDQvTGRLENjM3WBFIbkLaummA0WOUmQAPSvwgsePfzRYBdJ1TorhQ2x1juOeQVDsTauEE/0A/NJDpxZXp8y100xIbwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877092; c=relaxed/simple;
	bh=2rZWOLEKKBjccInvTK0Y4YWoPsH6kyP74H/6EZNYrBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIfase93oLn1fb19woUUdYS6OirksGbOehnBTGavW5kZnEOcDkIWPcRBm5qEL0c1kipV6ikojMpOQ52+GQZz9migCa9kat/cAmXPEke7rBSyq5jh1MSuZvZqdjgr39SFcaLZo8FzrY6dFuC8Iotr/zDpiAAW52ogSQS4MM6+lTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2748FEC;
	Mon,  9 Sep 2024 03:18:37 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCFE03F66E;
	Mon,  9 Sep 2024 03:18:06 -0700 (PDT)
Date: Mon, 9 Sep 2024 11:18:01 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "Liao, Chang" <liaochang1@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, mhiramat@kernel.org, oleg@redhat.com,
	peterz@infradead.org, puranjay@kernel.org, ast@kernel.org,
	andrii@kernel.org, xukuohai@huawei.com, revest@chromium.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] arm64: insn: Simulate nop and push instruction for
 better uprobe performance
Message-ID: <Zt7LWaoZ0PTFqVLF@J2N7QTR9R3>
References: <20240814080356.2639544-1-liaochang1@huawei.com>
 <Zr3RN4zxF5XPgjEB@J2N7QTR9R3>
 <f95fc55b-2f17-7333-2eae-52caae46f8b2@huawei.com>
 <8cc13794-30a7-a30b-2ac9-4d151499d184@huawei.com>
 <ZtrN4eWwrSWTMGmD@J2N7QTR9R3>
 <CAEf4BzYn3EkVVk4dnWMBMKa16y_ZFvQp3ZcdM44a2LeS08S6FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYn3EkVVk4dnWMBMKa16y_ZFvQp3ZcdM44a2LeS08S6FQ@mail.gmail.com>

On Fri, Sep 06, 2024 at 10:46:00AM -0700, Andrii Nakryiko wrote:
> On Fri, Sep 6, 2024 at 2:39 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Aug 27, 2024 at 07:33:55PM +0800, Liao, Chang wrote:
> > > Hi, Mark
> > >
> > > Would you like to discuss this patch further, or do you still believe emulating
> > > STP to push FP/LR into the stack in kernel is not a good idea?
> >
> > I'm happy with the NOP emulation in principle, so please send a new
> > version with *just* the NOP emulation, and I can review that.
> 
> Let's definitely start with that, this is important for faster USDT tracing.
> 
> > Regarding STP emulation, I stand by my earlier comments, and in addition
> > to those comments, AFAICT it's currently unsafe to use any uaccess
> > routine in the uprobe BRK handler anyway, so that's moot. The uprobe BRK
> > handler runs with preemption disabled and IRQs (and all other maskable
> > exceptions) masked, and faults cannot be handled. IIUC
> > CONFIG_DEBUG_ATOMIC_SLEEP should scream about that.
> 
> This part I don't really get, and this might be some very
> ARM64-specific issue, so I'm sorry ahead of time.
> 
> But in general, at the lowest level uprobes work in two logical steps.
> First, there is a breakpoint that user space hits, kernel gets
> control, and if VMA which hit breakpoint might contain uprobe, kernel
> sets TIF_UPROBE thread flag and exits. This is the only part that's in
> hard IRQ context. See uprobe_notify_resume() and comments around it.
> 
> Then uprobe infrastructure gets called in user context on the way back
> to user space. This is where we confirm that this is uprobe/uretprobe
> hit, and, if supported, perform instruction emulation.
> 
> So I'm wondering if your above comment refers to instruction emulation
> within the first part of uprobe handling? If yes, then, no, that's not
> where emulation will happen.

You're right -- I had misunderstood that the emulation happened during
handling of the breakpoint, rather than on the return-to-userspace path.
Looking at the arm64 entry code, the way uprobe_notify_resume() is
plumbed in is safe as it happens after we've re-enabled preemption and
unmasked other exceptions.

Sorry about that.

For the moment I'd still prefer to get the NOP case out of the way
first, so I'll review the NOP-only patch shortly.

Mark.

