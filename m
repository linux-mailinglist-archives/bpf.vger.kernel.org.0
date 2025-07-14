Return-Path: <bpf+bounces-63197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F946B04012
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1487A97C4
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1CC254AE1;
	Mon, 14 Jul 2025 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrJuoumm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C209252903
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500040; cv=none; b=R4PHO0nCMbvLzmU929LH36L3toFfKNsSMheBxHuF6mx18YX7j1Q1sgeXuhgBGzYdP/Eh9yO5ZPxF5+reCpvrtMCR9dB2s8+eBsaGVp4u7eoltOjlVLxp+pZkclUU8aNEuJs6qAw9CQ6pNwp7OA0s3BKV6O5qEKXkrD1mbPT5HgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500040; c=relaxed/simple;
	bh=dknSdYPDMo76cFz0sXYbOIhIT5DVtRwgwQqMWZ1ploE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uGKWSjxZF3iG9VDfDRvsBdD8W1ggGkdADzPOx7LsDuTEWH6GvYHJF85iKL1JKQtU5EFnCXVjmrDUXYBw8qEaTqzOhXZH5Q13+PWE7Tg/C40Wu/s8Hv16E+zFsweezNG/AdF8PgIMjVWDpJPMQKGt1E5bUwjXCY7upY1dudkKXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrJuoumm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752500037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib61hPCB4AUA3/+sodbduYae96rRA8xkreivfOor25Y=;
	b=DrJuoummdCjdsrPgz157Ra0gU6uQtwGNzUp27BUk+vA+dpSYjqNt0GqdKVYpns2YtX4gnH
	+Gjqynk/wNEv3Dvyz1qFSM6t3a3F7M3TIFuwkS7xKMcQ8lOaagXrhg9s+ciRid3GYQw6EH
	aP3BR0hXhkE61/d+TUG0ZFnocxdBpE4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-g3maL9QyPnKY0NAeiK1cyw-1; Mon, 14 Jul 2025 09:33:55 -0400
X-MC-Unique: g3maL9QyPnKY0NAeiK1cyw-1
X-Mimecast-MFC-AGG-ID: g3maL9QyPnKY0NAeiK1cyw_1752500033
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2104809f8f.0
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 06:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500033; x=1753104833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib61hPCB4AUA3/+sodbduYae96rRA8xkreivfOor25Y=;
        b=mvoHvWMkbo5sDK5qgIOvJDjF0j7hhOnfFtQleJRsOhFqxSKlJnJzEuwTDMTajIYuy9
         4jLme6OSwbITSOoYHsgb7gvzFxUUIRnDFR2BYsa0SRS4RI8eLy8odmtc160h2qLl2EsX
         hWdn/fSkQS+aPhif288ON4qTR3P4NzJljWPV5KXdDPnahkTRXaI8VoaZfd2n39eDjU0R
         VJYAXoJm/LMn8P81kzi+1mej0XGmBZRq9qBPHb/e6+q60DpcI+zOVM6IGqJ2WLPqVY+L
         mvzmbA2x+lCvm3PdA50wERarh29DEoQe8YCSTqgISr9BNbCi0MvC4yQcZYkE9XBvJdR5
         tIpw==
X-Forwarded-Encrypted: i=1; AJvYcCX98uQ5N5Ptm+fzIMPCCl7pCvqICvvTdgM5FnxmXIceOdWY0snw30Cytu7FVcYldkVKLVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3pBmY/O3H6nlce/JNUiYgQZk2G78HM3iECc6Gqxa6rJBwdxg/
	FXOVYk3DD0LBmTbhGu5jI0i0Ed6oX6zl9MDS71OBJx6xuZO5gNV+030ofi5uX9KrAbPcgh4P25y
	P2uCVSu+W/XrZTk1RiYXvjJND2b6ARpCz+HdW3KVkQAjWrgttrBf61g==
X-Gm-Gg: ASbGnctOndqTeCN4CCa7ZlcOOMjiFOpDr5/P8iJSIQRIqrLYmPJXNguTKhHDM0ZWw7D
	ehkv1ZekRU0aJWcAQ35o5UfKtB9BTKjZrQvcosppCwcilscsBY32yRHScOKo772iZowLkdov/ss
	0tzUiamRqFz64TTWFxD1y7Aoh3O5lzsDIye3xzp6/c7CyKfZPUua8V81+05jzwnYlutu6ZzIXZ7
	uWPkCCWEqzMO4SOh0f0nLsvpypSlJ26QII8hDyPO3NF3D6PTnr/mty2p3iGeQKlb9ctIUKgR5Zb
	jLgBnLT5TIJ25TAD8yWICuakks366pbISgyfhOKRLvM=
X-Received: by 2002:adf:e194:0:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3b5f35795c3mr9445131f8f.34.1752500032642;
        Mon, 14 Jul 2025 06:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcwfUCJlkG4jBfS0/HPnRj2f8oJvU/65bj2WaKyheEy4Aut2WkWbMl50W+qZ6Yk9d4ozuegA==
X-Received: by 2002:adf:e194:0:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3b5f35795c3mr9445096f8f.34.1752500032183;
        Mon, 14 Jul 2025 06:33:52 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26f22sm12633688f8f.94.2025.07.14.06.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:33:51 -0700 (PDT)
Message-ID: <226c49dc-ee9c-4edb-9428-2b8b37f542fe@redhat.com>
Date: Mon, 14 Jul 2025 15:33:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 09/15] tcp: accecn: AccECN needs to know
 delivered bytes
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
 <20250704085345.46530-10-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-10-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index eea790295e54..f7d7649612a2 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -1050,6 +1050,7 @@ struct tcp_sacktag_state {
>  	u64	last_sackt;
>  	u32	reord;
>  	u32	sack_delivered;
> +	u32	delivered_bytes;

Explicitly mentioning in the commit message that the above fills a 4
bytes hole could be helpful for reviewers.

Otherwise LGTM,

Acked-by: Paolo Abeni <pabeni@redhat.com>


