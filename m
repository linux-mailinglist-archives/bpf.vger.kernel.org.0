Return-Path: <bpf+bounces-40670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 520D298BECD
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 16:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29CE1F21378
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB3A1C6885;
	Tue,  1 Oct 2024 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDGFO/vj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD661C5789
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791290; cv=none; b=hWQqQb1v4WWvo9+SIY5UL2EbuJFulS45sOHY2jvypC7K+BxipTBTiNdzrdtznJYcFqJ2FHKqHYm/hTPgspW4if/wRAlktG3YnAAWt/8gIlwKGfvi8MNsb8XaKbjw0NKfTEwwaBLpDEBmjW6t2RNcr81Ta2icI+3oVGm4nBgbyTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791290; c=relaxed/simple;
	bh=ZBW3p1N7/VvV8czD2P7uNmuKZU5QpLbIJPQDxsRwsRk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T79WleMrTXdd+8rrxZoKNa1XhGh7g0Y4CIzu49rChIXq2tVMwzQrHCx4zPndV9VyONdUEvUUGQv3B5f3VNad9I78b5maK1QRPer+JbgOp2DsZmAUZKCQqM6uo9JTBWMqE+V7v4XUJvOD5xIUK6GRUJgwre8GKbrt9/JbT6RMjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDGFO/vj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a90349aa7e5so820974966b.0
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727791287; x=1728396087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JVJRVXsjeYdns3+LyBB6s8cwSLbv4Go5GfL8ogPgag=;
        b=KDGFO/vjD5AYSei8HatsFF4inU9ZQRqfaVFxmT0k6heV964t9+Zym9+UVqcH8TSZcW
         SW1QYA0pjW8oi7U83vpIEf4iHWv8qo3tSLa4Pt/jdIElhHDhq8YUUq2qH2FeSKgWIGV/
         kXAtRabA2NHGW8u7WDXAvRGw5yPRM1r6hvVPVooqSiJJoVD/JEOotZcpMXjm3QoeISdz
         v9/ime5HUpya1nSpS58DhnPSPNnMsl/o0jnxFK0sElpVq3Y+OyOYVhvM3E18JuPjcFFU
         soOd0vQkVctAup4Dv6h0oWTRvGqElfvd6Aa2ye77F8xJlw8n/tDrq23P0oxHIOSraau2
         p6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791287; x=1728396087;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JVJRVXsjeYdns3+LyBB6s8cwSLbv4Go5GfL8ogPgag=;
        b=KwEDdGg9hhGY1hXNf/Bx2O1tyJj0QX6pIhyqt8XzYTd13tOQr6L0qq+80M5/4s7jjV
         HNTQScD6O0G5yx4s2gZp6jaa/pE4Nqoo+PxnH054Akg+qVK+KhO8rstbA2V9y2T6BUIq
         9UpECn4VzUdaYInUjgrgbtLX6aSUzPJeqe2hy3hRod7D7bjKDEtkDCh+d2y2f4pepWOo
         uOjZZ2HacLGby5mSWkUZ7PNjIRq4VY3KZ59IerHnhwFsPQkK64E5y0DNdjY7jisuhQqe
         TqgY7Lh0wJGbHzhaNPID0VjMu7hFcx7EwVzmM3hglJiGqMwUVELJIl8rGybwHwibVpy0
         bKGA==
X-Gm-Message-State: AOJu0YzDCKsZjLUGFUOdlD7YmglgG4kS1yT2p49XsC3WRC6SxxalDPGd
	MyRBT2WUn+iCVzwm33HTTVcUuQYWCY6Yi0g4XfQ6Rmg+QFsf6pvgZoCNAw==
X-Google-Smtp-Source: AGHT+IFVba4OmS12CwmXam5R4xmDspCy3WD2WSLfG1Cn3Ldl+8Npk6+BmuGb0l8UIl8pX4jtDvIXaw==
X-Received: by 2002:a17:907:6ea1:b0:a86:8f8f:4761 with SMTP id a640c23a62f3a-a93c491ae88mr1438639966b.25.1727791286858;
        Tue, 01 Oct 2024 07:01:26 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bb69sm729162966b.171.2024.10.01.07.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:01:26 -0700 (PDT)
Subject: Re: NULL pointer deref inside xdp_do_flush due to
 bpf_net_ctx_get_all_used_flush_lists
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Yury Vostrikov <mon@unformed.ru>
Cc: bpf@vger.kernel.org, Martin Habets <habetsm.xilinx@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <5627f6d1-5491-4462-9d75-bc0612c26a22@app.fastmail.com>
 <20241001133603.G8j39V2l@linutronix.de>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <09947f9d-0694-fad6-661a-0b24db9aa47a@gmail.com>
Date: Tue, 1 Oct 2024 15:01:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241001133603.G8j39V2l@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 01/10/2024 14:36, Sebastian Andrzej Siewior wrote:
> diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
> index c9e17a8208a90..f3288e02c1bd8 100644
> --- a/drivers/net/ethernet/sfc/efx_channels.c
> +++ b/drivers/net/ethernet/sfc/efx_channels.c
> @@ -1260,7 +1260,8 @@ static int efx_poll(struct napi_struct *napi, int budget)
>  
>  	spent = efx_process_channel(channel, budget);
>  
> -	xdp_do_flush();
> +	if (spent)
> +		xdp_do_flush();
>  
>  	if (spent < budget) {
>  		if (efx_channel_has_rx_queue(channel) &&

Seems reasonable to me.
Another alternative is to look at budget rather than spent,
 as that seems like the condition that drives whether we
 have a real XDP.

-ed

