Return-Path: <bpf+bounces-34021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C191B929A23
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 01:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4981C20971
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 23:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A12B6F30C;
	Sun,  7 Jul 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="DfyPwl5T"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57E18059
	for <bpf@vger.kernel.org>; Sun,  7 Jul 2024 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720393855; cv=none; b=NS5aY9NZED+7faC4JR5iqhDCzcJzWNo93wfFDJ/zWl9SBTVBZOhWd5e1cN5PqCU0xY1OiVXk7/rG8RrLLMCvkGwxjyjlTSOhu6E6iy9QkAp7JSK/LhiB5qrXSTPuJRsSOROuBpjfE3rq03/isUYO4olNWEFD0OYcFopJCogaF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720393855; c=relaxed/simple;
	bh=O5o/eP4LgGugCxbHwEZDgcxUBVbVn9HGYGyiaGL9Cjg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jgI5aaNXu4OmX8+2Iun1hwCS2La/awnW9v8R6gwf83s8QeBrFtOO6A9PqjmH8JtXp6AIfg2TSBG31E2U3vsIGpWloNAabuWwWv1tJDQr3IooIjHNP4KADSQujeYyzOmH4/a6N0333ceeqrlZskODnTOJL5HqneAQPLVVya35EEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=DfyPwl5T; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sQb1r-00Eua1-T2; Mon, 08 Jul 2024 01:10:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=3qVjd2mndo9/JcAYjbDgkzf53A6FUdmQfE9RK1JjNJQ=; b=DfyPwl5TB74RXrOvRndiUvZpGs
	kJ7tHTfcY+b4DF82ZCZ1a3xpfAl4r1WFYzORAd9biRIFAjr3o4SE500yrALRf1gBTM/wBl3UEhLRm
	By25759yAHEd5Q+/E38q+mLkvfhCQokxiiNsjqGTVMKUcmNx77uQpY14LnCcZYvPqwL46XzGodr0g
	79/gCPCQrR/YopDrrCqm+xSqkNPqi8tAQCWnvteme5PAiTcFC620oMFa8J1MY3o1duwTQ4YNJTYYX
	Iak/MHJ8cTghVnzcN9pwrIuFJc5H53iSkpTdwxv9SgqtENmqtfBX8VefMG/OQmmfhIhdEFztSwM7L
	ckA1N0HA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sQb1q-0006Vi-PH; Mon, 08 Jul 2024 01:10:46 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sQb1m-00C8Gs-Ba; Mon, 08 Jul 2024 01:10:42 +0200
Message-ID: <8820c332-53e9-4d8d-99a1-3e8b1aad188b@rbox.co>
Date: Mon, 8 Jul 2024 01:10:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v2] af_unix: Disable MSG_OOB handling for sockets in
 sockmap/sockhash
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 Cong Wang <cong.wang@bytedance.com>
References: <20240622223324.3337956-1-mhal@rbox.co>
 <874j9ijuju.fsf@cloudflare.com>
 <2301f9fb-dab5-4db7-8e69-309e7c7186b7@rbox.co>
 <87tthej0jj.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <87tthej0jj.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/24 09:40, Jakub Sitnicki wrote:
> On Wed, Jun 26, 2024 at 12:19 PM +02, Michal Luczaj wrote:
>> On 6/24/24 16:15, Jakub Sitnicki wrote:
>>> On Sun, Jun 23, 2024 at 12:25 AM +02, Michal Luczaj wrote:
>>>> AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
>>>> with an `oob_skb` pointer. BPF redirecting does not account for that: when
>>>> an OOB packet is moved between sockets, `oob_skb` is left outdated. This
>>>> results in a single skb that may be accessed from two different sockets.
>>>>
>>>> Take the easy way out: silently drop MSG_OOB data targeting any socket that
>>>> is in a sockmap or a sockhash. Note that such silent drop is akin to the
>>>> fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
>>>>
>>>> For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
>>>>
>>>> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>> ---
>>>
>>> [+CC Cong who authored ->read_skb]
>>>
>>> I'm guessing you have a test program that you're developing the fix
>>> against. Would you like to extend the test case for sockmap redirect
>>> from unix stream [1] to incorporate it?
>>>
>>> Sadly unix_inet_redir_to_connected needs a fix first because it
>>> hardcodes sotype to SOCK_DGRAM.
>>
>> Ugh, my last two replies got silently dropped by vger. Is there any way to
>> tell what went wrong?
> 
> Not sure if it was vger or lore archive. Your reply hit my inbox but is
> nowhere to be found in the archive:> [...]

24h later mailer daemon revealed that my SMTP server got (temporarily) on
the Spamhaus Blocklist. Oh well.

>> So, again, sure, I'll extend the sockmap redirect test.
> 
> Appreciate the help with adding a regression test, if time allows.
> Fixes are of course very welcome even without them.

No problem, fix along with the test sent. Let me know what you think.

>> And regarding Rao's comment, I took a look and I think sockmap'ed TCP OOB
>> does indeed act the same way. I'll try to add that into selftest as well.n
> 
> Right, it does sound like we're not clearing the offset kept in
> tcp_sock::urg_data when skb is redirected.

Yeah, so I also wanted to extend the TCP's redir_to_connected(), but is
that code correct? It seems to be testing REDIR_INGRESS, yet
prog_stream_verdict() doesn't run bpf_sk_redirect_map() with the
BPF_F_INGRESS flag.

Thanks,
Michal

