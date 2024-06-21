Return-Path: <bpf+bounces-32688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7C8911C42
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 08:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F58A282539
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 06:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6476F16D307;
	Fri, 21 Jun 2024 06:56:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-11.21cn.com [182.42.117.141])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A199016C688
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.117.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952977; cv=none; b=KIAI1qDkwf07DPB4oj3joZMP84DVzEY7Ic9b3f+x621lcOeDSSfyWMhGJbEpCAb4lBjtnQe39DsAs2IwUpRhP70FEGfrrpOHbn58WfSts1ZCsJULL8+uOKIdx9JdypwdUG/CKwDdnNVL8kV9UsN304fr5CurtT4P6UcX178POlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952977; c=relaxed/simple;
	bh=Xa4aSMWehbcPiMB6Xl7bQ0+Ssy5IwxSWthGTuuWGAsI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=vE57N1ahhDrjzvG5QRq0T24cUp7RifKkR3cjh3iNDJ1IG7a7klDmiOPJlpou1J6gWP2LGwoDynFx+QafNn/Yx0GpQYq237HrMEhi/vSWxqi1M8eP+SF5gCkU/z5Gl9IufedCSiC61OaFcDcYLfAtx+nMvX7mhXq4lojOL6GCnTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.117.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.983451143
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.70 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id BB2E3E010B49;
	Fri, 21 Jun 2024 14:44:23 +0800 (CST)
X-189-SAVE-TO-SEND: zhenggy@chinatelecom.cn
Received: from  ([27.148.194.70])
	by gateway-ssl-dep-67bdc54df-cz88j with ESMTP id 4c6d12761e734bb38c066afa53205516 for john.fastabend@gmail.com;
	Fri, 21 Jun 2024 14:44:26 CST
X-Transaction-ID: 4c6d12761e734bb38c066afa53205516
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 27.148.194.70
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
Message-ID: <fcd7bc97-3d74-4725-b8e5-700d8dfdef3a@chinatelecom.cn>
Date: Fri, 21 Jun 2024 14:44:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Ctyun AOneMail
Subject: Re: [issue]: sockmap restrain send if receiver block
From: zhengguoyong <zhenggy@chinatelecom.cn>
To: =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRIEpvaG4gRmFzdGFiZW5k?=
 <john.fastabend@gmail.com>, jakub@cloudflare.com, bpf@vger.kernel.org
References: <42dd5ee4-fb01-4b84-9418-65adb7480138@chinatelecom.cn>
 <66706d48967f3_1c38c208e5@john.notmuch>
 <4cf6d911-9dc4-4588-be1f-cfee675e174e@chinatelecom.cn>
In-Reply-To: <4cf6d911-9dc4-4588-be1f-cfee675e174e@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

is it too heavy use tcp socket memory(defined in /proc/sys/net/ipv4/tcp_mem)
to control sender not send too much data when we run sk_msg redirect sockmap
whit TCP protocol?

look forward for your reply.

thanks  so much.

在 2024/6/18 16:08, zhengguoyong 写道:
> thanks for reply.
>
> i mean the sk_msg with TCP protocol. in this case, sender use sk_stream_memory_free()
> to check if memory is free. and in __sk_stream_memory_free(), if
> sk->sk_wmem_queued is bigger then sk->sk_sndbuf or sk
> notsent_bytes(tp->write_seq - tp->snd_nxt) is too bigger then
> __sk_stream_memory_free() will return false and do sk_stream_wait_memory().
>
> but in sk_msg mode, tcp_bpf_sendmsg() will not create skb structure and not use seq to
> recording sending info，so sk->sk_wmem_queued is not changed in tcp_bpf_sendmsg() path,
> and __sk_stream_memory_free() will always return true.
>
> in bpf_tcp_ingress() will copy the sender msg and charge it, and in
> tcp_bpf_recvmsg(), it will uncharge the msg after sk_msg_recvmsg()
> receive it from psock ingress_msg queue, and if receiver is not to read again
> due to application bug, and sender continuous send, then the receiver
> psock ingress_msg queue will continuous increase and cannot be uncharged
> until tcp socket memory is not enough in the fllowing path.
>
>     tcp_bpf_sendmsg
>         tcp_bpf_send_verdict
>             tcp_bpf_sendmsg_redir
>                 bpf_tcp_ingress
>                     sk_wmem_schedule
>
> so if a sk_msg type sockmap receiver is block, then it may consume all the
> tcp socket memory and influence other tcp stream,
> can we limit per sockmap tcp stream link sk->sk_sndbuf ?
>
> thanks.
>
> 在 2024/6/18 1:07, 【外部账号】 John Fastabend 写道:
>> 郑国勇 wrote:
>>> hi, In sockmap case, when sender send msg, In function sk_psock_queue_msg(), it will put the msg into the receiver psock ingress_msg queue, and wakeup receiver to receive.
>>>
>> Whats the protocol? The TCP case tcp_bpf_sendmsg() is checking
>> sk_stream_memory_free() and will do sk_stream_wait_memory() if under
>> memory pressure. This should handle sending case with lots of data
>> queued up on the sk.
>>
>> On the redirect ingress case we do this,
>>
>>   sk_psock_handle_skb()
>>     sk_psock_skb_ingress()
>>       sk_psock_create_ingress_msg()
>>
>> There sk_psock_create_ingress_msg() should check the rcvbuf of the
>> receiving socket and shouldn't create a msg if its under memory pressure.
>> If its an ingress_self case we do a skb_set_owner_r which should (?) push
>> back on the memory side through sk_mem_charge().
>>
>> Seems like I'm missing some case then if we are hitting this. What protocol
>> and what is the BPF program? Is it a sender redirect? I guess more details
>> might make it obvious to me.
>>
>>
>>> sender can always send msg but not aware the receiver psock ingress_msg queue size.  In mortally case, when receiver not receive again due to the application bug, 
>>>
>>> sender can contiunous send msg unti system memory not enough. If this happen, it will influence the whole system.
>>>
>>> my question is:  is there a better solution for this case? just like tcp use sk_sendbuf to limit the sender to send agagin if receiver is block.
>> The sender shouldn't be able to have more outstanding data than the
>> socket memory allows. After the redirect the skb/msg should be
>> charged to the receiving socket though. Agree sk_sendbuf should
>> limit sender. Maybe the test is not TCP protocol and we missed
>> adding the limits to UDP/AF_UNIX/etc?
>>
>>> thanks very much.


