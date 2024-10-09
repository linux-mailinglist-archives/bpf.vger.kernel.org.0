Return-Path: <bpf+bounces-41356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 865B3995F5F
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 08:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2BA1F249F2
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 06:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E888A15B0FE;
	Wed,  9 Oct 2024 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kjK5x1It"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473055E53
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 06:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453926; cv=none; b=iCk1Dv/5lSlIVcAXqR612tgHmUlaj1lg3KpI14EYVD7aUKGSesjKpxvdV1XH4XVz7J3pxEELuEcMKsSW8BQtBAeqvt5MTT708CFkxbW7rZGmc+mI+IN9uB4M183wqGRsvW9O0UKPtZfMydK8j0b1LCytAsVrNE5yGJU6En8E5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453926; c=relaxed/simple;
	bh=1eEU42de8ebHh7jKTf0QKcDjG1OYA4PXg4rT76Tf2qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPsJqavbqoK5tAp84UzUpUBQosOkjoioh/LJtJ235MjkClzdUz1RY8D2/jHjdAsh/Q+yFwAgbqlXbcCXYNzOkv75auroRWpy4MFeYg9Uqi2KwH3sdndnzBNKeE9BypgsuJJoJ38FkUKIiz+BtED2dfvHFGS7Vm3Ig6hqqbn06nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kjK5x1It; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b803ca1-bf7d-4ecd-8585-aac3b97b6167@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728453922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+pN0OGwczoZelsecyrD2X4biL2Pro4ODwdmdtim8cg=;
	b=kjK5x1ItfMP7QT09Fi1RPR3D+nGtHvCi2AawXKyox9BolDfWMcipiUWjApulJzBGGZXuFA
	OGuFKZrtsIuu2E2H50LGLQfKxk9BN5n3hJKh1Nf4jxa18a1atgk6HRbf0xeho7z4PsIEhM
	UQEnyxwrv18QUnhFkHQPvOppBKKpXIs=
Date: Wed, 9 Oct 2024 14:05:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: Add cases to test tailcall
 in freplace
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 xukuohai@huaweicloud.com, iii@linux.ibm.com, kernel-patches-bot@fb.com,
 lkp@intel.com
References: <20241008161333.33469-1-leon.hwang@linux.dev>
 <20241008161333.33469-4-leon.hwang@linux.dev>
 <e8ca8f6d618a446a3e7ab28f4f36ab7e1e814432.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <e8ca8f6d618a446a3e7ab28f4f36ab7e1e814432.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/10/24 13:04, Eduard Zingerman wrote:
> On Wed, 2024-10-09 at 00:13 +0800, Leon Hwang wrote:
>> cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
>> 335/27  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_1:OK
>> 335/28  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_2:OK
>> 335     tailcalls:OK
>> Summary: 1/28 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
> 
> Tbh, I don't think these tests are necessary.
> Patch #2 already covers changes in patch #1.
> 
> [...]
> 

You are right.

I should provide the commit message to tell the reason why to add these
two test cases:

In order to confirm tailcall in freplace is OK and won't be broken by
patch of preventing tailcall infinite loop caused by freplace or other
patches in the future, add two test cases to confirm that freplace is OK
to tail call itself or other freplace prog, even if the target prog of
freplace is a subprog and the subprog is called many times in its caller.

Thanks,
Leon


