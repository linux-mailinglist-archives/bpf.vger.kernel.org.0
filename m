Return-Path: <bpf+bounces-79391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F4BD39C13
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C593300161F
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 01:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9961A215F5C;
	Mon, 19 Jan 2026 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTxVxdH+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABAC21FF30
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787109; cv=none; b=hKS45gbEh5JW6nJ0dFrkokIowqqradsp8RnlbtHFjqr3i5sSni6j35/6Htb1cgw0dDDb/6GcD4UxO28i8luIKrfdiq3Vn4QCdcEbbWhViJ+9pWvY0fW0/jec6PMLHnZrQsUEVOlC5hLwEfNXdqvnPoVKQJqH6sozXuviNrzylyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787109; c=relaxed/simple;
	bh=U8PNPh3IzoGoEPY4cEKOEaJDM5WYCHkHtLD8h7dHgf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy9x1PX1KgdzTD4OM0YBfRWIrl+mMs52/px1YB1MKzSLq7wQUw37yTgi8Wvw838aPA+iGBplwF7EJECTSWeTkwZ/ZBizBd3bMQh8eNErm/ya46GoeFs6T34/d2/W/zgWaHYKhPSmLqKwtTxoduJYXrR9rUOeYexLp6GQQdJASxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTxVxdH+; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ae38f81be1so4381014eec.0
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787106; x=1769391906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8EOGYST1p2LOOGAv7v8y7rda0D/LyXqaBPdKVh+hRg4=;
        b=UTxVxdH+CDXUnn9O+wfOzieMoLHEXGPhijOrPsfpGoLc1SaOba9EEKXks720Lc1z03
         00vIKX8vb3lzXaNYzDHZOa+UGV32YgUj9Gj8q3kip6PLsMsow9++ijU5bcZjbgzvZ9/C
         HAYsirzDuT3Hotclop9tZHuje+RCqtf4TQkOkNwKGAXPyid9Y8uJXumf4zGs6C3Do1xP
         +j8Z/Qcz9187N2KUM/eUM/FPVckTvuhttVuXoQFbUQky7JXOXzRyzoPontzfS8ymYmnl
         eYlVvsvrYfCdqpa0OjyVEZJYlqTTbtAXG4/oBEpWmGqcqDWqYm/wxziNtQU5lc7yejpg
         yfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787106; x=1769391906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EOGYST1p2LOOGAv7v8y7rda0D/LyXqaBPdKVh+hRg4=;
        b=E7xsWO8RLzOb/ThVo3S2W5gUfroJ+YUHXyh2Qpu/aPuMHdeQq1yIdYYd+ZJPyn/PeN
         N5iAT7CdwHwH4qBS6IbM7NXCGtw6byWKv1MjKrnJTzhSC0kRizh02ts0ptCxIT5JBE7z
         SpgLqUmufgKKDQbeoU8JKnweUGYpuEGd2OG/vyFCvM5gszYrloXLyaZvDY8idpfg6ofj
         QLLFsRk8044G4Xto9W8qj3Q8yRl09nf+pkYBGPi3vRC+WWmt0XWN+ArEJOkJJs/sLiqx
         UDQEPolrEQDyj0d5KfdeSAnpj+pB0v+vcjor/JXmIlGrvVnJXByTHVQL7sdTwYu7rh6A
         Pcdw==
X-Forwarded-Encrypted: i=1; AJvYcCUtdVAda37/WiC0tXZXWmQnmTbSb4ShIPUwLbYzkYYDvCw8FLLzy3h9G7sBSkXA2oxRKdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP77A5rZYSvrTGCrftnF70Sb4OUoYa25osQUbbDpO/lNF9nN6U
	vjaSffXRVlusdJhWTBj0tfHN1HMkAzSKKNww8RmXzbd48cGR4Y8E3bM=
X-Gm-Gg: AY/fxX70yp3wpEpKIEMX8h3ULaaexw1i0C00HE1VRyXQ7WM729N9RxHrHN+heJaaGw8
	FgKGPJLV3sVxAUGpRj+zZ4xqLpbY7Um5Ftqy+JcxSqlz3Fv+n3uMVUFtmp6nUesXodqxWObmknq
	kWDWCH9MW1khX1LZOBiV6JlRYckiKRpp7Q/zFivIh1FXkoQX/1ZjHfdTpUTbiwgXRyfYWKay2zU
	ijffgf8j6KMyLju2KcVEaToX0f+ZODysUlxn1kyyVhbZ5dpqefHIolTQLhwJqgHtAVZZfETohpB
	2B3DP3WZx1TQrEwcgs/49s+ko0qsA2MIwoDaX9ohQPBKe8nCKDgNcx5MbufvG3hqXbN2haQm920
	k4zbYpZljz7bk7L1mK1zNM1rlgaSTinSeTByNz5+ZfpfM+YvsrXdCj7gu7D0jvNAtMsZcJASe0D
	II/piMMRRT0Fbz/Zksqe2S1+8N6Srbp7eRQhFXB76U5Cazf3M86mS4FNSBGERcENzzyu18Rv1WN
	52D+d6+jm62raYj
X-Received: by 2002:a05:7301:4194:b0:2a9:97bd:a844 with SMTP id 5a478bee46e88-2b6b4e8cb91mr8200129eec.21.1768787105717;
        Sun, 18 Jan 2026 17:45:05 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm12601055eec.32.2026.01.18.17.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:45:05 -0800 (PST)
Date: Sun, 18 Jan 2026 17:45:04 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 06/16] net: Proxy netdev_queue_get_dma_dev
 for leased queues
Message-ID: <aW2MoKSFflEa3CtU@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-7-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-7-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Extend netdev_queue_get_dma_dev to return the physical device of the
> real rxq for DMA in case the queue was leased. This allows memory
> providers like io_uring zero-copy or devmem to bind to the physically
> leased rxq via virtual devices such as netkit.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

