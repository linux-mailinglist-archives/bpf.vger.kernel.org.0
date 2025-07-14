Return-Path: <bpf+bounces-63163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10518B03D2D
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 13:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97774A438C
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 11:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470624678C;
	Mon, 14 Jul 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCo43i71"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0E1EB9FA
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492015; cv=none; b=kszgcGNVMAiCTn9/sjtiiLoArDEpz2eBTWmYyUaCwQvqoj9PGsZTyAiy07mdsAq2dokZ6a/Vwag9CK1N6rR8ii8w3dWjUvYjwuRW0OMpNtOS5J2RJRqVwc4HAt4YRVticnsfhRl7N5A2JSxoW9ZvHVBV1RtbVOj3lquWsU2cLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492015; c=relaxed/simple;
	bh=U+ABV2Z/K8FhS1tVsDtWSNLoxl2AP1Zy78uF8iTobqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SiYHosKEo56ab6Ks3EahT9h8Y2lFulT33HEzXJyEwuQgpW/e2sVwisyuO49+yTGoQV6+KMh6SV7pmRLsCIdXs0L9eGsrV4il0OvCAZN+f0BbtEQ6dtjxYBVuUnXL0SeZIjHk1q+nBHfmj2bd1hMCBdfgtdaGJuJXdmbc6V2A+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCo43i71; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752492013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y2GjFqzQOcWBUPguZ9USD97IUATEowPrFd5x574Jlc=;
	b=TCo43i71mxbIFTPT/vwzSGnUEtXb3Hjb3IMFYn40LP3/UAwGr6K87DzTxp0oOAmFl9kFk1
	NlwV8UxpB5h5APA2ZXySSL3XxSEfiF4IoWX1qbRRA84gXQDCY5A8KeQ+rTy6U4ejmhwrho
	le56Hs2AM2PXctT+f8WTI+lT0ZV3AJI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-rjhotTtuO3mw1XxX1eC1aw-1; Mon, 14 Jul 2025 07:20:12 -0400
X-MC-Unique: rjhotTtuO3mw1XxX1eC1aw-1
X-Mimecast-MFC-AGG-ID: rjhotTtuO3mw1XxX1eC1aw_1752492011
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a5780e8137so2792442f8f.1
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 04:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752492011; x=1753096811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y2GjFqzQOcWBUPguZ9USD97IUATEowPrFd5x574Jlc=;
        b=HKHBk314B6noc9X+m9tKKWUbFhNV20K1jOV35jAl5wfX4nnkMNUpmxeivnRVmuWqxG
         r+OcxZtwGAB7QHd1gQUNW7hzfU1H5WoadEtKQE4CZWbKwWP60j8e/aodG7zYKh1gAHiB
         bJeee/tW4TBvPQ+NF0SmDVEsNeHWQyx2hKC/U+eZYdMOMu0iKDvhAJV0QpB/bL12yP+G
         fmhsTG1PDmyxaRBqJDlcYCX+m792uNbhRu+oJ/nRaskL5HTsH68Iae3GmAr8jN+MgH5A
         YAE4l3GkkpIuqK9nCBYSkVFJ8qdMOqIZMO7tcLCT5WmKAzKeT4pg9DjeOkFFsoZKVH6E
         N80w==
X-Forwarded-Encrypted: i=1; AJvYcCUqCgwb0QZAq92tuwLAqW+PM/hBwKnKITgrwi3/UJdQgPu9wFhvk6ADox1HFl3Yu6MRDrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9S7jKA8F5A4u0m2Cd/Pple6TOjPFPIg+nAJJlDQo14nV9g65
	dUxwbIFYRm79/jV6Zy91sBirA8rBaL5k+v96FJ9DAGB+smNEVdzWeR+JUKkyclnLMHfL+DESRLD
	74RpQdYh1Fx369wnWH7GYRLn/0SjfO7Bye2dayUFBgEckUIUYpvZXjg==
X-Gm-Gg: ASbGncs1gXcPdqK34sMBI1Xr8LgrhD6KCPlG08aDnNl2jp4Ke1mLq7RAzxuliJQQDCf
	P0uEJTdmGlq3sO3aNabULIgums5tvSBl16/0cW7/NO5DcLuAQi3JnRbD0FsKMNcGQGUZ4p7pjIU
	lbskJTCpAkPbV32vQ9k2MfTReZs+4g8PTZIWPuClkHXNeKveSyxzIs2mXL8hkrafLWCMIp99l8b
	/l4gvQYKBjRkU5IjofC1gThN7dopXeY+GihLYQbLuuJRhRDZMljJDAiq3SNlPqXq3jskbmt9KUw
	P9yw9JtimyOzWB74mILcn9cLtmXjlLZlxeZqQoSFON4=
X-Received: by 2002:a05:6000:240e:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3b5e7f13a0amr13230081f8f.12.1752492010670;
        Mon, 14 Jul 2025 04:20:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY5XrOya3yhJllGztjovrFQKpCxb10L3EkWzmPKdKNg7g1cHqucJ9l4yQULMvIkstPwMqvTQ==
X-Received: by 2002:a05:6000:240e:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3b5e7f13a0amr13230053f8f.12.1752492010098;
        Mon, 14 Jul 2025 04:20:10 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc201asm11984844f8f.22.2025.07.14.04.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 04:20:09 -0700 (PDT)
Message-ID: <b8f0ae48-b059-4137-9b74-f69c122f98f9@redhat.com>
Date: Mon, 14 Jul 2025 13:20:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 04/15] tcp: ecn functions in separated
 include file
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> The following patches will modify ECN helpers and add AccECN herlpers,
> and this patch moves the existing ones into a separated include file.
> 
> No functional changes.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


