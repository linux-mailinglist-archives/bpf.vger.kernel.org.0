Return-Path: <bpf+bounces-34593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520AE92F062
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 22:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8305C1C21DD8
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 20:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8C19FA79;
	Thu, 11 Jul 2024 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="foTghpf5"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F5913D8B0
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730026; cv=none; b=EAdqjtHQ2kwv8lsy45z/JhgrYc0bjVAauyLlaGJYvHQCTxyuWap4DoWgHLGcHQkJ6AoqOcd/1ASB07LpblBS7+KRBLeaJ0AAcktOqcM31GD/383p5IwOFKdjcF1bsn1VpPqKxdcniOytV9cREyUKi+NLBt3boqswPMJlcrD83Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730026; c=relaxed/simple;
	bh=1ntlBVZaA6nIqfQ0L6ZAA5wpv5JsM6PuyIdSwyncDKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJwfU8JYQUeaSgaccwbN+3byqDrReZ4yv09w40pTfiNYRVUz617aIlgGdz66JPbK/MggC+n8ysXCbA4ZV4o3+y6bnyp5l6Q2K7bgFfcGlYMuEm4J+7DMnhHnauzH+kCSuznB2sd4NNdCgfkUMsIK7D/7ZY/cyyaNXUpt/LWIcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=foTghpf5; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sS0Tq-00ADAS-GF; Thu, 11 Jul 2024 22:33:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=9cd/vhXK716SREp7Lhm7dFiIgMHnwk6lJItzbpojeQ0=; b=foTghpf5CilnhUDxC5iGhBSmqg
	OodOA0hxXaHVQrEpLvRmD88XlQyOK+oqBNNp7KdrVZSThuLStK+ob67onrxQ7XyH7HCkGxLK4DuHU
	mqqmUo07XsiX6p3W4gWb5kn5T1lRbE0lS8j/OKLLj5JfXvXOjvaGR2iW/G5Y++tpzgIMtUewyRrao
	NEebImQj5M0zamHntkkf5Gu47CRbQi+PlquZH38HUTwCQcoomN9al/YDd+F2VsifcioAXdxSfK8Nk
	OC1gjybKKFbYr2iU/en+p93xdU2QZQcVI2RzyKLx9wFajB8KVCLVi/AmpJcWczixOTYJuJuN0DJzu
	0hx966NA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sS0Tp-0000EC-6g; Thu, 11 Jul 2024 22:33:29 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sS0Tf-002COC-Di; Thu, 11 Jul 2024 22:33:19 +0200
Message-ID: <fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
Date: Thu, 11 Jul 2024 22:33:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com
References: <20240707222842.4119416-1-mhal@rbox.co>
 <20240707222842.4119416-3-mhal@rbox.co> <87zfqqnbex.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87zfqqnbex.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/24 11:48, Jakub Sitnicki wrote:
> On Sun, Jul 07, 2024 at 11:28 PM +02, Michal Luczaj wrote:
>> Function ignores the AF_INET socket type argument, SOCK_DGRAM is hardcoded.
>> Fix to respect the argument provided.
>>
>> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
> 
> Thanks for the fixup.
> 
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

Ugh, my commit message is wrong. Change is for socketpair(AF_UNIX), not
inet_socketpair(). Sorry, will fix.

Speaking of fixups, do you want it tagged with Fixes: 75e0e27db6cf
("selftest/bpf: Change udp to inet in some function names")? And looking at
that commit[1], inet_unix_redir_to_connected() has its @type ignored, too.
Same treatment?

[1] https://lore.kernel.org/netdev/20210816190327.2739291-5-jiang.wang@bytedance.com/

