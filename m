Return-Path: <bpf+bounces-28775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A24D8BDF30
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08E41F22CAB
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917514EC48;
	Tue,  7 May 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw0UJA1G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795514EC43
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075913; cv=none; b=WcmyuKsWfp3RwnGcLwkQ4gq5yRbhvSwiDEU5yN8jM7sNJ1KaNeEbOqqQixZ/TaaTzzc903hBrNmb8ZSgGZsAfOk9OC6NOhXhKmFx1XORHQ8ozjbmXWGIj4i800kM4aVaGnp/CJuqemN42UzvC6r9DAGwh3vkfhi4IjZMMWBwwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075913; c=relaxed/simple;
	bh=4G34gv/aHq2/Cq2qYsNFrMjdbVHMVm1Dc8yvrzJjOBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojhaAw5zGFPVVZVFnh/HHrhei08YBmnTsMf9Db3g+nydrUS/CPdAQg0ya/LOR7FkeixdWbSJQDfdAp6Rrm+ItmR3H/DaUGArslpSoU9mUsdPqJD9hxiYcxrtTXNPiruFYgvrXeW5sqkebjwttXrxTRYMCx0drDN9dOeh2HALkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw0UJA1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C50C2BBFC;
	Tue,  7 May 2024 09:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715075912;
	bh=4G34gv/aHq2/Cq2qYsNFrMjdbVHMVm1Dc8yvrzJjOBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bw0UJA1G4xsYNMaCGFTpa882SRhECMmDsseUX8SvayQzQ+jfR84Vr7luev5GO6rnq
	 hL8XE+8Cifk7D7b6d2oiQt0uAZbKvTMcZ+V/rn1FiYHhmWQ0RlVGFJkAegjY28PhqE
	 RgxsmvTaQSrTQE84+80QlHOMF6P0KM01fXrAE3fSLLFYMRRS4Zaoeu8k9DJKerYz9E
	 9Fa1D3HFXhPTuqAu1bE21Gyry63fOi7zVLQ797/KacRVwGQJscLbYpfMevZNkOMk8S
	 /6sOGRd+TSAfHA06B6TG6N57uYWVXdcGnU4CW/XTDEq4HhHq4GQ8yFHxXsCu3q/Uyd
	 UX/fbhjDlWguw==
Date: Tue, 7 May 2024 15:22:08 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, "Paul E. McKenney" <paulmck@kernel.org>, bpf@vger.kernel.org, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Michael Ellerman <mpe@ellerman.id.au>, Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH bpf] riscv, bpf: make some atomic operations fully ordered
Message-ID: <zdyarsgcnk6fwiqg7ir3e7m5vggchd77vlac2bkstkenenplam@i4ecorifshni>
References: <20240505201633.123115-1-puranjay@kernel.org>
 <mb61p34qvq3wf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61p34qvq3wf.fsf@kernel.org>

Hi Puranjay,

On Sun, May 05, 2024 at 10:40:00PM GMT, Puranjay Mohan wrote:
> Puranjay Mohan <puranjay@kernel.org> writes:
> 
> > The BPF atomic operations with the BPF_FETCH modifier along with
> > BPF_XCHG and BPF_CMPXCHG are fully ordered but the RISC-V JIT implements
> > all atomic operations except BPF_CMPXCHG with relaxed ordering.
> 
> I know that the BPF memory model is in the works and we currently don't
> have a way to make all the JITs consistent. But as far as atomic
> operations are concerned here are my observations:
> 
...
> 
> 
> 3. POWERPC
>    -------
> 
> JIT is emitting all atomic instructions with relaxed ordering. It
> implements atomic operations using LL and SC instructions, we need to
> emit "sync" instructions before and after this sequence to make it
> follow the LKMM. This is how the kernel is doing it.

Indeed - good find!

> 
> Naveen, can you ack this? if this is the correct thing to do, I will
> send a patch.

Please do.


Thanks,
Naveen


