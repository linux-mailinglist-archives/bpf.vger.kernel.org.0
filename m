Return-Path: <bpf+bounces-45602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF49D8F2E
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 00:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D2F2B27246
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 23:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D71922F3;
	Mon, 25 Nov 2024 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I7XBtWgo"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18015575D
	for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732577557; cv=none; b=deMWIDiun+5lVta6KfGeuNWFKCE9namoLbP8G4a1X8hItwQbxu+Wk1hNlQBxh8rTWPcDsvCii5v4UElAFOdGmyLlhvev/+ySCwCB7a5i2EKd67McJECZ8XugIq6LoLjxxn97fc9jmDURFwqiGHAxQtUUtDgb3KxuqNl+5XFl4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732577557; c=relaxed/simple;
	bh=LNccCELnCrrqGQYbKuoIRwN1z+f7ffZ07hvTsR886aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quTlGM/FcAbpfCNVlRR+tRuJt2jW3T5aMsIZjk+YKf4n+FSd3yVCfBd3Z2b+jIF0aZKA1iwpKalMc5gXQZ98Kc7zmblaXJBtieFveewSX1NRoxTJ19jUqMPrKPFG2pXyGSZeNFFBEDtFC5mplDhm1/w+UWBmpchBwHsVBuoMcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I7XBtWgo; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c96fe7a8-8512-48e8-b253-d5ff8a0f4755@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732577553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42xw4Y/QgzVishOExotOvnZ6629ZtF3nEkWEZ8DaPJ8=;
	b=I7XBtWgoi21uPDExAyXxP3I5eIHuuliAfUq7hNhg/Cq/gcVONaqN7oQbH45zuQNMGiQuwp
	ItBqM/JLGbbqmeYf0NyXLG+LNdZH4RjmrNSCS4iw+ujSERgIE1oGF1gXp3rDWV+JYpGJRP
	HJHchJs3puUNxIPSmMu6+FzGwU6MEy4=
Date: Mon, 25 Nov 2024 15:32:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/4] bpf/selftests: add simple selftest for
 bpf_smc_ops
To: Zhu Yanjun <yanjun.zhu@linux.dev>, "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, dtcccc@linux.alibaba.com
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
 <1729737768-124596-5-git-send-email-alibuda@linux.alibaba.com>
 <8c06240b-540b-472f-974f-d2db80d90c22@linux.dev>
 <e8ba7dc0-96b5-4119-b2f6-b07432f65fdb@linux.alibaba.com>
 <0a8c2285-29c2-4a79-b704-c2baeac90b70@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <0a8c2285-29c2-4a79-b704-c2baeac90b70@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/25/24 2:52 AM, Zhu Yanjun wrote:
>>> # ./test_progs -t smc
>>> #27/1    bpf_smc/load:OK
>>> #27      bpf_smc:OK
>>> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>>>
>>> The above command is based on several kernel modules. After these dependent 
>>> kernel modules are loaded, then can run the above command successfully.

>>
>> This is indeed a problem, a better way may be to create a separate testing 
>> directory for SMC, and we are trying to do this.
> 
> Got it. In the latest patch series, if a test program in sample/bpf can verify 
> this bpf feature, it is better than a selftest program in the directory tools/ 
> testing/selftests/bpf.
> 
> I delved into this selftest tool. It seems that this selftest tool only makes 
> the basic checks. A test program in sample/bpf can do more.

sample(s)/bpf? No new test should be added to samples/bpf which is obsolete. The 
bpf CI only runs tests under selftests/bpf.

There is selftests/bpf/config to tell the bpf CI about what kconfig needs to 
turn on.


