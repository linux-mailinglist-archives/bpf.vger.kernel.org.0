Return-Path: <bpf+bounces-32384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A7D90C64F
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 12:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1231C20E4B
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 10:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A8A1553AB;
	Tue, 18 Jun 2024 07:47:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-02.21cn.com [182.42.154.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B50B13B798
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.154.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696827; cv=none; b=SYDDaG+T71Jr5fn5lGSv1UMF/j1JILsJKSmPjSEaMBKEcwQ+KrGZEffiuApebaDaSpy8pGw/gpti5l4awuQfSqDPpJMnHA1QEPPDbS4I1AjpPTQH6wCVUmdOHUEdR1McG/sajue/5yBZuvQU96S7poTm1hCrDbMrSm55c4ypPn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696827; c=relaxed/simple;
	bh=FYDtqoi/JUfB3URt1U/VCwxgcZIsrXkkTF74pgY/SOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tqtw3VS/y6G9Gfga77d+pDfBFDPZs2xThDUCUH3s+d6kwOrZXQDRj9weCq5a7c+Q9VBNRiFB6IpY7GTeA/KcYRjX7PX0BcOUky1q62T/yoSABeN3USVRurEJxefH0nc4VpFbtHKkMHtc3mWFM27hldJrPENBWuC8eNPE+UzperU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.154.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.736495165
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-10.133.8.70 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id 8023F1200C269;
	Tue, 18 Jun 2024 15:46:53 +0800 (CST)
X-189-SAVE-TO-SEND: zhenggy@chinatelecom.cn
Received: from  ([10.133.8.70])
	by gateway-ssl-dep-67bdc54df-b7md5 with ESMTP id 0f09be6690b04e84bdeb130cfa9ab37b for john.fastabend@gmail.com;
	Tue, 18 Jun 2024 15:46:55 CST
X-Transaction-ID: 0f09be6690b04e84bdeb130cfa9ab37b
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 10.133.8.70
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
Message-ID: <8f9fb569-4dd6-465e-853b-8b4f5255f1da@chinatelecom.cn>
Date: Tue, 18 Jun 2024 15:47:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Ctyun AOneMail
Subject: Re: [issue]: sockmap restrain send if receiver block
To: =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRIEpvaG4gRmFzdGFiZW5k?=
 <john.fastabend@gmail.com>, jakub@cloudflare.com, bpf@vger.kernel.org
References: <42dd5ee4-fb01-4b84-9418-65adb7480138@chinatelecom.cn>
 <66706d48967f3_1c38c208e5@john.notmuch>
From: zhengguoyong <zhenggy@chinatelecom.cn>
In-Reply-To: <66706d48967f3_1c38c208e5@john.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

thanks for reply.

i mean the sk_msg with TCP protocol.  in this case, sender  use sk_stream_memory_free()

to check if memory is free. and in __sk_stream_memory_free(), if sk->sk_wmem_queued

is bigger then sk->sk_sndbuf or sk notsent_bytes(tp->write_seq - tp->snd_nxt) is too

bigger then __sk_stream_memory_free() will return false and do sk_stream_wait_memory().

but in sk_msg mode, tcp_bpf_sendmsg() whill not create skb structure and not use

seq to recording sending info，so sk->sk_wmem_queued is not changed in

tcp_bpf_sendmsg() path, and __sk_stream_memory_free() will always return true.

In bpf_tcp_ingress() it will copy the sender msg and charge it, and in tcp_bpf_recvmsg(),

it will uncharge the msg after sk_msg_recvmsg() receive it from psock ingress_msg queue,

if receiver is not to read again due to application bug, but sender continuous send,

then the receiver psock ingress_msg queue will continuous increase and cannot be uncharge

until tcp socket memory is not enough in the fllowing path.

tcp_bpf_sendmsg

tcp_bpf_send_verdict

tcp_bpf_sendmsg_redir

bpf_tcp_ingress

sk_wmem_schedule

so if a sk_msg type sockmap receiver is block, then it may consume all the tcp socket memory

and influence other tcp stream,  can we have a better way to limit it ?  

just like tcp use sk_sendbuf to limit per tcp stream?


thanks.


在 2024/6/18 1:07, 【外部账号】 John Fastabend 写道:
> 郑国勇 wrote:
>> hi, In sockmap case, when sender send msg, In function sk_psock_queue_msg(), it will put the msg into the receiver psock ingress_msg queue, and wakeup receiver to receive.
>>
> Whats the protocol? The TCP case tcp_bpf_sendmsg() is checking
> sk_stream_memory_free() and will do sk_stream_wait_memory() if under
> memory pressure. This should handle sending case with lots of data
> queued up on the sk.
>
> On the redirect ingress case we do this,
>
>   sk_psock_handle_skb()
>     sk_psock_skb_ingress()
>       sk_psock_create_ingress_msg()
>
> There sk_psock_create_ingress_msg() should check the rcvbuf of the
> receiving socket and shouldn't create a msg if its under memory pressure.
> If its an ingress_self case we do a skb_set_owner_r which should (?) push
> back on the memory side through sk_mem_charge().
>
> Seems like I'm missing some case then if we are hitting this. What protocol
> and what is the BPF program? Is it a sender redirect? I guess more details
> might make it obvious to me.
>
>
>> sender can always send msg but not aware the receiver psock ingress_msg queue size.  In mortally case, when receiver not receive again due to the application bug, 
>>
>> sender can contiunous send msg unti system memory not enough. If this happen, it will influence the whole system.
>>
>> my question is:  is there a better solution for this case? just like tcp use sk_sendbuf to limit the sender to send agagin if receiver is block. 
> The sender shouldn't be able to have more outstanding data than the
> socket memory allows. After the redirect the skb/msg should be
> charged to the receiving socket though. Agree sk_sendbuf should
> limit sender. Maybe the test is not TCP protocol and we missed
> adding the limits to UDP/AF_UNIX/etc?
>
>> thanks very much.

