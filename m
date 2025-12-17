Return-Path: <bpf+bounces-76812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ED4CC5F32
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 05:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A4BD300720C
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 04:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CAF2C3770;
	Wed, 17 Dec 2025 04:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R5ZtTLWe"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149A33A1E96
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 04:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765944887; cv=none; b=fV4oEE9wTI1f+wZwjTarwT/X23uu0FhT8Dt2QVyyv7RY4TtHjMxjRCYcIEOglK9DIULrSHDFPKb5xGFJHZ2XEeODJkdRYac7LyVwE1SXK0Bm0FYPeVvLSJEIirZw6rvflsOCe8CahGHJlP2NYJMobBn535ysA9b8JesivQbHXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765944887; c=relaxed/simple;
	bh=3lAZQQL4Am4yzepVc4vhg1U8EkL2ZiU9oeAQGFws6Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhTFf5+xSY0qQgxXBGTb3/b5NUYoJa+SYZ+oYhrIZdTa3tTa3DpBwO4hxJgedB/27cdA+9Yst6BDH2TMBOxvDnBo5jz/ca2uBn8nVcOZX8SE4xgDRE42hnQpFY9dkYVJG94rO99wFSFxgC/NK9da9Dbg0iXb8iw9DyZxoxt3DAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R5ZtTLWe; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3b3c5b4b-b4a3-402b-8d5d-507edaf4a814@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765944883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lAZQQL4Am4yzepVc4vhg1U8EkL2ZiU9oeAQGFws6Wk=;
	b=R5ZtTLWe4eVZ6lfOrKiZ4bcdDsC0w6Hd7nnNKuUCFDTW3aljA+rUqjNZlkLEZPNrGEjmZH
	uRNc/lR5tj+aUGpfbOaSU62Dc0sY3GHWhBo3bLayxYL++45WQv7ckD/TkBPIcM9KnOYElM
	sKsdjIuhOI5qYsZKyhJnh6QYezr3yy8=
Date: Tue, 16 Dec 2025 20:14:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v2] dwarf_loader: Handle DW_AT_location attrs
 containing DW_OP_plus_uconst
Content-Language: en-GB
To: Yao Zi <me@ziyao.cc>, Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, q66 <me@q66.moe>
References: <20251213082721.51017-2-me@ziyao.cc>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251213082721.51017-2-me@ziyao.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/13/25 12:27 AM, Yao Zi wrote:
> LLVM has a GlobalMerge pass, which tries to group multiple global
> variables together and address them with through a single register with
> offsets coded in instructions, to reduce register pressure. Address of
> symbols transformed by the pass may be represented by an DWARF
> expression consisting of DW_OP_addrx and DW_OP_plus_uconst, which
> naturally matches the way a merged variable is addressed.
>
> However, our dwarf_loader currently ignores anything but the first in
> the location expression, including the DW_OP_plus_uconst atom, which
> appears the second operation in this case. This could result in broken
> BTF information produced by pahole, where several merged symbols are
> given the same offset, even though in fact they don't overlap.
>
> LLVM has enabled MergeGlobal pass for PowerPC[1] and RISC-V[2] by
> default since version 20, let's handle DW_OP_plus_uconst operations in
> DW_AT_location attributes correctly to ensure correct BTF could be
> produced for LLVM-built kernels.
>
> Fixes: a6ea527aab91 ("variable: Add ->addr member")
> Reported-by: q66 <me@q66.moe>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2089
> Link: https://github.com/llvm/llvm-project/commit/aaa37d6755e6 # [1]
> Link: https://github.com/llvm/llvm-project/commit/9d02264b03ea # [2]
> Signed-off-by: Yao Zi <me@ziyao.cc>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


