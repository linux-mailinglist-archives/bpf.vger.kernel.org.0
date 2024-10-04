Return-Path: <bpf+bounces-40912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDFF98FC9C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 06:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F808283D35
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 04:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7754C618;
	Fri,  4 Oct 2024 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NlSWV+zG"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713A1B963
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728014433; cv=none; b=d0TVmvYDMW6mPJckPX9rcp08BSB3wx1Gb67oS5I+7ED/bJJ9umZbdAp3ZEw89qAgZgGoW6fU8UYMfixApYSDmSOIHKkAuC0dVcHDhp22SW8KDaa/3cOCyrY7i8JMke8SSw4bFu13LTog0NY1gMcnHToqll624QX2NaHWSvitiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728014433; c=relaxed/simple;
	bh=3Z7c/wBfN2zeA3acuNBiKHtvX5WGERkpd4FWQk2H9BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOX/BZFDr7OeVLK/pK69agzV0xc+sP2KjrCe0zPundnFrMZEHwslvOpMatwapRIXeNgUcokR6sf/Rd2Q6ZP0IN9iKpvB6W4SA0+9T1PQz0OqdeBgwZg+wtT9OHp+u6KV7m2eHSR9eAqMEJ32AjLVExPeSpXMEujrWJa49NT9vzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NlSWV+zG; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <341af7e1-7817-4aca-97dc-8f2813a086df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728014428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNQRCxMBz5ZWdzX3UDIe7nauhj263vm6VCZvYNip50E=;
	b=NlSWV+zGCTyP4Pqc7/XWPASsNMjkm4WkxEKNmbiLzgDsVBcrzRA0suPyrZ50sCDpSVqPFn
	xJZI38QpnkLr7er5lhWFgTFhg5Xe+GBVzq+cy5OdcVnvmYnFHpzQpOb6aieKVs/w0xCOeZ
	s/jGVGgMHbCXF1BqQI7Dpc5id3JrNsQ=
Date: Thu, 3 Oct 2024 21:00:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Question]: A non NULL req->sk in tcp_rtx_synack. Not a fastopen
 connection.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org
References: <eb6684d0-ffd9-4bdc-9196-33f690c25824@linux.dev>
 <20241004020255.36532-1-kuniyu@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241004020255.36532-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/3/24 7:02 PM, Kuniyuki Iwashima wrote:
> From: Martin KaFai Lau <martin.lau@linux.dev>
> Date: Thu, 3 Oct 2024 18:14:09 -0700
>> Hi,
>>
>> We are seeing a use-after-free from a bpf prog attached to
>> trace_tcp_retransmit_synack. The program passes the req->sk to the
>> bpf_sk_storage_get_tracing kernel helper which does check for null before using it.
>>
>> fastopen is not used.
>>
>> We got a kfence report on use-after-free (pasted at the end). It is running with
>> an older 6.4 kernel and we hardly hit this in production.
>>
>>   From the upstream code, del_timer_sync() should have been done by
>> inet_csk_reqsk_queue_drop() before "req->sk = child;" is assigned in
>> inet_csk_reqsk_queue_add(). My understanding is the req->rsk_timer should have
>> been stopped before the "req->sk = child;" assignment.
> 
> There seems to be a small race window in reqsk_queue_unlink().
> 
> expire_timers() first calls detach_timer(, true), which marks the timer
> as not pending, and then calls reqsk_timer_handler().
> 
> If reqsk_queue_unlink() calls timer_pending() just before expire_timers()
> calls reqsk_timer_handler(), reqsk_queue_unlink() could miss
> del_timer_sync() ?

This seems to explain it. :)

Does it mean there is a chance that the reqsk_timer_handler() may rearm the 
timer again and I guess only a few more synack will be sent in this case and 
should be no harm?

> 
> ---8<---
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 2c5632d4fddb..4ba47ee6c9da 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1045,7 +1045,7 @@ static bool reqsk_queue_unlink(struct request_sock *req)
>   		found = __sk_nulls_del_node_init_rcu(sk);
>   		spin_unlock(lock);
>   	}
> -	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
> +	if (del_timer_sync(&req->rsk_timer))

It seems the reqsk_timer_handler() will also call reqsk_queue_unlink() through 
inet_csk_reqsk_queue_drop_and_put(). Not sure if the reqsk_timer_handler() can 
del_timer_sync() itself.

>   		reqsk_put(req);
>   	return found;
>   }
> ---8<---
> 
> 
>>
>> or there are cases that req->sk is not NULL in the reqsk_timer_handler()?
>>
>> BUG: KFENCE: use-after-free read in bpf_sk_storage_get_tracing+0x2e/0x1b0
>>
>> Use-after-free read at 0x00000000a891fb3a (in kfence-#1):
>> bpf_sk_storage_get_tracing+0x2e/0x1b0
>> bpf_prog_5ea3e95db6da0438_tcp_retransmit_synack+0x1d20/0x1dda
>> bpf_trace_run2+0x4c/0xc0
>> tcp_rtx_synack+0xf9/0x100
>> reqsk_timer_handler+0xda/0x3d0
>> run_timer_softirq+0x292/0x8a0
>> irq_exit_rcu+0xf5/0x320
>> sysvec_apic_timer_interrupt+0x6d/0x80
>> asm_sysvec_apic_timer_interrupt+0x16/0x20
>> intel_idle_irq+0x5a/0xa0
>> cpuidle_enter_state+0x94/0x273
>> cpu_startup_entry+0x15e/0x260
>> start_secondary+0x8a/0x90
>> secondary_startup_64_no_verify+0xfa/0xfb
>>
>> kfence-#1: 0x00000000a72cc7b6-0x00000000d97616d9, size=2376, cache=TCPv6
>>
>> allocated by task 0 on cpu 9 at 260507.901592s:
>> sk_prot_alloc+0x35/0x140
>> sk_clone_lock+0x1f/0x3f0
>> inet_csk_clone_lock+0x15/0x160
>> tcp_create_openreq_child+0x1f/0x410
>> tcp_v6_syn_recv_sock+0x1da/0x700
>> tcp_check_req+0x1fb/0x510
>> tcp_v6_rcv+0x98b/0x1420
>> ipv6_list_rcv+0x2258/0x26e0
>> napi_complete_done+0x5b1/0x2990
>> mlx5e_napi_poll+0x2ae/0x8d0
>> net_rx_action+0x13e/0x590
>> irq_exit_rcu+0xf5/0x320
>> common_interrupt+0x80/0x90
>> asm_common_interrupt+0x22/0x40
>> cpuidle_enter_state+0xfb/0x273
>> cpu_startup_entry+0x15e/0x260
>> start_secondary+0x8a/0x90
>> secondary_startup_64_no_verify+0xfa/0xfb
>>
>> freed by task 0 on cpu 9 at 260507.927527s:
>> rcu_core_si+0x4ff/0xf10
>> irq_exit_rcu+0xf5/0x320
>> sysvec_apic_timer_interrupt+0x6d/0x80
>> asm_sysvec_apic_timer_interrupt+0x16/0x20
>> cpuidle_enter_state+0xfb/0x273
>> cpu_startup_entry+0x15e/0x260
>> start_secondary+0x8a/0x90
>> secondary_startup_64_no_verify+0xfa/0xfb
>>
>> Thanks,
>> Martin


