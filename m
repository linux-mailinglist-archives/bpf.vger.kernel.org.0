Return-Path: <bpf+bounces-29091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6849B8C0125
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 17:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997761C2458D
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7786651;
	Wed,  8 May 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DSSG4Tng"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA81170D
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182748; cv=none; b=sMs6sIND5f4mmghnd8zh5bLacvJTgc4NniW1u/Nnc6Fy7Uvliy7j6Rsny8Hnetxcmg/8q7cnvlvP6UksQLSUrksc+5HyStt2aGIWuDKcLnPaZD94gq4q9GO8XzKyXtg+8a3U6+GTqFVFW/MO/RumwtzGt5NcBLHr9IsuRBAuPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182748; c=relaxed/simple;
	bh=6LempL8Q0wZraTYHyZd/bzH2zG2ISQUukAUaQbfem9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jv6UGHF8lF0tFbjE5BXjCwXCiUFaKIBThtd3ea/CiU3jE+UR9Hf2QGLY6/XMtWjexDNoj7Go6MbGihCSFMcPU9ZVHEp1GU/aO+8JfzSjG/FbUMF3wQNkwLAQmctBR43Bstz3xp800nzSeKpCETV95r4l1eQnY2XbsnZSYTu1K3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DSSG4Tng; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <51b6eab8-7b48-4600-b557-126ae9af8183@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715182743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4S30uU05ycS7AdrUX44L4fu5+ofM8Q8QK0p1dk9OtXo=;
	b=DSSG4Tng6f0UN0/u6I0R+tti/AETZ2lQeslMbMvoFoagg0PJclE1Me8OiZEzr65I2/uXEx
	x/TC2Rm2Hb6VLg9ZjtmvSH433EvyuN/7uUTwRwHtIyIJorM8Cbye4S1R47lJ9WupXjIBki
	glHzMealfE7XdjwS/OPvNg0p1tFjgiI=
Date: Wed, 8 May 2024 08:38:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next V3] bpf: avoid UB in usages of the __imm_insn
 macro
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: david.faust@oracle.com, cupertino.miranda@oracle.com,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20240508103551.14955-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240508103551.14955-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/8/24 3:35 AM, Jose E. Marchesi wrote:
> [Changes from V2:
>   - no-strict-aliasing is only applied when building with GCC.
>   - cpumask_failure.c is excluded, as it doesn't use __imm_insn.]
>
> The __imm_insn macro is defined in bpf_misc.h as:
>
>    #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
>
> This may lead to type-punning and strict aliasing rules violations in
> it's typical usage where the address of a struct bpf_insn is passed as
> expr, like in:
>
>    __imm_insn(st_mem,
>               BPF_ST_MEM(BPF_W, BPF_REG_1, offsetof(struct __sk_buff, mark), 42))
>
> Where:
>
>    #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> 	((struct bpf_insn) {					\
> 		.code  = BPF_ST | BPF_SIZE(SIZE) | BPF_MEM,	\
> 		.dst_reg = DST,					\
> 		.src_reg = 0,					\
> 		.off   = OFF,					\
> 		.imm   = IMM })
>
> In all the actual instances of this in the BPF selftests the value is
> fed to a volatile asm statement as soon as it gets read from memory,
> and thus it is unlikely anti-aliasing rules breakage may lead to
> misguided optimizations.
>
> However, GCC detects the potential problem (indirectly) by issuing a
> warning stating that a temporary <Uxxxxxx> is used uninitialized,
> where the temporary corresponds to the memory read by *(long *).
>
> This patch adds -fno-strict-aliasing to the compilation flags of the
> particular selftests that do type punning via __imm_insn, only for
> GCC.
>
> Tested in master bpf-next.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


