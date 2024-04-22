Return-Path: <bpf+bounces-27440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB878AD124
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47401B23E16
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87915350C;
	Mon, 22 Apr 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="D5ZO+q3J"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA9502A8;
	Mon, 22 Apr 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800683; cv=none; b=emtNONyYZ1hMc6nfvluhYjsyHJmm6Jl9lFUKFwU3PAwkylQdm8BzAE7CkODOZUE7Pkw2rPzp1Str+eUSv/jZC64zwr3liIwzqL6pTu9HgDKJPcdVKr+BzQFW3J1iA2w8WDR3xcHP1SyOO6F2Fz+uPFxx2M+M4j35VR2LNz7NJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800683; c=relaxed/simple;
	bh=l7rKs3ixCXKoOcLYDLGrz2HItxbwWthaFHvLrLBduNU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BOVzY7DeGt3YUTHT6sHsqYGgIKKPKmDv4ZSaZ76x2LOhn/vEn56vYS69jiC34IrDXrk5DUeMoPIv+2yTO3syZHYBiUG+oVJSQwM5Q1sS/MibMkoOY6SBpfjhEf3sq/0USLoxnGs9kmiZg9ihfatnx7ShdAMVb+C2Z7MruWJZzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=D5ZO+q3J; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=e2lT5/1rajezrWimLTKtgygjXyrCQCa/wvH4yM38h4w=; b=D5ZO+q3JfddXpR/n0E4yEf686f
	UMvNuV5qbGRKT3s4w9jIkx2DIkUO0bUSK52NWa/XKL0Eb24J+DPCFeFlO6HmVTdT7ih0Y2HzQXCdZ
	HWVO+ymTTCpWLi4LGl2KcXMF9EJYtHJkBBbFuQZMEOn4ytEG8k7uHHMSqe6JGrmMx2fbSNedNsA18
	4GOyroYcVXr49KJQXMpvRGILktAOu46K1rTq4rFssJV2BanYYQWPOYT0+JZ06l0MHj1g4D1cYC04b
	bCSI7BZpoWP09gc4M7x369Xts+D9bPKd16l82ULyG4nJn2o994JrLU26HPiQ0jw0347W0aS+YUW79
	x/Af/gKw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ryvqE-000CQk-99; Mon, 22 Apr 2024 17:44:26 +0200
Received: from [178.197.248.40] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1ryvqD-000AeN-0p;
	Mon, 22 Apr 2024 17:44:25 +0200
Subject: Re: [PATCH] bpf: verifier: allow arrays of progs to be used in
 sleepable context
To: Benjamin Tissoires <bentiss@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7344022a-6f59-7cbf-ee45-6b7d59114be6@iogearbox.net>
Date: Mon, 22 Apr 2024 17:44:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27253/Mon Apr 22 10:25:51 2024)

On 4/22/24 9:16 AM, Benjamin Tissoires wrote:
> Arrays of progs are underlying using regular arrays, but they can only
> be updated from a syscall.
> Therefore, they should be safe to use while in a sleepable context.
> 
> This is required to be able to call bpf_tail_call() from a sleepable
> tracing bpf program.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> Hi,
> 
> a small patch to allow to have:
> 
> ```
> SEC("fmod_ret.s/__hid_bpf_tail_call_sleepable")
> int BPF_PROG(hid_tail_call_sleepable, struct hid_bpf_ctx *hctx)
> {
> 	bpf_tail_call(ctx, &hid_jmp_table, hctx->index);
> 
> 	return 0;
> }
> ```
> 
> This should allow me to add bpf hooks to functions that communicate with
> the hardware.

Could you also add selftests to it? In particular, I'm thinking that this is not
sufficient given also bpf_prog_map_compatible() needs to be extended to check on
prog->sleepable. For example we would need to disallow calling sleepable programs
in that map from non-sleepable context.

>   kernel/bpf/verifier.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 68cfd6fc6ad4..880b32795136 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18171,6 +18171,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>   		case BPF_MAP_TYPE_QUEUE:
>   		case BPF_MAP_TYPE_STACK:
>   		case BPF_MAP_TYPE_ARENA:
> +		case BPF_MAP_TYPE_PROG_ARRAY:
>   			break;
>   		default:
>   			verbose(env,
> 
> ---
> base-commit: 735f5b8a7ccf383e50d76f7d1c25769eee474812
> change-id: 20240422-sleepable_array_progs-e0c07b17cabb
> 
> Best regards,
> 


