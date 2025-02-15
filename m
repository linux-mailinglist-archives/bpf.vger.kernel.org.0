Return-Path: <bpf+bounces-51632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A53CA36B35
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 02:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F8717055A
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 01:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4924F82C60;
	Sat, 15 Feb 2025 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FYhNwNpN"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61942AE8B
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739584358; cv=none; b=ubVNOEiKZLSLAK7PSrHeyuSoo+hpgzFr8KVOF6MDQ43ZkypL8r+/xRDTYRB1cMoDjgojCCUqWi3fGateHciN+vspwx6J69/8t2NSFJFKHMltOjb7H1+BdUo8ANdb21llKKv5boxtEt110I/NZNqvR0XRDl7CgAxgc4ScLLiF4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739584358; c=relaxed/simple;
	bh=jfqkk0TCaYWMw6ql0GEFTrNVNTvLzFUE5mw/weUXqfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7tRJgIcuu+egHORmO74S9DCF3ST3EtABugnFKg60XHszoKqWGmb59M2COWJZM325/CbvrPGodu5W6uaIw9z70Jk9gNRR6iZfyPtSthLXsmeLw6kNPiYkJp4o2e6dQwaea3bvAjaUd/XVYYgDl+eIirnYkx3v3Golr0+mcQ9R/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FYhNwNpN; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e39cb65a-a323-4dc8-a5b6-2526c4b11803@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739584353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYnGan2wRT1DFtioqJ6XvduoSrdkRQeSqEFzr5Mxx7M=;
	b=FYhNwNpN0WyHE/4PwCYjvOT5ILBHC6TBduEtsvBL+Nf7nQf3JIXwlQyBX2raDZzxNCT99R
	Il0cDhkZrZC+7aMCHyoEWpsgYgZChSX2lN3KSZ0HWsqj75smSWAz/FipORJvZZz3YD7+xd
	P/3vDv5v6UuiG5aVAsh3jH3XmVIleb0=
Date: Fri, 14 Feb 2025 17:52:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 5/5] selftests/bpf: Test returning referenced
 kptr from struct_ops programs
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@meta.com
References: <20250214164520.1001211-1-ameryhung@gmail.com>
 <20250214164520.1001211-6-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250214164520.1001211-6-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 8:45 AM, Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
> 
> Test struct_ops programs returning referenced kptr. When the return type
> of a struct_ops operator is pointer to struct, the verifier should
> only allow programs that return a scalar NULL or a non-local kptr with the
> correct type in its unmodified form.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


