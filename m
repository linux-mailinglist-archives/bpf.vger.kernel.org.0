Return-Path: <bpf+bounces-75012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 247B1C6BF53
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 00:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C45F4E7952
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 23:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524BD3101DB;
	Tue, 18 Nov 2025 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="No7V5DrD"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1B2DC79F
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507560; cv=none; b=LEZfQDBd7R1g9XEldKByVJRttAshgF+vPthRylDxzK9KUpo6uTLLCwdwuQ2PCzCV8CvzfAmRDoFPvzqxXpNTKo15vPGbc07TqkTD7KllCJbDldPKx1a7GcwdGNHGThGMjmYTTdHw70zJQK3D/umNuLPxYUSiOoJByhB0VT0Vjso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507560; c=relaxed/simple;
	bh=e/Hnql5X24YAHbZdXDFtkYfQnmz3FhRh0cWocj6LGAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5zst+U2Vpzn0VdSHHvu3wCzhgT3dFIsxibhkEKb0lS27w7Om79CTrzCVmibPiaNxKq61kD1hneQG4t3a0/HqLFj9Wr2o06zIYWI6HGksVv5VB3py0JuJ223lBSuOKqghLqZg/75sGKbxus7J6YzNpypcgUpJt4Hr2x7E9mCXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=No7V5DrD; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9ed9de08-9a5b-4fc9-9213-ca918dafea0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763507542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xaoTNRkEc4AwUxJW2GrHJgy21+EkedavIk+JMyDtFX0=;
	b=No7V5DrDej+c5MpOesXj0Sy7BeZ+JSAWRkE392Kxi6iS6pIqF3qnFkLFcpmTwS3NbuSAVa
	BQxNZeLLyguQ7j1Bv3FXE8gK3DnDjrf9T5htpKXVcSD1dYYhETPU/qEBRqeq5ktpfDtsYN
	TtcmiiQAPV9YPxKM8Eod1rE0U1kPFKc=
Date: Tue, 18 Nov 2025 15:12:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next v1 1/5] selftests/bpf: use sockaddr_storage instead of
 addr_port in cls_redirect test
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
 <20251115225550.1086693-2-hoyeon.lee@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251115225550.1086693-2-hoyeon.lee@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/15/25 2:55 PM, Hoyeon Lee wrote:

>   struct tuple {
>   	int family;

The "family" is not needed either. Just use the ss_family from src or 
dst. The 'struct tuple' can be removed also?

I'm on the fence about whether this "struct sockaddr_storage" change is 
worth the code churn. Are patch 1 and 2 the only tests that need this
change?

Patch 3 and 4 make sense. Patch 3 and 4 are applied.

Please post patch 5 as a separate patch on its own.

> -	struct addr_port src;
> -	struct addr_port dst;
> +	struct sockaddr_storage src;
> +	struct sockaddr_storage dst;
>   };


