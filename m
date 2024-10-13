Return-Path: <bpf+bounces-41833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E1199BA60
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 18:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8201F21030
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B301147C91;
	Sun, 13 Oct 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="e7zqfddA"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57B13DDB9
	for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728836934; cv=none; b=RUWLBeCXbVMalJWAtCEhNjKULWbe3nzmA/2f0CkMtup7HgT9pMQhE1FkJr9tdQAJRKFl+wZrYJp5Z8vf7t+zUiD49qoZdfx0bLRLRndXJbHpNPSoUv0T6n2O0EeUPGgoUBOq678EsqZDymGC9GrfJ+Doxr9e4I+bxw1xv/jh+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728836934; c=relaxed/simple;
	bh=zLiPBf1YEdBMWFLgK9tV16l3TNMRcCLLAzsO2dxRFso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXSs6QkpzM9BbsOlDTSoxWpZNMTjjVIlejt4qJAqrd/JPfnpbitKvQnqpmI88IRySAQZYY2QPpGlIF5mYbFKaTJaRo2Nyaf10qaeCqiqndpmqTJK6jAu9KGAMW+5WC+qgM2BXJgKZS5Ev0t1nClZq26VdrziGNREoRXwscX8OvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=e7zqfddA; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1t01SY-00CykB-KK; Sun, 13 Oct 2024 18:28:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=+abiPB0rL2pZ7+/1GAhspcsF1eaJlmhqsP9hIzzCSOE=; b=e7zqfddAJi4C4ZnIQZc2m3iGom
	J72T0pJpWIbbKaJjzADBkqD5J8HZasQiwOMRX8f0coD7MmwwQWn6QSmIkB5y4wOc6Jq2gAwHagmJk
	o3NTgGNA6vyFwIJmswayjqtbySvUwG9oceH4SmPp/HnnfwuSw9A6dQCHTJdMPCj45hD/I1h8Lch0T
	DZiS6ntziihlVMdUx5/Muqc5Fbj1GlB0FQy1W8IuQA/FH6WTpJMaCTdUhz35ZShd1gbeiY5Rs9eYv
	8JhldTJL1uAM7ofHTVuEx+rkhfRWTXxMRsFFyD0t0Bv2hseSMuzAskLmcQum14e11RzKwJ7K6QAtn
	ZUSDGs0w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1t01SX-0007Mq-Kx; Sun, 13 Oct 2024 18:28:45 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1t01SK-00DrP9-Ki; Sun, 13 Oct 2024 18:28:32 +0200
Message-ID: <9e886805-36ee-418c-9d75-175599eab6d0@rbox.co>
Date: Sun, 13 Oct 2024 18:28:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf 2/4] vsock: Update rx_bytes on
 read_skb()
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Robert Eshleman ." <bobby.eshleman@bytedance.com>
Cc: bobby.eshleman@gmail.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>
 <20241009-vsock-fixes-for-redir-v1-2-e455416f6d78@rbox.co>
 <mwemnay5bb7ft5zvlrh5emdtkilqvkj42xnxnatnh3hmmtkhce@fqe64sbx6b2z>
 <CALa-AnBQAhpBn2cPG4wW9c-dMq0JXAbkd4NSJL+Vtv=r=+hn2w@mail.gmail.com>
 <cjhxc6sgmufeemnhgsv4prrf5uionxtgadsgwbxajwsljhqwao@3k4nrd2ivvtl>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <cjhxc6sgmufeemnhgsv4prrf5uionxtgadsgwbxajwsljhqwao@3k4nrd2ivvtl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/11/24 10:40, Stefano Garzarella wrote:
> On Thu, Oct 10, 2024 at 05:09:17PM GMT, Robert Eshleman . wrote:
>> On Thu, Oct 10, 2024 at 1:49 AM Stefano Garzarella <sgarzare@redhat.com>
>> wrote:
>>>
>>> The modification looks good to me, but now that I'm looking at it
>>> better, I don't understand why we don't also call
>>> virtio_transport_send_credit_update().
>>>
>>> This is to inform the peer that we've freed up space and it has more
>>> credit.
>>>
>>> @Bobby do you remember?
>>>
>>>
>> I do not remember, but I do think it seems wrong not to.
> 
> Yeah, @Michal can you also add that call?
> 
> For now just call it, without the optimization we did for stream 
> packets, in the future I'll try to unify the paths.

Sure, here is v2:
https://lore.kernel.org/bpf/20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co

Thanks,
Michal


