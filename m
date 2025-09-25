Return-Path: <bpf+bounces-69737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05974BA06B2
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEEFA7AB43A
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEFA302760;
	Thu, 25 Sep 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y484IEMM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD830170D
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815200; cv=none; b=HfrGN8Q6iO7pFE+NcRgbFjP8FGtGwRWRIemHzLXylZSKwq3e7pszCVPJaUC2AdKT8zGWbckLkYwwTXkgk1X7io5HnIaCf/F0Phm2gV8R0dksrlUM1qWV6678WJgT3gMV8A9QBkfV9JzXvZ8gtBwvQ68K19iun3WnLUw3csnpybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815200; c=relaxed/simple;
	bh=5CJLjTtW546J8tpkufLvEmsJirZuPDW94Wu+LVkFf3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YSoqvMNk03ryGNf0TRDyNI82OiOhW54DUBYAr9WRJtbMQZU9WAXLo00XWlIUN7YjmCb3uvW7qQgGdCzxkRbW4H5xdJpYc/e5rw0fMf/34nUX0ZRnwVJvD/nnbdmREOsxzxblC14fT6EaB40cukvHZkiIWTyVce9h8t2Q9XWCLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y484IEMM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758815196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxessgCFqOIjkxN8E3V+AacX2DwtplcyNFIAKPJSduY=;
	b=Y484IEMMqth/JEbEiL0j+BJFy4JptX07yOHZ5ZoqbPDdY1t7Hex+DTi8vb52gqv1vV0Dmg
	w91h6bIlli5vWnC+B4LvxVDrE/Laq02N5zytXr/IGm3OAljXW2sPdurLb377Pzubp3m/DX
	7WuPb6XsYx5PZFy1AxpcUlsmfwvS7lo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-9oJwukhoO1Ojn3FqIlNA_A-1; Thu, 25 Sep 2025 11:46:35 -0400
X-MC-Unique: 9oJwukhoO1Ojn3FqIlNA_A-1
X-Mimecast-MFC-AGG-ID: 9oJwukhoO1Ojn3FqIlNA_A_1758815194
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3eb8e43d556so975250f8f.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 08:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758815194; x=1759419994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxessgCFqOIjkxN8E3V+AacX2DwtplcyNFIAKPJSduY=;
        b=PMHk5MyIPrsqiWqGI/vLCxqccWT2+qbYUWH9X1dGSDFi8whaH9Bcbnrk0wk+WZQ+Iv
         bsjX47SXQ/+94G8y87oH5m11hisZS3Yh+8C8T9Kb7sWjJE4i3kxlKZ0Zt/zMfz/3XP+u
         r+Z3/hqSFObljVXwXQNBdq4ZEQHRTiJTal+gx3MpTXg0FoLllAWb7EWw7Yj5JP32EdpM
         AuGOo6aIR14Xi41493DQPaWgTLf07g9JbS9xZSsw1wzuzce/zPWXXhUVAn1WEa6I7F4r
         A04LQU/A970kUYRjVPFWWL/LHGArN7j7vOkcQXErxhUKxWEbK16MSN1lhR0wTmC5y7Tt
         N7cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzZYhqbBj5EVdbJQSUiVOyquv/U2rMDruyIBxDf7l6kva6NuBtfy5kWRj/28KgF/LYdNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3TmhtgoLh2DIFgUPAb+1RypwDECeJ5zwnOED7c9cb0ClSVZZ
	4k/74/rS/0xS/+yILn7XtFX7PU5UqwjvjBxusQuvA/Wpw98JHGsH6rW6nwI3FbmULAfYU3jFP/I
	RcxOKkvN5WtVNARIiTsZJ0S0BfD7Sf9PY3uuYgMim0WjBgDcHExB7gQ==
X-Gm-Gg: ASbGnctpZqUW5Z44w6MDJqEIGF5nywwm5Zrqx0BHK0RGftmzJLIP4mWaacL2JlFtrst
	sfjqkWrEvAn/10eGrNL36DdXqglGCI+lLTaACHCgkzwB2Nen2GGdh18SyJCXUNUS60OS+TVSWzv
	0bOj3+xnsbuVCDFMO2m4iUQFcski1IK/w5iM7hJ+biJAmZ0aDBiy100uPjp7f35WdZrhAQwEjU5
	twl4rnoUHI1SEZpTJZif0vp7OSBgx3VIdWKDPafFe3Pxx25oRMsSpOM6otauF/ujd4fB3KQqoKJ
	ae+OX6XLE2OwMz6nQWtr99wny1Xk/z/MOKegwHrcDLrUhvE5de/iDWWcIRrHwNbhzJfjicZy1qo
	fepPEZraXE52V
X-Received: by 2002:a05:6000:4305:b0:3ea:63d:44a8 with SMTP id ffacd0b85a97d-40f625fb96amr3794205f8f.15.1758815193852;
        Thu, 25 Sep 2025 08:46:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/k0nNfesW/BrVX/GL2okFEQbeth/drP6MINltdb5SEkxjqx61LbE6DaCG/45opkpod6jG0w==
X-Received: by 2002:a05:6000:4305:b0:3ea:63d:44a8 with SMTP id ffacd0b85a97d-40f625fb96amr3794161f8f.15.1758815193392;
        Thu, 25 Sep 2025 08:46:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602f15sm3410601f8f.39.2025.09.25.08.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 08:46:32 -0700 (PDT)
Message-ID: <b2a0cbdc-776a-42c8-8e19-051a12a1a7bc@redhat.com>
Date: Thu, 25 Sep 2025 17:46:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 13/14] tcp: accecn: stop sending AccECN opt
 when loss ACK w/ option
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
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-14-chia-yu.chang@nokia-bell-labs.com>
 <03d6dba8-2586-4ae9-8a16-26b84cf206eb@redhat.com>
 <PAXPR07MB7984B98035A3D3A1570F4AF4A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984B98035A3D3A1570F4AF4A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 4:46 PM, Chia-Yu Chang (Nokia) wrote:
>From: Paolo Abeni <pabeni@redhat.com> Sent: Tuesday, September 23, 2025 12:52 PM
>> On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>>
>>> Detect spurious retransmission of a previously sent ACK carrying the 
>>> AccECN option after the second retransmission. Since this might be 
>>> caused by the middlebox dropping ACK with options it does not 
>>> recognize, disable the sending of the AccECN option in all subsequent 
>>> ACKs. This patch follows Section 3.2.3.2.2 of AccECN spec (RFC9768).
>>
>> Is this really useful/triggers in practice?
>>
>> AFAICS it will take effect only it the retransmission happens just after an egress AccECN packet, i.e. will not trigger if the there are more later non AccECN packets pending.
> 
> Hi Paolo,
> 
> This is a simplied implementation than what is mentieond in the RFC9768: 
> "Such a host detect loss of ACKs carrying the AccECN Option by detecting whether the acknowledged data alwaysreappears as a retransmission. In such cases, the host disable the sending of the AccECN Option for this half-connection."
> 
> However, to implement the case that not that just after egressing the ACK with AccECN, I was thinking to modify struct tcp_sack_block but that maybe an over engineering.

I agree touching tcp_sack_block looks overkill. I think that the
simplified implementation is a bit too far from the RFC specification
and too simplistic to be effective. I suggest dropping this change.

Thanks,

Paolo


