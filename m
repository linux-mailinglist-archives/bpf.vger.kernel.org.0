Return-Path: <bpf+bounces-37806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F42A95A9D6
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A07284DB9
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408556BFCA;
	Thu, 22 Aug 2024 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mrsgiyaj"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6556766
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289624; cv=none; b=inAiR/14a+4phZPE+9GJGppPtWHEcGkfarFAuN0RbupgT+QJbKk7HwpCKcDHoMDdmXciLqFUMd/hjXkWmSVMv6qYoN178yF21yuzDO2pYI+wJeOUj5B1fPJBOvUPx8xg837HNNFy8qJBftqdAAZBaGznfilBA3zzjVnhDNoWhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289624; c=relaxed/simple;
	bh=OtdFDuUGhkyqwtDzsjbru1iLCiDvkTzWaley1hWs3Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fn0oH/gccMj6VUiNCU/Ppw7FFn6+++ECv5aOVnnlfdlArPYtW+G2ZV5hYo61kaAjUW5AE6LjZJaHDCBNt9Lilupdxf7aJJV5CORezVSqzMQa8OLTDyIZ1ySYeaZ6GSZXTi87ahhXfyjLYiaiCttLbWS/CH9fxuTI74gNhbYPN3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mrsgiyaj; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08b8436d-473f-4b5b-9ac1-b81eb8822e64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724289618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtdFDuUGhkyqwtDzsjbru1iLCiDvkTzWaley1hWs3Vo=;
	b=MrsgiyajoPAgYDK8c09R5l4Rdp/1XtP4HSgrFXW+qxm+p2XZ+N4sgIb44J6NbRMKb0Si60
	Yj8swEqzgvIK6lVwK5bIn1ple7wK3j8Sv0d2bi1A7uzKcjXYOF26VVreADjbsupv3jY9YM
	SHnvjQPw0Ejz9mBTTs79K99zvf5Nmh0=
Date: Wed, 21 Aug 2024 18:20:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/5] selftests/bpf: rename nocsr ->
 bpf_fastcall in selftests
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, jose.marchesi@oracle.com
References: <20240817015140.1039351-1-eddyz87@gmail.com>
 <20240817015140.1039351-3-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240817015140.1039351-3-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/16/24 6:51 PM, Eduard Zingerman wrote:
> Attribute used by LLVM implementation of the feature had been changed
> from no_caller_saved_registers to bpf_fastcall (see [1]).
> This commit replaces references to nocsr by references to bpf_fastcall
> to keep LLVM and selftests parts in sync.
>
> [1] https://github.com/llvm/llvm-project/pull/101228

Let us change the link to https://github.com/llvm/llvm-project/pull/105417

>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>

