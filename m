Return-Path: <bpf+bounces-51628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 483C2A369EB
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 01:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4C9163F0D
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 00:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461E31373;
	Sat, 15 Feb 2025 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AMeEFyLE"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0022904
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578867; cv=none; b=jk9SHK680700gLOeAyyFOxf+mHrtkhAeF5cAJ+07Wp7xqAIbX22yb5E/lPXvo7Pgy8sL6MWiEQ3v7f4w3Tsv7VU0Zzp2q3duFLqiCQG73ox9qMSjtZED1oDh7nteZRZRAblWGj7g2PeJNh28cVjegbrO4cUag4F7K8vr6jbjwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578867; c=relaxed/simple;
	bh=PfrStYaGr1SKjYAk1wwZHOVneXLbhFmVgWnjrXpteMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qU+Vv8eoErGOxf3F3PtHoNQ6SKMI9y086RumUuLfxkSwn8LWWNBIhrclNcLimNlvnDsQ3fnQmZ8ntBfSOQjYZXuW0RsWgIOk/hZHDf9t+JOWG8KRq76kY5JgZieJ1JdE5hvCKP2+jRlJyLAMDrc9fD5GcEkDeuoYO69p//J8zAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AMeEFyLE; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4f9df8f0-114f-4448-ba3e-66273a225b0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739578861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QMUCj18d8+QhG3MKgt11DEf0IRtSdlZ4GPLaeyohmY=;
	b=AMeEFyLE/iQAbkhlC46oRGoEUWukYRMCrREzH7yR2kRQLuJeo0ff+oFxvuAB2iSSXvno1Y
	uUce2X7r8ATzKAzjf61LUveCZZm7eMLYf/3USkZxtsdRMpUSbm8gvP8azMJYU56R8HYat6
	ZtIOpxRxoaaS2CpSaVJWOSov6Q0TpIE=
Date: Fri, 14 Feb 2025 16:20:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/5] bpf: Make every prog keep a copy of
 ctx_arg_info
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@meta.com
References: <20250214164520.1001211-1-ameryhung@gmail.com>
 <20250214164520.1001211-2-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250214164520.1001211-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 8:45 AM, Amery Hung wrote:
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c420edbfb7c8..598f19e6ebd2 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2315,6 +2315,8 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
>   	kfree(prog->aux->kfunc_tab);
>   	if (prog->aux->attach_btf)
>   		btf_put(prog->aux->attach_btf);
> +	if (prog->aux->ctx_arg_info)

A small nit. NULL check is not needed.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

> +		kfree(prog->aux->ctx_arg_info);

