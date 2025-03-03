Return-Path: <bpf+bounces-53099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6866FA4C657
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 17:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCBE1672D7
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C920322A4CA;
	Mon,  3 Mar 2025 16:05:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE821578D;
	Mon,  3 Mar 2025 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017912; cv=none; b=iu2tpEQ92HAxHwcF2eqDcTXoP7Ld7vI5u5XimKhGjMd+Zh2z+IZg4gpxm3IbtYNMemWiBr2kixzhIbCulg04QAxqy6FpiFrJF0vSs0ozlBk7fop1AsPoEN4S+E3R4pelPix0epSYue0YcFsPpIN9jrRuVkB0hnnuw8gw5X8ZrC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017912; c=relaxed/simple;
	bh=jbJ2N2jSzuaiP65Mwcj5vtf0bSK0vEHTkqqcaJYFKVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWiRbel0+wTwb55U9/ZT9pEYAqyDGIqG8u3h+oaDl1Mq8M2xIyQ7+d34KTVHtfzXOp7FJrmTeVLrq5WqKCcwcs6sx4dhE+uuvApc5HX14NlIjguQSlieaqsB2K5whHhy8wFqvVfU1igMUF+ZEc93XNQvroHk/UeathF+SxLW/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA387C4CED6;
	Mon,  3 Mar 2025 16:05:07 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:05:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: peterz@infradead.org, mark.rutland@arm.com,
 alexei.starovoitov@gmail.com, catalin.marinas@arm.com, will@kernel.org,
 mhiramat@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, mathieu.desnoyers@efficios.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, samitolvanen@google.com,
 kees@kernel.org, dongml2@chinatelecom.cn, akpm@linux-foundation.org,
 riel@surriel.com, rppt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 3/4] x86: implement per-function metadata
 storage for x86
Message-ID: <20250303110559.5a584602@gandalf.local.home>
In-Reply-To: <20250303065345.229298-4-dongml2@chinatelecom.cn>
References: <20250303065345.229298-1-dongml2@chinatelecom.cn>
	<20250303065345.229298-4-dongml2@chinatelecom.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Mar 2025 14:53:44 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> In the third case, we make the kernel function 32 bytes aligned, and there
> will be 32 bytes padding before the functions. According to my testing,
> the text size didn't increase on this case, which is weird.
> 
> With 16-bytes padding:
> 
> -rwxr-xr-x 1 401190688  x86-dev/vmlinux*
> -rw-r--r-- 1    251068  x86-dev/vmlinux.a
> -rw-r--r-- 1 851892992  x86-dev/vmlinux.o
> -rw-r--r-- 1  12395008  x86-dev/arch/x86/boot/bzImage
> 
> With 32-bytes padding:
> 
> -rwxr-xr-x 1 401318128 x86-dev/vmlinux*
> -rw-r--r-- 1    251154 x86-dev/vmlinux.a
> -rw-r--r-- 1 853636704 x86-dev/vmlinux.o
> -rw-r--r-- 1  12509696 x86-dev/arch/x86/boot/bzImage

Use the "size" command to see the differences in sizes and not the file size.

$ size vmlinux
   text    data     bss     dec     hex filename
36892658        9798658 16982016        63673332        3cb93f4 vmlinux

-- Steve

