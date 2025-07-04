Return-Path: <bpf+bounces-62406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99316AF9989
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C7C1CA16F1
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E07F2D836F;
	Fri,  4 Jul 2025 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUC4rJYw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE512D3EFC;
	Fri,  4 Jul 2025 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751649285; cv=none; b=R3DWrG/FIWozb2AaOk2fFoLyN5H/yojQkRu3VN7M+2+/kphgKLzTzjvsarWZ6FJl440uCNOkb0R/Ffw4zDBVROCgb2wzyo/btdmBldKjK0JTRw9RQh43oHnYzNmy+/w5RU7R/sZgty8CUlW6JtKaI52yInWNk1R2TwpgxgF3RtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751649285; c=relaxed/simple;
	bh=34JBcfpqv/RuVeGVE1sgz4VnuW3G11ODRxomS8x+vyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy73QaOyyDq5czAa8h4NTsXhIUsvaUKu/tDQKzkoFZrmi/z1UPqRuzi2smoqeK573vH9AtZvV5DCpsGckyP4vsOAIbnnIzkn34naRBtMaXvFWNZaSGMv2KcMZODEJlaUerQXo8jnNmX5KNHKxb89J+W3eNJDd+N5eWn86g5RCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUC4rJYw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45348bff79fso11883415e9.2;
        Fri, 04 Jul 2025 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751649282; x=1752254082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tyC50wOyVRs8MKfadyZet0uzckUrFkE/ZuApW9xR9g0=;
        b=JUC4rJYw6n32r6GpnLEO+V+CXLuWGvB5mu54yNuRGG2xZJIZN4jtg8TJwOyii10fm+
         95/rbMeBg+qbBNl6E+9dy1IwzUo+5qF1NZeTLn+nzn3U7ctbAlapolYrhMbdq4x5kOu2
         Jhp3bLDiVNxIwxUkzSg9FcaMBS+LjPApPfNPPR6zjdLlhJLj3R1oVsapbwCOsDbgkL5b
         ozP59Qz9C7ayz8goEPbyOuAHGrMFa4Pq8qAiuuWRhZ69rOUZ8Qq0q4U3ykvQ4/Y+M7q6
         mBhApX7wkYlYOYGJTqYffpmmX4JAfHL/UpXzkBIGGya4vbS6aSSIc3vrkhQ1Ag5DDN0e
         +9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649282; x=1752254082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyC50wOyVRs8MKfadyZet0uzckUrFkE/ZuApW9xR9g0=;
        b=eLAWVHc7zz9pnfzraYcLeA0HF82rarTEsQhEmuY7EVTdAo4r+Y6wnQLTaUducvjRo2
         ye2rrupEYMEq3vfXp7/9d52bbS9Ryu5qCwUs9oi/e3jbIxzBu7iT6TrMrjayM6e+AaEs
         Dc6PU0fwzdAMmbyYkpEiouA2+qUUy+Uk2sDaS2NWC4Y7X44R0dPTVuLfeNWeYfJ81i/c
         fkZPDcJTxsI385CjX8oXoEu7i8ijh7r4mC+bH74f8daZJXVk2oTa8eqAHYDiRueMcvZD
         8mA36zl2mfdee3p4p7lh8CnkFJFne/O6rP2ldtheCjYFBU4+mmQQLwm9DKYbUavQ8tnH
         ymaA==
X-Forwarded-Encrypted: i=1; AJvYcCVHESibUwliAqjD52iOvrLpSvwQnuAUbjI8PxdPwQ8CjlGuzymdkzOb+MYKxhBoDwdxZKYHOIIF+Xgog+3K@vger.kernel.org, AJvYcCX1kPmEykCO0lP12fwZru/zyrJsuAdEHS5tYwwYm/HQH9YyjPSiKucE1bZfWvAVGdT1U1Y=@vger.kernel.org, AJvYcCXlw0sxcpO/7RWXX/Z2+c/8qMQ1slOte/AUPwN9RtlOlys+HjwlJ2snHmxDhucsIZNHfV6uGqM8@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbyhQLwB14XELGsq14LexcAnnMU5ATjpnglz3FSfvkfl1+xn8
	3KR0sH9gwCv3MFzAcOGL9XtsT8b7EhWpiUWHBHbC62C/xG4aKyKrJ70k
X-Gm-Gg: ASbGnctPfqAc4+kQNYCVFL9o/xGiwNvWejdG7+l9i0JL0O9nWW7Mzp8zjVot0wZd01W
	O9b+kHCN9zy4rymnjzqSjr0U2mhHtOlaRdKELGIre8PpOgh8C7QxKJJTiv7ygfZOLHoQ/zIpPP0
	WxoNClJXW4yyU/hKrWadGlH4JPWtxoabXEJFI6zp97Ofx0CXQOn8eBQI7d1Q/3xXmCz5ld2qDZN
	NhFOrmrchDxbzJb0cIfDyZRgFJzMAEpWyJePYtVHYlxKyao7fs9ZoyR+CxhRWBtfn8dgfZhRHLP
	gN6bsIozoLeiwHWDdQJcqGsSszhMd3sLOH2AVjHO1AjYn27cquSj3o8ITgbe3YAzExG90pfQKV2
	V2o44wOGEsVEDigrEy/Fadbfv9qi92RoohP9etxvkNiaM0Qt8CeW2BKnjpfY=
X-Google-Smtp-Source: AGHT+IEpBfkGUWzq1y9+h7zKwUeUeUOSaRanOJEnEFwDu+h0TVYl39D9u2QkWyRSq6xOmn06pQZyFA==
X-Received: by 2002:a05:600c:3555:b0:453:8f6:6383 with SMTP id 5b1f17b1804b1-454b4e850ffmr36548925e9.15.1751649281599;
        Fri, 04 Jul 2025 10:14:41 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f4a70e6ef5563d6a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f4a7:e6e:f556:3d6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0ed9sm2995844f8f.38.2025.07.04.10.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:14:40 -0700 (PDT)
Date: Fri, 4 Jul 2025 19:14:38 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
Message-ID: <aGgL_g3wA2w3yRrG@mail.gmail.com>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
 <aGa3iOI1IgGuPDYV@Tunnel>
 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>

On Thu, Jul 03, 2025 at 11:54:27AM -0700, Eduard Zingerman wrote:
> On Thu, 2025-07-03 at 19:02 +0200, Paul Chaignon wrote:
> > On Tue, Jul 01, 2025 at 06:55:28PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    cce3fee729ee selftests/bpf: Enable dynptr/test_probe_read_..
> > > git tree:       bpf-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=147793d4580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf
> > > compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1594e48c580000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1159388c580000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/f286a7ef4940/disk-cce3fee7.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/e2f2ebe1fdc3/vmlinux-cce3fee7.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/6e3070663778/bzImage-cce3fee7.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0x0, 0x0] s64=[0x0, 0x0] u32=[0x1, 0x0] s32=[0x0, 0x0] var_off=(0x0, 0x0)(1)
> > > WARNING: CPU: 1 PID: 5833 at kernel/bpf/verifier.c:2688 reg_bounds_sanity_check+0x6e6/0xc20 kernel/bpf/verifier.c:2682
> >
> > I'm unsure how to handle this one.
> >
> > One example repro is as follows.
> >
> >   0: call bpf_get_netns_cookie
> >   1: if r0 == 0 goto <exit>
> >   2: if r0 & Oxffffffff goto <exit>
> >
> > The issue is on the path where we fall through both jumps.
> >
> > That path is unreachable at runtime: after insn 1, we know r0 != 0, but
> > with the sign extension on the jset, we would only fallthrough insn 2
> > if r0 == 0. Unfortunately, is_branch_taken() isn't currently able to
> > figure this out, so the verifier walks all branches. As a result, we end
> > up with inconsistent register ranges on this unreachable path:
> >
> >   0: if r0 == 0 goto <exit>
> >     r0: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0xffffffffffffffff)
> >   1: if r0 & 0xffffffff goto <exit>
> >     r0 before reg_bounds_sync: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0)
> >     r0 after reg_bounds_sync:  u64=[0x1, 0] var_off=(0, 0)
> >
> > I suspect there isn't anything specific to these two conditions, and
> > anytime we start walking an unreachable path, we may end up with
> > inconsistent register ranges. The number of times syzkaller is currently
> > hitting this (180 in 1.5 days) suggests there are many different ways to
> > reproduce.
> >
> > We could teach is_branch_taken() about this case, but we probably won't
> > be able to cover all cases. We could stop warning on this, but then we
> > may also miss legitimate cases (i.e., invariants violations on reachable
> > paths). We could also teach reg_bounds_sync() to stop refining the
> > bounds before it gets inconsistent, but I'm unsure how useful that'd be.
> 
> Hi Paul,
> 
> In general, I think that reg_bounds_sync() can be used as a substitute
> for is_branch_taken() -> whenever an impossible range is produced,
> the branch should be deemed impossible at runtime and abandoned.
> If I recall correctly Andrii considered this too risky some time ago,
> so this warning is in place to catch bugs.

Hi Eduard,

Yeah, that feels risky enough that I didn't even dare mention it as a
possibility :)

> 
> Which leaves only the option to refine is_branch_taken().
> 
> I think is_branch_taken() modification should not be too complicated.
> For JSET it only checks tnum, but does not take ranges into account.
> Reasoning about ranges is something along the lines:
> - for unsigned range a = b & CONST -> a is in [b_min & CONST, b_max & CONST];
> - for signed ranged same thing, but consider two unsigned sub-ranges;
> - for non CONST cases, I think same reasoning can apply, but more
>   min/max combinations need to be explored.
> - then check if zero is a member or 'a' range.
> 
> Wdyt?

I might be missing something, but I'm not sure that works. For the
unsigned range, if we have b & 0x2 with b in [2; 10], then we'd end up
with a in [2; 2] and would conclude that the jump is never taken. But
b=8 proves us wrong.

> 
> > The number of times syzkaller is currently hitting this (180 in 1.5
> > days) suggests there are many different ways to reproduce.
> 
> It is a bit inconvenient to read syzbot BPF reports at the moment,
> because it us hard to figure out how the program looks like.
> Do you happen to know how complicated would it be to modify syzbot
> output to:
> - produce a comment with BPF program
> - generating reproducer with a flag, allowing to print level 2
>   verifier log
> ?

I have the same thought sometimes. Right now, I add verifier logs to a
syz or C reproducer to see the program. Producing the BPF program in a
comment would likely be tricky as we'd need to maintain a disassembler
in syzkaller. Adding verifier logs to reproducers that contain
bpf(PROG_LOAD) calls seems easier. Then I guess we'd get that output in
the strace or console logs of syzbot.

> 
> Thanks,
> Eduard

