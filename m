Return-Path: <bpf+bounces-32813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A94FD9136A9
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 00:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9F41C21295
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 22:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD1A77118;
	Sat, 22 Jun 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Ic6fG/jW"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903D4084E;
	Sat, 22 Jun 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719095933; cv=none; b=FNpUWzc3JEwUMCVI+vSuxhujeN/Q8UYI38FGc8kHWMJXOnMoPwKjHrLb0m6GDVBIcsskJG1U3Sr1PDT+09pYsdvyVurdRYzf+7+QxQD9FqtHUKDIyByZSRwwlS3M+zXcJfna/sCQQcjHOWmKjRv2SWjtui11NVJmuYc0UDUfeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719095933; c=relaxed/simple;
	bh=utn2ppJ9txOpHHSpjmfdAGRZovA0rUkWTLSy2Eqzuek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hr3pT7kfokQADtd4WT42Lb8Fw9VTJTIrzzXMD0zwTcTXCEqODlEJpEFAhDiUiEHgG5WvYs8SmMkt+/EvE8WIuXGbRetVmst5vNxrh2GXNkY5eVZIJj0lw2xnUiWJEl/BpHKDxH58BH05TdBblU+yMqKnLfW+vNEQ9EIwqk5BQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Ic6fG/jW; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sL9NY-00Akdl-5O; Sun, 23 Jun 2024 00:38:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=wD4i8ug9zL8PvMy94qhpbD+VPJZ/Z40xDdYrlAll9Ro=; b=Ic6fG/jWgrmNZ+4+IiBkEbZgWz
	H+5x0yTuNHuUDfBhgb8jFHh2ttZovkc0lGz83BWp8ChLgeKFWoy+UUIvGEI84Jqv+xKTIpf1W6vfb
	JZX+DpAJDOq5ckK36RAAaRwDgKNSr3laDT2nvxAfHdvlKh7eKyzGoMIh7rjxrm8N+dbri9yF3QTN9
	Aty41LSwYdeff2dFqwOWdAVz4PwUuURWgp8/xMobFjrgqmH8AicjWRMqpOBNXvjI+8dn0iSiRwkPM
	WdRDV46qm9rzS8MdQ6o/UTCfRBSEYziWps/c95FX94NeSU7c8uv5t/tWvekxfnHBGsdcBCLe8nyGR
	e7qOAd8Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sL9NX-0003zK-7f; Sun, 23 Jun 2024 00:38:39 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sL9NH-0079be-Qe; Sun, 23 Jun 2024 00:38:23 +0200
Message-ID: <fda335cd-3fb1-4024-bff7-aedeb1d8710a@rbox.co>
Date: Sun, 23 Jun 2024 00:38:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] af_unix: Disable MSG_OOB handling for sockets in
 sockmap/sockhash
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <20240620203009.2610301-1-mhal@rbox.co>
 <20240620221223.66096-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240620221223.66096-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/24 00:12, Kuniyuki Iwashima wrote:
> Sorry for not mentioning this before, but could you replace "net" with
> "bpf" in Subject and rebase the patch on bpf.git so that we can trigger
> the patchwork's CI ?

No problem, will do.

>> ...
>>  static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>>  {
>> +	struct unix_sock *u = unix_sk(sk);
>> +	struct sk_buff *skb;
>> +	int err;
>> +
>>  	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED))
>>  		return -ENOTCONN;
>>  
>> -	return unix_read_skb(sk, recv_actor);
>> +	mutex_lock(&u->iolock);
>> +	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
> 
> 	mutex_unlock(&u->iolock);
> 
> I think we can drop mutex here as the skb is already unlinked
> and no receiver can touch it.

I guess you're right about the mutex. That said, double mea culpa, lack of
state lock makes things racy:

unix_stream_read_skb
  mutex_lock
  skb = skb_recv_datagram
  mutex_unlock
  spin_lock
  if (oob_skb == skb) {
				unix_release_sock
				  if (u->oob_skb) {
				    kfree_skb(u->oob_skb)
				    u->oob_skb = NULL
				  }
    oob_skb = NULL
    drop = true
  }
  spin_unlock
  if (drop) {
    skb_unref(skb)
    kfree_skb(skb)
  }

In v2 I'll do what unix_stream_read_generic() does: take state lock and
check for SOCK_DEAD.

> and the below part can be like the following not to slow down
> the common case:
> 
> 	if (!skb)
> 		return err;
> 
>> +
>> +#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>> +	if (skb) {
> 
> 	if (unlikely(skb == READ_ONCE(u->oob_skb))) {
> 
> 
>> +		bool drop = false;
>> +
>> +		spin_lock(&sk->sk_receive_queue.lock);
>> +		if (skb == u->oob_skb) {
> 
> 		if (likely(skb == u->oob_skb)) {
> 
>> +			WRITE_ONCE(u->oob_skb, NULL);
>> +			drop = true;
>> +		}
>> +		spin_unlock(&sk->sk_receive_queue.lock);
>> +
>> +		if (drop) {
>> +			WARN_ON_ONCE(skb_unref(skb));
>> +			kfree_skb(skb);
>> +			skb = NULL;
>> +			err = -EAGAIN;
> 			return -EAGAIN;
> 
>> +		}
>> +	}
>> +#endif
> 
> 	return recv_actor(sk, skb);

All right, thanks. So here's v2:
https://lore.kernel.org/netdev/20240622223324.3337956-1-mhal@rbox.co/

