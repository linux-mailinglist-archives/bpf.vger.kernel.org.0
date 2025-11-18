Return-Path: <bpf+bounces-74951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49152C69621
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 070A64E27F7
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9464F306B33;
	Tue, 18 Nov 2025 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O83kRwuv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib+GeaHr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5376322157E
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469027; cv=none; b=fy4TK8B/Ahm+h6Ttm1Xx3I5mqzK1RAWizmneAFy/7mrSfcOw6Zx0yDDWs84OcYTDqqebq/UFPSGpzP/qLGWxrX0Wj/R2C/GrSU5eWYI0Uzq1lhiVkC2rDrh1OGhW/aPPIvgdN47vgXzX6WQJfrt3G0KzjiaAmV2jdhDhZsCCyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469027; c=relaxed/simple;
	bh=8B9ouElv+xeFaTKAh9MT9KBQGuCsWdhQ9skK5QulCOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ND9fyBnp2VNieXb716qmB8QOfT8acPIuCTteJlyKqXOke8L6uqJA72qkhJICAGbc+Whje/ATFJ6iULvvLbPqSAoBZ2vMsn7ryZuOSu304xdP8G4Zn1FFsNBXRmICZzjoqwl6S7ivpVf1y8Y52KGfoeVU0lf5osnQ7N+9/7sqe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O83kRwuv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ib+GeaHr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763469024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1y6PrlUAcuxkkEloRxo0vMvd5pujl1anuTqxEZ8o/Q=;
	b=O83kRwuvD5AKFvQbFu6mrpO9JcXSk/KF+Xooa27/DRka+F8uuo/EEMh6SfG2wgaRcXlfry
	DnpsEUkCjNiA/JwkIgf2SLruFZagfTWR69uUe3Y44BqT195CnNuzkUfl3SQT2OjKd0J0hT
	fizHXj0aec845wY6SgcWNuEH+rnenQ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-jjcXzC74P-Cs4OtuECwuTQ-1; Tue, 18 Nov 2025 07:30:22 -0500
X-MC-Unique: jjcXzC74P-Cs4OtuECwuTQ-1
X-Mimecast-MFC-AGG-ID: jjcXzC74P-Cs4OtuECwuTQ_1763469022
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477563e531cso45668985e9.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763469021; x=1764073821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1y6PrlUAcuxkkEloRxo0vMvd5pujl1anuTqxEZ8o/Q=;
        b=ib+GeaHrpuu/avH9sUKzdMZIMuxV5MZqO5tDHbpN9aEOCFtPnmRi7sRZFCHcwhMshZ
         bhVdMgo2Z/C/8gNeQlA0vgLAfmwiEEGpd/g6Bq62EMLN1lRswsPVN+zLcrscKMW2Gdsk
         KYFv4V9Wp7weLllmBsnsnaTAvvH8a46HCyWDrPJzKUEf7kJiW6n34urmlZ1QU2BLF837
         wsOlAVG0mBJHydb7XzU38+hadvYD6sl1m7A6S+D41YSzlyu2vh1VBh8M3ZEjrLjLbwvH
         y8YhzUVSiwQ4+TThCmSBe8pn96Dpe0WnLL98wps+V9LWFDfkT61UmdX+txmP8p7L0Pld
         GIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469021; x=1764073821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1y6PrlUAcuxkkEloRxo0vMvd5pujl1anuTqxEZ8o/Q=;
        b=TT8sotd499ABonylMdXleeAK56aTwvBPe8/MAH1K5DW0xWLl4utxTmsSSDEQAH7PYK
         K+lCV5oqds2+AgM5gMlB/JyHWni9esqu58fB1oiqVfuLsIlKguuVOv5eRvsGv4bIy9Qx
         nf/69t2J8uF4o8j+EBR0IMzFcYxfU+2ED2NwQ3zswcTdEQXFxJEaG+DhHV9baV+13eLI
         WPiuUcjrbmR3UjtVyvDo4JYtGKpRUnXEIbwV84Mbz8S6xcFtxyI3EmwTBf0E49dFL3Os
         zeriYjiFcW/x1UdbvbdUqngLYgI0N5Byilwc43HwpgNAdVSeTrUDpM93CZhWFDdnkg0v
         EipQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOgL/76+sH2U+ts9P4oxxglKdpTyTeNlJZ8NhJ1Dj8sMHtie/YwGLis6oV55P7TeH4joY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdOPxy9yl8bxorSuKAK8XGf7nJIO/UjI+HpyWznoRw/E6ITrTa
	XPDDqF+6NWyX0vOuk1mqr0FbMZAc9b9iASdiXzLIt4UUreIwVh8/Eze+EvDTxp1j73JEcybTkrb
	q5z2+oInbrJIKBeq8whZwSkdH1+XA7xkJKE4eAJudggl89PAo7JhQ0w==
X-Gm-Gg: ASbGnct4swBbyLb90vFMFJxfkXEEVfDSwu+A1akYoDxj/9Gcr4QYtm7cQXRbutTvQR/
	+e8e6ND8ajHd4zxPdqi6xy8mT2qNmc0r68KET5hehfaYl9y5RDhEFIrxXEcDDZ2eGl10f6Ko+OU
	Qq/atACi80qcHQy8qH2SzXGcovbt9zxA0U/jWNOP0xIjWR1im3HrVTbvWbwiHBn4w57z9UQ7+jc
	rR3qD3wcR4SUKQHS4GVdTaYHgiDqPqr4kj05jb+w4ZoE0nriwcYDxcfkXZ0LccsbpEDpNNxWbUA
	tbR2Vm4rrUFaFO3diWhWuBrWfgRkvMjpNE/uwbpJosJ7dQupuxc7tnazLTIk6dLEOyok3O3cD9l
	SUHytVEblBmZi
X-Received: by 2002:a05:600c:4513:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-4778fe5c820mr175963075e9.10.1763469021597;
        Tue, 18 Nov 2025 04:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOZAD7E1uZGLJ36i/AdVTCJbTikjjEi/nzH5t0pOPTGX1/txTaGcM5dmDEUHhqBH4ogD1aHQ==
X-Received: by 2002:a05:600c:4513:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-4778fe5c820mr175962585e9.10.1763469021119;
        Tue, 18 Nov 2025 04:30:21 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dcd891sm15757525e9.7.2025.11.18.04.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:30:20 -0800 (PST)
Message-ID: <715746f8-d1f0-485a-ab83-2f768722698f@redhat.com>
Date: Tue, 18 Nov 2025 13:30:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 05/14] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN
 identifiers
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114071345.10769-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/25 8:13 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Two CA module flags are added in this patch related to AccECN negotiation.
> First, a new CA module flag (TCP_CONG_NEEDS_ACCECN) defines that the CA
> expects to negotiate AccECN functionality using the ECE, CWR and AE flags
> in the TCP header.
> 
> Second, during ECN negotiation, ECT(0) in the IP header is used. This patch
> enables CA to control whether ECT(0) or ECT(1) should be used on a per-segment
> basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the expected ECT value
> in the IP header by the CA when not-yet initialized for the connection.
> 
> The detailed AccECN negotiaotn during the 3WHS can be found in the AccECN spec:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> 
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


