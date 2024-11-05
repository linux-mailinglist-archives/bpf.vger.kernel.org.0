Return-Path: <bpf+bounces-44067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACEB9BD5CC
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 20:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05991F238B9
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 19:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97331EBFF4;
	Tue,  5 Nov 2024 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t0rDGiu4"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EBA17BEB7
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834547; cv=none; b=evZzq+tU0TJMiVDycv2pG+iUdiCCCcMjk+rp1IUB1RiQL+L5f3g1xZKhnxix7Jwgq62xtMHJWmc+TJ1PNeXBbd5wxy89fx7Ni0JvRTWGOI2gLbyz49DWZzWF4jtxEDhDrzu1edH2RpXgigPUnHcqYzwcILsldG7hTLb15MQjedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834547; c=relaxed/simple;
	bh=EK18a9GsAaNuMbsMBX+mlEU/2y8NCZMLplGvJ8fchqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xavnkd1VyC44Z1tIeEHM5ecUJnW42uBT+IYwmIMJ/B9+6jjGt/DG9pWkH8UAU+1X8qCO5j1mGRG80bUFhlm3N40WD5kYGoi2R9oYFE7MPAkqvO+mqvqoDyeLbgdlr1ZPh1HpRw1x39UxqiNwAlybBhtWIbqLYDD48/6agpUgN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t0rDGiu4; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f27ab4ce-02df-464e-90ed-852652fb7e3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730834540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/lV56qOFekIpTJ0243xyhBPojpFxY1cI7kHvI1Dc0Y=;
	b=t0rDGiu4kcbJWqqnIp1eA7/ABUJPfcWEp5oyLZuXDW+rbTi7nHHV/7C3fiWSJKBi/Kq0IC
	NmpulbcAq4Kfkh+dheC5mcgNpNkf23CBbXtBl31wLa+ilqOZc026f7L7LKel4CbptMdDBd
	fJLAtaj+9cbQBOtIubOmLtRx18mnDSA=
Date: Tue, 5 Nov 2024 11:22:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, willemb@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
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
 <1c8ebc16-f8e7-4a98-9518-865db3952f8f@linux.dev>
 <CAL+tcoBf+kQ3_kc9x62KnHx9O+6c==_DN+6EheL82UKQ3xQN1A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoBf+kQ3_kc9x62KnHx9O+6c==_DN+6EheL82UKQ3xQN1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/4/24 10:22 PM, Jason Xing wrote:
> On Tue, Nov 5, 2024 at 10:09 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 11/1/24 6:32 AM, Willem de Bruijn wrote:
>>>> In udp/raw/..., I don't know how likely is the user space having "cork->tx_flags
>>>> & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags) &
>>>> SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set.
>>> This is not something to rely on. OPT_ID was added relatively recently.
>>> Older applications, or any that just use the most straightforward API,
>>> will not set this.
>>
>> Good point that the OPT_ID per cmsg is very new.
>>
>> The datagram support on SOF_TIMESTAMPING_OPT_ID in sk->sk_tsflags had
>> been there for quite some time now. Is it a safe assumption that
>> most applications doing udp tx timestamping should have
>> the SOF_TIMESTAMPING_OPT_ID set to be useful?
>>
>>>
>>>> If it is
>>>> unlikely, may be we can just disallow bpf prog from directly setting
>>>> skb_shinfo(skb)->tskey for this particular skb.
>>>>
>>>> For all other cases, in __ip[6]_append_data, directly call a bpf prog and also
>>>> pass the kernel decided tskey to the bpf prog.
>>>>
>>>> The kernel passed tskey could be 0 (meaning the user space has not used it). The
>>>> bpf prog can give one for the kernel to use. The bpf prog can store the
>>>> sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add one to the struct
>>>> sock. The bpf prog does not have to start from 0 (e.g. start from U32_MAX
>>>> instead) if it helps.
>>>>
>>>> If the kernel passed tskey is not 0, the bpf prog can just use that one
>>>> (assuming the user space is doing something sane, like the value in
>>>> SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_MAX). I hope this
>>>> is very unlikely also (?) but the bpf prog can probably detect this and choose
>>>> to ignore this sk.
>>> If an applications uses OPT_ID, it is unlikely that they will toggle
>>> the feature on and off on a per-packet basis. So in the common case
>>> the program could use the user-set counter or use its own if userspace
>>> does not enable the feature. In the rare case that an application does
>>> intermittently set an OPT_ID, the numbering would be erratic. This
>>> does mean that an actively malicious application could mess with admin
>>> measurements.
>>
>> All make sense. Given it is reasonable to assume the user space should either
>> has SOF_TIMESTAMPING_OPT_ID always on or always off. When it is off, the bpf
>> prog can directly provide its own tskey to be used in shinfo->tskey. The bpf
>> prog can generate the id itself without using the sk->sk_tskey, e.g. store an
>> atomic int in the bpf_sk_storage.
> 
> I wonder, how can we correlate the key with each skb in the bpf
> program for non-TCP type without implementing a bpf extension for
> SCM_TS_OPT_ID? Every time the timestamp is reported, we cannot know
> which sendmsg() the skb belongs to for non-TCP cases.

SCM_TS_OPT_ID is eventually setting the shinfo->tskey.
If the shinfo->tskey is not set by the user space, the bpf prog can directly set 
the shinfo->tskey. There is no need to use the sk->sk_tskey as the ID generator 
also. The bpf prog can have its own id generator.

If the user space has already set the shinfo->tskey (either by sk->sk_tskey or 
SCM_TS_OPT_ID), the bpf prog can just use the user space one.

If there is a weird application that flips flops between OPT_ID on/off, the bpf 
prog will get confused which is fine. The bpf prog can detect this and choose to 
ignore measuring this sk/skb. The bpf prog can also choose to be on the very 
safe side and ignore all skb with SKBTX_ANY_TSTAMP set in txflags but with no 
OPT_ID. The bpf prog can look into the details of the sk and skb to decide what 
makes the most sense for its deployment.

I don't know whether it makes more sense to call the bpf prog to decide the 
shinfo->{tx_flags,tskey} just before the "while (length > 0)" in 
__ip[6]_append_data or it is better to call the bpf prog in ip[6]_setup_cork.
I admittedly less familiar with this code path than the tcp one.

