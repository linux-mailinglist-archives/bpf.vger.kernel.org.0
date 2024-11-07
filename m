Return-Path: <bpf+bounces-44190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A19BFB48
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 02:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E281F22A24
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 01:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A0979F6;
	Thu,  7 Nov 2024 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KE3otffs"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202028F4;
	Thu,  7 Nov 2024 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942392; cv=none; b=K8i4iPzYcPIiPIJgVrfWvy9bfeqKWfd8e7nBi+A3AKjTlCHKKF3PViRJYLd73GRAMxKjyem8hfCaSQu0pm8uLnsgUMfb9EOeEILn+dUd+yca1QrZrVynVqAOsMPukQpB9Ih7FR9lf8Sa2tZpRJGGctLLij5zR5auHEG+KcAPR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942392; c=relaxed/simple;
	bh=ascCbzhcSGbBvZZqUcwg813ce3rDFdTCCRNFSzOHDTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jB/oc76MCIXTgJTEfFay5TeF1yZMjp/pTUHj2gixPq4NtvGjwCdKSjc0lAAN0gdkoGYI2yxvAmBdrCnKrlMz9XbEctnE3dNs5s64/AL8w10dXHmcxRlOCp57veG7cSB2Md7ofHWvndP4C540BYLQdlmPQOAOAiIzCgtkiiMvkzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KE3otffs; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49ad2b87-29af-429e-8acb-2bba13e2b2aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730942386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThItE6RrQVjW+V5DIFsvkMqpM7Ki0rhjv5HfjUjDAW8=;
	b=KE3otffsel9h+yldP/nMPkrw8v143Te8IUZuM59wZpBfPM+s59ufTis56+bxE+Wb2+1S0K
	dpzdSNigogJYdA5BnOHc12qgkSYoMGAuxgLH5ZMLrs0MnzwzXXJGizrRGu5cflGDXVEnmC
	9T2B02MYN9MuQrxL9cvWvy8YoQGqPAE=
Date: Wed, 6 Nov 2024 17:19:36 -0800
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
 <f27ab4ce-02df-464e-90ed-852652fb7e3e@linux.dev>
 <CAL+tcoDEMJGYNw01QnEUZwtG5BMj3AyLwtp1m1_hJfY2bG=-dQ@mail.gmail.com>
 <97d8f9b3-9ae3-4146-a933-70dbe393132e@linux.dev>
 <CAL+tcoBzces5_awOzZsyqpTWjk0moxkjj7kHjCtPcsU3kNJ4tg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoBzces5_awOzZsyqpTWjk0moxkjj7kHjCtPcsU3kNJ4tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/5/24 6:51 PM, Jason Xing wrote:
> On Wed, Nov 6, 2024 at 9:09 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 11/5/24 4:17 PM, Jason Xing wrote:
>>> On Wed, Nov 6, 2024 at 3:22 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 11/4/24 10:22 PM, Jason Xing wrote:
>>>>> On Tue, Nov 5, 2024 at 10:09 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>>>
>>>>>> On 11/1/24 6:32 AM, Willem de Bruijn wrote:
>>>>>>>> In udp/raw/..., I don't know how likely is the user space having "cork->tx_flags
>>>>>>>> & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags) &
>>>>>>>> SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set.
>>>>>>> This is not something to rely on. OPT_ID was added relatively recently.
>>>>>>> Older applications, or any that just use the most straightforward API,
>>>>>>> will not set this.
>>>>>>
>>>>>> Good point that the OPT_ID per cmsg is very new.
>>>>>>
>>>>>> The datagram support on SOF_TIMESTAMPING_OPT_ID in sk->sk_tsflags had
>>>>>> been there for quite some time now. Is it a safe assumption that
>>>>>> most applications doing udp tx timestamping should have
>>>>>> the SOF_TIMESTAMPING_OPT_ID set to be useful?
>>>>>>
>>>>>>>
>>>>>>>> If it is
>>>>>>>> unlikely, may be we can just disallow bpf prog from directly setting
>>>>>>>> skb_shinfo(skb)->tskey for this particular skb.
>>>>>>>>
>>>>>>>> For all other cases, in __ip[6]_append_data, directly call a bpf prog and also
>>>>>>>> pass the kernel decided tskey to the bpf prog.
>>>>>>>>
>>>>>>>> The kernel passed tskey could be 0 (meaning the user space has not used it). The
>>>>>>>> bpf prog can give one for the kernel to use. The bpf prog can store the
>>>>>>>> sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add one to the struct
>>>>>>>> sock. The bpf prog does not have to start from 0 (e.g. start from U32_MAX
>>>>>>>> instead) if it helps.
>>>>>>>>
>>>>>>>> If the kernel passed tskey is not 0, the bpf prog can just use that one
>>>>>>>> (assuming the user space is doing something sane, like the value in
>>>>>>>> SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_MAX). I hope this
>>>>>>>> is very unlikely also (?) but the bpf prog can probably detect this and choose
>>>>>>>> to ignore this sk.
>>>>>>> If an applications uses OPT_ID, it is unlikely that they will toggle
>>>>>>> the feature on and off on a per-packet basis. So in the common case
>>>>>>> the program could use the user-set counter or use its own if userspace
>>>>>>> does not enable the feature. In the rare case that an application does
>>>>>>> intermittently set an OPT_ID, the numbering would be erratic. This
>>>>>>> does mean that an actively malicious application could mess with admin
>>>>>>> measurements.
>>>>>>
>>>>>> All make sense. Given it is reasonable to assume the user space should either
>>>>>> has SOF_TIMESTAMPING_OPT_ID always on or always off. When it is off, the bpf
>>>>>> prog can directly provide its own tskey to be used in shinfo->tskey. The bpf
>>>>>> prog can generate the id itself without using the sk->sk_tskey, e.g. store an
>>>>>> atomic int in the bpf_sk_storage.
>>>>>
>>>>> I wonder, how can we correlate the key with each skb in the bpf
>>>>> program for non-TCP type without implementing a bpf extension for
>>>>> SCM_TS_OPT_ID? Every time the timestamp is reported, we cannot know
>>>>> which sendmsg() the skb belongs to for non-TCP cases.
>>>>
>>>> SCM_TS_OPT_ID is eventually setting the shinfo->tskey.
>>>> If the shinfo->tskey is not set by the user space, the bpf prog can directly set
>>>> the shinfo->tskey. There is no need to use the sk->sk_tskey as the ID generator
>>>> also. The bpf prog can have its own id generator.
>>>>
>>>> If the user space has already set the shinfo->tskey (either by sk->sk_tskey or
>>>> SCM_TS_OPT_ID), the bpf prog can just use the user space one.
>>>>
>>>> If there is a weird application that flips flops between OPT_ID on/off, the bpf
>>>> prog will get confused which is fine. The bpf prog can detect this and choose to
>>>> ignore measuring this sk/skb. The bpf prog can also choose to be on the very
>>>> safe side and ignore all skb with SKBTX_ANY_TSTAMP set in txflags but with no
>>>> OPT_ID. The bpf prog can look into the details of the sk and skb to decide what
>>>> makes the most sense for its deployment.
>>>>
>>>> I don't know whether it makes more sense to call the bpf prog to decide the
>>>> shinfo->{tx_flags,tskey} just before the "while (length > 0)" in
>>>> __ip[6]_append_data or it is better to call the bpf prog in ip[6]_setup_cork.
>>>> I admittedly less familiar with this code path than the tcp one.
>>>
>>> Now I feel it could be complicated for a software engineer to consider
>>> how they will handle the key if they don't read the kernel code very
>>> carefully. They are facing different situations. Being user-friendly
>>> lets this feature have more chances to get widely used. As I insisted
>>> before, I still would like to know if it is possible that we can try
>>> to introduce sk_tskey_bpf_offset (like patch 10-12) to calculate a bpf
>>> exclusive tskey for bpf use? Only exporting one key. It will be really
>>> simple and easy-to-use :)
>>
>> imo, there is no need for adding sk_tskey_bpf_offset to sk. just allow the bpf
>> prog to decide what is the tskey.
>>
>> There is no usability issue in bpf prog. It is pretty normal for a bpf prog
>> author to look at the sk details to make decision.
>>
>> Abstracting the sk/skb is not helping the bpf prog and not the right direction
>> to go. Over time, there has been case over case that the bpf prog wants to know
>> more instead of being abstracted away like running in the user space. e.g. The
>> "struct bpf_sock" abstraction in the uapi/linux/bpf.h does not scale and we have
>> stopped adding more abstraction this way. The btf (and PTR_TO_BTF_ID,
>> CO-RE...etc) has been added to allow the bpf prog to learn other details in sk
>> and skb.
>>
>> Instead, design a better bpf kfunc to help the bpf prog to set the bits/tskey in
>> the skb. I think this is more important. tcp tskey is easy. just need some care
>> on the udp tskey and need to check if the user space has already set one.
>> A good designed bpf kfunc is all it needs.
> 
> Thanks!
> 
> Let me confirm again in case I'm missing something important.
> 1) For tcp, as you said before, bpf prog can extract the seq from the
> exported skb, so I don't need to export any key in this case.
> 2) For udp, if the skb has skb_shinfo(skb)->tskey set, then export the
> key, else, export zero to the bpf program.

A follow up to myself on the earlier bpf kfunc comment. Something like this:

/* ack: request ACK timestamp (tcp only)
  * req_tskey: bpf prog can request to use a particular tskey.
  *            req_tskey should always be 0 for tcp.
  * return: -ve for error. u32 for the tskey that the bpf prog should use.
  *	   may be different from the req_tskey (e.g. the user space has
  *         already set one).
  */
__bpf_kfunc s64 bpf_skops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
					   bool ack, u32 req_tskey);

/* "not sure" if this kfunc is needed. probably no. I think it is easier to pass
  * true/false in the args[0]. It seems tskey can be 0 in udp, so
  * passing tskey can't tell if the skb/cork/sockcm_cookie has the tskey.
  */
__bpf_kfunc bool bpf_skops_has_tskey(struct bpf_sock_ops_kern *skops);

For udp, I don't know whether it will be easier to set the tskey in the 'cork' 
or 'sockcm_cookie' or 'skb'. I guess it depends where the bpf prog is called. If 
skb, it seems the bpf prog may be called repetitively for doing the same thing 
in the while loop in __ip[6]_append_data. If it is better to set the 'cork' or 
'sockcm_cookie', the cork/sockcm_cookie pointer can be added to 'struct 
bpf_sock_ops_kern'. The sizeof(struct bpf_sock_ops_kern) is at 64bytes. Adding 
one pointer is not ideal.... probably it can be union with syn_skb but will need 
some code audit (so please check).


> 3) extend SCM_TS_OPT_ID for the udp/bpf case.

I don't understand. What does it mean to extend SCM_TS_OPT_ID?

> I'm not sure if I should postpone implementing this part after the
> basic framework of this series gets merged. Anyway, I will try this :)

