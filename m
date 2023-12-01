Return-Path: <bpf+bounces-16407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4CC801218
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AB41C20ED3
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 17:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1F24EB29;
	Fri,  1 Dec 2023 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GD5yOe97"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A38D3
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 09:51:10 -0800 (PST)
Message-ID: <9841230b-e613-4e70-9844-26cd91a69136@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701453068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQFnWRTx1TD7aQaB4sFvjeeBs0YyeM3RARjxW+bYBws=;
	b=GD5yOe972f+HP0MwDNqe2UIKfOEgYtA7ponqn7EYO8NQOcYwFkrnPpttgPr4AxLz4U/sTq
	QDs0JYWwLbwVAOedNK/xwVzR6Wx1NcScHOBjgHt+RNBxAdM+2ocPeuL2o2UBQfsA8QH4XM
	FwBAQhAbER7YfQE+CELgjcakWmGPiEY=
Date: Fri, 1 Dec 2023 09:51:03 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: sock_ops: calling bpf_sock_ops_cb_flags_set() for already
 established sockets
Content-Language: en-US
To: Alan Maguire <alan.maguire@oracle.com>
References: <f42f157b-6e52-dd4d-3d97-9b86c84c0b00@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
In-Reply-To: <f42f157b-6e52-dd4d-3d97-9b86c84c0b00@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/1/23 9:01 AM, Alan Maguire wrote:
> hi folks
> 
> I've run into a few cases where users have wanted to enable additional
> tcp-bpf sock_ops events for a socket _after_ connection establishment.
> The problem is that to set the flags to enable additional events, we
> have to be in the context of a sock_ops program, and as I understand it,
> by default only events early in the socket lifetime are enabled by
> default (such as connection established/accepted). As a consequence, if
> we do not catch one of those early events, the sock_ops program will not
> run and we miss the opportunity to enable more sock_ops events. This can
> be a problem for boot-time connections like iSCSI where we are too late
> to catch connection establishment.
> 
> I can see a few possibilities:
> 
> - support setting sock_ops event flags via a socket iterator. This would
> mean that the user can always set per-socket flags on
> already-established sockets by iterating over existing sockets,
> selecting those of interest.
> - supporting setting event flags via setsockopt(). In fact we wouldn't
> need to fully support setting event flags via "real" setsockopt(); we
> could simply use a cgroup/setsockopt program and allow
> bpf_sock_ops_cb_flags_set() to run in the cgroup/setsockopt context
> (with additional checks to ensure it is indeed a tcp socket).
> 
> Do either/both of these seem reasonable, or is there a better way to
> tackle this? Thanks!

The lock_sock() is held in both cases (iterator / cgroup-setsockopt), so should 
be ok. I guess it depends on the usecase. If it does not have a hold on the 
socket fd, socket iterator may be the only way.

