Return-Path: <bpf+bounces-49271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5483A16000
	for <lists+bpf@lfdr.de>; Sun, 19 Jan 2025 03:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994B97A3254
	for <lists+bpf@lfdr.de>; Sun, 19 Jan 2025 02:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7DA38DE0;
	Sun, 19 Jan 2025 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBbHNqo0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165372260C;
	Sun, 19 Jan 2025 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737253501; cv=none; b=F27OrNPM60rAcZ+LqSaWF5seA2hJrPj95jzoO75r8STP1Ec1p7D0F9TsB8Nhz2NX4IIw8LjkOu8XKNnCR/RJqKMMjRF/AfVX7upGgQVBMdmY003dQSZ2yAX+vIOO+13lJzoeFH7fHGSIh000Z6+UzwjvlPFCv1POOyCFIcOudUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737253501; c=relaxed/simple;
	bh=ddL+NkFNYPrdui3CKEli90UVHoVi0+D4DKl8jrPqKJg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SHT2dSdTN3foxQPnPUXiLjDjwb6Ru7wvKq8WcbiPdKTsJe+i6EL/7OrdyrkBbo0V4yD7ySplKpQ/xg3ZB0znUm6xJCFrcd09qYoZpGKi3g0N3YfiJMGWXHts2bnU44i23OXsjCeVutjUaV+z6/e183Jz29Jvt4ljpbjh5U+mdO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBbHNqo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2100FC4CED1;
	Sun, 19 Jan 2025 02:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737253500;
	bh=ddL+NkFNYPrdui3CKEli90UVHoVi0+D4DKl8jrPqKJg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BBbHNqo0OrObq+Bp0IRPC0XRoaQWk4tvtqMd58+wboBRrpuPrp7Aie1PYphHFCa1v
	 EeyO/M924eO6cFQmJWzud3achxJkEkiNar0FvhW6fJSPTPNe6vh8CINkpZpujPvTLg
	 39nWR/exipEvFcedt8rf+GUM9JPnX09bsdKtTNB+FjPPpCOfnNrKqAG3ItEKbCmFIr
	 gZqDyH01citVBTxEL7E35eoeGIJkpH7PwQOVUXcK7Vqax5yMXF0xDNd8NJ/u7u6+sc
	 5e06JOY80OJLM590u45BDvqMfFrOQq7alpk7+ieStqFY6vzB2hwQ1Myy1MBYPrxcwq
	 IryIRWnGOy8ew==
Date: Sat, 18 Jan 2025 18:24:58 -0800
From: Kees Cook <kees@kernel.org>
To: Eyal Birger <eyal.birger@gmail.com>
CC: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, ldv@strace.io,
 mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org,
 alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net,
 ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io,
 shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_seccomp=3A_passthrough_ur?=
 =?US-ASCII?Q?etprobe_systemcall_without_filtering?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com> <202501181212.4C515DA02@keescook> <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
Message-ID: <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 18, 2025 12:45:47 PM PST, Eyal Birger <eyal=2Ebirger@gmail=2Eco=
m> wrote:
>I think the difference is that this syscall is not part of the process's
>code - it is inserted there by another process tracing it=2E

Well that's nothing like syscall_restart, and now I'm convinced seccomp mu=
st never ignore uretprobe -- a process might want to block uretprobe!

So, no, sorry, this needs to be handled by the seccomp policy that is appl=
ied to the process=2E

>So this is different than desiring to deploy a new version of a binary
>that uses a new libc or a new syscall=2E

Uh, no, the case I used as an example was no changes to anything except th=
e kernel=2E Libc noticed the available syscall, uses it, and is instantly k=
illed by the Docker seccomp policy which didn't know about that syscall=2E

> Here the case is that there are
>three players - the tracer running out of docker, the tracee running in d=
ocker,
>and docker itself=2E All three were running fine in a specific kernel ver=
sion,
>but upgrading the kernel now crashes the traced process=2E

If uretprobe used to work without a syscall, then that seems to be the pro=
blem=2E But I think easiest is just fixing the Docker policy=2E (Which is a=
 text file configuration change; no new binaries, no rebuilds!)=2E

>I think this syscall is different in that respect for the reasons describ=
ed=2E

I don't agree, sorry=2E Seccomp has a really singular and specific purpose=
, which is explicitly *externalizing* policy=2E I do not want to have polic=
y within seccomp itself=2E

>I don't know if seccomp is behaving correctly when it blocks a kernel
>implementation detail that isn't user created=2E

But it is user created? Something added a uretprobe to a process who's sec=
comp policy is not expecting it=2E This seems precisely by design=2E

-Kees

--=20
Kees Cook

