Return-Path: <bpf+bounces-37284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C9D9538C0
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 19:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA817B23FE2
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944651BB6BC;
	Thu, 15 Aug 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFjMALsa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E71BB698;
	Thu, 15 Aug 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741637; cv=none; b=PkO8MZCuzfcVtR0BOvatJ/aqEmjpMk731KshiYqI/bzHl4s8e50cQcNhiRfDJpFIO+YPCUWWTxpML2qPCPrqCUt9KU4p6nCThIIcqJw86QIfeKAKMvTSv/sEktTHKgBO58y7mSp0yX1itx8OhG9QzEf4Idwk/lfQyhrOeBk0RIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741637; c=relaxed/simple;
	bh=ezoUPV9NtiZJSTV6zls7zJ7zcj268aTx3CmYfyW3TL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1kjNZoFLTBqK43bMGvM8Ezor6JEV5Jk7p5ULWxE0voBURou/IbPAosN9GFntZzsKKYNX0eC+2HiD2RUntJg8kOYfnaia7UCcCxkPvRnDeWEYpUrGvnqc0/uKmJYT/ma4IZ4KSeWRBrHtcVMniKC1+7wdSA/olZ3j9LqkXdvsDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFjMALsa; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so938680b3a.2;
        Thu, 15 Aug 2024 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723741635; x=1724346435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezoUPV9NtiZJSTV6zls7zJ7zcj268aTx3CmYfyW3TL8=;
        b=kFjMALsa3urV4H+2rZ2tKhgvwzTzy3j+gYkSeee2EtQSSfOyXhnVM0EGVAiJcyUySo
         bTIvHXilNnhxLtXd11tKnjKLF5mMhRHK5IA/4nqR6/rbHMMK+xjKt87Ous9aQXS4UTUv
         rPDvsNJFMM1RQgGoKtywhQl4YAqk3g1YxOwlMgh2x87dXejz49a9yV6KA5mnsYyIaqR/
         Eu6vXlWEULzc40OGvucM/MhOTpn4iOOSVX4x0E0mBkTEDoCkHMICjIANcYQfs9DdXUAg
         Zxgzrt3J+8dzW+l1dZjVsB1lqVvCE93ogT+YTdsdcinF4AlM/cr0rjNiBKJUFQ/dcPzK
         Nt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723741635; x=1724346435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezoUPV9NtiZJSTV6zls7zJ7zcj268aTx3CmYfyW3TL8=;
        b=aYAuBhaifLY7Lbqpj6C34h2lAvlmo72Syav32qru6iC/RLiyk//hL5O8JXDORxtBEt
         up0glNEZmrm/yoiUZzeYbXVAaQkuCZ+5dT/NejINL5hjJ8HOTuCF7aQ05H7jjwSvKzR2
         R3Eu36HZepnIbUj0NjOVrpKD/I2Dh3aa+DyWZDdIebMH918wYuUMBJesyy7kiBYMBbbI
         JuOLvDN5kD5sus3EGgObYuqhuAqUud6eBGJSaojbD8Z3k8unvfNPWRic4z9zJ7x2nFj4
         Oc4qAuWTK1l2NNlz68QI1MDejTV4Fwuwp4Hl/8ZK5H1JB2zVl91hH5C61FjJSKdkOmEX
         yKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB1iqaXylN9X7TQ/qVlFQ+vp0KWd1Vsx6uXNpDYFAo4QvYluAGLhBIN5kvDJVElSQde0yzaHx93/C0ucnwCrOOjY6YlEB2hZcut6hsOkz4iWGnlMAMldWi1/LG//dpyTNUh03oyJ78o5FZ5d+bpeWq6g2/cpi8tQF81Bh2weOW+QTbo4ie
X-Gm-Message-State: AOJu0YyZMfiDEOaUPvlWjGz/6LTGWd50/yin0zA5tjJMn9DSUAupSubK
	Hyj0D9O6GDXm94+OA1mmGnGOw3GPoaNejSa3rerkWD+NV4yhGHUEL+tMnHqWs8BBHN1lu4C5XqY
	WDvqvwxgL7AJhWhwxsmi6LijkpFc=
X-Google-Smtp-Source: AGHT+IEhG8yb0DN5azLksyXPUrRHr8vbXffVkqBSYdftGQ8kgbIULC9JtvZq1U5symED/v3v5+dTCncrrJJvNXH6Woo=
X-Received: by 2002:a17:90a:ec14:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2d3dfc6adb1mr310656a91.11.1723741634889; Thu, 15 Aug 2024
 10:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814080356.2639544-1-liaochang1@huawei.com> <Zr3RN4zxF5XPgjEB@J2N7QTR9R3>
In-Reply-To: <Zr3RN4zxF5XPgjEB@J2N7QTR9R3>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 10:07:02 -0700
Message-ID: <CAEf4BzaUy+oxMk9guMX06z-MLeUJMmf8TvzoLveO7ukBFaJiqg@mail.gmail.com>
Subject: Re: [PATCH] arm64: insn: Simulate nop and push instruction for better
 uprobe performance
To: Mark Rutland <mark.rutland@arm.com>
Cc: Liao Chang <liaochang1@huawei.com>, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	puranjay@kernel.org, ast@kernel.org, andrii@kernel.org, xukuohai@huawei.com, 
	revest@chromium.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 2:58=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Wed, Aug 14, 2024 at 08:03:56AM +0000, Liao Chang wrote:
> > As Andrii pointed out, the uprobe/uretprobe selftest bench run into a
> > counterintuitive result that nop and push variants are much slower than
> > ret variant [0]. The root cause lies in the arch_probe_analyse_insn(),
> > which excludes 'nop' and 'stp' from the emulatable instructions list.
> > This force the kernel returns to userspace and execute them out-of-line=
,
> > then trapping back to kernel for running uprobe callback functions. Thi=
s
> > leads to a significant performance overhead compared to 'ret' variant,
> > which is already emulated.
>
> I appreciate this might be surprising, but does it actually matter
> outside of a microbenchmark?

I'll leave the ARM parts to Liao, but yes, it does a lot. Admittedly,
my main focus right now is x86-64, but ARM64 keeps growing in
importance.

But on x86-64 we specifically added emulation of push/pop operations
(a while ago) so we can mitigate performance degradation for a common
case of installing uprobes on (user space) function entry. That was a
significant speed up because we avoided doing one extra interrupt hop
between kernel and user space, which is a big chunk of uprobe
activation cost. And then in BPF cases, BPF uprobe program logic is
usually pretty lightweight, so the uprobe triggering overhead is still
very noticeable in practice.

So if there is anything that can be done to improve performance on
ARM64 for similar function entry situations, that would be greatly
appreciated by many bpftrace and BPF users at the very least.

>
> > Typicall uprobe is installed on 'nop' for USDT and on function entry
> > which starts with the instrucion 'stp x29, x30, [sp, #imm]!' to push lr
> > and fp into stack regardless kernel or userspace binary.
>
> Function entry doesn't always start with a STP; these days it's often a
> BTI or PACIASP, and for non-leaf functions (or with shrink-wrapping in
> the compiler), it could be any arbitrary instruction. This might happen
> to be the common case today, but there are certain;y codebases where it
> is not.
>

[...]

