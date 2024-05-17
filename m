Return-Path: <bpf+bounces-29910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF8D8C809D
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 07:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC101F223EE
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 05:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566E410A25;
	Fri, 17 May 2024 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pefdQCGE"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248841095A
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715923917; cv=none; b=ZQ1Wy8anWaDowrU+9srGZoQgyS1bTyVI35geXmPApZYvFveKVDSlMYh3QpNcu65JshaL6veOumhzAkx8YkdIzexVZIfxPLpbUN6CfXrvDv2MwYIcKYqq4hCxfDRxyq8rnmLuTDqtu/vD0fyQ5rQP4PxgBZ1yUpD/9TLdPwdkwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715923917; c=relaxed/simple;
	bh=absqiGfvycRZSEK8hB0pz9iDnBjitUNULBRZy+DAKEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THWjUzDhMCe6xhId85BrpH6Q5vmx+uZWkkj54YL2NwlOFnuuR7Frkw+M1YVv9q1TuRPqo10HSU5H/S6Ds/h8QROiQeJZmmUa6b5CBCFGOovvPMO5sdTldjuZePmmQGvJfImRq/M6r/oNn8kwHnJcRrw5L9R7I3i1n6qLku9bYbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pefdQCGE; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ameryhung@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715923914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWiH1ntwk6P5FhwO/W2vcC5tpmZ5f241W3D/djzN3rk=;
	b=pefdQCGEmDzYbSY4gBkHkM8E8m88P60tW27DIGiTGaMQI4RUwK3xEMVz5b3toh+BRlkowk
	98kWdJtBhGhz52w7BYpeoVK5p6/AdIEs0HYIURemFHqxyqldOQItQBzrAIB9u6dS+iFxwc
	hfRSHvPPCI8cEWc1A+uY/KayugUWQYQ=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: yangpeihao@sjtu.edu.cn
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: toke@redhat.com
X-Envelope-To: jhs@mojatatu.com
X-Envelope-To: jiri@resnulli.us
X-Envelope-To: sdf@google.com
X-Envelope-To: xiyou.wangcong@gmail.com
X-Envelope-To: yepeilin.cs@gmail.com
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <7e6f6e7e-bcec-44a2-99d6-ec923f2f305c@linux.dev>
Date: Thu, 16 May 2024 22:30:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v8 03/20] bpf: Allow struct_ops prog to return
 referenced kptr
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, sinquersw@gmail.com,
 toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, netdev@vger.kernel.org
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-4-amery.hung@bytedance.com>
 <CAMB2axMa6sGcn69QhzkoG5JijDF+QpBuyWO9aae7hrLrM_EZvA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axMa6sGcn69QhzkoG5JijDF+QpBuyWO9aae7hrLrM_EZvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/16/24 7:06 PM, Amery Hung wrote:
> Arguments and the return for helpers and kfuncs, where we transition
> between bpf program and kernel, can be tagged, so that we can do
> proper checks. struct_ops shares the similar property in that sense,
> but currently lacks the ability to tag the return.
> 
> A discussion was that, here we assume the returning referenced kptr
> "may be null" because that's what Qdisc expects. 

As a return value of a kernel function, it usually needs to return error. I was 
thinking "may be null" is actually the common case if it is not ERR_PTR.

> I think it would make sense to only allow it when the return is explicitly
> tagged with MAY_BE_NULL. How about doing so in the stub function name?

I think this is something internal and qdisc is the only case now. The default 
is something that could be improved later as a followup and not necessary a blocker?

But, yeah, if it is obvious to make the return ptr expectation/tagging 
consistent to how __nullable means to the argument, it would be nice. Tagging 
the stub function name like "__ret_null"? That should work. I think it will need 
some plumbing from bpf_struct_ops.c to the verifier here.

