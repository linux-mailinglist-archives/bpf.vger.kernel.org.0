Return-Path: <bpf+bounces-19839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B5083212D
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 22:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E291128AB25
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 21:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CB72E85D;
	Thu, 18 Jan 2024 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y14Cujcu"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5E2EB06
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705615025; cv=none; b=WQXQomc15oSKdPUVWeKvE+MC32Rb1diteYRUJet4yttl3xvhjTaQTdHUWLVhNkDJ1XQDI//Op7ZNAAtrMHNoCQfLMbkh+8NQi+3MWFWjXUPZ82HdEGBENpj5vNnk8vBXXWIGCP+nUc7SmR0WS5/McDG6gmh8nha8WsvJ5bGjBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705615025; c=relaxed/simple;
	bh=T6dOyPlPnPmWMQY23lAfswRbS2OF8UAwuzbYVTrFf74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oq+F/4UxZyyQZeZgDcMYE1/D67dClptRiF47TWvIaiXaD/nFybLCFXXz+87zOcZEGGQkdwlNAitohp7o/jQZAq4+UDBLlsnXMsW3AQ69+xVKFSaZTGWP9KXK+sYUq+I+663bVHNS8k81mF3zm6qcO37xMlrr5CAVZOCBS4zaWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y14Cujcu; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8ff1275-fbc2-4117-9f40-59072e129426@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705615021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvQ4yapkyl0kRiKWuEwjWDWxgTK0FujX1jhdCpgjMDc=;
	b=Y14Cujcucxp+J9RIPRp7TU3XhqW5LOOsX8FNf1SgCztlYYi50HkGT53EhvQRPDNh+j05xt
	FKqwO4CWNOmbeFVpdaopxr5fYBEPKQWmNh+7aUop933ggfNkATW4l1XpJihbFdqNiKTNh6
	3vURVQSr+Pg8kJb1BpEaVixwHAkDtZY=
Date: Thu, 18 Jan 2024 13:56:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v16 08/14] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-9-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240118014930.1992551-9-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0744a1f194fa..ff41f7736618 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20234,6 +20234,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>   	const struct btf_member *member;
>   	struct bpf_prog *prog = env->prog;
>   	u32 btf_id, member_idx;
> +	struct btf *btf;
>   	const char *mname;
>   
>   	if (!prog->gpl_compatible) {
> @@ -20241,8 +20242,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>   		return -EINVAL;
>   	}
>   
> +	btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
> +

just "btf = prog->aux->attach_btf;" which was assigned to bpf_get_btf_vmlinux() 
for the non-module case. Take a look at bpf_prog_load() in syscall.c

