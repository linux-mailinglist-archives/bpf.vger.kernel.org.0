Return-Path: <bpf+bounces-18391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F2081A1A9
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 15:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1144A1C241F9
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15663D967;
	Wed, 20 Dec 2023 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="L/p9M8QT"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881833D972
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hNb4GxNHU8POXalAxfqnvMnNR0+gsZIp5Z4DiSkmyFU=; b=L/p9M8QT6qMpiYnC2BE2LCxE93
	RMOxDO0OCO9W/qQD4p5Eb9q/KvEFaY3eIOdZjS7Jlv92BPUcIfEVta+KdOi6p4GRy/XYXDtj9syLx
	MVQIc+2b+UbUcWbYN/S1RjISpVwWDHzNegDVRO1pKudXCbtuy11S1YLFZjm9dxXrjvpvWIHwzyl19
	T5QoOFj2q+RZipz0YpLVW5NKJICIfRSuVmBHBPZBHtUqMT+CuXLCpw1S62es+F6qHuP9RMLvLjF9j
	stfYQ29uvJJT75g6e3hI5TLKFf3i7X8XzJVb/SRzHwBVeXCYof2UavAIIOOsYKFvz5fk1JJwNSaz3
	AumAjxzQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFy29-000KIa-FT; Wed, 20 Dec 2023 15:58:53 +0100
Received: from [178.197.249.36] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFy28-000O8k-LU; Wed, 20 Dec 2023 15:58:52 +0100
Subject: Re: [PATCH bpf-next 2/3] bpf, x86: Don't generate lock prefix for
 BPF_XCHG
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231219135615.2656572-1-houtao@huaweicloud.com>
 <20231219135615.2656572-3-houtao@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7f682450-e165-26a9-1247-ef1440d9b7a2@iogearbox.net>
Date: Wed, 20 Dec 2023 15:58:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231219135615.2656572-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27129/Wed Dec 20 10:38:37 2023)

On 12/19/23 2:56 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> According to the implementation of atomic_xchg() under x86-64, the lock
> prefix is not necessary for BPF_XCHG atomic operation, so just remove
> it.

It's probably a good idea for the commit message to explicitly quote the
Intel docs in here, so it's easier to find on why the lock prefix would
not be needed for the xchg op.

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   arch/x86/net/bpf_jit_comp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index c89a4abdd726..49dac4d22a7b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -990,7 +990,9 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
>   {
>   	u8 *prog = *pprog;
>   
> -	EMIT1(0xF0); /* lock prefix */
> +	/* lock prefix */
> +	if (atomic_op != BPF_XCHG)
> +		EMIT1(0xF0);
>   
>   	maybe_emit_mod(&prog, dst_reg, src_reg, bpf_size == BPF_DW);
>   
> 


