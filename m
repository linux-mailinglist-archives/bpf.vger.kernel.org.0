Return-Path: <bpf+bounces-77317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7071ACD7258
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 21:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B33E304076A
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 20:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298F530BF5C;
	Mon, 22 Dec 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vWti6cf3"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52C30BB98
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766436645; cv=none; b=j0COOqR6GcxJSzcjXHwcW5yGF38QOnJedoa9VSpmGYIxeWSdUvAgl4vOs5Sk2ru7ohXq157zy9VhFLfXHNzJ49hvRJEMUwnApptl4ABDxtf33+ZN+lggCz676d8xxLONB58XL27VvL7HDACPmkCEzIRC3djKAxJOe+MmmCDsldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766436645; c=relaxed/simple;
	bh=g2edcYbWytQiXTQsQE/xePAjs/e76ldE4yyH/mLbw0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk8lLZwivwcm+YzzEW5Kmyq6G9PMbrnJASMd7kVC94XKM/koY2xdoDzPM5wTke5jumXOmVcGXqcmVoM47tcoWQNfYu6UlIwY005Yh1Bft4/pkxS1K+V117Y0CFmmhXfZMuljzK44lfzGKJ7rcBj1T6VLm64912pAFbrP3IGW1Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vWti6cf3; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac1ac629-9e99-43aa-a16c-a81d5fec9820@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766436635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPR/QEYurTJLLgB0IiU/Et3tWe5nGVToo+ZseMxXVPs=;
	b=vWti6cf30LtI6nwf/0cI7TuMeb9IT+ChVtuSu8HrmOg0rOt27Pvy4MBnA3jCQZ7UnoiS28
	Igxym+PYoVSy4ZUjMSPcsUhXPgR0XYANKcx6YvcAnsFrvH/LJzb/ZUNkKPCpbyQjLtneDo
	40lfifnSvmtE/EGiz3rf5dD+Zkn3w5E=
Date: Mon, 22 Dec 2025 12:50:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] verifier: add prune points to live registers
 print
Content-Language: en-GB
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 eddyz87@gmail.com, andrii@kernel.org, paul.chaignon@gmail.com
References: <20251222185813.150505-1-mahe.tardy@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251222185813.150505-1-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/22/25 10:58 AM, Mahe Tardy wrote:
> Explicitly printing where prune points are placed within the
> instructions allows for better debugging of state pruning issues.
>
> 	Live regs before insn, prune points (p), and force checkpoints (P):
> 	      0: ..........   (b7) r1 = 0
> 	      1: .1........   (63) *(u32 *)(r10 -4) = r1
> 	      2: ..........   (bf) r2 = r10
> 	      3: ..2.......   (07) r2 += -4
> 	      4: ..2.......   (18) r1 = 0xffff8cb747b16000
> 	      6: .12.......   (85) call bpf_map_lookup_elem#1
> 	      7: 0..345.... p (bf) r6 = r0
> 	      8: ...3456... p (15) if r6 == 0x0 goto pc+6
> 	      9: ...3456...   (b7) r1 = 5
> 	     10: .1.3456...   (b7) r2 = 3
> 	     11: .123456... p (85) call pc+5
> 	     12: 0.....6... p (67) r0 <<= 32
> 	     13: 0.....6...   (c7) r0 s>>= 32
> 	     14: 0.....6...   (7b) *(u64 *)(r6 +0) = r0
> 	     15: .......... p (b7) r0 = 0
> 	     16: 0.........   (95) exit
> 	     17: .12....... p (bf) r0 = r2
> 	     18: 01........   (0f) r0 += r1
> 	     19: 0.........   (95) exit
>
> Also uses uppercase P for force checkpoints, which are a subset of prune
> points (a force checkpoint should already be a prune point).
>
> 	Live regs before insn, prune points (p), and force checkpoints (P):
> 	      0: .......... p (b7) r1 = 1
> 	      1: .1........ P (e5) may_goto pc+1
> 	      2: ..........   (05) goto pc-3
> 	      3: .1........ p (bf) r0 = r1
> 	      4: 0.........   (95) exit
>
> Existing tests on liveness tracking had to be updated with the new
> output format including the prune points.
>
> This proposal patch was presented at Linux Plumbers 2025 in Tokyo along
> the "Making Sense of State Pruning" presentation[^1] with the intent of
> making state pruning more transparent to the user.
>
> [^1]: https://lpc.events/event/19/contributions/2162/
>
> Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


