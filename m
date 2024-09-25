Return-Path: <bpf+bounces-40310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFCC986025
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 16:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38278289295
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC44318595A;
	Wed, 25 Sep 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="B0GuRjMS"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9213415CD46;
	Wed, 25 Sep 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267877; cv=none; b=c5dNsnGjPb5zSuzgioR26auvsNc80PVC2mR/VB8wP8prXBc4cqmLh5umchGWGDfUSP2Ec6tLAfmaWIi1mxrVd+i0smn4toFsjkpqprmmT+/Wx4lmIOj+7ytVsXF+EjzEGdAhHAej9q2KyLlU56NMsinRonDP6Vq4iqBPuNGoJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267877; c=relaxed/simple;
	bh=yGA4k9fPRkP7UNwjMq/bcpk/wx7MQAsUF0sTAoJLV6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAdmrkj/HA8pHWGo5HTnDwhXOmegBlaLbuli8X9fFHpLT7aoNH36tz0gRoLUg9vFRBnzxPGwOSZuMOcFB4rtrKITktnLPZLdtW4XTTahLPwLAlqq3b2jyL/FGz5FHpAuNX0mATQ6EiZ2cqPha0HbxLXkQXqrgNwtXKBG2ah2Dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=B0GuRjMS; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=77XXD0LA4ebMzrDQBNCHl27giGc0zGFsG6O/kyjKY7c=; b=B0GuRjMSashd8iRo1h/j4+zK0+
	cUYDB0lfz3MKusy39Ke9+5GPmF+GdcYlcVLlMm0HYCqXn/Oh30fiyeEOZZ57PoL2SFaD6d5LHu4Kh
	CyukCpKp82pZQo9iu7nUT15Z4qbPGFtc/CFsdKCnnb2hsohlB2FtZaEHscLH+pL6wsW9uFWBH5UJn
	JrZfLynGrJ7TDjpohdcfMzkcJ5uPimIMpKn/sxxEZJSCuP+SgLqBxD/DE8Oyc5LjaPiMH2FTu9qfT
	NlX2dLO+0qRT93QwajRkzZyXmicoHfbBEWtuoc4y5AsjLDKvqLob34iyPyzMMqhZBHx7DEXsWF5pv
	1B3Tu6lQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1stRH6-000AIM-6U; Wed, 25 Sep 2024 14:37:44 +0200
Received: from [178.197.249.20] (helo=[192.168.1.114])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1stRH5-0004VM-0Y;
	Wed, 25 Sep 2024 14:37:43 +0200
Message-ID: <eebea88a-ebef-4bc7-9859-52820113318d@iogearbox.net>
Date: Wed, 25 Sep 2024 14:37:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] BPF : arch/x86/net/bpf_jit_comp.c : fix wrong condition
 code in jit compiler
To: zyf <zhouyangfan20s@ict.ac.cn>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, dsahern@kernel.org,
 Yonghong Song <yonghong.song@linux.dev>
References: <20240925082332.2849923-1-zhouyangfan20s@ict.ac.cn>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20240925082332.2849923-1-zhouyangfan20s@ict.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27409/Wed Sep 25 11:17:07 2024)

On 9/25/24 10:23 AM, zyf wrote:
> change 'case BPF_ALU64 | BPF_END | BPF_FROM_LE' to 'case BPF_ALU64 | BPF_END | BPF_FROM_BE'
>
> Signed-off-by: zyf <zhouyangfan20s@ict.ac.cn>
> ---
>   arch/x86/net/bpf_jit_comp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa5..7f954d76b3a6 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1786,7 +1786,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>   			break;
>   
>   		case BPF_ALU | BPF_END | BPF_FROM_BE:
> -		case BPF_ALU64 | BPF_END | BPF_FROM_LE:
> +		case BPF_ALU64 | BPF_END | BPF_FROM_BE:
>   			switch (imm32) {
>   			case 16:
>   				/* Emit 'ror %ax, 8' to swap lower 2 bytes */
Please elaborate on the exact issue you've encountered. Right now it looks
like you did this change just based on code review but not based on a real
world bug?

BPF_ALU64 | BPF_END | BPF_FROM_LE instruction is unconditonal swap,
see also commit 0845c3db7bf5c4ceb ("bpf: Support new unconditional bswap 
instruction").
As it stands your change additionally breaks BPF selftests.

