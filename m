Return-Path: <bpf+bounces-78682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0372DD1806A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 11:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C0D3304C0C7
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 10:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC9538B7AE;
	Tue, 13 Jan 2026 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NClj29oc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l7rblCDK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172338A9A2
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300079; cv=none; b=PqbDwDXuhlLYUI0GvleTOOHIHY47Mjj8qqzS0MsEH5+zggI8A3M1/MV31lBxAYbve7G7VoNbZMTqfb55NfiJaG2oOJIooSFGjOMF9NobYQkf8UhOQ/2W67V622Tgi4Vr9eisMTeNrnRQXBq5Of0LorfmwZDL3ITSzyTH16RXwDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300079; c=relaxed/simple;
	bh=Xs40V71NSFgBl8ux07wXA+nnPiuQ97Bp4CQVChxYDDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlgCFz5aLsPEO6kIjbmEe3FArckmASex19XlCvXQAoNHmLP51LpRAQmw8HyninQKTESj1NaTQdsSKoIEYxWhQ1DXPgFEKBiO5wn2eDuW4k43kPVGeFm48ksMNqOcrsOLlnfGsqSWCvU+MTLsHpGs7Q4rvRS3c/Iv1MIeY7vKLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NClj29oc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l7rblCDK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768300075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZv6AyyuLVVLAZ1eQ6zjrtIwS0o/q5F3gCFQ/xz3D2k=;
	b=NClj29ocrXBwpERDSs1D7BvqCTEwbxSgumH3xypeSfL4Ed1Ul5PKrpFSr0Zqi1kDKw0IOq
	geC9aM/QNMyUGf+dBIEBdbl3VjYb128jEagbVYrjEoWCoIYCG3nxNymrrRWwA25LW/cSZX
	CBGoFJFSfV109z2rwkiUrHPUq/Zt2ek=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-ghXPQDNuOmCqBCeNWNsYEw-1; Tue, 13 Jan 2026 05:27:53 -0500
X-MC-Unique: ghXPQDNuOmCqBCeNWNsYEw-1
X-Mimecast-MFC-AGG-ID: ghXPQDNuOmCqBCeNWNsYEw_1768300072
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so58023055e9.3
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 02:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768300072; x=1768904872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZv6AyyuLVVLAZ1eQ6zjrtIwS0o/q5F3gCFQ/xz3D2k=;
        b=l7rblCDKgRS2I8oTRrwQ581FzINuB670SWOuseGwHOQbWyBC9dTt+/5RgCIcU/9EE3
         XD+IsZvDDq8b60X5k3xH3B7rawc5Q/fSX8JH2v/YDk1hwJUCm4BcV/Alz9PK66UotQaj
         gZcHrNG8OALEVy2ggRJTjuUOx5FIlJ49Z5OXAUSuRx8rLxpMyX1pME0x0488fM48QgJT
         CW/durgdG8PRaW+3XLBL4lQxoIRpUG8vU6Q8ZbgAITczA+8hnfDGF1d22IrrZ3E5G52Q
         KotZHPmbkOc6rxF6ydk15WebD6IDQd52YzwP3VMoCFuyMMHlmen3U5EcrQTrPMPhGLUB
         hnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300072; x=1768904872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZv6AyyuLVVLAZ1eQ6zjrtIwS0o/q5F3gCFQ/xz3D2k=;
        b=X9yEodbrf0bO1K5h2ls85Z5I1Uei2MWlFMoQQAG811NVeNok6VXBhWmMP//0RpwMvA
         EWl3xIjs3QTmclJ24xWjYfvsIq+dwXwTa4UaT4ikE/VShPxV72hgz90VW2d4x/AhPnXP
         AC3B5mZI7jNnymMv35Fza3g5pZ5zT2NvdgCVcZ7lyp2i+JtkXMxQY0GywqnGb/JxRB+d
         dBeStT0fgfPiL60uQMyWVBpgbqRHbvSyNnee6/qBSpdgIWYwPwV0lSnGV+JUdG3xeCmJ
         7GS8MEw4ipMrzwIi52zkOGFGhH1mCxi8eaA0cD8PuwhUT6QGxcxnkkABEa00b65uMFOI
         7BFw==
X-Forwarded-Encrypted: i=1; AJvYcCWUo/ON1vwzaNGK3X5qoAgaxjeMuj31wQ34+/nSCVU4+orpaX/7ujuiOLudR5YJN2DAPiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ZmKl/ZE6SJvklO0iiXbMq6HlPCBwugyI+TLuchKsbd/SqA7z
	kpog9v7w4+QULhuYNT5xsTKJT7WfbZk9ZD8ElHUvMvUyrMj6CPiLd9VIfbxPcwSRwN/E6+bbFXe
	edfc1J5AWoBQKfv+MmuSKhWj0xy8VqlowovceKn7n0xeyoo4YGqu/kA==
X-Gm-Gg: AY/fxX7wpelFEFX/Wb26jC1rtywQD7NFb9P/A0cWDRvRcPX5ILxWkIz22EjBL5KsY+X
	xfmsZdPZubgSPDL1LfaB2MguGWSLAutcp626LpRCpD1pnjx0kyd1tgq6DZDoAbQabl74LryfGGX
	HMUwlKl2cKm+ITYtAm5i3m8eOOloXOcS+yJiP1GGfJkkS1bhqtuUWGaurd7SrtfYVtQf51DRC6C
	xrOJop6MffnSCfyTn9KNrNvMNhSTQY5VHgrV8yoWmKl503jZAgvGe77gdNwhmyQrVM5dgwBJrON
	xTx5Do4/A0OsNWM5xveO6sfiu4QnW8Msymkd+TuA0Tm6oO+NKXVncPfDcJrMA/JTsub/B0vziag
	5PG9DxlJtSPXK
X-Received: by 2002:a05:600c:c10f:b0:47e:d6ee:7dd1 with SMTP id 5b1f17b1804b1-47ed6ee7dfbmr30480755e9.2.1768300071586;
        Tue, 13 Jan 2026 02:27:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBi8qAsCyoUj8yK3DWWfIteg/UVGEMMZ3DTwKr3HpHFkur4u7m4Xtrpa9L15tB9tU9SsSBiA==
X-Received: by 2002:a05:600c:c10f:b0:47e:d6ee:7dd1 with SMTP id 5b1f17b1804b1-47ed6ee7dfbmr30480125e9.2.1768300071047;
        Tue, 13 Jan 2026 02:27:51 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695956sm408197555e9.6.2026.01.13.02.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:27:50 -0800 (PST)
Message-ID: <4db44c27-4654-46f9-be41-93bcf06302b2@redhat.com>
Date: Tue, 13 Jan 2026 11:27:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 6/9] eth: bnxt: adjust the fill level of agg
 queues with larger buffers
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <8b6486d8a498875c4157f28171b5b0d26593c3d8.1767819709.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/26 12:28 PM, Pavel Begunkov wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> The driver tries to provision more agg buffers than header buffers
> since multiple agg segments can reuse the same header. The calculation
> / heuristic tries to provide enough pages for 65k of data for each header
> (or 4 frags per header if the result is too big). This calculation is
> currently global to the adapter. If we increase the buffer sizes 8x
> we don't want 8x the amount of memory sitting on the rings.
> Luckily we don't have to fill the rings completely, adjust
> the fill level dynamically in case particular queue has buffers
> larger than the global size.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [pavel: rebase on top of agg_size_fac, assert agg_size_fac]
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 +++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 8f42885a7c86..137e348d2b9c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3816,16 +3816,34 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
>  	}
>  }
>  
> +static int bnxt_rx_agg_ring_fill_level(struct bnxt *bp,
> +				       struct bnxt_rx_ring_info *rxr)
> +{
> +	/* User may have chosen larger than default rx_page_size,
> +	 * we keep the ring sizes uniform and also want uniform amount
> +	 * of bytes consumed per ring, so cap how much of the rings we fill.
> +	 */
> +	int fill_level = bp->rx_agg_ring_size;
> +
> +	if (rxr->rx_page_size > BNXT_RX_PAGE_SIZE)
> +		fill_level /= rxr->rx_page_size / BNXT_RX_PAGE_SIZE;

According to the check in bnxt_alloc_rx_page_pool() it's theoretically
possible for `rxr->rx_page_size / BNXT_RX_PAGE_SIZE` being zero. If so
the above would crash.

Side note: this looks like something AI review could/should catch. The
fact it didn't makes me think I'm missing something...

/P


