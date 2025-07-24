Return-Path: <bpf+bounces-64243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6E2B1071E
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 11:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AF8AC0727
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7693D254874;
	Thu, 24 Jul 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOceyGx5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8525A2C2
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351044; cv=none; b=m4OV3W7ByJ7zsLPsLel62XYAxxi86UHD5vd7Vu+MkpmcDzrYXGuLI/cDv4fZtN/vvGUYgirN75QHeL/xFV5ZYOb3onCuTsKT47H7TB6ZIeu/BQILbki7LRbvkYYfBzY/WrpoKH+VG1hI1tZeaAYLnafbxvISpmKYgpPkyxjt8tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351044; c=relaxed/simple;
	bh=3QN2SPK+xpAbgocIP4oE8AbjkT4UjG+6575GluaartQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCaTV1rVRQgpuv4eRRP8UW+tHI7QF7w4wEAiWRbibVAcVJcnu4ysCtd4o07KX5CUjUmAIaJ7/JTiAzjPcV881cRgdD6uS7YRdfpSv6kUGblejNCX5605Yc9Qi37EyjLvm3IKm5XF930kC72UXMd575Y45tcbdS8pxb/IOyvSWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOceyGx5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753351041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QN2SPK+xpAbgocIP4oE8AbjkT4UjG+6575GluaartQ=;
	b=aOceyGx5E7EOtH4Jhb2/SxApHV1MgFRV+4d8nwWwdJDxXyY6xvUiDt9g/SNrijAY4udCXe
	8dwUj2gFNnH+mjWCSDpbe3DiG9FpdS8djvfcPkMTQyjqDqLpM9jD9sMAdYSfwSUqn4OlYB
	pTerfHV+zN9GaUZ6v2FpWVBdx0QITcM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-LOysGec0NUu01V1AltyYwg-1; Thu, 24 Jul 2025 05:57:13 -0400
X-MC-Unique: LOysGec0NUu01V1AltyYwg-1
X-Mimecast-MFC-AGG-ID: LOysGec0NUu01V1AltyYwg_1753351033
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4560f28b2b1so2821825e9.2
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 02:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753351033; x=1753955833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QN2SPK+xpAbgocIP4oE8AbjkT4UjG+6575GluaartQ=;
        b=B/ZZAa/M/4Bu10xQRjg/sAk7MuJyNegrAiV0Kf7lSmFnUsp5P7NKb5Ry2quFC90Vwx
         /NlaI7dJlbX/3WxOyZLDtpHllhJTb55XeOuZzL6W7vAMfOfCPT3neBRGt+0MrswPbYko
         OE5yRMJUYrC+gnQb9+4hUkHeg++3Jc1BpYLu3pxHdNTtq2pNFWYz3vMQ4GxjO9En5g5o
         qdFvZIxQD+FuQx7Eig+ajMDyY3PpNirG34+Ifc1zgqZI/vt0xbZCVNyofYaPwhm4dH02
         U8Eed3ASKVitEnoXXHbB9IoG5rHBi+2mIKLA1aqJc4eQXHhnwz3b4QxqWa+/oKJwdQP+
         ygqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3rD/NuaHSNIdNuYZ8iSZH7bZAfu0iJbwUCUABpZKJ08DgmPq+VK1fnb+VJxDIwWGf7AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNYF5azaHOJ5IP1uxf8qQyYH4cIV96sCEnDX6FqKqdbH2zujz
	DTdQA1oYB8hZVUNY6C9gF+zvsS6w+Brr8/aKtV57E/HjIqtqeMFG2zUDRHIneq+JOG/qp4SF5lk
	PbfTu6uOvZXI86BYZQjiZt4s/0ZRFCrGjguCQ+rfVvn6igsM2piaiyg==
X-Gm-Gg: ASbGncu25/JbhU60t9BGQIRwYZ5eYuOINXxIMjaLy2ityVzsimJikBPj4P5XwkNJ0Zh
	FBZFJMSa/LJTySIEowU/MucbmJR5qbuNto6kP2/y1w7jnxQ2ARslR1aJ5Kx2nSPG8riMQ6Khumf
	+yoTfe3pdTdqJdtFKIqBK7ClfOqIuA2Mr6PSIqI35ZPuM7zF+uUcpG2Pkd1Qd0zVl2uN9QTchqV
	wLOYQlAkrKlpO28D6N0jF/xE1yMNXuRX5jVrZctPbXtwhwKrdrlhxYtyuQPhVmFvcnGdC3cYLhy
	Pju4EXeK5OZVLMUFyVMu5ZLk1me5VpVl5t3nuiHtZvhEAG55VjweiCxB6s3RlfS4X+Naci0C9fe
	xGNtQkYdJX4Q=
X-Received: by 2002:a05:600c:540c:b0:453:697:6f08 with SMTP id 5b1f17b1804b1-45868d6b4b4mr46224065e9.26.1753351032720;
        Thu, 24 Jul 2025 02:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBdiBk1y9FYFtZGZos+FZxTmneELrQSJ8S9Hi/6MjtohOABZ0cx37UcBf5gRBbBVayCRRaKw==
X-Received: by 2002:a05:600c:540c:b0:453:697:6f08 with SMTP id 5b1f17b1804b1-45868d6b4b4mr46223915e9.26.1753351032246;
        Thu, 24 Jul 2025 02:57:12 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcb9a2asm1677126f8f.63.2025.07.24.02.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:57:11 -0700 (PDT)
Message-ID: <045d1ff5-bb20-481d-a067-0a42345ab83d@redhat.com>
Date: Thu, 24 Jul 2025 11:57:10 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: handle NULL returned by xdp_convert_buff_to_frame()
To: Chenyuan Yang <chenyuan0y@gmail.com>, ecree.xilinx@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org,
 zzjas98@gmail.com
References: <20250723003203.1238480-1-chenyuan0y@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250723003203.1238480-1-chenyuan0y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 2:32 AM, Chenyuan Yang wrote:
> The xdp_convert_buff_to_frame() function can return NULL when there is
> insufficient headroom in the buffer to store the xdp_frame structure
> or when the driver didn't reserve enough tailroom for skb_shared_info.

AFAIC the sfc driver reserves both enough headroom and tailroom, but
this is after ebpf run, which in turn could consume enough headroom to
cause a failure, so I think this makes sense.

@Eduard: could you please have a look?

Thanks,

Paolo


