Return-Path: <bpf+bounces-63923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7B3B0C6F8
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 16:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DFE4E7271
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128CB2D46A1;
	Mon, 21 Jul 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wOXuikRO"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914D29E11B
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109654; cv=none; b=oT1vRn68TFg6oLRgQhTj+CmTRE/Km4U/M69I6rmca6hopDqk8w0s0uKCI/TEz+9XPHzKacdQbt3cGThGzKEzicI7Dm3Zfs07ZgBZ934TwweSAfO+zpxdjUl7PM9OX6bPB11aqojQ23bGCNY01f8VffMbjhsrEdG1nWtnj/mNC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109654; c=relaxed/simple;
	bh=THL+fUQ9gm5BBK1/DqJnbqOdCdcAtahGVSHQAhCxYiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNL/zez+l51hf7rCQ8gi+qwZi0liIB2b0ucOCSO5Wh9TCeTX/cPMgTPVcq8yG/Cl1qNJPhDaDimvgSZ/XOLBLyT9hPzrImc7tYRYvEOcRCTAsEQZPPZ2bbEX1Q5ANKo9ZO8mh50bXjbTyMUOhq8ppLpe+EJBPxNzM5Q50Fz+Poo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wOXuikRO; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9f233a20-6649-4796-9ef4-a499382b0006@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753109640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l422d7oeAFcO1bYQl8KfoBYk/oeBHLUEYg+PCRee8Sw=;
	b=wOXuikRO+I5b0nkI6GZlCqw9R16E3lshkwIgEZQ5ixIO11Jmd0ZftdFmdOUgkK5QXDFym8
	hYuAMqJHmthOZ5CWgGOaii+8A9e0eYKZihdQzcc5NsRowG8uKVDQRa0G63Vo36Tfz75dH8
	kngEu74AVTbCzKC4T6+EKORKw+8yQKo=
Date: Mon, 21 Jul 2025 07:53:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] bpftool: Add CET-aware symbol matching for x86_64
 architectures
Content-Language: en-GB
To: chenyuan <chenyuan_fl@163.com>
Cc: ast@kernel.org, qmo@qmon.net, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuan Chen <chenyuan@kylinos.cn>
References: <20250626061158.29702-1-chenyuan_fl@163.com>
 <20250626074930.81813-1-chenyuan_fl@163.com>
 <21fbb0ba-25bc-4457-9f12-b5a8f6988e4c@linux.dev>
 <172453cd.68e1.197f84fac7c.Coremail.chenyuan_fl@163.com>
 <67b36ef6-fd2e-49a8-b5bd-ebcf69e12f22@linux.dev>
 <6b73e029.985f.1982d0a122d.Coremail.chenyuan_fl@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6b73e029.985f.1982d0a122d.Coremail.chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/21/25 5:51 AM, chenyuan wrote:
> Apologies for any inaccuracies in my previous explanation. Below, I'll provide a brief clarification based
> on verification across both ARM64 and x86 platforms:
> arm64:
> Without kprobe/kprobe_multi Hook:
> (gdb) disassemble vfs_read
> Dump of assembler code for function vfs_read:
>     0xffffc000803ca308 <+0>:	bti	c   // ARM64 BTI security instruction
>     0xffffc000803ca30c <+4>:	nop
>     0xffffc000803ca310 <+8>:	nop
>     0xffffc000803ca314 <+12>:	paciasp
>     0xffffc000803ca318 <+16>:	sub	sp, sp, #0xa0
>
> With kprobe/kprobe_multi Hook:
> (gdb) disassemble vfs_read
> Dump of assembler code for function vfs_read:
>     0xffffc000803ca308 <+0>:	brk	#0x4  // BTI replaced by breakpoint
>     0xffffc000803ca30c <+4>:	mov	x9, x30
>     0xffffc000803ca310 <+8>:	nop
>     0xffffc000803ca314 <+12>:	paciasp
>     0xffffc000803ca318 <+16>:	sub	sp, sp, #0xa0

Thanks for checking. If this is the case, then I don't think we
need to checking
    if (dd.sym_mapping[i].address == data[j].addr - 4) for arm64. In you v3 
patch, the comment also only mentions x86_64.

>
> kprobe directly overwrites the first instruction (bti c → brk #0x4). Hook address (0xffffc000803ca308) matches
> the symbol address exactly.
>
> x86_64:
> Without kprobe/kprobe_multi Hook:
> (gdb) disassemble vfs_read
> Dump of assembler code for function vfs_read:
>     0xffffffff82112b40 <+0>:     endbr64  // x86 CET security instruction
>     0xffffffff82112b44 <+4>:     nopl   0x0(%rax,%rax,1)
>     0xffffffff82112b49 <+9>:     push   %r15
>     0xffffffff82112b4b <+11>:    mov    %rsi,%r15
>     0xffffffff82112b4e <+14>:    push   %r14
>     0xffffffff82112b50 <+16>:    push   %r13
>
> With kprobe/kprobe_multi Hook:
> (gdb) disassemble vfs_read
> Dump of assembler code for function vfs_read:
>     0xffffffff82112b40 <+0>:     endbr64   // Preserved security instruction
>     0xffffffff82112b44 <+4>:     call   0xffffffffa1830000  // Hook replaces nopl
>     0xffffffff82112b49 <+9>:     push   %r15
>     0xffffffff82112b4b <+11>:    mov    %rsi,%r15
>     0xffffffff82112b4e <+14>:    push   %r14
>     0xffffffff82112b50 <+16>:    push   %r13
>
> kprobe preserves endbr64 and overwrites the subsequent instruction (nopl → call). Hook address (0xffffffff82112b44)
> requires -4 offset (0xffffffff82112b40) to match the symbol address.
>
> ARM64 hooks replace the very first instruction (including security features like BTI), while x86_64 hooks target the instruction
> immediately after endbr64, creating a 4-byte offset that must be compensated for when resolving symbol addresses.

[...]


