Return-Path: <bpf+bounces-56579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D5EA9AA87
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CD31941A3B
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE491228CB5;
	Thu, 24 Apr 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cjn9rSzg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF7221FBD;
	Thu, 24 Apr 2025 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490841; cv=none; b=JYsex1bZ46ovtAwBPtV4O9SRNNLcN0grYHh/Gt03R/qbD25sJtqrxamHCeiDVKVBIT0T/HPThWuQqAYsGN9YylrKW88oTQoHVSkSDe/rpN2aIVB8zzBxHmDYyF3mCeSXYyG/jA3iE8TpLSDz0OXLDqG2uQvAp+nbbez5l+IDc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490841; c=relaxed/simple;
	bh=Uy+mUasuhKbgXtDTxk3JR8h6eqRQF8rsNoKeGi5WQnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiNw0PHBMdp8Wc4hYWxRwvBIgPS9TZBUQI51FXN79lIweOlB/i1vKBpYPABQgc46xB9D4f52gfataykj8x5YU6GKDLlFAIpwq6Cybrs/Wjy8UF+/g9s+YSgLZgdZWOc+UXOm+b0lyoZQspf7gsz6Tb4a40osWC2Mm+mL6sI1Vks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cjn9rSzg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af5139ad9a2so493049a12.1;
        Thu, 24 Apr 2025 03:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745490838; x=1746095638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VS98H9vhuUvesz4nn7FmfvGAmjamAD7zXnYiaxDdLvI=;
        b=Cjn9rSzgZhzKxCTkD5Y1dbLostMYVv9P8SmrxTOqGa42FLZGUyIJD1ECiDS9yQGNzS
         mwVy5nYCMi5WpQV5p8BvfWEzhk26Q9pjuAsaHQ6E394ZT5Vu5poQtWF/XpiPHjv6IrHY
         ho5vmMwVKJJpKwQpoMbVDautjIJq6EL4ZeQpl/LbTyiLIk/nFaktDhxoVKm9I477sZpm
         37tXi+3wuqIgvb5TncwN0YxOlTSCGENSUCTzNjSLT8Rvr5RNfreDhsWH9B8aAjqojlhV
         WBViyXoZTjfBxxXIRLtFk2K7s2HNnguDOjar20ONK3Ym2EJMixM/eaKAVJkiC1axeMgk
         Ko6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745490838; x=1746095638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VS98H9vhuUvesz4nn7FmfvGAmjamAD7zXnYiaxDdLvI=;
        b=LgerZmXO8PGGSk6q5X1rRSDHuiFFYD5ciKKgV67xFBsngY/tJbPZvXYkJFkzchdEx8
         P7rmRtHHjnmQtYUuveOQrOtOxJLtlErSh922kF14W1M0Z35ft8pl2piZweVHJ54FRe+p
         HQHZP+6T1AsOTIEmfRfvGVJRvGx/X+NgonnXDqaUk1yMaPb/AjBxqPkMHyqhWTNwVwzE
         lbXQFkAWiyKKcCb9NdtFwVBYCyhOmiBN2VeupGNMPxjZ8QKxDEQ0uI61x+cXQF64lLu+
         zZz9AIuICpfHudSTUr9XyGjSszSVapYGoReijRY6IrXL6HZ5nJ4vobpeITknmFAI5/yj
         k7HA==
X-Forwarded-Encrypted: i=1; AJvYcCUFphkqn5Za+z2ZCWu6WrUQvZ53M1H7MapuGueTtSDO2khsv0pGvxgS2FT4JuQcFbz7ogQFsvjO@vger.kernel.org, AJvYcCX6q+vXYH2qsH3zIJrsmMNU+gb3vUligsCmd5XbuWxpmviqPphp4gzYpRdVpkeIJCJGZpo=@vger.kernel.org, AJvYcCXEEkXrSUaSTrUhC+dRgkWL+0TvTj0GujZ0zD0T234pLGmO/7wNsCjc/ZTlx2R6K7hHVY7fi28KBfdLZJxD@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjvRtE5OnvYcIAj4F39A539GsXnA6ak/rK67DxURFf74GaprI
	28JdflIEdrRo7V0unBReZeSOjEd3AAu+RlNAnZLPyBYYmaS48NCQ
X-Gm-Gg: ASbGnct5iRjXGkTbVimKb1LSpma0YFaXY1+rZpeZVR3kFOttcy/WexMHZFhc3sX++Jp
	rkFTpUK5EDqIWKQKLmU8BnJGYLIsQMkRQX0mnVkDpezsOCA0EVk6Yloq/zsOmO+/VNcShU0HBaP
	Lnoc1Vq0OYXsTFFp5EKyxC90iNojh7RhFFZepFWTNBSANOoRhRTyO37JezC9Nv7HhT5+hCqS14/
	W5SA8XozHlu9I7fI7RD9s6ciqn9gSOw4BARMPk2V6BNnTmM/16GjPgK4DwM/hXmdRhK9KyX1rPj
	qEzCBvSEbTJC8rlAiG7elDVhnXAu8ENPMvh00i5Z1eqTGnLJDenJHMjVn4IxeMd/NDzWc1nm8gq
	OeGH1AedW3g6I7XE8jzY=
X-Google-Smtp-Source: AGHT+IE16otPz//YJ1TEtt4Uv/PnG/T0CeZp27eSS79xfdk9zP1F3OBCyutLV1LXJhRM9Cm0Rt17bg==
X-Received: by 2002:a17:90a:e7c5:b0:2ff:5357:1c7f with SMTP id 98e67ed59e1d1-309ed3424efmr3084886a91.30.1745490837878;
        Thu, 24 Apr 2025 03:33:57 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:f632:6238:46f4:702e? ([2001:ee0:4f0e:fb30:f632:6238:46f4:702e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03b27asm1086032a91.6.2025.04.24.03.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 03:33:57 -0700 (PDT)
Message-ID: <619bc46d-4acf-4c54-bd47-6b482fb76878@gmail.com>
Date: Thu, 24 Apr 2025 17:33:49 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] selftests: net: add a virtio_net deadlock selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
 <20250417072806.18660-5-minhquangbui99@gmail.com>
 <20250422184151.2fb4fffe@kernel.org>
 <aac402b4-d04c-4d7e-91c8-ab6c20c9a74d@gmail.com>
 <20250423152333.68117196@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250423152333.68117196@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/25 05:23, Jakub Kicinski wrote:
> On Wed, 23 Apr 2025 22:20:41 +0700 Bui Quang Minh wrote:
>> I've tried to make the setup_xsk into each test. However, I've an issue
>> that the XDP socket destruct waits for an RCU grace period as I see this
>> sock's flag SOCK_RCU_FREE is set. So if we start the next test right
>> away, we can have the error when setting up XDP socket again because
>> previous XDP socket has not unbound the network interface's queue yet. I
>> can resolve the issue by putting the sleep(1) after closing the socket
>> in xdp_helper:
>>
>> diff --git a/tools/testing/selftests/net/lib/xdp_helper.c
>> b/tools/testing/selftests/net/lib/xdp_helper.c
>> index f21536ab95ba..e882bb22877f 100644
>> --- a/tools/testing/selftests/net/lib/xdp_helper.c
>> +++ b/tools/testing/selftests/net/lib/xdp_helper.c
>> @@ -162,5 +162,6 @@ int main(int argc, char **argv)
>>            */
>>
>>           close(sock_fd);
>> +       sleep(1);
>>           return 0;
>>    }
>>
>> Do you think it's enough or do you have a better suggestion here?
> Interesting :S What errno does the kernel return? EBUSY?
> Perhaps we could loop for a second retrying the bind()
> if kernel returns EBUSY in case it's just a socket waiting
> to be cleaned up?

Yes, the kernel returns EBUSY. Loop and retry sounds good to me but it's 
not easy to get the return code when using bkg(). So for simplicity, 
I'll retry with sleep(1) 3 times when the xdp_helper fails.

Thanks,
Quang Minh.

