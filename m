Return-Path: <bpf+bounces-69369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FCAB9567A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 12:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33872A0543
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A089231CA5A;
	Tue, 23 Sep 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkowXnC1"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F6313536
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622459; cv=none; b=UDDuE8SSx+N1BTtCLJIOwH6sq0D13+3j9tTvSI2tganOk5VHHiM4Fy7Vck09RmLLj02TgBMoZo3mN3j3fgQ4C33SXc81cVmvb49GOXEnOVF6fTmAtq1ABrydid4rzhxb3sNODZ71GajT2V43KhaAmxtYxHqq5g35IKk595x8xWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622459; c=relaxed/simple;
	bh=PB7RTh2tkmTB3/Z3OmF5DIITDSFcvCKR9iFhCuOZMCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hNgz231qyxIoYOMiYSYXdygotZdcjPeE/uQepp0yXDzu4vwbEU6e6eHe5agQzDx4FrgnjcbYFSpZ8J0kA/blWJv43G8aKvMz+j739XGAUjPhmHiuUDAlAPrDg/lx4WnYSaJVKgHyHu52IE8H2W2oPHlXbkMDUCndPQ/iZGHUNsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkowXnC1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758622456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvoidjNPKx0LbqZQ6ZyfhvwOmvcCE/1oZtLmb8HEGok=;
	b=OkowXnC1OW0RKcegST2Ir2K+ZsPJ/CmhBLDL2jLRzey/+1DB6v1EsEX0skb8fWAz5tqCLD
	AzwkQ0I2Y2DprrESAs7g4neHEfBhox7PQTG63lM1kXtmsDXRL8zwCHTjL86nBJrtd/QLO+
	g9Ia7QjTVWcnKOlKVeWtf5XKWoID2DU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-Z2ZRTwD6OkWcT7rxmCrkjw-1; Tue, 23 Sep 2025 06:14:15 -0400
X-MC-Unique: Z2ZRTwD6OkWcT7rxmCrkjw-1
X-Mimecast-MFC-AGG-ID: Z2ZRTwD6OkWcT7rxmCrkjw_1758622454
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb604427fso29889285e9.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 03:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758622454; x=1759227254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvoidjNPKx0LbqZQ6ZyfhvwOmvcCE/1oZtLmb8HEGok=;
        b=fSMsZUxwbVn/bSTEN9BJ2/AMaQzMpLiv1SADlFPC82LPs+vF319QoA+BCFx2tjF126
         7DjjjfxlXKGqJtm2Jf8eR68x78btGPChgOFRwlpSvtnoPPdES92rzhelRrp5HKAp2m74
         s5m/qGoWzJPITQwd8+n4sfHhIc9wMfP14vOYKzjZG5+EfwmkV/atwtKMv3Bn20fqVWEH
         Tl3Qb61v9tZlF42eFsN01yxegXZ8C5fMabNirgsMTxvLOhEnAKc5sOUeSgSH7Rv2C5I7
         GhZZoHyZt2PRbhc2L4Yq0r7HoUeb0qFXg1EwzThfidGdKK3NJpntxOPfamEomuxS2mRy
         mU1A==
X-Forwarded-Encrypted: i=1; AJvYcCXIvhBKq2SadG3q7Xou+mAAZo9jxhHLi293PiRu7rox3rPkDx0AgwCxJL5lA35OlbOxS30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHg1tRyVexlKM7O7md/296OwORz5WkG57KBysLq3WkKjjE2mW
	VnoDbdEpnxkMcHCPxt3mS+EKUMSzKqhp7rQ3RogpOyLQko/vI6I9/E7UYyPb0BkT7PpWvq+GnwG
	rt6oJP0e19CDccUclOiYr0s7NQLFpK/wDSlpQZ6T0yc6aU/k9DC28Fg==
X-Gm-Gg: ASbGncsgetGSO7NZAwIv5tSSl94VJVfR5kzVx+Jmpf7uPUrKC+qybl+eLtT3syEqIdd
	2w+PBF6Snvs5etWsIEAqOpjp+4PUBV8EUcwICw4+DRNKFCskqm8PGqMEBgYvwDX9+/9SQ02FssM
	WCzC/f8hjSVDh2VMFPjyDVWQhPbI/KCEGtn2rgGwoFXvAKm1efyM1dxvssKWlhI3w3AEQK5q2lr
	77mZtSqNLrkGPxzs6Qp7Ic9iTBEzog7fJsgMZkaTER3CXZTs/ThZiAPyTGLCUpw60uFytWePA9o
	aF4+KeV22NIcoX8/aUbksjSh0eW9NwY6oZ8Lwf9Mpfy2qi8gl71ohMzDwsKX4XMBXnRbYNLSMdR
	czPsvxhJ+NA/t
X-Received: by 2002:a05:600c:190e:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46e1dab8219mr23578695e9.24.1758622454126;
        Tue, 23 Sep 2025 03:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfxcysg2CPLWO7CKaUjf7VjUD/s/qwqr1QLzNIPiHoxbXJnS5UWMoepWPmpljqyYqsxssm0w==
X-Received: by 2002:a05:600c:190e:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46e1dab8219mr23578095e9.24.1758622453537;
        Tue, 23 Sep 2025 03:14:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-401d7fa1729sm5378032f8f.5.2025.09.23.03.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:14:13 -0700 (PDT)
Message-ID: <feca7414-31fc-4eb2-9b25-e8adc70c2394@redhat.com>
Date: Tue, 23 Sep 2025 12:14:10 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 06/14] tcp: accecn: handle unexpected AccECN
 negotiation feedback
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
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-7-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-7-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
> has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
> then receives a SYN/ACK with the currently reserved combination
> (AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
> combination, the Client MUST enable AccECN mode as if the SYN/ACK
> confirmed that the Server supported AccECN and as if it fed back that
> the IP-ECN field on the SYN had arrived unchanged.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This looks like a fix for an incorrect behavior introduced by a previous
AccECN patch. If so, please add a suitable fixes tag. We accept such
tags even for net-next material, and it's better to explicitly call out
needed fixes.

Thanks,

Paolo


