Return-Path: <bpf+bounces-70064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0562EBAEB6D
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 00:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72905189DD87
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 22:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE524298CC7;
	Tue, 30 Sep 2025 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GjBEwhoT"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684AA4C81
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759272701; cv=none; b=LlmdaohB9CZd63j7Qaog+3ErZ80/NHEbx33PMzfB7jguHIDCYH40l74o2ob5F04HdUgsP9RxcZ69AmQDLGnxIjfl79U1SXF6VEDoRwwxkhzmKKllIr2fEWBu4t1onpKo3ty5Eao4w7Xqljtdfpd2kPM1Of2AD40dJviRv0R09bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759272701; c=relaxed/simple;
	bh=W6fGZswsETaiYp+vnrP47GCktmIpYRDQTQHdCgwjTIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSve957fGC276sve2584MPrBnKP7TGdwoI+4gvgG7X2prynOSwm3HqsU7EwPiJC/GQAwwOnBkLwvxyV/H4uWUJ89Jo43OyXalf6W/PnEaGQXBUNI3FicqPZIN67VhLDJMswehojLLN7QObdfJs7cnbAnwlf8XRW4MuUVrIC6tHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GjBEwhoT; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df4c8852-f6d1-4278-84d8-441aad1f9994@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759272696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtBSg3QsPPTaP+NQAUZ72XmJ08HeC+LB2BKpcmTsYt0=;
	b=GjBEwhoTMJ2qnPtFoURNCY+S8DQry6qeNP6ZfuuPw1Wxv0NLmkXwsTpdlkK/5FDH8O2in4
	vnlCWMubiCwlxxhtDCfKwdcJ2RWkclNLatEnadc6ly9a3zagDeuDFzfWa2CxQM4Gjtz3w8
	07rQyZT8XeJZ3xHnoe0WowCaVDt2lts=
Date: Tue, 30 Sep 2025 15:51:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 00/14] bpf: Efficient socket destruction
To: Jordan Rife <jordan@jrife.io>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev
 <sdf@fomichev.me>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Aditi Ghag
 <aditi.ghag@isovalent.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250909170011.239356-1-jordan@jrife.io>
 <80b309fe-6ba0-4ca5-a0b7-b04485964f5d@linux.dev>
 <ilrnfpmoawkbsz2qnyne7haznfjxek4oqeyl7x5cmtds5sdvxe@dy6fs3ej4rbr>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <ilrnfpmoawkbsz2qnyne7haznfjxek4oqeyl7x5cmtds5sdvxe@dy6fs3ej4rbr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/21/25 9:03 AM, Jordan Rife wrote:
> Hi Martin,
> 
> Thanks for taking a look.
> 
>> How many sockets were destroyed?
> 
> Between 1 and 5 per trial IIRC during this test. Generally, there would
> be a small set of sockets to destroy for a given backend relative to the
> total number UDP/TCP sockets on a system.
> 
>> For TCP, is it possible to abort the connection in BPF_SOCK_OPS_RTO_CB to
>> stop the retry? RTO is not a per packet event.
> 
> To clarify, are you suggesting bpf_sock_destroy() from that context or
> something else? If the former, bpf_sock_destroy() only works from socket
> iterator contexts today, so that's one adjustment that would have to be

Regarding how to abort, I was thinking something (simpler?) like having the 
BPF_SOCK_OPS_RTO_CB prog to enforce the "expired" logic in the 
tcp_write_timeout() by using the prog's return value. The caveat is the return 
value of the BPF_SOCK_OPS_RTO_CB prog is currently ignored, so it may 
potentially break existing use cases. However, I think only checking retval == 
ETIMEOUT should be something reasonable. The retval can be set by 
bpf_set_retval(). I have only briefly looked at tcp_write_timeout, so please check.

The bpf_sock_destroy() may also work but a few things need to be 
considered/adjusted. Its tcp_send_active_reset() seems unnecessary during RTO. 
Maybe only tcp_done_with_err() is enough which seems to be a new kfunc itself. 
It also needs bh_lock_sock() which I am not sure it is true for all sock_ops 
callback. This could be tricky to filter out by the cb enum. Passing "struct 
bpf_sock_ops *" instead of "struct sock *" to a new kfunc seems not generic 
enough. It also has a tcp_set_state() call which will recur to the 
BPF_SOCK_OPS_STATE_CB prog. This can use more thought if the above "expired" 
idea in tcp_write_timeout() does not work out.

[ Unrelated, but in case it needs a new BPF_SOCK_OPS_*_CB enum. I would mostly 
freeze any new BPF_SOCK_OPS_*_CB addition and requiring to move the bpf_sock_ops 
to the struct_ops infrastructure first before adding new ops. ]

> made. It seems like this could work, but I'd have to think more about
> how to mark certain sockets for destruction (possibly using socket
> storage or some auxiliary map).

The BPF_SOCK_OPS_RTO_CB should have the sk which then should have all 4 tuples 
for an established connection.


>> Before diving into the discussion whether it is a good idea to add another
>> key to a bpf hashmap, it seems that a hashmap does not actually fit your use
>> case. A different data structure (or at least a different way of grouping
>> sk) is needed. Have you considered using the
> 
> If I were to design my ideal data structure for grouping sockets
> (ignoring current BPF limitations), it would look quite similar to the
> modified SOCK_HASH in this series. Really what would be ideal is
> something more like a multihash where a single key maps to a set of
> sockets, but that felt much too specific to this use case and doesn't
> fit well within the BPF map paradigm. The modification to SOCK_HASH with
> the key prefix stuff kind of achieves and felt like a good starting
> point.

imo, I don't think it justifies to cross this bridge only for sock_hash map and 
then later being copied to other bpf map like xsk/dev/cpumap...etc. Lets stay 
with the existing bpf map semantic. The bpf rb/list/arena is created for this. 
Lets try it and improve what is missing.
  >
>> bpf_list_head/bpf_rb_root/bpf_arena? Potentially, the sk could be stored as
>> a __kptr but I don't think it is supported yet, aside from considerations
>> when sk is closed, etc. However, it can store the numeric ip/port and then
>> use the bpf_sk_lookup helper, which can take netns_id. Iteration could
>> potentially be done in a sleepable SEC("syscall") program in test_prog_run,
>> where lock_sock is allowed. TCP sockops has a state change callback (i.e.
> 
> You could create a data structure tailored for efficient iteration over
> a group of ip/port pairs, although I'm not sure how you would acquire
> the socket lock unless, e.g., bpf_sock_destroy or a sleepable variant
> thereof acquires the lock itself in that context after the sk lookup?
> E.g. (pseudocode):
> 
> ...
> for each (ip,port,ns) in my custom data structure:
>      sk = bpf_sk_lookup_tcp(ip, port, ns)
>      if (sk)
>      	bpf_sock_destroy_sleepable(sk) // acquires socket lock?
> ...
> 

The verifier could override the kfunc call to another function pointer but I am 
not sure we should complicate verifier further for this case, so adding a 
bpf_sock_destroy_sleepable() is fine, imo. Not sure about the naming though, may 
be bpf_sock_destroy_might_sleep()?


