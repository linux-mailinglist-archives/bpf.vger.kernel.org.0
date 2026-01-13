Return-Path: <bpf+bounces-78632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F81D1630A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 02:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84C89302573D
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014227E045;
	Tue, 13 Jan 2026 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WAnavtjN"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3FC274B59
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268612; cv=none; b=Ku12VYkjK/qMMk+MD5IJ+jFLHVANGM5G2MIQKp4g/RROZZ9nHcgVJrMgIajSqZY6zleNqixE5+hnv+j1az9/7ssMEUlX5FHqfyqEqEGyi4cfnyCQCMfqw+LvpSS1lWDGe+J/26oWcuSu1YOyToRyLT8ohddmXfQoMoAH4q5DXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268612; c=relaxed/simple;
	bh=AzGYY8TVf6kHgCekFCUzEbv5VDS1oXckWndMM4wUWIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idChCsZB2q35rlTtnNcvb4C9AOTeNWUy5XZ9ZPLlyDR0nnUJajuKbH69NACvPFfBnvqjdW3w01932a6rvj+s7lHi3/EOmGlrpoZ7dUWcr8eBQSl3iiNQ7+vc3+S2xx+dapdOQklFQ1vUZnN5KYGsrmwYjcefPDAtVE+TAUzzIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WAnavtjN; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39acf3ae-031e-41fe-8343-9445775f312c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768268599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HlY+CfNE9yvpYaQbltrehDKBAIWVYvJbFw7ICzfvQHs=;
	b=WAnavtjN1+zzKw4FnoeX0yz4HzyCQ7l3gW29koNOFbo8Zn1rd132wS6VXPuiccj09DukFR
	DQa9tTNenc+jK1CJJX2Rvy95LPOqU7GeSjJIRiLLDmi90sMXRQi4rmbj5Dql2r6uMQ+Qq/
	KB67rxnIDrFeqvIYT0uMhIXiZ3RJ/V0=
Date: Tue, 13 Jan 2026 09:43:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Introduce BPF_BRANCH_SNAPSHOT_F_COPY
 flag for bpf_get_branch_snapshot helper
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Matt Bobrowski
 <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260109153420.32181-3-leon.hwang@linux.dev>
 <202601122013.hmoeIXXs-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <202601122013.hmoeIXXs-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi kernel test robot,

Thanks for the test results.

No further testing is needed for this patch series, as it will not be
pursued further and is not expected to be accepted upstream.

Thanks again for the testing effort.

Thanks,
Leon

On 13/1/26 03:22, kernel test robot wrote:
> Hi Leon,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-x64-Call-perf_snapshot_branch_stack-in-trampoline/20260109-234435
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20260109153420.32181-3-leon.hwang%40linux.dev
> patch subject: [PATCH bpf-next 2/3] bpf: Introduce BPF_BRANCH_SNAPSHOT_F_COPY flag for bpf_get_branch_snapshot helper
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260112/202601122013.hmoeIXXs-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601122013.hmoeIXXs-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601122013.hmoeIXXs-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: undefined symbol: bpf_branch_snapshot
>    >>> referenced by bpf_trace.c:1182 (kernel/trace/bpf_trace.c:1182)
>    >>>               vmlinux.o:(bpf_get_branch_snapshot)
>    >>> referenced by bpf_trace.c:0 (kernel/trace/bpf_trace.c:0)
>    >>>               vmlinux.o:(bpf_get_branch_snapshot)
> 


