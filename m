Return-Path: <bpf+bounces-79070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F05AFD263A8
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 743BB301559D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB823BF317;
	Thu, 15 Jan 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt1r2nl5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B625C3BF303
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497067; cv=none; b=ju1aVqblcMTGwml4huTpQlxlkiw/4+5iAcnNYS74++D8UuAfeZLLb2J4sHWfzZCMcy0fKTrZdQm03BMu/KkngBSl1jmKxhADE8M2NtdPLIC1j8bIYzHpAJsnpAAX1+NdTyn3An7CZMA2LpJdzzPZ/aZQiWSjvIx7AeVYj58WFzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497067; c=relaxed/simple;
	bh=z5fuYqtywwL6KOIHKbWzEHmAdjuqly6oA3cwR7sT8v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TojmgdytZJbUkLbJr4QpkSA/vFIfNgmsFSSyR6bTcU/eBePSWQ9LjwOkshI9IN3HeSQi7aHuAlGCTonFs17W9+YzrufKEq3zfi9PQWA21hnepy9l6tV4oOZByfqK/yp3y6defH1Sv1EKoeR533eFM0cMlclWyAayhpI0lH3U01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt1r2nl5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so1045958f8f.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 09:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497063; x=1769101863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9zIIkhhFGJW7c5euU+uczxwuqnCR/g7cOorqaRVjc8=;
        b=mt1r2nl5+IcwV4rIclf6O+vfsoItttvYMAwELjX7wAw87RRtgoOW4yjf89VreUeVMN
         DUvrtR/D70+SBDc9heH/xdBvKbODGU113itq08ukub4tw+xmUGwWcQhvsS/yavKIjx8y
         PASkfYCvUsV604SnIoRkl5iKxMvUsKrbTugd7YH3ahhdIWQQnwHQ1c0NgQjcQgRbKuv2
         7EhanVPn/TK/MhaAGM941iuLfLGdB+n9VQzBnIWd0wo7hXd3PVboAUZARPbzFlr0f3XW
         mTrXKtW8TsgnMgSgjAIi7VeQPc9k6LrWVpOEBn+lZbb7YXfAaBO7VVSecu2OIE4EI6IW
         MwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497063; x=1769101863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9zIIkhhFGJW7c5euU+uczxwuqnCR/g7cOorqaRVjc8=;
        b=B3rr/wwOzFin62xsIGX50+Lardt9WZGS6nzqw6YnLcw7NvQVmkvnbdZaxDHFiAimVG
         TLplBKXrtr1gPab50JcSv4bT0S3MRMka53x6v8aQlRSFNtq9nAZlN11KH4BRTxdT3NkO
         4w2z6GueJ4gz8nxdLTR/0XmhqsLnj4M762vlC2pudkFS/kw407up54M2T1GuxMN4qvYz
         4z7oSz8lSH3KyanfL+39AEh/VZlD9ik3BFrBXHQhTI76rrgqOaTtArbBNY3AvcOWaOWJ
         DA5Q/sCPKwbOqMeXqIumChmuOEI+XZcVcw5HttpqzFjNnshKKf+jlEdsfHPgPQv9Jq5Q
         sDjg==
X-Forwarded-Encrypted: i=1; AJvYcCUT2S2hHN5cALqWSgCBOZjft25wXXSEAzbTbE5lMCpd1NNt7RdoSPXTkz98/9KAqwC2/tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2oGHVAbrHo2rU7NUiYUQo8Ws0yGU2UCLwXtqFjfselmRkfNh
	muDevdXIiKpsEspfZqdjZpxA0kKfL1myk8t/pImNSs0xK9PDa12evVHo
X-Gm-Gg: AY/fxX6ZchM+W7hogSEFmLQfMIdykSAImjm3F/XgM2Hn/tb0uqITCrIAPMua+S6uQN+
	LqY1rHT6Eijq9rfTmQ0jvPe/yPDACVQnGUo2LJwuSUak8fsNDtZST7GE5GFpoSy/83hNunD3J4U
	1Pa42CIMPInff4CJVRMQ2yQe+IdQ/U+FiZ56+u/arCfIIfmIo46GOPHbDDn4u4/QojAc49Srj1g
	dIplKM3ihZ+sXAPDr6VCyhzKRjbwWXiO5gZcx/1Zc30/j/YWlWnG+V1iOrPKLzhnAXAwnU7HeDo
	d7wqhc1FW6e87qMXGIbOV+eZVn8iY07Of557Ml+atpcYpibF5CnGXVcs+5j+QkaEDC+nJlonXPn
	m1XuJ98pS8aOfyq5LjHwIQKTS3gAfypoh1yOBoH9eepIGzAv1FWlinVekFWtCFyfxWa2qPPhpSI
	6W5TN56iuXfhRrQze1IJsfFze3eh62MqjW0SgbL6jx+S8oBbWZoX76Qqj+4XyRyIxXFefW5Qy70
	+RxrKPCKuopKe11q/KcBy43JhFyP199FlSezIfYg4QV8ULq5EYjVTOuEV2eq+D5ig==
X-Received: by 2002:a05:6000:1889:b0:431:9b2:61c4 with SMTP id ffacd0b85a97d-43569bc77b8mr74982f8f.45.1768497062676;
        Thu, 15 Jan 2026 09:11:02 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cf42sm104023f8f.20.2026.01.15.09.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 09:11:01 -0800 (PST)
Message-ID: <5c0f28de-41dd-47c6-9b0b-9ea40cbbeab2@gmail.com>
Date: Thu, 15 Jan 2026 17:10:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 7/9] eth: bnxt: support qcfg provided rx page
 size
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Ziwei Xiao <ziweixiao@google.com>,
 John Fraker <jfraker@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Joe Damato <joe@dama.to>,
 Mina Almasry <almasrymina@google.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com,
 io-uring@vger.kernel.org
References: <cover.1767819709.git.asml.silence@gmail.com>
 <28028611f572ded416b8ab653f1b9515b0337fba.1767819709.git.asml.silence@gmail.com>
 <20260113193612.2abfcf10@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260113193612.2abfcf10@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 03:36, Jakub Kicinski wrote:
> On Fri,  9 Jan 2026 11:28:46 +0000 Pavel Begunkov wrote:
>> @@ -4342,7 +4343,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
>>   		if (!rxr)
>>   			goto skip_rx;
>>   
>> -		rxr->rx_page_size = BNXT_RX_PAGE_SIZE;
>> +		rxq = __netif_get_rx_queue(bp->dev, i);
>> +		rxr->rx_page_size = rxq->qcfg.rx_page_size;
> 
> Pretty sure I asked for the netdev_queue_config() helper to make
> a return, instead of drivers poking directly into core state.
> Having the config live in rxq directly is also ugh.

Having a helper would be a good idea, but I went for stashing
configs in the queue as it's simpler, while dynamic allocations
were of no benefit for this series. Maybe there are some further
plans for it, but as you mentioned, it'd be better to do on top.

> But at this stage we're probably better off if you just respin
> to fix the nits from Paolo and I try to de-lobotimize the driver
> facing API. This is close enough.

Ok

-- 
Pavel Begunkov


