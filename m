Return-Path: <bpf+bounces-49621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B828DA1ACC8
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 23:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D41D7A42D1
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 22:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE281D417C;
	Thu, 23 Jan 2025 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A561BuRS"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149D3C463
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737672256; cv=none; b=Whi99KKFV3zF4QcEHGA0j4INHEwJXttO/6UsVgvRYazl4fI4Cxp6VfocF8IAT/43sALUfdQjayzUKZ8agRr+Av7JTf1tC9D/TMwAEWXhz2w3AFAZUcG+vEyz0hkeRNIopBMQ5YaWzn7rttJdAq6mGhvusZnQ4x2qANRDFGUMkz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737672256; c=relaxed/simple;
	bh=QN4xevP2kD07f6DclAx2752o2gTiVEofdsrlbWVXmcM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uo6FDp6x+Zrcvk5GODVW5vtIF/iFRSW09kttzCg+khR6nt+GjbPenaidCxqJcmiyCatEAtn0+iJM7rb2sdKthzQxITQy2FW4FObBB8I3niPAI8GLr6qbcq4InuMLvX4Xd76STfdU9htWOfWVyA0wP6yRJ4c7TYNhOTePIkhqQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A561BuRS; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <53b7e874-484f-4072-97b2-c76d0e810e4a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737672247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpnHIkMla8GYAw59s4KT7gjSCuf3m3ZGtUqLkg5onr0=;
	b=A561BuRSM+U5LhRQnxpPzSTzTZyIl/HJeUiFaWCzJ2UrE3S92NBQjBwPNu7EwFxx/5vv00
	/wmEXtMjqc79ie94iQsQWalqsJiG9OVpeU1XjPBYFZ5l2mEcjU3ydSaYHu7E1kO6TBSKns
	fY2SGj2WkR3Ij9s0OEa2vCYWzNBNeag=
Date: Thu, 23 Jan 2025 14:44:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [TEST FAILURE] bpf: s390: missed/kprobe_recursion
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>
References: <8a6ee672-26d0-4213-be5a-7660d2bfa868@linux.dev>
Content-Language: en-US
In-Reply-To: <8a6ee672-26d0-4213-be5a-7660d2bfa868@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/23/25 2:32 PM, Martin KaFai Lau wrote:
> Hi Jiri,
> 
> The "missed/kprobe_recursion" fails consistently on s390. It seems to start 
> failing after the recent bpf and bpf-next tree ffwd.
> 
> An example:
> https://github.com/kernel-patches/bpf/actions/runs/12934431612/job/36076956920
> 
> Can you help to take a look?
> 
> afaict, it only happens on s390 so far, so cc IIya if there is any recent change 
> that may ring the bell.

Ignore this thread. Somehow my mail client sent a dup... please continue the 
discussion on the other email.

