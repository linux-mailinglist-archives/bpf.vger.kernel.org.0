Return-Path: <bpf+bounces-73817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E731C3AB62
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 12:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117F23BA7E6
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3773101DB;
	Thu,  6 Nov 2025 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdEyq71R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lnvYLxbr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E273310627
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429344; cv=none; b=kDNhPEWtjg6fVzYx0tMK/6Azm+OTFMrL0iMH0BNQHqRxUaaw/CiG8pwhNM4jg006b6PcAku7NtB65kItSeVM0ye0WS0n+aVbNY92gKkgG9TO9ON17RV9rbz7pzdYQLw/8y1AapabN8REjxdh+JuOtaw8aGiebxp4L20J2QlFS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429344; c=relaxed/simple;
	bh=skC26cRzfhs694yk1GvmPhOCKjrsCkj5WGjm2V3nag0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YADTbi6BeQjDilr6d9TTkERVwyZILZ6rOkw43v7WNU3P6vbB+hXHgauL4g4pYLwABpQR8+eg2IAHguN6R3DbBZLU7Wx+W3Bnk5VhGK+134EgrAzJDxe26KSEG5iu8a+mlaeXnFEph9z58CB0loWY7I4rK+mhfC7BHtYLTGOBE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdEyq71R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lnvYLxbr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762429340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yI4sLrgM9n4bdj8hOJQf5//skDa3nIIok/oPWCQb8k=;
	b=YdEyq71RCqFAJgz6OBuuP0L5rIylrDW2XGpa3TRB8cM2kg2ZJ16bcBrK4INvzCGmaDRpln
	8NmXaQOf3uBxYgVR9JX5jVeBeqP84tr5dapc66jDyL8We145yR2bioCKhQ5ZSIahoZLoMr
	H78m8atfbyXFd/FhuR0u5QWpSzuK1ZU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-8EZWGvlVM_CrhZA_NmmRbw-1; Thu, 06 Nov 2025 06:42:19 -0500
X-MC-Unique: 8EZWGvlVM_CrhZA_NmmRbw-1
X-Mimecast-MFC-AGG-ID: 8EZWGvlVM_CrhZA_NmmRbw_1762429338
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b6d7405e6a8so271341266b.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 03:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762429338; x=1763034138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2yI4sLrgM9n4bdj8hOJQf5//skDa3nIIok/oPWCQb8k=;
        b=lnvYLxbry/U9OU0LBYf5XlgU6ioCAzO2geBEsRSwpVkyfcxFo7PB8igo5pBex/t5Nr
         mQS76EBVyKHa8HMEf/zrL6c2Xm3dSs/KDGQq6F7gPC9gGvYCeeKrZmWb1flnQLlJVCgg
         zNgxJ1f6ZccUjKsUp9lZBqeYMLuy0szITyR5laghUJdL9Xriz2uMUE8/Tk/mz+20mwFV
         OL/zZ5csXkRH8Fz1N+n4qz3pnbBiRq0CtcOjOM4Ni5nhQbirr1gY3c4qUGWWobimbozM
         lz+vaURRuW6IbKx4uzcsglhScB2ybHUKjqSsIboOMCtl/5HchlUHgN5H4I9LtFYxviRV
         YK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429338; x=1763034138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yI4sLrgM9n4bdj8hOJQf5//skDa3nIIok/oPWCQb8k=;
        b=vWG3vr2s1BGSNzn3YJD0Icr8xjUoHa6o2sjfQGUDCt6ZcV3iBk9Mf0thOh2cLvxYzD
         Y+4QOXvWd6BRV9S+pcGhdVB4DyNItgaPitmVG9aLpbGWO+awPP1Uz9/5fVmjBbzHrDoE
         uVbnMaI6QoS/FaED1fxOgEVflDr7Et/bOnNuwczaoo+0mvKzHddfloRKFBqSAnpBdLgV
         NSSNOonf19l1QYc+XGOaXE7jWe0vbqEk3J9YnjyeSntgWBkjYU7N5MkEjIByvrM7QfpO
         29cWej1sRpnCx0f1nPaUjAC1+D1iwZFrdmoqi42QRKp//rqyVGCyFQzCmz+fmfaWsHY5
         PlOA==
X-Forwarded-Encrypted: i=1; AJvYcCXn4COgTaYQzzKXRZ+ELOkszqo3izCyEq2ORoSiAL08W8YoNT6l2efmmC37UQSH9TXbukY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObjvTVxxdUZti6u6MXKs0LDNZu9ld7vQz31YpWl/uKXeq80bu
	PYdvpiWr7zyPoyNdnzAfBzMtA5Vs4q1STSuI+7k1aak4v9pTEszfzQkWm6t9WBNg0o4CnUY85r8
	aZVy/a3PKywyvWg7SUuzLHRhk0fycYhZdYv8s+XQjDz0UQnYOHa74MA==
X-Gm-Gg: ASbGncvzwpKt3uvANqNZ1jqg1ihGCuXtydxRbNdpMPGs68G/FfDsqgAzTZPQN3Ft4CL
	4Lg+Hnz7i7l675k9jeC5rrQARaBIKw5M33vGtCYEOM9DLVw3v17lgznIYHFE3UDfPQNzEqULus0
	9pgWEPlO9cA7I3844CTV7q9jI/9U2NiDOmqMM4K39NHgLrFA7/Ahl53ZcyNtKjh5mXeix0PoDqX
	Rj2uh5a3JAeEMdODOGe59yShjbBw2SeOYIw9q6/WDgzZKTfcEQjLK29z66Tkn2EIOLM9rOhR/hp
	98th+UFSyzqmwmgHCiv21aLu997EEzaobnyafDMtGcgYKTay+k7ioppMZslgT2H/XQ5It2EGrsl
	dJg==
X-Received: by 2002:a17:906:f591:b0:b70:c6ee:8956 with SMTP id a640c23a62f3a-b72893d8e8fmr339800566b.12.1762429337653;
        Thu, 06 Nov 2025 03:42:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOB8p8VKAkDWd7Zb5ZOoLgXt76WYCHhozdvWiOM8SoWc4iM6IK84Od+ej6rTPGojaDwrxUhw==
X-Received: by 2002:a17:906:f591:b0:b70:c6ee:8956 with SMTP id a640c23a62f3a-b72893d8e8fmr339798666b.12.1762429337263;
        Thu, 06 Nov 2025 03:42:17 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289645397sm194955666b.41.2025.11.06.03.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:42:16 -0800 (PST)
Message-ID: <aeaa5b5f-8697-4431-82b1-c890d67ebd41@redhat.com>
Date: Thu, 6 Nov 2025 12:42:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 06/14] tcp: disable RFC3168 fallback
 identifier for CC modules
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
 <20251030143435.13003-7-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-7-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> When AccECN is not successfully negociated for a TCP flow, it defaults
> fallback to classic ECN (RFC3168). However, L4S service will fallback
> to non-ECN.
> 
> This patch enables congestion control module to control whether it
> should not fallback to classic ECN after unsuccessful AccECN negotiation.
> A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
> behavior expected by the CA.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


