Return-Path: <bpf+bounces-55273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7EFA7B26F
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 01:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0BF189A898
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 23:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DD41DC9A2;
	Thu,  3 Apr 2025 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBc9gv72"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658792E62B8;
	Thu,  3 Apr 2025 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743723497; cv=none; b=L/ghirypOslaArY93vWofUDn9qqGQY0ZKC28fyn+6yAAARwMy7OSudlT++nOfMKfCdZNGenGKIqFAjUq3uSSLjK4jtmJPUMvbaCgFQVLj/lnBATyqyvbye/lwLzD5aWFYmMV3DhTJAQesfNGn0KZplEeTQjq1UpuG+wRgMpfVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743723497; c=relaxed/simple;
	bh=ARtpSuXc5Q1J6pbqUvazMG3UXIw/DngzcoPBK1lgHG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICyTuSBLUTQMBOPmvfwcwSumJpnet6KSUV2qqpD4cqNHXCDbt+GB8PduJ9aVASEnNmy/a1rH4Res9aeShgIFd1JIoIE9Ksixu/E8hQxgVAIVy3guuoUWzfpJ6zqFUr7RRQqJJRJNvVLrcQu4t3zXW37WvV6q5VSbFI/HtgtQCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBc9gv72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3745FC4CEE3;
	Thu,  3 Apr 2025 23:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743723493;
	bh=ARtpSuXc5Q1J6pbqUvazMG3UXIw/DngzcoPBK1lgHG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pBc9gv726PLBWFgV4BY9pevnB8FdPwYuY3DfDiZ+/ois7FmJtkOpYRLivOMKi8MZa
	 s+2GX0zDe+8IM9OXCvDnYHY7nyHf2OQ9LWjGDkEhR+93iID9MQBOLq2fKlylan6ZVO
	 KdE63IcrsdPCd4TYcvnKbSUpcJWrBKDQ3tWHTDb3gInQq5t23fqfjI+NGGPYYf/idS
	 Fr3XXj6zpYAUD+yH1Dqv3bT+kPlMejeJp+7/xUfOZNCDdIIjdiz8P/CzBk8x6zQcWu
	 4fU5QPBG1fSF7ey5HxUCOMJrj2Xj+F0McyT5K8rvpdSzITcQwkwGEIQ7RM4DSjGpRb
	 RPBtp7zK/Ldmw==
Date: Thu, 3 Apr 2025 16:38:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, kuniyu@amazon.com, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
Message-ID: <20250403163812.69ad4cb4@kernel.org>
In-Reply-To: <cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
References: <20250403083956.13946-1-justin.iurman@uliege.be>
	<Z-62MSCyMsqtMW1N@mini-arch>
	<cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Apr 2025 21:08:12 +0200 Justin Iurman wrote:
> On 4/3/25 18:24, Stanislav Fomichev wrote:
> > On 04/03, Justin Iurman wrote:  
> >> In lwtunnel_{input|output|xmit}(), dev_xmit_recursion() may be called in
> >> preemptible scope for PREEMPT kernels. This patch disables preemption
> >> before calling dev_xmit_recursion(). Preemption is re-enabled only at
> >> the end, since we must ensure the same CPU is used for both
> >> dev_xmit_recursion_inc() and dev_xmit_recursion_dec() (and any other
> >> recursion levels in some cases) in order to maintain valid per-cpu
> >> counters.  
> > 
> > Dummy question: CONFIG_PREEMPT_RT uses current->net_xmit.recursion to
> > track the recursion. Any reason not to do it in the generic PREEMPT case?  
> 
> I'd say PREEMPT_RT is a different beast. IMO, softirqs can be 
> preempted/migrated in RT kernels, which is not true for non-RT kernels. 
> Maybe RT kernels could use __this_cpu_* instead of "current" though, but 
> it would be less trivial. For example, see commit ecefbc09e8ee ("net: 
> softnet_data: Make xmit per task.") on why it makes sense to use 
> "current" in RT kernels. I guess the opposite as you suggest (i.e., 
> non-RT kernels using "current") would be technically possible, but there 
> must be a reason it is defined the way it is... so probably incorrect or 
> inefficient?

I suspect it's to avoid the performance overhead.
IIUC you would be better off using local_bh_disable() here.
It doesn't disable preemption on RT.
I don't believe "disable preemption if !RT" primitive exists.

