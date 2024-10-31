Return-Path: <bpf+bounces-43630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFAE9B7436
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 06:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D817B2246F
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 05:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9AB13D899;
	Thu, 31 Oct 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZEkY/Y+Y"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5D8C07
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730353955; cv=none; b=lhzXESOJWZevloYTyH3E03dSV/XUTWsvcVqO7n0dpYjf6yVOFPxnc1ftsN5aZnEn5lp3pVdQnv/HzNqeGihPrzQf3UoCFzDOIGVPhy47oQ+ogv74ZpbMKQyi0uunU+E1o1iIUsMNRbqCCZw3dfSyI3AjNtVL/Luplx+Dmb0H6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730353955; c=relaxed/simple;
	bh=eb/Z+/PJPgqn+QYmOhrs4q7OX4CSFr+nl1U5dZAUVWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7VfMBQ7luXclLD2qDgztGhhfZdoHBGJX+ZFMHpKcG0Vv1fK/Df0mklwtl7rD7Jn0fNe/dQqajuu0/CwSvD4K4N7R/DDw768kqnqQgvSmha3/nK93coVeJ/Ftx2+S/AL0toUVTlXvtgHUHmBVO8NBo/1SeCQjye6ikatqGx4BQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZEkY/Y+Y; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b4392ce-b10d-4103-b592-2ab7a624cae7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730353950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjKR+byc94vFsnGXdjHCMCmRRxvS/mNAdBdhq8QzfaM=;
	b=ZEkY/Y+Y8yCOan0jFxFOLFGe0TvTQUkRsvX2ZWXQ6I5ecEPwikeojpiBPwWKwA6iS/iAQm
	JjoiHfwFLTctWKT33iolmilHQTw7oJAGjNJ5rX4AGHKeMSinYuLFl7rW9f+bWDni7kmL1+
	E0myQd2R1d9sWffHe1XNEP9+X3YmjFk=
Date: Wed, 30 Oct 2024 22:52:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com>
 <8fd16b77-b8e8-492c-ab69-8192cafa9fc7@linux.dev>
 <CAL+tcoBNiZQr=yk_fb9eoKX1_Nr4LuDaa1kkLGbdnc=8JNKnNg@mail.gmail.com>
 <e56f78a9-cbda-4b80-8b55-c16b36e4efb1@linux.dev>
 <CAL+tcoDi86GkJRd8fShGNH8CgdFu3kbfMubWxCLVdo+3O-wnfg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoDi86GkJRd8fShGNH8CgdFu3kbfMubWxCLVdo+3O-wnfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/30/24 7:41 PM, Jason Xing wrote:

>> All that said, while looking at tcp_tx_timestamp() again, there is always
>> "shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;". shinfo->tskey can be
>> used directly as-is by the bpf prog. I think now I am missing why the bpf prog
>> needs the sk_tskey in the sk?
> 
> As you said, tcp seqno could be treated as the key, but it leaks the
> information in TCP layer to users. Please see the commit:

I don't think it is a concern for bpf prog running in the kernel. The sockops 
bpf prog can already read the sk, the skb (which has seqno), and many others.

The bpf prog is not a print-only logic. Only using bpf prog to do raw data 
dumping is not fully utilizing its capability, e.g. data aggregation. The bpf 
prog should aggregate the data first which is to calculate the delay here.


