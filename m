Return-Path: <bpf+bounces-51631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DA6A36B33
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 02:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345A91890ACE
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 01:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E256126C18;
	Sat, 15 Feb 2025 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vREk0Hwz"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F92F4ED
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739583749; cv=none; b=aWLi4gkT12uatcFfjqYDKgJZqXsaQ9uy8JzOISOJoxnnzA3Tx01scLqnc9hkAYTjH5rASElMi+V2z2+lKzgHLmZXt0q1lr9WigyMG/I3RcjdRnG1AP0u40Hjlpf1UbR5grN6tOEZdFVIuAlzmZUgRuuhVyZF7rCIVG20o6X/sE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739583749; c=relaxed/simple;
	bh=QHrBndZ9Bnjnd1xLvW0noMEiXiux22/GGHI1PlSLD+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnrQxooARqfsghYLNc6UdoWqVeAs4XpuclUtlCZ1qGTT4PH+Imd6h8a1fmlZ9vLAcDFLBC/FLpE49PiwkD1jBQL9s4IAmJn+7VWVbzZ3/XCCiOKr+ODSwh4kXBLma/phXocQKNuNsBUN881e3GUsQZqu51Uxd6igK1csH0YgyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vREk0Hwz; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0f675fea-fc8c-4e95-b823-8c9919d830e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739583745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dp6x7JTPyAEWfBfhzqQMfujk3lrsPrZboxeSy1BOj/8=;
	b=vREk0Hwzm4JDdfvWq3cb50zi8t5qFjghUs+rL7pxrXJzyBDCcMKMuEWO2ljKyQnyGICxoH
	UH+l3eHHvoXGkJBAe+SW0oUcBJW22grH+JMwyvC/ha43iTl0Bh5aCljHhdtrU1oLLqg++R
	JYgNgjWMRVcPYqKnksp+EK3o9uGSVtk=
Date: Fri, 14 Feb 2025 17:42:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 4/5] bpf: Allow struct_ops prog to return
 referenced kptr
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@meta.com
References: <20250214164520.1001211-1-ameryhung@gmail.com>
 <20250214164520.1001211-5-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250214164520.1001211-5-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 8:45 AM, Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
> 
> Allow a struct_ops program to return a referenced kptr if the struct_ops
> operator's return type is a struct pointer. To make sure the returned
> pointer continues to be valid in the kernel, several constraints are
> required:
> 
> 1) The type of the pointer must matches the return type
> 2) The pointer originally comes from the kernel (not locally allocated)
> 3) The pointer is in its unmodified form
> 
> Implementation wise, a referenced kptr first needs to be allowed to _leak_
> in check_reference_leak() if it is in the return register. Then, in
> check_return_code(), constraints 1-3 are checked. During struct_ops
> registration, a check is also added to warn about operators with
> non-struct pointer return.
> 
> In addition, since the first user, Qdisc_ops::dequeue, allows a NULL
> pointer to be returned when there is no skb to be dequeued, we will allow
> a scalar value with value equals to NULL to be returned.
> 
> In the future when there is a struct_ops user that always expects a valid
> pointer to be returned from an operator, we may extend tagging to the
> return value. We can tell the verifier to only allow NULL pointer return
> if the return value is tagged with MAY_BE_NULL.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


