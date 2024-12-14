Return-Path: <bpf+bounces-46967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CB99F1B44
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F21D7A04F0
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E48EC0;
	Sat, 14 Dec 2024 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n4N1oCBY"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C114366
	for <bpf@vger.kernel.org>; Sat, 14 Dec 2024 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734135261; cv=none; b=cTEtmlfK+bDCaBjrzM/dofbiChsLPDwasFBIN7BXhP8VBvQtA3OaMeTuCIpHIxBHrATysWewZiP2TQEEBqtaNJOWGGqVUschjJBFlRfUMAlo8rSBLURoHEDTRuZbn0dpXZD8p3+Bc2/68i2iylXfh98BFVxhxfYLqd1C7PyOM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734135261; c=relaxed/simple;
	bh=jYAGYgV2QzgVZgzyJaAliZuzkuC1P4ijjgr0LDq11GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXza14P0ArYeUQIGCU29CKusV7IFBbytZMzNdeGgx2CqqJt7IU74WXp1fc2utvBXh7S3MXM3SIaGQjbaq8sM+ffDKX9shkJmLtlJLKSK7qIIv01vsOEZBZVoRQGNIodMlMP0fmaU0vZiBwVpHHCqSHD1JSPPfHn+ztIyUdlC2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n4N1oCBY; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <14464b87-aaf4-4879-89ae-2006c1024fab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734135257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hGm1A6WsQy1HIgrzcczkWT2uU87XdknA/NOjCfb4Ig=;
	b=n4N1oCBYtgyVQRZpYYXr7E0dkM8BQfIBG2DpLS3txL5bpc7vK0QK4u0rdK8sngNHvp5j4b
	GlMEgkaJ2CzFTMZdnrI1NUplh27xGlIXAxT7mpW0GJMwy7qvfhIpj9tdfEWI+a+0E6C928
	5YRUsrZ+9M+4O6mMhIaRIksgp3PO29c=
Date: Fri, 13 Dec 2024 16:14:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 11/11] bpf: add simple bpf tests in the tx
 path for so_timstamping feature
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-12-kerneljasonxing@gmail.com>
 <65a83b0e-5547-408a-a081-083ffd9d1c91@linux.dev>
 <CAL+tcoDALG5pEXEvhrN4e3AWTi8xO-qOt5nLty55hsDiBaRPrA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoDALG5pEXEvhrN4e3AWTi8xO-qOt5nLty55hsDiBaRPrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 8:02 AM, Jason Xing wrote:
>>> +static u64 delay_tolerance_nsec = 5000000;
>>
>> If I count right, 5ms may not a lot for the bpf CI and the test could become
>> flaky. Probably good enough to ensure the delay is larger than the previous one.
> 
> You're right, initially I set 2ms which make the test flaky. How about
> 20ms? We cannot ensure each delta (calculated between two tx points)
> is larger than the previous one.

or I was thinking the delay is always measured from sendmsg_ns.

Regardless, whatever way the delay of a tx point is measured from (always from 
sendmsg_ns or from the previous tx point), it can also just check the measured 
delay is +ve or something like that instead of having a hard coded maximum delay 
here.

The following "struct delay_info" may not be the best. Feel free to adjust.

>> struct delay_info {
>>          u64 sendmsg_ns;
>>          u32 sched_delay;  /* SCHED_OPT_CB - sendmsg_ns */
>>          u32 sw_snd_delay;
>>          u32 ack_delay;
>> };


