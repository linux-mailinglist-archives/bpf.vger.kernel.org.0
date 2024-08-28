Return-Path: <bpf+bounces-38326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7249963646
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 01:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE9C1F21CB6
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 23:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B47C1AED35;
	Wed, 28 Aug 2024 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ID3HQtNe"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3E1AB528
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888348; cv=none; b=Yu86zBs9Z5k8STVZu83SvVPX2HwmWcd50X6arntiZVRDLu5LlCwFW1bMaQehDEs6M0X90vpqhvAytKebWRpT9OpJOrIG5Atx+t7YnXQlPPLr2J+RsV9bhOvBUhFqd9YNu3prT++ogaHPJAGYE3p/pv+8ewr69NzOoIslBegE5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888348; c=relaxed/simple;
	bh=H6K7AQLLN5A1oYM0+0Iq6C9+LOGrlXIARjps0C204+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qluMmMtkbZp7MKd//3iOTGJ/6jPvOJeJ/AIATHr1I0vBu391529R6JfgtUPaKlyQuygu4o9bWSJ9rO/KwZzdyC/5Ml/MfxCwvSYMK1E54cceHcU69laCxygbT9Y29G/TJeNQPklVv8YCiVhdauKj+YPtzF6yrF/BlJbJyhqvmpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ID3HQtNe; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b57a793-2b30-45bb-bddd-3034c80c1451@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724888343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qojBtzEYCubfc+SLemZKMkIpGSuVb7ZcvQk5GgdMAug=;
	b=ID3HQtNetK1/qcdGp4sZKSvVckb6yCsYKgUmND0uijyOj3twQnea0gZDaArwXN4EkLG6sM
	BUy4n6JWu5zRG5H8XdDwx2OIlchrnNkjcgRYYSYwGgi8QmKHkRKt6U1Rbt2LALPnphupxS
	XAAMUOoTi5OQtxDv4dK5luHncfrwn/U=
Date: Wed, 28 Aug 2024 16:38:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Make sure stashed kptr in local
 kptr is freed recursively
To: Amery Hung <amery.hung@bytedance.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, houtao@huaweicloud.com,
 davemarchevsky@fb.com, ameryhung@gmail.com
References: <20240827011301.608620-1-amery.hung@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240827011301.608620-1-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/26/24 6:13 PM, Amery Hung wrote:
> When dropping a local kptr, any kptr stashed into it is supposed to be
> freed through bpf_obj_free_fields->__bpf_obj_drop_impl recursively. Add a
> test to make sure it happens.
> 
> The test first stashes a referenced kptr to "struct task" into a local
> kptr and gets the reference count of the task. Then, it drops the local
> kptr and reads the reference count of the task again. Since
> bpf_obj_free_fields and __bpf_obj_drop_impl will go through the local kptr
> recursively during bpf_obj_drop, the dtor of the stashed task kptr should
> eventually be called. The second reference count should be one less than
> the first one.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


