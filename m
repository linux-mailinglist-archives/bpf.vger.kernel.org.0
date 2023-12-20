Return-Path: <bpf+bounces-18390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D181A18C
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 15:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAD8287945
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1E53D967;
	Wed, 20 Dec 2023 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ctwS6xiH"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F053D964
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2yxymCn5n1hGq4kOvfY+oOKucc+MKFQl2MGK3YFmVmQ=; b=ctwS6xiHFoJlsO2BApbEWL9qqN
	zqI1Z4R5CidvyTURNqfvbPY38kKrgPs+o2/SFqPaxDba6DutneyXQh0785K7QYiQ+ktwBzlpT/L+f
	PDjaJWpu/5bvhF16m5YOx8drYv5JkI1UHvZjyhPiPuhUb+4Ezm4Efr/6x6Ih7zodH6Lr2XMt3Af4d
	xpJXoxUJNMLJYJdGvEdtQNQh3NKZz4/68HdGtd6oUoOG844zfEXXP7bY3inkT7FTyuF9jXk/TLSmL
	U5tpI6ba21AUDGqdFl+MmDhf9MFtGFnEaCl80jOwKBIr+ecSjZN9b1Unu/sWdn3p2cG/Y/7Af/TlJ
	LLbaVVqw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFxyD-000Jwh-Jg; Wed, 20 Dec 2023 15:54:49 +0100
Received: from [178.197.249.36] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFxyC-000USJ-R1; Wed, 20 Dec 2023 15:54:48 +0100
Subject: Re: [PATCH bpf-next 0/3] bpf: inline bpf_kptr_xchg()
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231219135615.2656572-1-houtao@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <42d42854-61d4-5379-908a-04892765f85c@iogearbox.net>
Date: Wed, 20 Dec 2023 15:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231219135615.2656572-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27129/Wed Dec 20 10:38:37 2023)

On 12/19/23 2:56 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The motivation for the patch set comes from the performance profiling of
> bpf memory allocator benchmark (will post it soon). The initial purpose
> of the benchmark is used to test whether or not there is performance
> degradation when using c->unit_size instead of ksize() to select the
> target cache for free [1]. The benchmark uses bpf_kptr_xchg() to stash
> the allocated objects and fetches the stashed objects for free. Based on
> the fix proposed in [1], After inling bpf_kptr_xchg(), the performance
> for object free increase about ~4%.

It would probably make more sense if you place this also in the actual
patch as motivation / use case on /why/ it's needed.

> Initially the inline is implemented in do_jit() for x86-64 directly, but
> I think it will more portable to implement the inline in verifier.
> Please see individual patches for more details. And comments are always
> welcome.
> 
> [1]: https://lore.kernel.org/bpf/20231216131052.27621-1-houtao@huaweicloud.com
> 
> Hou Tao (3):
>    bpf: Support inlining bpf_kptr_xchg() helper
>    bpf, x86: Don't generate lock prefix for BPF_XCHG
>    bpf, x86: Inline bpf_kptr_xchg() on x86-64
> 
>   arch/x86/net/bpf_jit_comp.c |  9 ++++++++-
>   include/linux/filter.h      |  1 +
>   kernel/bpf/core.c           | 10 ++++++++++
>   kernel/bpf/verifier.c       | 17 +++++++++++++++++
>   4 files changed, 36 insertions(+), 1 deletion(-)
> 

nit: Needs a rebase.

