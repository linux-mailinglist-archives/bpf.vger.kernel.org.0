Return-Path: <bpf+bounces-64951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD02B18A22
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 03:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B004D1698D9
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 01:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966841C72;
	Sat,  2 Aug 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aV479sjJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6DE14AA9;
	Sat,  2 Aug 2025 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754099231; cv=none; b=cB9t09PWBVVWxAKc1gQk8Ag4TF2ZK2bB7GQBeMLzf1wGc6tvrrrzx51X3qgr0rzpqi3Ox53TixcSJx1a7A2bpGDwfBvKEcRQqAayZSrZAnHByPG+QG2xfwcIq1MGooj7+x/0+Xtz/+whL/fQyFSR77Mt9Nq+Ty4U/VYZF7U2HRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754099231; c=relaxed/simple;
	bh=M4FIp6gDAq6LOPcZohH8l8bZz1AozZyZU0aoqGzdwhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbOYQbLs1A8CEMZEStHUPOQFFxlYuzQnuRXA3w2HqPXuXiMlNr5stdXMDpmNmnIa8ZNFFfIXVrocdH4kL+rmjxdV7C2AVpP3bRJCSIehMIX9jKm2Kt/x6vA4HVWbIq+uuKh8VmePrg/auTtbzw99dXSZs31YQ+ujXmbMVcDR2lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aV479sjJ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1365e2a1-dda9-4aa3-9658-cc34a9bb3137@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754099226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZx6mqK72vsgBMJWtFA5R42V5D4hVz9KqrDuBiEte2k=;
	b=aV479sjJ7283YcsVqPKAXntC5xs1aYri+Scs/nYhT+3zQvMWdFF7ahBm6Jm2YUBDAlQ9Md
	ycT6wa2552yypBUwMF3iRw4RAsNxCSmfzJphO1fXS7ZYXaT4tcFMARVvBzymVeVTX4WiiR
	5w+BAQVy7i7gQhql9OG9+x7drho/pko=
Date: Fri, 1 Aug 2025 18:46:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v1 00/11] Remove task and cgroup local
To: Amery Hung <ameryhung@gmail.com>, memxor@gmail.com
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, kpsingh@kernel.org, martin.lau@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, haoluo@google.com,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20250729182550.185356-1-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250729182550.185356-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 11:25 AM, Amery Hung wrote:
> Question:
> 
> - In bpf_local_storage_destroy() and bpf_local_storage_map_free(), where
>    it is not allow to fail, I assert that the lock acquisition always
>    succeeds based on the fact that 1) these paths cannot run recursively
>    causing AA deadlock and 2) local_storage->lock and b->lock are always
>    acquired in the same order, but I also notice that rqspinlock has
>    a timeout fallback. Is this assertion an okay thing to do?

At bpf_local_storage_destroy, the task is going away.
At bpf_local_storage_map_free, the map is going away.
A bpf prog needs to have both task ptr and map ptr to be able to do 
bpf_task_storage_get(+create) and bpf_task_storage_delete().

The bpf_local_storage_destroy and bpf_local_storage_map_free can run in 
parallel, and you mentioned there is lock ordering. Not sure how the timeout 
fallback is (Kumar ?) but I don't think either of the two functions will hold a 
lock for a very long time before releasing it.

I also think bpf_local_storage_destroy and bpf_local_storage_map_free should not 
fail. It is good to keep the WARN_ON but I would change it to WARN_ON_ONCE.

