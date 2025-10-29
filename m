Return-Path: <bpf+bounces-72712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8734EC19D5A
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 11:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4074631E9
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563133F8DA;
	Wed, 29 Oct 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYsynUJx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70932C938;
	Wed, 29 Oct 2025 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734008; cv=none; b=iRsENPzVNCA22yKGb+JhPw3icT7BOUuR0X91KSrs1nDOi9Xl680fy4QFWgJAzE2CqtcsNPj6LGDnyn8mHH9skBBybsNlvLmTH59jCe+Y/tPtSwcAUhvErSrZ6LfGE/ETccDTOYox8nL9Y415fd9EwAyPuSFJuqmCBGUb4vV+qO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734008; c=relaxed/simple;
	bh=jW3t4Dky05lPY8vwEMeUV64HgYZv3cbkpNkYWRVtEJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luXjTKC4lUQx0ehPt+bPiMYIbsfa4eGA7uR7+Wz1IrvkZw1VQpgNIZS0hn7HFTVkxY65QGahUWZGE+c4EyRCN/ou+3Q/Sn2hrDG9anHjhPR06x9O3CvZEG1OK4UIrjeDvOcD0fs/rg+MxrysYGCItGkllVuoQIMYacF6TxTD8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYsynUJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7FDC4CEF7;
	Wed, 29 Oct 2025 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761734008;
	bh=jW3t4Dky05lPY8vwEMeUV64HgYZv3cbkpNkYWRVtEJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lYsynUJxVZiUiCsmJM0jypLVG7AcY0ZwK0hhpZtHLY6Gb1fUIUoP24nwcWYogF0rs
	 KotIuWsLPWMrJuCRUnf/UHrSc6uHEHm1jaOrWH3j38g7KeogP0z1LexU8fo4uqXQ37
	 qRJOTW0tRn5kpA0fclgSw3dolaQMxr9fPJR9kKBXDUrQ5AW9BfykY2Mky+tVwWLfpe
	 MseGeTQuouCXLWoRc5ZBeXf6ltgs5io7YwrEocfyMEX+pOjnCCy0EAQANYLGBsk47T
	 BkVKgzR9DB8sJfzHKO822WiHkLJPoRCZLm9f78e9vfGtWmOYu2F3OZwWkmOli3aS5m
	 e7AYebJxPTesA==
Message-ID: <27e74aeb-89f5-4547-8ecc-232570e2644c@kernel.org>
Date: Wed, 29 Oct 2025 11:33:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/2] veth: more robust handing of race to avoid txq
 getting stuck
To: Toshiaki Makita <toshiaki.makita1@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, makita.toshiaki@lab.ntt.co.jp,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com,
 netdev@vger.kernel.org, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553930.5396.4492315010562655785.stgit@firesoul>
 <aacc9c56-bea9-44eb-90fd-726d41b418dd@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <aacc9c56-bea9-44eb-90fd-726d41b418dd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 28/10/2025 15.56, Toshiaki Makita wrote:
> On 2025/10/28 5:05, Jesper Dangaard Brouer wrote:
> 
>> (1) In veth_xmit(), the racy conditional wake-up logic and its memory 
>> barrier
>> are removed. Instead, after stopping the queue, we unconditionally call
>> __veth_xdp_flush(rq). This guarantees that the NAPI consumer is 
>> scheduled,
>> making it solely responsible for re-waking the TXQ.
> 
> Maybe another option is to use !ptr_ring_full() instead of 
> ptr_ring_empty()?

Nope, that will not work.
I think MST will agree.

> I'm not sure which is better. Anyway I'm ok with your approach.
> 
> ...
> 
>> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
>> about to complete (napi_complete_done), it now also checks if the peer TXQ
>> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
>> reschedule itself. This prevents a new race where the producer stops the
>> queue just as the consumer is finishing its poll, ensuring the wakeup 
>> is not missed.
> ...
> 
>> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int 
>> budget)
>>       if (done < budget && napi_complete_done(napi, done)) {
>>           /* Write rx_notify_masked before reading ptr_ring */
>>           smp_store_mb(rq->rx_notify_masked, false);
>> -        if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
>> +        if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
>> +                 (peer_txq && netif_tx_queue_stopped(peer_txq)))) {
> 
> Not sure if this is necessary.

How sure are you that this isn't necessary?

>  From commitlog, your intention seems to be making sure to wake up the 
> queue,
> but you wake up the queue immediately after this hunk in the same function,
> so isn't it guaranteed without scheduling another napi?
> 

The above code catches the case, where the ptr_ring is empty and the
tx_queue is stopped.  It feels wrong not to reach in this case, but you
*might* be right that it isn't strictly necessary, because below code
will also call netif_tx_wake_queue() which *should* have a SKB stored
that will *indirectly* trigger a restart of the NAPI.

I will stare some more at the code to see if I can convince myself that
we don't have to catch this case.

Please, also provide "How sure are you that this isn't necessary?"


>>               if (napi_schedule_prep(&rq->xdp_napi)) {
>>                   WRITE_ONCE(rq->rx_notify_masked, true);
>>                   __napi_schedule(&rq->xdp_napi);
>> @@ -998,6 +992,13 @@ static int veth_poll(struct napi_struct *napi, 
>> int budget)
>>           veth_xdp_flush(rq, &bq);
>>       xdp_clear_return_frame_no_direct();
>> +    /* Release backpressure per NAPI poll */
>> +    smp_rmb(); /* Paired with netif_tx_stop_queue set_bit */
>> +    if (peer_txq && netif_tx_queue_stopped(peer_txq)) {
>> +        txq_trans_cond_update(peer_txq);
>> +        netif_tx_wake_queue(peer_txq);
>> +    }
>> +
>>       return done;
>>   }
> 
> -- 
> Toshiaki Makita


