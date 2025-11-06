Return-Path: <bpf+bounces-73815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9041C3A8E9
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 12:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CD31A41DF1
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 11:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF68A30EF8F;
	Thu,  6 Nov 2025 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxyrdjdc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxRNAGsc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2E230DED5
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428397; cv=none; b=VbJmz9nN3MwgrXC5JXWRn4y84rhscCTObKaAvLVmAFhNTvXDCULF5PZZ8W4DTMDtQKqNSqpPM/XYJ4oQCnPPyDd7uB9Qcynt4Apdjw0RnP5W7QgJu3YjLpm1p+Wr0KAjaW4KF+j+tgKMETJzlIEvJNMSaPxZWwWElrwiAtRC5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428397; c=relaxed/simple;
	bh=dQJ7UpGrlfHCXR4jDF4h6g+I9lA0nUsBumN+lVkpg84=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ARnyk/8WB/k5fSBso3INCPt3mSCebYHgmV7sPZnZSU3eo1JANeV4ppP30sY8LfZ/7pgBHSqbDmePjL1mBH/9V7q1woYTPpjJnbi4VQb3d5rRUwcO74iZbz6sUhwaSrMSdbOit//5W42BwFHI31PvYFCSjyjYyYsWsMCIuoVVtsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxyrdjdc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxRNAGsc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762428394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2soIc1bWuVzdGmA3cL/c6qe7E7yX3XgCWZMG0VXc8s=;
	b=cxyrdjdc/acVKs4Yld/RSf4H6hmRVQ4r3tiC45C/rsr7j/bikdcaDTitGKRnzyyT+UUY3q
	39F/Xbf2Hi1EsYyr6aAFHsvy1pEpjp5QegJrS+vShnSWyyorbm3rX5RE+AMt1WTR3f9jlQ
	0IaIe5Cv1TYWGfNPLF9EQbQgdGtrm1M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-wiAwZZoJP6mXqISbC3IHDg-1; Thu, 06 Nov 2025 06:26:32 -0500
X-MC-Unique: wiAwZZoJP6mXqISbC3IHDg-1
X-Mimecast-MFC-AGG-ID: wiAwZZoJP6mXqISbC3IHDg_1762428392
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c521cf2aso615978f8f.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 03:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762428392; x=1763033192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2soIc1bWuVzdGmA3cL/c6qe7E7yX3XgCWZMG0VXc8s=;
        b=DxRNAGscNsdKU4rAsykkjf7xySlwZcWLuYCoLalPVvdA8G4oQpsKoDVO3DhakDYyO6
         ljTVz+ZHaAmjr19YWoxHKuOkxYKuEqFEtNPyejVAHsoyHtfuI7+DDy2Y5JuvANWr6CRu
         Pg2nkk9L5itwCSE3XwIpeNFBRm+++1jV4C8qJvaNnIAyam5y2Uc0Ry4rekskDm2JSl0n
         19B1TGaYTaLucCo0DGz0g7CfbwjjAKjjC1pYbYlRuSgnpPBjuANwFbhO1W06KJHyEvsU
         JoME8sn8gMiJInv/gPmzfroi9J7s5pVIwqgbywOozSMNpbic/LKR2ma+ib6/K/4TwTl5
         ToSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428392; x=1763033192;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2soIc1bWuVzdGmA3cL/c6qe7E7yX3XgCWZMG0VXc8s=;
        b=VYiNywKWfsCmZzHzNyu9eqAdyfqGGeS3bsJxdWBApkhXDTHLg3Q23Qjd6nw2Uj/4Pz
         LW/6+IWBW9tiChLdMDrWDkwry6eolaUKvmYkZ1BiCfCUSeOhNoDaUM4gFiONr2DemG5S
         bTjLbSVjmPi5VUanNJp1VqGjL251H8qrmLl9D1iHNRR/BJfdJWjLkCU3jh/+f42lZSHa
         apY9NptVmEVPqINIx68HHTR1elxilqficozM5kE1d1fVNNgnnd6qO4RdhmxDcufixg+5
         4izptyjIBTMgr99lo51mX2kgcjlCEDQthpd2o7H0coE3G3YVAPooTCPbTo16omxa8tl0
         WPbg==
X-Forwarded-Encrypted: i=1; AJvYcCVQVB0vRGl60qhNOavSYS0AcsDuLFDoI+bzkNTOsxuCQ507gm38DTZ1FgdqL08/j3IEpq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze+HOuxN4SC8mrXa5UuhUli9+6B55MQkH3PRiBzrnuJP6CXpOM
	YZ3hRnoJ4XXvaBGlEw7/BywqIeGneTePCkU4DNXxbFrOvqWbJW8WCwP9+Psu7NviFKLrMGZm/sS
	RRP8EagPzWGnWre+iEcucS1oD6GgOcNsn2UkXqBx4mJiAaWXZdmlIgQ==
X-Gm-Gg: ASbGncvyT032dB2mxNS47S1iefojatKyRHk7ru4wQ8ZX9w6MXsK6/MNWFggUOx1/bNl
	rQipBBMNoFoh4dIY+1l4O8W49iRQ1TB+d6Zhn+saw41n3XX3w4cSTTpYZfMBCaDa/inp7iwfArC
	kEu6FGT+qTNAUrWnmE/CzQqwDrHDEhnwsXvQm0Hk5dpJ9n9y8sqCH6sRSk2gwzS3FE1rWoe1Mk+
	D8miyXfcSHwBhN5WFMiy+dtogIF+4vCiaEIkWOuWiEihaRfCyctlTDFT/WtPus+KJZc9Lve6C6D
	5z88BwNt5KTiRfz7+fhd8cUnpfcJKUot1rI6voERqYhSbxD/vK1rAwmWmdW3l0oq4NEIN1cAiGb
	4mw==
X-Received: by 2002:a05:6000:2882:b0:426:f10c:c512 with SMTP id ffacd0b85a97d-429e330aacbmr5599519f8f.43.1762428391632;
        Thu, 06 Nov 2025 03:26:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTk4Fgt0+Mi1XCDO47kQQbIjxqGs2on8RBp/UBF82QmihADe45xfIjJ/TRK2eqLeeu+VVD/w==
X-Received: by 2002:a05:6000:2882:b0:426:f10c:c512 with SMTP id ffacd0b85a97d-429e330aacbmr5599487f8f.43.1762428391189;
        Thu, 06 Nov 2025 03:26:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm4564491f8f.32.2025.11.06.03.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:26:30 -0800 (PST)
Message-ID: <1c79daaf-c092-4c49-a715-52aeb9688b48@redhat.com>
Date: Thu, 6 Nov 2025 12:26:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
From: Paolo Abeni <pabeni@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-4-chia-yu.chang@nokia-bell-labs.com>
 <f98d3cab-7668-4cf0-87bf-cd96ca5f7a5b@redhat.com>
Content-Language: en-US
In-Reply-To: <f98d3cab-7668-4cf0-87bf-cd96ca5f7a5b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/25 12:06 PM, Paolo Abeni wrote:
> On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>
>> No functional changes.
>>
>> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
>> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
>> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>> ---
>>  include/linux/skbuff.h | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index a7cc3d1f4fd1..74d6a209e203 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -671,7 +671,12 @@ enum {
>>  	/* This indicates the skb is from an untrusted source. */
>>  	SKB_GSO_DODGY = 1 << 1,
>>  
>> -	/* This indicates the tcp segment has CWR set. */
>> +	/* For Tx, this indicates the first TCP segment has CWR set, and any
>> +	 * subsequent segment in the same skb has CWR cleared. This cannot be
>> +	 * used on Rx, because the connection to which the segment belongs is
>> +	 * not tracked to use RFC3168 or Accurate ECN, and using RFC3168 ECN
>> +	 * offload may corrupt AccECN signal of AccECN segments.
>> +	 */
> 
> The intended difference between RX and TX sounds bad to me; I think it
> conflicts with the basic GRO design goal of making aggregated and
> re-segmented traffic indistinguishable from the original stream. Also
> what about forwarded packet?

Uhm... I missed completely the point that SKB_GSO_TCP_ECN is TX path
only, i.e. GRO never produces aggregated SKB_GSO_TCP_ECN packets. Except
virtio_net uses it in the RX path ( virtio_net_hdr_to_skb ). Please
clarify the statement accordingly.

/P



