Return-Path: <bpf+bounces-49399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA7A181D3
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 17:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7026316309E
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564D01F4730;
	Tue, 21 Jan 2025 16:16:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDD5028C;
	Tue, 21 Jan 2025 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737476193; cv=none; b=eWxWpdptqCt+2e99DQG4OOqWLFp7SUX77Nu6/4oZYf6+LNuJKD9HdOEEPScZC674QYX6Gy55iBzd+21F+RruDND1C/kTTI/HA0xnHNytJdjrKK2IB3QLgx/Vr455Tm+d/RCoLpjSYRJxdzS1LOabwmQ3a1HBKdGzN32hXAIn/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737476193; c=relaxed/simple;
	bh=m8/+oAz9c3s5IhomuLkjouwcueBvq5vmmfW6pTnyTN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twHBWJUr3NVg6tlKbYUuPiUQ9Hu8hd+utKEpNeYofMLwMwWQQuk6HaVUP6qzY+CswDInOvC6UaKMU41eKFtOgRf5Nr5PzwAiSbGXehZh/pYUjkMAAJ2njjdV2x1cSXSXHNVFhWkiDCcDSOOGcl7jkllV3x9k8+jhwh4s7+JTYkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BCAC4CEDF;
	Tue, 21 Jan 2025 16:16:28 +0000 (UTC)
Date: Tue, 21 Jan 2025 11:16:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, Kees Cook <kees@kernel.org>,
 luto@amacapital.net, wad@chromium.org, oleg@redhat.com, ldv@strace.io,
 mhiramat@kernel.org, andrii@kernel.org, alexei.starovoitov@gmail.com,
 cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de,
 bp@alien8.de, daniel@iogearbox.net, ast@kernel.org,
 andrii.nakryiko@gmail.com, rafi@rbk.io, shmulik.ladkani@gmail.com,
 bpf@vger.kernel.org, linux-api@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250121111631.6e830edd@gandalf.local.home>
In-Reply-To: <Z4-xeFH0Mgo3llga@krava>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
	<202501181212.4C515DA02@keescook>
	<CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
	<8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
	<CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
	<Z4-xeFH0Mgo3llga@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


[ Watching this with popcorn from the sidelines, but I'll chime in anyway ]

On Tue, 21 Jan 2025 15:38:48 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> I'm still trying to come up with some other solution but wanted
> to exhaust all the options I could think of

I think this may have been mentioned, but is there a way that the kernel
could know that this system call is being monitored by seccomp, and if so,
just stick with the interrupt version? If not, enable the system call?

-- Steve

