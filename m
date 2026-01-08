Return-Path: <bpf+bounces-78211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C472D020AD
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 11:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDF363139B8D
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0ED34FF65;
	Thu,  8 Jan 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBaY2P0V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j/Mpn09K"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A8A326958
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862523; cv=none; b=Eirdxn1VAF0byJ4Wy/Yz20veTQumv4nKrtOpGHAtJWuD2qp1VkFYTykrxY34iToHdhoUIEW3I2/NMXenHZoODfQDoboO5LXbyXGi0cF/Vzhc9HNncMWbQx0G9up8JacFExgCvOODynXnmJ9vvUfFXAmAJ6k5aISlvyMcEffCwJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862523; c=relaxed/simple;
	bh=bFmLVSAcLFz2S+ZEsibt6MqqAQ0+Kcz/e6Xn5wGq9BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMbyEa7gR6B3tebdZEb5txMRAYiifL8qIVo6L78Y15PawjxwM6EB/KcJMF1pJAdIiixWchUNcPniocMSzFLCC6+MR6BjZiy69SrAMpY8X5uHxC/L5tSDw2/+klx8nLzktBhvGcPHv6Z8sL8XlQAj/49nMqLU9pNJcjBjzuAmNfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBaY2P0V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j/Mpn09K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767862512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eI5c1pIYmm7x1JE+RGB61/I3xmf/iU6ZuwYMsS4kL0I=;
	b=aBaY2P0V3vYJDAElQaHSKD5qkRubewg/EpIclUiCCFHS1a28lMgjNhDaASM50DCXogK4PF
	MPzm0wMEs6yG1hd/ifcsIgFTTOaY+LDos+u3TnaKpMtYVCSsIt8VQd3ksPF4Do+i6jje7B
	uIF4TRP72SU8ZUkE58g8HdFRfZxUdFQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-bAE5OQEqMG-nXdXPNphV8w-1; Thu, 08 Jan 2026 03:55:11 -0500
X-MC-Unique: bAE5OQEqMG-nXdXPNphV8w-1
X-Mimecast-MFC-AGG-ID: bAE5OQEqMG-nXdXPNphV8w_1767862510
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so30493005e9.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 00:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767862510; x=1768467310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eI5c1pIYmm7x1JE+RGB61/I3xmf/iU6ZuwYMsS4kL0I=;
        b=j/Mpn09Ksl06ge3iPfRKBIsO/2A0A2VvAGI/K46hwkoPVn8gJgJvo6G8sbVpiCn8ZH
         i6j1dWLknVqzfcw01LQEBv3g/BBgN/UsPGJVzDSRg6tVCoENtr3BZ14sWCLm95xhiW87
         02VEErM9RMC/FVM4+3CcIdtOKrVg4bp8+wx346BGP2EAXuGvY9ze+/HYo1PRCju2ibmJ
         sjfa91fNrTBHJtcpKBqngnSVhmk5uSQhIxIHIG/AdyowXCdKA3n32ldXUsOZ+0040Fhi
         DLXx1ynwc9SmO5eX3lLWAauEo/ASSgBPwP2ugBFhMuNx1DzsRMMXUAelcDwzQNR+4z4A
         nz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767862510; x=1768467310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eI5c1pIYmm7x1JE+RGB61/I3xmf/iU6ZuwYMsS4kL0I=;
        b=LJIeb4S1J92i/tW3NbT+7YmfmRX1bipRL0zAQFFZod5mIDk3ISmqmiqTape/pXODfz
         cfvw5b/auLgzs0DBA2Sxjz3usycjQ9VySxzAUUvH5h1hDpDI3IKDbrRlpVco4GxDrBhd
         Bicnm0C7dSpMzs6cuUGlG/QkA1qkcDJkyyccZJ1B0cqGyLW4QUTuZOcxSocqR5jHypAX
         xMWSw/yzvGNErVWfa6DxO68YLsvhdHfBcMOIWv5Cu8HHQ0/yZFFkWLM5MXLOR0fAJfUh
         9BKcBR2xJApgSELR87Z+XtqwQem/zcHvcbovlaw3I27cS5NqntQqWiDTNh8UGr8CfSSi
         CoxQ==
X-Gm-Message-State: AOJu0Ywc8v3UsIlPgT5Ol92YMDSzR33tbQJ5ki5tFomtCxW+IhdWc1tU
	LjX+w2YJlKlax7lhmMxQUluZYEvKwuI2jKrh/GYPFSb1FRbSxn83Ou3jjyhPkKWnZBc7eCzSSCO
	Icq71SPNu4rVZak9X2nemrZM2rS/bQJ0QQw0RhLRH0EtY07pXyXfT+g==
X-Gm-Gg: AY/fxX4hQNcIZ92j0pElZ+GjIVjMSCvgeEduvUh/sWZj36EXc4jCA1RhEZ/AK0EMPxs
	gRXS8M3hKJDHqUNnEbLnsz+c9WesuIvZ/624Jd1Xxd3Nwzx8nmSkSZMdXxXGaA9XMqhtsiT545L
	hEGaohLU3MOo9YCVM8WgFY7eBcWv3AqNDb1wPKKCK58rTp0O3SQy/BwoMqrIyueNSPyi7Mk6Gro
	vb+hQGdBHsKAiybY+QxahxrpXpGSn6W2oeVPTmbcIimT0pPVRCClVth7hFGf+lSq7r4qz0d0nUe
	oQ9jNkXCCkOkTBOemagv99qheUIko3/fMOZbkHZsATFpcl1eJLgIkyf3mbidDjOUtLj0gL8y6NT
	XpCTyCwXApfTVrw==
X-Received: by 2002:a05:600c:348f:b0:47a:9560:5944 with SMTP id 5b1f17b1804b1-47d84b4113cmr64178045e9.34.1767862510109;
        Thu, 08 Jan 2026 00:55:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaTX6Vb9Xp6nT3BQIbPf9uYgZ4XxnPVNIfnIPI+U4WUs2U6AT0/uTauIZVS1q7u+CvwWYylQ==
X-Received: by 2002:a05:600c:348f:b0:47a:9560:5944 with SMTP id 5b1f17b1804b1-47d84b4113cmr64177785e9.34.1767862509768;
        Thu, 08 Jan 2026 00:55:09 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df90dsm14458469f8f.20.2026.01.08.00.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:55:09 -0800 (PST)
Message-ID: <9f0fffcd-8e2a-4ae1-b89d-ae73dba9e1be@redhat.com>
Date: Thu, 8 Jan 2026 09:55:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] xsk: move cq_cached_prod_lock to avoid
 touching a cacheline in sending path
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
 <20260104012125.44003-3-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260104012125.44003-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/26 2:21 AM, Jason Xing wrote:
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 6bf84316e2ad..cd5125b6af53 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -91,7 +91,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>  	INIT_LIST_HEAD(&pool->xsk_tx_list);
>  	spin_lock_init(&pool->xsk_tx_list_lock);
>  	spin_lock_init(&pool->cq_prod_lock);
> -	spin_lock_init(&pool->cq_cached_prod_lock);
> +	spin_lock_init(&xs->cq_tmp->cq_cached_prod_lock);
>  	refcount_set(&pool->users, 1);

Very minor nit: moving the init later, after:

	pool->cq = xs->cq_tmp;

would avoid touching a '_tmp' field, which looks strange.

Please do not resubmit just for this. Waiting a little longer for
Magnus, Maciej or Stanislav ack.

/P


