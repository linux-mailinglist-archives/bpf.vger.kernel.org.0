Return-Path: <bpf+bounces-63420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07AFB070A6
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 10:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F953AA57C
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF0D2EE97C;
	Wed, 16 Jul 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ot7ekC/Q"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4469326E6F9
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654821; cv=none; b=Fi2Vji/qonztPSdGf1qLLk/J1lBz3ueSNDAXQ1+dBTZ+if+ET92du79ZUnViADWOTQkfSvyGcpMzk9iFIYGuWuGz4iiD2T2kGRvm0aJikZnOXycU4nS41zihkplF/6r45+MvM9VAbkbjIr2wwJ/wYd1vc+S8PJwO75fP0PaSvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654821; c=relaxed/simple;
	bh=PO/hVtAFUJcvYOoFA5Lsz2XawUBmB+drYH34Ga9YmFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D1NLPDwyy+HhZwI8JPivmITzfERDSrTVxBVcc6IU4AYtRDbrDFl9iUHZlyHFLKouuX1fBI6KzdTLSef5E2J8ixL7XxigUkCiqwCrGD3pN12L4/tu5ROkfR+aGBXrMIasGN12NZeV9iTaLJCxSxEz7XV5o7qq7glCg8RLWA+FvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ot7ekC/Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752654819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/mMMz9r3dZS5fLhT7uV9k7AsWyXJpRGJaGcTiHmpis=;
	b=Ot7ekC/QeQO4d7qwMfesFi7OCIqtRsPrkTp3ZurfiwbfSLW0ytRCfHWH4uQK/aSDQk0K11
	ZWiXuH9fdohWhmLNW6R09fQT/VLBtb/EGuKRKJxYd1Xebqv6pJn3Z/D8MeuvfTuGeYAgyD
	RaJsKUo7I+VecJJRHDQNfPaGkDm1o+k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-cyh4thZbPjGcYRpNy4A_-g-1; Wed, 16 Jul 2025 04:33:37 -0400
X-MC-Unique: cyh4thZbPjGcYRpNy4A_-g-1
X-Mimecast-MFC-AGG-ID: cyh4thZbPjGcYRpNy4A_-g_1752654816
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so2625205f8f.2
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 01:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654816; x=1753259616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/mMMz9r3dZS5fLhT7uV9k7AsWyXJpRGJaGcTiHmpis=;
        b=YzvDtzcSKsVumo/qZiuqAbSYKmSEbAw63d3p3IacOJBteknHH3K62B7dDscq+r6YSE
         J9IhkwGrNqV3S5R/iKZt2U8uWBEAT1OdJka8gio0Rlexrx6nKbQfN6FpN3QpfHhj1MBK
         wuFKPfSdq+UrJ58KYVymyoevcvfgc69ECENCuNeXqetcMaxjAVShgdRilhwB4+++ZE6l
         ulAYiLTeULKxZnh4jN1q1mI4ro4C1oEsMRsYUuDmXyxo7U+En9KaNDbrJs+X/EFL/zIr
         CLGWN0Wps2nk18M1T39CA/fMzOoy0x2Zhrxrx7iHtMBo8pc5utsmW3bh5s5KxElwjmEb
         d77A==
X-Forwarded-Encrypted: i=1; AJvYcCXUc30e6Oe6p7bzKFLPh9p6N1SbJP5twzQU3vnl3MxYEGbDLW/MkbsIoJpHSrskJFOPKb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEHiaAF5++aJNAdGTlQtorlw9trJi4pxP3zRSl1cYVbW0a7fHC
	Nh8oQIuh78qwyDcp7w5oasPHrsBiLL6CYNOnxDAfi32SOVk7dyIIAa9udVIi0fkzyRP6BdpC1Mx
	G7kIHXRH/s81eLBqRdFiT7NtAqvyg9FPgIETA9o9oDil4B01W6/2hog==
X-Gm-Gg: ASbGncsvW8+Cz5AWO9Vc9kWI7HznBI69qi8kTCdSM3RFjQabBE1O/jLGGeI46V5OzhI
	VYKURu8XPm8pdybjIbwCF7kKXadDyi/r784ajGjoN60gDcZpdbX/vrXx9rLshhgyKEHTQ1k0SxG
	WoU8Gs3WsuB8be/ebO01WJmWBQxTnFuBIKBx5ajLX740TrQkIccX/FzkL8wOE939xYXj0lei3p6
	mahlEdVxg1y95gotpCX2e+z0LbyCXPYv5JFgaN9lum9kt0NlekKhsSJJ/FQ1oJmcF3lsIUyyBxL
	ndTXpgLWTv0/fZrjDI1wsjRm+RjdPmHYrb3lSls+8FNQTdzSkhFLTZYbWyiWbJ3g/u61ESE4pI2
	rfsw9mj8sL3I=
X-Received: by 2002:a05:6000:2101:b0:3a5:67d5:a400 with SMTP id ffacd0b85a97d-3b60dd7ad32mr1289762f8f.33.1752654816264;
        Wed, 16 Jul 2025 01:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9yD8/Rt4+/VGcbyULapP54i40HRfZLKuicTBEq7LAucDsT5xtqNB3H6FZ/JdSK6n94pjh2w==
X-Received: by 2002:a05:6000:2101:b0:3a5:67d5:a400 with SMTP id ffacd0b85a97d-3b60dd7ad32mr1289729f8f.33.1752654815741;
        Wed, 16 Jul 2025 01:33:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886286sm13769075e9.26.2025.07.16.01.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 01:33:35 -0700 (PDT)
Message-ID: <514ca303-149a-4f7e-a473-31051fb7162b@redhat.com>
Date: Wed, 16 Jul 2025 10:33:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 12/15] tcp: accecn: AccECN option send
 control
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-13-chia-yu.chang@nokia-bell-labs.com>
 <b2c0653e-077f-4609-922e-777f1d868dd0@redhat.com>
 <PAXPR07MB7984D6FA40FF000E51F694F3A357A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984D6FA40FF000E51F694F3A357A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 5:14 PM, Chia-Yu Chang (Nokia) wrote:
>> On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
>>> @@ -285,9 +297,33 @@ static inline void 
>>> tcp_ecn_received_counters(struct sock *sk,
>>>
>>>               if (len > 0) {
>>>                       u8 minlen = 
>>> tcp_ecnfield_to_accecn_optfield(ecnfield);
>>> +                     u32 oldbytes = tp->received_ecn_bytes[ecnfield - 
>>> + 1];
>>> +
>>>                       tp->received_ecn_bytes[ecnfield - 1] += len;
>>>                       tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
>>>                                                 minlen);
>>> +
>>> +                     /* Demand AccECN option at least every 2^22 bytes to
>>> +                      * avoid overflowing the ECN byte counters.
>>> +                      */
>>> +                     if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
>>> +                         ~((1 << 22) - 1)) {
>>
>> I don't understand the above statement, I don't think it yield the result expected according to the above comment.
> 
> Hi Paolo,
> 
> I was thinking to change it into GENMASK_U32() and comments like below.
> 
> It is intended to send AccECN option at least once per 2^22-byte increase in the counter.

Ok, I see it now. Please mention explicitly the above in the comment and
test just the 22 bit.

/P


