Return-Path: <bpf+bounces-62979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4B3B00C1C
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 21:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29EB4E64B1
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 19:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350372FCE1A;
	Thu, 10 Jul 2025 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d7rQXUfD"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CED2741C6
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175727; cv=none; b=YxugJVd4yPXldagLxOwu5VVkkPBR2oVZ4RReg21Jpqpz3xfHoOp5QKrJjZcRfFKDnz9PmyeL+SPbpUN9bZv4bj6Fha+AScXshHW3keF/qMWuQRFb4XuXTaE/gw4ozZv4yPLCie2+b39MZ6YETukLEmWwZBuU9mPT/huYijVH7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175727; c=relaxed/simple;
	bh=zVY+b+S3n4ZG/VFQuk9CCHdsoYZhdESMhk1/PEdkPkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+unl6FA2gL4UkK5Eas0abWSWohtcCui+uholyxrPGZ/SvThkWqN/2u+V7k7DeRpan2exoA+qGSGypqbBR8VAMTrsiDsoWyZgfVsYuxWMYl3UgWU5SLNgOq/uD1+kepVPa36isUVEUuBEUBoT5GpByZaDp8EABIV84dMhp2ljq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d7rQXUfD; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f914d8c1-0e87-43ed-b5af-7dba776d76ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752175712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACTscg3Et5oSzAHLPse1wLZeVGYcH/Kg//tzct6pHZg=;
	b=d7rQXUfD2003WoGYkXZLWvLwPNSf/hlDrfer7J9b923go4i2+nHS+gyiz4APmjFIxxXhbv
	5Dl2sK8bjiuEAaJw56AKlttRg8PNqkyUUTcb0VThOrnYfiQX8NeCe1UgkABBWms0R0lLMp
	R/sWE1JAkabikstNzp0k9Kay+ND1700=
Date: Thu, 10 Jul 2025 12:28:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/1] selftests/bpf: fix implementation of
 smp_mb()
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: bpf@vger.kernel.org, lkmm@lists.linux.dev
References: <20250710175434.18829-1-puranjay@kernel.org>
 <20250710175434.18829-2-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250710175434.18829-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/10/25 10:54 AM, Puranjay Mohan wrote:
> As BPF doesn't include any barrier instructions, smp_mb() is implemented
> by doing a dummy value returning atomic operation. Such an operation
> acts a full barrier as enforced by LKMM and also by the work in progress
> BPF memory model.
>
> If the returned value is not used, clang[1] can optimize the value
> returning atomic instruction in to a normal atomic instruction which
> provides no ordering guarantees.
>
> Mark the variable as volatile so the above optimization is never
> performed and smp_mb() works as expected.
>
> [1] https://godbolt.org/z/qzze7bG6z

You are using llvm19 in the above godbolt run.
But from llvm20, instead of 'lock ...' insn, 'atomic_fetch_or'
will be generated so barrier semantics will be preserved.

Since CI is using llvm20, so we should not have any problem.
But for llvm19 or lower, the patch does fix a problem for arm64 etc.
So in case that maintainer agrees with this patch, my ACK is below:

   Acked-by: Yonghong Song <yonghong.song@linux.dev>
   

>
> Fixes: 88d706ba7cc5 ("selftests/bpf: Introduce arena spin lock")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   tools/testing/selftests/bpf/bpf_atomic.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
> index a9674e544322..c550e5711967 100644
> --- a/tools/testing/selftests/bpf/bpf_atomic.h
> +++ b/tools/testing/selftests/bpf/bpf_atomic.h
> @@ -61,7 +61,7 @@ extern bool CONFIG_X86_64 __kconfig __weak;
>   
>   #define smp_mb()                                 \
>   	({                                       \
> -		unsigned long __val;             \
> +		volatile unsigned long __val;    \
>   		__sync_fetch_and_add(&__val, 0); \
>   	})
>   


