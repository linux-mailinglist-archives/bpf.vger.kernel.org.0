Return-Path: <bpf+bounces-78689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3839CD181F3
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 11:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90F8F3026B27
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 10:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADA0349B1D;
	Tue, 13 Jan 2026 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwDx6rus";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXjzljLa"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA533F8A3
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300897; cv=none; b=FtsD/bx0HUgVS55FXocmIsJf/+D6bhSqS9pDWodguwjFWKbXMbwsjSgsFx2/1DkfJM7xBBt0qeMu8VBSDMxLTSfHQK0rPnW71cn15GGNQikM/OzJ9GxZ73ZYGgzU/eYgBNpy4v3QfEp46XIwk5ltjLI98ZOVo7iiIGMxeddDTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300897; c=relaxed/simple;
	bh=6rphP0XeUY1TRejd2aNPhK+QTTqnj0/IWJtxgLJQFlY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nHjbWCEHSSMv3Rte4ujPbJ/hSbRzbRIVo43/LuzbNC/F/KUJJAoyKOnJYYpA90stZqMRVHpyBjP9/TlCYKkM+L5kLhSHuSsaPZpO5Oeuy/wLQ+i3lS41Y0OgYYsCK4qJQjrHY3YVzgtYU/Q3+bF6GLhva+kU6Y/cW1IOxh5cEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwDx6rus; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXjzljLa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768300894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0UJyxAD7OV1Vlm9xAqwyNi0f+c77Epf12aV/zNPFd8=;
	b=TwDx6ruslPmtpXkYyaxcLnjjHcqVMMNt4DoYRRyWpPrbV363SIZ/wCBq1vwtHGQNCP0edm
	K0uf3uRU6dwnfsjRFfB+7jQRbyPiwFyxZu6JpwSTSQddH6uTr+SM0Esjy38s3kfh2/O8sm
	765g5MI9SRvLISqktI0Xo6sk+KA7ebk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-q32ep2NwMbiSalkEDNYKGQ-1; Tue, 13 Jan 2026 05:41:33 -0500
X-MC-Unique: q32ep2NwMbiSalkEDNYKGQ-1
X-Mimecast-MFC-AGG-ID: q32ep2NwMbiSalkEDNYKGQ_1768300892
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so77058265e9.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 02:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768300892; x=1768905692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S0UJyxAD7OV1Vlm9xAqwyNi0f+c77Epf12aV/zNPFd8=;
        b=MXjzljLa7elUnoRzn0CoAuENKKL7+rkFSYz3pNVLDoVAhVOvcjNiZtPElWhwD7kXbq
         qqw1wK7DLG3xP+IHUEoeKSvBbXw/xjF1X5a7bsQ3+FaJBe7nrHprzbxWKsEJEVKo6q6/
         QasZpeKDDAsO2NzG21ebv3pCuprozp1/3E0UNsnhdDgRPAp68yooZ9OudB3vHOydBY26
         Y8rHifgm7wMMhLVXDZ/srSFr6Djv6D81wpNO0ZVk6qOwWwyQQa8WK7HMuDb24yfQyIcO
         WFpxnnQNPAuZ0vfEbhdoBGgiEDEhXueJsHEembd3aqyOkXcAJ6iHvBvNooKN81HAQlN8
         pyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300892; x=1768905692;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0UJyxAD7OV1Vlm9xAqwyNi0f+c77Epf12aV/zNPFd8=;
        b=W6ewgEs6JO4gsu00ngaHd8Dz/ZcjWN2kUPHNJLVJjmbwqvMAH0lCKKZ5jX2hFCdlrL
         iJqFINBohrKFgp0rQlCcmd8yVnuQqN/H3NmEBUKF/6xrQp7jYy45m4jCdW1LqCbQ1Xgs
         IZ+Cx/mDjXrF1LhUeB+N34GRMsVqb7kyK21VUkfVXT7+D5mrvkW0vXEXlRdmniyyAubB
         qtfjTZl5D/W58lOwdIH1tliZ7rKNoO8DTGCdonuwzD9uuNMvqNyb/+WMJhMoXsQqtADA
         /p3uI4N2/WuzZ1QayfxFldKdm7agRTazVfC9rU1HtxGd9alsQSn78L4bfnrzvk7u07wW
         8QRA==
X-Forwarded-Encrypted: i=1; AJvYcCXQvxXcTof3ScJxFyj+u3Z5qvLgFbmxXLbQ/kB1kaG4EUzsBtaLHvJFJBA1ejVpA+t+0Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Thw8r7W2pej8Qx/Qp87dDR9S23+pwhtBtD8Tppmoju4pWAYg
	PHbsWO/fDdZPJviSA234kwFz9HVF9zMwKFsMT/YMWcUoRM9yDQM79Bx+QamTKQdFbcj1uOEGQsY
	3YS1Ppx2VAmq0d0zl1xlWAhye6B9Rq9cyDbawm+h1HVJnsOyJwAsJrA==
X-Gm-Gg: AY/fxX6+lcX0WWrO1ouuH+UPFYRMYucwJZKil//84iO41hvN6eLGn0OP5ABzSsAJPhu
	eDQ/0OHevaC3eNSGd9k/ClwB9sKJuIGeCe3rBg19rn0akEaV478GkEwpA/+770iFUYE+OxL8xxS
	olPfE+ljcPUihy+PtIBWG2UeE4wlC3G5W3nCIJzlkYjAJ4iRyIxOjeSOC6CHbkllePT0IDJAP/A
	y2J59fc5+vtVcpHooMwBUxQzXj7dC6sQb7rsdYV2MrpdwkE1xyAnUxC6I3B95bEiYUWVN6O5OoQ
	VGrJTo1GjyYL/zjWTJkEDFzWZzued+AQu3k0uzYZQL3gDitDEp4XZkqvGJQySybln0Hsm6CRR47
	FlZAS/0kY6TUR
X-Received: by 2002:a05:600c:a16:b0:47b:de05:aa28 with SMTP id 5b1f17b1804b1-47d84b0aadcmr200306735e9.2.1768300892142;
        Tue, 13 Jan 2026 02:41:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyA6GIRnSDRUL9ab020nIrIsOT+mtQP2pIuI9imx0C1in3fLtYCcDSBcqt+RulymIY1xRsYA==
X-Received: by 2002:a05:600c:a16:b0:47b:de05:aa28 with SMTP id 5b1f17b1804b1-47d84b0aadcmr200306215e9.2.1768300891731;
        Tue, 13 Jan 2026 02:41:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47edfd5cfd5sm4882345e9.8.2026.01.13.02.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:41:31 -0800 (PST)
Message-ID: <0eab9112-eedf-4425-9ce9-be0a59191d8d@redhat.com>
Date: Tue, 13 Jan 2026 11:41:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 6/9] eth: bnxt: adjust the fill level of agg
 queues with larger buffers
From: Paolo Abeni <pabeni@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
 <8b6486d8a498875c4157f28171b5b0d26593c3d8.1767819709.git.asml.silence@gmail.com>
 <4db44c27-4654-46f9-be41-93bcf06302b2@redhat.com>
Content-Language: en-US
In-Reply-To: <4db44c27-4654-46f9-be41-93bcf06302b2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 11:27 AM, Paolo Abeni wrote:
> On 1/9/26 12:28 PM, Pavel Begunkov wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>>
>> The driver tries to provision more agg buffers than header buffers
>> since multiple agg segments can reuse the same header. The calculation
>> / heuristic tries to provide enough pages for 65k of data for each header
>> (or 4 frags per header if the result is too big). This calculation is
>> currently global to the adapter. If we increase the buffer sizes 8x
>> we don't want 8x the amount of memory sitting on the rings.
>> Luckily we don't have to fill the rings completely, adjust
>> the fill level dynamically in case particular queue has buffers
>> larger than the global size.
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> [pavel: rebase on top of agg_size_fac, assert agg_size_fac]
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 +++++++++++++++++++----
>>  1 file changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index 8f42885a7c86..137e348d2b9c 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -3816,16 +3816,34 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
>>  	}
>>  }
>>  
>> +static int bnxt_rx_agg_ring_fill_level(struct bnxt *bp,
>> +				       struct bnxt_rx_ring_info *rxr)
>> +{
>> +	/* User may have chosen larger than default rx_page_size,
>> +	 * we keep the ring sizes uniform and also want uniform amount
>> +	 * of bytes consumed per ring, so cap how much of the rings we fill.
>> +	 */
>> +	int fill_level = bp->rx_agg_ring_size;
>> +
>> +	if (rxr->rx_page_size > BNXT_RX_PAGE_SIZE)
>> +		fill_level /= rxr->rx_page_size / BNXT_RX_PAGE_SIZE;
> 
> According to the check in bnxt_alloc_rx_page_pool() it's theoretically
> possible for `rxr->rx_page_size / BNXT_RX_PAGE_SIZE` being zero. If so
> the above would crash.
> 
> Side note: this looks like something AI review could/should catch. The
> fact it didn't makes me think I'm missing something...

I see the next patch rejects too small `rx_page_size` values; so
possibly the better option is to drop the confusing check in
bnxt_alloc_rx_page_pool().

/P


