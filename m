Return-Path: <bpf+bounces-79323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2038AD3847E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 19:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F015302F2CD
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9695C34A3A2;
	Fri, 16 Jan 2026 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LLSUwYFJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4B33C538
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588701; cv=none; b=jwThzt8j36SdwFPBL7pynI0rmmyNPitocI9HYFMO5V9024bJZ7wwgdLpoNGZfEHkINwG8lcs/CzDpTIycNzQSLy0pZumSfG6GA3moqiFFP3mY5ZINVZdiNSHiNm3HB6oMhdLGfhTd5WMpD1X3WayX+hyIsH0hbnGYnVrbmuP1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588701; c=relaxed/simple;
	bh=1ky4UikkOikzyKvl+Pwr3xvGiCpORk73qCitj901RwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IESuHjiyQM0dDMTkjMyqEQYRN9MAgKk/2VrVwhauiuXDmNZoSfPBV/4V+AJSJf2gWFya5hlGc6xUq2zt/FSocxXY4UBMQzByUGiH7TGQgDmhZVLniJEnCwlcknYR7U1pYP2ZUB29+b5ApsLJJ8AOCjm1xZuVe84eTXWHkQSoBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LLSUwYFJ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a6bf2c0-a949-4c29-9001-f0116cc6f7ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768588696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/07ScKuHr2iROBs6Acls6nZ3d/fY3yEhuuO/c3+M8+I=;
	b=LLSUwYFJFPmQ95ZvnhRWf8yuUbplcEs83O5+qJL04VAguodfXrei3cLyUnWub3Cox3liuW
	C5ASy5m5xIz7Ysg1FrN0csZ/GbImmxpdQMJT2hNxM4ZU8FmZ9JScFskBze5QDblsR6/VW0
	HnMgaUDO/AWYzUWULJmhyNmXy/U/7Tw=
Date: Fri, 16 Jan 2026 10:38:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: verifier: Make sync_linked_regs() scratch
 registers
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20260116141436.3715322-1-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260116141436.3715322-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/16/26 6:14 AM, Puranjay Mohan wrote:
> sync_linked_regs() is called after a conditional jump to propagate new
> bounds of a register to all its liked registers. But the verifier log
> only prints the state of the register that is part of the conditional
> jump.
>
> Make sync_linked_regs() scratch the registers whose bounds have been
> updated by propagation from a known register.
>
> Before:
>
> 0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
> 1: (57) r0 &= 255                     ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
> 2: (bf) r1 = r0                       ; R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R1=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
> 3: (07) r1 += 4                       ; R1=scalar(id=1+4,smin=umin=smin32=umin32=4,smax=umax=smax32=umax32=259,var_off=(0x0; 0x1ff))
> 4: (a5) if r1 < 0xa goto pc+2         ; R1=scalar(id=1+4,smin=umin=smin32=umin32=10,smax=umax=smax32=umax32=259,var_off=(0x0; 0x1ff))
> 5: (35) if r0 >= 0x6 goto pc+1
>
> After:
>
> 0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
> 1: (57) r0 &= 255                     ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
> 2: (bf) r1 = r0                       ; R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R1=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
> 3: (07) r1 += 4                       ; R1=scalar(id=1+4,smin=umin=smin32=umin32=4,smax=umax=smax32=umax32=259,var_off=(0x0; 0x1ff))
> 4: (a5) if r1 < 0xa goto pc+2         ; R0=scalar(id=1+0,smin=umin=smin32=umin32=6,smax=umax=smax32=umax32=255) R1=scalar(id=1+4,smin=umin=smin32=umin32=10,smax=umax=smax32=umax32=259,var_off=(0x0; 0x1ff))
> 5: (35) if r0 >= 0x6 goto pc+1
>
> The conditional jump in 4 updates the bound of R1 and the new bounds are
> propogated to R0 as it is linked with the same id, before this change,
> verifier only printed the state for R1 but after it prints for both R0
> and R1.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


