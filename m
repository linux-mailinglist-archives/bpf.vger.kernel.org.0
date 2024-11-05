Return-Path: <bpf+bounces-43986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 713F59BC2F3
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 03:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A1B281DCA
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA8C38DE5;
	Tue,  5 Nov 2024 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixSW0ajk"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD32943F
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772572; cv=none; b=J1h9M+xnXVo2c8GCHHjCbyMR0Hp6otn0pPOhENCxmn5EiCMKAbd4e0iwDwNMVDGi21u6/xMtdoPZHB3TnAsAX7EXFenRcE4xJCfy7kJocowAO8ObMG6FZ2rlyVpCf1HASWT+BFTxqvgz17TOdy77rIhHt/QypKQA0Avpj7KUev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772572; c=relaxed/simple;
	bh=Pcrln0gItgmWejm1QLG9WqarUk3RNYetd3XMdPpy93g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BczPVo2yBh31FdK5AiD1ox3QaqcKUi7fvB64DYNl7UKvnvhiMIxVnkL70FyumGbI8z4Y0g1wUBCYy3EFpq//QIz1j0mHaScj/aDFjgGwaTiB9XxOS78vmNQ+qfbWqlYJr+zJW9W/lXDPfLmvtr5AuyfTs8chV1YIYblDb5wHgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixSW0ajk; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1c8ebc16-f8e7-4a98-9518-865db3952f8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730772568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ+XFIX1RNZC7zDuvf3RyH0l1wOdRsulutGWdWwlL5c=;
	b=ixSW0ajklzW6HjRAczqKD+T/jETT8RNbwC/hHm/wUY42VWIcH6CF/oSyOP8vTq05yuBjs3
	DboW+J7AmV0y9bUdxtl2HajuSIN1bUfIwtvcg+B5h2LPiWw3OlaMaY8tfse903X/h7Q286
	xBi2OETtl5V7Z2IoT+AGcwqy0W7bzaU=
Date: Mon, 4 Nov 2024 18:09:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Xing <kerneljasonxing@gmail.com>
Cc: willemb@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
 <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev>
 <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch>
 <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev>
 <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/1/24 6:32 AM, Willem de Bruijn wrote:
>> In udp/raw/..., I don't know how likely is the user space having "cork->tx_flags
>> & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags) &
>> SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set.
> This is not something to rely on. OPT_ID was added relatively recently.
> Older applications, or any that just use the most straightforward API,
> will not set this.

Good point that the OPT_ID per cmsg is very new.

The datagram support on SOF_TIMESTAMPING_OPT_ID in sk->sk_tsflags had
been there for quite some time now. Is it a safe assumption that
most applications doing udp tx timestamping should have
the SOF_TIMESTAMPING_OPT_ID set to be useful?

> 
>> If it is
>> unlikely, may be we can just disallow bpf prog from directly setting
>> skb_shinfo(skb)->tskey for this particular skb.
>>
>> For all other cases, in __ip[6]_append_data, directly call a bpf prog and also
>> pass the kernel decided tskey to the bpf prog.
>>
>> The kernel passed tskey could be 0 (meaning the user space has not used it). The
>> bpf prog can give one for the kernel to use. The bpf prog can store the
>> sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add one to the struct
>> sock. The bpf prog does not have to start from 0 (e.g. start from U32_MAX
>> instead) if it helps.
>>
>> If the kernel passed tskey is not 0, the bpf prog can just use that one
>> (assuming the user space is doing something sane, like the value in
>> SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_MAX). I hope this
>> is very unlikely also (?) but the bpf prog can probably detect this and choose
>> to ignore this sk.
> If an applications uses OPT_ID, it is unlikely that they will toggle
> the feature on and off on a per-packet basis. So in the common case
> the program could use the user-set counter or use its own if userspace
> does not enable the feature. In the rare case that an application does
> intermittently set an OPT_ID, the numbering would be erratic. This
> does mean that an actively malicious application could mess with admin
> measurements.

All make sense. Given it is reasonable to assume the user space should either 
has SOF_TIMESTAMPING_OPT_ID always on or always off. When it is off, the bpf 
prog can directly provide its own tskey to be used in shinfo->tskey. The bpf 
prog can generate the id itself without using the sk->sk_tskey, e.g. store an 
atomic int in the bpf_sk_storage.

