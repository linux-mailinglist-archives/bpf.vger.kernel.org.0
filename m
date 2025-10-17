Return-Path: <bpf+bounces-71168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8BEBE5DEF
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 02:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8BE19A62CF
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A96190685;
	Fri, 17 Oct 2025 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqyrUj1D"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B8014A91
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760660399; cv=none; b=fimlaxv10jCG+vdArhCsmAT7g9OVQDxyd84I8JDTOxHlQcW/ZSHzoGbqgJC6w8dgVKe5sZY92WEblHr2ChZovKlkTbJrbbf7vRNe6vczpbYVs1NCmQ1Ctz+oDaVIwEyTrtIdmeGoJfwqqsSU66a8OTgHlHjj1INxzQQPwG/RQeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760660399; c=relaxed/simple;
	bh=t533MWAjxekx1RdhNKfbpM/O6kjNk+pdE1l8KJDfeb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiwC1M1Om/iF//EenmmaLAz0lDch3WQdJsra8463XitQaB+r7w1uzfbqThPx2+PXZtJcT5/o9M/Nd5Zfh6TrwaeeG6/ULSq+DItFSRKlRA/uKBRYkgxMrTbIVxWtQxv8bvAzCns/l+m6+X9mIuNs8qcJNvLbdKRerfo+rmQusOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqyrUj1D; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <285ba391-1d23-41be-8cc4-e2874fbcb1af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760660385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2x7hwEg4kXyGUAy6uSa91M7KYOv6YwYGll5TDIncFg=;
	b=RqyrUj1D56mcLYbMpUohK2wRlgWEojwCL4YrImFR8tyId9kUVrPITZA8EFNX/J2XpunGNP
	xlEAnAFAYSzqGtxlq8dUf94xQiqMVUV7TD9P0N+8vUDb2HrozXR7H1Fr1jIhOgEHLMdHLp
	OJnsq9vZqus+O3MR7efO+n014z6nPfo=
Date: Thu, 16 Oct 2025 17:19:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program with
 struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20251016204503.3203690-1-ameryhung@gmail.com>
 <20251016204503.3203690-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251016204503.3203690-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/16/25 1:45 PM, Amery Hung wrote:
> Each associated programs except struct_ops programs of the map will take
> a refcount on the map to pin it so that prog->aux->st_ops_assoc, if set,
> is always valid. However, it is not guaranteed whether the map members
> are fully updated nor is it attached or not. For example, a BPF program
> can be associated with a struct_ops map before map_update. The

Forgot to ask this, should it at least ensure the map is fully updated 
or it does not help in the use case?

> struct_ops implementer will be responsible for maintaining and checking
> the state of the associated struct_ops map before accessing it.


