Return-Path: <bpf+bounces-72674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0446C1800C
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 03:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FB31C60C0E
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 02:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A52571DC;
	Wed, 29 Oct 2025 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="lPEndVtb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32202E8DE3
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703694; cv=none; b=eFYTvSYAG9Ag3HZ+LUeJ4otY//6Tc73dRpQloRJNJReW8wizNbOWqN7kSez5ZtIqBNyzmVVwnfI1yyR8QkkJwWzyS7ZnZNyK+J62Fe4JXsEQb14P6e4tyQpiu/pxbAgAzJcwqEDCRj2tmJEPZKXLhrrjDWgTQhS9pTtDGptoZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703694; c=relaxed/simple;
	bh=DZB1KNfyJicdFq2XENqQyno5NTovyzK4zCwNpClQJZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uN2GL/KYIxNj0heMXS01su0at6YBLAI9Q5gPiH5oEsZ9gbGNHXIlbN9rYGHyRelrf0d9AqYKrBdWqdfE3+5w1n8yrmPEA0MpICjm07dKEPhhT1X6f3qOKQj0Uv7ZriXCOSBO0lb773GshmUHVlKRyagYC+qeha1Fpe16idQyVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=lPEndVtb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a4176547bfso3604154b3a.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 19:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761703692; x=1762308492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7eBpQyclD0Km8KHgiZXvZe1KUtyHdkLCjFK6BIXujg=;
        b=lPEndVtbWhF0dyxQA6qs/+vw24e1Ezz1axyI0SnQQ1Q03fo3+Ydyb1/dkbn15ECgcb
         HCJLWhI6vezFYdpsa3yBYl5pErsPu4rCsoWVnLwEmH28X+JOcPdptE9a7vs12VPMIeT7
         U8uDN5mHsxjE31R+CF7bYMyo0sQ51pmjxXnz0EnjpMFAqsBVdTxR1mVg/Zw45n4acZ+f
         OVIPme4jxaMoSwyxb55JCngY/Cz8trLNJOcK1s7xd+f4ObAfMQI23L7BH2FoFE91cTEO
         nCQZYIMhbzXXBwG+OQhoxt5O0/HWDy+PcCT+RTQ4CaI+Ex/7466nwvudYQQ8xjNvV/8F
         j5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703692; x=1762308492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7eBpQyclD0Km8KHgiZXvZe1KUtyHdkLCjFK6BIXujg=;
        b=c3jPH9eDVaY5uJm9Byxe6C40m0NOM0VglP1SmXRQ7SrDt8bjBNQuwcMpntxoEIvNZf
         6zs99KaQmOqnu3bl8uNdcGgg40Yeowzn/QjhdSm705kQdc/62fXouUfjA1t95db85qN3
         UmK6YGMEYiJPQf+73Nptw61th7RZyD+xksMXKDxnGbdXSnwaWXCCXScnxMpzbL4ZpuRK
         nWbsrgZAcxLKWI9jTH3OxWGQneS9NQ7hpgK06kmyCvMx8WXzXWIabmtBTWAsSKHspI7c
         zFqeb7/k26+kdiKqn1A5T5kUZ5HuZTSqFZoJTS0SY2qYvZxPiO2ZsiUVF8PvKfnV4Ux2
         ZkKA==
X-Forwarded-Encrypted: i=1; AJvYcCVXeT3jJ++wdEGGusNuGG3l1t5mGwp+Apo2ynzXdQI4Z7YNevnEdcg0StBYxdRxZS9egUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl1Vl7YxKN1vk/KwNRfyHY62Vap4MChmh/X2xI8IHb9QgSOU9q
	Jeqv5q4ergeQjyd1nY0qNzLZ3asitffDGYj63RJG7NHBHqTRQ8oUUeOXfUKVhO4bMQA=
X-Gm-Gg: ASbGncszPTDLj6ZQEnNoptzjZrB5h0tEBQoytvEFWzl35q1oLa5CXreSyWoTP5DpObQ
	aMAeVsp/D4GKbokcVmhKfj+3w/vwH855EMmwyDn6cX293j0HriFrC98txXJiVgrNXvDdRbfYcWz
	4h2f5Cx48KLClN3Tcv+yhkf8BZFKpVBSnFOl+V88bDX6Qj7xowTtpNk/Se6Zm1VQFVXpCYVN38b
	wphSkWay1tkFTNEH0t0l23TwfUA7phWUCsr+G4xDtcjGqU/78/Ddj+3tZG1FXruUTaVO6hV32zT
	lqiWOBWCF9NXTlaKYROhfQX+XCbQNcXKCHI+ggx87daGESc7JoRZPfoZItWlKrrD4PRuRu3Kaax
	FUiTwJcXBLoAQgdWH5jnlwONVDB0F+l0HY3EuIsOArpWAhmCY9VOd4tv+BMeJgwzp0iiQ+xV0RC
	NTL2n0TH7tuezXO8/XslG2Q//+uQnb+tdZ/+DtiDc=
X-Google-Smtp-Source: AGHT+IEWHDznxIYhkt4nsOAIu1DCYbl63hbFFlY4qk3uZRryNFT6SYOErTMxVSowKpCM2aBWKfmZ/A==
X-Received: by 2002:a05:6a00:2d0b:b0:7a2:81fe:b748 with SMTP id d2e1a72fcca58-7a4dfd08245mr1490684b3a.0.1761703691563;
        Tue, 28 Oct 2025 19:08:11 -0700 (PDT)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm13068960b3a.12.2025.10.28.19.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 19:08:11 -0700 (PDT)
Message-ID: <b6b3cef5-195c-40cc-8c37-cebdee05a5bd@davidwei.uk>
Date: Tue, 28 Oct 2025 19:08:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/15] net: Add peer info to queue-get
 response
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-4-daniel@iogearbox.net>
 <20251023193333.751b686a@kernel.org>
 <17f5b871-9bd9-4313-b123-67afa0f69272@iogearbox.net>
 <20251024161832.2ff28238@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251024161832.2ff28238@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-24 16:18, Jakub Kicinski wrote:
> On Fri, 24 Oct 2025 14:59:39 +0200 Daniel Borkmann wrote:
>> On 10/24/25 4:33 AM, Jakub Kicinski wrote:
>>> On Mon, 20 Oct 2025 18:23:43 +0200 Daniel Borkmann wrote:
>>>> Add a nested peer field to the queue-get response that returns the peered
>>>> ifindex and queue id.
>>>>
>>>> Example with ynl client:
>>>>
>>>>     # ip netns exec foo ./pyynl/cli.py \
>>>>         --spec ~/netlink/specs/netdev.yaml \
>>>>         --do queue-get \
>>>>         --json '{"ifindex": 3, "id": 1, "type": "rx"}'
>>>>     {'id': 1, 'ifindex': 3, 'peer': {'id': 15, 'ifindex': 4, 'netns-id': 21}, 'type': 'rx'}
>>>
>>> I'm struggling with the roles of what is src and dst and peer :(
>>> No great suggestion off the top of my head but better terms would
>>> make this much easier to review.
>>>
>>> The example seems to be from the container side. Do we need to show peer
>>> info on the container side? Not just on the host side?
>>
>> I think up to us which side we want to show. My thinking was to allow user
>> introspection from both, but we don't have to. Right now the above example
>> was from the container side, but technically it could be either side depending
>> in which netns the phys dev would be located.
>>
>> The user knows which is which based on the ifindex passed to the queue-get
>> query: if the ifindex is from a virtual device (e.g. netkit type), then the
>> 'peer' section shows the phys dev, and vice versa, if the ifindex is from a
>> phys device (say, mlx5), then the 'peer' section shows the virtual one.
>>
>> Maybe I'll provide a better more in-depth example with both sides and above
>> explanation in the commit msg for v4..
> 
> Yes, FWIW my mental model is that "leaking" host information into the
> container is best avoided. Not a problem, but shouldn't be done without
> a clear reason.
> Typical debug scenario can be covered from the host side (container X
> is having issues with queue Y, dump all the queues, find out which one
> is bound to X/Y).

Makes sense, I didn't consider leaking host info in a container. Happy
to remove the introspection from the container side, leaving it only on
the host side when queues are dumped.

Like Daniel mentioned, I didn't add 'src/real' or 'dst/virtual' because
I believed this information is implicit to the user when querying a
netdev based on its type. Do you find this to be confusing? Happy to add
a clarifying field in the nested struct.

