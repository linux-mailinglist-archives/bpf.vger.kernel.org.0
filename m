Return-Path: <bpf+bounces-74774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B43FC65BD7
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C4A0F292F7
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884C30CD95;
	Mon, 17 Nov 2025 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WDOYbggP"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF6262FD0
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404601; cv=none; b=XZeafnbHC/vVusrwz2Hx7MngXSLamYgijw3/1GN5jO7FH5O2Wtn2VjyiEv7EIcu/xPUq+/3mEEIv3bKM7IjGzhsnALCAkw3bZAdSC3WeIpeiP7dt+JEkyDTSSpaygRGsZ301eGolWS+rDE/A5jqbtqF4lXkzzyyOr8we11bViy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404601; c=relaxed/simple;
	bh=Y75/5lI7MOBGyhHp3TMh06ab+pJvdnTlIRKltBYZjpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uELprPPZsO46VuNIKrzfufvPWqou6UQEknaGKSSQXiPckB8UE5I0A+A7eyVmI3cNDKQMavm3KHhzi3SDN+Y8wCXf4noKCWTgrAv3YYniMNgZL39b/PM4yHns2XdB89yZrquups3Vu2JWV+RHwUQtZy/wNdtBZJqHhdwy7Cm6ixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WDOYbggP; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <be091ffa-aa9d-41ae-adc9-e5679cfddf7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763404586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y75/5lI7MOBGyhHp3TMh06ab+pJvdnTlIRKltBYZjpU=;
	b=WDOYbggPuuTzt61dFThSWu1Rx7MENV+X6AeCIJJvjMrWgW9bmdZ2Efu26GU6GUmWCzoAXd
	SvI4+aI8cg5TvgeQD2hcS78O20sM6kr7z9PdIUTQG9fU6GhUMd69+SvBZg4NVB3xvMAWfx
	WukxkdleLBAw2Cr0q5rgMO1nTycxK3k=
Date: Mon, 17 Nov 2025 10:36:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Save memory alloction info in
 bpf_local_storage
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, memxor@gmail.com,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20251114201329.3275875-1-ameryhung@gmail.com>
 <20251114201329.3275875-4-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251114201329.3275875-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/14/25 12:13 PM, Amery Hung wrote:
> Save the memory allocation method used for bpf_local_storage in the
> struct explicitly so that we don't need to go through the hassle to
> find out the info. When a later patch replaces BPF memory allocator
> with kmalloc_noloc(), bpf_local_storage_free() will no longer need
> smap->storage_ma to return the memory and completely remove the
> dependency on smap in bpf_local_storage_free().

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>


