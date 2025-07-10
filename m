Return-Path: <bpf+bounces-62965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16432B00B52
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 20:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD3F7AA422
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087E2FCE07;
	Thu, 10 Jul 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WXmFXxFT"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4238284669
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171993; cv=none; b=VY6YRR2CdlZcv/yIEgr8aGy96XFJ52neUl5+L8OITbDRjHZs/IYQQO00bY219WCYnEc/+fKqFFJ4fstO3tBQuJV7N3DZt67r3j564Bl8CVsHSACw0iOTORruduURb8SZz1lScDQSaQ14xpA58RVaVnD4NP3VcO3zHFx8yUec1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171993; c=relaxed/simple;
	bh=stNQq0cgqTnzV2EJ3FHfdlzz6D2JFWyIose4ahA1Ino=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QDpOb8IizpleHC3l08QkYOdbyruLxzy+Whmi3x8b4rWzRKFPmX7Kjg1hnQb4jg8nsS7AzrwTkC/cDcQ9quLLqGEqO2y/CLfjX0up5JNOoKai60bo3Hf9n9nGQNd3EeUChjNVMVqwmrDJKfkRP5QCBhIr9osSylRm55yhz50oSt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WXmFXxFT; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e0663356-c10a-4f57-aab5-ea1c32441821@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752171988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01bfLQ3jMDlMsGUYOLDFdQ+l5qKzyiidcsZwhc5kv0A=;
	b=WXmFXxFT0wx35lAerm4IjNIIbab0fCXloYCH0jLbhpzN4LbfSsIumGUSXjp5G7SlnOsg/N
	wPRfioQeRKXeJ5gUNh6Ts8SY69rQyMr/2IY8cCMLZ/xJglbvtz8TPIvo/hb6v5PBDY01Ax
	VUtWFKhQABJ5g4PvXj3+/CEj0vYJJ3M=
Date: Thu, 10 Jul 2025 11:26:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based
 struct_ops attachment
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Amery Hung <ameryhung@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 tj@kernel.org, martin.lau@kernel.org, kernel-team@meta.com,
 bpf@vger.kernel.org
References: <20250708230825.4159486-1-ameryhung@gmail.com>
 <20250708230825.4159486-3-ameryhung@gmail.com>
 <68f4b77c-3265-489e-9190-0333ed54b697@linux.dev>
Content-Language: en-US
In-Reply-To: <68f4b77c-3265-489e-9190-0333ed54b697@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/9/25 3:13 PM, Martin KaFai Lau wrote:
> If I understand correctly, the kfunc implementation needs to look up the scx_ops 
> instance (i.e., the struct_ops map) from the map->id/cookie. There is a similar 
> map->id lookup in bpf_map_get_fd_by_id(), which requires acquiring a spin_lock. 
> If performance is a concern, we can investigate whether it can be rcu-ified. 
>  From a quick glance, bpf_map_free_id() is called before call_rcu(). Note that 
> bpf_struct_ops_map_free() will wait for an RCU grace period.
> 

After looking at bpf_map_put more, not all BPF map frees wait for RCU. It may be 
cleaner to store the sched_ext_ops map in a separate (i.e., new) lookup data 
structure. That may also make it easier to ensure the looked up map is a 
struct_ops map (or in particular a sched_ext_ops).

