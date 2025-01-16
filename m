Return-Path: <bpf+bounces-49095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C234A142C2
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2C11884F8D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88985236ED1;
	Thu, 16 Jan 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IsdpPYDa"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310423243D
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057856; cv=none; b=T+kbM8sDqZUzm5m11rHabHGvkTS/nicGkPaJAvSK6A5jPj5iTlQEscaai5eUXUPnMhqkWNQvRt/ZMctXt4szzFkV0XsUGJt3w6PLF05OJyPlr5V7xDM82gEqHHF+lf/dTrizapPJsb+iOGxzQMI7zNbCkpPoOijCJURrvAr9YUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057856; c=relaxed/simple;
	bh=5EXta7kpLt5yaegjOlD1OpZbITaQ48ZLPtOl+gI2CcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYw9G5XJHa4a7BtYwq1oMKaeQOiIrZHHtoikjBxCqwOqDxu1z9EUxSNFXbEh7n+dLnxx86EHbxECPaDsKSADSTXEsK0myP37JSpaJXmjQ4xJovv6GeHVVYFRXkdE2s8NCq2QDxhmwwQ0sn8nbMqw7o/5QX+fpIjoLPwS8Ss30TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IsdpPYDa; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9e5b183e-5dd5-4d3d-b3e6-09ad5e7262dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737057840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqHq2Y2jq8JAJpoGQ2hS6bFm7a13DqxW+Q9h4zZv3mo=;
	b=IsdpPYDaUOBchiGdF2FkugelmmyTLLxURio+d0H1pg1c5PtScV4J5PwrMwppVoRFXafxTb
	zTUgqjXhCwANhZNHhwH0fDr24w54IDPTkzDG7HSpOREc+MiosXGjJxuqJjYRdon+03Yvj2
	qaqAhH0PY83dqMjpkii0+1TP5WDwubQ=
Date: Thu, 16 Jan 2025 12:03:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: use attach_btf instead of vmlinux in
 bpf_sk_storage_tracing_allowed
To: Jared Kangas <jkangas@redhat.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@kernel.org,
 ast@kernel.org, johannes.berg@intel.com, kafai@fb.com,
 songliubraving@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250116162356.1054047-1-jkangas@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250116162356.1054047-1-jkangas@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/16/25 8:23 AM, Jared Kangas wrote:
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 2f4ed83a75ae..74584dd12550 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -352,8 +352,8 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
>   
>   static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
>   {
> -	const struct btf *btf_vmlinux;
>   	const struct btf_type *t;
> +	const struct btf *btf;
>   	const char *tname;
>   	u32 btf_id;
>   
> @@ -371,12 +371,12 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
>   		return true;
>   	case BPF_TRACE_FENTRY:
>   	case BPF_TRACE_FEXIT:
> -		btf_vmlinux = bpf_get_btf_vmlinux();
> -		if (IS_ERR_OR_NULL(btf_vmlinux))
> +		btf = prog->aux->attach_btf;
> +		if (!btf)
>   			return false;
>   		btf_id = prog->aux->attach_btf_id;
> -		t = btf_type_by_id(btf_vmlinux, btf_id);
> -		tname = btf_name_by_offset(btf_vmlinux, t->name_off);
> +		t = btf_type_by_id(btf, btf_id);
> +		tname = btf_name_by_offset(btf, t->name_off);
>   		return !!strncmp(tname, "bpf_sk_storage",
>   				 strlen("bpf_sk_storage"));

Thanks for the report.

There is a prog->aux->attach_func_name, so it can be directly used, like:

	case BPF_TRACE_FENTRY:
	case BPF_TRACE_FEXIT:
		return !!strncmp(prog->aux->attach_func_name, "bpf_sk_storage",
				 strlen("bpf_sk_storage"));

The above should do for the fix.

No need to check for null on attach_func_name. It should have been checked 
earlier in bpf_check_attach_target (the "tname" variable).

pw-bot: cr


