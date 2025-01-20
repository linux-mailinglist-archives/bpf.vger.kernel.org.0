Return-Path: <bpf+bounces-49305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88152A17431
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 22:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7F71888348
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 21:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41E1F03EA;
	Mon, 20 Jan 2025 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYjBeMSv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC419048A;
	Mon, 20 Jan 2025 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737408883; cv=none; b=aul3ZUGHwNzH6SuH1L9t1NZ/ILHqyfxcAs13ok28Izv7Ay6MB6atkgPPOEEONR2jKVscuoyoAXfzPONdP7BlbPbvbsmyZpZ2jw7LyhAquua7FlNSorxs9uY5gY5ZYyB0vTRl7cwByVV084eZ3RLfCUXgwURsOGKVNx95o8Qv2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737408883; c=relaxed/simple;
	bh=9ih2GpebRjJrsa6IpbPBSwb297i5yfqxVDGG6wxAQB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wdp9H3gY2qpzYXNLbnHvlGaS4nIbPU4U4G3myyS+3baiviDA2j5ASY4cvN4dPExNVMU/IOLySt2G1uQC0TWij/vDBs7gLb58lkWugC9YzM7PwZm9/wDuA+EJjGFvLuZAytBO7+Yetgl9fnTcuqUv3d3Uc3tVHx1UrJ89W4JEkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYjBeMSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE04C4CEE4;
	Mon, 20 Jan 2025 21:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737408882;
	bh=9ih2GpebRjJrsa6IpbPBSwb297i5yfqxVDGG6wxAQB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYjBeMSvfvvQKot1mhfi8Hd5N2XuVOPqPJCdD9uQkMPL4Q8LWkmdm1RPpuMzpnykq
	 tAP5Ud4EA/zUhLeqU5YwyMKpERSneecbkfn9conkiNRdPKaMg5f39LGVnrUGeiRTNg
	 Wr3v6GcHmdfkS37gEXqellLirgmdRGUrfDt1pVtWbsdRe0wSOFPHqLZSMaXlXflcvY
	 2FnQUJ7WNEhn1nE8Z0HID90c99DQAsDCLDnLTik+n0TbPzJNTocSsuAS76Ykow7A2d
	 DLBlCAeqkEZ/0KBotpHTuGwOccl+F0W6rOV0P9/AE4Dt0zAo30fM7ytkuwyk3WnvYF
	 e5AGL8lv5iODg==
Date: Mon, 20 Jan 2025 13:34:39 -0800
From: Kees Cook <kees@kernel.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, ldv@strace.io,
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <202501201334.604217B7@keescook>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook>
 <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
 <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>

On Sat, Jan 18, 2025 at 07:39:25PM -0800, Eyal Birger wrote:
> Alternatively, maybe this syscall implementation should be reverted?

Honestly, that seems the best choice. I don't think any thought was
given to how it would interact with syscall interposers (including
ptrace, strict mode seccomp, etc).

-- 
Kees Cook

