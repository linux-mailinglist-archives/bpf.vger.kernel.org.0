Return-Path: <bpf+bounces-79311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 207D1D379FF
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 18:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3C96303D8AC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62034165E;
	Fri, 16 Jan 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tqeEKivl"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87533ADA9
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584437; cv=none; b=tPOFe/94OnCw7k4E4JpP28XmPo+aukcNMli2NF1k/9IduzcD4x7ZD6uqyVLGvS9oE7Z7PZoS0qBtHvWNvZnHCSOFTCx2rtIafw+LasK/HnFsWbxFhiDtWAr5YckmnJDsR8NK+r7iUNWCHagKcNhki+c6uHk4HBNbKcKH/P5OQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584437; c=relaxed/simple;
	bh=zMJWrBE0tYCY8+z3t3KMeR4M0ruLw7+B8YnWtlYtfz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlrAE16TXWoMCfmU5jHjMv6kFlI4JqsSsECdhgTPx9W6PkeGjmf9ayIhk2wkF0QzxZimC0k7nIueKelJ2Ky0uy5cs+36eGNFzuitQya+2X1lOgBIlLqEPteng1cDk1Mu67yPst1SScZ94EUo87+/i+rY8uF1ea2PTHkUhu+i9f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tqeEKivl; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8131f46b-7115-44db-b182-9471afa67e61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768584424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMJWrBE0tYCY8+z3t3KMeR4M0ruLw7+B8YnWtlYtfz0=;
	b=tqeEKivlbF4yUz+8PCt0PXV0c4dI/2oC71B+sG/PfWkpFTMSSzZJZuXlYxZEbRjdlROl9j
	fwrd2o9AAr0B4hwo8FjolvbZKVqC9yl9/VWAQPMdos0EEZJSIyBW5OkL+erJBjQsMHIIou
	aUo929t1xsEZSwDaA8O/qYyywIsFQLM=
Date: Fri, 16 Jan 2026 09:26:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kcsan, compiler_types: avoid duplicate type issues in BPF
 Type Format
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, kees@kernel.org,
 nathan@kernel.org, peterz@infradead.org, elver@google.com
Cc: ojeda@kernel.org, akpm@linux-foundation.org, ubizjak@gmail.com,
 Jason@zx2c4.com, Marc.Herbert@linux.intel.com, hca@linux.ibm.com,
 hpa@zytor.com, namjain@linux.microsoft.com, paulmck@kernel.org,
 linux-kernel@vger.kernel.org, andrii.nakryiko@gmail.com, ast@kernel.org,
 jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, bvanassche@acm.org,
 nilay@linux.ibm.com, bpf@vger.kernel.org
References: <20260116091730.324322-1-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260116091730.324322-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/16/26 1:17 AM, Alan Maguire wrote:
> Enabling KCSAN is causing a large number of duplicate types
> in BTF for core kernel structs like task_struct [1].
> This is due to the definition in include/linux/compiler_types.h
>
> `#ifdef __SANITIZE_THREAD__
> ...
> `#define __data_racy volatile
> ..
> `#else
> ...
> `#define __data_racy
> ...
> `#endif
>
> Because some objects in the kernel are compiled without
> KCSAN flags (KCSAN_SANITIZE) we sometimes get the empty
> __data_racy annotation for objects; as a result we get multiple
> conflicting representations of the associated structs in DWARF,
> and these lead to multiple instances of core kernel types in
> BTF since they cannot be deduplicated due to the additional
> modifier in some instances.
>
> Moving the __data_racy definition under CONFIG_KCSAN
> avoids this problem, since the volatile modifier will
> be present for both KCSAN and KCSAN_SANITIZE objects
> in a CONFIG_KCSAN=y kernel.
>
> Fixes: 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifier")
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Tested on gcc15 and llvm22 and all works okay. Also
the patch itself makes sense, so

Acked-by: Yonghong Song <yonghong.song@linux.dev>



