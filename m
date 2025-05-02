Return-Path: <bpf+bounces-57302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA3EAA7D8E
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 01:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0428189AB5A
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 23:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794D826FD84;
	Fri,  2 May 2025 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sWajPAQV"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01744224229
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746230068; cv=none; b=UF/t231hYz42Z0Nd2e9B5zSInv8+M6085KopitdOwyRqorOB1NLoQcfvOSyHhgUUtUnTSYijv/SQBS3jpgzg+izJ2A6Dn77+N8WIG/fiMdkyL/f9S2dOyvnVqM0G8ctvxLpcCh97Z4YbrKszXcyupN2jBdamnxEA+bNB6eXhTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746230068; c=relaxed/simple;
	bh=Nut9Z6zAswX1Qhme7hdr3QplQpoYsNQAe8svZOfUBUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulkaP8mxyCvr6GQEcwy45BBiSJOX3F2wg4IjJ6FKIKRaRZoWYLk61m1HT9fpvbTTQ133mNJoFkz5amePqIIe9T9ydMGFUHmEuExMuHZp1ffu0M0xyFONeHKHRlEMJCVV8JIwmuRvNN8UOBfaS83eT+Sc1E48/+2JCt9xrm35cMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sWajPAQV; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8fdecc9c-e1ac-4c75-9382-3d6fdd760350@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746230051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J16W7octDyPX0RHz6S2Vch53DXPtbswS4jxvXocz2Ac=;
	b=sWajPAQVfI5pj/FCsDUDohOmKxtIOMag0MQF8TjIn2Cfw2yalGa94Dc1GVH8Y6aCnh44jW
	s45SfhyMW27SwvPfCo2O17qKucDbCHp3DRcm8viDZ3mHeIeL2H+kRWnEOz2R8bA28LFUzY
	0V2qkr/Ogl47V5op1NIHVQj9LWttISU=
Date: Fri, 2 May 2025 16:54:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v2 4/5] selftests/bpf: Test attaching a bpf
 qdisc with incomplete operators
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, xiyou.wangcong@gmail.com, kernel-team@meta.com
References: <20250502201624.3663079-1-ameryhung@gmail.com>
 <20250502201624.3663079-5-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250502201624.3663079-5-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/2/25 1:16 PM, Amery Hung wrote:
> +SEC("struct_ops/bpf_qdisc_test_enqueue")
> +SEC("struct_ops/bpf_qdisc_test_dequeue")
> +SEC("struct_ops/bpf_qdisc_test_reset")
> +SEC("struct_ops/bpf_qdisc_test_destroy")

I removed all the "/bpf_qdisc_test_xxx" part. Only SEC("struct_ops") is needed. 
A similar cleanup was done in bpf_cubic/dctcp.c.

> +SEC("struct_ops/bpf_fifo_destroy")
> +SEC("struct_ops/bpf_fq_destroy")

Removed the "/bpf_xxx" part from these new ones also.

The other existing bpf_qdisc_fifo/fq SEC was an overlook and it should be 
cleaned up in a followup.

Applied. Thanks.

