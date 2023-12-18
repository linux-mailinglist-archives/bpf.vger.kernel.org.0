Return-Path: <bpf+bounces-18215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68D98173EF
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 15:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BEA71C249E9
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE737887;
	Mon, 18 Dec 2023 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HNd3lZ77"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663533A1BB
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=L/0WjEIPOYfAp8r9b1KzU/LxQJE1bU8wE9g+7MPoVj8=; b=HNd3lZ77PUdnHh70xDD4s1Ngq7
	QH3S1nNUll1kl3Z1//jCJPolJqFQKgDsdiTl1+coS6P+9mMqTUZbz0vwOEf8HBSahMx9ykjnmxQNX
	NEpKNwkuvwhiU4WyO0ytUvlqDHUroS8ZpBhnq/Ko0TtFChlqfWMy29j4eUOAxNXrwPH0P7ptjqOR9
	Lo9qhF+VbcuiSD+ozs1NoU6mmF+cnbfTxFfmbXa3jrtZ36RfD5+2jVvnGsXZpX9T9bMW+MHHzzKuL
	KkQ6OpRFWkrxgRbiCWlbJd30qkLAWpVDqJ0n8GIO5j/LmPbGC917KJBXr77CbzTUiGsztodrVYFOW
	VvJwbYbQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFEol-0007Mx-9Y; Mon, 18 Dec 2023 15:42:03 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFEok-000LoG-Pt; Mon, 18 Dec 2023 15:42:02 +0100
Subject: Re: [PATCH bpf-next] bpf: Introduce "volatile compare" macro
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, martin.lau@kernel.org, dxu@dxuuu.xyz,
 memxor@gmail.com, john.fastabend@gmail.com, kernel-team@fb.com
References: <20231217010632.72047-1-alexei.starovoitov@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <020cb6d5-0256-3243-c1ff-404f44f609fc@iogearbox.net>
Date: Mon, 18 Dec 2023 15:42:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231217010632.72047-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27127/Mon Dec 18 10:39:04 2023)

On 12/17/23 2:06 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Compilers optimize conditional operators at will, but often bpf programmers
> want to force compilers to keep the same operator in asm as it's written in C.
> Introduce CMP(var1, conditional_op, var2) macro that can be used as:
> 
> -               if (seen >= 1000)
> +               if (CMP(seen, >=, 1000))
> 
> The macro takes advantage of BPF assembly that is C like.
> 
> The macro checks the sign of variable 'seen' and emits either
> signed or unsigned compare.
> 
> For example:
> int a;
> CMP(a, >, 0) will be translted to 'if rX s> 0 goto' in BPF assembly.

nit: translted

> unsigned int a;
> CMP(a, >, 0) will be translted to 'if rX > 0 goto' in BPF assembly.

ditto

> The right hand side isn't checked yet. The macro needs more safety checks.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
> 
> As next step we can remove all of bpf_assert_ne|eq|... macros.
> Also I'd like to remove bpf_assert_with. Open coding it is imo cleaner.
> 
>   .../testing/selftests/bpf/bpf_experimental.h  | 28 +++++++++++++++++++
>   .../testing/selftests/bpf/progs/exceptions.c  | 20 ++++++-------
>   .../selftests/bpf/progs/iters_task_vma.c      |  3 +-
>   3 files changed, 39 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 1386baf9ae4a..a3248b086e4b 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -254,6 +254,34 @@ extern void bpf_throw(u64 cookie) __ksym;
>   		}									\
>   	 })
>   
> +#define __eauality(x) \
> +	__builtin_strcmp(#x, "==") == 0 || __builtin_strcmp(#x, "!=") == 0

nit: s/__eauality/__equality/ ?

Otherwise, looks good:

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

