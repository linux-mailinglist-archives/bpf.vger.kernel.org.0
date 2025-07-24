Return-Path: <bpf+bounces-64261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269D2B10B0E
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 15:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813DF1CE300E
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 13:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795F2D6611;
	Thu, 24 Jul 2025 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BB61TH7B"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA482D5C92
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362668; cv=none; b=lrDMz2kzlk95rTp4HNWzx2RFucLiP5TyoYo2W9HCI0LfdGPCGT3v489ov3CasL+c9Sh+5Hd+dXLHyX5v6VWBEj97m/QIURTVlP5P5mtSQqsxwFAEY7nwrV3ePKcsXqoTEz9FI+3zmsv1h/VhwHOo/4Rf1dJrtHqeW0V5iJKeyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362668; c=relaxed/simple;
	bh=keOlY8IaAAP4UK7nEyK2eSAQe1k4TUyTEO0v5TsdGIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i4Wa2XBHP9WaHU475BFMlKYPyts/WLZOzfVlE/UE0pWbRbyPlZ3c8rKb2AoYUrM2YLApljFvpYSyCa0FXvRq5lHWtBtldstJEAwfoZ8T1HzTwnYWo6S8z/rM64cS8hCu3ZiYs7YWfFAgnBBxJ0xTT9h0wIcSpV8TugbxQkm8YVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BB61TH7B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753362664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzMToL0msrSZ/KKMxmuznJBdXGU3S4ZL56R4KdRa7go=;
	b=BB61TH7BPG1btsSu7D7dR3xBvBvLYcCcE/21W8XHYGHowQsP6fZS76T5cDEfNuIUreic+2
	L9STSFrUeWtdrvWE7FyEzLvSGZYk1KzXNS2+iidFQXlxxYGILRY5gX2oo480mydDDrv4B3
	e+fLceLxuc2atV+DaLHPxImnL70AGlQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-MEbpLYBIPomT6NATiE5-Gg-1; Thu, 24 Jul 2025 09:11:03 -0400
X-MC-Unique: MEbpLYBIPomT6NATiE5-Gg-1
X-Mimecast-MFC-AGG-ID: MEbpLYBIPomT6NATiE5-Gg_1753362662
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso630867f8f.2
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 06:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753362662; x=1753967462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzMToL0msrSZ/KKMxmuznJBdXGU3S4ZL56R4KdRa7go=;
        b=SblX9LLoxAJWvMbuMLVFSpLkRBnPVzYBp6RRHwOBkwKypQLmOqCbfg3q4OrT4HjIMn
         QAAVabNndTk+l2jzgq/+mFHGS44RRLWPhIrbHr1a7YGmla5Ggbj/UadHILTFaVYUNxZ2
         4THPIuH1Ndi5Y5VtEDkx6YuM861b9hddR/yLp6/zZgyhMtUXLhACLngis3CWnu3nw2tY
         x8tpM5/bnnPU2/cd6HvKJXXWzLB43YLIRO3VZY69R2yyE7o+MfDKfXgFO7cvc+IPTS88
         URrO+pEjBRvsIp08TZJGfwNbDiyOgnwY0VM3FtPTkku39OAgEqRNK0St/DqEJ9kJo3aw
         I9Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVfRPjsbBN89BWMsItw7KUS/91fKOw5K2yGHjYO5ZCc9hvPzHKRrBJ6UQ2oH/FPqXwA9D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZaGEVdhK/3CgH/0uxh8lSQGLyMiajYcpSKNjueRdckh6btEq3
	3kSpDXv1NryXjiQdoxgJEG/+R/LwclAngqzAcucnbBVTXHGCqfONZ8fkwayQbGLvVGltYJ/smex
	vYXN5kxw04rkrpBY93bKyAlpjLKmQFxK4S0mVzj1ykyh1O/WjXdbKVg==
X-Gm-Gg: ASbGnctdIm2zJJo3c50B9wPlF+nZNH1ah4MFQyzP0jIc1Vv4EqLRajE59Het/zzzttp
	GWpGBzIvc33CwyiBJvwZFy8T0AmUvUnGCfAsEqL3YzSQUMhoHCR7oa79l9tFoh6CQAwW1sk3ndj
	2HWjibN6wJ26p4ZpXAfGNu3XkqtaUvGGNTzt+2ze2s9IOWtuZSR4CL/Dswh4bCFWeTsIKxfNFH0
	/NaHBDDxXi/4PUIjX6MxomivgHZko/ityKww3uFxlRlwBQSVKVZ3RIvCRbyL/ael4U2bbYpykvD
	bPOe5dtzh+Vt8Ej9+O1hZzJBxJ3mkQo0aiSE26nz8EjkZV61xMUTLLK4ugC3axwhTrNliIGYdPo
	MWHUTDUWktI8=
X-Received: by 2002:a05:6000:40db:b0:3a6:d2ae:1503 with SMTP id ffacd0b85a97d-3b768ef6f18mr6952663f8f.34.1753362662152;
        Thu, 24 Jul 2025 06:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9uXjjqVyQTr1AvkZtxeDHHOZSkmpUhu0Uhy7GWwFd3tbgN6rpLR2iWPHM6a6vJBIw8pnGSQ==
X-Received: by 2002:a05:6000:40db:b0:3a6:d2ae:1503 with SMTP id ffacd0b85a97d-3b768ef6f18mr6952627f8f.34.1753362661709;
        Thu, 24 Jul 2025 06:11:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcc3ccasm2177679f8f.80.2025.07.24.06.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 06:11:01 -0700 (PDT)
Message-ID: <e79b4382-9421-498d-8b8c-6157ff070a34@redhat.com>
Date: Thu, 24 Jul 2025 15:10:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 00/14] AccECN protocol patch series
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
References: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/22/25 11:59 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Please find the v14 AccECN protocol patch series, which covers the core
> functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
> and AccECN failure handling. The Accurate ECN draft can be found in
> https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28
> 
> This patch series is part of the full AccECN patch series, which is available at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

I don't have any additional comments, but let's wait for Eric's review.

Also we are very far in the development cycle, likely this will have to
be postponed to the next cycle.

Thanks,

Paolo


