Return-Path: <bpf+bounces-40296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185F1985736
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0729E1C20E92
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E315B55E;
	Wed, 25 Sep 2024 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PeLyz8eX"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482331304AB;
	Wed, 25 Sep 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260345; cv=none; b=nE2UXX4jbsGz6zDm9TaX/OxEMrmYeRZUSIucp/KXM5oasn6qkaOVfLie4yKboJjlN2X2aUFqgRzRvQLkDRMYJLK9TGns19I+MKNdc3y9smv5b5oEXYrrq3fBVxcOZA1St8tn3Xlj5Pz/s3pKo1tp8DRrKyY+6YTIptf9PNN0ArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260345; c=relaxed/simple;
	bh=PEjdN1B8+nauzasTx+oZo2a/P2fqeXtD5HkfhxXmZEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2hwIHsc6gHFcV6UbOAsbaWB4PNYyhqKx9Fn5XGhmxSnJs+BeEHAV1YwQA3tekVatfM6rHJpM2ARkkncnJvba65KoaNESdJ0SJq9jC2DeprJ2KCf4IiG/XMMYDx0GMnE2Z4v4xiPxhHZS/JQxCt1MRLcAxpE9SVxAOcGPnvZvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PeLyz8eX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kcWlSC0R569rA7S9bQRoeCCxWKeeKW+3l2wH6VkxOIk=; b=PeLyz8eXctSFlPP0aizM/oPEO0
	SQsf2XpAFd0oVtamcxXWsRL7XtJVaLDkv+RyExATR/ACYKZBYaf12660ipQLEZEObBVrSMHMGDG3k
	9YDnjW3Oty/21rXYE9VPmxUl3I+JyrK7aBZWdCDnzkt7v9fKg6ySQSdN0DKC6guMOnN+UBhQtIuxZ
	jPilQ4gjByTZare0td9Q7r5ueZd7KmIstMNediInPjl4ebbpO1LkD9Coub0OA9ciDEaPfoIR+Dm9S
	8j1yEKUqPQ5HTU4SzNeTsDiP6FNO147sB/BdQt7cdq8rUdJafpB+Pi//mVM/bwW3EGZlIndfW+fxP
	B7C33xxA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1stPJk-000FNr-U2; Wed, 25 Sep 2024 12:32:20 +0200
Received: from [178.197.249.20] (helo=[192.168.1.114])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1stPJk-000NDC-2I;
	Wed, 25 Sep 2024 12:32:20 +0200
Message-ID: <4f58b093-ca1f-426a-8102-4b00ccaf4973@iogearbox.net>
Date: Wed, 25 Sep 2024 12:32:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Remove llvm-strip from Makefile
To: patchwork-bot+netdevbpf@kernel.org, Tao Chen <chen.dylane@gmail.com>
Cc: qmo@kernel.org, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240924165202.1379930-1-chen.dylane@gmail.com>
 <172725782851.519668.2924142510144708471.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <172725782851.519668.2924142510144708471.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27409/Wed Sep 25 11:17:07 2024)

On 9/25/24 11:50 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Daniel Borkmann <daniel@iogearbox.net>:
>
> On Wed, 25 Sep 2024 00:52:02 +0800 you wrote:
>> As Quentin and Andrri said [0], bpftool gen object strips
>> out DWARF already, so remove the repeat operation.
>>
>> [0] https://github.com/libbpf/bpftool/issues/161
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Suggested-by: Quentin Monnet <qmo@kernel.org>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>>
>> [...]
I'll toss this shortly from the tree again, this missed that bpftool gen 
object call
needs to strip out dwarf.
>> Here is the summary with links:
>>    - [bpf-next] bpftool: Remove llvm-strip from Makefile
>>      https://git.kernel.org/bpf/bpf-next/c/25bfc6333e32
>>
>> You are awesome, thank you!

