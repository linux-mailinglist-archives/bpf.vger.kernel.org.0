Return-Path: <bpf+bounces-69664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D1B9DE43
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A8338269D
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4F12E92DA;
	Thu, 25 Sep 2025 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQGF6bA+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E81A2541
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786278; cv=none; b=LXxDjP7j9+LMAa67jvvO7ekUSFVoBpQZ8Vdy1kj1quIBnw8UBEpF8tvsSmmipLo0lBIUCuhnhuwauPx/SA238OvuEZPkAlWq+ByyTkQd1mnn0jB8WTfnYcZmSIDOW0OMMf/u9sEjzcpY/cXzoNEryK8p9ynzzLT//NCueQipqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786278; c=relaxed/simple;
	bh=ugLehOMIQJ+Et15CIYTCGD2MzcB90KpcWiFwRf+O/xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoiGbBWYe1I+SVPLWajHv2ytzAHnsvA6viKxuyc9SpQEjF88MOwVtPBUWX9i3iDtyfZptWkVgFxS8/N0laOg/GJ7v9PeKqJ1mjas2uI+KVqUpDC27jWHyvC4xEd7eKqezd3QK/yqL+T/E/KjMd5QD2MjPFnMphNnc2MMwM20XvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQGF6bA+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758786275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEtIyjQBQWhfMNa18kEW2ePRbLcIzRH3NXOv/vzbj6M=;
	b=BQGF6bA+xSE9OJ6KkCNX3B+m3YuoCwY1tizasl0TOBx+9ucDS2aG7YUBfHmSyuXZlRkUD2
	3sene0uAh0oQ8C8bC1NGYt77yHIR8v8O8R4o8Ghi+YP77BZ0DcJE+187/fGv/oC+JDf8Kx
	YHFhEqu4QO01kmRT8mxAVWsTizPaSTg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-k6BWKC_qNfCj_q5varz6RA-1; Thu, 25 Sep 2025 03:44:27 -0400
X-MC-Unique: k6BWKC_qNfCj_q5varz6RA-1
X-Mimecast-MFC-AGG-ID: k6BWKC_qNfCj_q5varz6RA_1758786265
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e303235e8so4110645e9.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 00:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786264; x=1759391064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEtIyjQBQWhfMNa18kEW2ePRbLcIzRH3NXOv/vzbj6M=;
        b=kSbJBXDsMpXNEIzZnDjpy0d9OiG0/AJ33VJeDMsW28i5mY4B8Rgq5+5bCPmRmlcvQI
         hD3npeh3yl6nPti4visqXjd6DEhyFIOugkg90RM+qpdYjont2XR0+JdhLqC2ufpTP/Vw
         znIpNZJxmje+iT2pMiDxKkosx9MEnW8t6YKKiUc+jz4il1Ac/7IBFI8tSIZRde9FSj3f
         JlLnw9NXGttYI/qfJs2iF0VUpsQ87MuTizJ09oWK25Ac0tas1pJy3ZWRYqwl0vxB3fBR
         9dlz3B8jJ9wqpuZGz1rVy3ZBc9wDPEekAlr2uCrbPYJMvMg22qvKynyt0gU/xxEBOZmm
         XnjA==
X-Forwarded-Encrypted: i=1; AJvYcCWa1zwCqvKf8gl36P1OtbZkVhv1xoE33rYb2sKI5tVN6TUExqodrk9RSrwL+VZn7qCI9ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrc11D9jBiqY8WshaTCoosTC+0Qovze7Vb3OEj1S2n6j4eetYY
	W8cxzGtSK523w+ODJl1OI9hqnHAriDQJqvGI/mRTX3Cy06DL8cr1mybHnR1UbEu6iJ5qAbLQzgl
	vE5iDTAh8jZe+CVpd2QoUEIGTn3xqgMC/vgD2EC+YzTH+3yUVULAWWw==
X-Gm-Gg: ASbGnctsRHDydpp/P9wCSTcOeMFEHUEiOT9xH8jNBw6Pupb+2rhJ8EEMUXQBKwi437A
	woMRakLkHqjFvfp9jVbiMFfjaurXVY/vLCAciLhkCarwZL7MCv7EU0x5Sd/7wbWyjhmm+S7Xmlw
	kFuCOeVa4YNm/WHj0pp8nK8dZRlRHp2lKJm6YF9isuM1gp+DQ669C4YAvljBoGUAZYK+QVC1qai
	KyeTBhC7dRqo8+wZFCB8j4+36P4lS8AQuCrqFF4MrDvGXXMiyO325G2QB7fMnccEGCGUlQaYQZL
	4GY8WvNn1DDNZ5aGr1hKC2wXPwvaN4XdIg02CCamgpm+DUp8xAsmI3M1gpLlS+9gwNG+TKqycoh
	5Pt0QtyCfhCcI
X-Received: by 2002:a05:600c:8484:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-46e329f653emr17736415e9.27.1758786264600;
        Thu, 25 Sep 2025 00:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt7+vuVFRubxJxrOllWmSQM91xay34blZgLFJjzErhlGB9fkTHJc47Tm6tJsYcxZXKKZ/Mjg==
X-Received: by 2002:a05:600c:8484:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-46e329f653emr17736175e9.27.1758786264164;
        Thu, 25 Sep 2025 00:44:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33baa625sm21917375e9.7.2025.09.25.00.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 00:44:23 -0700 (PDT)
Message-ID: <ce0f60b5-858e-4d88-904f-5f77bbe82643@redhat.com>
Date: Thu, 25 Sep 2025 09:44:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to
 rate_sample
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
Cc: "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-4-chia-yu.chang@nokia-bell-labs.com>
 <161c09cc-9982-4046-9aa0-d0ec194daba0@redhat.com>
 <PAXPR07MB7984DC6C693DAED54AC14161A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984DC6C693DAED54AC14161A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/25/25 9:40 AM, Chia-Yu Chang (Nokia) wrote:
>> -----Original Message-----
>> From: Paolo Abeni <pabeni@redhat.com> 
>> Sent: Tuesday, September 23, 2025 11:48 AM
>> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet@google.com; linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
>> Cc: Olivier Tilmans (Nokia) <olivier.tilmans@nokia.com>
>> Subject: Re: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to rate_sample
>>
>>
>> CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
>>
>>
>>
>> On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>>> From: Ilpo Järvinen <ij@kernel.org>
>>>
>>> Include echoed CE count into rate_sample. Replace local ecn_count 
>>> variable with it.
>>
>> Why? skimming over the next few patches it's not clear to me which is the goal here.
>>
>> Expanding the commit message would help, thanks!
>>
>> Paolo
> 
> Hi Paolo,
> 
> Sorry for my late reply.
> Here, ece_delata will be used in the next patch series by tcp_prague (or other congestion control algorithm) that support Prague requirement to adjust the congestion window accordingly.
> I will elaborate more on the patch notes, or you think this shall stay in the tcp_prague patch series?

I think the latter would be the better option.

Thanks,

Paolo


