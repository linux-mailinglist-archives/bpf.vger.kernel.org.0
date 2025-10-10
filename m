Return-Path: <bpf+bounces-70724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E335BCC1EC
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 10:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8313B4EA678
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE4125BF1B;
	Fri, 10 Oct 2025 08:26:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-10.21cn.com [182.42.147.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A8F255F2C;
	Fri, 10 Oct 2025 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.147.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084768; cv=none; b=gIDiiZ3uQMyg/K6aaJjWpE3mzdCUagS8p6C5CthjmqHB2tJTzIcTw+LALvcbKKR/t3bhrA4aIy/TA7lpjAskR0YHyfLwwyJXNqwDYWhaF1PVP8huEMmyffcgT5MXUxKcliYQB1jjnCDf/SwIisykgLOENmBbh0DBZqA4LWal7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084768; c=relaxed/simple;
	bh=ZuFuyTGu23tvFNWi4Iv+KCLI8/7kdNScqRY8LYBHD+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZYqVavPCTgxFrN6gZp/d+tfsDs77oDaOeyC5kpgt/DRJWIxNOEejeKX1Kc8+lamB3nkecZEDPAvfuijMo4SOZWUUjDErYZl41nxviPz2JpOIr5JNQCMRWeuPSkXgg/MyMcq7aprrrPMjz7RXfXXyrFPR63N1ktHsRNJtdlZkTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.147.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.1171078105
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.68 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id E8B6CB0CA534;
	Fri, 10 Oct 2025 16:17:29 +0800 (CST)
X-189-SAVE-TO-SEND: zhenggy@chinatelecom.cn
Received: from  ([27.148.194.68])
	by gateway-ssl-dep-79cdd9d55b-z742x with ESMTP id 1de75387086b4f1a9ceda4f4d87fbae0 for edumazet@google.com;
	Fri, 10 Oct 2025 16:17:50 CST
X-Transaction-ID: 1de75387086b4f1a9ceda4f4d87fbae0
X-Real-From: zhenggy@chinatelecom.cn
X-Receive-IP: 27.148.194.68
X-MEDUSA-Status: 0
Sender: zhenggy@chinatelecom.cn
Message-ID: <81694a16-07df-44f0-a0a1-601821e8859d@chinatelecom.cn>
Date: Fri, 10 Oct 2025 16:18:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Ctyun AOneMail
Subject: Re: [PATCH] bpf, sockmap: Update tp->rcv_nxt in sk_psock_skb_ingress
Content-Language: en-US
To: =?UTF-8?B?44CQ5aSW6YOo6LSm5Y+344CRIEVyaWMgRHVtYXpldA==?=
 <edumazet@google.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <3b78ca04-f4b9-4d12-998d-4e21a3a8397f@chinatelecom.cn>
 <CANn89i+rHTU2eVtkc0H=v+8PczfonOxTqc=fCw+6QRwj_3MURg@mail.gmail.com>
From: zhengguoyong <zhenggy@chinatelecom.cn>
In-Reply-To: <CANn89i+rHTU2eVtkc0H=v+8PczfonOxTqc=fCw+6QRwj_3MURg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

Thank you for your reply. Indeed, using bh_lock_sock_nested can lead to deadlock risks.
I apologize for not noticing this earlier.

Can I change bh_lock_sock_nested to lock_sock to resolve this deadlock issue?
Or do you have any better suggestions on where to update the tp->rcv_nxt field in the process?

Look forward to your response. Thank you.

*From:* 【外部账号】Eric Dumazet
*收件人:* zhengguoyong
*抄送:* john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org
*主题:* [PATCH] bpf, sockmap: Update tp->rcv_nxt in sk_psock_skb_ingress
*日期:* 2025-10-09 15:07:44
> On Wed, Oct 8, 2025 at 8:07 PM zhengguoyong <zhenggy@chinatelecom.cn> wrote:
>>
>> When using sockmap to forward TCP traffic to the application
>> layer of the peer socket, the peer socket's tcp_bpf_recvmsg_parser
>> processing flow will synchronously update the tp->copied_seq field.
>> This causes tp->rcv_nxt to become less than tp->copied_seq.
>>
>> Later, when this socket receives SKB packets from the protocol stack,
>> in the call chain tcp_data_ready → tcp_epollin_ready, the function
>> tcp_epollin_ready will return false, preventing the socket from being
>> woken up to receive new packets.
>>
>> Therefore, it is necessary to synchronously update the tp->rcv_nxt
>> information in sk_psock_skb_ingress.
>>
>> Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>
> 
> Hi GuoYong Zheng
> 
> We request a Fixes: tag for patches claiming to fix a bug.
> 
> How would stable teams decide to backport a patch or not, and to which versions,
> without having to fully understand this code ?
> 
> 
>> ---
>>  net/core/skmsg.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index 9becadd..e9d841c 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -576,6 +576,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>>         struct sock *sk = psock->sk;
>>         struct sk_msg *msg;
>>         int err;
>> +       u32 seq;
>>
>>         /* If we are receiving on the same sock skb->sk is already assigned,
>>          * skip memory accounting and owner transition seeing it already set
>> @@ -595,8 +596,15 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>>          */
>>         skb_set_owner_r(skb, sk);
>>         err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
>> -       if (err < 0)
>> +       if (err < 0) {
>>                 kfree(msg);
>> +       } else {
>> +               bh_lock_sock_nested(sk);
>> +               seq = READ_ONCE(tcp_sk(sk)->rcv_nxt) + len;
>> +               WRITE_ONCE(tcp_sk(sk)->rcv_nxt, seq);
> 
> This does not look to be the right place.
> 
> Re-locking a socket _after_ the fundamental change took place is
> fundamentally racy.
> 
> Also do we have a guarantee sk is always a TCP socket at this point ?
> 
> If yes, why do we have sk_is_tcp() check in sk_psock_init_strp() ?
> 
>> +               bh_unlock_sock(sk);
>> +       }
>> +
>>         return err;
>>  }
>>
>> --
>> 1.8.3.1


