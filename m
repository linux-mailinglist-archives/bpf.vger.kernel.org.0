Return-Path: <bpf+bounces-17407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF49080CEC0
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC0D1C20971
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C7C495F3;
	Mon, 11 Dec 2023 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="grfgRxvN"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6D6AB;
	Mon, 11 Dec 2023 06:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+f/7NOz/Mkinrg40jIZrImE4IcPtyVXDHo7HHDIl+Oc=; b=grfgRxvNOoeNJHlhYOYT6AGeuw
	reCThwNxC5osNKWYsW2Hh8ugetWUcTAVy1y/qNJbrqRA4k1LVW1OcSr1BFQOdJoEcFJKKAVDMPyHh
	Qr0iHKK8THwqXYXTqo3YNFUR6xJ55NxWM8tgU58OtJo21PZYyyNJjGJnFaewKhW5pjZkwLXUmDL5I
	mzPxvKmGuKH3l86z1telgLYmkSLiGAEZIh/U1rSgHQgtnS8CoeaTMWUuOv+k/AZUrAwQVLxN039ZR
	jh+UOVaKGxb4QwCAaLXgoBs2+eEuUqe37oxtWI1cVzQ41X1kw0uw+kW3e3BLK8xzLYm998SA5M7Ns
	+Y/bEFEg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rChhV-0002DT-Iy; Mon, 11 Dec 2023 15:56:05 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rChhV-000JV5-2T; Mon, 11 Dec 2023 15:56:05 +0100
Subject: Re: [PATCH bpf v2 1/2] bpf: syzkaller found null ptr deref in
 unix_bpf proto add
To: Cong Wang <xiyou.wangcong@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org,
 edumazet@google.com, jakub@cloudflare.com, martin.lau@kernel.org,
 netdev@vger.kernel.org, amery.hung@bytedance.com
References: <20231201180139.328529-2-john.fastabend@gmail.com>
 <20231201211453.27432-1-kuniyu@amazon.com>
 <656e4758675b9_1bd6e2086f@john.notmuch> <ZXKZa4RRmK2M6iHT@pop-os.localdomain>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5c20a29a-ac9f-da0a-01dc-2278d7ae386a@iogearbox.net>
Date: Mon, 11 Dec 2023 15:56:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZXKZa4RRmK2M6iHT@pop-os.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27120/Mon Dec 11 10:44:34 2023)

On 12/8/23 5:19 AM, Cong Wang wrote:
> On Mon, Dec 04, 2023 at 01:40:40PM -0800, John Fastabend wrote:
>> Kuniyuki Iwashima wrote:
>>> From: John Fastabend <john.fastabend@gmail.com>
>>> Date: Fri,  1 Dec 2023 10:01:38 -0800
>>>> I added logic to track the sock pair for stream_unix sockets so that we
>>>> ensure lifetime of the sock matches the time a sockmap could reference
>>>> the sock (see fixes tag). I forgot though that we allow af_unix unconnected
>>>> sockets into a sock{map|hash} map.
>>>>
>>>> This is problematic because previous fixed expected sk_pair() to exist
>>>> and did not NULL check it. Because unconnected sockets have a NULL
>>>> sk_pair this resulted in the NULL ptr dereference found by syzkaller.
>>>>
>>>> BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
>>>> Write of size 4 at addr 0000000000000080 by task syz-executor360/5073
>>>> Call Trace:
>>>>   <TASK>
>>>>   ...
>>>>   sock_hold include/net/sock.h:777 [inline]
>>>>   unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
>>>>   sock_map_init_proto net/core/sock_map.c:190 [inline]
>>>>   sock_map_link+0xb87/0x1100 net/core/sock_map.c:294
>>>>   sock_map_update_common+0xf6/0x870 net/core/sock_map.c:483
>>>>   sock_map_update_elem_sys+0x5b6/0x640 net/core/sock_map.c:577
>>>>   bpf_map_update_value+0x3af/0x820 kernel/bpf/syscall.c:167
>>>>
>>>> We considered just checking for the null ptr and skipping taking a ref
>>>> on the NULL peer sock. But, if the socket is then connected() after
>>>> being added to the sockmap we can cause the original issue again. So
>>>> instead this patch blocks adding af_unix sockets that are not in the
>>>> ESTABLISHED state.
>>>
>>> I'm not sure if someone has the unconnected stream socket use case
>>> though, can't we call additional sock_hold() in connect() by checking
>>> sk_prot under sk_callback_lock ?
>>
>> Could be done I guess yes. I'm not sure the utility of it though. I
>> thought above patch was the simplest solution and didn't require touching
>> main af_unix code. I don't actually use the sockmap with af_unix
>> sockets anywhere so maybe someone who is using this can comment if
>> unconnected is needed?
> 
> Our use case is also connected unix stream socket, as demonstrated in
> the selftest unix_redir_to_connected().

Great, is everyone good to move this fix forward then? Would be great if
this receives at least one ack if the latter is indeed the case.

Thanks,
Daniel

