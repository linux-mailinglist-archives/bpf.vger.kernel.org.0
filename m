Return-Path: <bpf+bounces-16290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218F7FF5E8
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 17:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C37F2818F8
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8548C5576A;
	Thu, 30 Nov 2023 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="m8loHk3x"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095891A4;
	Thu, 30 Nov 2023 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=96mV3PE/EFMwbcHPk/z39OHBljiIgbbmD5TmN3kEpN0=; b=m8loHk3x3/TTEA9Xj884g0pNM1
	j4rOoTWNbrVXOrrNIJf4g0czDDpjkqyutSXhxm5L0ey4sVW+DmX2vA6yMR8BcyuA8VFFaZMHrqknx
	WA3aR48+rSfi61G5Q3HzwU1Nx1IzCusp9YKS4yaGK49ZMqTB94Elh1CRKDFedO0FGjLkTEN4Li58e
	+i2DxD5KfEd/VJhSEIauOBEc85pOs0T3FlW3oLGRPQ0tskGIgwyuRAg0cxALrhhfft/DlZGJVOPgm
	Rud8odkwO4uzV5DVE6LEngbvSk/bNuDYVDvxBRCSfmjYX6JYTQheE6+r0OhoNve7txNOrMy/F1d3S
	kPbnekOQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8jxh-000BLg-9f; Thu, 30 Nov 2023 17:32:25 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8jxg-0006sY-ID; Thu, 30 Nov 2023 17:32:24 +0100
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, Stanislav Fomichev <sdf@google.com>,
 Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, kernel-team
 <kernel-team@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
 <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org>
 <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net> <87fs0qj61x.fsf@toke.dk>
 <0b0c6538-92a5-3041-bc48-d7286f1b873b@gmail.com> <87plzsi5wj.fsf@toke.dk>
 <1ff5c528-79a8-fbb7-8083-668ca5086ecf@iogearbox.net> <871qc72vmh.fsf@toke.dk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8677db3e-5662-7ebe-5af0-e5a3ca60587f@iogearbox.net>
Date: Thu, 30 Nov 2023 17:32:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <871qc72vmh.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27109/Thu Nov 30 09:44:04 2023)

On 11/30/23 2:55 PM, Toke Høiland-Jørgensen wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes
>> On 11/29/23 10:52 PM, Toke Høiland-Jørgensen wrote:
>>> Edward Cree <ecree.xilinx@gmail.com> writes:
>>>> On 28/11/2023 14:39, Toke Høiland-Jørgensen wrote:
>>>>> I'm not quite sure what should be the semantics of that, though. I.e.,
>>>>> if you are trying to aggregate two packets that have the flag set, which
>>>>> packet do you take the value from? What if only one packet has the flag
>>
>> It would probably make sense if both packets have it set.
> 
> Right, so "aggregate only if both packets have the flag set, keeping the
> metadata area from the first packet", then?

Yes, sgtm.

>>>>> set? Or should we instead have a "metadata_xdp_only" flag that just
>>>>> prevents the skb metadata field from being set entirely?
>>
>> What would be the use case compared to resetting meta data right before
>> we return with XDP_PASS?
> 
> I was thinking it could save a call to xdp_adjust_meta() to reset it
> back to zero before PASSing the packet. But okay, that may be of
> marginal utility.

Agree, feels too marginal.

>>>> Sounds like what's actually needed is bpf progs inside the GRO engine
>>>>    to implement the metadata "protocol" prepare and coalesce callbacks?
>>>
>>> Hmm, yes, I guess that would be the most general solution :)
>>
>> Feels like a potential good fit, agree, although for just solving the
>> above sth not requiring extra BPF might be nice as well.
> 
> Yeah, I agree that just the flag makes sense on its own.
> 
> -Toke
> 


